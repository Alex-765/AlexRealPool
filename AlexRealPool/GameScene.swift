//
//  GameScene.swift
//  AlexRealPool
//
//  Created by Alexander Bater on 27/09/2023.
//

import SpriteKit

class Ball: SKSpriteNode {
    
    init(texture: SKTexture?) {
        
        let size = CGSize(width:20, height: 20)
        
        super.init(texture: texture, color: .clear, size: size)
        //    Each instance of the ball class is initialised with a texture (image)
        //    Each instance also has same defined color (clear), and same circular size
        
        self.zPosition = 1
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.restitution = 1
        self.physicsBody?.collisionBitMask = 0b0001
        //      Balls are given values a resitution of 1 so collisions are elastic
        self.physicsBody?.linearDamping = 0.7
        //      Balls are given a value of friction

        
    }
    func updateSpeed(){
//      Ensuring the physics body has a velocity before it is assigned
//      to prevent errors
        guard let velocity = self.physicsBody?.velocity
        else{
            return
        }
//      Using pythagoras theorem to calculate the magnitude of velocity
//        and setting it to zero if sufficently small
        let speeds = sqrt(pow(velocity.dx, 2.0) + pow(velocity.dy, 2.0))
            if speeds < 1 && speeds > 0 {
                self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
}

class Number: SKLabelNode {

    //    Each instance of the ball class is initialised with a text and position to be entered
    init(text: String, position: CGPoint) {
        super.init()
        //    Each instance also has same defined font, colour and size
        self.fontName = "Helvetica"
        self.fontColor = .black
        self.fontSize = 35
        self.text = text
        self.position = position

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
}

class Wall: SKNode {

    //    Each instance of the ball class is initialised with two points to be entered
    init(start: CGPoint, end: CGPoint) {
        super.init()
        //    Each instance has the same physical properites
        self.physicsBody = SKPhysicsBody(edgeFrom: start, to: end)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.restitution = 1
        self.physicsBody?.collisionBitMask = 0b0001

    }
    
    required init?(coder aDecoder: NSCoder) {
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
    var blueBalls: [Ball]!
    var redBalls: [Ball]!
    var rightButton: SKSpriteNode!
    var righterButton: SKSpriteNode!
    var leftButton: SKSpriteNode!
    var lefterButton: SKSpriteNode!
    var backButton: SKSpriteNode!
    var powerButton: SKSpriteNode!
    var power: CGFloat!
    var numberOne: Number!
    var numberTwo: Number!
    var numberThree: Number!
    var numberFour: Number!
    var numberFive: Number!
    var chosen: Int!
    var fire: SKLabelNode!
    var pocket1: SKSpriteNode!
    var pocket2: SKSpriteNode!
    var pocket3: SKSpriteNode!
    var pocket4: SKSpriteNode!
    var pocket5: SKSpriteNode!
    var pocket6: SKSpriteNode!
    var scoreRed: Int!
    var scoreBlue: Int!
    var path: SKSpriteNode!
    var paths: [SKSpriteNode]!
    var rotationSpeed: CGFloat!
    var counterRed: SKLabelNode!
    var counterBlue: SKLabelNode!
    
    
    override func didMove(to view: SKView) {
        
        //      Creating table node
        
        let table = SKSpriteNode(imageNamed: "PoolTable")
        
        table.size = CGSize(width: 852, height: 393)
        table.position = CGPoint(x: frame.midX, y: frame.midY)
        table.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        table.zPosition = -1
        
        addChild(table)
        
        
//      Points of the edges of the cushions
        let point1 = CGPoint(x:380, y:140)
        let point2 = CGPoint(x:380, y:-140)
        let point3 = CGPoint(x:355, y:-161)
        let point4 = CGPoint(x:25, y:-161)
        let point5 = CGPoint(x:-25, y:-161)
        let point6 = CGPoint(x:-355, y:-161)
        let point7 = CGPoint(x:-380, y:140)
        let point8 = CGPoint(x:-380, y:-140)
        let point9 = CGPoint(x:355, y:161)
        let point10 = CGPoint(x:25, y:161)
        let point11 = CGPoint(x:-25, y:161)
        let point12 = CGPoint(x:-355, y:161)
        
//      Creating the pockets
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
        
//      Creating the cushions using previous points
        let wall1 = Wall(start: point1, end: point2)
        addChild(wall1)
        
        let wall2 = Wall(start: point3, end: point4)
        addChild(wall2)
    
        let wall3 = Wall(start: point5, end: point6)
        addChild(wall3)
        
        let wall4 = Wall(start: point7, end: point8)
        addChild(wall4)
        
        let wall5 = Wall(start: point9, end: point10)
        addChild(wall5)
        
        let wall6 = Wall(start: point11, end: point12)
        addChild(wall6)
        
        
        let redBallTexture = SKTexture(imageNamed: "redBall")
        let blueBallTexture = SKTexture(imageNamed: "BlueBall")
        let cueBallTexture = SKTexture(imageNamed: "cueBall")
        let blackBallTexture = SKTexture(imageNamed: "BlueBall")
        
        
        //      Red Ball positions for the break
        let redBallPositions: [(CGFloat, CGFloat)]  = [
            (155, -20),
            (155, 20),
            (175, -10),
            (175, 30),
            (195, -20),
            (195, 20),
            (235, 0)
        ]
        //      Blue Ball positions for the break
        let blueBallPositions: [(CGFloat, CGFloat)]  = [
            (155, -40),
            (155, 0),
            (155, 40),
            (175, -30),
            (175, 10),
            (215, -10),
            (215, 10)
        ]
        
        //      Creating blue balls
        blueBalls = []
        for (x,y) in blueBallPositions {
            blueBall = Ball(texture: blueBallTexture)
            blueBall.position = CGPoint(x: (frame.midX + x), y:(frame.midY + y))
            addChild(blueBall)
            blueBalls.append(blueBall)
            
        }
        //      Creating red balls
        redBalls = []
        for (x,y) in redBallPositions {
            redBall = Ball(texture: redBallTexture)
            redBall.position = CGPoint(x: (frame.midX + x), y:(frame.midY + y))
            addChild(redBall)
            redBalls.append(redBall)
        }
        //      Creating cue ball
        cueBall = Ball(texture: cueBallTexture)
        cueBall.position = CGPoint(x: (frame.midX - 195), y:(frame.midY))
        cueBall.color = .white
        addChild(cueBall)
        
        //      Creating black ball
        blackBall = Ball(texture: blackBallTexture)
        blackBall.color = .red
        blackBall.colorBlendFactor = 1
        blackBall.position = CGPoint(x: (frame.midX + 195), y:(frame.midY))
        addChild(blackBall)
        
        //      Creating the cue Stick
        let cueStickTexture = SKTexture(imageNamed: "CueStick")
        cueStick = SKSpriteNode(texture: cueStickTexture)
        addChild(cueStick)
        
        //      Placing it behind the cue ball
        cueStick.position = cueBall.position
        cueStick.zPosition = 0
        cueStick.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        cueStick.size = CGSize(width: 200, height: 150)
        
        //      Creating right movement button
        let rightTexture = SKTexture(imageNamed: "right")
        rightButton = SKSpriteNode(texture: rightTexture)
        rightButton.zPosition = 2
        rightButton.size = CGSize(width: 35, height: 33)
        rightButton.position = CGPoint(x: frame.midX + 45, y:frame.midY + 177)
        addChild(rightButton)
        
        //      Creating left movement button
        leftButton = SKSpriteNode(texture: rightTexture)
        leftButton.zPosition = 2
        leftButton.zRotation = 3.14
        leftButton.size = CGSize(width: 35, height: 33)
        leftButton.position = CGPoint(x: frame.midX - 45, y:frame.midY + 177)
        addChild(leftButton)
        
//      Creating a back button
        backButton = SKSpriteNode(texture: rightTexture)
        backButton.zPosition = 2
        backButton.zRotation = 4.71
        backButton.size = CGSize(width: 35, height: 33)
        backButton.position = CGPoint(x: frame.midX - 320, y:frame.midY + 177)
        addChild(backButton)
        
//      Creating faster movement buttons
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
        
        
//      Creating power levels
        numberOne = Number(text: "1", position: CGPoint(x: frame.midX + 405, y: frame.midY - 105))
        addChild(numberOne)
        numberTwo = Number(text: "2", position: CGPoint(x: frame.midX + 405, y: frame.midY - 60))
        addChild(numberTwo)
        numberThree = Number(text: "3", position: CGPoint(x: frame.midX + 405, y: frame.midY - 20))
        addChild(numberThree)
        numberFour = Number(text: "4", position: CGPoint(x: frame.midX + 405, y: frame.midY + 20))
        addChild(numberFour)
        numberFive = Number(text: "5", position: CGPoint(x: frame.midX + 405, y: frame.midY + 60))
        addChild(numberFive)
        
//      Creating the fire button
        
        fire = SKLabelNode(fontNamed: "Impact")
        fire.text = "Fire"
        fire.fontColor = .red
        fire.position = CGPoint(x: frame.midX + 405, y: frame.midY + 105)
        fire.fontSize = 22
        addChild(fire)

//      Creating a path of many little red dots
        paths = []
        for _ in 0..<15{
            path = SKSpriteNode(imageNamed: "redBall")
            path.size = CGSize(width: 5, height: 5)
            path.zPosition = 0
            addChild(path)
            path.isHidden = true
            paths.append(path)
        }

//      Declaring variables to default values
        power = 0
        rotationSpeed = 0
        scoreRed = 7
        scoreBlue = 7
        gameStarted = true
        
//      Creating Score counters
        counterRed = SKLabelNode(fontNamed: "Helvetica")
        counterRed.text = String(scoreRed)
        counterRed.fontColor = .red
        counterRed.position = CGPoint(x: frame.midX - 205, y: frame.midY + 170)
        counterRed.fontSize = 24
        addChild(counterRed)
        
        counterBlue = SKLabelNode(fontNamed: "Helvetica")
        counterBlue.text = String(scoreRed)
        counterBlue.fontColor = .blue
        counterBlue.position = CGPoint(x: frame.midX - 185, y: frame.midY + 170)
        counterBlue.fontSize = 24
        addChild(counterBlue)
        
        
    }
    
    override func update(_ currentTime: TimeInterval){
        
        if gameStarted == true{
            //  Adding the specified rotation to the stick
            cueStick.zRotation += rotationSpeed
            
            // If the game has started, the speed of the cue ball is found
            // and if it is zero, then the speeds of red ball are found, and so forth.
            if let cueBall = cueBall{
                cueBall.updateSpeed()
                if cueBall.physicsBody?.velocity == CGVector(dx: 0, dy: 0){
                    for redBall in redBalls {
                        redBall.updateSpeed()
                        if redBall.physicsBody?.velocity == CGVector(dx: 0, dy: 0){
                            for blueBall in blueBalls {
                                blueBall.updateSpeed()
                                //  If every ball's speed is found to be 0, the cue Stick
                                //  is no longer hidden, otherwise it is kept hiddden
                                if blueBall.physicsBody?.velocity == CGVector(dx: 0, dy: 0){
                                    cueStick.position = cueBall.position
                                    cueStick.isHidden = false
//                                  The path is added in the direction of the cue
                                    var count = 0.0
                                    let angle = Double(cueStick.zRotation)
                                    for path in paths{
                                        count += 50
                                        path.position = CGPoint(x:cueStick.position.x + (cos(angle) * count)
                                        ,y: cueStick.position.y + (sin(angle) * count) + 2.0)
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
//              Making the specified button highlighted
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
//              If a red ball enters the pocket, it is hidden out of frame,and the score decreased
                for pocket in pockets {
                    for redBall in redBalls {
                        if redBall.frame.intersects(pocket.frame) {
                            redBall.position = CGPoint(x: 10000,y: 10000)
                            redBall.isHidden = true
                            scoreRed -= 1
                            counterRed.text = String(scoreRed)
    
                        }
                    }
//               If a blue ball enters the pocket, it is hidden out of frame,and the score decreased
                    for blueBall in blueBalls {
                        if blueBall.frame.intersects(pocket.frame) {
                            blueBall.position = CGPoint(x: 10000,y: 10000)
                            blueBall.isHidden = true
                            scoreBlue -= 1
                            counterBlue.text = String(scoreBlue)
                        }
                    }
//               If a black ball enters the pocket, it is hidden
                    if blackBall.frame.intersects(pocket.frame) {
                        blackBall.isHidden = true
                    }
//               If a white ball enters the pocket, it is spotted back in the middle
                    if cueBall.frame.intersects(pocket.frame) {
                        cueBall.physicsBody?.velocity = CGVector(dx:0, dy: 0)
                        cueBall.position = CGPoint(x: (frame.midX - 195), y:(frame.midY))
                    }
                }
            }
        }
    }
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//          Setting the sensitivity speed for each button
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
            
//             Outlining which button is chosen, and thus its power
                if numberOne.contains(touchLocation) {
                    power = 3.0
                    chosen = 1
                }
                if numberTwo.contains(touchLocation) {
                    power = 8.0
                    chosen = 2
                }
                if numberThree.contains(touchLocation) {
                    power = 15.0
                    chosen = 3
                }
                if numberFour.contains(touchLocation) {
                    power = 20.0
                    chosen = 4
                }
                if numberFive.contains(touchLocation) {
                    power = 25.0
                    chosen = 5
                }

//             If the fire button is pressed, an impulse is applied to the ball
                if fire.contains(touchLocation) {
                    if power >= 1.0 && cueStick.isHidden == false{
                        cueBall.physicsBody?.applyImpulse(CGVector(dx: cos(cueStick.zRotation) * power!, 
                                                                   dy: sin(cueStick.zRotation) * power!))
                    }
                }
                if backButton.contains(touchLocation) {
                    if let view = self.view {
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
//      Turning off the cue's rotation if the button is let go
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
