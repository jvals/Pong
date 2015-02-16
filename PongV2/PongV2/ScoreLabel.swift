//
//  ScoreLabel.swift
//  PongV2
//
//  Created by Jørgen Valstad on 10.02.15.
//  Copyright (c) 2015 Jørgen Valstad. All rights reserved.
//

import SpriteKit

class ScoreLabel : SKLabelNode {
    override init() {
        super.init()
        self.fontName = "Menlo-Regular"
        self.text = "0"
        self.fontColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
