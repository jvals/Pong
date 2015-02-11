//
//  VWall.swift
//  Pong2
//
//  Created by Jørgen Valstad on 10.02.15.
//  Copyright (c) 2015 Jørgen Valstad. All rights reserved.
//

import SpriteKit

class VerticalWall: SKSpriteNode {
    override init() {
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSize(width: 10, height: 400))
    }
    
    convenience init(direction : Direction) {
        self.init()
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        if let physics = self.physicsBody {
            physics.dynamic = false
            physics.friction = 0.0
            
            physics.categoryBitMask = direction.returnWall()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
