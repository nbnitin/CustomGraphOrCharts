//
//  ViewController.swift
//  CustomGraphs
//
//  Created by Nitin Bhatia on 01/04/22.
//

import UIKit
//graph view has capability to detect either to allow scroll or not based on data, either getting fitted in device width or not.
class ViewController: UIViewController {
    //let values : [CGFloat] = [22,65.6,80,40,30,90,24,10,22,65.6,80,40,30,90,24,10]
    var values : [CGFloat] = [22,66.5,80]
    @IBOutlet var btnValues: [UIButton]!
    @IBOutlet weak var barGraphView: BarGraph!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        barGraphView.drawHorizontalSeperatorEnabled = true
        barGraphView.drawHorizontalSeperatorBehind = false
        barGraphView.layer.borderWidth = 0.5
        barGraphView.layer.borderColor = UIColor.black.cgColor
        barGraphView.makeBarAnimate = true
        values = [22,65.6,80,40,30,90,24,10,22,65.6,80,40,30,90,24,10]
        barGraphView.yAxixTitle = "Score (%)"
        barGraphView.values = values
        barGraphView.setupYAxisValue(maxScore: 300)
    }

    @IBAction func btnValuesAction(_ sender: Any) {
        
        let btn = sender as! UIButton
        
        if btnValues.firstIndex(of: btn) == 0 {
            values = [22,66.5,80]
            barGraphView.yAxixTitle = "Score (%)"
        } else if btnValues.firstIndex(of: btn) == 1 {
            values = [2,6,8]
            barGraphView.yAxixTitle = "Time Left (sec)"
        } else {
            values = [-2,66.5,80]
            barGraphView.yAxixTitle = "Score 1 (%)"
        }
        barGraphView.values = values
    }
}

