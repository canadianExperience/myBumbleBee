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
    
    let screenSize = UIScreen.main.bounds
    var scale: CGFloat = 0
    
    var background1: Background?
    var background2: Background?
    
    override func didMove(to view: SKView) {
        
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
        
        var message = ""
        if isAlive && score > topScore {
            message = "You won"
            UserDefaults.standard.set(score, forKey: "topScore")
        } else if timeOut {
            message = "Time expired"
        } else {
            message = "Game over"
        }
        
        messageLabel = self.childNode(withName: "message") as? SKLabelNode
        messageLabel?.text = message
        messageLabel?.verticalAlignmentMode = .center
        messageLabel?.horizontalAlignmentMode = .center
        messageLabel?.position = CGPoint(x: 0, y: 0)
        messageLabel?.zPosition = 1
        
        yourScoreLabel = self.childNode(withName: "yourScore") as? SKLabelNode
        yourScoreLabel?.text = "Your Score: \(score)"
        yourScoreLabel?.verticalAlignmentMode = .center
        yourScoreLabel?.horizontalAlignmentMode = .center
        yourScoreLabel?.position = CGPoint(x: -screenSize.width / 2 + 150, y: screenSize.size.height / 2 - 50)
       yourScoreLabel?.zPosition = 1
        
        topScoreLabel = self.childNode(withName: "topScore") as? SKLabelNode
        topScoreLabel?.text = "Top Score: \(topScore)"
        topScoreLabel?.verticalAlignmentMode = .center
        topScoreLabel?.horizontalAlignmentMode = .center
        topScoreLabel?.position = CGPoint(x: screenSize.width / 2 - 150, y: screenSize.size.height / 2 - 50)
        topScoreLabel?.zPosition = 1
        
        menuButton = self.childNode(withName: "toStartScene") as? SKLabelNode
        menuButton?.text = "Main Menu"
        menuButton?.verticalAlignmentMode = .center
        menuButton?.horizontalAlignmentMode = .center
        menuButton?.position = CGPoint(x: -screenSize.width / 2 + 150, y: -screenSize.size.height / 2 + 50)
       menuButton?.zPosition = 1
        
        quitButton = self.childNode(withName: "quitGame") as? SKLabelNode
        quitButton?.text = "Quit Game"
        quitButton?.verticalAlignmentMode = .center
        quitButton?.horizontalAlignmentMode = .center
        quitButton?.position = CGPoint(x: screenSize.width / 2 - 150, y:  -screenSize.size.height / 2 + 50)
        quitButton?.zPosition = 1
        
        
    }
    
    
//    func buttonSound() {
//        let action1 = SKAction.playSoundFileNamed("button.mp3", waitForCompletion: true)
//        self.run(action1)
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "toStartScene" {
                if let startScene = StartScene(fileNamed: "StartScene") {
                    startScene.scaleMode = .aspectFill
                    view?.presentScene(startScene)
                   // buttonSound()
//                    view?.presentScene(sartScene, transition: .doorsOpenVertical(withDuration: 2))
                }
            }
            
            if atPoint(location).name == "quitGame" {
              //  buttonSound()
                exit(0)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        background1?.Update(currentTime)
        background2?.Update(currentTime)
    }
}



