import Foundation
import SpriteKit

class BossHero: Hero {
    weak var state: BossState!
    
    override func setUp(for state: GameState) {
        super.setUp(for: state)
        self.state = state as? BossState
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
    override func didCollide(with node: SKNode?) {
        super.didCollide(with: node)
    }
}
