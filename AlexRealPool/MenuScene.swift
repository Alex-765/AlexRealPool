//  MenuScene.swift
//  AlexRealPool
//
//  Created by Bater, Alexander (IRG) on 27/09/2023.
//
import SpriteKit


class MenuScene: SKScene {
    
    var playButton: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
//      Creating a white backgroud
        let background = SKSpriteNode(color: .white, size: view.frame.size)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        addChild(background)
        
//      Creating a black title text node
        let title = SKLabelNode(fontNamed: "Impact")
        title.text = "Real Pool"
        title.position = CGPoint(x: frame.midX, y: frame.midY + 30)
        title.fontColor = .black
        title.fontSize = 70
        title.zPosition = 1
        addChild(title)
        
//      Creating a red play button
        playButton = SKLabelNode(fontNamed: "Impact")
        playButton.text = "Play Game"
        playButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        playButton.fontColor = .red
        playButton.fontSize = 30
        playButton.zPosition = 1
        
        addChild(playButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
//            Checking every touch and defining a variable mapping every touch to a location
            if playButton.contains(touchLocation) {
                if let view = self.view{
                    if let scene = SKScene(fileNamed: "GameScene") {
                        scene.scaleMode = .resizeFill
                        view.presentScene(scene)
//                        If the touch location overlaps with the play button, the scene switches
                    }
                }
            }
        }
    }
}

