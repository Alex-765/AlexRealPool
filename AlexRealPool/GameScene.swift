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
        let size = CGSize(width: 20, height: 20) // Set the size to 5x5
        
        super.init(texture: texture, color: .clear, size: size)
        self.zPosition = 1
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.restitution = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
}

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        // Table set up
        
        let table = SKSpriteNode(imageNamed: "PoolTable")
        
        table.size = view.frame.size
        table.position = CGPoint(x: frame.midX, y: frame.midY)
        table.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        table.zPosition = -1
        addChild(table)
        
        // Create and position red and blue balls in break position

    
        let redBallTexture = SKTexture(imageNamed: "RedBall")
        let blueBallTexture = SKTexture(imageNamed: "BlueBall")
        
 
        for i in 0...1 {
            let redBall = Ball(texture: redBallTexture)
            redBall.position = CGPoint(x: (frame.midX + CGFloat(155)), y: (frame.midY + CGFloat(i*40)-20))
            addChild(redBall)
            }
        
        for i in 0...2 {
            let blueBall = Ball(texture: blueBallTexture)
            blueBall.position = CGPoint(x: (frame.midX + CGFloat(155)), y:(frame.midY + CGFloat(i*40)-40))
                
            addChild(blueBall)
            }
        
        let cueBall = SKSpriteNode(imageNamed: "CueBall")
        let blackBall = SKSpriteNode(imageNamed: "Black Ball")
    
//       Creation of Wall
        
        
        }
}

//Fix images
//Break position
//Screenshots



#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {
   
}
#endif

