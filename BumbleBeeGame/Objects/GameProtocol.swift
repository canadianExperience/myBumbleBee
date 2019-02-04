import SpriteKit

protocol GameProtocol {
    
    func Reset()
    
    func CheckBounds()
    
    func Start()
    
    func Update(_ currentTime: TimeInterval)
}
