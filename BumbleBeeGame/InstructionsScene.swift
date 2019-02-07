
import UIKit
import SpriteKit
import Foundation

class InstructionsScene: SKScene {
    
    var backToMenuButton: SKLabelNode!
    var instructionsTextLabel: SKLabelNode!

    

    override func didMove(to view: SKView) {
        
        backToMenuButton = childNode(withName: "backToMenu") as! SKLabelNode
        backToMenuButton.fontName = "Futura-Bold"
       
        instructionsTextLabel = childNode(withName: "instructionsText") as! SKLabelNode
        instructionsTextLabel.fontName = "Futura-Bold"
//        
        instructionsTextLabel.text = "The goal of the “BumbleBee” arcade Game is exceeding top level score within limited time.  “BumbleBee” is a main character of the game.  The game scores are increasing while “BumbleBee” picks up “Flowers” and deducting while “BumbleBee” collides with enemies - “Owls”. Winning condition gains when user exceeds top scores within time limit, otherwise the user loses."
        instructionsTextLabel.numberOfLines = 0
        instructionsTextLabel.preferredMaxLayoutWidth = 600
        
        instructionsTextLabel.verticalAlignmentMode = .center
        instructionsTextLabel.horizontalAlignmentMode = .center
        instructionsTextLabel.position = CGPoint(x: 0, y: 0)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "backToMenu" {
                if let startScene = StartScene(fileNamed: "StartScene") {
                    startScene.scaleMode = .aspectFill
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
