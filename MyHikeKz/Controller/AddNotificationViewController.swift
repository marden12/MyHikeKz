//
//  AddNotificationViewController.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 25.03.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import DateTimePicker
class AddNotificationViewController: UIViewController {
    var databaseRef: DatabaseReference!{
        return Database.database().reference()
    }
    lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        btn.addTarget(self, action: #selector(undo), for: .touchUpInside)
        return btn
    }()
    let screen = UIScreen.main.bounds
    lazy var logoImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "logo")
        return imgView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Подача обьявления"
        label.textColor = .myOrange
        label.font = UIFont(name: Standart.robotoFont.rawValue, size: 12)
        return label
    }()
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.contentSize = CGSize(width: self.screen.width, height: 2*self.screen.height)
        scrollView.backgroundColor = .backgroundColor
        return scrollView
    }()
    lazy var name: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "Название"
        return tf
    }()
    lazy var date: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "Дата"
        tf.keyboardDistanceFromTextField = 100000
        tf.addTarget(self, action: #selector(textFieldShouldBeginEditing(textField:)), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(textFieldShouldReturn(textField:)), for: .editingDidBegin)
        return tf
    }()

    lazy var place: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "Место сбора"
        return tf
    }()
    lazy var other: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "Дополнения"
        return tf
    }()
    lazy var telephone: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "Контактный телефон"
        tf.keyboardType = .numberPad
        return tf
    }()
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.myGray, for: .normal)
        button.backgroundColor = .myBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        
        button.titleLabel?.font = UIFont(name: Standart.robotoFont.rawValue, size: 16)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor
        [scrollView,logoImageView,titleLabel,name,date,place,other,telephone,submitButton,cancelButton].forEach{
            view.addSubview($0)
        }
        loadConstraints()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var lastHeight = 100
        [logoImageView,titleLabel,name,date,place,other,telephone,submitButton,cancelButton].forEach{
            lastHeight += Int($0.sizeThatFits($0.bounds.size).height)
        }
        scrollView.contentSize = CGSize(width: self.screen.width , height: CGFloat(lastHeight))
    }
    @objc func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        let picker = DateTimePicker.show()
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.isDatePickerOnly = false // to hide time and show only date picker
        picker.completionHandler = { date in
            self.date.text = picker.selectedDateString
            
        }
        return true
    }
    @objc func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc func submitAction(){
        if (name.text?.isEmpty)! || (date.text?.isEmpty)! || (place.text?.isEmpty)! || (other.text?.isEmpty)! || (telephone.text?.isEmpty)! {
            self.showMessage("Заполните все поля", type: .error)
        }else{
            self.showMessage("Загрузка...", type: .info)
            let userRef = databaseRef.child("news").childByAutoId()
            let comments = News(name: name.text!, date: date.text!, place: place.text!, other: other.text!, telephone: telephone.text!)
            userRef.setValue(comments.toAnyObject())
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc func undo(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadConstraints(){
        constrain(scrollView,view,cancelButton){sv,v,cancel in
            sv.edges == v.edges
            
            cancel.width == 24
            cancel.height == 24
            cancel.top == v.top + 64
            cancel.right == v.right - 32
            
        }
        constrain(view,logoImageView,titleLabel,name){v,imv,t,n in
            imv.height == 40
            imv.width == v.width/2
            imv.top == v.top + 80
            imv.centerX == v.centerX
            
            t.top == imv.bottom + 8
            t.centerX == v.centerX
            
            n.width == v.width - 80
            n.height == 45
        }
        constrain(titleLabel,name,date,place) { view1, view2,view3,view4 in
            distribute(by: 16, vertically: view1, view2,view3,view4)
            align(centerX: view1, view2,view3,view4)
            view3.width == view2.width
            [view3,view4].forEach{
                $0.width == view2.width
                $0.height == view2.height
            }
   
        }
        constrain(place,other,telephone,submitButton) { view1, view2,view3,view4 in
            distribute(by: 16, vertically: view1, view2,view3)
            align(centerX: view1, view2,view3,view4)
            view4.top == view3.bottom + 20
            [view2,view3,view4].forEach{
                $0.width == view1.width
                $0.height == view1.height
                
            }
        }
        
    }

}
