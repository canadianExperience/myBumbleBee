import SpriteKit
import GameplayKit

class Flower : GameObject {
    
    // Initializers
    init() {
        super.init(imageString: "flower", initialScale: 0.3)
        self.Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // class functions
    
    override func Start() {
        self.horizontalSpeed = 2.0
        self.zPosition = 2
        self.Reset()
    }
    
    override func Reset() {
        
        // random X flower position
        let randomX = Int(arc4random_uniform(UInt32(screenSize.size.width)))
        self.position.x = screenSize.size.width / 2 + self.width! + CGFloat(randomX)
        
        // max Y upperBound coordinate to place flower
        let upperBound = Int(screenSize.size.height) - Int(self.height!)
        
        // random Y flower position
        let randomY:Int = Int(self.halfHeight!) +
            (self.randomSource?.nextInt(upperBound: (Int(upperBound))))! - Int(screenSize.height / 2.0)
        self.position.y = CGFloat(randomY)
    }
    
    override func CheckBounds() {
        if(self.position.x < -(screenSize.size.width / 2 + self.width! + 30) ) {
            self.Reset()
        }
    }
    
    override func Update(_ currentTime: TimeInterval) {
        self.position.x -= self.horizontalSpeed!
        self.CheckBounds()
    }
}
