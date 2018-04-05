//
//  MapViewController.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 13.03.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Cartography
import Alamofire
import SwiftyJSON

class MapViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var mapView = GMSMapView()
    var places = [Places]()
    var place: Places?
    var currentPlace: Places?
    var des: ConstraintGroup?
    var dess: ConstraintGroup?
    var opened = false
    var start = CLLocation()
    var end = CLLocation()
    
    fileprivate lazy var descriptionView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.borderColor = UIColor.myGray.cgColor
        v.layer.borderWidth = 1
        v.layer.cornerRadius = 10
        v.alpha = 0.85
        return v
    }()
    fileprivate lazy var nameD: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.robotoFont.rawValue, size: 18)
        label.textColor = .myGray
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    fileprivate lazy var loc: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.robotoFont.rawValue, size: 14)
        label.textColor = .myGray
        label.textAlignment = .center
        label.numberOfLines = 5
        label.numberOfLines = 5
        return label
    }()
    
    fileprivate lazy var directionButton: UIButton = {
        let btn = UIButton()
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.myGray.cgColor
        btn.setTitle("Проложить маршрут", for: .normal)
        btn.titleLabel?.font = UIFont(name: Standart.robotoFont.rawValue, size: 11)
        btn.setTitleColor(.myGray, for: .normal)
        btn.addTarget(self, action: #selector(showPath), for: .touchUpInside)
        return btn
    }()
    fileprivate lazy var aboutButton: UIButton = {
        let btn = UIButton()
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.myGray.cgColor
        btn.backgroundColor = .myBlue
        btn.addTarget(self, action: #selector(showInf), for: .touchUpInside)
        btn.setTitle("Подробнее", for: .normal)
        btn.titleLabel?.font = UIFont(name: Standart.robotoFont.rawValue, size: 11)
        btn.setTitleColor(.myGray, for: .normal)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        [descriptionView,nameD,loc,directionButton,aboutButton].forEach({
            self.view.addSubview($0)
        })
        hideDes()
        view.backgroundColor = .white
        
    }
    //load map settings
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 43.222015, longitude: 76.851248, zoom: 6)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
        mapView.accessibilityElementsHidden = false
        mapView.isMyLocationEnabled = true
        mapView.isUserInteractionEnabled = true
        mapView.delegate = self
        
        
        for i in 0...places.count-1{
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: places[i].lat, longitude: places[i].long)
            marker.title = places[i].title
            marker.snippet = places[i].location_text
            marker.map = mapView
            marker.icon = UIImage(named: "goal")
            
        }
        
    }
   
    func userLocation(){
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        start = (locationManager.location)!
        print(start)
    }
    func drawPath(startLocation: CLLocation, endLocation: CLLocation){
        userLocation()
        mapView.reloadInputViews()
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        print("HERE\(origin,destination)")
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        Alamofire.request(url).responseJSON { response in
            do {
                let json = try JSON(data: response.data!)
                let routes = json["routes"].arrayValue
                
                // print route using Polyline
                for route in routes{
                    
                    let routeOverviewPolyline = route["overview_polyline"].dictionary
                    let points = routeOverviewPolyline?["points"]?.stringValue
                    let path = GMSPath.init(fromEncodedPath: points!)
                    let polyline = GMSPolyline.init(path: path)
                    
                    polyline.strokeWidth = 5
                    polyline.strokeColor = .myBlue
                    polyline.map = self.mapView
                }
            }
            catch {
                print("DASAAAa\(response.error!)")
            }
        }
    }
    
    @objc func showInf(){
        let nv = AboutViewController()
        nv.places = currentPlace
        self.navigationController?.pushViewController(nv, animated: true)
    }
    
    @objc func showPath(){
        drawPath(startLocation: start, endLocation: end)
        constrain(clear: des!)
        constrain(clear: dess!)
        view.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.hideDes()
            
        })
    }
  
    
    
    func hideDes(){
        des = constrain(nameD,descriptionView,loc,view){n,d,l,v in
            d.width == v.width - 64
            d.height == v.height/3.5
            d.centerX == v.centerX
            d.top == v.bottom
            
            n.top == d.top + 10
            n.centerX == d.centerX
            n.width == d.width - 32
            
            l.top == n.bottom + 10
            l.centerX == d.centerX
            l.width == d.width - 45
            
        }
        dess = constrain(loc,directionButton,descriptionView,aboutButton){l,d,dv,a in
            d.width == dv.width/2.5
            d.height == 30
            d.left == l.left
            d.bottom == dv.bottom - 25
            
            a.width == dv.width/2.5
            a.height == 30
            a.right == l.right
            a.bottom == dv.bottom - 25
        }
    }
    func openDes(){
        des = constrain(nameD,descriptionView,loc,view){n,d,l,v in
            d.width == v.width - 64
            d.height == v.height/3.5
            d.centerX == v.centerX
            d.bottom == v.bottom - 16
            
            n.top == d.top + 10
            n.centerX == d.centerX
            n.width == d.width - 32
            
            
            l.top == n.bottom + 10
            l.centerX == d.centerX
            l.width == d.width - 40
            
        }
        dess = constrain(loc,directionButton,descriptionView,aboutButton){l,d,dv,a in
            d.width == dv.width/2.5
            d.height == 30
            d.left == l.left
            d.bottom == dv.bottom - 25
            
            a.width == dv.width/2.5
            a.height == 30
            a.right == l.right
            a.bottom == dv.bottom - 25
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        userLocation()
        constrain(clear: des!)
        constrain(clear: dess!)
        view.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.5, animations: {
            self.openDes()
            self.view.layoutIfNeeded()
        })
        nameD.text = marker.title
        loc.text = marker.snippet
        
        for i in 0...places.count-1{
            if marker.title == places[i].title{
                print(i)
                currentPlace = places[i]
                end = CLLocation(latitude: places[i].lat, longitude: places[i].long)
            }
        }
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        constrain(clear: des!)
        constrain(clear: dess!)
        view.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.5, animations: {
            self.hideDes()
            self.view.layoutIfNeeded()
        })
    }
    
}



