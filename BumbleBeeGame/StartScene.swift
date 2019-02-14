//
//  StartScene.swift
//  BumbleBeeGame
//
//  Created by Elena Melnikova on 2019-01-29.
//  Copyright © 2019 Centennial College. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class StartScene: SKScene {
    
    var startButton: SKLabelNode!
    var instructionsButton: SKLabelNode!
    var gameNameLabel: SKLabelNode!
    var backgroundSound: SKAudioNode!
    let screenSize = UIScreen.main.bounds
    var scale: CGFloat = 0
    var background1: Background?
    var background2: Background?
    
    override func didMove(to view: SKView) {
        
        // set labels and buttons
        gameNameLabel = childNode(withName: "gameName") as! SKLabelNode
        gameNameLabel.zPosition = 3
        gameNameLabel.fontName = "Futura-Bold"
        
        startButton = childNode(withName: "startGame") as! SKLabelNode
        startButton.zPosition = 3
        startButton.fontName = "Futura-Bold"

        instructionsButton = childNode(withName: "instructions") as! SKLabelNode
        instructionsButton.zPosition = 3
        instructionsButton.fontName = "Futura-Bold"
        
        //Background sound
        if let musicURL = Bundle.main.url(forResource: "nature", withExtension: "mp3") {
            backgroundSound = SKAudioNode(url: musicURL)
            addChild(backgroundSound)
        }
        
        // set background image
        let image = UIImage(named: "sky")
        scale = CGFloat(screenSize.size.height) / CGFloat((image?.size.height)!)
        
        // add the background1 to scene
        background1 = Background(scale)
        background1?.position.x = 0
        background1?.position.y = 0
        background1?.zPosition = 0
        addChild(background1!)
        
        // add the background2 to scene
        background2 = Background(scale)
        background2?.position.x = (background2?.size.width)!
        background2?.position.y = 0
        background2?.zPosition = 0
        addChild(background2!)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            // Start game button click action (move to Game scene)
            if atPoint(location).name == "startGame" {
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    gameScene.scaleMode = .aspectFill
                    
                    // Button clicked sound
                    let action2 = SKAction.playSoundFileNamed("button.mp3", waitForCompletion: true)
                    self.run(SKAction.sequence([
                        action2
                        ])
                    )
                    view?.presentScene(gameScene, transition: .doorsOpenVertical(withDuration: 1))
                }
            }

            // Instructions button click action (move to Instructions scene)
            if atPoint(location).name == "instructions" {
                if let instructionsScene = InstructionsScene(fileNamed: "InstructionsScene") {
                    instructionsScene.scaleMode = .aspectFill
                    
                    // Button clicked sound
                    let action2 = SKAction.playSoundFileNamed("button.mp3", waitForCompletion: true)
                    self.run(SKAction.sequence([
                        action2
                        ])
                    )
                    view?.presentScene(instructionsScene, transition: .doorsOpenVertical(withDuration: 1))
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        background1?.Update(currentTime)
        background2?.Update(currentTime)
    }
}

