//
//  Paddle.swift
//  Pong2
//
//  Created by Jørgen Valstad on 10.02.15.
//  Copyright (c) 2015 Jørgen Valstad. All rights reserved.
//

import SpriteKit

class Paddle: SKSpriteNode {
    
    override init() {
        super.init(texture: nil, color: UIColor.whiteColor(), size: CGSize(width: 10, height: 40))
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        if let physics = self.physicsBody {
            physics.dynamic = false
            physics.friction = 0.0
            physics.categoryBitMask = PhysicsCategory.paddle
            
            // precisecollisiondetection yields better results when the game gets fast
            physics.usesPreciseCollisionDetection = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
