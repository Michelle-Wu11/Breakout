//
//  ViewController.swift
//  Breakout
//
//  Created by 吴雨楠 on 16/7/28.
//  Copyright © 2016年 Yunan Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {

    @IBOutlet weak var livesLabel: UILabel!

    var dynamicAnimator = UIDynamicAnimator()
    var collisionBehavior = UICollisionBehavior()
    var ball = UIView()
    var paddle = UIView()
    var lives = 5
    var bricks = [UIView]()
    var brick = UIView(）
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add a black ball object to the view
        ball = UIView(frame: CGRectMake(view.center.x, view.center.y, 20, 20))
        ball.backgroundColor = UIColor.blackColor()
        ball.layer.cornerRadius = 10
        ball.clipsToBounds = true
        view.addSubview(ball)
        
        // Add a red paddle object to the view
        paddle = UIView(frame: CGRectMake(view.center.x, view.center.y * 1.7, 80, 20))
        paddle.backgroundColor = UIColor.redColor()
        view.addSubview(paddle)
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        // Add brick objects to the view
        for i in 0...7{
            let ii = CGFloat(i)
            let iii = CGFloat(20 + ii * 40)
            let y = CGFloat(20)
           bricks[i] = UIView(frame: CGRectMake(iii ,y ,40,20))
            bricks[i].backgroundColor = UIColor.blueColor()
            view.addSubview(bricks[i])

        }
        // Create dynamic behavior for the ball
        let ballDynamicAnimator = UIDynamicItemBehavior(items: [ball])
        ballDynamicAnimator.friction = 0
        ballDynamicAnimator.resistance = 0
        ballDynamicAnimator.elasticity = 1.0
        ballDynamicAnimator.allowsRotation = false
        dynamicAnimator.addBehavior(ballDynamicAnimator)
        
        // Create dynamic behavior for the paddle
        let paddleDynamicAnimator = UIDynamicItemBehavior(items: [paddle])
        paddleDynamicAnimator.density = 10000
        paddleDynamicAnimator.resistance = 100
        paddleDynamicAnimator.allowsRotation = false
        dynamicAnimator.addBehavior(paddleDynamicAnimator)
        
        // Create a push behavior to get the ball moving
        let pushBehavior = UIPushBehavior(items: [ball], mode: .Instantaneous)
        pushBehavior.pushDirection = CGVectorMake(0.2, 1.0)
        pushBehavior.magnitude = 0.25
        dynamicAnimator.addBehavior(pushBehavior)
        
        // Create collision behaviors so ball can bounce off of other objects
        collisionBehavior = UICollisionBehavior(items: [ball, paddle])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Everything
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)
        
        livesLabel.text = "Lives : \(lives)"

    }
    
    @IBAction func dragPaddle(sender: UIPanGestureRecognizer) {
        let panGesture = sender.locationInView(view)
        paddle.center.x = panGesture.x
        dynamicAnimator.updateItemUsingCurrentState(paddle)
    }
    
    
    // Collision behavior delegate method with boundary
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        if item.isEqual(ball) && p.y > paddle.center.y{
            lives -= 1
            if lives > 0 {
                livesLabel.text = "Lives : \(lives)"
                ball.center = view.center
                dynamicAnimator.updateItemUsingCurrentState(ball)
            } else {
                livesLabel.text = "Game over"
                ball.removeFromSuperview()
                collisionBehavior.removeItem(ball)
                dynamicAnimator.updateItemUsingCurrentState(ball)
                
            }
        }
    }

    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
        if (item1.isEqual(ball) && item2.isEqual(brick)) || (item1.isEqual(brick) && item2.isEqual(ball)) {
            
            if brick.backgroundColor == UIColor.blueColor() {
                brick.backgroundColor = UIColor.yellowColor()
                
            } else {
                brick.hidden = true
                collisionBehavior.removeItem(brick)
                livesLabel.text = "You win!"
                ball.removeFromSuperview()
                collisionBehavior.removeItem(ball)
                dynamicAnimator.updateItemUsingCurrentState(ball)
                
            }
        }
    }

}

