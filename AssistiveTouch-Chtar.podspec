Pod::Spec.new do |s|
  s.platform = :ios
  s.name             = 'AssistiveTouch-Chtar'
  s.version          = '0.02'
  s.summary          = 'AssistiveTouch   component for iOS '
 
  s.description      = <<-DESC
AssistiveTouch component for using in iOS!, allow you mange your application replace your tabBar of sideMenu it like Assistivekey default in iOS Operating system.
                       DESC
 
  s.homepage         = 'https://ragaie.github.io/AssistiveTouch/.'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ragaie Alfy' => 'eng.ragaie@gmail.com' }
  s.source           = { :git => 'https://github.com/ragaie/AssistiveTouch', :tag => s.version.to_s }
 
  s.framework = "UIKit"
  s.ios.deployment_target = '8.0'
  s.source_files = 'AssistiveTouch/AssistiveTouch.swift','AssistiveTouch/AssistiveController.swift','AssistiveTouch/AssistiveModel.swift','AssistiveTouch/IconObject.swift','AssistiveTouch/AssistiveTouchDelegate.swift'


  s.resources = 'AssistiveTouch/Assistive.xcassets'

  s.resource_bundle = {'AssistiveTouch-Chtar' => ['AssistiveTouch/Assistive.xcassets']}



 
 
  
end