/*
 File       : GameScene.swift
 Author     : Feiliang Zhou
 StudentId  : 301216989
 Date       : February 19, 2022
 Description: slotmachine
*/

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    let slotOptios = ["blank", "bell", "cherry", "coin", "seven", "grape", "strawberry" ]
    
    var blank: Int32 = 0
    var bell: Int32 = 0
    var cherry: Int32 = 0
    var coin: Int32 = 0
    var grape: Int32 = 0
    var strawberry: Int32 = 0
    var seven: Int32 = 0
    
    var currentReelValue1: String = ""
    var currentReelValue2: String = ""
    var currentReelValue3: String = ""
    let initialCredits = 200;
    
    
    var wins: Double = 0 {
        didSet {
            winsLabel.text = "Wins: \(wins)"
        }
    }
    var losses: Double! = 0  {
        didSet {
            lossesLabel.text = "Losses: \(losses ?? 0)"
        }
    }
    var winRatio: Double! = 0 {
        didSet {
            winRatioLabel.text = "WinRatio: \(winRatio ?? 0)%"
        }
    }
    var turn: Int = 0 {
        didSet {
            turnLabel.text = "Turns: \(turn)"
        }
    }
    
    var jackpot: Int = 5000 {
        didSet {
            jackpotNumber.text = "\(jackpot)"
        }
    }
    
    var resultLabel: SKLabelNode!
    var winsLabel: SKLabelNode!
    var lossesLabel: SKLabelNode!
    var winRatioLabel: SKLabelNode!
    var turnLabel: SKLabelNode!
    var jackpotNumber: SKLabelNode!
    
    var jackpotLabel: SKLabelNode!
    
    
    
    var wheelActive: Bool = false
    
    
    // CREDITS
    var creditLabel: SKLabelNode!
    var creditNumber: SKLabelNode!
    var credits:Int = 200 {
        didSet {
            creditNumber.text = "\(credits)"
        }
    }
    
    // BETS
    var betLabel: SKLabelNode!
    var betNumber: SKLabelNode!
    var bets:Int = 0 {
        didSet {
            betNumber.text = "\(bets)"
        }
    }
    
    // WINNER PAID
    var winnerPaidLabel: SKLabelNode!
    var winnerPaidNumber: SKLabelNode!
    var winnerPaid:Int = 0 {
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
    var spinButton: SKSpriteNode!
    // RESET button
    var resetButton: SKNode!
    // QUIT button
    var quitButton: SKNode!
    
    var labelFontName: String = "AmericanTypewriter-Bold"
    var numberFontName: String = "BanglaSangamMN-Bold"
    var labelFontSize: Int = 25
    var numberFontSize: Int = 30
    
    
    override func didMove(to view: SKView) {
        
        // Sounds
        let backgroundMusic = SKAudioNode(fileNamed: "background-music.mp3")
        self.addChild(backgroundMusic)
        backgroundMusic.autoplayLooped = true
        
        // preload / prewarm impulse
        do{
            let sounds:[String] = ["spin", "win", "game-over", "casino-chips", "chimeup", "high-score", "riseup"]
            for sound in sounds
            {
                let path: String = Bundle.main.path(forResource: sound, ofType: "mp3")!
                let url: URL = URL(fileURLWithPath: path)
                let player: AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
            }
        }
        catch
        {
            
        }

        // resultLabel
        resultLabel = SKLabelNode(text: "Let's spin~")
        resultLabel.position = CGPoint(x: self.frame.size.width * 0.5 - 540, y: self.frame.size.height * 0.5 - 435)
        resultLabel.zPosition = 1
        resultLabel.fontName = labelFontName
        resultLabel.fontSize = CGFloat(25)
        //rgba(248, 179, 9, 1)
        resultLabel.fontColor = UIColor(displayP3Red: 248, green: 179, blue: 9, alpha: 1)
        self.addChild(resultLabel)
        
        // turnLabel
        turnLabel = SKLabelNode(text: "Turns: 0")
        turnLabel.position = CGPoint(x: self.frame.size.width * 0.5 - 350, y: self.frame.size.height * 0.5 - 435)
        turnLabel.zPosition = 1
        turnLabel.fontName = labelFontName
        turnLabel.fontSize = CGFloat(25)
        //rgba(248, 179, 9, 1)
        turnLabel.fontColor = UIColor(displayP3Red: 248, green: 179, blue: 9, alpha: 1)
        self.addChild(turnLabel)
        
        // winsLabel
        winsLabel = SKLabelNode(text: "Wins: 0")
        winsLabel.position = CGPoint(x: self.frame.size.width * 0.5 - 550, y: self.frame.size.height * 0.5 - 465)
        winsLabel.zPosition = 1
        winsLabel.fontName = labelFontName
        winsLabel.fontSize = CGFloat(25)
        //rgba(248, 179, 9, 1)
        winsLabel.fontColor = UIColor(displayP3Red: 248, green: 179, blue: 9, alpha: 1)
        self.addChild(winsLabel)
        
        // lossesLabel
        lossesLabel = SKLabelNode(text: "Losses: 0")
        lossesLabel.position = CGPoint(x: self.frame.size.width * 0.5 - 400, y: self.frame.size.height * 0.5 - 465)
        lossesLabel.zPosition = 1
        lossesLabel.fontName = labelFontName
        lossesLabel.fontSize = CGFloat(25)
        //rgba(248, 179, 9, 1)
        lossesLabel.fontColor = UIColor(displayP3Red: 248, green: 179, blue: 9, alpha: 1)
        self.addChild(lossesLabel)
        
        // winRatioLabel
        winRatioLabel = SKLabelNode(text: "WinRatio: 0%")
        winRatioLabel.position = CGPoint(x: self.frame.size.width * 0.5 - 220, y: self.frame.size.height * 0.5 - 465)
        winRatioLabel.zPosition = 1
        winRatioLabel.fontName = labelFontName
        winRatioLabel.fontSize = CGFloat(25)
        //rgba(248, 179, 9, 1)
        winRatioLabel.fontColor = UIColor(displayP3Red: 248, green: 179, blue: 9, alpha: 1)
        self.addChild(winRatioLabel)
        
        
        
        
        // slot graphic
        let slotGraphic = SKSpriteNode(texture: SKTexture(imageNamed: "slot-machine"), size: CGSize(width: 400, height: 150))
        slotGraphic.position = CGPoint(x: self.frame.size.width * 0.5 - 380, y: self.frame.size.height * 0.5 - 145)
        slotGraphic.zPosition = 1
        self.addChild(slotGraphic)
        
        // Jackpot Label
        jackpotLabel = SKLabelNode(text: "JACKPOT")
        jackpotLabel.position = CGPoint(x: self.frame.size.width * 0.5 - 380, y: self.frame.size.height * 0.5 - 250)
        jackpotLabel.zPosition = 1
        jackpotLabel.fontName = labelFontName
        jackpotLabel.fontSize = CGFloat(36)
        //rgba(248, 179, 9, 1)
        jackpotLabel.fontColor = UIColor(displayP3Red: 248, green: 179, blue: 9, alpha: 1)
        self.addChild(jackpotLabel)
        
        // Jackpot Number
        jackpotNumber = SKLabelNode(text: "5000")
        jackpotNumber.position = CGPoint(x: self.frame.size.width * 0.5 - 380, y: self.frame.size.height * 0.5 - 290)
        jackpotNumber.zPosition = 1
        jackpotNumber.fontName = numberFontName
        jackpotNumber.fontSize = CGFloat(40)
        jackpotNumber.fontColor = UIColor.white
        self.addChild(jackpotNumber)
        
        
        // Credits number
        creditNumber = SKLabelNode(text: "\(initialCredits)")
        creditNumber.position = CGPoint(x: self.frame.size.width * 0.5 - 540, y: self.frame.size.height * 0.5 - 350)
        creditNumber.zPosition = 1
        creditNumber.fontName = numberFontName
        creditNumber.fontSize = CGFloat(numberFontSize)
        creditNumber.fontColor = UIColor.white
        self.addChild(creditNumber)
        
        // Credits label
        creditLabel = SKLabelNode(text: "CREDITS")
        creditLabel.position = CGPoint(x: self.frame.size.width * 0.5 - 540, y: self.frame.size.height * 0.5 - 380)
        creditLabel.zPosition = 1
        creditLabel.fontName = labelFontName
        creditLabel.fontSize = CGFloat(labelFontSize)
        creditLabel.fontColor = UIColor.white
        self.addChild(creditLabel)
        
        
        // Bets number
        betNumber = SKLabelNode(text: "0")
        betNumber.position = CGPoint(x: self.frame.size.width * 0.5 - 380, y: self.frame.size.height * 0.5 - 350)
        betNumber.zPosition = 1
        betNumber.fontName = numberFontName
        betNumber.fontSize = CGFloat(numberFontSize)
        betNumber.fontColor = UIColor.white
        self.addChild(betNumber)
        
        // Bets label
        betLabel = SKLabelNode(text: "BETS")
        betLabel.position = CGPoint(x: self.frame.size.width * 0.5 - 380, y: self.frame.size.height * 0.5 - 380)
        betLabel.zPosition = 1
        betLabel.fontName = labelFontName
        betLabel.fontSize = CGFloat(labelFontSize)
        betLabel.fontColor = UIColor.white
        self.addChild(betLabel)
        
        
        // WinnerPaid number
        winnerPaidNumber = SKLabelNode(text: "0")
        winnerPaidNumber.position = CGPoint(x: self.frame.size.width * 0.5 - 220, y: self.frame.size.height * 0.5 - 350)
        winnerPaidNumber.zPosition = 1
        winnerPaidNumber.fontName = numberFontName
        winnerPaidNumber.fontSize = CGFloat(numberFontSize)
        winnerPaidNumber.fontColor = UIColor.white
        self.addChild(winnerPaidNumber)
        
        // WinnerPaid label
        winnerPaidLabel = SKLabelNode(text: "WINNER PAID")
        winnerPaidLabel.position = CGPoint(x: self.frame.size.width * 0.5 - 220, y: self.frame.size.height * 0.5 - 380)
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
            
            if betLabel_10.contains(location){
                if (credits < 10) {
                    showToast(message: "You don't have enough money.", font: UIFont(name: "AvenirNextCondensed-Heavy", size: 30)!)
                    spinButton.texture = SKTexture(imageNamed: "grey_spin");
                }else {
                    bets = 10
                }
            }
            if betLabel_20.contains(location){
                if (credits < 20) {
                    showToast(message: "You don't have enough money.", font: UIFont(name: "AvenirNextCondensed-Heavy", size: 30)!)
                    spinButton.texture = SKTexture(imageNamed: "grey_spin");
                } else {
                    bets = 20
                }
            }
            if betLabel_50.contains(location){
                if (credits < 50) {
                    showToast(message: "You don't have enough money.", font: UIFont(name: "AvenirNextCondensed-Heavy", size: 30)!)
                    spinButton.texture = SKTexture(imageNamed: "grey_spin");
                } else {
                    bets = 50
                }
            }
            if betLabel_100.contains(location){
                if (credits < 100) {
                    showToast(message: "You don't have enough money.", font: UIFont(name: "AvenirNextCondensed-Heavy", size: 30)!)
                    spinButton.texture = SKTexture(imageNamed: "grey_spin");
                } else {
                    bets = 100
                }
            }
            
            if quitButton.contains(location){
                scene?.run(SKAction.playSoundFileNamed("game-over", waitForCompletion: false))
                
                setScene(sceneName: "GameOverScene")
            }
            
            if resetButton.contains(location){
                print("Resetting ~~~")
                spinButton.texture = SKTexture(imageNamed: "spin");
                jackpot = 5000
                turn = 0
                bets = 0
                credits = initialCredits
                winRatio = 0
                spin_1.texture = SKTexture(imageNamed: "spin")
                spin_2.texture = SKTexture(imageNamed: "spin")
                spin_3.texture = SKTexture(imageNamed: "spin")
            }
            
            
            if spinButton.contains(location) {
                if ( (credits == 0) || (credits < bets) ) {
                    showToast(message: "You don't have enough money.", font: UIFont(name: "AvenirNextCondensed-Heavy", size: 15)!)
                    bets = 0;
                    spinButton.texture = SKTexture(imageNamed: "grey_spin");
                    return;
                }
                if (bets == 0) {
                    showToast(message: "You should bet money first.", font: UIFont(name: "AvenirNextCondensed-Heavy", size: 15)!)
                    return;
                }
                
                print("spinning ~~~!")
                
                wheelActive = true
    
                let wait: SKAction = SKAction.wait(forDuration: 0.2)
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
                    self.clearState()
                }
                self.run(SKAction.sequence([
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
    
    func clearState()
    {
        blank = 0
        bell = 0
        cherry = 0
        coin = 0
        grape = 0
        strawberry = 0
        seven = 0
    }
    
    func setScene(sceneName:String)
    {
        if let view = self.view {
            if let scene = SKScene(fileNamed: sceneName) {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
        }
    }
    
    func spinReel(whichReel: Int) -> Void
    {
        scene?.run(SKAction.playSoundFileNamed("spin", waitForCompletion: false))
        
        let randomNum: UInt32 = arc4random_uniform( UInt32(100))
        //  ["bell", "cherry", "coin", "seven", "grape", "strawberry" ]
        var reelPick: String = "bell"
        
        switch randomNum
        {
            case 0..<50: // 50% probability
                reelPick = "blank"
                blank += 1
                break
            case 50..<80: // 30% probability
                reelPick = "cherry"
                cherry += 1
                break
            case 80..<90: // 10% probability
                reelPick = "grape"
                grape += 1
                break
            case 90..<94: // 4% probability
                reelPick = "strawberry"
                strawberry += 1
                break
            case 94..<97: // 3% probability
                reelPick = "bell"
                coin += 1
                break
            case 97..<99: // 2% probability
                reelPick = "coin"
                coin += 1
                break
            case 99..<100: // 1% probability
                reelPick = "seven"
                seven += 1
                break
            default:
                break
        }
//        let reelPick: String = slotOptios[ Int(randomNum) ]
        print("Reel \(whichReel) spun a value of \(reelPick)")
        
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
        turn += 1
        //  ["bell", "cherry", "coin", "seven", "grape", "strawberry" ]
        if (blank < 1) // win
        {
            wins += 1
            resultLabel.text = "You win!!!!"
            if (bell == 3) {
                winnerPaid = bets * 10;
            }
            else if(cherry == 3) {
                winnerPaid = bets * 20;
            }
            else if (grape == 3) {
                winnerPaid = bets * 30;
            }
            else if (strawberry == 3) {
                winnerPaid = bets * 40;
            }
            else if (coin == 3) {
                winnerPaid = bets * 50;
            }
            else if (seven == 3) {
                winnerPaid = bets * 100;
                //jackpot
                scene?.run(SKAction.playSoundFileNamed("high-score", waitForCompletion: false))
                showToast(message: "You win jackpot \(winnerPaid)!!", font: UIFont(name: "Chalkduster", size: 20)!)
                resultLabel.text = "You win jackpot \(winnerPaid)!!!!"
                
            }
            else if (bell == 2) {
                winnerPaid = bets * 2;
            }
            else if (cherry == 2) {
                winnerPaid = bets * 2;
            }
            else if (grape == 2) {
                winnerPaid = bets * 2;
            }
            else if (strawberry == 2) {
                winnerPaid = bets * 2;
            }
            else if (coin == 2) {
                winnerPaid = bets * 3;
            }
            else if (seven == 2) {
                winnerPaid = bets * 20;
            }
            else if (seven == 1) {
                winnerPaid = bets * 5;
            }
            credits += winnerPaid
            
        } else {  // lose
            print("you lose~")
            //lose
            losses += 1
            resultLabel.text = "You lose~"
            credits -= bets
            winnerPaid = 0
        }
        
        winRatio = ceil((wins/Double(turn))*100)
        if (credits < bets) {
            bets = 0;
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func showToast(message : String, font: UIFont) {
        messageBox(messageTitle: message, messageAlert: "Important", messageBoxStyle: UIAlertController.Style.alert, alertActionStyle: UIAlertAction.Style.default, completionHandler: {});

//        let toastLabel = UILabel(frame: CGRect(x: self.view!.frame.size.width/2 - 75, y: self.view!.frame.size.height-100, width: 150, height: 35))
//        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        toastLabel.textColor = UIColor.white
//        toastLabel.font = font
//        toastLabel.textAlignment = NSTextAlignment.center;
//        toastLabel.text = message
//        toastLabel.alpha = 1.0
//        toastLabel.layer.cornerRadius = 10;
//        toastLabel.clipsToBounds  =  true
//        self.view!.addSubview(toastLabel)
//        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
//             toastLabel.alpha = 0.0
//        }, completion: {(isCompleted) in
//            toastLabel.removeFromSuperview()
//        })
    }
    
    
    
    func checkJackPot() {
        var jackPotTry = arc4random_uniform(100);
        var jackPotWin = arc4random_uniform(100);
        if (jackPotTry == jackPotWin) {
            showToast(message: "You Won the $\(jackpot) Jackpot!!", font: UIFont(name: "Bangla Sangam MN", size: 30)!)
            credits += jackpot;
            jackpot = 1000;
        }
    }
    
    func messageBox(messageTitle: String, messageAlert: String, messageBoxStyle: UIAlertController.Style, alertActionStyle: UIAlertAction.Style, completionHandler: @escaping () -> Void)
        {
            let alert = UIAlertController(title: messageTitle, message: messageAlert, preferredStyle: messageBoxStyle)

            let okAction = UIAlertAction(title: "Ok", style: alertActionStyle) { _ in
                completionHandler() // This will only get called after okay is tapped in the alert
            }

            alert.addAction(okAction)
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
//            present(alert, animated: true, completion: nil)
        }
    
}
