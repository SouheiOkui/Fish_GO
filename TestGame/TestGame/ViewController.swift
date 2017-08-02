//
//  ViewController.swift
//  TestGame
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController, SKPhysicsContactDelegate {

    //Player作成
    let player = SKSpriteNode(imageNamed: "player.png")
    
    //衝突判定のためのビットマスク作成
    struct PhysicsCategory {
        static let Emeny: UInt32 = 1
        static let Bullet: UInt32 = 2
        static let Player: UInt32 = 3
    }
    
    //カウンター作成
    var score = Int()
    var counter = Int()
    
    //Scoreラベル作成
    var scoreLabel: UILabel!
    
    //タイムインターバル
    var enemyInterval: NSTimeInterval!
    var bulletInterval: NSTimeInterval!
    
    
    override func didMoveToView(view: SKView) {
        //背景色を設定
        self.backgroundColor = UIColor.grayColor()
        
        physicsWorld.contactDelegate = self
        
        //playerの表示位置設定
        player.position = CGPointMake(self.size.width / 2, self.size.height / 5)
        
        
        /* playerの物理体設定 */
        //PhysicsBody生成
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        //重力影響を無効化
        player.physicsBody?.affectedByGravity = false
        //衝突判定に使用する値の設定
        player.physicsBody?.categoryBitMask = PhysicsCategory.Player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.Emeny
        //衝突影響を無効化
        player.physicsBody?.dynamic = false
        //player表示
        self.addChild(player)
        
        
        /* bulletとenemyの生成間隔を設定 */
        //生成間隔の初期値を設定
        enemyInterval = 0.2
        bulletInterval = 0.2
        
        //bulletとenemyの生成
        let bulletTimer = NSTimer.scheduledTimerWithTimeInterval(bulletInterval, target: self, selector: Selector("SpanBullets"), userInfo: nil, repeats: true)
        let enemyTimer = NSTimer.scheduledTimerWithTimeInterval(enemyInterval, target: self, selector: Selector("Enemies"), userInfo: nil, repeats: true)
        //10秒ごとに生成間隔を更新
        let IntervalRondomTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: ("RondomInterval"), userInfo: nil, repeats: true)
        
        //Scoreラベルの設定
        scoreLabel = UILabel(frame: CGRectMake(0, 0, 100, 20))
        scoreLabel.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.6)
        scoreLabel.textColor = UIColor.whiteColor()
        self.view?.addSubview(scoreLabel)
    }
    
    
    /*
     bulletの設定
     */
    func SpanBullets(){
        //Bullet作成
        let bulletTexture = SKTexture(imageNamed: "Missile.png")
        let bullet = SKSpriteNode(texture: bulletTexture)
        
        //レンダリング順とヒットテスト順の設定
        bullet.zPosition = -5
        //生成位置の設定
        bullet.position = CGPointMake(player.position.x, player.position.y)
        
        
        //アクション作成(移動方向:Y,移動時間:1.0秒)
        let action = SKAction.moveToY(self.size.height + 30, duration: 1.0)
        let actionDone = SKAction.removeFromParent()
        bullet.runAction(SKAction.sequence([action,actionDone]))
        
        
        /* 物理体の設定 */
        //PhysaicsBody生成
        bullet.physicsBody = SKPhysicsBody(texture: bulletTexture, size: bulletTexture.size())
        //重力影響を無効化
        bullet.physicsBody?.affectedByGravity = false
        //衝突判定に使用する値の設定
        bullet.physicsBody?.categoryBitMask = PhysicsCategory.Bullet
        bullet.physicsBody?.contactTestBitMask = PhysicsCategory.Emeny
        //衝突影響を無効化
        bullet.physicsBody?.dynamic = false
        
        
        //Bullet表示
        self.addChild(bullet)
    }
    
    
    /*
     enemyの設定
     */
    func Enemies() {
        //enemy作成
        let enemyTexture = SKTexture(imageNamed: "Meteor")
        enemyTexture.filteringMode = .Nearest
        let enemy = SKSpriteNode(texture: enemyTexture)
        
        /* enemy出現の設定 */
        let minValue = self.size.width / 8
        let maxValue = self.size.width - 30
        let spanPoint = UInt32(maxValue - minValue)
        enemy.position = CGPoint(x: CGFloat(arc4random_uniform(spanPoint)), y: self.size.height)
        //enemyサイズをランダムに生成し設定
        let enemySize: CGFloat = getRandomNumber(Min: 0.5, Max: 1.0)
        enemy.setScale(enemySize)
        
        
        /* アクション作成(移動方向:-Y,移動時間:ランダム(1.5 ~ 3.0sec)) */
        let actionDuradion: NSTimeInterval = NSTimeInterval(getRandomNumber(Min: 1.5, Max: 3.0))
        let action = SKAction.moveToY(-30, duration: actionDuradion)
        let actionDone = SKAction.removeFromParent()
        enemy.runAction(SKAction.sequence([action,actionDone]))
        
        
        /* 物理体の設定*/
        //PhysicsBpdy生成
        enemy.physicsBody = SKPhysicsBody(texture: enemyTexture, size: enemy.size)
        //重力の影響を無効化
        enemy.physicsBody?.affectedByGravity = false
        //衝突判定に使用する値の設定
        enemy.physicsBody?.categoryBitMask = PhysicsCategory.Emeny
        enemy.physicsBody?.contactTestBitMask = PhysicsCategory.Bullet
        //衝突影響を有効化
        enemy.physicsBody?.dynamic = true
        
        
        //enemy表示
        self.addChild(enemy)
    }
    
    
    /*
     乱数生成処理
     */
    //Float用
    func getRandomNumber(Min _Min : CGFloat, Max _Max : CGFloat) -> CGFloat {
        
        return ( CGFloat(arc4random_uniform(UINT32_MAX)) / CGFloat(UINT32_MAX) ) * (_Max - _Min) + _Min
    }
    
    //NSTimeInterval(Double)用
    func getRandomInterval(Min _Min : NSTimeInterval, Max _Max : NSTimeInterval) -> NSTimeInterval {
        
        return ( NSTimeInterval(arc4random_uniform(UINT32_MAX)) / NSTimeInterval(UINT32_MAX) ) * (_Max - _Min) + _Min
    }
    
    /*
     bulletとenemyの生成間隔を取得
     */
    func RondomInterval() {
        enemyInterval = getRandomInterval(Min: 0.1, Max: 0.5)
        bulletInterval = getRandomInterval(Min: 0.1, Max: 1.0)
    }
    
    
    /*
     衝突検出時の処理
     */
    func didBeginContact(contact: SKPhysicsContact) {
        
        //衝突したnodeを取得
        let nodeNameA = contact.bodyA
        let nodeNameB = contact.bodyB
        
        
        /* bulletとenemyが衝突した時 */
        if ((nodeNameA.categoryBitMask == PhysicsCategory.Emeny && nodeNameB.categoryBitMask == PhysicsCategory.Bullet) ||
            (nodeNameA.categoryBitMask == PhysicsCategory.Bullet && nodeNameB.categoryBitMask == PhysicsCategory.Emeny)) {
            
            //bulletとenemyを削除
            nodeNameA.node?.removeFromParent()
            nodeNameB.node?.removeFromParent()
            
            //スコア加算と表示
            score++
            scoreLabel.text = "\(score)"
            
            
            /* playerとenemyが衝突した時の処理 */
        } else if ((nodeNameA.categoryBitMask == PhysicsCategory.Emeny && nodeNameB.categoryBitMask == PhysicsCategory.Player) ||
            (nodeNameA.categoryBitMask == PhysicsCategory.Player && nodeNameB.categoryBitMask == PhysicsCategory.Emeny)) {
            
            //ゲームオーバ処理実行
            gameover()
        }
    }
    
    
    /*
     ゲームオーバの処理
     */
    func gameover() {
        
        //playerとenemyの衝突回数をカウント
        counter++
        
        //衝突回数が３回になったらゲームオーバー
        //スコアを保存し結果画面に移動
        if counter == 3 {
            // スコアを格納。
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setInteger(score, forKey: "score")
            scoreLabel.removeFromSuperview()
            
            // 結果画面に移動
            let resultScene = ResultScene(size: self.scene!.size)
            resultScene.scaleMode = SKSceneScaleMode.AspectFill
            self.view!.presentScene(resultScene)
        }
    }
    
    
    /*
     playerの移動処理
     */
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            player.position.x = location.x
            player.position.y = location.y
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {}
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {}
}

