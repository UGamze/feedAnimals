//
//  AnimationView.swift
//  feedAnimals
//
//  Created by Gamze Ulucan on 11.11.17.
//  Copyright © 2017 Gamze Ulucan. All rights reserved.
//

import UIKit

class Animation {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    // animate a button
    func animateButton(objectButton:UIButton){
        UIView.animate(withDuration: 1,delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            objectButton.frame.size.width += 30
            objectButton.frame.size.height += 30
        }) { _ in
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                objectButton.frame.size.width -= 30
                objectButton.frame.size.height -= 30
            })
        }
    }
    // animate an UIImageView
    func animateView(objectView:UIImageView){
        UIView.animate(withDuration: 1,delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            objectView.frame.size.width += 30
            objectView.frame.size.height += 30
        }) { _ in
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                objectView.frame.size.width -= 30
                objectView.frame.size.height -= 30
            })
        }
    }
    
    //pulsate a button
    func pulsateButton(objectButton:UIButton) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        objectButton.layer.add(pulse, forKey: "pulse")
    }
}
