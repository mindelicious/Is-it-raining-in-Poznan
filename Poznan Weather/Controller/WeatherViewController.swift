//
//  ViewController.swift
//  Poznan Weather
//
//  Created by Matt on 16/03/2019.
//  Copyright © 2019 mindelicious. All rights reserved.
//
import UIKit

class WeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var forecastData = [WeeklyWeather]()
    var weatherToSend: WeeklyWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        updateWeather()
    }
    
    
    func updateWeather() {
        
        WeeklyWeather.downloadWeeklyWeather { (result:[WeeklyWeather]?) in
            if let weatherData = result {
                self.forecastData = weatherData
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherViewCell", for: indexPath) as! WeatherViewCell
        
        let weatherObject = forecastData[indexPath.row]
        
        cell.dayLabel.text = weatherObject.date.dayOfTheWeek().capitalized
        cell.tempLabel.text = "Temperatura:\n" + String(format: "%.0f", weatherObject.temperature) + "°"
        cell.pressureLabel.text = "Ciśnienie:\n" + String(format: "%.0f", weatherObject.pressure) + " hPa"
        cell.weatherImage.image = UIImage(named: weatherObject.weatherIcon)
        
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let weather = forecastData[indexPath.row]
        self.weatherToSend = weather
        performSegue(withIdentifier: "WeeklyToDaily", sender: weather) 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeeklyToDaily" {
            let singleVC = segue.destination as! SingleDayViewController
            singleVC.forecast = self.weatherToSend
        }
    }


}

