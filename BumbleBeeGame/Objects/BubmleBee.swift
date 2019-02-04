import SpriteKit
import GameplayKit

class BumbleBee : GameObject {
    var forceUp: Float = 0
    let graviry: Float = 0.05
    var verticalSpeed: Float = 0
    var verticalForce: Float = 0
    
    init() {
        super.init(imageString: "bumbleBee", initialScale: 0.5)
        self.Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func Start() {
        self.zPosition = 2
    }
    
    
    override func CheckBounds() {
        // check the top boundary
        if(self.position.y > screenSize.height - self.halfHeight!) {
            self.position.y = screenSize.height - self.halfHeight!
        }
        
        // check the bottom boundary
        if(self.position.y < -screenSize.height + self.halfHeight!) {
            self.position.y = -screenSize.height + self.halfHeight!
        }
    }
    
    override func Update(_ currentTime: TimeInterval) {
        verticalForce = -graviry + forceUp
        verticalSpeed = verticalSpeed + verticalForce
        //self.position.y = self.position.y + CGFloat(verticalSpeed)
        let y = self.position.y + CGFloat(verticalSpeed)
        
        // check the top boundary
//        if(y > screenSize.height / 2  - self.halfHeight!) {
//            self.position.y = screenSize.height / 2 - self.halfHeight!
//            verticalSpeed = 0
//        } else if(y < -screenSize.height / 2 + self.halfHeight!) {
//            // check the bottom boundary
//            self.position.y = -screenSize.height / 2 + self.halfHeight!
//            verticalSpeed = 0
//        } else {
//            self.position.y = y
//        }
        
        if(y > screenSize.height / 2 - self.halfHeight!) {
            self.position.y = screenSize.height / 2 - self.halfHeight!
            verticalSpeed = 0
        } else if(y < -screenSize.height / 2 + self.halfHeight!) {
            // check the bottom boundary
            self.position.y = -screenSize.height / 2 + self.halfHeight!
            verticalSpeed = 0
        } else {
            self.position.y = y
        }
        
        //CheckBounds(y)
    }
}
