//
//  Player.swift
//  JackTheGiant
//
//  Created by Dylan Cunningham on 6/18/17.
//  Copyright © 2017 Dylan Cunningham. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let Player: UInt32 = 0
    static let Cloud: UInt32 = 1
    static let DarkCloudAndCollectables: UInt32 = 2
}

class Player: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas()
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction()
    
    func initPlayerAndAnimations() {
        textureAtlas = SKTextureAtlas(named: "Player.atlas")
        
        for i in 2...textureAtlas.textureNames.count {
            let name = "Player \(i)"
            playerAnimation.append(SKTexture(imageNamed: name))
        }
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)

        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 50, height: self.size.height - 5))
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        self.physicsBody?.categoryBitMask = ColliderType.Player
        self.physicsBody?.collisionBitMask = ColliderType.Cloud
        self.physicsBody?.contactTestBitMask = ColliderType.DarkCloudAndCollectables
    }
    
    func movePlayer(moveLeft: Bool) {
        
        if moveLeft {
            self.position.x -= 12
        } else {
            self.position.x += 12
        }
        
    }
    
    func animatePlayer(moveLeft: Bool) {
        
        if moveLeft {
            self.xScale = -fabs(self.xScale)
        } else {
            self.xScale = fabs(self.xScale)
        }
        
        self.run(SKAction.repeatForever(animatePlayerAction), withKey: "Animate")
    }
    
    func stopPlayerAnimation() {
        self.removeAction(forKey: "Animate")
        self.texture = SKTexture(imageNamed: "Player 1")
        self.size = (self.texture?.size())!
    }
}
