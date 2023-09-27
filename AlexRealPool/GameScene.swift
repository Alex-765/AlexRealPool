//
//  GameScene.swift
//  AlexRealPool
//
//  Created by Alexander Bater on 27/09/2023.
//
//import GameplayKit

import SpriteKit

class Ball: SKSpriteNode{
}

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor.black

        
        let table = SKSpriteNode(imageNamed: "PoolTable")
        
        table.size = view.frame.size
        table.position = CGPoint(x: frame.midX, y: frame.midY)
        table.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        table.zPosition = -1
        addChild(table)
        
        //        Table Sprite create and set up
        
        let redBallTexture = SKTexture(imageNamed: "RedBall")
        let blueBallTexture = SKTexture(imageNamed: "BlueBall")
        
//
//
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

 
#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {
   
}
#endif

