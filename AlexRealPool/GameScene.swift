//
//  GameScene.swift
//  AlexRealPool
//
//  Created by Alexander Bater on 27/09/2023.
//

import SpriteKit

class Ball: SKSpriteNode {
    let screenWidth = UIScreen.main.bounds.height
    let screenHeight = UIScreen.main.bounds.width
    
    
    init(texture: SKTexture?) {
        
        let size = CGSize(width:20, height: 20)
        
        super.init(texture: texture, color: .clear, size: size)
        self.zPosition = 2
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
//        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.restitution = 1
        self.physicsBody?.collisionBitMask = 0b0001
        self.physicsBody?.linearDamping = 0.7
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
    var blueBalls: [Ball]!
    var redBalls: [Ball]!
    var blackBall: Ball!
    var cueStick: SKSpriteNode!
    var rightButton: SKSpriteNode!
    var righterButton: SKSpriteNode!
    var leftButton: SKSpriteNode!
    var lefterButton: SKSpriteNode!
    var backButton: SKSpriteNode!
    var powerButton: SKSpriteNode!
    var power: CGFloat!
    var numberOne: SKLabelNode!
    var numberTwo: SKLabelNode!
    var numberThree: SKLabelNode!
    var numberFour: SKLabelNode!
    var numberFive: SKLabelNode!
    var chosen: Int!
    var fire: SKLabelNode!
    var pocket1: SKSpriteNode!
    var pocket2: SKSpriteNode!
    var pocket3: SKSpriteNode!
    var pocket4: SKSpriteNode!
    var pocket5: SKSpriteNode!
    var pocket6: SKSpriteNode!
    var path: SKSpriteNode!
    var paths: [SKSpriteNode]!
    var rotationSpeed: CGFloat!
    var scoreRed: Int!
    var scoreBlue: Int!
    var shotCounter: Int!
    var counter: SKLabelNode!
    
    let screenWidth = UIScreen.main.bounds.height
    let screenHeight = UIScreen.main.bounds.width
    
    
    func transform_x(_ val: Double) -> Double{
        return val//*screenWidth/393
    }
    
    func transform_y(_ val: Double) -> Double{
        return val//*screenHeight/852
    }
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = .black
        let screenWidth = UIScreen.main.bounds.height
        let screenHeight = UIScreen.main.bounds.width
        
        print(screenWidth)
        print(screenHeight)
        
        let point1 = CGPoint(x:transform_x(380), y:transform_y(140))
        let point2 = CGPoint(x:transform_x(380), y:transform_y(-140))
        let point3 = CGPoint(x:transform_x(355), y:transform_y(-161))
        let point4 = CGPoint(x:transform_x(25), y:transform_y(-161))
        let point5 = CGPoint(x:transform_x(-25), y:transform_y(-161))
        let point6 = CGPoint(x:transform_x(-355), y:transform_y(-161))
        let point7 = CGPoint(x:transform_x(-380), y:transform_y(140))
        let point8 = CGPoint(x:transform_x(-380), y:transform_y(-140))
        let point9 = CGPoint(x:transform_x(355), y:transform_y(161))
        let point10 = CGPoint(x:transform_x(25), y:transform_y(161))
        let point11 = CGPoint(x:transform_x(-25), y:transform_y(161))
        let point12 = CGPoint(x:transform_x(-355), y:transform_y(161))
        
        pocket1 = SKSpriteNode(imageNamed: "BlueBall")
        pocket1.size = CGSize(width: 35, height: 30)
        pocket1.position = CGPoint(x: (383), y:(-161))
        pocket2 = SKSpriteNode(imageNamed: "BlueBall")
        pocket2.size = CGSize(width: 35, height: 30)
        pocket2.position = CGPoint(x: (383), y:(161))
        pocket3 = SKSpriteNode(imageNamed: "BlueBall")
        pocket3.size = CGSize(width: 40, height: 1)
        pocket3.position = CGPoint(x: (0), y:(-171))
        pocket4 = SKSpriteNode(imageNamed: "BlueBall")
        pocket4.size = CGSize(width: 40, height: 10)
        pocket4.position = CGPoint(x: (0), y:(171))
        pocket5 = SKSpriteNode(imageNamed: "BlueBall")
        pocket5.size = CGSize(width: 35, height: 30)
        pocket5.position = CGPoint(x: (-383), y:(-161))
        pocket6 = SKSpriteNode(imageNamed: "BlueBall")
        pocket6.size = CGSize(width: 35, height: 30)
        pocket6.position = CGPoint(x: (-383), y:(161))
        
        let pockets: [SKSpriteNode] = [pocket1, pocket2, pocket3, pocket4, pocket5, pocket6]

        for pocket in pockets {
            pocket.isHidden = false
        }
        
//        let fakeBall = SKSpriteNode(texture: cueBallTexture)
//        fakeBall.size = CGSize(width: 55, height: 50)
//        fakeBall.position = CGPoint(x: (383), y:(161))
//        addChild(fakeBall)
        
        
        let wall1 = SKNode()
        wall1.physicsBody = SKPhysicsBody(edgeFrom: point1, to: point2)
//        wall1.physicsBody?.usesPreciseCollisionDetection = true
        wall1.physicsBody?.restitution = 1
        wall1.physicsBody?.collisionBitMask = 0b0001
        addChild(wall1)
        
        let wall2 = SKNode()
        wall2.physicsBody = SKPhysicsBody(edgeFrom: point3, to: point4)
//        wall2.physicsBody?.usesPreciseCollisionDetection = true
        wall2.physicsBody?.restitution = 1
        wall2.physicsBody?.collisionBitMask = 0b0001
        addChild(wall2)
        
        let wall3 = SKNode()
        wall3.physicsBody = SKPhysicsBody(edgeFrom: point5, to: point6)
//        wall3.physicsBody?.usesPreciseCollisionDetection = true
        wall3.physicsBody?.restitution = 1
        wall3.physicsBody?.collisionBitMask = 0b0001
        addChild(wall3)
        
        let wall4 = SKNode()
        wall4.physicsBody = SKPhysicsBody(edgeFrom: point7, to: point8)
//        wall4.physicsBody?.usesPreciseCollisionDetection = true
        wall4.physicsBody?.restitution = 1
        wall4.physicsBody?.collisionBitMask = 0b0001
        addChild(wall4)
        
        let wall5 = SKNode()
        wall5.physicsBody = SKPhysicsBody(edgeFrom: point9, to: point10)
//        wall5.physicsBody?.usesPreciseCollisionDetection = true
        wall5.physicsBody?.restitution = 1
        wall5.physicsBody?.collisionBitMask = 0b0001
        addChild(wall5)
        
        let wall6 = SKNode()
        wall6.physicsBody = SKPhysicsBody(edgeFrom: point11, to: point12)
//        wall6.physicsBody?.usesPreciseCollisionDetection = true
        wall6.physicsBody?.restitution = 1
        wall6.physicsBody?.collisionBitMask = 0b0001
        addChild(wall6)

        let table = SKSpriteNode(imageNamed: "PoolTable")
        
        table.size = CGSize(width: 852, height: 393)
        table.position = CGPoint(x: frame.midX, y: frame.midY)
        table.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        table.zPosition = -1
        
        addChild(table)
        

        let redBallTexture = SKTexture(imageNamed: "redBall")
        let blueBallTexture = SKTexture(imageNamed: "BlueBall")
        let cueBallTexture = SKTexture(imageNamed: "oldcueBall")
        let blackBallTexture = SKTexture(imageNamed: "BlueBall")

        
        
        let redBallPositions: [(CGFloat, CGFloat)]  = [
            (transform_x(235), transform_y(-20)),
            (transform_x(235), transform_y(20)),
            (transform_x(215), transform_y(-10)),
            (transform_x(215), transform_y(30)),
            (transform_x(195), transform_y(-20)),
            (transform_x(195), transform_y(20)),
            (transform_x(155), transform_y(0))
        ]
        
        let blueBallPositions: [(CGFloat, CGFloat)]  = [
            (transform_x(235), transform_y(-40)),
            (transform_x(235), transform_y(0)),
            (transform_x(235), transform_y(40)),
            (transform_x(215), transform_y(-30)),
            (transform_x(215), transform_y(10)),
            (transform_x(175), transform_y(-10)),
            (transform_x(175), transform_y(10))
        ]
        
        blueBalls = []
        for (x,y) in blueBallPositions {
            blueBall = Ball(texture: blueBallTexture)
            blueBall.position = CGPoint(x: (frame.midX + x), y:(frame.midY + y))
            addChild(blueBall)
            blueBalls.append(blueBall)
        }
        
        redBalls = []
        for (x,y) in redBallPositions {
            redBall = Ball(texture: redBallTexture)
            redBall.position = CGPoint(x: (frame.midX + x), y:(frame.midY + y))
            addChild(redBall)
            redBalls.append(redBall)
        }

        
        cueBall = Ball(texture: cueBallTexture)
        cueBall.position = CGPoint(x: (frame.midX - transform_x(195)), y:(frame.midY))
        cueBall.color = .white
        addChild(cueBall)
        
        blackBall = Ball(texture: blackBallTexture)
        blackBall.color = .red
        blackBall.colorBlendFactor = 1
        blackBall.position = CGPoint(x: (frame.midX + transform_x(195)), y:(frame.midY))
        addChild(blackBall)
    
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
        
        leftButton = SKSpriteNode(texture: rightTexture)
        leftButton.zPosition = 2
        leftButton.zRotation = 3.14
        leftButton.size = CGSize(width: 35, height: 33)
        leftButton.position = CGPoint(x: frame.midX - 45, y:frame.midY + 177)
        addChild(leftButton)
        
        backButton = SKSpriteNode(texture: rightTexture)
        backButton.zPosition = 2
        backButton.zRotation = 4.71
        backButton.size = CGSize(width: 35, height: 33)
        backButton.position = CGPoint(x: frame.midX - 320, y:frame.midY + 177)
        addChild(backButton)
        
        righterButton = SKSpriteNode(texture: rightTexture)
        righterButton.zPosition = 2
        righterButton.size = CGSize(width: 35, height: 33)
        righterButton.position = CGPoint(x: frame.midX + 65, y:frame.midY + 177)
        addChild(righterButton)
        
        lefterButton = SKSpriteNode(texture: rightTexture)
        lefterButton.zRotation = 3.14
        lefterButton.zPosition = 2
        lefterButton.size = CGSize(width: 35, height: 33)
        lefterButton.position = CGPoint(x: frame.midX - 65, y:frame.midY + 177)
        addChild(lefterButton)
        
        
        gameStarted = true
        
        numberOne = SKLabelNode(fontNamed: "Helvetica")
        numberOne.text = "1"
        numberOne.fontColor = .black
        numberOne.position = CGPoint(x: frame.midX + 405, y: frame.midY - 105)
        numberOne.fontSize = 35

        addChild(numberOne)
        
        numberTwo = SKLabelNode(fontNamed: "Helvetica")
        numberTwo.text = "2"
        numberTwo.fontColor = .black
        numberTwo.position = CGPoint(x: frame.midX + 405, y: frame.midY - 60)
        numberTwo.fontSize = 35
        addChild(numberTwo)
        
        numberThree = SKLabelNode(fontNamed: "Helvetica")
        numberThree.text = "3"
        numberThree.fontColor = .black
        numberThree.position = CGPoint(x: frame.midX + 405, y: frame.midY - 20)
        numberThree.fontSize = 35
        addChild(numberThree)
        
        numberFour = SKLabelNode(fontNamed: "Helvetica")
        numberFour.text = "4"
        numberFour.fontColor = .black
        numberFour.position = CGPoint(x: frame.midX + 405, y: frame.midY + 20)
        numberFour.fontSize = 35
        addChild(numberFour)
        
        numberFive = SKLabelNode(fontNamed: "Helvetica")
        numberFive.text = "5"
        numberFive.fontColor = .black
        numberFive.position = CGPoint(x: frame.midX + 405, y: frame.midY + 60)
        numberFive.fontSize = 35
        addChild(numberFive)
        
        fire = SKLabelNode(fontNamed: "Impact")
        fire.text = "Fire"
        fire.fontColor = .red
        fire.position = CGPoint(x: frame.midX + 405, y: frame.midY + 105)
        fire.fontSize = 22
        addChild(fire)
        
        shotCounter = 0
        counter = SKLabelNode(fontNamed: "Helvetica")
        counter.text = String(shotCounter)
        counter.fontColor = .blue
        counter.position = CGPoint(x: frame.midX - 205, y: frame.midY + 170)
        addChild(counter)
        
        paths = []
        for i in 0..<15{
            path = SKSpriteNode(imageNamed: "redBall")
            path.size = CGSize(width: 5, height: 5)
            path.zPosition = 0
            addChild(path)
            path.isHidden = true
            paths.append(path)
        }
        
        power = 0
        rotationSpeed = 0
        scoreRed = 0
        scoreBlue = 0
        
        }
    
    
    override func update(_ currentTime: TimeInterval){
        
        if gameStarted == true{
            cueStick.zRotation += rotationSpeed
            if let cueBall = cueBall{
                cueBall.updateSpeed()
                if cueBall.physicsBody?.velocity == CGVector(dx: 0, dy: 0){
                    for redBall in redBalls {
                        redBall.updateSpeed()
                        if redBall.physicsBody?.velocity == CGVector(dx: 0, dy: 0){
                            for blueBall in blueBalls {
                                blueBall.updateSpeed()
                                if blueBall.physicsBody?.velocity == CGVector(dx: 0, dy: 0){
                                    cueStick.position = CGPoint(x: cueBall.position.x, y: cueBall.position.y - 2 )
                                    cueStick.isHidden = false
                                    var count = 0.0
                                    let angle = Double(cueStick.zRotation)
                                    for path in paths{
                                        count += 50
                                        path.position = CGPoint(x:cueStick.position.x + (cos(angle) * count) , y: cueStick.position.y + (sin(angle) * count) + 2.0)
                                        path.isHidden = false
                                    }
                                    
                                }
                                else{
                                    cueStick.isHidden = true
                                    for path in paths{
                                        path.isHidden = true
                                    }
                                }
                            }
                        }
                        else{
                            cueStick.isHidden = true
                            for path in paths{
                                path.isHidden = true
                            }
                        }
                    }
                }
                else{
                    cueStick.isHidden = true
                    for path in paths{
                        path.isHidden = true
                    }
                }
            }
            if chosen == 1{
                numberOne.fontColor = .red
            }
            else{
                numberOne.fontColor = .black
            }
            if chosen == 2{
                numberTwo.fontColor = .red
            }
            else{
                numberTwo.fontColor = .black
            }
            if chosen == 3{
                numberThree.fontColor = .red
            }
            else{
                numberThree.fontColor = .black
            }
            if chosen == 4{
                numberFour.fontColor = .red
            }
            else{
                numberFour.fontColor = .black
            }
            if chosen == 5{
                numberFive.fontColor = .red
            }
            else{
                numberFive.fontColor = .black
            }
            let pockets: [SKSpriteNode] = [pocket1, pocket2, pocket3, pocket4, pocket5, pocket6]

            for pocket in pockets {
                for redBall in redBalls {
                    if redBall.frame.intersects(pocket.frame) {
                        redBall.isHidden = true
                        
                    }
                }
                for blueBall in blueBalls {
                    if blueBall.frame.intersects(pocket.frame) {
                        blueBall.isHidden = true
                    }
                }
                if blackBall.frame.intersects(pocket.frame) {
                    blackBall.physicsBody?.velocity = CGVector(dx:0, dy: 0)
                    blackBall.position = CGPoint(x: (frame.midX + 195), y:(frame.midY))
                }
                if cueBall.frame.intersects(pocket.frame) {
                    cueBall.physicsBody?.velocity = CGVector(dx:0, dy: 0)
                    cueBall.position = CGPoint(x: (frame.midX - 195), y:(frame.midY))
                }
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
            if leftButton.contains(touchLocation) {
                rotationSpeed = 0.002
            }
            if rightButton.contains(touchLocation) {
                rotationSpeed = -0.002
            }
            if lefterButton.contains(touchLocation) {
                rotationSpeed = 0.05
            }
            if righterButton.contains(touchLocation) {
                rotationSpeed = -0.05
            }
            if numberOne.contains(touchLocation) {
                power = 3.0
                chosen = 1
            }
            if numberTwo.contains(touchLocation) {
                power = 5.0
                chosen = 2
            }
            if numberThree.contains(touchLocation) {
                power = 10.0
                chosen = 3
            }
            if numberFour.contains(touchLocation) {
                power = 18.0
                chosen = 4
            }
            if numberFive.contains(touchLocation) {
                power = 25.0
                chosen = 5
            }
            if fire.contains(touchLocation) {
                if power >= 1.0{
                    cueBall.physicsBody?.applyImpulse(CGVector(dx: cos(cueStick.zRotation) * power!, dy: sin(cueStick.zRotation) * power!))
                }
            }
            if backButton.contains(touchLocation) {
                if let view = self.view as! SKView? {
                    if let scene = SKScene(fileNamed: "MenuScene") {
                        scene.scaleMode = .resizeFill
                        view.presentScene(scene)
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        rotationSpeed = 0.0
    }
}

//
