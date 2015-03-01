//
//  FinalViewController.swift
//  Test2
//
//  Created by Sam Cohen on 2/28/15.
//  Copyright (c) 2015 edwinwu. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy



class FinalViewController: UIViewController {
    var tempstring: String!
    var str : String!
    var name : String!
    var telephone : String!
    var address1 : String!
    var address2 : String!
    var rating : Double!
    
    @IBOutlet var resultsInformation : UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        var request = HTTPTask();
        let params: Dictionary<String, AnyObject> = ["lat": 34.1024, "long": -118.41835]
        request.POST("http://diesel-ability-87008.appspot.com/submitrestaurant", parameters: params, success:{(response: HTTPResponse) in
            
            if let data = response.responseObject as? NSData {
                let k = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("response: \(k)")
                dispatch_async(dispatch_get_main_queue(), {
                    self.str = k
                    self.resultsInformation.text = self.str
                    var counter = 0

                    var myName = self.str.componentsSeparatedByString("'name': u'")
                    var myName2 = myName[1].componentsSeparatedByString("'")
                    self.name = myName2[0]
                    println("\(self.name)")
                    
                    var myTelephone = self.str.componentsSeparatedByString("tel': u'")
                    var myTelephone2 = myTelephone[1].componentsSeparatedByString("'")
                    self.telephone = myTelephone2[0]
                    println("\(self.telephone)")

                    
                    var myRating = self.str.componentsSeparatedByString("u'rating': ")
                    var myRating2 = myRating[1].componentsSeparatedByString("'")
                    self.rating = (myRating2[0] as NSString).doubleValue
                    println("\(self.rating)")

                    
                    var myAddress1 = self.str.componentsSeparatedByString("u'address': u'")
                    var myAddress2 = myAddress1[1].componentsSeparatedByString("'")
                    
                    self.address1 = myAddress2[0]
                    println("\(self.address1)")

                    
                    var myAddress3 = self.str.componentsSeparatedByString("locality': u'")
                    var myAddress4 = myAddress3[1].componentsSeparatedByString("'")
                    var myAddress5 = self.str.componentsSeparatedByString("region': u'")
                    var myAddress6 = myAddress5[1].componentsSeparatedByString("'")
                    var myAddress7 = self.str.componentsSeparatedByString("u'postcode': u'")
                    var myAddress8 = myAddress3[1].componentsSeparatedByString("'")
                    
                    var tempcom = ","
                    var tempspace = " "
                    var tempadd = myAddress4[0] + tempcom
                    var tempadd1 = tempspace + myAddress6[0] + tempspace + myAddress8[0]
                    self.address2 = tempadd + tempadd1
                    println("\(self.address2)")


                    
                    
//                        if self.str.substringWithRange(Range<String.Index>(start: advance(str.startIndex, i), end: advance(str.startIndex, i+4))) == "name" {
//                            
//                        }
                        
                        
//
                    
                })

            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)")
        })
        
        //resultsInformation.text = "hello"
        
        
        // Do any additional setup after loading the view, typically from a nib.
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
