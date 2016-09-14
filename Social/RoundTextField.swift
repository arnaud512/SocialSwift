//
//  FancyVue.swift
//  Social
//
//  Created by Arnaud Dupuy on 14/09/2016.
//  Copyright © 2016 Arnaud Dupuy. All rights reserved.
//

import UIKit

class RoundTextField: UITextField {
    
    func frameRadius() -> CGFloat {
        return min(self.frame.height,self.frame.width) / 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frameRadius()
        layer.borderWidth = 2
        layer.borderColor = PRIMARY_COLOR.cgColor
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: frameRadius(), dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: frameRadius(), dy: 0)
    }
    
}
