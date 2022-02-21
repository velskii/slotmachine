import SpriteKit
import GameplayKit

class DocumentationScene : SKScene
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
        title.text = "Documentation"
        title.fontSize = 65
        title.fontColor = SKColor.green
        title.position = CGPoint(x: frame.midX, y: 400)
           
        addChild(title)
        
        let rules = SKLabelNode(fontNamed: "Chalkduster")
        rules.text = "Slotmachine application."
        rules.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        rules.numberOfLines = 3
        rules.preferredMaxLayoutWidth = 1000
        rules.fontSize = 30
        rules.fontColor = SKColor.green
        rules.position = CGPoint(x: -300, y: 200)
           
        addChild(rules)
        
        let rules1 = SKLabelNode(fontNamed: "Chalkduster")
        rules1.text = "Feiliang Zhou, StudentId: 301216989."
        rules1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        rules1.numberOfLines = 3
        rules1.preferredMaxLayoutWidth = 1000
        rules1.fontSize = 30
        rules1.fontColor = SKColor.green
        rules1.position = CGPoint(x: -300, y: 100)
           
        addChild(rules1)
        
        let rules2 = SKLabelNode(fontNamed: "Chalkduster")
        rules2.text = "Version: 1.1"
        rules2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        rules2.numberOfLines = 3
        rules2.preferredMaxLayoutWidth = 1000
        rules2.fontSize = 30
        rules2.fontColor = SKColor.green
        rules2.position = CGPoint(x: -300, y: 0)
           
        addChild(rules2)
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
