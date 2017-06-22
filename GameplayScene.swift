//
//  GameplayScene.swift
//  JackTheGiant
//
//  Created by Dylan Cunningham on 6/18/17.
//  Copyright © 2017 Dylan Cunningham. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var cloudsController = CloudsController()
    
    var mainCamera: SKCameraNode?
    
    var bg1: Background?
    var bg2: Background?
    var bg3: Background?
    
    var player: Player?
    
    var canMove = false
    var moveLeft = false
    
    var center: CGFloat?
    
    let distanceBetClouds = CGFloat(450)
    let minX = CGFloat(-237)
    let maxX = CGFloat(237)
    
    override func didMove(to view: SKView) {
        initVariables()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveCamera()
        managePlayer()
        manageBackgrounds()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.x > center! {
                moveLeft = false
                player?.animatePlayer(moveLeft: moveLeft)
            } else {
                moveLeft = true
                player?.animatePlayer(moveLeft: moveLeft)
            }
        }
        
        canMove = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    func initVariables() {
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        print("\(center)")
        
        player = self.childNode(withName: "Player") as? Player!
        player?.initPlayerAndAnimations()
        
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode!
        
        getBackgrounds()
        cloudsController.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetClouds, center: center!, minX: minX, maxX: maxX, initialClouds: true)
    }
    
    func getBackgrounds() {
        bg1 = self.childNode(withName: "BG1") as? Background!
        bg2 = self.childNode(withName: "BG2") as? Background!
        bg3 = self.childNode(withName: "BG3") as? Background!
    }
    
    func managePlayer() {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
    }
    
    func moveCamera() {
        self.mainCamera?.position.y -= 4
    }
    
    func manageBackgrounds() {
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
    }
}
