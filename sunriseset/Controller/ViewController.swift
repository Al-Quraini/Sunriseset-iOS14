//
//  ViewController.swift
//  sunriseset
//
//  Created by Mohammed Al-Quraini on 8/11/21.
//

import UIKit
import CoreLocation
import SearchTextField

class ViewController: UIViewController {
    
    //MARK: - Properties

    let cities : [City] = Bundle.main.decode("cities.json")
    
    private var selectedCity : City?
    
    private var selectedCoordinates : CLLocationCoordinate2D?
    
    private var selectedDate = Date()

    
    let dataManager = DataManager()
    let locationManager = CLLocationManager()
    
    var imagesArraySlideshow : [UIImage] = []
    var slideShowIndex:NSInteger = 0
    var slideShowMax:NSInteger = 0
        
    var ivSlideshow:UIImageView = UIImageView()
    
    private let searchTextField : SearchTextField = {
        let textField = SearchTextField()
        textField.returnKeyType = .done
        textField.leftViewMode = .always
//        textField.placeholderRect(forBounds: CGRect(x: 20, y: 0, width: 20, height: 20))
        textField.backgroundColor = .lightGray
        textField.placeholder = "Search For a City..."
        textField.layer.cornerRadius = 10
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.textColor = .black
        textField.tintColor = .black
        let color = UIColor.darkGray
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        imageContainerView.addSubview(imageView)
        textField.leftViewMode = .always
        textField.theme.font = UIFont.systemFont(ofSize: 12)
        
        textField.leftView = imageContainerView

        
        
        return textField
    }()
    

    
    private let currentLocationButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location"), for: .normal)
        button.scalesLargeContentImage = true
        button.imageView!.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.tintColor = .white
        
//        button.backgroundColor = .green
        
        return button
    }()
    


    
    private let locationLabel : UILabel = {
       let label = UILabel()
        let font = UIFont.systemFont(ofSize: 35, weight: .black)
        label.font = font
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .lightText
        label.text = "--"
        
        return label
    }()
    
    private let dateLabel : UILabel = {
       let label = UILabel()
        let font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.font = font
        label.textColor = .lightText
        label.text = "--"
        
        return label
    }()
    
    private let sunriseLabel : UILabel = {
       let label = UILabel()
        let font = UIFont.systemFont(ofSize: 15, weight: .ultraLight)
        label.font = font
        label.textColor = .lightText
        label.text = "Sunrise"
        
        return label
    }()
    
    private let sunriseTimeLabel : UILabel = {
       let label = UILabel()
        let font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.font = font
        label.textColor = .lightText
        label.text = "--"
        
        return label
    }()
    
    
    private let sunsetLabel : UILabel = {
       let label = UILabel()
        let font = UIFont.systemFont(ofSize: 15, weight: .ultraLight)
        label.font = font
        label.textColor = .lightText
        label.text = "Sunset"
        
        return label
    }()
    
    private let sunsetTimeLabel : UILabel = {
       let label = UILabel()
        let font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.font = font
        label.textColor = .lightText
        label.text = "--"
        
        return label
    }()
    
    private let dayLengthLabel : UILabel = {
       let label = UILabel()
        let font = UIFont.systemFont(ofSize: 15, weight: .ultraLight)
        label.font = font
        label.textColor = .lightText
        label.text = "Length Of The Day"
        
        return label
    }()
    
    private let dayLengthTimeLabel : UILabel = {
       let label = UILabel()
        let font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.font = font
        label.textColor = .lightText
        label.text = "--"
        
        return label
    }()
    
    private let container : UIView = {
       let uiView = UIView()
        uiView.backgroundColor = UIColor(named: "background")
        uiView.layer.cornerRadius = 12
        
        return uiView
    }()
    
    private let sunriseImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sunrise")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .systemYellow
        
        return imageView
    }()
    
    private let sunsetImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sunset")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .systemYellow
        
        return imageView
    }()
    
    private let dayLengthImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.min")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .systemYellow
        
        return imageView
    }()
    
    private let mapButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
//            UIColor(named: "primary")
//        button.setTitle("Show in map", for: .normal)
        button.layer.cornerRadius = 30
        button.setImage(UIImage(systemName: "map"), for: .normal)
        button.tintColor = .lightText
        
        return button
    }()
    
    private let calendarButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "primary")
