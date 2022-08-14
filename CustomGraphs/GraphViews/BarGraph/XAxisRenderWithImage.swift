//
//  XAxisRenderer.swift
//  CustomGraphs
//
//  Created by Nitin Bhatia on 01/04/22.
//

import UIKit

class XAxisRenderWithImage: UIView {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("XAxisRenderWithImage", owner: self)
        contentView.frame = self.bounds
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func setupView(img:String,title:String,index:Int) {
        imgIcon.image = UIImage(named: img)
        lblTitle.text = title
    }

}
