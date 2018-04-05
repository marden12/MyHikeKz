//
//  ListAboutViewController.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 26.03.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography

class ListAboutViewController: UIViewController {
    var news: News?
    lazy var mountainImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "mountain")
        return imgView
    }()
    lazy var logoImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "logo")
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "О походе"
        label.textColor = .myOrange
        label.font = UIFont(name: Standart.robotoFont.rawValue, size: 12)
        return label
    }()
    
    lazy var nameLable2: UILabel = {
        let lbl = UILabel()
        lbl.text = news?.name
        lbl.font = UIFont(name: Standart.robotoFont.rawValue, size: 14)
        lbl.textColor = .myGray
        return lbl
    }()
    lazy var dateLable2: UILabel = {
        let lbl = UILabel()
        lbl.text = news?.date
        lbl.font = UIFont(name: Standart.robotoFont.rawValue, size: 14)
        lbl.textColor = .myGray
        return lbl
    }()
    lazy var otherLable2: UILabel = {
        let lbl = UILabel()
        lbl.text = news?.other
        lbl.font = UIFont(name: Standart.robotoFont.rawValue, size: 14)
        lbl.textColor = .myGray
        return lbl
    }()
    lazy var phoneLable2: UILabel = {
        let lbl = UILabel()
        lbl.text = news?.telephone
        lbl.font = UIFont(name: Standart.robotoFont.rawValue, size: 14)
        lbl.textColor = .myGray
        return lbl
    }()
    lazy var placeLabel2: UILabel = {
        let lbl = UILabel()
        lbl.text = news?.place
        lbl.font = UIFont(name: Standart.robotoFont.rawValue, size: 14)
        lbl.textColor = .myGray
        return lbl
    }()
    
    lazy var nameLable: UILabel = {
        let lbl = UILabel()
        lbl.text = "Название"
        lbl.font = UIFont(name: Standart.robotoFont.rawValue, size: 14)
        lbl.textColor = .myOrange
        return lbl
    }()
    lazy var dateLable: UILabel = {
        let lbl = UILabel()
        lbl.text = "Дата"
        lbl.font = UIFont(name: Standart.robotoFont.rawValue, size: 14)
        lbl.textColor = .myOrange
        return lbl
    }()
    lazy var otherLable: UILabel = {
        let lbl = UILabel()
        lbl.text = "Дополнения"
        lbl.font = UIFont(name: Standart.robotoFont.rawValue, size: 14)
        lbl.textColor = .myOrange
        return lbl
    }()
    lazy var phoneLable: UILabel = {
        let lbl = UILabel()
        lbl.text = "Контакнтый телефон"
        lbl.font = UIFont(name: Standart.robotoFont.rawValue, size: 14)
        lbl.textColor = .myOrange
        return lbl
    }()
    lazy var placeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Место"
        lbl.font = UIFont(name: Standart.robotoFont.rawValue, size: 14)
        lbl.textColor = .myOrange
        return lbl
    }()
    lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        btn.addTarget(self, action: #selector(undo), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        [logoImageView,titleLabel,cancelButton,nameLable,dateLable,otherLable,placeLabel,phoneLable,
         nameLable2,dateLable2,otherLable2,placeLabel2,phoneLable2,mountainImageView].forEach{
            view.addSubview($0)
        }
        loadConstraints()
    }
    @objc func undo(){
        self.dismiss(animated: true, completion: nil)
    }
    func loadConstraints(){
        constrain(view,cancelButton){v,cancel in
            
            cancel.width == 24
            cancel.height == 24
            cancel.top == v.top + 10
            cancel.right == v.right - 32
            
        }
        constrain(view,logoImageView,titleLabel,nameLable,nameLable2){v,imv,t,n,nn in
            
            imv.height == 40
            imv.width == v.width/2
            imv.top == v.top + 10
            imv.centerX == v.centerX
            
            t.top == imv.bottom + 8
            t.centerX == v.centerX
            
            n.top == t.bottom + 20
            n.left == v.left + 32
            
            nn.top == t.bottom + 20
            nn.right == v.right - 32
        }
        constrain(nameLable,dateLable,otherLable,placeLabel,phoneLable){ n,d,o,p,ph in
            distribute(by: 16, vertically: n,d,o,p,ph)
            align(left: n, d,o,p,ph)
            
        }
        constrain(nameLable2,dateLable2,otherLable2,placeLabel2,phoneLable2){ n,d,o,p,ph in
            distribute(by: 16, vertically: n,d,o,p,ph)
            align(right: n, d,o,p,ph)
            
        }
        constrain(view,mountainImageView){ v,miv in
            miv.width == v.width
            miv.height == 200
            miv.bottom == v.bottom
            miv.centerX == v.centerX
        }
        
        
    }
}
