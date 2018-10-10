//
//  MyFigure.swift
//  MotionCube
//
//  Created by Yaroslav Zakharchuk on 10/10/18.
//  Copyright © 2018 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation
import UIKit

class MyFigure: UIView {
    private let color = Figures.colors
    private let form = Figures.forms
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.layer.shadowColor = UIColor.black.cgColor
        super.layer.shadowOpacity = 1
        super.layer.shadowOffset = CGSize.zero
        super.layer.shadowRadius = 10
        super.layer.shouldRasterize = true
        setRandForm()
        setRandColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRandColor() {
        super.backgroundColor = color[Int(arc4random_uniform(UInt32(color.count)))]
    }
    
    func setRandForm() {
        let randForm = form[Int(arc4random_uniform(UInt32(form.count)))]
        if randForm == .circle {
            super.layer.cornerRadius = frame.width / 2
            super.clipsToBounds = true
        } else {
            super.clipsToBounds = false
        }
    }
}
