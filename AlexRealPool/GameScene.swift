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
        
        // Create Red and Blue Ball Textures

        let redBallTexture = SKTexture(imageNamed: "RedBall")
        let blueBallTexture = SKTexture(imageNamed: "BlueBall")
        let cueBallTexture = SKTexture(imageNamed: "RedBall")
        let blackBallTexture = SKTexture(imageNamed: "RedBall")

        
        // Creating Break Positions
        
        let redBallPositions: [(CGFloat, CGFloat)]  = [
            (155, -20),
            (155, 20),
            (175, -10),
            (175, 30),
            (195, -20),
            (195, 20),
            (235, 0)
        ]
        
        let blueBallPositions: [(CGFloat, CGFloat)]  = [
            (155, -40),
            (155, 0),
            (155, 40),
            (175, -30),
            (175, 10),
            (215, -10),
            (215, 10)
        ]
        
        // Placing Balls in Break Positions
        
        for (x,y) in blueBallPositions {
            let blueBall = Ball(texture: blueBallTexture)
            blueBall.position = CGPoint(x: (frame.midX + x), y:(frame.midY + y))
            addChild(blueBall)
        }
        for (x,y) in redBallPositions {
            let redBall = Ball(texture: redBallTexture)
            redBall.position = CGPoint(x: (frame.midX + x), y:(frame.midY + y))
            addChild(redBall)
        }
        
        let cueBall = Ball(texture: cueBallTexture)
        cueBall.position = CGPoint(x: (frame.midX + 195), y:(frame.midY))
        addChild(cueBall)
        
        let blackBall = Ball(texture: blackBallTexture)
        blackBall.position = CGPoint(x: (frame.midX - 195), y:(frame.midY))
        addChild(blackBall)
    
        
        
//       Main Menu, Images
//       Creation of Wall
        
        
        }
}




#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {
   
}
#endif