//            UIColor(named: "primary")
//        button.setTitle("Show in map", for: .normal)
        button.layer.cornerRadius = 30
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        button.tintColor = .lightText
        
        return button
    }()
    
    private let container1 : UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(named: "backgroundSecondary")
        uiView.layer.cornerRadius = 15
        uiView.layer.shadowColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        uiView.layer.shadowRadius = 2
        uiView.layer.shadowOpacity = 1
        uiView.layer.shadowOffset = .zero
        
        return uiView
    }()
    
    private let container2 : UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(named: "backgroundSecondary")
        uiView.layer.cornerRadius = 15
        uiView.layer.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        uiView.layer.shadowRadius = 2
        uiView.layer.shadowOpacity = 1
        uiView.layer.shadowOffset = .zero

        
        return uiView
    }()
    
    
    private let container3 : UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(named: "backgroundSecondary")
        uiView.layer.cornerRadius = 15
        uiView.layer.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        uiView.layer.shadowRadius = 1
        uiView.layer.shadowOpacity = 1
        uiView.layer.shadowOffset = .zero

        return uiView
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        // adding subviews
        view.addSubview(ivSlideshow)
        view.addSubview(container)
        view.addSubview(searchTextField)
        view.addSubview(currentLocationButton)
        view.addSubview(locationLabel)
        view.addSubview(dateLabel)
        container1.addSubview(sunriseImageView)
        container1.addSubview(sunriseLabel)
        container1.addSubview(sunriseTimeLabel)
        container2.addSubview(sunsetLabel)
        container2.addSubview(sunsetTimeLabel)
        container2.addSubview(sunsetImageView)
        container3.addSubview(dayLengthLabel)
        container3.addSubview(dayLengthTimeLabel)
        container3.addSubview(dayLengthImageView)
        view.addSubview(mapButton)
        view.addSubview(calendarButton)
        view.addSubview(container1)
        view.addSubview(container2)
        view.addSubview(container3)
        
        // configure search text field
        configureSearchTextField()
        

        // Do any additional setup after loading the view.
        buildImagesArraySlideshow()

        //slideshow
        imageSlidingConfiguration()
        
        // Date Configuration
        configureDate()
        
        // text field delegate
        searchTextField.delegate = self

        
        // location manager configuration
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        // current location button target
        currentLocationButton.addTarget(self, action: #selector(updateLocation), for: .touchUpInside)
        mapButton.addTarget(self, action: #selector(openMapView), for: .touchUpInside)
        
        
        
       
    }
    
    
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        
        // ivSlidershow
        ivSlideshow.translatesAutoresizingMaskIntoConstraints = false
        ivSlideshow.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        ivSlideshow.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        ivSlideshow.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        ivSlideshow.heightAnchor.constraint(equalToConstant: view.frame.size.height/2.5).isActive = true
        
        // container
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: ivSlideshow.bottomAnchor, constant: -20).isActive = true
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        ivSlideshow.heightAnchor.constraint(equalToConstant: view.frame.size.height/2.5).isActive = true
        container.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 15).isActive = true
        
        
        // search text field
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: currentLocationButton.leadingAnchor).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // current location image view
        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        currentLocationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        currentLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        currentLocationButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        currentLocationButton.widthAnchor.constraint(equalTo: currentLocationButton.heightAnchor).isActive = true
        
        // location label
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
//        locationLabel.bottomAnchor.constraint(equalTo: ivSlideshow.bottomAnchor, constant: -50).isActive = true
        locationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20).isActive = true
        locationLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width - 20).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // date label
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 40).isActive = true
//        dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 15).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        container1.translatesAutoresizingMaskIntoConstraints = false
        container1.heightAnchor.constraint(equalToConstant: 100).isActive = true
        container1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        container1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        container1.topAnchor.constraint(equalTo: container.topAnchor, constant: 40).isActive = true
        
        // sunrise image view
        sunriseImageView.translatesAutoresizingMaskIntoConstraints = false
        sunriseImageView.topAnchor.constraint(equalTo: container1.topAnchor, constant: 10).isActive = true
        sunriseImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        sunriseImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        sunriseImageView.widthAnchor.constraint(equalTo: sunriseImageView.heightAnchor).isActive = true
        
        // sunrise label
        sunriseLabel.translatesAutoresizingMaskIntoConstraints = false
        sunriseLabel.topAnchor.constraint(equalTo: container1.topAnchor, constant: 15).isActive = true
        sunriseLabel.leadingAnchor.constraint(equalTo: sunriseImageView.trailingAnchor, constant: 25).isActive = true
        
        // sunrise time label
        sunriseTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        sunriseTimeLabel.leadingAnchor.constraint(equalTo: sunriseImageView.trailingAnchor, constant: 25).isActive = true
        sunriseTimeLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 10).isActive = true
        
        container2.translatesAutoresizingMaskIntoConstraints = false
        container2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        container2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        container2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        container2.topAnchor.constraint(equalTo: container1.bottomAnchor, constant: 10).isActive = true
        
        // sunset image view
        sunsetImageView.translatesAutoresizingMaskIntoConstraints = false
        sunsetImageView.topAnchor.constraint(equalTo: container2.topAnchor, constant: 10).isActive = true
        sunsetImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        sunsetImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        sunsetImageView.widthAnchor.constraint(equalTo: sunsetImageView.heightAnchor).isActive = true

        
        // sunset label
        sunsetLabel.translatesAutoresizingMaskIntoConstraints = false
        sunsetLabel.topAnchor.constraint(equalTo: container2.topAnchor, constant: 15).isActive = true
        sunsetLabel.leadingAnchor.constraint(equalTo: sunsetImageView.trailingAnchor, constant: 25).isActive = true
        
        // sunset time label
        sunsetTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        sunsetTimeLabel.leadingAnchor.constraint(equalTo: sunsetImageView.trailingAnchor, constant: 15).isActive = true
        sunsetTimeLabel.topAnchor.constraint(equalTo: sunsetLabel.bottomAnchor, constant: 10).isActive = true
        
        container3.translatesAutoresizingMaskIntoConstraints = false
        container3.heightAnchor.constraint(equalToConstant: 100).isActive = true
        container3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        container3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        container3.topAnchor.constraint(equalTo: container2.bottomAnchor, constant: 10).isActive = true
        
        
        // day length image view
        dayLengthImageView.translatesAutoresizingMaskIntoConstraints = false
        dayLengthImageView.topAnchor.constraint(equalTo: container3.topAnchor, constant: 10).isActive = true
        dayLengthImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        dayLengthImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        dayLengthImageView.widthAnchor.constraint(equalTo: dayLengthImageView.heightAnchor).isActive = true

        
        // day length label
        dayLengthLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLengthLabel.topAnchor.constraint(equalTo: container3.topAnchor, constant: 15).isActive = true
        dayLengthLabel.leadingAnchor.constraint(equalTo: dayLengthImageView.trailingAnchor, constant: 25).isActive = true
        
        // day length time label
        dayLengthTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLengthTimeLabel.leadingAnchor.constraint(equalTo: dayLengthImageView.trailingAnchor, constant: 25).isActive = true
        dayLengthTimeLabel.topAnchor.constraint(equalTo: dayLengthLabel.bottomAnchor, constant: 10).isActive = true
        
        // map button
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        mapButton.topAnchor.constraint(equalTo: container.topAnchor, constant: -30).isActive = true
        mapButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        mapButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        mapButton.widthAnchor.constraint(equalTo: mapButton.heightAnchor).isActive = true
        
        // calendar button
        calendarButton.translatesAutoresizingMaskIntoConstraints = false
        calendarButton.topAnchor.constraint(equalTo: container.topAnchor, constant: -30).isActive = true
        calendarButton.trailingAnchor.constraint(equalTo: mapButton.leadingAnchor, constant: -10).isActive = true
        calendarButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        calendarButton.widthAnchor.constraint(equalTo: calendarButton.heightAnchor).isActive = true
        

        


        }

    
    //MARK: - API REQUEST
    func apiRequest(lat : Double, lng : Double, cityName : String){
        sunriseTimeLabel.text = "--"
        sunsetTimeLabel.text = "--"
        locationLabel.text = "--"
        dayLengthTimeLabel.text = "--"
        
        dataManager.fetchData(lat: lat, lng: lng) { result in
            DispatchQueue.main.async {
                self.sunriseTimeLabel.text = result.sunrise.timeToHoursAndMinutes12()
                self.sunsetTimeLabel.text = result.sunset.timeToHoursAndMinutes12()
                self.locationLabel.text = cityName
                self.dayLengthTimeLabel.text = result.day_length.dayLengthString()
            }
        }
    }

    
    //MARK: - Search Text Field Configuration
    func configureSearchTextField(){
        
        

        searchTextField.itemSelectionHandler = { [self]item, itemPosition in
            print(itemPosition)
            let cityName : String = item[itemPosition].title
            guard let country = item[itemPosition].subtitle else {
                return
            }
            searchTextField.text = cityName
            self.selectedCity =  self.cities.first(where: {$0.name == cityName && $0.country == country})
            
            if let city = selectedCity {
                apiRequest(lat: Double(city.lat) ?? 0.0, lng: Double(city.lng) ?? 0.0, cityName: "\(city.name), \(city.country)")
                
                selectedCoordinates = CLLocationCoordinate2D(latitude: Double(city.lat) ?? 0.0, longitude: Double(city.lng) ?? 0.0)
            }
        }

                // Start filtering after an specific number of characters - Default: 0
                self.searchTextField.minCharactersNumberToStartFiltering = 3
                self.searchTextField.maxNumberOfResults = 5
    }
    


    //MARK: - image sliding configuration
    func imageSlidingConfiguration(){
        self.slideShowMax = self.imagesArraySlideshow.count
        DispatchQueue.global(qos: .userInteractive).async {
            while 1 == 1 {
//                print ("MAX:"+String(self.slideShowMax))
//
                DispatchQueue.main.async {
                    let toImage = self.imagesArraySlideshow[self.slideShowIndex]
//                    print ("index:"+String(self.slideShowIndex))
                    UIView.transition(
                        with: self.ivSlideshow,
                        duration: 5,
                        options: .transitionCrossDissolve,
                        animations: {self.ivSlideshow.image = toImage},
                        completion: nil
                    )
                }
                self.slideShowIndex += 1
                if self.slideShowIndex == self.slideShowMax {
                    self.slideShowIndex = 0
                }
                sleep(10)
            }
        }
    }
    
    func buildImagesArraySlideshow(){
        // example: localImageFilePath:URL = *URLs FOR SOME LOCAL IMAGE FILES*
      
        // for localImageFilePath in YOURIMAGEGFILES {
        imagesArraySlideshow.append(UIImage(named: "sunset1")!)
        imagesArraySlideshow.append(UIImage(named: "sunset2")!)
        imagesArraySlideshow.append(UIImage(named: "sunset3")!)
        imagesArraySlideshow.append(UIImage(named: "sunset4")!)
        imagesArraySlideshow.append(UIImage(named: "sunset5")!)
        imagesArraySlideshow.append(UIImage(named: "sunset6")!)

        // }
    }
    
    // Configure Date
    func configureDate(){
        dateLabel.text = selectedDate.string(format: "EEEE, MMMM dd")

    }
    
    
    
    //MARK: - Targets
    @objc func updateLocation(){
        searchTextField.text = ""
        sunriseTimeLabel.text = "--"
        sunsetTimeLabel.text = "--"
        locationLabel.text = "--"
        dayLengthTimeLabel.text = "--"
        
        locationManager.requestLocation()
        selectedCity = nil
    }
    
    @objc func openMapView(){
        performSegue(withIdentifier: "openMap", sender: self)
    }
    
    
    //MARK: - Search cities method
    func searchMoreItemsInBackground(_ cirteria : String, completion : @escaping ([SearchTextFieldItem]) -> Void){
        var searchTextFieldItems : [SearchTextFieldItem] = []
        for city in self.cities {
            if city.name.hasPrefix(cirteria.capitalized) {
                let searchTextFieldItem = SearchTextFieldItem(title: city.name, subtitle: city.country)
                searchTextFieldItems.append(searchTextFieldItem)
            }
            
        }
        
        completion(searchTextFieldItems)
        
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openMap" {
            let destinationVC = segue.destination as! MapViewController
            guard selectedCoordinates != nil else {return}
            destinationVC.loocationCoordinate = selectedCoordinates
            
            
        }
    }
    
}

            
        
        
        
