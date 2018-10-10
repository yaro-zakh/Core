//
//  ColorFigure.swift
//  MotionCube
//
//  Created by Yaroslav Zakharchuk on 10/9/18.
//  Copyright © 2018 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation
import UIKit

struct Figures {
    enum Forms {
        case square
        case circle
    }
    static let colors: [UIColor] = [UIColor(red:0.94, green:0.33, blue:0.31, alpha:1.0),
                                   UIColor(red:0.73, green:0.41, blue:0.78, alpha:1.0),
                                   UIColor(red:0.67, green:0.71, blue:1.00, alpha:1.0),
                                   UIColor(red:0.47, green:0.33, blue:0.28, alpha:1.0),
                                   UIColor(red:0.50, green:0.87, blue:0.92, alpha:1.0),
                                   UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.0),
                                   UIColor(red:0.51, green:0.78, blue:0.52, alpha:1.0),
                                   UIColor(red:1.00, green:0.95, blue:0.46, alpha:1.0),
                                   UIColor(red:1.00, green:0.72, blue:0.30, alpha:1.0),
                                   UIColor(red:1.00, green:0.34, blue:0.13, alpha:1.0)]
    
    static let forms: [Forms] = [.square, .circle]
}

