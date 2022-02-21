/*
 File       : GameScene.swift
 Author     : Feiliang Zhou
 StudentId  : 301216989
 Date       : January 22, 2022
 Description: slotmachine
*/

import UIKit
import SpriteKit
import GameplayKit
import FirebaseAuth

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error
            {
                print(error.localizedDescription)
            }
            
            guard let user = authResult?.user else {
                print("anonymous login failed")
                return
            }
            let isAnonymous = user.isAnonymous  // true
            let uid = user.uid
            print("uid: \(uid). is Anonymous:\(isAnonymous)")
           
        }
        
        setScene(sceneName: "GameScene")
        
    }
    
    func setScene(sceneName:String)
    {
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: sceneName) {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
