//
//  ViewController.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 06.12.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography


class LoginViewController: UIViewController{
    let authService = AuthenticationService()
    lazy var logoImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "logo")
        return imgView
    }()
    lazy var mountainImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "mountain")
        return imgView
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
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вход", for: .normal)
        button.setTitleColor(.myGray, for: .normal)
        button.backgroundColor = .myBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(submitAction(_:)), for: .touchUpInside)
        return button
    }()
    lazy var goToRegButton : UIButton = {
        let btn = UIButton()
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont(name: Standart.robotoFont.rawValue, size: 16)!,
            NSAttributedStringKey.foregroundColor : UIColor.myOrange,
            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
        let attributeString = NSMutableAttributedString(string: "У вас нет аккаунта?",
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        btn.setTitleColor(.myOrange, for: .normal)
        btn.addTarget(self, action: #selector(goToRegistration), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        [logoImageView,mountainImageView,loginTextField,passwordTextField,submitButton,goToRegButton].forEach({
            self.view.addSubview($0)
        })
        
        setupConstraints()
    }
    @objc func goToRegistration(){
        self.present(RegistrationViewController(), animated: true, completion: nil)
    }
    func setupConstraints(){
        constrain(view,logoImageView){v,imv in
            imv.height == 40
            imv.width == v.width/2
            imv.top == v.top + 45
            imv.centerX == v.centerX
        }
        constrain(view,mountainImageView){ v,miv in
            miv.width == v.width
            miv.height == 200
            miv.bottom == v.bottom
            miv.centerX == v.centerX
        }
        constrain(view,loginTextField,logoImageView,passwordTextField){ v,ltf,liv,ptf in
            ltf.width == v.width - 80
            ltf.height == 45
            ltf.centerX == v.centerX
            ltf.top == liv.bottom + 32
            
            ptf.width == v.width - 80
            ptf.height ==  45
            ptf.centerX == v.centerX
            ptf.top == ltf.bottom + 12
        }
        constrain(passwordTextField,submitButton){ ptf,btn in
            btn.width == ptf.width
            btn.height == 50
            btn.top == ptf.bottom + 32
            btn.centerX == ptf.centerX
            
        }
        constrain(submitButton,goToRegButton){ submit,reg in
            reg.width == submit.width
            reg.height == 50
            reg.centerX == submit.centerX
            reg.top == submit.bottom + 10
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
            authService.signIn(finalEmail, password: password, vs: self)
            
        }
        
    }
}

