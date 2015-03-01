//
//  Step3Page.swift
//  Test2
//
//  Created by Sam Cohen on 3/1/15.
//  Copyright (c) 2015 edwinwu. All rights reserved.
//

import UIKit
import CoreLocation

var restaurant_returns : [String] = ["1", "1", "1", "1", "1", "1"]
var moneymoney : String!
var latlong: [Double] = [0.1, 0.1]

class Step3Page: UIViewController, CLLocationManagerDelegate {
    var statement = false
    var dollar = 0
    var tempstring: String!
    var monetary_amount = 0
    var lat: Double!
    var long: Double!
    var check = false
    let restaurants = ["American",
        "Chinese",
        "Diner",
        "Italian",
        "Seafood",
        "Thai"]
    
    var locationManager = CLLocationManager()
    @IBOutlet var moneySlider : UISlider!
    @IBOutlet var maxMoney : UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        var currentValue = Int(sender.value)
        
        maxMoney.text = "Maximum Money ($\(Int(currentValue)))"
    }
    
    @IBAction func calculateTapped(sender : AnyObject) {
        latlong = [lat, long]
        var results = ""
        if moneySlider.value < 20 && Int(moneySlider.value) > -1
        {
            moneymoney = "1"
        }
        else if moneySlider.value < 60 && moneySlider.value > 20
        {
            moneymoney = "2"
        }
        else if moneySlider.value > 60 && moneySlider.value < 120
        {
            moneymoney = "3"
        }
        else if moneySlider.value > 120 && moneySlider.value < 200
        {
            moneymoney = "4"
        }
        else
        {
            moneymoney = "5"
        }
        
        
        for var index = 0; index < (restaurants.count); ++index{
            if restaurant_types[index]==true{
                
                restaurant_returns[index] = "1"
            }
            else
            {
                restaurant_returns[index] = "0"
            }
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingLocation()
        if ((error) != nil) {
            print(error)
        }
    }

    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue : CLLocationCoordinate2D = manager.location.coordinate
        locationManager.stopUpdatingLocation()
        lat = locValue.latitude
        long = locValue.longitude
        println("\(lat)")
    }

    
    func refreshUI() {
        moneySlider.value = Float(dollar)
        maxMoney.text = "Maximum Money (\(Int(moneySlider.value))%)"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
