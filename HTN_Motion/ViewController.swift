//
//  ViewController.swift
//  HTN_Motion
//
//  Created by Kashish Goel on 2015-09-19.
//  Copyright (c) 2015 Kashish Goel. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
  
    
    @IBOutlet weak var peopleCountLabel: UILabel!
    
    private let ref = Firebase(url: "https://motion.firebaseio.com")
    var countNumber = 0
    var peopleArray:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    //[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]

   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let dVC:DetailViewController = segue.destinationViewController as! DetailViewController
            dVC.mainVC = self
            
            dVC.array = peopleArray
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //peopleCountLabel.text = "\(countNumber)"
        firebaseCall()

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    @IBAction func metricsPressed(sender: UIButton) {
//        
//    self.performSegueWithIdentifier("showMetrics", sender: self)
//        
//    }
    
    
    @IBAction func metricsPressed(sender: UIButton) {
        self.performSegueWithIdentifier("showDetail", sender: self)
    }
    
    func firebaseCall () {
    
        ref.observeEventType(.Value, withBlock: { snapshot in
            println(snapshot.value)
            let people = snapshot.value["people"] as! Int
            println("People is \(people)")
            self.countNumber = people
            self.peopleCountLabel.text = "\(self.countNumber)"
//            let time = snapshot.value["time"] as! Int
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(.CalendarUnitHour, fromDate: date)
            let hour = components.hour
                
            println("time is \(hour)")
            var met = people
            let originalVal = self.peopleArray[hour]
            if people > originalVal {
                self.peopleArray[hour] = people}
            dump(self.peopleArray)
            
            }, withCancelBlock: { error in
                println(error.description)
        })
    }

}

