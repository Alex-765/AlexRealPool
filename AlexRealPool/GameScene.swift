//
//  GameScene.swift
//  AlexRealPool
//
//  Created by Alexander Bater on 27/09/2023.
//
//import GameplayKit

import SpriteKit

class Ball: SKSpriteNode {
    // Initialize the Ball with a size of 20x20
    init(texture: SKTexture?) {
        let size = CGSize(width: 20, height: 20)
        
        super.init(texture: texture, color: .clear, size: size)
        self.zPosition = 1
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.restitution = 1
//        self.physicsBody?.collisionBitMask = 0b0001
//        self.physicsBody?.mass = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
}

//class Wall: SKPhysicsBody {
//    init(edgeFrom p1: CGPoint,
//         to p2: CGPoint){
//        
//        let point1 = CGPoint(x:800, y:100)
//        let point2 = CGPoint(x:800, y:10)
//        super.init(edgeFrom: point1, to: point2)
//        
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("Error")
//    }
//}


class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.friction = 0.5
        
//        About Collisions and contacts
        
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
            (235, -20),
            (235, 20),
            (215, -10),
            (215, 30),
            (195, -20),
            (195, 20),
            (155, 0)
        ]
        
        let blueBallPositions: [(CGFloat, CGFloat)]  = [
            (235, -40),
            (235, 0),
            (235, 40),
            (215, -30),
            (215, 10),
            (175, -10),
            (175, 10)
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
        cueBall.position = CGPoint(x: (frame.midX - 195), y:(frame.midY))
        addChild(cueBall)
        
        let blackBall = Ball(texture: blackBallTexture)
        blackBall.position = CGPoint(x: (frame.midX + 195), y:(frame.midY))
        addChild(blackBall)
        
        cueBall.physicsBody?.velocity = self.physicsBody!.velocity
        cueBall.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 0))
        
//       Main Menu, Images
//       Creation of Wall
        
        
        }
}




#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {
   
}
#endif

