//
//  Direction.swift
//  PongV2
//
//  Created by Jørgen Valstad on 10.02.15.
//  Copyright (c) 2015 Jørgen Valstad. All rights reserved.
//

enum Direction : Printable{
    case Left, Right
    
    var description : String {
        switch self {
        case .Left : return "Left"
        case .Right : return "Right"
        }
    }
    
    func returnWall() -> UInt32 {
        switch self {
        case .Left : return PhysicsCategory.leftWall
        case .Right : return PhysicsCategory.rightWall
        }
    }
}
