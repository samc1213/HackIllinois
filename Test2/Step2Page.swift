//
//  Step2Page.swift
//  Test2
//
//  Created by Sam Cohen on 3/1/15.
//  Copyright (c) 2015 edwinwu. All rights reserved.
//

import UIKit
var restaurant_types:[Bool] = [true, true, true, true, true, true]


class Step2Page: UIViewController {
    var dollar = 0
    var tempstring: String!
    var monetary_amount = 0
    var check = false
    let restaurants = ["American",
        "Chinese",
        "Diner",
        "Italian",
        "Seafood",
        "Thai"]
    @IBAction func canceltoRestaurants(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveRestaurants(segue:UIStoryboardSegue) {
        let restaurantsViewController = segue.sourceViewController as RestaurantPickerViewControllerTableViewController
        
        
        for var i = 0; i < restaurantsViewController.selRestaurants.count; ++i{
            restaurant_types = restaurantsViewController.selRestaurants
        }
        
        check = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
