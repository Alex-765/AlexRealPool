//
//  MenuScene.swift
//  AlexRealPool
//
//  Created by Bater, Alexander (IRG) on 27/09/2023.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(color: .cyan, size: view.frame.size)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = -1
        addChild(background)
        
        let name = SKLabelNode(fontNamed: "Calibri")
        
//
//        let playButton = SKSpriteNode(imageNamed: "RedBall")
//        playButton.size = CGSize(width: 50, height: 50)
//        playButton.position = CGPoint(x: frame.midX, y: frame.midY)
//        playButton.name = "playButton"
//        addChild(playButton)
    }
}



#if os(iOS) || os(tvOS)
// Touch-based event handling
extension MenuScene {
   
}
#endif
