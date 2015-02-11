//
//  GameScene.swift
//  Pong2
//
//  Created by Jørgen Valstad on 10.02.15.
//  Copyright (c) 2015 Jørgen Valstad. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //----------------Variables/Constants----------------------
    
    private let ball = Ball.getSingletonBall
    
    private var p1Score : Int = 0
    private var p2Score : Int = 0
    
    private var hits : CGFloat = 0.0
    
    private let p1ScoreLabel = ScoreLabel()
    private let p2ScoreLabel = ScoreLabel()
    
    private let leftPaddle = Paddle()
    private let rightPaddle = Paddle()
    
    private let topWall = HorizontalWall()
    private let groundWall = HorizontalWall()
    private let rightWall = VerticalWall(direction: Direction.Right)
    private let leftWall = VerticalWall(direction: Direction.Left)
    
    
    //----------------The scene constructor--------------------

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // Delegate contactphysics to the gamescene
        physicsWorld.contactDelegate = self
        
        //Set the backgorund to a black color
        self.backgroundColor = UIColor.blackColor()
    
        
        //Layout
        p1ScoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame)-40, y: CGRectGetMaxY(self.frame)-60)
        p2ScoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame)+40, y: CGRectGetMaxY(self.frame)-60)
        
        topWall.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMaxY(self.frame) - 20)
        groundWall.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMinY(self.frame) + 20)
        rightWall.position = CGPoint(x: CGRectGetMaxX(self.frame), y: CGRectGetMidY(self.frame))
        leftWall.position = CGPoint(x: CGRectGetMinX(self.frame), y: CGRectGetMidY(self.frame))
        
        leftPaddle.position = CGPoint(x: CGRectGetMinX(self.frame)+20, y: CGRectGetMidY(self.frame))
        rightPaddle.position = CGPoint(x: CGRectGetMaxX(self.frame)-20, y: CGRectGetMidY(self.frame))
        
        ball.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))

        
        //Add
        self.addChild(p1ScoreLabel)
        self.addChild(p2ScoreLabel)
        self.addChild(topWall)
        self.addChild(groundWall)
        self.addChild(rightWall)
        self.addChild(leftWall)
        self.addChild(leftPaddle)
        self.addChild(rightPaddle)
        self.addChild(ball)
        
        // Initial impulse
        ball.physicsBody?.applyImpulse(CGVectorMake(-2, 0))
        
    }
    
    //----------------Paddle movement--------------------------
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        leftPaddle.position.y = touches.anyObject()!.locationInNode(self).y
    }
    
    //----------------Contact Handling-------------------------
    
    func didBeginContact(contact: SKPhysicsContact) {
        let ballBody = contact.bodyA.categoryBitMask == PhysicsCategory.ball ? contact.bodyA : contact.bodyB
        let otherBody = contact.bodyA.categoryBitMask == PhysicsCategory.ball ? contact.bodyB : contact.bodyA
        
        //ball collides with the left side wall
        if (otherBody.categoryBitMask == PhysicsCategory.leftWall) {
            p2Score += 1
            p2ScoreLabel.text = String(p2Score)
            
            resetBallPosition()
            if !checkVictory() {
                ball.physicsBody?.applyImpulse(CGVectorMake(2, 0))
            }
            return()
        }
        //ball collides with the right side wall
        else if (otherBody.categoryBitMask == PhysicsCategory.rightWall) {
            p1Score += 1
            p1ScoreLabel.text = String(p1Score)
            
            resetBallPosition()
            if !checkVictory(){
                ball.physicsBody?.applyImpulse(CGVectorMake(-2, 0))
            }
            return()
        }
        //ball collides with a paddle
        else if (otherBody.categoryBitMask == PhysicsCategory.paddle) {
            // add some horizontal speed for every paddle hit
            if abs(ball.physicsBody!.velocity.dx) < 1100 {
                switch ball.getBallDirection() {
                case .Left : ball.physicsBody?.velocity.dx += 25
                case .Right : ball.physicsBody?.velocity.dx -= 25
                }
            }

            
            //the ball's velocity in the y-direction should depend on it's vertical offset from the paddles center
            let offset = calculateVerticalOffset()
            ball.physicsBody?.velocity.dy = offset
        }
        
        // move the ai paddle
        moveEnemyPaddleToPredictedPoint()
    }
    
    
    
    //----------------Helper Functions-------------------------
    
    private func checkVictory() -> Bool {
        if p1Score == 21 || p2Score == 21 {
            resetBallPosition()
            
            let victoryLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
            victoryLabel.runAction(SKAction.moveTo(CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)), duration: 0.0))
            victoryLabel.fontColor = UIColor.redColor()
            self.addChild(victoryLabel)
            
            if (p1Score == 21) {
                victoryLabel.text = "Player one is the victor"
            }
            else {
                victoryLabel.text = "Player two is the victor"
            }
            return true
        }
        else {
            return false
        }
    }
    
    private func resetBallPosition() {
        ball.runAction(SKAction.moveTo(CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)), duration: 0.0))
        ball.physicsBody?.velocity = CGVectorMake(0, 0)
        
        centerEnemyPaddle()
    }
    
    private func centerEnemyPaddle() {
        // Using a key will/should cancel any other action with the same key
        rightPaddle.runAction(SKAction.moveToY(CGRectGetMidY(self.frame), duration: 0.0), withKey: "rightPaddleMoving")
    }
    
    private func moveEnemyPaddleToPredictedPoint() {
        let A = (ball.physicsBody!.velocity.dy) / (ball.physicsBody!.velocity.dx)
        let B = ball.position.y
        let X = rightPaddle.position.x - ball.position.x
        // y = AX + B
        var predictedY = (A * X) + B
        
        // Check to see if the ball is heading towards a point higher/lower than the bounds
        if (predictedY > topWall.position.y) {
            predictedY = topWall.position.y - rightPaddle.size.height - 1
        }
        else if (predictedY < groundWall.position.y) {
            predictedY = groundWall.position.y + rightPaddle.size.height + 1
        }
        
        let interval : NSTimeInterval = (-1 / 8) * Double(p1Score) + 3.0
        rightPaddle.runAction(SKAction.moveToY(predictedY, duration: interval), withKey: "rightPaddleMoving")
    }
    
    private func calculateVerticalOffset() -> CGFloat {
        var offset : CGFloat
        
        switch ball.getBallDirection() {
            case .Left : offset = ball.position.y - leftPaddle.position.y
            case .Right : offset = ball.position.y - rightPaddle.position.y
        }
        return offset * offset
    } 
}