//
//  MasterViewController.swift
//  HTN_Motion
//
//  Created by Kashish Goel on 2015-09-19.
//  Copyright (c) 2015 Kashish Goel. All rights reserved.
//

import UIKit
import PNChartSwift

class MasterViewController: UIViewController, PNChartDelegate {
    var mainVC = DetailViewController()
     var array1:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         array1 = mainVC.array
        dump(array1)
        // Do any additional setup after loading the view.
    }
   
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var viewController:UIViewController = segue.destinationViewController as! UIViewController
        var ChartLabel:UILabel = UILabel(frame: CGRectMake(0, 90, 320.0, 30))
        
        ChartLabel.textColor = PNGreenColor
        ChartLabel.font = UIFont(name: "Avenir-Medium", size:23.0)
        ChartLabel.textAlignment = NSTextAlignment.Center
        
        switch segue.identifier! as NSString {
        case "lineChart":
            //Add LineChart
            ChartLabel.text = "Visitors over the Day"
            
            var lineChart:PNLineChart = PNLineChart(frame: CGRectMake(0, 135.0, 360, 200.0))
            lineChart.yLabelFormat = "%1.1f"
            lineChart.showLabel = true
            lineChart.backgroundColor = UIColor.clearColor()
            lineChart.xLabels = ["","","","4","","","", "8", "", "", "", "12","","","","16","","","", "20", "", "", "", "24"]
            
            //lineChart.xLabels = ["1 am","2 am","3 am","4 am","5 am","6 am","7 am", "8 am", "9 am", "10 am", "11 am", "12 pm","1 pm","2 pm","3 pm","4 pm","5 pm","6 pm","7 pm", "8 pm", "9 pm", "10 pm", "11 pm", "12 am"]
            lineChart.showCoordinateAxis = true
            lineChart.delegate = self
            
            // Line Chart Nr.1
            var data01Array: [CGFloat] = [1, 8, 44, 25, 90, 88, 60]
            var data01:PNLineChartData = PNLineChartData()
            data01.color = PNGreenColor
            data01.itemCount = data01Array.count
            data01.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
            data01.getData = ({(index: Int) -> PNLineChartDataItem in
                var yValue:CGFloat = data01Array[index]
                var item = PNLineChartDataItem(y: yValue)
                return item
            })
            
            lineChart.chartData = [data01]
            lineChart.strokeChart()
            
            //        lineChart.delegate = self
            
            viewController.view.addSubview(lineChart)
            viewController.view.addSubview(ChartLabel)
            viewController.title = "Line Chart"
            
        case "barChart":
            //Add BarChart
            ChartLabel.text = "Visitors Over The Week"
            
            var barChart = PNBarChart(frame: CGRectMake(0, 135.0, 320.0, 200.0))
            barChart.backgroundColor = UIColor.clearColor()
            //            barChart.yLabelFormatter = ({(yValue: CGFloat) -> NSString in
            //                var yValueParsed:CGFloat = yValue
            //                var labelText:NSString = NSString(format:"%1.f",yValueParsed)
            //                return labelText;
            //            })
            
            
            // remove for default animation (all bars animate at once)
            barChart.animationType = .Waterfall
            
            
            barChart.labelMarginTop = 5.0
            barChart.xLabels = ["Sept 14","Sept 15","Sept 16","Sept 17","Sept 18","Sept 19","Sept 20", "8", "", "", "", "12","","","","16","","","", "20", "", "", "", "24"]
            barChart.yValues = [21,24,12,18,30,10,1]
            barChart.strokeChart()
            
            barChart.delegate = self
            
            viewController.view.addSubview(ChartLabel)
            viewController.view.addSubview(barChart)
            
            viewController.title = "Bar Chart"
            
        default:
            println("Hello Chart")
        }
        
    }
    
    func userClickedOnLineKeyPoint(point: CGPoint, lineIndex: Int, keyPointIndex: Int)
    {
        println("Click Key on line \(point.x), \(point.y) line index is \(lineIndex) and point index is \(keyPointIndex)")
    }
    
    func userClickedOnLinePoint(point: CGPoint, lineIndex: Int)
    {
        println("Click Key on line \(point.x), \(point.y) line index is \(lineIndex)")
    }
    
    func userClickedOnBarChartIndex(barIndex: Int)
    {
        println("Click  on bar \(barIndex)")
    }

}


