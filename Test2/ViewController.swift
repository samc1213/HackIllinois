//
//  ViewController.swift
//  Test2
//
//  Created by Edwin Wu on 2/28/15.
//  Copyright (c) 2015 edwinwu. All rights reserved.
//

import UIKit
import SwiftHTTP
import Foundation
import CoreLocation
import MapKit
var restaurant_returns = ["1", "1", "1", "1", "1", "1"]
var moneymoney : String!


class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var outside: Bool = false
    var inside: Bool = true
    var dollar = 0
    var latitude: Float!
    var longitude: Float!
    var monetary_amount = 0
    var restaurant_types:[Bool] = [true, true, true, true, true, true]
    var check = false
    let restaurants = ["American",
    "Chinese",
    "Diner",
    "Italian",
    "Seafood",
    "Thai"]
    
    @IBOutlet var moneySlider : UISlider!
    @IBOutlet var maxMoney : UILabel!
    @IBOutlet var resultsTextView : UILabel!
    @IBOutlet var resultsInformation : UILabel!


    @IBAction func canceltoRestaurants(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveRestaurants(segue:UIStoryboardSegue) {
        let restaurantsViewController = segue.sourceViewController as RestaurantPickerViewControllerTableViewController
        
        
        for var i = 0; i < restaurantsViewController.selRestaurants.count; ++i{
            restaurant_types = restaurantsViewController.selRestaurants
        }
        
        check = true
    }
    
    @IBAction func outside_clicked(sender : AnyObject) {
        (sender as UIButton).backgroundColor = UIColor.brownColor()
        outside = true
    }
    @IBAction func inside_clicked(sender : AnyObject) {
        (sender as UIButton).backgroundColor = UIColor.brownColor()
        inside = true
    }
    
    @IBAction func dinner_clicked(sender : AnyObject) {
        
    }
    
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        var currentValue = Int(sender.value)
        
        maxMoney.text = "Maximum Money ($\(Int(currentValue)))"
    }
    
    @IBAction func calculateTapped(sender : AnyObject) {
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
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

        

        
    }
    
    


    func refreshUI() {
        moneySlider.value = Float(dollar)
        maxMoney.text = "Maximum Money (\(Int(moneySlider.value))%)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

