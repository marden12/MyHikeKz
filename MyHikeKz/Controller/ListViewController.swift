//
//  ListViewController.swift
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

class ListViewController: UIViewController {
    var databaseRef: DatabaseReference!{
        return Database.database().reference()
    }
    var arr = News(name: "", date: "",place: "",other: "",telephone: "")
    var comm: [News] = []
    var needArray: [News] = []
    var name = ""
    var date = ""
    var place = ""
    var other = ""
    var telephone = ""
    lazy var logoImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "logo")
        return imgView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Список походов"
        label.textColor = .myOrange
        label.font = UIFont(name: Standart.robotoFont.rawValue, size: 12)
        return label
    }()
    fileprivate lazy var listTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    fileprivate lazy var addButton:UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        btn.addTarget(self, action: #selector(goToAdding), for: .touchUpInside)
        btn.tintColor = .myGray
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(listTable)
        view.addSubview(addButton)
        fetchData()
        loadConsytaints()
    }
    func loadConsytaints(){
        constrain(view,logoImageView,titleLabel,listTable,addButton){v,imv,t,l,a in
            imv.height == 40
            imv.width == v.width/2
            imv.top == v.top + 45
            imv.centerX == v.centerX
            
            t.top == imv.bottom + 8
            t.centerX == v.centerX
            
            l.top == t.bottom + 10
            l.centerX == t.centerX
            l.width == v.width
            l.height == v.height
            
            a.width == 24
            a.height == 24
            a.left == imv.right + 16
            a.centerY == imv.centerY
        }
        
    }
    @objc func goToAdding(){
        let nv = AddNotificationViewController()
        self.present(nv, animated: true, completion: nil)
    }
    func fetchData(){
        print("fetchData")
        databaseRef.child("news/").observe(.value, with: {(snapshot) in
            if let children = snapshot.children.allObjects as? [DataSnapshot] {
                self.comm.removeAll()
                for child in children {
                    if let childElement = child.value as? [String: Any] {
                        self.name = childElement["name"] as! String
                        self.date = childElement["date"] as! String
                        self.place = childElement["place"] as! String
                        self.other = childElement["other"] as! String
                        self.telephone = childElement["telephone"] as! String
                        self.arr = News(name: self.name, date: self.date, place: self.place, other: self.other, telephone: self.telephone)
                    }
                    self.comm.append(self.arr)
                }
                self.needArray.removeAll()
                for i in self.comm{
                    self.needArray.append(i)
                }
                
            } else {
                print("parse failure ")
            }
            DispatchQueue.main.async {
                self.listTable.reloadData()
            }
        })
    }
}
extension ListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if needArray.isEmpty{
            return 0
        }else{
            return needArray.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        if needArray.isEmpty{
           self.showMessage("Загрузка...", type: .info)
        }else{
            cell.name.text = needArray[indexPath.row].name
            cell.date.text = needArray[indexPath.row].date
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     about(news: needArray[indexPath.row])
    }
    func about(news: News){
        let vc = ListAboutViewController()
        vc.news = news
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
