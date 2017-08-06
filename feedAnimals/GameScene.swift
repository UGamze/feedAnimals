//
//  GameScene.swift
//  feedAnimals
//
//  Created by Gamze Ulucan on 12.07.17.
//  Copyright © 2017 Gamze Ulucan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var isGameStarted = Bool(false)
    var isDied = Bool(false)
    //let coinSound = SKAction.playSoundFileNamed("CoinSound.mp3", waitForCompletion: false)
    
    var score = Int(0)
    var scoreLbl = SKLabelNode()
    var highscoreLbl = SKLabelNode()
    var taptoplayLbl = SKLabelNode()
    var restartBtn = SKSpriteNode()
    var pauseBtn = SKSpriteNode()
    var logoImg = SKSpriteNode()
    var wallPair = SKNode()
    var moveAndRemove = SKAction()
    
    
    func createScene(){
        for i in 0..<2{
            let background = SKSpriteNode(imageNamed: "blankoBackground")
            background.anchorPoint = CGPoint.init(x: 0, y: 0)
            background.position = CGPoint(x:CGFloat(i) * self.frame.width, y:0)
            background.name = "background"
            background.size = (self.view?.bounds.size)!
            self.addChild(background)
        }
        
    }
    
    override func didMove(to view: SKView) {
        createScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
}
