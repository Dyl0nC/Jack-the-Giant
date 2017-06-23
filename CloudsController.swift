//
//  CloudsController.swift
//  JackTheGiant
//
//  Created by Dylan Cunningham on 6/22/17.
//  Copyright © 2017 Dylan Cunningham. All rights reserved.
//

import SpriteKit

class CloudsController {
    
    var lastCloudPositionY = CGFloat()
    
    func shuffle(arrayClouds: [SKSpriteNode]) -> [SKSpriteNode] {
        
        var arrayClouds = arrayClouds
        for i in (1...arrayClouds.count - 1).reversed() {
            let j = Int(arc4random_uniform(UInt32(i - 1)))
            
            swap(&arrayClouds[i], &arrayClouds[j])
            
        }

        return arrayClouds
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func createClouds() -> [SKSpriteNode] {
        var cloudsArray = [SKSpriteNode]()
        
        for _ in 0..<2 {
            let cloud1 = SKSpriteNode(imageNamed: "Cloud 1")
            cloud1.name = "1"
            let cloud2 = SKSpriteNode(imageNamed: "Cloud 2")
            cloud2.name = "2"
            let cloud3 = SKSpriteNode(imageNamed: "Cloud 3")
            cloud3.name = "3"
            let darkCloud = SKSpriteNode(imageNamed: "Dark Cloud")
            darkCloud.name = "Dark Cloud"
            
            cloud1.setScale(1.5)
            cloud2.setScale(1.5)
            cloud3.setScale(1.5)
            darkCloud.setScale(1.5)
            
            cloud1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cloud1.size.width - 15, height: cloud1.size.height - 10))
            cloud1.physicsBody?.affectedByGravity = false
            cloud1.physicsBody?.restitution = 0
            cloud1.physicsBody?.categoryBitMask = ColliderType.Cloud
            cloud1.physicsBody?.collisionBitMask = ColliderType.Player
            
            cloud2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cloud2.size.width - 15, height: cloud2.size.height - 10))
            cloud2.physicsBody?.affectedByGravity = false
            cloud2.physicsBody?.restitution = 0
            cloud2.physicsBody?.categoryBitMask = ColliderType.Cloud
            cloud2.physicsBody?.collisionBitMask = ColliderType.Player
            
            cloud3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cloud3.size.width - 15, height: cloud3.size.height - 10))
            cloud3.physicsBody?.affectedByGravity = false
            cloud3.physicsBody?.restitution = 0
            cloud3.physicsBody?.categoryBitMask = ColliderType.Cloud
            cloud3.physicsBody?.collisionBitMask = ColliderType.Player
            
            darkCloud.physicsBody = SKPhysicsBody(rectangleOf: darkCloud.size)
            darkCloud.physicsBody?.affectedByGravity = false
            darkCloud.physicsBody?.categoryBitMask = ColliderType.DarkCloudAndCollectables
            darkCloud.physicsBody?.collisionBitMask = ColliderType.Player
            
            
            cloudsArray.append(cloud1)
            cloudsArray.append(cloud2)
            cloudsArray.append(cloud3)
            cloudsArray.append(darkCloud)
        }
        
        cloudsArray = shuffle(arrayClouds: cloudsArray)
        
        return cloudsArray
    }
    
    func arrangeCloudsInScene( scene: SKScene, distanceBetweenClouds: CGFloat, center: CGFloat, minX: CGFloat, maxX: CGFloat, initialClouds: Bool) {
        
        var clouds = createClouds()
        
        if initialClouds {
            while(clouds[0].name == "Dark Cloud") {
                clouds = shuffle(arrayClouds: clouds)
            }
        }
        
        var positionY = CGFloat()
        
        if initialClouds {
            positionY = center - 100
        } else {
            positionY = lastCloudPositionY
        }
        
        var random = 0
        
        for i in 0...clouds.count - 1 {
            
            var randomX = CGFloat()
            
            if random == 0 {
                randomX = randomBetweenNumbers(firstNum: center + 90, secondNum: maxX)
                random = 1
            } else if random == 1 {
                randomX = randomBetweenNumbers(firstNum: center - 90, secondNum: minX)
                random = 0
            }
            
            clouds[i].position = CGPoint(x: randomX, y: positionY)
            clouds[i].zPosition = 3
            
            scene.addChild(clouds[i])
            positionY -= distanceBetweenClouds
            lastCloudPositionY = positionY
        }
        
        
        
    }
    
}
