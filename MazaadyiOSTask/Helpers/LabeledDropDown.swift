//
//  LabeledDropDown.swift
//  MazaadyiOSTask
//
//  Created by Ahmed Mahrous on 13/01/2024.
//

import UIKit
import iOSDropDown

class LabeledDropDown: DropDown {
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Category"
        lbl.textColor = .lightGray
        lbl.backgroundColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    @IBInspectable public var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    // Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}

extension LabeledDropDown {
    func setupUI() {
        self.addSubview(titleLabel)
        //add constraints
        let horizontalConstraint = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 10)
         let verticalConstraint = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)

         NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
    }
}
