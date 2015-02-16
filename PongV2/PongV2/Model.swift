//
//  model.swift
//  PongV2
//
//  Created by Jørgen Valstad on 11.02.15.
//  Copyright (c) 2015 Jørgen Valstad. All rights reserved.
//

import SpriteKit

class Model {
    var ballPosition : CGPoint! //{ didSet { println("Ballposition was changed to \(ballPosition)") } }
    var leftPaddlePosition : CGPoint! //{ didSet { println("leftPaddlePosition was changed to \(leftPaddlePosition)") } }
    var rightPaddlePosition : CGPoint! //{ didSet { println("rightPaddlePosition was changed to \(rightPaddlePosition)") } }
    var p1Score : Int! { didSet { println("p1Score was changed to \(p1Score)") } }
    var p2Score : Int! { didSet { println("p2Score was changed to \(p2Score)") } }
    
    init(ballPosition : CGPoint, leftPaddlePosition : CGPoint, rightPaddlePosition : CGPoint, p1Score : Int, p2Score : Int) {
        self.ballPosition = ballPosition
        self.leftPaddlePosition = leftPaddlePosition
        self.rightPaddlePosition = rightPaddlePosition
        self.p1Score = p1Score
        self.p2Score = p2Score
    }
    
    
}