//MARK: - UITextFieldDelegate
extension ViewController : UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            print(textField.text!)
            textField.text = ""
            textField.endEditing(true)
            
            
            
//            deactivateTableView()
        }
        
        
        return true
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        searchTextField.userStoppedTypingHandler = {
            if let criteria = self.searchTextField.text {
                if criteria.count > 1 {

                    // Show the loading indicator
                    self.searchTextField.showLoadingIndicator()

                    self.searchMoreItemsInBackground(criteria) { results in
                        // Set new items to filter
                        self.searchTextField.filterItems(results)


                        // Hide loading indicator
                        self.searchTextField.stopLoadingIndicator()
                    }
                }
            }
        }
        
        return true
    }
    

    
    
    
     
}


//MARK: - CLLocationManagerDelegate
extension ViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            
            selectedCoordinates = location.coordinate
            
            let geocoder = CLGeocoder()
                      
                  // Look up the location and pass it to the completion handler
                  geocoder.reverseGeocodeLocation(location,
                              completionHandler: { (placemarks, error) in
                      if error == nil {
                        guard let firstLocation = placemarks?[0] else {
                            return
                        }
                        
                        let cityName = "\(String(describing: firstLocation.locality ?? "citName")), \(String(describing: firstLocation.administrativeArea ?? ""))"
                        
                        self.apiRequest(lat: lat, lng: lng, cityName: cityName)
                      }
                      else {
                       // An error occurred during geocoding.
                         return
                      }
                  })
        }
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


