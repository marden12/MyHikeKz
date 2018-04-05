//
//  RegistrationViewController.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 09.12.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
class RegistrationViewController: UIViewController {
    let authService = AuthenticationService()
    lazy var logoImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "logo")
        return imgView
    }()
    lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        btn.addTarget(self, action: #selector(undo), for: .touchUpInside)
        return btn
    }()
    lazy var loginTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "Почта"
        return tf
    }()
    lazy var passwordTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "Пороль"
        tf.isSecureTextEntry = true
        return tf
    }()
    lazy var passwordTextField2: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "Повторите пороль"
        tf.isSecureTextEntry = true
        return tf
    }()
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(.myGray, for: .normal)
        button.backgroundColor = .myBlue
        button.addTarget(self, action: #selector(submitAction(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    lazy var mountainImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "mountain")
        return imgView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        view.addSubview(logoImageView)
        view.addSubview(cancelButton)
    [logoImageView,cancelButton,loginTextField,passwordTextField,passwordTextField2,submitButton,mountainImageView].forEach({
            self.view.addSubview($0)
        })
        setupConstraints()
    }
    @objc func undo(){
        self.dismiss(animated: true, completion: nil)
    }
    func setupConstraints(){
        constrain(cancelButton,view,logoImageView){ cancel,v,imv in
            cancel.width == 24
            cancel.height == 24
            cancel.top == v.top + 64
            cancel.left == v.left + 32
            
            imv.height == 40
            imv.width == v.width/2
            imv.top == cancel.top + 32
            imv.centerX == v.centerX
            
        }
        constrain(view,loginTextField,logoImageView,passwordTextField,passwordTextField2){ v,ltf,liv,ptf,ptf2 in
            ltf.width == v.width - 80
            ltf.height == 45
            ltf.centerX == v.centerX
            ltf.top == liv.bottom + 32
            
            ptf.width == v.width - 80
            ptf.height == 45
            ptf.centerX == v.centerX
            ptf.top == ltf.bottom + 12
            
            ptf2.width == v.width - 80
            ptf2.height == 45
            ptf2.centerX == v.centerX
            ptf2.top == ptf.bottom + 12
        }
        constrain(passwordTextField2,submitButton){ ptf2,btn in
            btn.width == ptf2.width
            btn.height == 50
            btn.top == ptf2.bottom + 32
            btn.centerX == ptf2.centerX
        }
        constrain(view,mountainImageView){ v,miv in
            miv.width == v.width
            miv.height == 200
            miv.bottom == v.bottom
            miv.centerX == v.centerX
        }
        
    }

    @objc func submitAction (_:UIButton){
        let email = loginTextField.text!.lowercased()
        let finalEmail = email.trimmingCharacters(in: CharacterSet.whitespaces)
        let password = passwordTextField.text!
        
        if  password.isEmpty || finalEmail.isEmpty{
            self.view.endEditing(true)
            self.showMessage("please check your text fields", type: .info)
        } else {
            self.showMessage("Загрузка...", type: .info)
            self.view.endEditing(true)
            authService.signUp(finalEmail,password:password,vc: self)
            
        }
        
    }
}
