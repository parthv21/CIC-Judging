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
  console.log("Assigning teams", judgeId);
  if (snapshot.val() !== null) {
    const root = snapshot.val();
    var judge = root.judges[judgeId];
    var teams = root.teams;
    var judgingQueue = "judgingQueue" in root ? root.judgingQueue : {};
    var assignedTeams =
      "judgeAssigned" in judgingQueue ? judgingQueue.judgeAssigned : {};
    var judgeAssignedTeams =
      judgeId in judgingQueue ? judgingQueue[judgeId] : [];
    const all_scores = "scores" in root ? root.scores : {};

    var filteredTeams = [];
    var preferredTeams = [];

    for (const teamID in teams) {
      const team = teams[teamID];
      const isPreferredTeam =
        judge.affinityGroup === "None"
          ? true
          : team.affinityGroup === judge.affinityGroup;

      const team_scores = teamID in all_scores ? all_scores[teamID] : {};
      const isScored = judgeId in team_scores;

      if (isPreferredTeam && !isScored) {
        preferredTeams.push(teams[teamID]);
      }
      if (!(teamID in assignedTeams) && isPreferredTeam && !isScored) {
        filteredTeams.push(teams[teamID]);
      }
    }

    filteredTeams.sort(compare);
    preferredTeams.sort(compare);
    // console.log("Filtered Teams ", filteredTeams);
    // console.log("Preferred Teams: ", preferredTeams);
    // console.log("Old Assigned Teams: ", judgeAssignedTeams);

    const teamsToAdd = 3 - judgeAssignedTeams.length;
    var teamsAdded = 0;
    // // console.log("Will add", teamsAdded, "new teams");
    var i = 0;
    while (i < filteredTeams.length && teamsAdded < teamsToAdd) {
      const currTeamId = filteredTeams[i].teamId;
      // // console.log("Finding team in filtered", currTeamId);
      if (
        !judgeAssignedTeams.includes(currTeamId) &&
        currTeamId !== undefined
      ) {
        // // console.log("Assigning team", currTeamId);
        judgeAssignedTeams.push(currTeamId);
        assignedTeams[currTeamId] = judgeId;
        i++;
        teamsAdded++;
      }
    }
    i = 0;
    while (i < preferredTeams.length && teamsAdded < teamsToAdd) {
      const currTeamId = preferredTeams[i].teamId;
      // // console.log("Finding team in preferred", currTeamId);
      if (
        !judgeAssignedTeams.includes(currTeamId) &&
        currTeamId !== undefined
      ) {
        // // console.log("Assigning team", currTeamId);
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
    // console.log("ASSIGNED '", judgeId, "' TEAMS: ", judgingQueue);
    return { teams: judgeAssignedTeams };
  } else {
    // console.log("Root is empty");
    return { teams: [] };
  }
};

const reassignTeam = judgeId => {
  console.log("Reassigning team");
  var db = admin.database();
  var rootRef = db.ref("/");
  rootRef
    .once("value", snapshot => {
      return processAssignedQueue(snapshot, judgeId);
    })
    .catch(function(error) {
      console.log("Assigning new team after removing old team failed", error);
      return { teams: [] };
    });
};

const filterAssignedQueue = (snapshot, judgeId, teamId) => {
  if (snapshot.val() === null) {
    return { teams: [] };
  }
  const root = snapshot.val();
  var judgingQueue = "judgingQueue" in root ? root.judgingQueue : {};
  var assignedTeams =
    "judgeAssigned" in judgingQueue ? judgingQueue.judgeAssigned : {};
  var judgeAssignedTeams = judgeId in judgingQueue ? judgingQueue[judgeId] : [];
  delete assignedTeams[teamId];
  judgeAssignedTeams = judgeAssignedTeams.filter(
    filterTeamId => filterTeamId !== teamId
  );
  judgingQueue[judgeId] = judgeAssignedTeams;
  judgingQueue.judgeAssigned = assignedTeams;
  // console.log(judgingQueue);
  var judgingQueueRef = admin.database().ref("judgingQueue");
  judgingQueueRef
    .set(judgingQueue)
    .then(function() {
      console.log("Setting new team");
      return reassignTeam(judgeId);
    })
    .catch(function(error) {
      return { teams: [] };
      // console.log("Removing Team ID failed:", error);
    });
  // console.log("Removed teamId ", teamId, "from judgeId ", judgeId, " queue.");
};

const displayError = errorObject => {
  // console.log("The read failed: " + errorObject.code);
  return { teams: [] };
};

exports.assignTeams = functions.https.onCall((data, context) => {
  const judgeId = data.judgeId;
  var db = admin.database();
  var rootRef = db.ref("/");
  rootRef.once(
    "value",
    function(snapshot) {
      processAssignedQueue(snapshot, judgeId);
    },
    function(errorObject) {
      displayError(errorObject);
    }
  );
});

exports.removeAssignedTeam = functions.https.onCall((data, context) => {
  const judgeId = data.judgeId;
  const teamId = data.teamId;
  var db = admin.database();
  var rootRef = db.ref("/");
  rootRef.once(
    "value",
    function(snapshot) {
      filterAssignedQueue(snapshot, judgeId, teamId);
    },
    function(errorObject) {
      displayError(errorObject);
    }
  );
});
