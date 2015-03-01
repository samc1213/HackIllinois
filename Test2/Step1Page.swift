//
//  Step1 Page.swift
//  Test2
//
//  Created by Sam Cohen on 3/1/15.
//  Copyright (c) 2015 edwinwu. All rights reserved.
//

import UIKit
var outside: Bool = false
var inside: Bool = false

class Step1_Page: UIViewController {
    
    @IBAction func outside_clicked(sender : AnyObject) {
        (sender as UIButton).backgroundColor = UIColor.blackColor()
        outside = true
    }
    @IBAction func inside_clicked(sender : AnyObject) {
        (sender as UIButton).backgroundColor = UIColor.blackColor()
        inside = true
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
