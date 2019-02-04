import SpriteKit
import GameplayKit

class Owl : GameObject {
    
    // Initializers
    init() {
        super.init(imageString: "owl", initialScale: 1.0)
        self.Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // class functions
    
    override func Start() {
        //self.verticalSpeed = 10
        self.horizontalSpeed = 5.0
        self.zPosition = 2
        self.Reset()
    }
    
    override func Reset() {
        self.position.x = 1440 * scale! + self.width!
//        let randomY:Int =
//            (self.randomSource?.nextInt(upperBound: (Int(screenSize.height * 2.0))))! - Int(screenSize.height)
        
        // max Y upperBound coordinate to place owl
        let upperBound = Int(screenSize.size.height) - Int(self.height!)
        
        let randomY:Int = Int(self.halfHeight!) +
            (self.randomSource?.nextInt(upperBound: (Int(upperBound))))! - Int(screenSize.height / 2.0)
        //let randomY:Int = 0
        self.position.y = CGFloat(randomY)
    }
    
    override func CheckBounds() {
        if(self.position.x < -1440 * scale! - self.width! ) {
            self.Reset()
        }
    }
    
    override func Update(_ currentTime: TimeInterval) {
        //self.position.y -= self.verticalSpeed!
        self.position.x -= self.horizontalSpeed!
        self.CheckBounds()
    }
}
