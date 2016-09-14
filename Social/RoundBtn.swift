//
//  RoundBtn.swift
//  Social
//
//  Created by Arnaud Dupuy on 14/09/2016.
//  Copyright © 2016 Arnaud Dupuy. All rights reserved.
//

import UIKit

class RoundBtn: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius =  min(self.frame.height,self.frame.width) / 2
    }

}
