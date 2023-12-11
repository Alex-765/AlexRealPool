//
//  MenuScene.swift
//  AlexRealPool
//
//  Created by Bater, Alexander (IRG) on 27/09/2023.
//

import SpriteKit


class MenuScene: SKScene {
    
    var playButton: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(color: .cyan, size: view.frame.size)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = -1
        addChild(background)

        playButton = SKLabelNode(fontNamed: "Impact")
        playButton.text = "Play Game"
        playButton.position = CGPoint(x: frame.midX, y: frame.midY)
        playButton.fontColor = .red
        playButton.fontSize = 50
        playButton.zPosition = 1
        
        addChild(playButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
            if playButton.contains(touchLocation) {
                if let view = self.view{
                    if let scene = SKScene(fileNamed: "GameScene") {
                        scene.scaleMode = .resizeFill
                        view.presentScene(scene)
                    }
                }
            }
        }
    }
}

