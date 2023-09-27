//
//  GameScene.swift
//  AlexRealPool
//
//  Created by Alexander Bater on 27/09/2023.
//
//import GameplayKit

import SpriteKit

class Ball: SKSpriteNode {
    // Initialize the Ball with a size of 5x5
    init(texture: SKTexture?) {
        let size = CGSize(width: 15, height: 15) // Set the size to 5x5
        
        super.init(texture: texture, color: .clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
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
        
        //Table Sprite create and set up
        
        let redBallTexture = SKTexture(imageNamed: "RedBall")
        let blueBallTexture = SKTexture(imageNamed: "BlueBall")
        
        // Create and position 7 red balls

        
        for i in 1...7 {
            let redBall = Ball(texture: redBallTexture)
            redBall.position = CGPoint(x: (frame.midX + CGFloat(i*10+50)), y: (frame.midY + 10.0))
            addChild(redBall)
        }
            
        // Create and position 7 blue balls
        for i in 1...7 {
            let blueBall = Ball(texture: blueBallTexture)
            blueBall.position = CGPoint(x: (frame.midX + CGFloat(i*10+50)), y: frame.midY )
            addChild(blueBall)
                }
        }
}


 
#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {
   
}
#endif

