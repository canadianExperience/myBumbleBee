//  GameOverScene.swift
//  Created by Elena Melnikova on 2019-01-29.
//  BumbleBeeGame
//  Student ID: 301025880
//  Description: "GameOverScene" displays final activity with respective game message "Game Over","Time Expired" or "You Won". "Your Score" and "Top Score" labels show scores. "Menu" button moves users to "StartScene", "Play Again" button starts game again and "Quit" exits the game
//  Copyright © 2019 Centennial College. All rights reserved.

import SpriteKit
import GameplayKit
import UIKit
import AVFoundation


class GameOverScene: SKScene{
    var score: Int = 0
    var topScore: Int = 0
    var timeOut: Bool = false
    var isAlive: Bool = true
    var messageLabel: SKLabelNode?
    var yourScoreLabel: SKLabelNode?
    var topScoreLabel: SKLabelNode?
    var menuButton: SKLabelNode?
    var quitButton: SKLabelNode?
    var playAgainButton: SKLabelNode?
    let screenSize = UIScreen.main.bounds
    var scale: CGFloat = 0
    var background1: Background?
    var background2: Background?
    
    override func didMove(to view: SKView) {
        
        //set background image
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
        
        // show win(lose) message and pay respective sounds (get parameters from Game Scene)
        var message = ""
        if isAlive && score > topScore {
            message = "You won"
            // Score saves as a top score in UserDefaults
            UserDefaults.standard.set(score, forKey: "topScore")
            play("win")
            
        } else if timeOut {
            message = "Time expired"
            play("time_expired")
        } else {
            message = "Game over"
            play("time_expired")
            
        }
        
        // set labels and buttons positions
        
        messageLabel = self.childNode(withName: "message") as? SKLabelNode
        messageLabel?.text = message
        messageLabel?.verticalAlignmentMode = .center
        messageLabel?.horizontalAlignmentMode = .center
        messageLabel?.position = CGPoint(x: 0, y: 0)
        messageLabel?.zPosition = 1
        messageLabel?.fontName = "Futura-Bold"
        messageLabel?.fontColor = UIColor.yellow
        messageLabel?.fontSize = 72.00
        
        yourScoreLabel = self.childNode(withName: "yourScore") as? SKLabelNode
        yourScoreLabel?.text = "Your Score: \(score)"
        yourScoreLabel?.verticalAlignmentMode = .center
        yourScoreLabel?.horizontalAlignmentMode = .center
        yourScoreLabel?.position = CGPoint(x: -screenSize.width / 2 + 150, y: screenSize.size.height / 2 - 50)
        yourScoreLabel?.zPosition = 1
        yourScoreLabel?.fontName = "Futura-Bold"
        yourScoreLabel?.fontColor = UIColor.blue
        yourScoreLabel?.fontSize = 36.00
        
        topScoreLabel = self.childNode(withName: "topScore") as? SKLabelNode
        topScoreLabel?.text = "Top Score: \(topScore)"
        topScoreLabel?.verticalAlignmentMode = .center
        topScoreLabel?.horizontalAlignmentMode = .center
        topScoreLabel?.position = CGPoint(x: screenSize.width / 2 - 150, y: screenSize.size.height / 2 - 50)
        topScoreLabel?.zPosition = 1
        topScoreLabel?.fontName = "Futura-Bold"
        topScoreLabel?.fontColor = UIColor.red
        topScoreLabel?.fontSize = 36.00
        
        menuButton = self.childNode(withName: "toStartScene") as? SKLabelNode
        menuButton?.text = "Menu"
        menuButton?.verticalAlignmentMode = .center
        menuButton?.horizontalAlignmentMode = .center
        menuButton?.position = CGPoint(x: -screenSize.width / 2 + 80, y: -screenSize.size.height / 2 + 50)
        menuButton?.zPosition = 1
        menuButton?.fontName = "Futura-Bold"
        menuButton?.fontColor = UIColor.blue
        menuButton?.fontSize = 36.00
        
        quitButton = self.childNode(withName: "quitGame") as? SKLabelNode
        quitButton?.text = "Quit"
        quitButton?.verticalAlignmentMode = .center
        quitButton?.horizontalAlignmentMode = .center
        quitButton?.position = CGPoint(x: screenSize.width / 2 - 80, y:  -screenSize.size.height / 2 + 50)
        quitButton?.zPosition = 1
        quitButton?.fontName = "Futura-Bold"
        quitButton?.fontColor = UIColor.blue
        quitButton?.fontSize = 36.00
        
        playAgainButton = self.childNode(withName: "playAgain") as? SKLabelNode
        playAgainButton?.text = "Play Again"
        playAgainButton?.verticalAlignmentMode = .center
        playAgainButton?.horizontalAlignmentMode = .center
        playAgainButton?.position = CGPoint(x: 0, y:  -screenSize.size.height / 2 + 50)
        playAgainButton?.zPosition = 1
        playAgainButton?.fontName = "Futura-Bold"
        playAgainButton?.fontColor = UIColor.blue
        playAgainButton?.fontSize = 36.00
   
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            // Play again button click action (move to Game scene)
            if atPoint(location).name == "playAgain" {
                if let gameScene = StartScene(fileNamed: "GameScene") {
                    gameScene.scaleMode = .aspectFill
                    // play sound
                    play("button")
                    view?.presentScene(gameScene, transition: .doorsOpenVertical(withDuration: 2))
                }
            }
            
            // Menu button click action (move to Start scene)
            if atPoint(location).name == "toStartScene" {
                if let startScene = StartScene(fileNamed: "StartScene") {
                    startScene.scaleMode = .aspectFill
                    // play sound
                    play("button")
                    view?.presentScene(startScene, transition: .doorsOpenVertical(withDuration: 2))
                }
            }
            
            if atPoint(location).name == "quitGame" {
                play("quit")
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        background1?.Update(currentTime)
        background2?.Update(currentTime)
    }
    
    // play system sound
    func play(_ soundName: String) {
        
        
        if let customSoundUrl = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            var customSoundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(customSoundUrl as CFURL, &customSoundId)
            
            if soundName == "quit" {
                AudioServicesAddSystemSoundCompletion(customSoundId, nil, nil, soundFinished, nil)
            }
            AudioServicesPlaySystemSound(customSoundId)
        }
    }
}

//play sound and then exit from app
func soundFinished(_ snd:UInt32, _ c:UnsafeMutableRawPointer?) {
    print("finished!")
    AudioServicesRemoveSystemSoundCompletion(snd)
    AudioServicesDisposeSystemSoundID(snd)
    exit(0)
}





