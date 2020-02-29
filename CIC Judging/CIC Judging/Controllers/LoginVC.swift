//
//  ViewController.swift
//  CIC Judging
//
//  Created by Parth Tamane on 27/02/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import UIKit
import FontAwesome_swift
import Firebase

class LoginVC: UIViewController {
    
    private let phoneNumberTxtFld = UITextField()
    private let otpTxtFld = UITextField()
    private let submitNumberBtn = UIButton()
    private let submitOtpBtn = UIButton()
    private let backBtn = UIButton()
    private let otpStkVw = UIStackView()
    private enum inputTags: Int {
        case phoneNumber = 0
        case otp = 1
    }
    private lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+5)
    private lazy var scrollView : UIScrollView = {
        let view = UIScrollView(frame : .zero)
        view.frame = self.view.bounds
        view.contentInsetAdjustmentBehavior = .never
        view.contentSize = contentViewSize
        view.backgroundColor = .white
        return view
    }()
    
    /**
     Initial setup of LoginVC.
     */
    private func setUpView() {
        view.backgroundColor = .white
        self.view.addSubview(scrollView)
        registerForKeyboardNotifications()
        let scrollViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOnTap))
        scrollViewTapGestureRecognizer.numberOfTapsRequired = 1
        scrollViewTapGestureRecognizer.isEnabled = true
        scrollViewTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(scrollViewTapGestureRecognizer)
    }
    
    private func makeLoginUI() {
        //CIC Logo
        let cicLogoImgVw = UIImageView(image: UIImage(named: "cic_logo"))
        scrollView.addSubview(cicLogoImgVw)
        cicLogoImgVw.translatesAutoresizingMaskIntoConstraints = false
        let window = UIApplication.shared.keyWindow
        let topPadding = window?.safeAreaInsets.top ?? 50
        NSLayoutConstraint.activate([
            cicLogoImgVw.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: topPadding + 20),
            cicLogoImgVw.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            cicLogoImgVw.widthAnchor.constraint(equalToConstant: 130),
            cicLogoImgVw.heightAnchor.constraint(equalToConstant: 130)
        ])
        //CIC Text Logo
        let cicTextImgVw = UIImageView(image: UIImage(named: "cic_text_logo"))
        scrollView.addSubview(cicTextImgVw)
        cicTextImgVw.translatesAutoresizingMaskIntoConstraints = false
        cicTextImgVw.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            cicTextImgVw.topAnchor.constraint(equalTo: cicLogoImgVw.bottomAnchor, constant: 10),
            cicTextImgVw.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            cicTextImgVw.widthAnchor.constraint(equalToConstant: 260),
            cicTextImgVw.heightAnchor.constraint(equalToConstant: 45)
        ])
        //Seperator
        let seperator = UIView()
        scrollView.addSubview(seperator)
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = .black
        NSLayoutConstraint.activate([
            seperator.topAnchor.constraint(equalTo: cicTextImgVw.bottomAnchor, constant: 10),
            seperator.heightAnchor.constraint(equalToConstant: 2),
            seperator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            seperator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        //Info label
        let infoLbl = UILabel()
        infoLbl.text = "Login with phone"
        infoLbl.textAlignment = .center
        scrollView.addSubview(infoLbl)
        infoLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLbl.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 20),
            infoLbl.heightAnchor.constraint(equalToConstant: 40),
            infoLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            infoLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20),
        ])
        
        //Input stack view
        let inputStckVw = UIStackView()
        inputStckVw.layer.borderColor = UIColor.black.cgColor
        inputStckVw.layer.borderWidth = 1
        inputStckVw.translatesAutoresizingMaskIntoConstraints = false
        inputStckVw.axis = .vertical
        inputStckVw.distribution = .equalSpacing
        inputStckVw.spacing = 10
        scrollView.addSubview(inputStckVw)
        NSLayoutConstraint.activate([
            inputStckVw.topAnchor.constraint(equalTo: infoLbl.bottomAnchor, constant: 20),
            inputStckVw.widthAnchor.constraint(equalToConstant: 255),
            //            inputStckVw.heightAnchor.constraint(equalToConstant: 110),
            inputStckVw.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        //Number field
        inputStckVw.addArrangedSubview(phoneNumberTxtFld)
        phoneNumberTxtFld.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTxtFld.attributedPlaceholder = NSAttributedString(string: "Enter your phone number",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: placeHolderTxtClr])
        phoneNumberTxtFld.clipsToBounds = true
        phoneNumberTxtFld.layer.cornerRadius = 5
        phoneNumberTxtFld.layer.borderWidth = 1
        phoneNumberTxtFld.layer.borderColor = UIColor.black.cgColor
        phoneNumberTxtFld.textAlignment = .center
        phoneNumberTxtFld.keyboardType = .phonePad
        phoneNumberTxtFld.tag = inputTags.phoneNumber.rawValue
        
        NSLayoutConstraint.activate([
            phoneNumberTxtFld.heightAnchor.constraint(equalToConstant: 50)
        ])
        //otp Field
        otpStkVw.isHidden = true
        inputStckVw.addArrangedSubview(otpStkVw)
        inputStckVw.translatesAutoresizingMaskIntoConstraints = false
        otpStkVw.axis = .horizontal
        otpStkVw.distribution = .fill
        NSLayoutConstraint.activate([
            otpStkVw.heightAnchor.constraint(equalToConstant: 50)
        ])
        //Back Button
        otpStkVw.addArrangedSubview(backBtn)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        backBtn.setTitle(String.fontAwesomeIcon(name: .arrowAltCircleLeft), for: .normal)
        backBtn.setTitleColor(.black, for: .normal)
        NSLayoutConstraint.activate([
            backBtn.widthAnchor.constraint(equalToConstant: 50),
            backBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        backBtn.addTarget(self, action: #selector(hideOtp), for: .touchUpInside)
        //otp Text Field
        otpStkVw.addArrangedSubview(otpTxtFld)
        otpTxtFld.translatesAutoresizingMaskIntoConstraints = false
        otpTxtFld.attributedPlaceholder = NSAttributedString(string: "Enter the OTP",
                                                             attributes: [NSAttributedString.Key.foregroundColor: placeHolderTxtClr])
        otpTxtFld.clipsToBounds = true
        otpTxtFld.layer.cornerRadius = 5
        otpTxtFld.layer.borderWidth = 1
        otpTxtFld.layer.borderColor = UIColor.black.cgColor
        otpTxtFld.textAlignment = .center
        otpTxtFld.tag = inputTags.otp.rawValue
        NSLayoutConstraint.activate([
            otpTxtFld.heightAnchor.constraint(equalToConstant: 50)
        ])
        //Submit Number
        inputStckVw.addArrangedSubview(submitNumberBtn)
        submitNumberBtn.translatesAutoresizingMaskIntoConstraints = false
        submitNumberBtn.backgroundColor = .black
        submitNumberBtn.layer.cornerRadius = 5
        submitNumberBtn.clipsToBounds = true
        submitNumberBtn.titleLabel?.font = UIFont(name: robotoBold, size: 16)
        submitNumberBtn.titleLabel?.textAlignment = .center
        submitNumberBtn.setTitle("SUBMIT", for: .normal)
        submitNumberBtn.setTitleColor(.white, for: .normal)
        NSLayoutConstraint.activate([
            submitNumberBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
        submitNumberBtn.addTarget(self, action: #selector(submitNumber), for: .touchUpInside)
        //Submit otp
        submitOtpBtn.isHidden = true
        inputStckVw.addArrangedSubview(submitOtpBtn)
        submitOtpBtn.translatesAutoresizingMaskIntoConstraints = false
        submitOtpBtn.backgroundColor = .black
        submitOtpBtn.layer.cornerRadius = 5
        submitOtpBtn.clipsToBounds = true
        submitOtpBtn.titleLabel?.font = UIFont(name: robotoBold, size: 16)
        submitOtpBtn.titleLabel?.textAlignment = .center
        submitOtpBtn.setTitle("LOGIN", for: .normal)
        submitOtpBtn.setTitleColor(.white, for: .normal)
        NSLayoutConstraint.activate([
            submitOtpBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
        submitOtpBtn.addTarget(self, action: #selector(submitOtp), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        makeLoginUI()
        // Do any additional setup after loading the view.
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    func showOtpInput() {
        otpTxtFld.becomeFirstResponder()
        phoneNumberTxtFld.isHidden = true
        submitNumberBtn.isHidden = true
        submitOtpBtn.isHidden = false
        otpStkVw.isHidden = false
    }
    
    func showPhoneNumberInput() {
        phoneNumberTxtFld.becomeFirstResponder()
        phoneNumberTxtFld.isHidden = false
        submitNumberBtn.isHidden = false
        submitOtpBtn.isHidden = true
        otpStkVw.isHidden = true
    }
    
    func _submitNumber() {
        
        //Valid Number?
        var phoneNumber = phoneNumberTxtFld.text ?? ""
        let isValid = validatePhoneNumber(phoneNumber)
        
        if !isValid {
            let invalidInputAlrt = makeAlert(title: "Invalid Input", message: "Please check the phone number you entered for errors.")
            self.present(invalidInputAlrt, animated: true, completion:nil)
        } else {
            
            checkIfUserRegistred(phoneNumber: String(phoneNumber.suffix(10))) { registred in
                if !registred {
                    let missedRegistrationAlrt = makeAlert(title: "Not Registered", message: "Please go to the front desk and register yourself before trying to login.")
                    self.present(missedRegistrationAlrt, animated: true, completion:nil)
                } else {
                    if phoneNumber.count == 10 {
                        phoneNumber = "+1\(phoneNumber)"
                    }
                    PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                        if let error = error {
                            let authErrorAlrt = makeAlert(title: "Authentication Error", message: error.localizedDescription)
                            self.present(authErrorAlrt, animated: true, completion: nil)
                            return
                        } else {
                            UserDefaults.standard.set(verificationID, forKey: authVerificationID)
                            self.showOtpInput()
                        }
                    }
                }
            }
        }
    }
    
    @objc func submitNumber(sender: UIButton!) {
        //Logic to check for key
        _submitNumber()
    }
    
    func _submitOtp() {
        let verificationID = UserDefaults.standard.string(forKey: authVerificationID) ?? ""
        let verificationCode = otpTxtFld.text ?? ""
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                let loginErrorAlrt = makeAlert(title: "Login Error", message: error.localizedDescription)
                self.present(loginErrorAlrt, animated: true, completion: nil)
                return
            }
            let teamListVC = TeamListVC()
            teamListVC.modalPresentationStyle = .fullScreen
            self.present(teamListVC, animated: true, completion: nil)
        }
    }
    
    @objc func submitOtp(sender: UIButton!) {
        _submitOtp()
    }
    
    @objc func hideOtp(sender: UIButton!) {
        showPhoneNumberInput()
    }
}

//MARK:- Extension to handle text field
extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        switch textField.tag {
        case inputTags.phoneNumber.rawValue:
            _submitNumber()
        case inputTags.otp.rawValue:
            _submitOtp()
        default:
            break
        }
        
        return true
    }
}

//MARK:- Handling text fields hidden by keyboard
extension LoginVC {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardAppear(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDisappear(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func onKeyboardAppear(_ notification: NSNotification) {
        let info = notification.userInfo!
        let rect: CGRect = info[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
        let kbSize = rect.size
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
        
        var aRect = self.view.frame;
        aRect.size.height -= kbSize.height;
        
        let activeField: UITextField? = [phoneNumberTxtFld, otpTxtFld].first { $0.isFirstResponder }
        if let activeField = activeField {
            if !aRect.contains(activeField.frame.origin) {
                let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y-kbSize.height)
                scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }
    
    @objc func onKeyboardDisappear(_ notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc func dismissKeyboardOnTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
