//
//  ViewController.swift
//  MotionCube
//
//  Created by Yaroslav Zakharchuk on 10/9/18.
//  Copyright © 2018 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var motionManager = CMMotionManager()
    var animator: UIDynamicAnimator?
    var gravity: UIGravityBehavior?
    var collision: UICollisionBehavior?
    var elasticity: UIDynamicItemBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.38, green:0.49, blue:0.55, alpha:1.0)
        animator = UIDynamicAnimator(referenceView: view)
        createGravity()
        createCollision()
        createLatex()
        motionManagerInit()
    }
    
    func motionManagerInit() {
        if (motionManager.isAccelerometerAvailable) {
            motionManager.accelerometerUpdateInterval = 1;
            motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: handleAccelerometerUpdate);
        }
    }
    
    func handleAccelerometerUpdate(data: CMAccelerometerData?, error: Error?) -> Void {
        if let d = data {
            self.gravity!.gravityDirection = CGVector(dx: d.acceleration.x, dy: -d.acceleration.y);
        }
    }
    
    @IBAction func anyTouch(_ sender: UITapGestureRecognizer) {
        let newView = createFigure(touchCoordinate: sender.location(in: view))
        
        gravity?.addItem(newView)
        collision?.addItem(newView)
        elasticity?.addItem(newView)
    }
    
    func createFigure(touchCoordinate: CGPoint) -> UIView {

        let tmpView = MyFigure(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotate))
        
        tmpView.addGestureRecognizer(panGesture)
        tmpView.addGestureRecognizer(pinchGesture)
        tmpView.addGestureRecognizer(rotationGesture)

        tmpView.center = view.convert(touchCoordinate, to: view)
        view.addSubview(tmpView)
        return tmpView
    }
    
    @objc func rotate(sender: UIRotationGestureRecognizer) {
        switch sender.state {
        case .began:
            self.gravity?.removeItem(sender.view!)
        case .changed:
            self.collision?.removeItem(sender.view!)
            self.elasticity?.removeItem(sender.view!)
            sender.view!.transform = sender.view!.transform.rotated(by: sender.rotation)
            sender.rotation = 0
            self.collision?.addItem(sender.view!)
            self.elasticity?.addItem(sender.view!)
            self.animator?.updateItem(usingCurrentState: sender.view!)
        case .ended:
            self.gravity?.addItem(sender.view!)
        default:
            break
        }
    }
    
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .began:
            self.gravity?.removeItem(sender.view!)
            self.collision?.removeItem(sender.view!)
        case .changed:
            self.elasticity?.removeItem(sender.view!)
            sender.view?.bounds.size.height *= sender.scale
            sender.view?.bounds.size.width *= sender.scale
            if (sender.view?.clipsToBounds == true) {
                sender.view?.layer.cornerRadius *= sender.scale
            }
            sender.scale = 1.0
            self.animator?.updateItem(usingCurrentState: sender.view!)
        case .ended:
            self.collision?.addItem(sender.view!)
            self.elasticity?.addItem(sender.view!)
            self.gravity?.addItem(sender.view!)
        default:
            break
        }
    }
    
    @objc func pan(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            self.gravity?.removeItem(sender.view!)
        case .changed:
            sender.view?.center = sender.location(in: self.view)
            self.animator?.updateItem(usingCurrentState: sender.view!)
        case .ended:
            self.gravity?.addItem(sender.view!)
        default:
            break
        }
    }
    
    func createGravity() {
        self.gravity = UIGravityBehavior(items: [])
        animator?.addBehavior(self.gravity!)
    }
    
    func createCollision() {
        self.collision = UICollisionBehavior(items: [])
        self.collision!.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(self.collision!)
    }
    
    func createLatex() {
        self.elasticity = UIDynamicItemBehavior(items: [])
        self.elasticity!.elasticity = 0.4
        animator?.addBehavior(self.elasticity!)
    }
}


