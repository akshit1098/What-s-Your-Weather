//
//  WeatherTableViewCell.swift
//  Whats-Weather
//
//  Created by Akshit Saxena on 3/7/24.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var highTempLabel: UILabel!
    @IBOutlet var lowTempLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        backgroundColor = .gray
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib{
        
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
        
    }
    
    func configure(with model: WeatherPrediction){
        self.lowTempLabel.text = "\(Double(model.main.temp_min))"
        
    }
    
    
    
    
    
}
