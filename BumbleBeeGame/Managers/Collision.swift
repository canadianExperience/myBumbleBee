import CoreGraphics
import SpriteKit

class Collision {
    
    static func isCollision(_ obj1: GameObject?, _ obj2: GameObject?) -> Bool {
        if obj1 != nil && obj2 != nil {
            let object1 = obj1!
            let object2 = obj2!
            if (abs(object1.position.x - object2.position.x)) <= object1.halfWidth!*object1.scale! + object2.halfWidth! * object2.scale!
                &&  (abs(object1.position.y - object2.position.y)) <= object1.halfHeight!*object1.scale! + object2.halfHeight! * object2.scale!
            {
                return true
            }
            return false
        }
        return false
    }
    
}
