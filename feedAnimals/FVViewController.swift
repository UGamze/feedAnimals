//
//  FVViewController.swift
//  feedAnimals
//
//  Created by Gamze Ulucan on 13.08.17.
//  Copyright © 2017 Gamze Ulucan. All rights reserved.
//

import UIKit

class FVViewController: UIViewController {

    //Objects for firstVC
    @IBOutlet weak var animationButton: UIButton!
    @IBOutlet weak var animatedFarmer: UIImageView!

    // Function for firstVC
    @IBAction func startAnimation(_ sender: UIButton) {
        animateView(objectFarmer: animatedFarmer)
        createSpeechBubbleText(textForSpeech: "Hallo, ich bin der Bauer Heinz...")
    }
    //Objects for secondVC
    @IBOutlet weak var sVCanimatedFarmer: UIImageView!
    @IBOutlet weak var sVCanimationButton: UIButton!
    
    //Function for secondVC
    @IBAction func sVCstartAmination(_ sender: UIButton) {
        animateView(objectFarmer: sVCanimatedFarmer)
        createSpeechBubbleText(textForSpeech:"... und ich hab ein Bauernhof mit vielen Tieren: Kühen, Enten, Hasen usw.")
        animateView(objectFarmer: insertNewObject(name: "cow", rec: CGRect(x: 850, y: 480, width: 160, height: 200)))
        
        animateView(objectFarmer: insertNewObject(name: "sheep", rec: CGRect(x: 710, y: 525, width: 150, height: 150)))
        
        animateView(objectFarmer: insertNewObject(name: "cat", rec: CGRect(x: 510, y: 525, width: 120, height: 150)))
        
        animateView(objectFarmer: insertNewObject(name: "chicken", rec: CGRect(x: 650, y: 600, width: 150, height: 150)))
        
        animateView(objectFarmer: insertNewObject(name: "bunny", rec: CGRect(x: 780, y: 600, width: 120, height: 150)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /** Alternative Function to animateView -> without boolean
    func animateViewAlternative (objectFarmer:UIImageView){
        //let finishedAnim = checkImageViewInView(forImage: objectFarmer)
        UIView.animate(withDuration: 1,delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            objectFarmer.frame.size.width += 30
            objectFarmer.frame.size.height += 30
        },completion: { (finished:Bool) in
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                objectFarmer.frame.size.width -= 30
                objectFarmer.frame.size.height -= 30
            }, completion: nil)
        })
        //during the animation-> the button is inactive
    }**/
    
        
        func animateView(objectFarmer:UIImageView){
            UIView.animate(withDuration: 1,delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                objectFarmer.frame.size.width += 30
                objectFarmer.frame.size.height += 30
            }) { _ in
                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                    objectFarmer.frame.size.width -= 30
                    objectFarmer.frame.size.height -= 30
                })
            }
        }
        
    func createSpeechBubbleText(textForSpeech:NSString) {
        //create speechBubble with text and switch position
        let imageView = UIImageView(image: UIImage(named: "speechBubble")!)
        imageView.frame = CGRect(x: 780, y: 250, width: 200, height: 190)
        view.addSubview(imageView)
        //spiegelt das Bild
        imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        let text = UITextView(frame: CGRect(x: 808, y: 280, width: 150, height: 150))
        text.text = textForSpeech as String!
        text.textColor = UIColor.black
        text.backgroundColor = UIColor.clear
        text.textAlignment = .center
        view.addSubview(text)
    }
    
    //TODO: function should check, if the UIImageView (which would be inserted) exists in the view
    func checkImageViewInView(forImage:UIImageView) -> Bool {
        var checkImageInView = Bool()
        for imageView in view.subviews {
            if (forImage.frame != imageView.frame){
                checkImageInView = false
            }else{
                checkImageInView = true
                return checkImageInView
            }
        }
        return checkImageInView
    }
    
    func insertNewObject(name:NSString, rec:CGRect) -> UIImageView{
        let imageView = UIImageView(image: UIImage(named: name as String)!)
        imageView.frame = rec
        //doppeltes Anlegen von UIImageView vermeiden
        if(!checkImageViewInView(forImage: imageView)){
            view.addSubview(imageView)
            return imageView
        }
        return imageView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
