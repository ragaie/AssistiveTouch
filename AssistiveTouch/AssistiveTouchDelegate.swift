//
//  File.swift
//  AssistiveTouch
//
//  Created by Ragaie alfy on 10/8/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import Foundation
import UIKit
@objc
public protocol AssistiveTouchDelegate {
    
    
    func assistiveTouch(_ assistiveTouch: AssistiveTouch, didClikedButton button : UIButton, atIndex index: Int)
    

    
}
