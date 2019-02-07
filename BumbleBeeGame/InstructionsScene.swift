
import UIKit
import SpriteKit
import Foundation

class InstructionsScene: SKScene {
    
    var backToMenuButton: SKLabelNode!
    var instructionsTextLabel: SKLabelNode!

    

    override func didMove(to view: SKView) {
        
        backToMenuButton = childNode(withName: "backToMenu") as! SKLabelNode
        
        instructionsTextLabel = childNode(withName: "instructionsText") as! SKLabelNode
//        
        instructionsTextLabel.text = "'BumbleBee' is an arcade game displays 'BumbleBee' character that has a purpose to pick up a maximum number of bonus 'Flowers'. BumbleBee should not contact enemies Owls, otherwise score points are deducted.  If user scores less then top level scores by the end of the time limit or fall to '0' the user loses and the game is over. If user exceeds max scores at the end of the time limit the user wins and reached scores set as a top amount"
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
