//
//  ViewController.swift
//  Test2
//
//  Created by Edwin Wu on 2/28/15.
//  Copyright (c) 2015 edwinwu. All rights reserved.
//

import UIKit
import SwiftHTTP



class ViewController: UIViewController {
    var request = HTTPTask()
    var outside: Bool = false
    var inside: Bool = true
    var dollar = 0
    var monetary_amount = 0
    var restaurant_types:[Bool] = [true, true, true, true, true, true, true, true, true]
    var check = false
    let restaurants = ["Asian",
    "American",
    "Diner",
    "Fast Food",
    "Gourmet",
    "Mexican",
    "Mediterranian",
    "TexMex",
    "Chicken"]
    
    @IBOutlet var moneySlider : UISlider!
    @IBOutlet var maxMoney : UILabel!
    @IBOutlet var resultsTextView : UILabel!

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
        
        for var index = 0; index < (restaurants.count); ++index{
            if restaurant_types[index]==true{
                results += restaurants[index]
            }
        }

        resultsTextView.text = results
    }
    
    func refreshUI() {
        moneySlider.value = Float(dollar)
        maxMoney.text = "Maximum Money (\(Int(moneySlider.value))%)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

