//
//  Ball.swift
//  Pong2
//
//  Created by Jørgen Valstad on 10.02.15.
//  Copyright (c) 2015 Jørgen Valstad. All rights reserved.
//

import SpriteKit

// Global instantiation of Ball class
private let _ball = Ball()

class Ball : SKSpriteNode {
    
    // Method for retrieving the singleton
    class var getSingletonBall : Ball {
        return _ball
    }
    // private token prevents usage of initializer
    private override init() {
        super.init(texture: nil, color: UIColor.whiteColor(), size: CGSize(width: 10, height: 10))
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.friction = 0.0
            physics.linearDamping = 0.0
            physics.restitution = 1.0
            physics.allowsRotation = false
            physics.angularDamping = 0.0
            
            physics.categoryBitMask = PhysicsCategory.ball
            physics.contactTestBitMask = PhysicsCategory.leftWall | PhysicsCategory.rightWall | PhysicsCategory.paddle
            
            // precisecollisiondetection yields better results when the game gets fast
            physics.usesPreciseCollisionDetection = true
            
        }
    }
    
    func getBallDirection() -> Direction {
        if self.physicsBody?.velocity.dx < 0 {
            return Direction.Right
        }
        else {
            return Direction.Left
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
