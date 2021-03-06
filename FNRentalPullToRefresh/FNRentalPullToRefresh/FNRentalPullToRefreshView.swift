//
//  FNRentalPullToRefreshAnimator.swift
//  FNRentalPullToRefresh
//
//  Created by Fnoz on 16/5/31.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

import UIKit
import EasyPull
import DKChainableAnimationKit

public class FNRentalPullToRefreshHeaderView: UIView, EasyViewManual, EasyViewAutomatic {
    let sky :UIImageView = UIImageView()
    let building : UIImageView = UIImageView()
    let sun : UIImageView = UIImageView()
    let sunContainer : UIView = UIView()
    var isAnimating = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func showManualPulling(progress:CGFloat) {
        if progress<0.2 {
            resetManual()
        }
        print(progress)
        sunContainer.center = CGPointMake(sunContainer.center.x, (1-progress * 0.7) * frame.size.height)
        let scale = ((35/15.0-1)*progress * 15 + 15)/35
        sun.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(scale, scale), 2 * CGFloat(M_PI) * progress)
        sky.transform = CGAffineTransformMakeTranslation(0, (1 - progress) * 20)
    }
    
    public func showManualPullingOver() {
        if !isAnimating {
            isAnimating = true
            var rotationAnimation: CABasicAnimation
            rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
            rotationAnimation.toValue = CFloat((M_PI*2.0))
            rotationAnimation.duration = 0.7
            rotationAnimation.cumulative = true
            rotationAnimation.repeatCount = 1024
            rotationAnimation.removedOnCompletion = false
            rotationAnimation.fillMode = kCAFillModeForwards
            sun.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
            
            UIView.animateWithDuration(0.9) {
                self.sky.transform = CGAffineTransformMakeScale(1.1, 1.1)
                self.building.transform = CGAffineTransformTranslate(CGAffineTransformMakeScale(1.2, 1.2), 0, -6)
                self.sun.transform = CGAffineTransformMakeScale(0.8, 0.8)
            }
        }
    }
    
    public func showManualExcuting() {
    
    }
    
    public func resetManual() {
        isAnimating = false
        sun.layer.removeAllAnimations()
        UIView.animateWithDuration(0.9) {
            self.sky.transform = CGAffineTransformMakeScale(1, 1)
            self.building.transform = CGAffineTransformTranslate(CGAffineTransformMakeScale(1, 1), 0, 0)
            self.sun.transform = CGAffineTransformMakeScale(1, 1)
            self.sky.transform = CGAffineTransformMakeTranslation(0, 20)
        }
    }
    
    public func showAutomaticPulling(progress: CGFloat) {
    }
    
    public func showAutomaticExcuting() {
    }
    
    public func showAutomaticUnable() {
    }
    
    public func resetAutomatic() {
    }
    
    private func initView() {
        clipsToBounds = true
        
        sky.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        sky.image = UIImage.init(named: "sky")
        addSubview(sky)
        sky.transform = CGAffineTransformMakeTranslation(0, 20)
        
        sunContainer.frame = CGRectMake(bounds.size.width/3.5, 35, 50, 50)
        addSubview(sunContainer)
        
        sun.frame = CGRectMake(7.5, 7.5, 35, 35)
        sun.image = UIImage.init(named: "sun")
        sunContainer.addSubview(sun)
        
        building.frame = CGRectMake(0, bounds.size.height - 72, bounds.size.width, 72)
        building.image = UIImage.init(named: "buildings")
        addSubview(building)
    }
}
