import SpriteKit
import GameplayKit

class SupportScene : SKScene
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
        title.text = "Game Rules"
        title.fontSize = 65
        title.fontColor = SKColor.green
        title.position = CGPoint(x: frame.midX, y: frame.midY + 200)
           
        addChild(title)
        
        let txt1 = SKLabelNode(fontNamed: "Chalkduster")
        txt1.text = "Win: no blank, every 3 same items:"
        txt1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        txt1.fontSize = 30
        txt1.fontColor = SKColor.green
        txt1.position = CGPoint(x: -300, y: 100)
           
        addChild(txt1)
        
        let txt2 = SKLabelNode(fontNamed: "Chalkduster")
        txt2.text = "you will get 10-100 times of your bet."
        txt2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        txt2.fontSize = 30
        txt2.fontColor = SKColor.green
        txt2.position = CGPoint(x: -280, y: 0)
           
        addChild(txt2)
        
        let txt3 = SKLabelNode(fontNamed: "Chalkduster")
        txt3.text = "Jackpot Rule: 3 same Seven item."
        txt3.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        txt3.fontSize = 30
        txt3.fontColor = SKColor.green
        txt3.position = CGPoint(x: -280, y: -100)
           
        addChild(txt3)
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
