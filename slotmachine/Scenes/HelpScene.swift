import SpriteKit
import GameplayKit

class HelpScene : SKScene
{
    
    var backButton: SKLabelNode!
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.white
        
        backButton = SKLabelNode(text: "Back")
        backButton.position = CGPoint(x: -230, y: 520)
        backButton.zPosition = 1
        backButton.fontName = "AmericanTypewriter-Bold"
        backButton.fontSize = CGFloat(30)
        backButton.fontColor = SKColor.black
        self.addChild(backButton)
        
        let winner = SKLabelNode(fontNamed: "Chalkduster")
        winner.text = "You Win!"
        winner.fontSize = 65
        winner.fontColor = SKColor.green
        winner.position = CGPoint(x: frame.midX, y: frame.midY)
           
        addChild(winner)

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if backButton.contains(location){
                
                if let view = self.view {
                    
                    let startScene = SKScene(fileNamed: "StartScene")
                    startScene?.scaleMode = .aspectFill
                    view.presentScene( startScene!, transition: SKTransition.fade(withDuration: 0.5) )
                }
            }
        }
        
    }
}
