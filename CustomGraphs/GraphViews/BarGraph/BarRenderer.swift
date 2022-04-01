//
//  BarRenderer.swift
//  CustomGraphs
//
//  Created by Nitin Bhatia on 01/04/22.
//

import UIKit
@IBDesignable
class BarRenderer: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var lblBarValue: UILabel!
    
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
    
    func setupBar(_ value: CGFloat, color:UIColor, labelColor: UIColor) {
        self.value = value
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
   var value : CGFloat = 0.0 {
        didSet {
            let difference : CGFloat = value / 1000
            barView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: (value / 100.0) ).isActive = true
            lblBarValue.text = "\(value)"
            barView.layer.cornerRadius = 10
            barView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        }
    }
    
    func setupBarWithAnimation(value:CGFloat, duration:Double = 0.4,delay:Double = 0.0,dampingEffect : Double = 0.4,dampingVelocity:Double=0.2,color:UIColor, labelColor: UIColor) {
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
