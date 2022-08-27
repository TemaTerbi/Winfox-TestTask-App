//
//  MapViewController.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 27.08.2022.
//

import UIKit
import SnapKit
import YandexMapKit

class MapViewController: UIViewController {
    
    var viewModel = MapViewModel()
    var places: [Places] = []
    
    lazy var map: YMKMap = {
        return mapView.mapWindow.map
    }()
    
    var mapObjects: YMKMapObjectCollection {
        return map.mapObjects
    }
    
    private lazy var mapView: YMKMapView = {
        let map = YMKMapView()
        return map
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAllPlaceMarks()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        addConstraints()
        bindViewModel()
        setupMapConfigure()
    }
    
    private func addSubview() {
        view.addSubview(mapView)
    }
    
    private func addConstraints() {
        mapView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        viewModel.places.bind { places in
            self.places = places
            self.setupMapConfigure()
        }
    }
    
    private func setupMapConfigure() {
        mapView.mapWindow.map.move(
            with: YMKCameraPosition.init(target: YMKPoint(latitude: 31.34534534, longitude: 51.23394534), zoom: 10, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
            cameraCallback: nil)
        
        var placeMarks = [YMKPoint]()
        
        for el in places {
            placeMarks.append(YMKPoint(latitude: el.latitide, longitude: el.longitude))
        }
        
        let imageTest = UIImage(systemName: "mappin.circle.fill")!
        let icon = YMKIconStyle()
        
        map.mapObjects.addPlacemarks(with: placeMarks, image: imageTest, style: icon)
        mapObjects.addTapListener(with: self)
    }
}

extension MapViewController: YMKMapObjectTapListener {
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        
        let currentPointLongLatitide = point.latitude * 100
        var latitide = 0
        var id = ""
        
        for el in places {
            let lat = Int(el.latitide * 100)
            if lat  == Int(currentPointLongLatitide) {
                latitide = lat
                id = el.id
                break
            }
        }
        
        if latitide == Int(currentPointLongLatitide) {
            let vc = MenuViewController()
            vc.idOfPlace = id
            self.present(vc, animated: true)
        }
        
        return true
    }
}
