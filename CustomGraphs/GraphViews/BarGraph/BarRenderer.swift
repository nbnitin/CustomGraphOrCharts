//
//  BarRenderer.swift
//  CustomGraphs
//
//  Created by Nitin Bhatia on 01/04/22.
//

import UIKit
@IBDesignable
class BarRenderer: UIView {

    //outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var lblBarValue: UILabel!
    @IBOutlet weak var lblLowerBarValue: UILabel!
    
    var maxScore : CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("BarRenderer", owner: self)
        contentView.frame = self.bounds
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    //MARK: setup bar
    func setupBar(_ value: String, color:UIColor, labelColor: UIColor) {
        self.value = NSString(string: value)
        self.color = color
        self.labelColor = labelColor
    }
    
    override var frame: CGRect {
        didSet {
            if contentView != nil {
                contentView.frame = frame
            }
        }
    }
    
   @IBInspectable
    var value : NSString = "0.0" {
        didSet {
            var tempVal : CGFloat = 0
            lblBarValue.text = value as String
            lblLowerBarValue.text = lblBarValue.text

            if value.contains(":") {
                let seperatedValue = value.components(separatedBy: ":")
                let hrs = (seperatedValue[0])
                let mins = (seperatedValue[1])
                let secs = (seperatedValue[2])
                
                if hrs == "0" || hrs == "00" {
                    lblBarValue.text = mins + "m " + secs + "s"
                    lblLowerBarValue.text = lblBarValue.text
                    let time = CGFloat((Float(String(mins + "." + secs)) ?? 0))
                    tempVal = time
                } else {
                    lblBarValue.text = hrs + "h " + mins + "m"
                    lblLowerBarValue.text = lblBarValue.text
                    let time = CGFloat((Float(String(hrs)) ?? 0) * 60) + CGFloat(Float(String(mins)) ?? 0)
                    tempVal = time
                }
            } else {
                tempVal = CGFloat(value.floatValue)
            }
            
            if tempVal <= 15.0 {
                lblLowerBarValue.isHidden = false
                lblBarValue.isHidden = true
            }
            
            if  tempVal > maxScore {
                barView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1 ).isActive = true
            } else if  tempVal <= 0 {
                barView.heightAnchor.constraint(equalToConstant: 1).isActive = true
                lblLowerBarValue.isHidden = false
                lblBarValue.isHidden = true
            } else {
                barView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: (tempVal / maxScore) ).isActive = true
            }
            
            
            barView.layer.cornerRadius = 10
            barView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        }
    }
    
    //MARK: sets bar value with animation
    func setupBarWithAnimation(value:String, duration:Double = 0.4,delay:Double = 0.0,dampingEffect : Double = 0.4,dampingVelocity:Double=0.2,color:UIColor, labelColor: UIColor) {
        setupBar(value, color: color, labelColor: labelColor)
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: dampingEffect, initialSpringVelocity: dampingVelocity, options: .curveLinear, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
   private var color : UIColor = .clear {
        didSet {
            barView.backgroundColor = color
        }
    }
    
    private var labelColor : UIColor = .clear {
        didSet {
            lblBarValue.textColor = labelColor
        }
    }
}
