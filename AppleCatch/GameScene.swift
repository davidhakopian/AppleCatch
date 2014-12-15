//
//  GameScene.swift
//  AppleCatch
//
//  Created by David Hakopian on 2014-12-13.
//  Copyright (c) 2014 David Hakopian. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    let appleCategory: UInt32 = 1 << 0
    let bucketCatagory: UInt32 = 1 << 1
    var i = 0
    
    override func didMoveToView(view: SKView) {
        
        view.showsPhysics = true
        physicsWorld.contactDelegate = self
        
        setBackground()
        let spawn = SKAction.runBlock({self.spawnApple()})
        let delay = SKAction.waitForDuration(1)
        let spawnThenDelay = SKAction.sequence([spawn, delay])
        let spawnForever = SKAction.repeatActionForever(spawnThenDelay)
        self.runAction(spawnForever)
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            spawnBucket(location.x)
            
        }
    }
    
    
    
    func spawnApple(){
        var rand = CGFloat(arc4random()%35) / 100 + 0.33
        println(rand)
        var apple: Apple
        apple = Apple(filename: "apple")
        apple.position = CGPointMake(self.frame.width*rand, self.frame.height)
        apple.setScale(2.0)
        apple.physicsBody = SKPhysicsBody(circleOfRadius: apple.size.width/2)
        apple.physicsBody?.categoryBitMask = appleCategory
        apple.physicsBody?.collisionBitMask = bucketCatagory
        apple.physicsBody?.contactTestBitMask = bucketCatagory
        addChild(apple)
    }
    
    func setBackground(){
        var background: Background
        background = Background(filename: "background")
        background.position = CGPointMake(self.frame.width*0.5, self.frame.height*0.5)
        background.zPosition = -10
        background.setScale(2.0)
        addChild(background)
    }
   
    
    func spawnBucket(xPos: CGFloat){
        var bucket: Apple
        bucket = Apple(filename: "garbage")
        bucket.position = CGPoint(x: xPos, y: self.frame.height*0.05)
        bucket.setScale(4)
        bucket.zPosition = -1
        bucket.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(bucket.size.width, bucket.size.height))
        bucket.physicsBody?.dynamic = false
        bucket.physicsBody?.categoryBitMask = bucketCatagory
        bucket.name = "bucket-0"
        let delay = SKAction.waitForDuration(1)
        let add = SKAction.runBlock(({self.addChild(bucket)}))
        let remove = SKAction.runBlock({
            if(self.parent?.childNodeWithName("bucket-0") == bucket){
                println("failed!!")
            }
            var x = self.parent?.childNodeWithName("bucket\(self.i)")
            println(bucket.name)
            println("\(x)")
            self.parent?.childNodeWithName("bucket-0")?.removeFromParent()
        })
        let removeAfter = SKAction.sequence([add, delay, remove])
        self.runAction(removeAfter)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch(contactMask){
        case appleCategory | bucketCatagory:
            let delay = SKAction.waitForDuration(0.025)
            let remove = SKAction.runBlock({
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
                })
            let delayThenRemove = SKAction.sequence([delay, remove])
            self.runAction(delayThenRemove)
        default: return
        }

    }
    
    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}
