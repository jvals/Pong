//
//  model.swift
//  Pong2
//
//  Created by Jørgen Valstad on 11.02.15.
//  Copyright (c) 2015 Jørgen Valstad. All rights reserved.
//

import SpriteKit

class Model {
    var ballPosition : CGPoint! {
        didSet {
            println("Ballposition was changed")
        }
    }
    var leftPaddlePosition : CGPoint!
    var rightPaddlePosition : CGPoint!
    var p1Score : Int!
    var p2Score : Int!
    
    init(ballPosition : CGPoint, leftPaddlePosition : CGPoint, rightPaddlePosition : CGPoint, p1Score : Int, p2Score : Int) {
        self.ballPosition = ballPosition
        self.leftPaddlePosition = leftPaddlePosition
        self.rightPaddlePosition = rightPaddlePosition
        self.p1Score = p1Score
        self.p2Score = p2Score
    }
    
    
}
