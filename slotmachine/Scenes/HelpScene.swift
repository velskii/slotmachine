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
        
        let title = SKLabelNode(fontNamed: "Chalkduster")
        title.text = "Help"
        title.fontSize = 65
        title.fontColor = SKColor.green
        title.position = CGPoint(x: frame.midX, y: 400)
           
        addChild(title)
        
        let txt1 = SKLabelNode(fontNamed: "Chalkduster")
        txt1.text = "Bet your money first"
        txt1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        txt1.fontSize = 30
        txt1.fontColor = SKColor.green
        txt1.position = CGPoint(x: -280, y: 100)
           
        addChild(txt1)
        
        let txt2 = SKLabelNode(fontNamed: "Chalkduster")
        txt2.text = "click the spin button to start the game!"
        txt2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        txt2.fontSize = 30
        txt2.fontColor = SKColor.green
        txt2.position = CGPoint(x: -280, y: 0)
           
        addChild(txt2)

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if backButton.contains(location){
                
                if let view = self.view {
                    
                    let startScene = SKScene(fileNamed: "GameScene")
                    startScene?.scaleMode = .aspectFill
                    view.presentScene( startScene!, transition: SKTransition.fade(withDuration: 0.5) )
                }
            }
        }
        
    }
}
