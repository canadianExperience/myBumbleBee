import SpriteKit
import GameplayKit

class Background : GameObject {
    // Initializers
    init(_ scale: CGFloat) {
        // initialize the object with an image
        super.init(imageString: "sky", initialScale: scale)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func Start() {
        
        
        self.horizontalSpeed = 0.5
      
    }
    
    override func Reset() {
        self.zPosition = 0
        let delta = self.position.x + self.width!
        self.position.x = self.width! + delta
        
    }
    
    override func CheckBounds() {
        if(self.position.x <= -self.width!) {
            self.Reset()
        }
    }
    
    override func Update(_ currentTime: TimeInterval) {
        //self.position.y -= self.verticalSpeed!
        self.position.x -= self.horizontalSpeed!
        self.CheckBounds()
    }
    
}
