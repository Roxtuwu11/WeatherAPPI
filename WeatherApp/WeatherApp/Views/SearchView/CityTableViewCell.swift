//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Ximena Rotceh Mendoza Gamino on 15/05/25.
//

import UIKit

class CityTableViewCell: UITableViewCell {
 
    @IBOutlet weak var cityName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var city: City?
    {
        didSet {
            guard let dataCity = city else {
                return
            }
            self.cityName.text = dataCity.cityName
            
        }
    }

}
