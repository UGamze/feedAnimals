//
//  GameElements.swift
//  feedAnimals
//
//  Created by Gamze Ulucan on 05.08.17.
//  Copyright © 2017 Gamze Ulucan. All rights reserved.
//

import SpriteKit

struct CollisionBitMask {
    static let heinzCategory:UInt32 = 0x1 << 0
    static let pillarCategory:UInt32 = 0x1 << 1
    static let flowerCategory:UInt32 = 0x1 << 2
    static let groundCategory:UInt32 = 0x1 << 3
}

extension GameScene {
    /*
    func createHeinz() -> SKSpriteNode {
        //1
        let heinz = SKSpriteNode(texture: SKTextureAtlas(named:"farmer").textureNamed("farmer"))
        heinz.size = CGSize(width: 50, height: 50)
        heinz.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        /** 
        //2
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.width / 2)
        bird.physicsBody?.linearDamping = 1.1
        bird.physicsBody?.restitution = 0
        //3
        bird.physicsBody?.categoryBitMask = CollisionBitMask.heinzCategory
        bird.physicsBody?.collisionBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.groundCategory
        bird.physicsBody?.contactTestBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.flowerCategory | CollisionBitMask.groundCategory
        //4
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        **/
        
        return heinz
    }
    */
}
