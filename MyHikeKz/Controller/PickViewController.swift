//
//  PickViewController.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 21.01.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
class PickViewController: UIViewController {

    var number = 1
    var num = 1
    var places = [Places]()
    var lang = ""
    let authService = AuthenticationService()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PickCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        return collectionView
    }()
    
    fileprivate lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width:self.view.frame.width/2, height:self.view.frame.width/3.25)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    fileprivate lazy var map_button: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 25
        btn.backgroundColor = .white
        btn.alpha = 0.68
        btn.setImage(#imageLiteral(resourceName: "map"), for: .normal)
        btn.addTarget(self, action: #selector(goToMap), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let button1 = UIBarButtonItem(image: UIImage(named: "exit"), style: .plain, target: self, action: #selector(exit))
        let button2 = UIBarButtonItem(image: UIImage(named: "list"), style: .plain, target: self, action: #selector(list))
        self.navigationItem.rightBarButtonItem  = button1
        self.navigationItem.leftBarButtonItem = button2
        parseJson()
        self.title = "MyHike.KZ"
        navigationController?.navigationBar.tintColor = .myGray
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(map_button)
        
        configureConstraints()
    }

    func configureConstraints(){
        constrain(view, collectionView) { v, cv in
            cv.edges == v.edges
        }
        constrain(map_button,view){ m ,v in
            m.width == 50
            m.height == 50
            m.right == v.right - 24
            m.bottom == v.bottom - 24
            
        }
    }
    
    @objc func goToMap(){
        let nv = MapViewController()
        nv.places = self.places
        navigationController?.pushViewController(nv, animated: true)
    }
    
    func parseJson(){
        do {
            if let file = Bundle.main.url(forResource: "placesRu", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let jerler = try JSONDecoder().decode([Places].self, from: data)
                self.places = jerler
        
            } else {
                print("Файл отсутствует!")
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    @objc func exit(){
        authService.logout()
    }
    @objc func list(){
        let nv = ListViewController()
        navigationController?.pushViewController(nv, animated: true)
    }
    
}

extension PickViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11 
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! PickCollectionViewCell
        cell.layer.borderColor = UIColor.white.cgColor
        cell.imageView.image = UIImage(named: places[indexPath.row].photo.first!)
        cell.title.text = places[indexPath.row].title
        cell.layer.borderWidth = 1
        cell.backgroundColor = .red
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var newSize: CGSize = CGSize(width: self.view.frame.width/2, height:self.view.frame.width/3.25)
        
        if number == 3 {
            newSize = CGSize(width: view.frame.width, height: self.view.frame.width/1.875)
            number = 1
        }
        else {
            number += 1
        }
        return newSize
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        about(place: places[indexPath.row])
    }
    func about(place: Places){
        let vc = AboutViewController()
        vc.places = place
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
