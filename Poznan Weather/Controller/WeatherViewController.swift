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
    
    
    var forcastData = [WeeklyWeather]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        updateWeather()
    }
    
    
    func updateWeather() {
        
        WeeklyWeather.downloadWeeklyWeather { (result:[WeeklyWeather]?) in
            if let weatherData = result {
                self.forcastData = weatherData
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forcastData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherViewCell", for: indexPath) as! WeatherViewCell
        
        let weatherObject = forcastData[indexPath.row]
        
        cell.dayLabel.text = weatherObject._date.dayOfTheWeek().capitalized
        cell.tempLabel.text = "Temperatura:\n" + String(format: "%.0f", weatherObject._temperature) + "°"
        cell.pressureLabel.text = "Ciśnienie:\n" + String(weatherObject._pressure) + " hPa"
        cell.weatherImage.image = UIImage(named: weatherObject._weatherIcon)
        
        return cell
        
    }


    
}

