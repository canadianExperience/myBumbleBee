//
//  GameScene.swift
//  BumbleBeeGame
//
//  Created by Elena Melnikova on 2019-01-29.
//  Copyright © 2019 Centennial College. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit
import AVFoundation

let screenSize = UIScreen.main.bounds
var scale: CGFloat = 0


class GameScene: SKScene{
    
    var score = 0
    var highScore = 0
    var lives = 5
    var timer: TimeInterval = 60 //3*60
    var timeEnd: TimeInterval = 0
    
    var timerLabel: SKLabelNode?
    var lifeLabel: SKLabelNode?
    var scoreLabel: SKLabelNode?
    
    var bumbleBee: BumbleBee?
    var background1: Background?
    var background2: Background?
    var green1: Green?
    var green2: Green?
    var flower: Flower?
    var owl: Owl?

    var isPressed: Bool = false
    var forceUp: Float = 0  // calculate bee force up
    var counter:Int = 1   // count a number of frames when user presses the screen
    
    var isHit: Bool = false
    var hitCurrentTime: TimeInterval = 0
    var prevTime: TimeInterval = 0
    var hitTotalRotateAngle: Double = 0.0
    
    override func didMove(to view: SKView) {
        
         highScore = UserDefaults.standard.integer(forKey: "topScore")
        
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
        
        // add green1 subbackground to scene
        green1 = Green(scale)
        green1?.position.x = 0
        green1?.position.y = 0
        green1?.zPosition = 1
        addChild(green1!)
        
        // add green2 subbackground to scene
        green2 = Green(scale)
        green2?.position.x = (green2?.size.width)!
        green2?.position.y = 0
        green2?.zPosition = 1
        addChild(green2!)
        
        owl = Owl()
        addChild(owl!)
        owl!.animate()
        
        flower = Flower()
        addChild(flower!)
        
        // add bumbleBee to scene
        bumbleBee = BumbleBee()
        let xBee = -screenSize.size.width / 2 + (bumbleBee?.halfWidth)! + 80
        bumbleBee?.position = CGPoint(x: xBee, y: 0.0)
        addChild(bumbleBee!)
        
        if bumbleBee!.action(forKey: "beeFly") == nil{
            bumbleBee!.animate()
        }
        
        
        timerLabel = self.childNode(withName: "timer") as? SKLabelNode
        timerLabel?.text = "\(Int(timer))"
        timerLabel?.position = CGPoint(x: screenSize.width / 2 - 15, y: screenSize.size.height / 2 - 30)
        timerLabel?.zPosition = 3
        
        lifeLabel = self.childNode(withName: "life") as? SKLabelNode
        lifeLabel?.text = "Life: \(Int(lives))"
        lifeLabel?.position = CGPoint(x: screenSize.width / 2 - 90, y: screenSize.size.height / 2 - 30)
        lifeLabel?.zPosition = 3
        
        scoreLabel = self.childNode(withName: "score") as? SKLabelNode
        scoreLabel?.text = "Score: \(Int(score)) / \(Int(highScore))"
        scoreLabel?.position = CGPoint(x: screenSize.width / 2 - 215, y: screenSize.size.height / 2 - 30)
        scoreLabel?.zPosition = 3
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isPressed = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isPressed = false
    }
    
    func toGameOverScene(_ timeOut: Bool){
        self.removeAllActions()
        if let gameScene = GameOverScene(fileNamed: "GameOverScene") {
            gameScene.scaleMode = .aspectFill
            gameScene.score = score
            gameScene.topScore = highScore
            gameScene.timeOut = timeOut
            gameScene.isAlive = lives > 0
            view?.presentScene(gameScene, transition: .doorsOpenVertical(withDuration: 2))
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        if timeEnd == 0 {
            timeEnd = currentTime + timer
        } else if currentTime >= timeEnd {
            self.run(SKAction.playSoundFileNamed("bee_pickup.mp3", waitForCompletion: false))
            toGameOverScene(true)
        }
        
        
        
        
        
        // Two objects hit
        
        if isHit {
            if currentTime - hitCurrentTime > 1 {
                isHit = false
                bumbleBee!.zRotation = 0
                hitCurrentTime = 0
                bumbleBee!.removeAllActions()
                if bumbleBee!.action(forKey: "beeFly") == nil {
                    bumbleBee!.animate()
                }
                
                owl!.zRotation = 0
            } else {
                let rotate = 2 * (bumbleBee!.getAngle(currentTime - prevTime))
                hitTotalRotateAngle += rotate
                bumbleBee!.zRotation = CGFloat(hitTotalRotateAngle)
                
                owl!.zRotation = CGFloat(hitTotalRotateAngle)
            }
        }
        
        if !isHit {
            
            if self.isPressed {
                counter += 1
            } else {
                counter = 1
            }
            
            if counter > 1 {
                forceUp = 0.1 + 2.0/Float(counter)
                if forceUp > 0.5 {
                    forceUp = 0.5
                }
            } else {
                forceUp = 0
            }
            
            bumbleBee?.forceUp = forceUp
            
            // Collision BumbleBee and Owl
            if isCollision(bumbleBee, owl) {
                
                lives -= 1
                if lives == 0 {
                    toGameOverScene(false)
                }
                
                owl!.verticalSpeed = -3
                isHit = true
                hitCurrentTime = currentTime
                hitTotalRotateAngle = 0
                
                self.removeAllActions()
                
                if bumbleBee!.action(forKey: "hitInPlaceBee") == nil {
                    bumbleBee!.animateHit()
                    bumbleBee?.forceUp = -0.1
                }
            }
        
            // Collision BumbleBee and Flower
            if isCollision(bumbleBee, flower) {
                
                score += 1
                flower?.position.x = -1000
            }
        }
        

           
            background1?.Update(currentTime)
            background2?.Update(currentTime)
            green1?.Update(currentTime)
            green2?.Update(currentTime)
            owl?.Update(currentTime)
            flower?.Update(currentTime)
            bumbleBee?.Update(currentTime)
        
            timerLabel?.text = "\(Int(timeEnd-currentTime))"
            lifeLabel?.text = "Life: \(Int(lives))"
            scoreLabel?.text = "Score: \(Int(score)) / \(Int(highScore))"
            
            prevTime = currentTime
            
            
        }
        
            
    
    func isCollision(_ obj1: GameObject?, _ obj2: GameObject?) -> Bool {
        if obj1 != nil && obj2 != nil {
            let o1 = obj1!
            let o2 = obj2!
            if (abs(o1.position.x - o2.position.x)) <= o1.halfWidth!*o1.scale! + o2.halfWidth! * o2.scale!
                &&  (abs(o1.position.y - o2.position.y)) <= o1.halfHeight!*o1.scale! + o2.halfHeight! * o2.scale! {
                return true
            }
            return false
        }
        return false
    }
}

