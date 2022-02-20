

import SpriteKit
import GameplayKit

class GameOverScene : SKScene
{
    // START button
    var restartButton: SKLabelNode!
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.white
        
        // slot graphic
        let slotGraphic = SKSpriteNode(texture: SKTexture(imageNamed: "slot-machine"), size: CGSize(width: 400, height: 150))
        slotGraphic.position = CGPoint(x: 0, y: self.frame.size.height * 0.5 - 275)
        slotGraphic.zPosition = 1
        self.addChild(slotGraphic)
        
        // RESTART button
        restartButton = SKLabelNode(text: "RESTART")
        restartButton.position = CGPoint(x: 0, y: -100)
        restartButton.zPosition = 1
        restartButton.fontName = "Chalkduster"
        restartButton.fontSize = CGFloat(65)
        restartButton.fontColor = SKColor.green
        self.addChild(restartButton)
        
        
        let txt = SKLabelNode(fontNamed: "Chalkduster")
        txt.text = "Game Over!"
        txt.fontSize = 65
        txt.fontColor = SKColor.init(red: 132, green: 0, blue: 102, alpha: 1)
        txt.position = CGPoint(x: 0, y: 130)
           
        addChild(txt)

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if restartButton.contains(location){
                
                if let view = self.view {
                    
                    let startScene = SKScene(fileNamed: "StartScene")
                    startScene?.scaleMode = .aspectFill
                    view.presentScene( startScene!, transition: SKTransition.fade(withDuration: 0.5) )
                }
            }
        }
        
    }
    
    
    
    
}
