//
//  BarGraph.swift
//  CustomGraphs
//
//  Created by Nitin Bhatia on 01/04/22.
//

import UIKit

@IBDesignable
class BarGraph: UIView {

    @IBOutlet weak var stackChartView: UIStackView!
    @IBOutlet var contentView : UIView!
    @IBOutlet weak var graphContainerView: UIView!
    @IBOutlet var horizontalSeperators: [UIView]!
    @IBOutlet weak var yAxisSeperator: UIView!
    @IBOutlet weak var xAxisContainerView: UIView!
    @IBOutlet weak var lblYAxisTitle: UILabel!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet var barView: [BarRenderer]!
    
    var barRendererViews : [BarRenderer] = [BarRenderer]()
    let colors = ["F8C346","EF6C00","EEEEEE"]
    let icons = ["Me","Topper","Others"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("BarGraph", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        lblYAxisTitle.transform = .init(rotationAngle: -(.pi / 2))
    }
    
   @IBInspectable
    var values : [CGFloat] = [CGFloat]() {
        didSet {
            for i in 0 ..< values.count {
                let barRendererView = BarRenderer()
                barRendererView.widthAnchor.constraint(equalToConstant: 34).isActive = true
                barRendererView.heightAnchor.constraint(equalToConstant: stackChartView.frame.height).isActive = true
                barRendererView.backgroundColor = .clear
                stackChartView.addArrangedSubview(barRendererView)
                var color = i % 2 == 0 ? UIColor(hexString: colors[0]) : UIColor(hexString: colors[1])
                var labelColor : UIColor = .white
                if i == values.count - 1 {
                    color = UIColor(hexString: colors.last ?? "")
                    labelColor = .black
                }
                barRendererView.setupBar(values[i], color: color, labelColor: labelColor)
                barRendererViews.append(barRendererView)
                setupXAxis(barView: barRendererView,iconName:icons[i],title:icons[i])

            }
            
        }
    }
    
    @IBInspectable
    var drawHorizontalSeperatorEnabled : Bool = true {
        didSet {
            horizontalSeperators.forEach({
                $0.isHidden = !drawHorizontalSeperatorEnabled
            })
        }
    }
    
    @IBInspectable
    var drawHorizontalSeperatorBehind : Bool = true {
        didSet {
            if drawHorizontalSeperatorBehind {
                horizontalSeperators.forEach({
                    contentView.sendSubviewToBack($0)
                })
            } else {
                horizontalSeperators.forEach({
                    contentView.bringSubviewToFront($0)
                })
            }
        }
    }
    
    var xAxisViews : [XAxisRenderWithImage] = [XAxisRenderWithImage]()
    
    func setupXAxis(barView:BarRenderer,iconName:String,title:String) {
        let XAxisRenderWithImage = XAxisRenderWithImage(frame: .zero)
        XAxisRenderWithImage.translatesAutoresizingMaskIntoConstraints = false
        xAxisContainerView.addSubview(XAxisRenderWithImage)
        
        XAxisRenderWithImage.leadingAnchor.constraint(equalTo: barView.leadingAnchor).isActive = true
        XAxisRenderWithImage.topAnchor.constraint(equalTo: xAxisContainerView.topAnchor).isActive = true
        XAxisRenderWithImage.bottomAnchor.constraint(equalTo: xAxisContainerView.bottomAnchor).isActive = true
        XAxisRenderWithImage.trailingAnchor.constraint(equalTo: barView.trailingAnchor).isActive = true
        
        XAxisRenderWithImage.setupView(img: iconName, title: title)
    }
    
}
