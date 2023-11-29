//
//  GameScene.swift
//  AlexRealPool
//
//  Created by Alexander Bater on 27/09/2023.
//
//import GameplayKit

import SpriteKit

class Ball: SKSpriteNode {
    init(texture: SKTexture?) {
        let size = CGSize(width:20, height: 20)
        
        super.init(texture: texture, color: .clear, size: size)
        self.zPosition = 1
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.restitution = 1
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
            if speeds < 1 && speeds > 0 {
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
    var rightButton: SKSpriteNode!
    var leftButton: SKSpriteNode!
    var powerButton: SKSpriteNode!
    var power: CGFloat!
    var numberOne: SKSpriteNode!
    var numberTwo: SKSpriteNode!
    var numberThree: SKSpriteNode!
    var numberFour: SKSpriteNode!
    var numberFive: SKSpriteNode!
    var chosen: Int!
    var fire: SKLabelNode!
    
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
            blueBall = Ball(texture: blueBallTexture)
            blueBall.position = CGPoint(x: (frame.midX + x), y:(frame.midY + y))
            addChild(blueBall)
        }
        
        
        for (x,y) in redBallPositions {
            redBall = Ball(texture: redBallTexture)
            redBall.position = CGPoint(x: (frame.midX + x), y:(frame.midY + y))
            addChild(redBall)
        }

        
        cueBall = Ball(texture: cueBallTexture)
        cueBall.position = CGPoint(x: (frame.midX - 195), y:(frame.midY))
        addChild(cueBall)
        
        blackBall = Ball(texture: blackBallTexture)
        blackBall.position = CGPoint(x: (frame.midX + 195), y:(frame.midY))
        addChild(blackBall)
    
        
        cueBall.physicsBody?.velocity = self.physicsBody!.velocity
        cueBall.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
        
        
        let cueStickTexture = SKTexture(imageNamed: "CueStick")
        cueStick = SKSpriteNode(texture: cueStickTexture)
        addChild(cueStick)

        cueStick.position = cueBall.position
        cueStick.zPosition = 0
        cueStick.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        cueStick.size = CGSize(width: 200, height: 150)
    
        
        let rightTexture = SKTexture(imageNamed: "right")
        rightButton = SKSpriteNode(texture: rightTexture)
        rightButton.zPosition = 2
        rightButton.size = CGSize(width: 35, height: 33)
        rightButton.position = CGPoint(x: frame.midX + 45, y:frame.midY + 177)
        addChild(rightButton)
        
        let leftTexture = SKTexture(imageNamed: "left")
        leftButton = SKSpriteNode(texture: leftTexture)
        leftButton.zPosition = 2
        leftButton.size = CGSize(width: 35, height: 33)
        leftButton.position = CGPoint(x: frame.midX - 45, y:frame.midY + 177)
        addChild(leftButton)
        
        gameStarted = true
        
        let oneTexture = SKTexture(imageNamed: "1")
        numberOne = SKSpriteNode(texture: oneTexture)
        numberOne.size = CGSize(width: 35, height: 30)
        numberOne.position = CGPoint(x: frame.midX + 405, y:frame.midY - 105)
        addChild(numberOne)
        
        let twoTexture = SKTexture(imageNamed: "2")
        numberTwo = SKSpriteNode(texture: twoTexture)
        numberTwo.size = CGSize(width: 38, height: 38)
        numberTwo.position = CGPoint(x: frame.midX + 405, y:frame.midY - 50)
        addChild(numberTwo)
        
        let threeTexture = SKTexture(imageNamed: "3")
        numberThree = SKSpriteNode(texture: threeTexture)
        numberThree.size = CGSize(width:40, height: 45)
        numberThree.position = CGPoint(x: frame.midX + 405, y:frame.midY - 5)
        addChild(numberThree)
        
        let fourTexture = SKTexture(imageNamed: "4")
        numberFour = SKSpriteNode(texture: fourTexture)
        numberFour.size = CGSize(width: 50, height: 45)
        numberFour.position = CGPoint(x: frame.midX + 405, y:frame.midY + 40)
        addChild(numberFour)
        
        let fiveTexture = SKTexture(imageNamed: "5")
        numberFive = SKSpriteNode(texture: fiveTexture)
        numberFive.size = CGSize(width: 30, height: 25)
        numberFive.position = CGPoint(x: frame.midX + 405, y:frame.midY + 75)
        addChild(numberFive)
        
        fire = SKLabelNode(fontNamed: "Impact")
        fire.text = "Fire"
        fire.fontColor = .red
        fire.position = CGPoint(x: frame.midX + 405, y: frame.midY + 105)
        fire.fontSize = 22
        fire.zPosition = 2
        addChild(fire)
        
        }
    
    
    override func update(_ currentTime: TimeInterval){
        
        if gameStarted == true{
            if let cueBall = cueBall{
                cueBall.updateSpeed()
                if cueBall.physicsBody?.velocity == CGVector(dx: 0, dy: 0){
                    cueStick.position = cueBall.position
                    cueStick.isHidden = false
                    cueBall.physicsBody?.applyImpulse(CGVector(dx:0, dy: 0))
                }
                else{
                    cueStick.isHidden = true
                }
            }
            if chosen == 1{
                numberOne.isHidden = true
            }
            else{
                numberOne.isHidden = false
            }
            if chosen == 2{
                numberTwo.isHidden = true
            }
            else{
                numberTwo.isHidden = false
            }
            if chosen == 3{
                numberThree.isHidden = true
            }
            else{
                numberThree.isHidden = false
            }
            if chosen == 4{
                numberFour.isHidden = true
            }
            else{
                numberFour.isHidden = false
            }
            if chosen == 5{
                numberFive.isHidden = true
            }
            else{
                numberFive.isHidden = false
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
            if leftButton.contains(touchLocation) {
                cueStick.zRotation = cueStick.zRotation + 0.05
            }
            if rightButton.contains(touchLocation) {
                cueStick.zRotation = cueStick.zRotation - 0.05
            }
            if numberOne.contains(touchLocation) {
                power = 1.0
                chosen = 1
            }
            if numberTwo.contains(touchLocation) {
                power = 2.0
                chosen = 2
            }
            if numberThree.contains(touchLocation) {
                power = 3.0
                chosen = 3
            }
            if numberFour.contains(touchLocation) {
                power = 4.0
                chosen = 4
            }
            if numberFive.contains(touchLocation) {
                power = 5.0
                chosen = 5
            }
            if fire.contains(touchLocation) {
                if power > 1.0{
                    cueBall.physicsBody?.applyImpulse(CGVector(dx: cos(cueStick.zRotation) * power!, dy: sin(cueStick.zRotation) * power!))
                }
            }
        }
    }
    }
