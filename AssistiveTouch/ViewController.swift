//
//  ViewController.swift
//  AssistiveTouch
//
//  Created by Ragaie alfy on 10/2/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,AssistiveTouchDelegate{

    
    var touchId : AssistiveTouch!
    
   // @IBOutlet weak var textfield: UITextField!
    
    
    var firstView : UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     
        
        
        
        touchId = AssistiveTouch()
        // to change icon of button
        touchId.assistiveImage = UIImage.init(named: "touchButton")
        // change view color
        //touchId.assistiveColor = UIColor.brown
        
        // you can change home icon or more icon or back image icon
        
       // touchId.homeIcon = IconObject.init(iconImage: UIImage.init(named: "home")!, iconTitle: "")
       // touchId.moreIcon = IconObject.init(iconImage: UIImage.init(named: "more")!, iconTitle: "More")
       // touchId.backImage = UIImage.init(named: "star")
        // set delgete of actions of view
        
        
        
        
        touchId.delgate = self
        
        
        

        var icons = [
                        IconObject.init(iconImage: UIImage.init(named:"profile")!, iconTitle: "profile") ,
                        IconObject.init(iconImage: UIImage.init(named: "bill")!, iconTitle: "bill") ,
                        IconObject.init(iconImage: UIImage.init(named: "profile")!, iconTitle: "profile") ,
                        IconObject.init(iconImage: UIImage.init(named: "bill")!, iconTitle: "bill") 
        

                        ,IconObject.init(iconImage: UIImage.init(named: "call")!, iconTitle: "call"),
                        IconObject.init(iconImage: UIImage.init(named: "notification")!, iconTitle: "notification"),
                        IconObject.init(iconImage: UIImage.init(named: "safari")!, iconTitle: "safari"),
                        IconObject.init(iconImage: UIImage.init(named: "setting")!, iconTitle: "setting"),
                        IconObject.init(iconImage: UIImage.init(named: "star")!, iconTitle: "star"),
                        IconObject.init(iconImage: UIImage.init(named: "profile")!, iconTitle: "profile"), IconObject.init(iconImage: UIImage.init(named: "profile")!, iconTitle: "profile"), IconObject.init(iconImage: UIImage.init(named: "profile")!, iconTitle: "profile"), IconObject.init(iconImage: UIImage.init(named: "profile")!, iconTitle: "profile"), IconObject.init(iconImage: UIImage.init(named: "profile")!, iconTitle: "profile"), IconObject.init(iconImage: UIImage.init(named: "profile")!, iconTitle: "profile"), IconObject.init(iconImage: UIImage.init(named: "profile")!, iconTitle: "profile"), IconObject.init(iconImage: UIImage.init(named: "profile")!, iconTitle: "profile"), IconObject.init(iconImage: UIImage.init(named: "profile")!, iconTitle: "profile")]
        
        
        //set dataSource of button
        touchId.setDataSource(homeController: self.navigationController!, icons: icons )

        
        /// you can use id of navagation controller if you want navagation controller
        //navID
        firstView  = (self.storyboard?.instantiateViewController(withIdentifier: "navID"))!
        
        
        // if you don't want navagation in your view
        //firstView  = (self.storyboard?.instantiateViewController(withIdentifier: "first"))!

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func assistiveTouch(_ assistiveTouch: AssistiveTouch, didClikedButton button: UIButton, atIndex index: Int) {
      
        
        switch index {
        case 2:
            
            // use it present view controller
            touchId.showFrontViewController(viewController: firstView!, animate: true)
            break
        default:
            UIAlertView.init(title: "Assistive Touch ", message: "Your Pressed key for index -->  \(index)  ", delegate: nil, cancelButtonTitle: "Dismiss").show()
            break
        }

        
    }
 
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        touchId.addTouch()
   
    }
    
    
    
    

  
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(true)
            touchId.addTouch()

    }
    
   
    
    
    
    

}

