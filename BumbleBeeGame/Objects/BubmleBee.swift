import SpriteKit
import GameplayKit

class BumbleBee : GameObject {
    
    var forceUp: Float = 0
    let graviry: Float = 0.05
    var verticalSpeed: Float = 0
    var verticalForce: Float = 0
    
    // set initial position
    var center: CGPoint = CGPoint(x: -screenSize.width/2 + 100, y: 0.0)
    
    private var beeFlyFrames: [SKTexture] = []
    private var beeHitFrames: [SKTexture] = []
    
    init() {
        // initialize the object with an image (animation)
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
        
        let beeHitAtlas = SKTextureAtlas(named: "BeeHitImages")
        var hitFrames: [SKTexture] = []
        
        let numHitImages = beeHitAtlas.textureNames.count
        for i in 1...numHitImages {
            let beeHitTextureName = "beehit\(i)"
            hitFrames.append(beeHitAtlas.textureNamed(beeHitTextureName))
        }
        beeHitFrames = hitFrames
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func Start() {
        self.zPosition = 2
    }
    
    override func Update(_ currentTime: TimeInterval) {
        
        // BumbleBee movement
        
        let angle = getAngle(currentTime)
        
        let xObj = 25 * CGFloat(sin(angle))
        let yObj = 25 * CGFloat(cos(angle))
        
        verticalForce = -graviry + forceUp
        verticalSpeed = verticalSpeed + verticalForce
        
        
        self.center.y =  self.center.y + CGFloat(verticalSpeed)
        let y = self.center.y + yObj
        
        if(y > screenSize.height / 2 - self.halfHeight!) {
            self.position.y = screenSize.height / 2 - self.halfHeight!
            if verticalSpeed > 0 {
                verticalSpeed = 0
            }
            verticalForce = -graviry
        } else if(y < -screenSize.height / 2 + self.halfHeight!) {
            // check the bottom boundary
            self.position.y = -screenSize.height / 2 + self.halfHeight!
            if verticalSpeed < 0 {
                verticalSpeed = 0
            }
            verticalForce = -graviry
        } else {
            self.position.y = y
        }
        self.position.x = self.center.x + xObj
    }
    
    // Circle flying (get angle position)
    func getAngle(_ currentTime: TimeInterval) -> Double{
        let integerPart = Int(currentTime)
        let floatPart = currentTime - Double(integerPart)
        let angle = 2 * Double.pi * floatPart
        return angle
    }
    
    // animation, BumbleBee is flying
    func animate() {
        self.run(SKAction.repeatForever(
            SKAction.animate(with: beeFlyFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                 withKey:"flyBee")
    }
    
    // animation, BumbleBee is Hitting
    func animateHit() {
        self.run(SKAction.repeatForever(
            SKAction.animate(with: beeHitFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                 withKey:"hitBee")
    }
}

