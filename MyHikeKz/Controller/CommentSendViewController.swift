//
//  CommentSendViewController.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 27.02.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
class CommentSendViewController: UIViewController {
    var databaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    var page_name: String = ""
    var commentsArray: [String] = []
    fileprivate lazy var title_name: UILabel = {
        let label = UILabel()
        label.text = "Оставить комментарий:"
        label.textColor = .myGray
        label.textAlignment = .left
        label.font = UIFont(name: Standart.robotoFont.rawValue, size: 18)
        return label
    }()
    fileprivate lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        btn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return btn
    }()
    fileprivate lazy var commTable: UITextView = {
        let tv = UITextView()
        tv.layer.cornerRadius = 10
        tv.layer.borderColor = UIColor.myGray.cgColor
        tv.layer.borderWidth = 1
        tv.backgroundColor = .backgroundColor
        return tv
    }()
    fileprivate lazy var sendButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .myBlue
        btn.layer.cornerRadius = 5
        btn.setTitle("Комментировать", for: .normal)
        btn.setTitleColor(.myGray, for: .normal)
        btn.titleLabel?.font = UIFont(name: Standart.robotoFont.rawValue, size: 16)
        btn.addTarget(self, action: #selector(addComment), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        view.backgroundColor = .backgroundColor
        super.viewDidLoad()
        view.addSubview(cancelButton)
        view.addSubview(title_name)
        view.addSubview(commTable)
        view.addSubview(sendButton)
        setupConstraints()
    }
    func setupConstraints(){
        constrain(cancelButton,view,title_name,commTable,sendButton){c,v,t,com,s in
            c.width == 20
            c.height == 20
            c.top == v.top + 48
            c.right == v.right - 16
            
            t.top == c.bottom + 16
            t.left == v.left + 16
            
            com.width == v.width - 32
            com.height == v.height/3.5
            com.top == t.bottom + 16
            com.centerX == v.centerX
            
            s.width == v.width - 32
            s.height == v.height/15
            s.top == com.bottom + 16
            s.centerX == v.centerX
        }

    }
    
    func getTodayString() -> String{
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        
        return today_string
    }
    
    func addToDataBase(){
        if commTable.text.isEmpty{
            self.showMessage("Нельзя оставить пустой комментарий", type: .error)
        }else{
            self.showMessage("Загрузка...", type: .info)
            let userRef = databaseRef.child("comments").child((page_name) + "/" + getTodayString())
            
            let comments = Comment(email: (Auth.auth().currentUser?.email)!, comment: commTable.text, date: getTodayString(),page: page_name)
            userRef.setValue(comments.toAnyObject())
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    @objc func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func addComment(){
        addToDataBase()
    }
}
