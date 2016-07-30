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
    var a = UIView()
    var b = UIView()
    var c = UIView()
    var d = UIView()
    var e = UIView()
    var f = UIView()
    var g = UIView()
    var h = UIView()
    var aa = UIView()
    var bb = UIView()
    var cc = UIView()
    var dd = UIView()
    var ee = UIView()
    var ff = UIView()
    var gg = UIView()
    var hh = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var brick = [a, b, c, d, e, f, g, h, aa, bb, cc, dd, ee, ff,hh]
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
        a = UIView(frame: CGRectMake(20, 20, 40, 20))
        a.backgroundColor = UIColor.blueColor()
        b = UIView(frame: CGRectMake(65, 20, 40, 20))
        b.backgroundColor = UIColor.blueColor()
        c = UIView(frame: CGRectMake(110, 20, 40, 20))
        c.backgroundColor = UIColor.blueColor()
        d = UIView(frame: CGRectMake(155, 20, 40, 20))
        d.backgroundColor = UIColor.blueColor()
        e = UIView(frame: CGRectMake(200, 20, 40, 20))
        e.backgroundColor = UIColor.blueColor()
        f = UIView(frame: CGRectMake(245, 20, 40, 20))
        f.backgroundColor = UIColor.blueColor()
        g = UIView(frame: CGRectMake(290, 20, 40, 20))
        g.backgroundColor = UIColor.blueColor()
        h = UIView(frame: CGRectMake(335, 20, 40, 20))
        h.backgroundColor = UIColor.blueColor()
        view.addSubview(a)
        view.addSubview(b)
        view.addSubview(c)
        view.addSubview(d)
        view.addSubview(e)
        view.addSubview(f)
        view.addSubview(g)
        view.addSubview(h)
        
        aa = UIView(frame: CGRectMake(20, 45, 40, 20))
        aa.backgroundColor = UIColor.blueColor()
        bb = UIView(frame: CGRectMake(65, 45, 40, 20))
        bb.backgroundColor = UIColor.blueColor()
        cc = UIView(frame: CGRectMake(110, 45, 40, 20))
        cc.backgroundColor = UIColor.blueColor()
        dd = UIView(frame: CGRectMake(155, 45, 40, 20))
        dd.backgroundColor = UIColor.blueColor()
        ee = UIView(frame: CGRectMake(200, 45, 40, 20))
        ee.backgroundColor = UIColor.blueColor()
        ff = UIView(frame: CGRectMake(245, 45, 40, 20))
        ff.backgroundColor = UIColor.blueColor()
        gg = UIView(frame: CGRectMake(290, 45, 40, 20))
        gg.backgroundColor = UIColor.blueColor()
        hh = UIView(frame: CGRectMake(335, 45, 40, 20))
        hh.backgroundColor = UIColor.blueColor()
        view.addSubview(aa)
        view.addSubview(bb)
        view.addSubview(cc)
        view.addSubview(dd)
        view.addSubview(ee)
        view.addSubview(ff)
        view.addSubview(gg)
        view.addSubview(hh)
        
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
        
        // Create dynamic behavior for the brick
        let brickDynamicAnimator = UIDynamicItemBehavior(items: [a, b, c, d, e, f, g, h, aa, bb, cc, dd, ee, ff, gg, hh])
        brickDynamicAnimator.density = 10000
        brickDynamicAnimator.resistance = 100
        brickDynamicAnimator.allowsRotation = false
        dynamicAnimator.addBehavior(brickDynamicAnimator)
        
        // Create a push behavior to get the ball moving
        let pushBehavior = UIPushBehavior(items: [ball], mode: .Instantaneous)
        pushBehavior.pushDirection = CGVectorMake(0.2, 1.0)
        pushBehavior.magnitude = 0.25
        dynamicAnimator.addBehavior(pushBehavior)
        
        // Create collision behaviors so ball can bounce off of other objects
        collisionBehavior = UICollisionBehavior(items: [ball, paddle, a, b, c, d, e, f, g, h, aa, bb, cc, dd, ee, ff, gg, hh])
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
        if (item1.isEqual(ball) && item2.isEqual(a)) || (item1.isEqual(a) && item2.isEqual(ball)) {
            if a.backgroundColor == UIColor.blueColor() {
                a.backgroundColor = UIColor.yellowColor()
            } else {
                a.hidden = true
                collisionBehavior.removeItem(a)
            }
        }
        if (item1.isEqual(ball) && item2.isEqual(b)) || (item1.isEqual(b) && item2.isEqual(ball)) {
            if b.backgroundColor == UIColor.blueColor() {
                b.backgroundColor = UIColor.yellowColor()
            } else {
                b.hidden = true
                collisionBehavior.removeItem(b)
            }
        }
        if (item1.isEqual(ball) && item2.isEqual(c)) || (item1.isEqual(c) && item2.isEqual(ball)) {
            if c.backgroundColor == UIColor.blueColor() {
                c.backgroundColor = UIColor.yellowColor()
            } else {
                c.hidden = true
                collisionBehavior.removeItem(c)
            }
        }
        if (item1.isEqual(ball) && item2.isEqual(d)) || (item1.isEqual(d) && item2.isEqual(ball)) {
            if d.backgroundColor == UIColor.blueColor() {
                d.backgroundColor = UIColor.yellowColor()
            } else {
                d.hidden = true
                collisionBehavior.removeItem(d)
            }
        }
        if (item1.isEqual(ball) && item2.isEqual(e)) || (item1.isEqual(e) && item2.isEqual(ball)) {
            if e.backgroundColor == UIColor.blueColor() {
                e.backgroundColor = UIColor.yellowColor()
            } else {
                e.hidden = true
                collisionBehavior.removeItem(e)
            }
        }
        if (item1.isEqual(ball) && item2.isEqual(f)) || (item1.isEqual(f) && item2.isEqual(ball)) {
            if f.backgroundColor == UIColor.blueColor() {
                f.backgroundColor = UIColor.yellowColor()
            } else {
                f.hidden = true
                collisionBehavior.removeItem(f)
            }
        }
        if (item1.isEqual(ball) && item2.isEqual(g)) || (item1.isEqual(g) && item2.isEqual(ball)) {
            if g.backgroundColor == UIColor.blueColor() {
                g.backgroundColor = UIColor.yellowColor()
            } else {
                g.hidden = true
                collisionBehavior.removeItem(g)
            }
        }
        if (item1.isEqual(ball) && item2.isEqual(h)) || (item1.isEqual(h) && item2.isEqual(ball)) {
            if h.backgroundColor == UIColor.blueColor() {
                h.backgroundColor = UIColor.yellowColor()
            } else {
                h.hidden = true
                collisionBehavior.removeItem(h)
                
            }
        }
        if (item1.isEqual(ball) && item2.isEqual(aa)) || (item1.isEqual(aa) && item2.isEqual(ball)) {
            if aa.backgroundColor == UIColor.blueColor() {
                aa.backgroundColor = UIColor.yellowColor()
            } else {
                aa.hidden = true
                collisionBehavior.removeItem(aa)
            }
        }
        if (item1.isEqual(ball) && item2.isEqual(bb)) || (item1.isEqual(bb) && item2.isEqual(ball)) {
            if bb.backgroundColor == UIColor.blueColor() {
                bb.backgroundColor = UIColor.yellowColor()
            } else {
                bb.hidden = true
                collisionBehavior.removeItem(bb)
            }
        }
        if (item1.isEqual(ball) && item2.isEqual(cc)) || (item1.isEqual(cc) && item2.isEqual(ball)) {
            if cc.backgroundColor == UIColor.blueColor() {
                cc.backgroundColor = UIColor.yellowColor()
            } else {
                cc.hidden = true
                collisionBehavior.removeItem(cc)
            }
        }
        if (item1.isEqual(ball) && item2.isEqual(dd)) || (item1.isEqual(dd) && item2.isEqual(ball)) {
            if dd.backgroundColor == UIColor.blueColor() {
                dd.backgroundColor = UIColor.yellowColor()
            } else {
                dd.hidden = true
                collisionBehavior.removeItem(dd)
            }
        }
        if (item1.isEqual(ball) && item2.isEqual(ee)) || (item1.isEqual(ee) && item2.isEqual(ball)) {
            if ee.backgroundColor == UIColor.blueColor() {
                ee.backgroundColor = UIColor.yellowColor()
            } else {
                ee.hidden = true
                collisionBehavior.removeItem(ee)
            }
        }
        if (item1.isEqual(ball) && item2.isEqual(ff)) || (item1.isEqual(ff) && item2.isEqual(ball)) {
            if ff.backgroundColor == UIColor.blueColor() {
                ff.backgroundColor = UIColor.yellowColor()
            } else {
                ff.hidden = true
                collisionBehavior.removeItem(ff)
            }
        }
        if (item1.isEqual(ball) && item2.isEqual(gg)) || (item1.isEqual(gg) && item2.isEqual(ball)) {
            if gg.backgroundColor == UIColor.blueColor() {
                gg.backgroundColor = UIColor.yellowColor()
            } else {
                gg.hidden = true
                collisionBehavior.removeItem(gg)
            }
        }
        if (item1.isEqual(ball) && item2.isEqual(hh)) || (item1.isEqual(hh) && item2.isEqual(ball)) {
            if hh.backgroundColor == UIColor.blueColor() {
                hh.backgroundColor = UIColor.yellowColor()
            } else {
                hh.hidden = true
                collisionBehavior.removeItem(hh)
            }
        }

    }
}