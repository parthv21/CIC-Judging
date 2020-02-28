//
//  ViewController.swift
//  CIC Judging
//
//  Created by Parth Tamane on 27/02/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import UIKit
import FontAwesome_swift

class LoginVC: UIViewController {

    private let phoneNumberTxtFld = UITextField()
    private let optTxtFld = UITextField()
    private let submitNumberBtn = UIButton()
    private let submitOptBtn = UIButton()
    private let backBtn = UIButton()
    
    /**
     Initial setup of LoginVC.
     */
    private func setUpView() {
        view.backgroundColor = .white
    }
    
    private func makeLoginUI() {
        //CIC Logo
        let cicLogoImgVw = UIImageView(image: UIImage(named: "cic_logo"))
        view.addSubview(cicLogoImgVw)
        cicLogoImgVw.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cicLogoImgVw.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cicLogoImgVw.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            cicLogoImgVw.widthAnchor.constraint(equalToConstant: 130),
            cicLogoImgVw.heightAnchor.constraint(equalToConstant: 130)
        ])
        //CIC Text Logo
        let cicTextImgVw = UIImageView(image: UIImage(named: "cic_text_logo"))
        view.addSubview(cicTextImgVw)
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
        view.addSubview(seperator)
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
        view.addSubview(infoLbl)
        infoLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLbl.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 20),
            infoLbl.heightAnchor.constraint(equalToConstant: 40),
            infoLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            infoLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20),
        ])
        
        //Input stack view
        let inputStckVw = UIStackView()
        inputStckVw.translatesAutoresizingMaskIntoConstraints = false
        inputStckVw.axis = .vertical
        inputStckVw.distribution = .equalSpacing
//        inputStckVw.spacing = 10
        view.addSubview(inputStckVw)
        NSLayoutConstraint.activate([
            inputStckVw.topAnchor.constraint(equalTo: infoLbl.bottomAnchor, constant: 20),
            inputStckVw.widthAnchor.constraint(equalToConstant: 255),
            inputStckVw.heightAnchor.constraint(equalToConstant: 250),
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
        NSLayoutConstraint.activate([
            phoneNumberTxtFld.heightAnchor.constraint(equalToConstant: 50)
        ])
        //OPT Field
        let optStkVw = UIStackView()
        inputStckVw.addArrangedSubview(optStkVw)
        inputStckVw.translatesAutoresizingMaskIntoConstraints = false
        optStkVw.axis = .horizontal
        optStkVw.distribution = .fill
        NSLayoutConstraint.activate([
            optStkVw.heightAnchor.constraint(equalToConstant: 50)
        ])
        //Back Button
        optStkVw.addArrangedSubview(backBtn)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        backBtn.setTitle(String.fontAwesomeIcon(name: .arrowAltCircleLeft), for: .normal)
        backBtn.setTitleColor(.black, for: .normal)
        NSLayoutConstraint.activate([
            backBtn.widthAnchor.constraint(equalToConstant: 50),
            backBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        //OPT Text Field
        optStkVw.addArrangedSubview(optTxtFld)
        optTxtFld.translatesAutoresizingMaskIntoConstraints = false
        optTxtFld.attributedPlaceholder = NSAttributedString(string: "Enter the OPT",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: placeHolderTxtClr])
        optTxtFld.clipsToBounds = true
        optTxtFld.layer.cornerRadius = 5
        optTxtFld.layer.borderWidth = 1
        optTxtFld.layer.borderColor = UIColor.black.cgColor
        optTxtFld.textAlignment = .center
        NSLayoutConstraint.activate([
            optTxtFld.heightAnchor.constraint(equalToConstant: 50)
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
        //Submit OPT
        inputStckVw.addArrangedSubview(submitOptBtn)
        submitOptBtn.translatesAutoresizingMaskIntoConstraints = false
        submitOptBtn.backgroundColor = .black
        submitOptBtn.layer.cornerRadius = 5
        submitOptBtn.clipsToBounds = true
        submitOptBtn.titleLabel?.font = UIFont(name: robotoBold, size: 16)
        submitOptBtn.titleLabel?.textAlignment = .center
        submitOptBtn.setTitle("LOGIN", for: .normal)
        submitOptBtn.setTitleColor(.white, for: .normal)
        NSLayoutConstraint.activate([
            submitNumberBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        makeLoginUI()
        // Do any additional setup after loading the view.
        
    }
}

