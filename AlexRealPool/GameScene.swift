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
        let size = CGSize(width:20, height: 20)
        
        super.init(texture: texture, color: .clear, size: size)
        self.zPosition = 1
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.restitution = 0.95
        self.physicsBody?.collisionBitMask = 0b0001
        self.physicsBody?.linearDamping = 0.1
        
        self.physicsBody?.allowsRotation = false
        
        
    }
    func updateSpeed(){
        guard let velocity = self.physicsBody?.velocity
        else{
            return
        }
        let speeds = sqrt(pow(velocity.dx, 2.0) + pow(velocity.dy, 2.0))
            if speeds < 0.5 && speeds > 0 {
                self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
}

class GameScene: SKScene {
    
    var gameStarted: Bool!
    var cueBall: Ball!
    var redBall: Ball!
    var blueBall: Ball!
    var blackBall: Ball!
    var cueStick: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        
        let point1 = CGPoint(x:380, y:140)
        let point2 = CGPoint(x:380, y:-140)
        let point3 = CGPoint(x:-380, y: 140)
        let point4 = CGPoint(x:-380, y: -140)
        
        let wall1 = SKNode()
        wall1.physicsBody = SKPhysicsBody(edgeFrom: point1, to: point2)
//        wall1.physicsBody?.usesPreciseCollisionDetection = true
        wall1.physicsBody?.restitution = 1
        wall1.physicsBody?.collisionBitMask = 0b0001
        
        
        addChild(wall1)

        
        let wall2 = SKNode()
        wall2.physicsBody = SKPhysicsBody(edgeFrom: point2, to: point4)
//        wall2.physicsBody?.usesPreciseCollisionDetection = true
        wall2.physicsBody?.restitution = 1
        wall2.physicsBody?.collisionBitMask = 0b0001
        addChild(wall2)
        
        let wall3 = SKNode()
        wall3.physicsBody = SKPhysicsBody(edgeFrom: point1, to: point3)
//        wall3.physicsBody?.usesPreciseCollisionDetection = true
        wall3.physicsBody?.restitution = 1
        wall3.physicsBody?.collisionBitMask = 0b0001
        addChild(wall3)
        
        let wall4 = SKNode()
        wall4.physicsBody = SKPhysicsBody(edgeFrom: point3, to: point4)
        wall4.physicsBody?.usesPreciseCollisionDetection = true
        wall4.physicsBody?.restitution = 1
        wall4.physicsBody?.collisionBitMask = 0b0001
        addChild(wall4)
        
        self.physicsBody?.linearDamping = 0
        

        // Table set up
        
        let table = SKSpriteNode(imageNamed: "PoolTable")
        
        table.size = view.frame.size
        table.position = CGPoint(x: frame.midX, y: frame.midY)
        table.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        table.zPosition = -1
        
        addChild(table)
        
        // Create Red and Blue Ball Textures

        let redBallTexture = SKTexture(imageNamed: "BlueBall")
        let blueBallTexture = SKTexture(imageNamed: "BlueBall")
        let cueBallTexture = SKTexture(imageNamed: "RedBall")
        let blackBallTexture = SKTexture(imageNamed: "BlueBall")

        
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
        
        let gameStarted = true
        
        cueBall.physicsBody?.velocity = self.physicsBody!.velocity
        cueBall.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
        
        
        let cueStickTexture = SKTexture(imageNamed: "CueStick")
        let cueStick = SKSpriteNode(texture: cueStickTexture)
        addChild(cueStick)

        cueStick.position = cueBall.position
        let moveAction: SKAction = SKAction.moveBy(x: -110, y: 0, duration: 0)
        cueStick.run(moveAction)
        cueStick.zPosition = 0
        cueStick.size = CGSize(width: 200, height: 150)

        }
    
    override func update(_ currentTime: TimeInterval){
        
        if gameStarted == true{
            cueBall.physicsBody?.applyImpulse(CGVector(dx: 1, dy: 0))
            if let cueBall = cueBall{
                cueBall.updateSpeed()
                
                if cueBall.physicsBody?.velocity == CGVector(dx: 0, dy: 0){
                    cueStick.isHidden = false
                }
                else{
                    cueStick.isHidden = true
                }
            }
        }
    }
    
}





#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {
   
}
#endif

