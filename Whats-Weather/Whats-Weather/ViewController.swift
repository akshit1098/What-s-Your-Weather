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
    
    var models = [String]()
    var lowTemps = [String]()
    var highTemps = [String]()
    var dates = [String]()
    var images = [UIImage]()
    
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
    
    func extractDay(from timestamp: TimeInterval)->Int?{
        
        let date = Date(timeIntervalSince1970: timestamp)
        
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: date)
        
        return day
        
    }
    
    
    
    func requestWeatherForLocation(){
        
        guard let currentLocation = currentLocation else{
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        //Steps
        let key = "160e478d3afd50d3a59a71467b0194e9"
        
        
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&appid=\(key)"
        
        //Validation
        
        
        URLSession.shared.dataTask(with: URL(string: url)!) { [self] data, response, error in
            
            
        guard let data = data, error == nil else{
                print("something went wrong")
                return
        }
            
            
        //Convert data to models/some object
            var p = [String]()
            var json: WeatherResponse?
            do{
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
            }
            catch{
                print("error: \(error)")
                
            }
            
            guard let result = json else{
                return
            }
            
            for i in result.list{
                print("Weather: \(i.weather)")
                print("Date: \(i.dt_txt)")
                self.dates.append(String(i.dt_txt))
//                if let day = extractDay(from: TimeInterval(i.dt)) {
//                    self.dates.append(String(day))
//                } else {
//                    print("Failed to extract day.")
//                }
                for j in i.weather{
                    //print("Prediction: \(j.main)")
                    self.models.append(j.main)
                    
                    
                    
                }
            }
            
            for ele in result.list{
//                print(ele.main.temp_max, ele.main.temp_min)
                self.lowTemps.append(String(format:"%.2f",ele.main.temp_min - 273.15) + "\u{00B0}" + "C")
                self.highTemps.append(String(format:"%.2f",ele.main.temp_max - 273.15) + "\u{00B0}" + "C")
            }
            
            
//            print(self.models)
//            print(self.highTemps)
//            print(self.lowTemps)
            
            
            for i in models{
                if (i == "Clear"){
                    self.images.append(UIImage(named: "clear")!)
                }
                else if (i == "Clouds"){
                    self.images.append(UIImage(named: "cloud")!)
                }
                else{
                    self.images.append(UIImage(named: "rain")!)
                }
            }
            
            print(self.images)
            
        //update user interface
            
            DispatchQueue.main.async{
                self.table.reloadData()
            }
            
            
            
        }.resume()
        
        
        
        print("\(lat), \(long)")
    }
    
    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        
        cell.dayLabel.text = dates[indexPath.row]
        cell.highTempLabel.text = highTemps[indexPath.row]
        cell.highTempLabel.textAlignment = .center
        cell.lowTempLabel.textAlignment = .center
        cell.lowTempLabel.text = lowTemps[indexPath.row]
        cell.iconImageView.image = images[indexPath.row]
        cell.iconImageView.contentMode = .scaleAspectFill
        
        
        
        return cell
    }


}

