//
//  Background.swift
//  JackTheGiant
//
//  Created by Dylan Cunningham on 6/21/17.
//  Copyright © 2017 Dylan Cunningham. All rights reserved.
//

import SpriteKit


class Background: SKSpriteNode {
    
    func moveBG(camera: SKCameraNode) {
        if self.position.y - self.size.height - 10 > camera.position.y {
            self.position.y -= self.size.height * 3
        }
    }
    
}
