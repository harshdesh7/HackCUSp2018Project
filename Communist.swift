//
//  Communist.swift
//  HackCU4_Fail
//
//  Created by  Harsh Deshpande on 2/25/18.
//  Copyright © 2018 hdeshpande. All rights reserved.
//

import SpriteKit
import GameplayKit

class Communist:SKSpriteNode{
    
    let noCategory:UInt32 = 0
    let laserCategory:UInt32 = 0b1
    let playerCategory:UInt32 = 0b1 << 1
    let enemyCategory:UInt32 = 0b1 << 2
    let itemCategory:UInt32 = 0b1 << 3
    
    
    func spawnLaser() {
        let scene:SKScene = SKScene(fileNamed: "Laser")!
        let laser = scene.childNode(withName: "laser")
        laser?.position = self.position
        laser?.move(toParent: self)
        laser?.physicsBody?.categoryBitMask = laserCategory
        laser?.physicsBody?.collisionBitMask = noCategory
        laser?.physicsBody?.contactTestBitMask = enemyCategory
    }

}



