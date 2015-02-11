//
//  PhysicsCategory.swift
//  Pong2
//
//  Created by Jørgen Valstad on 10.02.15.
//  Copyright (c) 2015 Jørgen Valstad. All rights reserved.
//


struct PhysicsCategory {
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let leftWall     : UInt32 = 0b1      //1
    static let rightWall    : UInt32 = 0b10     //2
    static let ball         : UInt32 = 0b11    //3
    static let paddle       : UInt32 = 0b100 //4
}