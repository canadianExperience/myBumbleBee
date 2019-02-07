import SpriteKit
import GameplayKit

class Owl : GameObject {
    var verticalSpeed: Float = 1
    
    private var owlFrames: [SKTexture] = []
    
    // Initializers
    init() {
        let owlAnimatedAtlas = SKTextureAtlas(named: "OwlImages")
        var frames: [SKTexture] = []
        
        let numImages = owlAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let owlTextureName = "owl\(i)"
            frames.append(owlAnimatedAtlas.textureNamed(owlTextureName))
        }
        owlFrames = frames
        
        let firstFrameTexture = owlFrames[0]
        super.init(texture: firstFrameTexture, initialScale: 1.0)
//        super.init(imageString: "owl", initialScale: 1.0)
        self.Start()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // class functions
    func animate() {
        self.run(SKAction.repeatForever(
            SKAction.animate(with: owlFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                 withKey:"flyOwl")
    }
    
    override func Start() {
        self.verticalSpeed = 1
        self.horizontalSpeed = 4.0
        self.zPosition = 2
        self.Reset()
    }
    
    override func Reset() {
        let randomX = Int(arc4random_uniform(UInt32(screenSize.size.width)))
        self.position.x = screenSize.size.width / 2 + self.width! + CGFloat(randomX)
        
        // max Y upperBound coordinate to place owl
        let upperBound = Int(screenSize.size.height) - Int(self.height!)
        let randomY:Int = Int(self.halfHeight!) +
            (self.randomSource?.nextInt(upperBound: (Int(upperBound))))! - Int(screenSize.height / 2.0)
        self.position.y = CGFloat(randomY)
    }
    
    override func CheckBounds() {
        if(self.position.x < -(screenSize.size.width / 2 + self.width! + 30) ) {
            self.Reset()
        }
        if self.position.y > (screenSize.size.height / 2 - self.halfHeight!) {
            self.position.y = screenSize.size.height / 2 - self.halfHeight!
            verticalSpeed = -verticalSpeed
        }
        if self.position.y < -(screenSize.size.height / 2 - self.halfHeight!) {
            self.position.y = -(screenSize.size.height / 2 - self.halfHeight!)
            verticalSpeed = -verticalSpeed
        }
    }
    
    override func Update(_ currentTime: TimeInterval) {
        self.position.y += CGFloat(verticalSpeed)
        self.position.x -= self.horizontalSpeed!
        self.CheckBounds()
    }
}
