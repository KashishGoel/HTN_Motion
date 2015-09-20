//
//  DetailViewController.swift
//  HTN_Motion
//
//  Created by Kashish Goel on 2015-09-19.
//  Copyright (c) 2015 Kashish Goel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var array:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

    
    @IBOutlet weak var activeTime: UILabel!
   
    var mainVC = ViewController()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCharts" {
            let mvC:MasterViewController = segue.destinationViewController as! MasterViewController
            mvC.mainVC = self
            mvC.array1 = array
            
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
let array = mainVC.peopleArray
        dump(array)
        let max = maxElement(array)
        println("max is \(max)")
        let count = array.count
        println("count is \(count)")
        
        if let i = find(array, max) {
            println("\(max) is at index \(i)")
            if i > 12 {
                let hour = i - 12
                self.activeTime.text = "\(hour) pm"
                
            }
            else if i == 12 {
            self.activeTime.text = "12 pm"
            }
            
            else if i == 24 {
            self.activeTime.text = "12 am"
            
            }
            else {
            self.activeTime.text = "\(i) am"
            }
        } else {
            println("\(max) isn't in the array")
        }
        

        
//        for var x = 0; x < array.count;{
//            let arrayNumber = array[x]
//            if arrayNumber != max {
//            x++ }
//            
//            else {
//            activeTime.text = "\(x)"
//            }
//        
//        
     //   }
        
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func chartsPressed(sender: UIButton) {
        self.performSegueWithIdentifier("showCharts", sender: self)
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
