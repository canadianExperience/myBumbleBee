import SpriteKit
import GameplayKit

class BumbleBee : GameObject {
    var forceUp: Float = 0
    let graviry: Float = 0.05
    var verticalSpeed: Float = 0
    var verticalForce: Float = 0
    
    var center: CGPoint = CGPoint(x: -270, y: 0.0)
    
    private var beeFlyFrames: [SKTexture] = []
    private var beeHitFrames: [SKTexture] = []
    
    init() {
        let beeAnimatedAtlas = SKTextureAtlas(named: "BeeImages")
        var beeFrames: [SKTexture] = []
        
        let numImages = beeAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let beeTextureName = "bee\(i)"
            beeFrames.append(beeAnimatedAtlas.textureNamed(beeTextureName))
        }
        beeFlyFrames = beeFrames
        
        let firstFrameTexture = beeFlyFrames[0]
        super.init(texture: firstFrameTexture, initialScale: 0.5)
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
        let y = self.position.y + CGFloat(verticalSpeed)
        
        
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
    
    func animate() {
        self.run(SKAction.repeatForever(
            SKAction.animate(with: beeFlyFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                 withKey:"flyBee")
    }
}
