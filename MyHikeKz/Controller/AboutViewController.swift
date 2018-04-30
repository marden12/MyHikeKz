//
//  AboutViewController.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 24.01.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
import PureLayout
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class AboutViewController: UIViewController {
    var databaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    let screen = UIScreen.main.bounds
    var comment = ""
    var date = ""
    var email = ""
    var page = ""
    var arr = Comment(email: "", comment: "", date: "")
    var comm: [Comment] = []
    var needArray: [Comment] = []
    var places: Places?
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: self.screen.width, height: 2*self.screen.height)
        scrollView.backgroundColor = .backgroundColor
        return scrollView
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AboutCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    fileprivate lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        var width = (self.view.frame.size.width - 64) //some width
        var height = self.view.frame.size.height/3 //ratio
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    fileprivate lazy var name_title: UILabel = {
        let label = UILabel()
        label.text = places?.title
        label.font = UIFont(name: Standart.regularFont.rawValue, size: 28)
        label.textColor = .myDarkGray
        return label
    }()

    fileprivate lazy var loc_title: UILabel = {
        let label = UILabel()
        label.text = places?.location_text
        label.font = UIFont(name: Standart.regularFont.rawValue, size: 16)
        label.textColor = .myOrange
        label.numberOfLines = 6
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    fileprivate lazy var desc_title: UILabel = {
        let label = UILabel()
        label.text = places?.desc
        label.font = UIFont(name: Standart.lightFont.rawValue, size: 18)
        label.numberOfLines = 100
        label.textColor = .myDarkGray
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var line: UIView = {
        let v = UIView()
        v.backgroundColor = .myOrange
        return v
    }()

    fileprivate lazy var commentButton: CustomButtonWithImage = {
        let btn = CustomButtonWithImage()
        btn.commImg.image = #imageLiteral(resourceName: "com")
        btn.addTarget(self, action: #selector(gotocom), for: .touchUpInside)
        btn.setTitle("Оставить комментарий", for: .normal)
        
        return btn
    }()
    fileprivate lazy var comentsTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90
        tableView.register(CommentsTableViewCell.self, forCellReuseIdentifier: "c")
        return tableView
    }()
    override func viewDidLoad() {
        view.backgroundColor = .backgroundColor
        view.addSubview(scrollView)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(name_title)
        scrollView.addSubview(desc_title)
        scrollView.addSubview(loc_title)
        scrollView.addSubview(line)
        scrollView.addSubview(commentButton)
        scrollView.addSubview(comentsTable)
        loadConstraints()
        comentsTable.reloadData()
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var lastHeight = 100
        [collectionView,name_title,loc_title,desc_title,commentButton,comentsTable].forEach{
            lastHeight += Int($0.sizeThatFits($0.bounds.size).height)
        }
        scrollView.contentSize = CGSize(width: self.screen.width , height: CGFloat(lastHeight))
    }
    func loadConstraints(){
        constrain(scrollView,view){sv,v in
            sv.edges == v.edges
        }
        
        constrain(collectionView,scrollView){cv,sv in
            cv.width == sv.width - 32
            cv.height == sv.height/3
            cv.top == sv.top + 16
            cv.centerX == sv.centerX
        }
        
        constrain(collectionView,name_title,view,loc_title,desc_title){ cv, name, v, l,d in
            name.centerX == v.centerX
            name.top == cv.bottom + 16
        }
        
        constrain(view,loc_title,name_title,desc_title){v, lt, n, d in
            
            lt.top == n.bottom + 8
            lt.width == v.width - 48
            lt.centerX == v.centerX
            
            d.top == lt.bottom + 16
            d.centerX == lt.centerX
            d.width == v.width - 48
        }
        
        constrain(line,view,desc_title,commentButton,comentsTable){l,v,d,c,t in
            l.height == d.height
            l.width == 1
            l.right == d.left - 5
            l.centerY == d.centerY
            
            c.width == v.width/1.7
            c.height == 30
            c.top == l.bottom + 16
            c.left == l.left
            
            t.width == v.width
            t.height == v.height
            t.top == c.bottom + 16
            t.centerX == v.centerX
            
            
        }
        
    }
    @objc func gotocom(){
        let nv = CommentSendViewController()
        nv.page_name = name_title.text!
        self.present(nv, animated: true, completion: nil)
    }
    func fetchData(){
        print("fetchData")
        databaseRef.child("comments/").child(name_title.text!).observe(.value, with: {(snapshot) in
            
            if let children = snapshot.children.allObjects as? [DataSnapshot] {
                print(children)
                self.comm.removeAll()
                for child in children {
                    if let childElement = child.value as? [String: Any] {
                        self.comment = childElement["comment"]! as! String
                        self.date = childElement["date"]! as! String
                        self.email = childElement["email"]! as! String
                        self.page = childElement["page"]! as! String
                        self.arr = Comment(email: self.email, comment: self.comment, date: self.date, page: self.page)
                    }
                    self.comm.append(self.arr)


                }
                self.needArray.removeAll()
                for i in self.comm{
                    let need = self.name_title.text

                    if i.page == need{
                        self.needArray.append(i)
                    }
                }
                print(self.needArray)

            } else {
                print("parse failure ")
            }
            DispatchQueue.main.async {
                self.comentsTable.reloadData()
            }
        })
    }
    
}
extension AboutViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AboutCollectionViewCell
        cell.imageV.image = UIImage(named: (places?.photo[indexPath.row])!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: false)
    }
}
//MARK:: List of Stocks, Table View
extension AboutViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if needArray.isEmpty{
            return 0
        }else{
            return needArray.count
        }
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "c", for: indexPath) as! CommentsTableViewCell
        if needArray.isEmpty{
            print("Emty")
        }else{
            cell.user_name.text = needArray[indexPath.row].email
            cell.current_time.text = needArray[indexPath.row].date
            cell.comment_text.text = needArray[indexPath.row].comment
        }
        return cell
    }
    
}
