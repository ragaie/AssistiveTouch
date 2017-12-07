# AssistiveTouch
Adding Assistive key for your application,
you used to replace side menu or tabBar, with new concept in design mange ios appllication.

## Getting Started
 Add blow for your pod file 
   ```
   pod 'AssistiveTouch-Chtar'
   ```
   run pod update 

### Installing

A step by step series of examples that tell you have to get a development env running

Say what the step will be

```
import AssistiveTouch_Chtar
```
then conform AssistiveTouchDelegate
inialize Assistive button, add dataSource and delegate
```
class ViewController: UIViewController ,AssistiveTouchDelegate{

    var touchId : AssistiveTouch!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any aditional setup after loading the view, typically from a nib.
        
        touchId = AssistiveTouch()
        
        touchId.delgate = self
        var icons = [
            IconObject.init(iconImage: UIImage.init(named:"settings")!, iconTitle: "profile") ,
            IconObject.init(iconImage: UIImage.init(named: "settings")!, iconTitle: "bill") ,
            IconObject.init(iconImage: UIImage.init(named: "settings")!, iconTitle: "profile") ,
            IconObject.init(iconImage: UIImage.init(named: "settings")!, iconTitle: "bill")
            
            ]
        
        touchId.setDataSource(homeController: self.navigationController!, icons: icons )

    }
```

add method for delegate to listen to button click
```
   func assistiveTouch(_ assistiveTouch: AssistiveTouch, didClikedButton button: UIButton, atIndex index: Int) {
                touchId.showFrontViewController(<viewController name >: firstView, animate: true)

        print(index)
        
    }
```
if you show different view controller when click in button you need to use 
```

        touchId.showFrontViewController(<viewController name >: firstView, animate: true)

```


finaly you need to add button by viewDidApper
 ```
 override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        touchId.addTouch()

    }
```

if you appplication support rotation you need to implemnt this method 
```
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
   
        touchId.addTouch()
        
    }
```

and ther some modify to change deafult values 
```
   // change view color
        touchId.assistiveColor = UIColor.brown
        
        // you can change home icon or more icon or back image icon
        
         touchId.homeIcon = IconObject.init(iconImage: UIImage.init(named: "home")!, iconTitle: "")
        touchId.moreIcon = IconObject.init(iconImage: UIImage.init(named: "more")!, iconTitle: "More")
        touchId.backImage = UIImage.init(named: "star")
        
        
```

## you should get like this result 

![Screenshot](https://github.com/ragaie/AssistiveTouch/blob/master/Screen%20Shot%202017-12-07%20at%202.09.11%20PM.png)
![Screenshot](https://github.com/ragaie/AssistiveTouch/blob/master/Screen%20Shot%202017-12-07%20at%202.09.31%20PM.png)
![Screenshot](https://github.com/ragaie/AssistiveTouch/blob/master/Screen%20Shot%202017-12-07%20at%202.10.02%20PM.png)

## Author

* **Ragaie alfy Fahmey** - *Initial work* - [ragaie alfy](https://github.com/ragaie)


## MIT License


Copyright (c) 2017 ragaie alfy fahmey

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE

