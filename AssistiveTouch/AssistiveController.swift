//
//  AssistiveController.swift
//  AssistiveTouch
//
//  Created by Ragaie alfy on 10/3/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit

class AssistiveController: NSObject {
    
    var myView : AssistiveTouch!
    var myModel : AssistiveModel!
    
    var homeViewController : UINavigationController!
    var activeViewController : UIViewController!
    var peresentController : [UIViewController]! = []
    
   
    var Icons : [IconObject]! = []
    
    
    override init(){
    
        super.init()
        
        myModel = AssistiveModel()
    }
    
    
    
    
    
    func setButtonInView(){
    
        
        
        if Icons.count  > 7 {
            
            addButtonsToView(count: 7,start : 0, first: true)

        
        }
        else if Icons.count <= 7 {
        
            addButtonsToView(count: Icons.count,start : 0, first: true)
        
        }
        
        
    }
    
    
    
    
    func addButtonsToView(count : Int,start : Int, first :Bool){
        
        
        var homebuttons : [UIButton]! = []
        
        var homeLabels : [UILabel]! = []
        
        let screenWidth = UIScreen.main.bounds.width <  UIScreen.main.bounds.height ?  UIScreen.main.bounds.width : UIScreen.main.bounds.height
        
        let buttonWidth = screenWidth * 0.13
        let  raduisView  = (myView.assistiveView.frame.width / 2) - (buttonWidth - 10)
        let angleCount = Double.init(count + 1)
        
        
        let degree = 360 / angleCount
        
        
        
        let xcenter = (UIScreen.main.bounds.width / 2) - myView.assistiveView.frame.origin.x
        let ycenter = (UIScreen.main.bounds.height / 2)  - (myView.assistiveView.frame.origin.y + 6)
        
        
        
        for i in  start...count  {
           
            
            let angleTemp = (  (degree * Double.init(i) ) - 270) * ( 3.14159 / 180)
                
            let x = (xcenter + raduisView * CGFloat.init(cos((angleTemp) )) )
                
            let y = (ycenter + raduisView *   CGFloat.init(sin((angleTemp) )))
                
                
            let tempButton = UIButton.init(frame:  CGRect.init(x: x, y: y, width: buttonWidth, height: buttonWidth))
                
        
            if i != 0 {
                tempButton.setBackgroundImage(Icons[i - 1].image, for: .normal)

            
            }
            else {
            
                tempButton.setBackgroundImage(Icons[i].image, for: .normal)

            }
            
            if first == false {
                tempButton.setBackgroundImage(Icons[i + 6].image, for: .normal)
                
            }
            
                tempButton.tag = i

            // change secand found button
                if first == false {
            
                    tempButton.tag = i + 7

                }
            
            
                tempButton.addTarget(self, action: #selector(AssistiveController.itemButtonAction(_:)), for: .touchUpInside)
                
                
                myView.assistiveView.addSubview(tempButton)
                
                homebuttons.append(tempButton)
                tempButton.center = CGPoint.init(x: x, y: y)
                
            let label = UILabel.init(frame: CGRect.init(x: x, y: y  , width: buttonWidth, height: 30))
                label.textColor = UIColor.white
                label.adjustsFontSizeToFitWidth = true
            if #available(iOS 8.2, *) {
                label.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeight.init(1))
            } else {
                // Fallback on earlier versions
            }
            
            
            
            if i != 0  {
                label.text = Icons[i - 1 ].title

            }else  {
            
                label.text = Icons[i  ].title

            }
            
            if first == false {
            
                label.text = Icons[i + 6].title
            
            }
            
            
            
                label.textAlignment = .center
                label.center = CGPoint.init(x: x , y: y + (buttonWidth / 2) + 10)
                homeLabels.append(label)
                myView.assistiveView.addSubview(label)
                
                
                
                // set home page
                if i == 0 && first == true{
                    
                        tempButton.setBackgroundImage(myView.homeIcon.image, for: .normal)
                        label.text = myView.homeIcon.title
                 
                }
            
                
                
            
            // set more button
            if i == 7  && first == true && Icons.count > 7{
                
                
                tempButton.setBackgroundImage(myView.moreIcon.image, for: .normal)
                
                tempButton.removeTarget(self, action: #selector(AssistiveController.itemButtonAction(_:)), for: .touchUpInside)
                tempButton.addTarget(self, action: #selector(AssistiveController.moreViewShow(_:)), for: .touchUpInside)
              
                
                label.text = myView.moreIcon.title
                
               // homebuttons.append(tempButton)
            }
            
            
        }
        
        
        /// add back Button
        if first == false{
        
            let backButton = UIButton.init(frame: CGRect.init(x: xcenter , y: ycenter , width: buttonWidth, height: buttonWidth))
            
            backButton.setBackgroundImage(myView.backImage, for: .normal)
            myView.assistiveView.addSubview(backButton)
            backButton.center = CGPoint.init(x: xcenter, y: ycenter)
            backButton.addTarget(self, action: #selector(AssistiveController.backToFirstView(_:)), for: .touchUpInside)
            
            homebuttons.append(backButton)
        
        }
        
        
        if first == true {
        
        
            myModel.firstViewLabels = homeLabels
            myModel.firstViewbuttons = homebuttons
        }
        else {
            myModel.secandViewbuttons =  homebuttons
            myModel.secandViewLabels = homeLabels
        }
    
    
    }
    
    
    
    

    
    func showElement(firstView : Bool ,hidden : Bool){
        
    
        // to just show button depend in number of controller
        
        if firstView == true {
            for item in myModel.firstViewbuttons{
                
                item.isHidden = hidden
            }
            
            for item in myModel.firstViewLabels{
                
                item.isHidden = hidden
            }
        }
        else if firstView == false {
        
            for item in myModel.secandViewLabels{
                
                item.isHidden = hidden
            }
            
            for item in myModel.secandViewbuttons{
                
                item.isHidden = hidden
            }
        
        
        }
     
        
    }
    

  @objc  func itemButtonAction(_ sender : UIButton){
       // print("click icon")
        myView.handleTap(myView.tap)

        
       
        // home button
       if sender.tag == 0 {
        
         
            if activeViewController != nil {
                
                for item in peresentController{
                
                    item.dismiss(animated: true, completion: nil)
                }
               // activeViewController.dismiss(animated: true, completion: nil)

                activeViewController = nil
            }
        
            if myView.delgate != nil   {
            
                myView.delgate.assistiveTouch(myView, didClikedButton: sender, atIndex: sender.tag)
            }
        
        }
        
       else if myView.delgate != nil   {
            
            myView.delgate.assistiveTouch(myView, didClikedButton: sender, atIndex: sender.tag)
        }
    
    }
    
    
    
    
  @objc  func moreViewShow(_ sender : UIButton){
    
     showElement(firstView: true ,hidden: true)
        if myModel.secandViewbuttons.count == 0 {
        
            if Icons.count > 14 {
                addButtonsToView(count : 7 ,start : 0    , first : false)
            }
            else{
                addButtonsToView(count : Icons.count - 7 ,start : 0    , first : false)
            }
        }
        else {
        
            showElement(firstView: false ,hidden: false)
        }
        
        
      /*
        if myView.delgate != nil   {
            
            myView.delgate.assistiveTouchDidClikedMoreButton!()
        }
        */
        
    }
    
    
    
    
    @objc func backToFirstView(_ sender : UIButton){
    
        
        
        /*if myView.delgate != nil   {
            
            myView.delgate.assistiveTouchDidClikedBackButton!()
        }
        */
        showElement(firstView: false ,hidden: true)
        showElement(firstView: true ,hidden: false)

    
    }
    

}
 
