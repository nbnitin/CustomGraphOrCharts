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
    let values : [CGFloat] = [22,66.5,80]
    @IBOutlet weak var barGraphView: BarGraph!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        barGraphView.values = values
        barGraphView.drawHorizontalSeperatorEnabled = true
        barGraphView.drawHorizontalSeperatorBehind = false
        barGraphView.layer.borderWidth = 0.5
        barGraphView.layer.borderColor = UIColor.black.cgColor
    }

}

