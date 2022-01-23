/*
 File       : GameScene.swift
 Author     : Feiliang Zhou
 StudentId  : 301216989
 Date       : January 22, 2022
 Description: slotmachine
*/

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let slotOptios = ["bell", "cherry", "coin", "seven", "grape", "strawberry" ]
    var currentReelValue1: String = ""
    var currentReelValue2: String = ""
    var currentReelValue3: String = ""
    
    var wheelActive: Bool = false
    
    
    // CREDITS
    var creditLabel: SKLabelNode!
    var creditNumber: SKLabelNode!
    var credits:Int = 1000 {
        didSet {
            creditNumber.text = "\(credits)"
        }
    }
    
    // BETS
    var betLabel: SKLabelNode!
    var betNumber: SKLabelNode!
    var bets:Int = 50 {
        didSet {
            betNumber.text = "\(bets)"
        }
    }
    
    // WINNER PAID
    var winnerPaidLabel: SKLabelNode!
    var winnerPaidNumber: SKLabelNode!
    var winnerPaid:Int = 50 {
        didSet {
            winnerPaidNumber.text = "\(winnerPaid)"
        }
    }
    
    // 3 spin images as default images
    var spin_1: SKSpriteNode!
    var spin_2: SKSpriteNode!
    var spin_3: SKSpriteNode!
    
    // BETS 10 20 50 100
    var betLabel_10: SKLabelNode!
    var betLabel_20: SKLabelNode!
    var betLabel_50: SKLabelNode!
    var betLabel_100: SKLabelNode!
    
    // SPIN button
    var spinButton: SKNode!
    // RESET button
    var resetButton: SKNode!
    // QUIT button
    var quitButton: SKNode!
    
    var labelFontName: String = "AmericanTypewriter-Bold"
    var numberFontName: String = "BanglaSangamMN-Bold"
    var labelFontSize: Int = 25
    var numberFontSize: Int = 30
    
    
    override func didMove(to view: SKView) {
        
        // Jackpot Label
        let jackpotLabel = SKLabelNode(text: "JACKPOT")
        jackpotLabel.position = CGPoint(x: self.frame.size.width * 0.5 - 380, y: self.frame.size.height * 0.5 - 200)
        jackpotLabel.zPosition = 1
        jackpotLabel.fontName = labelFontName
        jackpotLabel.fontSize = CGFloat(36)
        //rgba(248, 179, 9, 1)
        jackpotLabel.fontColor = UIColor(displayP3Red: 248, green: 179, blue: 9, alpha: 1)
        self.addChild(jackpotLabel)
        
        // Jackpot Number
        let jackpotNumber = SKLabelNode(text: "888")
        jackpotNumber.position = CGPoint(x: self.frame.size.width * 0.5 - 380, y: self.frame.size.height * 0.5 - 240)
        jackpotNumber.zPosition = 1
        jackpotNumber.fontName = numberFontName
        jackpotNumber.fontSize = CGFloat(40)
        jackpotNumber.fontColor = UIColor.white
        self.addChild(jackpotNumber)
        
        
        // Credits number
        creditNumber = SKLabelNode(text: "1000")
        creditNumber.position = CGPoint(x: self.frame.size.width * 0.5 - 540, y: self.frame.size.height * 0.5 - 300)
        creditNumber.zPosition = 1
        creditNumber.fontName = numberFontName
        creditNumber.fontSize = CGFloat(numberFontSize)
        creditNumber.fontColor = UIColor.white
        credits = 2000
        self.addChild(creditNumber)
        
        // Credits label
        creditLabel = SKLabelNode(text: "CREDITS")
        creditLabel.position = CGPoint(x: self.frame.size.width * 0.5 - 540, y: self.frame.size.height * 0.5 - 330)
        creditLabel.zPosition = 1
        creditLabel.fontName = labelFontName
        creditLabel.fontSize = CGFloat(labelFontSize)
        creditLabel.fontColor = UIColor.white
        self.addChild(creditLabel)
        
        
        // Bets number
        betNumber = SKLabelNode(text: "50")
        betNumber.position = CGPoint(x: self.frame.size.width * 0.5 - 380, y: self.frame.size.height * 0.5 - 300)
        betNumber.zPosition = 1
        betNumber.fontName = numberFontName
        betNumber.fontSize = CGFloat(numberFontSize)
        betNumber.fontColor = UIColor.white
        credits = 50
        self.addChild(betNumber)
        
        // Bets label
        betLabel = SKLabelNode(text: "BETS")
        betLabel.position = CGPoint(x: self.frame.size.width * 0.5 - 380, y: self.frame.size.height * 0.5 - 330)
        betLabel.zPosition = 1
        betLabel.fontName = labelFontName
        betLabel.fontSize = CGFloat(labelFontSize)
        betLabel.fontColor = UIColor.white
        self.addChild(betLabel)
        
        
        // WinnerPaid number
        winnerPaidNumber = SKLabelNode(text: "200")
        winnerPaidNumber.position = CGPoint(x: self.frame.size.width * 0.5 - 220, y: self.frame.size.height * 0.5 - 300)
        winnerPaidNumber.zPosition = 1
        winnerPaidNumber.fontName = numberFontName
        winnerPaidNumber.fontSize = CGFloat(numberFontSize)
        winnerPaidNumber.fontColor = UIColor.white
        winnerPaid = 200
        self.addChild(winnerPaidNumber)
        
        // WinnerPaid label
        winnerPaidLabel = SKLabelNode(text: "WINNER PAID")
        winnerPaidLabel.position = CGPoint(x: self.frame.size.width * 0.5 - 220, y: self.frame.size.height * 0.5 - 330)
        winnerPaidLabel.zPosition = 1
        winnerPaidLabel.fontName = labelFontName
        winnerPaidLabel.fontSize = CGFloat(labelFontSize)
        winnerPaidLabel.fontColor = UIColor.white
        self.addChild(winnerPaidLabel)
        
        
        
        // black background
        let bg_black = SKShapeNode(rectOf: CGSize(width: 600, height: 1200))
        bg_black.zPosition = -4
        bg_black.fillColor = UIColor(red: 51, green: 51, blue: 51, alpha: 1)
        bg_black.position = CGPoint(x: 0, y: 0)
        self.addChild(bg_black)
        
        // red background
        let bg_red = SKShapeNode(rectOf: CGSize(width: 500, height: 1000))
        bg_red.zPosition = -3
        bg_red.fillColor = UIColor(red: 192, green: 0, blue: 0, alpha: 1)
        bg_red.position = CGPoint(x: 0, y: 0)
        self.addChild(bg_red)
        
        // orange background
        let bg_org = SKShapeNode(rectOf: CGSize(width: 480, height: 360))
        bg_org.zPosition = -2
        bg_org.fillColor = UIColor(red: 250, green: 93, blue: 9, alpha: 1)
        bg_org.position = CGPoint(x: 0, y: 0)
        self.addChild(bg_org)
        
        // lite color column rgba(249, 252, 247, 1)
        let bg_lc1 = SKShapeNode(rectOf: CGSize(width: 150, height: 266))
        bg_lc1.zPosition = -1
        bg_lc1.fillColor = UIColor(red: 24, green: 25, blue: 24, alpha: 1)
        bg_lc1.position = CGPoint(x: -160, y: 0)
        self.addChild(bg_lc1)
        
        let bg_lc2 = SKShapeNode(rectOf: CGSize(width: 150, height: 266))
        bg_lc2.zPosition = -1
        bg_lc2.fillColor = UIColor(red: 24, green: 25, blue: 24, alpha: 1)
        bg_lc2.position = CGPoint(x: 0, y: 0)
        self.addChild(bg_lc2)
        
        let bg_lc3 = SKShapeNode(rectOf: CGSize(width: 150, height: 266))
        bg_lc3.zPosition = -1
        bg_lc3.fillColor = UIColor(red: 24, green: 25, blue: 24, alpha: 1)
        bg_lc3.position = CGPoint(x: 160, y: 0)
        self.addChild(bg_lc3)
        
        // 3 spins
        spin_1 = SKSpriteNode(imageNamed: "spin")
        spin_1.size = CGSize(width: 150, height: 150)
        spin_1.position = CGPoint(x: -160, y: 0)
        spin_1.zPosition = 1
        self.addChild(spin_1)
        // 2 spin
        spin_2 = SKSpriteNode(imageNamed: "spin")
        spin_2.size = CGSize(width: 150, height: 150)
        spin_2.position = CGPoint(x: 0, y: 0)
        spin_2.zPosition = 1
        self.addChild(spin_2)
        // 3 spin
        spin_3 = SKSpriteNode(imageNamed: "spin")
        spin_3.size = CGSize(width: 150, height: 150)
        spin_3.position = CGPoint(x: 160, y: 0)
        spin_3.zPosition = 1
        self.addChild(spin_3)
        
        
        
        // Bet 10 label
        betLabel_10 = SKLabelNode(text: "10")
        betLabel_10.position = CGPoint(x: -180, y: -250)
        betLabel_10.zPosition = 1
        betLabel_10.fontName = labelFontName
        betLabel_10.fontSize = CGFloat(labelFontSize)
        betLabel_10.fontColor = UIColor.white
        self.addChild(betLabel_10)
        
        // Bet 20 label
        betLabel_20 = SKLabelNode(text: "20")
        betLabel_20.position = CGPoint(x: -65, y: -250)
        betLabel_20.zPosition = 1
        betLabel_20.fontName = labelFontName
        betLabel_20.fontSize = CGFloat(labelFontSize)
        betLabel_20.fontColor = UIColor.white
        self.addChild(betLabel_20)
        
        // Bet 50 label
        betLabel_50 = SKLabelNode(text: "50")
        betLabel_50.position = CGPoint(x: 65, y: -250)
        betLabel_50.zPosition = 1
        betLabel_50.fontName = labelFontName
        betLabel_50.fontSize = CGFloat(labelFontSize)
        betLabel_50.fontColor = UIColor.white
        self.addChild(betLabel_50)
        
        // Bet 100 label
        betLabel_100 = SKLabelNode(text: "100")
        betLabel_100.position = CGPoint(x: 180, y: -250)
        betLabel_100.zPosition = 1
        betLabel_100.fontName = labelFontName
        betLabel_100.fontSize = CGFloat(labelFontSize)
        betLabel_100.fontColor = UIColor.white
        self.addChild(betLabel_100)
        
        // SPIN button
        spinButton = SKSpriteNode(texture: SKTexture(imageNamed: "spin"), color: UIColor.white, size: CGSize(width: 150, height: 100))
        spinButton.position = CGPoint(x: 0, y: -350)
        spinButton.zPosition = 1
        self.addChild(spinButton)
        
        // RESET button
        resetButton = SKSpriteNode(texture: SKTexture(imageNamed: "reset"), size: CGSize(width: 120, height: 100))
        resetButton.position = CGPoint(x: -180, y: -450)
        resetButton.zPosition = 1
        self.addChild(resetButton)
        
        // QUIT button
        quitButton = SKSpriteNode(texture: SKTexture(imageNamed: "quit"), color: UIColor.white, size: CGSize(width: 100, height: 44))
        quitButton.position = CGPoint(x: 180, y: -450)
        quitButton.zPosition = 1
        self.addChild(quitButton)
        
        
        
    }
    
   
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        for touch in touches {
            let location = touch.location(in: self)
            if spinButton.contains(location) {
                print("spinning ~~~!")
                
                wheelActive = true
    
                let wait: SKAction = SKAction.wait(forDuration: 1)
                let spinReel1: SKAction = SKAction.run {
                    self.spinReel(whichReel: 1)
                }
    
                let spinReel2: SKAction = SKAction.run {
                    self.spinReel(whichReel: 2)
                }
                let spinReel3: SKAction = SKAction.run {
                    self.spinReel(whichReel: 3)
                }
                let testReelValues: SKAction = SKAction.run {
                    self.testValues()
                }
                self.run(SKAction.sequence([
                    wait,
                    spinReel1,
                    wait,
                    spinReel2,
                    wait,
                    spinReel3,
                    wait,
                    testReelValues
                ]))
            }
        }
    

    
    }
    
    func spinReel(whichReel: Int) -> Void
    {
        let randomNum: UInt32 = arc4random_uniform( UInt32(slotOptios.count))
        
        let reelPick: String = slotOptios[ Int(randomNum) ]
        print("Reel \(whichWheel) spun a value of \(reelPick)")
        
        if(whichReel == 1)
        {
            currentReelValue1 = reelPick
            spin_1.texture = SKTexture(imageNamed: reelPick)
        } else if(whichReel == 2)
        {
            currentReelValue2 = reelPick
            spin_2.texture = SKTexture(imageNamed: reelPick)
        } else if(whichReel == 3)
        {
            currentReelValue3 = reelPick
            spin_3.texture = SKTexture(imageNamed: reelPick)
        }
    }
    
    func testValues()
    {
        if (currentReelValue1 == currentReelValue2 && currentReelValue2 == currentReelValue3)
        {
            print("they all match!!!")
        } else {
            print("you lose, sucker~")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
