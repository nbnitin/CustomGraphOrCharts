//
//  BarGraph.swift
//  CustomGraphs
//
//  Created by Nitin Bhatia on 01/04/22.
//

import UIKit
let CHART_STACK_VIEW_SPACING : CGFloat = 55
let BAR_WIDTH : CGFloat = 34
let MARGIN : CGFloat = 31.5
let BAR_GRAPH_Y_AXIS_STEPPER : CGFloat = 5

@IBDesignable
class BarGraph: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackChartViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackChartView: UIStackView!
    @IBOutlet var contentView : UIView!
    @IBOutlet weak var graphContainerView: UIView!
    @IBOutlet var horizontalSeperators: [UIView]!
    @IBOutlet weak var yAxisSeperator: UIView!
    @IBOutlet weak var xAxisContainerView: UIView!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet var barView: [BarRenderer]!
    @IBOutlet weak var yAxisStackView: UIStackView!
    
    var barRendererViews : [BarRenderer] = [BarRenderer]()
    let colors = ["F8C346","EF6C00","EEEEEE"]
    let icons = ["Me","Topper","Others"]
    var makeBarAnimate : Bool = false
    var oldYAxisLabel : UILabel!
    var maxScore : CGFloat = 0
    
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
        setupYAxisValue(maxScore: 100)
    }
    
    @IBInspectable
    var yAxixTitle : String = "" {
        didSet {
            
            //uncomment below code if you want to show Y axis label in future
            
            if oldYAxisLabel != nil {
                oldYAxisLabel.removeFromSuperview()
            }

            let label = UILabel(frame: CGRect(x: -12, y: graphContainerView.frame.height / 2, width: 100, height: 100))
            label.text = yAxixTitle
            label.textColor = UIColor(named: "color_808080")
            label.textAlignment = .left
            label.font = UIFont(name: "Arial", size: 10)
            label.adjustsFontSizeToFitWidth = true
            graphContainerView.addSubview(label)
            label.sizeToFit()
            label.transform = .init(rotationAngle: -(.pi / 2))
            label.frame.origin.x =  -5
            oldYAxisLabel = label
        }
    }
    
   @IBInspectable
    var values : [CGFloat] = [CGFloat]() {
        didSet {
            barRendererViews.removeAll()
            let _ = stackChartView.arrangedSubviews.map({
                $0.removeFromSuperview()
            })
            
            let _ = xAxisContainerView.subviews.map({
                $0.removeFromSuperview()
            })
            
            for valueIndex in 0 ..< values.count {
                let barRendererView = BarRenderer()
                barRendererView.maxValue = self.maxScore
                barRendererView.widthAnchor.constraint(equalToConstant: BAR_WIDTH).isActive = true
                barRendererView.backgroundColor = .clear
                stackChartView.addArrangedSubview(barRendererView)
                var color = valueIndex % 2 == 0 ? UIColor(hexString: colors[0]) : UIColor(hexString: colors[1])
                var labelColor : UIColor = .white
               
                if valueIndex == values.count - 1 {
                    color = UIColor(hexString: colors.last ?? "")
                    labelColor = .black
                }
                if makeBarAnimate {
                    barRendererView.setupBarWithAnimation(value: values[valueIndex], color: color, labelColor: labelColor)
                } else {
                    barRendererView.setupBar(values[valueIndex], color: color, labelColor: labelColor)
                }
                barRendererViews.append(barRendererView)
                var titleAndIconName = ""
               
                if valueIndex >= icons.count {
                   titleAndIconName = icons.last ?? ""
                } else {
                    titleAndIconName = icons[valueIndex]
                }
                setupXAxis(barView: barRendererView,iconName:titleAndIconName,title:titleAndIconName,index: valueIndex)
            }
            
            if round(stackChartView.frame.width / (BAR_WIDTH + CHART_STACK_VIEW_SPACING)) < CGFloat(values.count) {
                scrollView.isScrollEnabled = true
                scrollView.flashScrollIndicators()
            } else {
                scrollView.isScrollEnabled = false
            }
            
            
            
          //  stackChartViewWidthConstraint.constant =  CGFloat(CGFloat(Int(CHART_STACK_VIEW_SPACING) * values.count) + (BAR_WIDTH * CGFloat(values.count)) - MARGIN)
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
    
    func setupXAxis(barView:BarRenderer,iconName:String,title:String,index:Int) {
        let XAxisRenderWithImage = XAxisRenderWithImage(frame: .zero)
        XAxisRenderWithImage.translatesAutoresizingMaskIntoConstraints = false
        xAxisContainerView.addSubview(XAxisRenderWithImage)
        
        XAxisRenderWithImage.leadingAnchor.constraint(equalTo: barView.leadingAnchor).isActive = true
        XAxisRenderWithImage.topAnchor.constraint(equalTo: xAxisContainerView.topAnchor).isActive = true
        XAxisRenderWithImage.bottomAnchor.constraint(equalTo: xAxisContainerView.bottomAnchor).isActive = true
        XAxisRenderWithImage.trailingAnchor.constraint(equalTo: barView.trailingAnchor).isActive = true
        
        XAxisRenderWithImage.setupView(img: iconName, title: title,index: index)
    }
    
    
    //MARK: setting up y axis
    func setupYAxisValue(maxScore:CGFloat = 100) {
        let _ = yAxisStackView.arrangedSubviews.map({
            $0.removeFromSuperview()
        })
        
        let difference = round(maxScore / BAR_GRAPH_Y_AXIS_STEPPER)
        self.maxScore = maxScore

        for yAxisValue in stride(from: maxScore, through: 0, by: -difference) {
            let lbl = UILabel(frame: .zero)
            if yAxisValue - 1 == 0 || yAxisValue - 2 == 0 {
                lbl.text = "0"
            } else {
                lbl.text = "\(Int(yAxisValue))"
            }
            lbl.textColor = UIColor(named: "color_808080")
            lbl.font = UIFont(name: "Arial", size: 10)
            lbl.allowsDefaultTighteningForTruncation = true
            yAxisStackView.addArrangedSubview(lbl)
        }
    }
}
