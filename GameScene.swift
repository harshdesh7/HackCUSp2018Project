//
//  GameScene.swift
//  HackCU4_Fail
//
//  Created by  Harsh Deshpande on 2/24/18.
//  Copyright © 2018 hdeshpande. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: SKSpriteNode?
    var communist1:SKSpriteNode?
    var communist2:SKSpriteNode?
    var communist3: SKSpriteNode?
    var scoreLabel:SKLabelNode?
    var endLabel:SKLabelNode?
    var fireRate:TimeInterval = 0.8
    var timeSinceFire:TimeInterval = 0
    var lastTime:TimeInterval = 0
    var totalTime:TimeInterval = 0.0
    var score:Int = 0;
    var isDead:Bool = false
    var isMoved:Bool = false;
    let noCategory:UInt32 = 0
    let laserCategory:UInt32 = 0b1
    let playerCategory:UInt32 = 0b1 << 1
    let enemyCategory:UInt32 = 0b1 << 2
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        
        player = self.childNode(withName: "ship") as? SKSpriteNode
        player?.physicsBody?.categoryBitMask = playerCategory
        player?.physicsBody?.collisionBitMask = noCategory
        player?.physicsBody?.contactTestBitMask = enemyCategory | laserCategory
        player?.xScale = 0.25
        player?.yScale = 0.25
        
        communist1 = self.childNode(withName: "cyka") as? SKSpriteNode
        communist1?.physicsBody?.categoryBitMask = enemyCategory
        communist1?.physicsBody?.collisionBitMask = noCategory
        communist1?.physicsBody?.contactTestBitMask = playerCategory
        communist1?.xScale = 0.25
        communist1?.yScale = 0.25
        
        communist2 = self.childNode(withName: "blyat") as? SKSpriteNode
        communist2?.physicsBody?.categoryBitMask = enemyCategory
        communist2?.physicsBody?.collisionBitMask = noCategory
        communist2?.physicsBody?.contactTestBitMask = playerCategory
        communist2?.xScale = 0.25
        communist2?.yScale = 0.25

        communist3 = self.childNode(withName: "stalin") as? SKSpriteNode
        communist3?.physicsBody?.categoryBitMask = enemyCategory
        communist3?.physicsBody?.collisionBitMask = noCategory
        communist3?.physicsBody?.contactTestBitMask = playerCategory
        communist3?.xScale = 0.25
        communist3?.yScale = 0.25
        
        scoreLabel = self.childNode(withName: "label") as? SKLabelNode
        scoreLabel?.text = "Score: \(score)"
        
        endLabel = self.childNode(withName: "end") as? SKLabelNode
        totalTime = 0;

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for t in touches {
            player?.position.x = t.location(in: self).x;
        }
        
        isMoved = true;
        totalTime = 0;
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let cA:UInt32 = contact.bodyA.categoryBitMask
        let cB:UInt32 = contact.bodyB.categoryBitMask
        
        if cA == playerCategory || cB == playerCategory {
            let otherNode:SKNode = (cA == playerCategory) ? contact.bodyB.node! : contact.bodyA.node!
            playerDidCollide(with: otherNode)
        }
        else {
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
        }
    }

    func playerDidCollide(with other:SKNode) {
        other.removeFromParent()
        player?.removeFromParent()
        isDead = true
    }

    
    override func update(_ currentTime: TimeInterval) {
        if(isDead == true){
            endLabel?.text = "GAME OVER!!!!!!!"
            return
        }
        checkLaser(currentTime - lastTime)
        lastTime = currentTime
        if(fmod(totalTime.binade, 1) == 0.0 && isMoved == true){
            score = score + 1;
        }
        scoreLabel?.text = "Score: \(score)"
    }
    
    func checkLaser(_ frameRate:TimeInterval) {
        // add time to timer
        timeSinceFire += frameRate
        totalTime += frameRate
        print("Time Passed: \(totalTime)")
        // return if it hasn't been enough time to fire laser
        if ((timeSinceFire < fireRate)||isMoved == false) {
            return
        }
        
        //spawn laser
        spawnLaser()
        
        // reset timer
        timeSinceFire = 0
    }
    
    func spawnLaser() {
        let scene:SKScene = SKScene(fileNamed: "Laser")!
        let laser = scene.childNode(withName: "laser")
        laser?.position = communist1!.position
        laser?.move(toParent: self)
        laser?.physicsBody?.categoryBitMask = laserCategory
        laser?.physicsBody?.collisionBitMask = noCategory
        laser?.physicsBody?.contactTestBitMask = playerCategory
        let scene2:SKScene = SKScene(fileNamed: "Laser")!
        let laser2 = scene2.childNode(withName: "laser")
        laser2?.position = communist2!.position
        laser2?.move(toParent: self)
        laser2?.physicsBody?.categoryBitMask = laserCategory
        laser2?.physicsBody?.collisionBitMask = noCategory
        laser2?.physicsBody?.contactTestBitMask = playerCategory
        let scene3:SKScene = SKScene(fileNamed: "Laser")!
        let laser3 = scene3.childNode(withName: "laser")
        laser3?.position = communist3!.position
        laser3?.move(toParent: self)
        laser3?.physicsBody?.categoryBitMask = laserCategory
        laser3?.physicsBody?.collisionBitMask = noCategory
        laser3?.physicsBody?.contactTestBitMask = playerCategory
    }


}
