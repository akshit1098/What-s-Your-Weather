//
//  ViewController.swift
//  Whats-Weather
//
//  Created by Akshit Saxena on 3/7/24.
//

import UIKit
import CoreLocation


//Things required:
//Location: CoreLocation
//table view
//custom cell: collection view
//API / request to get data

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    
    @IBOutlet var table: UITableView!
    
    var models = [Weather]()
    
    let locationManager = CLLocationManager()
    
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // Register 2 cells
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        
        
        table.delegate = self
        table.dataSource = self
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Calling Location function
        setupLocation()
    }
    
    
    //Location
    
    func setupLocation(){
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil{
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    
    func requestWeatherForLocation(){
        
        guard let currentLocation = currentLocation else{
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        
        let url = "api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&appid=160e478d3afd50d3a59a71467b0194e9"
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            
            //Steps
            //Validation
            //Convert data to models/some object
            //update user interface
            
            
            guard let data = data, error == nil else{
                print("something went wrong")
                return
            }
            
            
            
            
        }
        
        
        
        print("\(lat), \(long)")
    }
    
    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }


}

struct Weather: Codable{
    
}
