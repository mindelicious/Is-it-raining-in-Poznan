//
//  SingleDayViewController.swift
//  Poznan Weather
//
//  Created by Matt on 11/04/2019.
//  Copyright © 2019 mindelicious. All rights reserved.
//

import UIKit

class SingleDayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    var forecast: WeeklyWeather? 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    
        if let forecastDay = forecast {
            tempLabel.text = String(format: "%.0f", forecastDay.temperature) + "°"
            dateLabel.text = "\(forecastDay.date.singleDayOfTheWeek())".capitalized
            weatherIcon.image = UIImage(named: forecastDay.weatherIcon)
        } 
        
    }
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleDayCell", for: indexPath) as! SingleDayViewCell
       
        if let forecastDay = forecast {
            switch indexPath.row {
            case 0:
                let prettyMinTemp = String(format: "%.0f", forecastDay.minTemp) + "° - "
                let prettyMaxTemp = String(format: "%.0f", forecastDay.maxTemp) + "°"
                cell.descriptionLabel.text = prettyMinTemp + prettyMaxTemp
                cell.iconImage.image = UIImage(named: "temp")
                cell.titleLabel.text = "MIN - MAX"
            case 1:
                cell.descriptionLabel.text = String(format: "%.0f", forecastDay.pressure) + " hPa"
                cell.iconImage.image = UIImage(named: "pressure")
                cell.titleLabel.text = "Ciśnienie"
            case 2:
                cell.descriptionLabel.text = String(forecastDay.humidity) + "%"
                cell.iconImage.image = UIImage(named: "humidity")
                cell.titleLabel.text = "Wilgotność"
            case 3:
                let windDirection = Direction(forecastDay.windDir).rawValue
                let windSpeed = String(format: "%.0f", forecastDay.wind) + " km/h"
                cell.descriptionLabel.text = windDirection.uppercased() + " " + windSpeed
                cell.iconImage.image = UIImage(named: "wind")
                cell.titleLabel.text = "Wiatr"
            default:
                break
            }
        }
        return cell
    }

}
