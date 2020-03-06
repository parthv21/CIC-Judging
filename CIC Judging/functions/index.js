const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const compare = (team1, team2) => {
  const scores1 = "scores" in team1 ? team1.scores : [];
  const scores2 = "scores" in team2 ? team2.scores : [];

  if (scores1.length > scores2.length) {
    return 1;
  } else if (scores1.length < scores2.length) {
    return -1;
  }
  return 0;
};

const processAssignedQueue = (snapshot, judgeId) => {
  if (snapshot.val() !== null) {
    console.log(snapshot.val());
    const root = snapshot.val();
    var judge = root.judges[judgeId];
    var teams = root.teams;
    var judgingQueue = "judgingQueue" in root ? root.judgingQueue : {};

    var assignedTeams =
      "judgeAssigned" in judgingQueue ? judgingQueue.judgeAssigned : {};

    var judgeAssignedTeams =
      judgeId in judgingQueue ? judgingQueue[judgeId] : [];

    var filteredTeams = [];
    var preferredTeams = [];
    for (const teamID in teams) {
      const team = teams[teamID];
      const isPreferredTeam =
        judge.affinityGroup === "None"
          ? true
          : team.affinityGroup === judge.affinityGroup;
      const team_scores = "scores" in team ? team.scores : {};
      const isScored = judgeId in team_scores;

      if (isPreferredTeam && !isScored) {
        preferredTeams.push(teams[teamID]);
      }
      console.log(teamID, assignedTeams, isPreferredTeam, isScored);
      if (!(teamID in assignedTeams) && isPreferredTeam && !isScored) {
        filteredTeams.push(teams[teamID]);
      }
    }

    filteredTeams.sort(compare);
    preferredTeams.sort(compare);

    const teamsToAdd = 3 - judgeAssignedTeams.length;
    var teamsAdded = 0;

    var i = 0;
    console.log("Filtered teams: \n", filteredTeams);
    while (i < filteredTeams.length && teamsAdded < teamsToAdd) {
      const currTeamId = filteredTeams[i].teamId;
      if (!judgeAssignedTeams.includes(currTeamId)) {
        judgeAssignedTeams.push(currTeamId);
        assignedTeams[currTeamId] = judgeId;
        i++;
        teamsAdded++;
      }
    }
    i = 0;
    while (i < preferredTeams.length && teamsAdded < teamsToAdd) {
      const currTeamId = preferredTeams[i].teamId;
      if (!judgeAssignedTeams.includes(currTeamId)) {
        judgeAssignedTeams.push(currTeamId);
        assignedTeams[currTeamId] = judgeId;
        i++;
        teamsAdded++;
      }
    }

    judgingQueue[judgeId] = judgeAssignedTeams;
    judgingQueue.judgeAssigned = assignedTeams;

    var judgingQueueRef = admin.database().ref("judgingQueue");
    judgingQueueRef.set(judgingQueue);
    console.log("SET: ", judgingQueue);
    return { teams: judgeAssignedTeams };
  } else {
    console.log("Root is empty");
    return { teams: [] };
  }
};

const displayError = errorObject => {
  console.log("The read failed: " + errorObject.code);
  return { teams: [] };
};

exports.assignTeams = functions.https.onCall((data, context) => {
  console.log("Running!");
  const judgeId = data.judgeId;
  var db = admin.database();
  var rootRef = db.ref("/");
  rootRef.once(
    "value",
    function(snapshot) {
      console.log(snapshot.val());
      processAssignedQueue(snapshot, judgeId);
    },
    function(errorObject) {
      displayError(errorObject);
    }
  );
});
