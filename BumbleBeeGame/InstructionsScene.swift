//  InstructionsScene.swift
//  Created by Elena Melnikova on 2019-01-29.
//  BumbleBeeGame
//  Student ID: 301025880
//  Description: "InstructionsScene" displays rules and instructions of the "BumbleBee" game
//  Copyright © 2019 Centennial College. All rights reserved.


import UIKit
import SpriteKit
import Foundation

class InstructionsScene: SKScene {
    
    let screenSize = UIScreen.main.bounds
    var backToMenuButton: SKLabelNode!
    var instructionsTextLabel: SKLabelNode!
    var headerLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        // set labels and buttons
        headerLabel = (childNode(withName: "header") as! SKLabelNode)
        headerLabel?.text = "GAME INSTRUCTIONS"
        headerLabel?.position = CGPoint(x: 0, y: screenSize.size.height / 2 - 40)
        headerLabel?.zPosition = 1
        headerLabel?.fontName = "Futura-Bold"
        headerLabel?.fontColor = UIColor.yellow
        headerLabel?.fontSize = 36.00
        
        backToMenuButton = (childNode(withName: "backToMenu") as! SKLabelNode)
        backToMenuButton?.text = "Back to menu"
        backToMenuButton?.position = CGPoint(x: 0, y: -screenSize.size.height / 2 + 10)
        backToMenuButton?.zPosition = 1
        backToMenuButton?.fontName = "Futura-Bold"
        backToMenuButton?.fontColor = UIColor.blue
        backToMenuButton?.fontSize = 30.00
        
        instructionsTextLabel = (childNode(withName: "instructionsText") as! SKLabelNode)
        instructionsTextLabel?.text = "The goal of the “BumbleBee” arcade Game is exceeding top level score within limited time.  “BumbleBee” is a main character of the game.  The game scores are increasing while “BumbleBee” picks up “Flowers” and deducting while “BumbleBee” collides with enemies - “Owls”. Winning condition gains when user exceeds top scores within time limit, otherwise the user loses."
        instructionsTextLabel?.numberOfLines = 0
        instructionsTextLabel?.preferredMaxLayoutWidth = 600
        instructionsTextLabel?.verticalAlignmentMode = .center
        instructionsTextLabel?.horizontalAlignmentMode = .center
        instructionsTextLabel?.position = CGPoint(x: 0, y: 0)
        instructionsTextLabel?.zPosition = 1
        instructionsTextLabel?.fontName = "Futura-Bold"
        instructionsTextLabel?.fontColor = UIColor.white
        instructionsTextLabel?.fontSize = 20.00
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            // Back to menu button click action (move to Start scene)
            if atPoint(location).name == "backToMenu" {
                if let startScene = StartScene(fileNamed: "StartScene") {
                    startScene.scaleMode = .aspectFill
                    
                    // Button clicked sound
                    let action = SKAction.playSoundFileNamed("button.mp3", waitForCompletion: true)
                    self.run(SKAction.sequence([
                        action
                        ])
                    )
                    view?.presentScene(startScene, transition: .doorsOpenVertical(withDuration: 1))
                }
            }
        }
    }
}
