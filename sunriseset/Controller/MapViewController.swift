//
//  MapViewController.swift
//  sunriseset
//
//  Created by Mohammed Al-Quraini on 8/15/21.
//
//
//  ViewController.swift
//  lavlabs_skill_assesment
//
//  Created by Mohammed Al-Quraini on 8/5/21.
//

import UIKit
import MapKit



class MapViewController: UIViewController, UIGestureRecognizerDelegate, MKMapViewDelegate {

    let mapView = MKMapView()
    
    var loocationCoordinate : CLLocationCoordinate2D?
    
    let dataLabelView : UIView = {
       let uiView = UIView()
        uiView.backgroundColor = .black
        uiView.layer.cornerRadius = 8
        uiView.layer.opacity = 0.6
        
        return uiView
    }()
    
    private let compassImage : UIImageView = {
       let imageView = UIImageView(image: UIImage(named : "compass"))
        
        
        return imageView
    }()
    
    private let dividerView : UIView = {
       let uiView = UIView()
        uiView.backgroundColor = .gray
        
        return uiView
    }()
    
    private let latLabel : UILabel = {
        let label = UILabel()
        let font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.font = font
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor(named : "primary")
        label.text = "Latitude"
            
        return label
    }()
    
    private let lngLabel : UILabel = {
        let label = UILabel()
        let font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.font = font
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor(named : "primary")
        label.text = "Longitude"
            
        return label
    }()
    
    private let latValLabel : UILabel = {
        let label = UILabel()
        let font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.font = font
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .lightText
        label.text = "..."
            
        return label
    }()
    
    private let lngValLabel : UILabel = {
        let label = UILabel()
        let font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.font = font
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .lightText
        label.text = "..."
            
        return label
    }()
    
    
    
    let topView : UIView = {
       let uiView = UIView()
        uiView.backgroundColor = .gray
        uiView.layer.cornerRadius = 2
        
        return uiView
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(mapView)
        view.addSubview(topView)
        view.addSubview(dataLabelView)
        dataLabelView.addSubview(compassImage)
        dataLabelView.addSubview(dividerView)
        dataLabelView.addSubview(latLabel)
        dataLabelView.addSubview(lngLabel)
        dataLabelView.addSubview(latValLabel)
        dataLabelView.addSubview(lngValLabel)
        
        
        view.backgroundColor = UIColor(named: "background")

        
        

        
        // set mapView delegate
        mapView.delegate = self
        

        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let coordinates = loocationCoordinate {
            addMapAnnotation(coordinates)
            centerMapOnLocation(coordinates)
            latValLabel.text = coordinates.latitude.description
            lngValLabel.text = coordinates.longitude.description
            
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        // map view constraints
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 15).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // top view constraints
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        topView.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2).isActive = true
        topView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // data label view
        dataLabelView.translatesAutoresizingMaskIntoConstraints = false
        dataLabelView.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 20).isActive = true
        dataLabelView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dataLabelView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        dataLabelView.heightAnchor.constraint(equalTo: dataLabelView.widthAnchor, multiplier: 1/3).isActive = true
        
        // compass image
        compassImage.translatesAutoresizingMaskIntoConstraints = false
        compassImage.leadingAnchor.constraint(equalTo: dataLabelView.leadingAnchor).isActive = true
        compassImage.centerYAnchor.constraint(equalTo: dataLabelView.centerYAnchor).isActive = true
        compassImage.heightAnchor.constraint(equalToConstant : 70).isActive = true
        compassImage.widthAnchor.constraint(equalTo: compassImage.heightAnchor).isActive = true
        
        // divider view
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.leadingAnchor.constraint(equalTo: compassImage.trailingAnchor, constant: 12).isActive = true
        dividerView.trailingAnchor.constraint(equalTo: dataLabelView.trailingAnchor, constant: -10).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        dividerView.centerYAnchor.constraint(equalTo: dataLabelView.centerYAnchor).isActive = true
        
        // latitude label
        latLabel.translatesAutoresizingMaskIntoConstraints = false
        latLabel.bottomAnchor.constraint(equalTo: dividerView.topAnchor, constant: -10).isActive = true
        latLabel.leadingAnchor.constraint(equalTo: dividerView.leadingAnchor).isActive = true
        
        // latitude value label
        latValLabel.translatesAutoresizingMaskIntoConstraints = false
        latValLabel.bottomAnchor.constraint(equalTo: dividerView.topAnchor, constant: -10).isActive = true
        latValLabel.trailingAnchor.constraint(equalTo: dividerView.trailingAnchor).isActive = true
        
        // longitude label
        lngLabel.translatesAutoresizingMaskIntoConstraints = false
        lngLabel.bottomAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 25).isActive = true
        lngLabel.leadingAnchor.constraint(equalTo: dividerView.leadingAnchor).isActive = true
        
        // longitude value label
        lngValLabel.translatesAutoresizingMaskIntoConstraints = false
        lngValLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 10).isActive = true
        lngValLabel.trailingAnchor.constraint(equalTo: dividerView.trailingAnchor).isActive = true
        
    }
    
    
    // button constraints
    
    func addMapAnnotation(_ coordinate : CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        if mapView.annotations.count < 1 {
            mapView.addAnnotation(annotation)
        }
        else if self.mapView.annotations.count > 0{
            mapView.removeAnnotations(self.mapView.annotations)
            mapView.addAnnotation(annotation)
        }
    }
    
    func centerMapOnLocation(_ coordinate: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 100000
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    
    

    

}
//

//MARK: - MKMapViewDelegate
extension ViewController : MKMapViewDelegate {

}




