//
//  AssistiveTouch.swift
//  AssistiveTouch
//
//  Created by Ragaie alfy on 10/2/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit





public class AssistiveTouch: NSObject {
    
   private var myController : AssistiveController!
   private var touchButton : UIButton!
   private var endDrag : Bool! = false
   private var validData : Bool! = false
    
    //var assistiveView : AssistiveView!
    private  var screenView : UIView!
    var   tap : UITapGestureRecognizer!
    var assistiveView : UIView!

    
    public var assistiveImage : UIImage!
    public var assistiveColor : UIColor! = UIColor.darkGray
    
  
    
    public  var homeIcon : IconObject!
    public var moreIcon : IconObject!
  
    public var backImage : UIImage! //= UIImage.init(named: "back")
    

    public var delgate : AssistiveTouchDelegate!
    
  public  override init(){
    
    
        super.init()
        
        myController = AssistiveController()
        myController.myView = self
        
        let bundle = Bundle(for: type(of: self))
        homeIcon  = IconObject.init(iconImage:  UIImage(named: "home" , in: bundle,compatibleWith: nil)!, iconTitle: "Home")
        moreIcon  = IconObject.init(iconImage:  UIImage(named: "more" , in: bundle,compatibleWith: nil)!, iconTitle: "More")
       
        backImage =  UIImage(named: "back" , in: bundle,compatibleWith: nil)!
        assistiveImage =  UIImage(named: "Touch" , in: bundle,compatibleWith: nil)!
    }
   
   
   public func setDataSource(homeController : UINavigationController , icons : [IconObject]){
         if homeController != nil  && icons.count > 0 {
                validData = true
            myController.homeViewController = homeController
            myController.Icons = icons
        }
        else{
            validData = false
        }
    }
    
