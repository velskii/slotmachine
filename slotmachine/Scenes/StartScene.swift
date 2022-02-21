
import SpriteKit
import GameplayKit
import FirebaseAuth

class StartScene : SKScene
{
    
    // START button
    var startButton: SKLabelNode!
    // HELP button
    var helpButton: SKLabelNode!
    // SUPPORT button
    var supportButton: SKLabelNode!
    // DOCUMENTATION button
    var documentationButton: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor.white
        
        let firebaseStore = FirebaseManager()
        firebaseStore.getGlobalData(key: "global_jackpot")
        
        // slot graphic
        let slotGraphic = SKSpriteNode(texture: SKTexture(imageNamed: "slot-machine"), size: CGSize(width: 400, height: 150))
        slotGraphic.position = CGPoint(x: 0, y: self.frame.size.height * 0.5 - 245)
        slotGraphic.zPosition = 1
        self.addChild(slotGraphic)
        
        // START button
        startButton = SKLabelNode(text: "START")
        startButton.position = CGPoint(x: 0, y: 0)
        startButton.zPosition = 1
        startButton.fontName = "Chalkduster"
        startButton.fontSize = CGFloat(100)
        startButton.fontColor = SKColor.init(red: 132, green: 0, blue: 102, alpha: 1)
        self.addChild(startButton)
        
        // HELP button
        helpButton = SKLabelNode(text: "Help")
        helpButton.position = CGPoint(x: -200, y: -300)
        helpButton.zPosition = 1
        helpButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        helpButton.fontName = "AmericanTypewriter-Bold"
        helpButton.fontSize = CGFloat(25)
        helpButton.fontColor = SKColor.black
        self.addChild(helpButton)
        
        // SUPPORT button
        supportButton = SKLabelNode(text: "Support")
        supportButton.position = CGPoint(x: -200, y: -350)
        supportButton.zPosition = 1
        supportButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        supportButton.fontName = "AmericanTypewriter-Bold"
        supportButton.fontSize = CGFloat(25)
        supportButton.fontColor = SKColor.black
        self.addChild(supportButton)
        
        // DOCUMENTATION button
        documentationButton = SKLabelNode(text: "Documentation")
        documentationButton.position = CGPoint(x: -200, y: -400)
        documentationButton.zPosition = 1
        documentationButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        documentationButton.fontName = "AmericanTypewriter-Bold"
        documentationButton.fontSize = CGFloat(25)
        documentationButton.fontColor = SKColor.black
        self.addChild(documentationButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if startButton.contains(location){
                if let view = self.view {
                    if let scene = SKScene(fileNamed: "GameScene") {
                        scene.scaleMode = .aspectFill
                        view.presentScene(scene)
                    }
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
            
            if helpButton.contains(location){
                
                if let view = self.view {
                    
                    let helpScene = SKScene(fileNamed: "HelpScene")
                    helpScene?.scaleMode = .aspectFill
                    view.presentScene( helpScene!, transition: SKTransition.fade(withDuration: 0.5) )
                }
            }
            
            if supportButton.contains(location){
                
                if let view = self.view {
                    
                    let helpScene = SKScene(fileNamed: "SupportScene")
                    helpScene?.scaleMode = .aspectFill
                    view.presentScene( helpScene!, transition: SKTransition.fade(withDuration: 0.5) )
                }
            }
            
            if documentationButton.contains(location){
                
                if let view = self.view {
                    
                    let helpScene = SKScene(fileNamed: "DocumentationScene")
                    helpScene?.scaleMode = .aspectFill
                    view.presentScene( helpScene!, transition: SKTransition.fade(withDuration: 0.5) )
                }
            }
        }
        
        
    }
    
    
    
    
}
