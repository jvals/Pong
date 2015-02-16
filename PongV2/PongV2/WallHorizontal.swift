//
//  Wall.swift
//  Pong2
//
//  Created by Jørgen Valstad on 10.02.15.
//  Copyright (c) 2015 Jørgen Valstad. All rights reserved.
//

import SpriteKit

class HorizontalWall: SKSpriteNode {
    override init() {
        super.init(texture: nil, color: UIColor.whiteColor(), size: CGSize(width: 800, height: 10))
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        if let physics = self.physicsBody {
            physics.dynamic = false
            physics.friction = 0.0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