    //setFrontViewController
   public func showFrontViewController(viewController : UIViewController,animate : Bool){
        if myController.homeViewController != nil {
            if  myController.activeViewController == nil {
                myController.homeViewController.present(viewController, animated: true, completion: nil)
                myController.activeViewController = viewController
                myController.peresentController.append(viewController)

            }
            else if myController.activeViewController != viewController  {
                myController.homeViewController.present(viewController, animated: true, completion: nil)
                myController.activeViewController = viewController
                myController.peresentController.append(viewController)
            }
        }
        
    
    }
    
 
    
    
    public func addTouch(){
    
        if touchButton == nil && validData == true {
            touchButton  = UIButton.init(frame: CGRect.init(x: 0 , y: (UIScreen.main.bounds.height / 2) - 30, width: 60, height: 60))
            touchButton.setBackgroundImage(assistiveImage, for: .normal)
            touchButton.addTarget(self, action: #selector(AssistiveTouch.wasDragged(_:event:)), for: UIControlEvents.allTouchEvents)
        
            UIApplication.shared.keyWindow?.addSubview(touchButton)
         }
        else if touchButton != nil && validData == true{
           
            // for rotate view to adjust button loaction
            if UIDevice.current.orientation.isLandscape {
                touchButton.frame = CGRect.init(x: 0 , y: (UIScreen.main.bounds.width / 2) - 30, width: 60, height: 60)
            }
            else{
                  touchButton.frame = CGRect.init(x: 0 , y: (UIScreen.main.bounds.height / 2) - 30, width: 60, height: 60)
            }
        }
        else if validData == false {
        
            UIAlertView.init(title: "AssistiveTouch", message: "All dataSource array sould be same count ", delegate:nil, cancelButtonTitle: "Dismiss").show()
        }
    
    }
    
    

    
    
    
    @objc func wasDragged (_ sender : UIButton, event :UIEvent)
    {
     
        let touch : UITouch! = event.touches(for: sender)?.first
    switch touch.phase {
        case UITouchPhase.moved:
            endDrag = true
            dragStart(sender, event: event)
            break;
        case UITouchPhase.ended:
            
            if endDrag == true {
                endDrag = false
                dragEnded(sender, event: event)
            }
            else{
                showViewTouch(sender: sender)
            }
            break;
        case UITouchPhase.began:
           // print("touchbegin")
            
            break;
        default:
            break;
        }
   
    }
    
    
    
    
    
    
    
    
    private func dragStart (_ sender : UIButton, event :UIEvent)
    {
        
        let touch : UITouch! = event.touches(for: sender)?.first
        let previousLocation : CGPoint = touch .previousLocation(in: sender)
        //current location for view
        let location : CGPoint = touch .location(in: sender)
       
        let delta_x :CGFloat = location.x - previousLocation.x
        let delta_y :CGFloat = location.y - previousLocation.y
        sender.center = CGPoint.init(x:sender.center.x + delta_x, y:  sender.center.y + delta_y)
    }
    
    
    
  private   func dragEnded (_ sender : UIButton, event :UIEvent)
    {
        let touch : UITouch! = event.touches(for: sender)?.first
        let previousLocation : CGPoint = touch .previousLocation(in: sender)
        //current location for view
        let location : CGPoint = touch .location(in: sender)
        let screenWidth = UIScreen.main.bounds.width
        var xValue : CGFloat! = 0.0
        var yValue : CGFloat! = 0.0

        if  sender.frame.minX < screenWidth / 2 {
            
            xValue =  sender.frame.width / 2
            
        }
        
        if sender.frame.minX > screenWidth / 2{
        
                xValue = screenWidth - sender.frame.width / 2
        }
        
        
        let delta_x :CGFloat = location.x - previousLocation.x
        let delta_y :CGFloat = location.y - previousLocation.y
 
        
        if  (sender.center.y + delta_y ) > (UIScreen.main.bounds.height  - (sender.frame.height / 2)){
        
            yValue = UIScreen.main.bounds.height  - (sender.frame.height / 2)
        
        }
        else if (sender.center.y + delta_y ) <  (sender.frame.height / 2) {
        
            yValue =  (sender.frame.height / 2)

        }
        else{
            yValue =  sender.center.y + delta_y
        
        }
        
         UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
         
                sender.center = CGPoint.init(x: xValue, y:  yValue)
         }, completion: nil)

        
    }

    
    
    
    
    
    
    // handle click on assistive button to show view 
    //this to show Assistive view buttons
    
    private func showViewTouch(sender : UIButton){
        
        
     
        
        let screenWidth = UIScreen.main.bounds.width <  UIScreen.main.bounds.height ?  UIScreen.main.bounds.width : UIScreen.main.bounds.height
        
        
        let xValue  = screenWidth / 15
        let widthValue  = xValue * 13
        let xPostion = (UIScreen.main.bounds.width / 2 ) - (widthValue / 2)
        
        let yPostion  = (UIScreen.main.bounds.height / 2 ) - (widthValue / 2)
        
        if assistiveView != nil {
            screenView.isHidden = false
            assistiveView.isHidden = false
            touchButton.isHidden = true
            
    // update assistive frame view
            assistiveView.frame = touchButton.frame

    //for item in assistiveView.subviews { item.isHidden = true}
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
                self.assistiveView.frame = CGRect.init(x: xPostion , y: yPostion, width: widthValue , height: widthValue )
            }, completion: { (true) in
                 self.myController.showElement(firstView: true , hidden: false)
            })
        }
        else{
        
          // init assistive view and animate to view it
            
             screenView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            screenView.backgroundColor = UIColor.clear

            assistiveView = UIView.init(frame: touchButton.frame)
            assistiveView.layer.cornerRadius = 20
            assistiveView.backgroundColor = assistiveColor
            tap = UITapGestureRecognizer(target: self, action: #selector(AssistiveTouch.handleTap(_:)))
            assistiveView.addGestureRecognizer(tap)
            //ragaie
            screenView.addGestureRecognizer(tap)
           
            //// edit ragaie
            screenView.addSubview(assistiveView)
            UIApplication.shared.keyWindow?.addSubview(screenView)
            touchButton.isHidden = true
            // animate view show
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
                 self.assistiveView.frame = CGRect.init(x: xPostion , y: yPostion, width: widthValue , height: widthValue )
            }, completion:  { (true) in
               self.myController.showElement(firstView: true,hidden: false)
                self.myController.setButtonInView()
            })
        }
   }
    
    
    
   
  // handle tap action in view
   @objc func handleTap(_ sender: UITapGestureRecognizer) {
        // handling code
    
      /*  if delgate != nil   {
            
            delgate.assistiveTouchWillDisAppear!()
        }
        */
        // hide view item before show it
        
        // hide secand view element 
      
        
        
        self.myController.showElement(firstView: false , hidden: true)
        
        // hide first view element
        self.myController.showElement(firstView: true , hidden: true)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
            self.assistiveView.frame = self.touchButton.frame
        }, completion: { (true) in
            self.assistiveView.isHidden = true
            self.touchButton.isHidden = false
            self.screenView.isHidden = true
        })
       
    }
    
 
    

}
