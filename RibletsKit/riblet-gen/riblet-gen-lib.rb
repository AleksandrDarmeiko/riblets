
require 'fileutils'

class Riblet

  def initialize(viewable)
    @viewable = viewable
    @name = ARGV[0]
    puts "Riblet name : #{@name}"
  end

  def make
    make_dir "#{@name}Riblet"
    make_builder_file
    make_router_file
    make_interactor_file
    if @viewable
      make_presenter_file
      make_view_controller_file
      make_story_board
    end
  end

  private

  def head_comment file_name
    <<-CONTENT
//
//  #{file_name}
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
    CONTENT

  end

  def global_imports
    <<-CONTENT
import Foundation
import UIKit
import RibletsKit
    CONTENT
  end

  def make_builder_file
    body = if @viewable 
<<-BODY
class #{@name}Builder: ViewableBuilder<Component,
                                             #{@name}Router,
                                             #{@name}Interactor,
                                             #{@name}Presenter,
                                             #{@name}ViewController> {
    
    static func defaultBuilder(component: Component) -> #{@name}Builder {
        return #{@name}Builder(component,
                                     routerClass: #{@name}Router.self,
                                     interactorClass: #{@name}Interactor.self,
                                     presenterClass: #{@name}Presenter.self,
                                     viewControllerClass: #{@name}ViewController.self)
    }
    
    /*!
      @brief 

      @discussion 
      - Defines secondary dependencies
      - Define communication dependencies
     */
    func buid() -> ViewableRoutable {
        let router = buildPrimaryUnits()
        
        return router
    }
    
}
BODY
          else
<<-BODY
class #{@name}Builder: Builder<Component,
                                             #{@name}Router,
                                             #{@name}Interactor> {
    
    static func defaultBuilder(component: Component) -> #{@name}Builder {
        return #{@name}Builder(component,
                                     routerClass: #{@name}Router.self,
                                     interactorClass: #{@name}Interactor.self)
    }
    
    /*!
      @brief 

      @discussion 
      - Defines secondary dependencies
      - Define communication dependencies
     */
    func buid() -> Routable {
        let router = buildPrimaryUnits()
        
        return router
    }
    
}
BODY
          end

    content = <<-CONTENT
#{head_comment builder_file_name}

#{global_imports}

#{@body}
    CONTENT
    make_riblet_file @name, builder_file_name, content
  end


  def make_router_file
    router_class = if @viewable
                     'ViewableRouter'
                   else
                     'Router'
                   end

    router_generics = if @viewable
                     "<#{@name}Interactor, #{@name}ViewController>"
                   else
                     "<#{@name}Interactor>"
                   end

    router_protocol = if @viewable
                     'ViewableRoutable'
                   else
                     'Routable'
                   end

    content = <<-CONTENT
#{head_comment router_file_name}

#{global_imports}

/*!
  @brief 

  @discussion 
    public methods for Interactor
 */
protocol #{@name}Routable : #{router_protocol} {
    
}
 
/*!
  @brief 

  @discussion 
    - Helper methods for attaching and detaching Routers
    - State-switching logic for determining states between multiple children
 */
class #{@name}Router: #{router_class}#{router_generics}, #{@name}Routable {

}
    CONTENT
    make_riblet_file @name, router_file_name, content
  end




  def make_interactor_file
    interactor_class = if @viewable
                         "ViewableInteractor<#{@name}Routable, #{@name}UserAction, #{@name}Presenter>"
                       else
                         "Interactor<#{@name}Routable>"
                       end

    

    activate_method = <<-ACTIVATE
    
    /*!
      @brief Entry point 

      @discussion 
      - do any activation business logic stuff here
     */
    override func didActivated() {
        super.didActivated()
        
    }
    
    /*!
     @brief Exit point 

     @discussion 
     - do any deactivation business logic stuff here
    */
    override func didDeactivated() {
        super.didDeactivated()
        
    }
ACTIVATE

    
    content = <<-CONTENT
#{head_comment interactor_file_name}

#{global_imports}

enum #{@name}UserAction {
   
}

class #{@name}Interactor : #{interactor_class} {
#{activate_method}
}
    CONTENT
    make_riblet_file @name, interactor_file_name, content
  end

  def make_presenter_file
    content = <<-CONTENT
#{head_comment presenter_file_name}
#{global_imports}

/*!
  @brief 

  @discussion 
  - Do any view logic here. Any if-else construction must be declared here
  - public methods for Interactor. Methods present Model structs provided by Interactor into ViewController 
    display methods calls with prepared for viewing data. Name of any method for this purpose must be started with "present".
  
 */
class #{@name}Presenter: Presenter<#{@name}ViewController> {

}

    CONTENT
    make_riblet_file @name, presenter_file_name, content
  end

  def make_view_controller_file
    content = <<-CONTENT
#{head_comment view_controller_file_name}

#{global_imports}

class #{@name}ViewController: ViewController<#{@name}UserAction> {

    /*!
     @brief  

     @discussion 
      
     Do any additional setup after loading the view.

     */
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /*!
     @brief  

     @discussion 
      
     Dispose of any resources that can be recreated.

     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: Public display methods for Presenter 

    // MARK: Public view hierarchy accessors for Router  

    // MARK: User actions

}

    CONTENT
    make_riblet_file @name, view_controller_file_name, content
  end

  def make_story_board
    content = <<-CONTENT
<?xml version="1.0" encoding="UTF-8"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="12120" systemVersion="16G8c" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" colorMatched="YES" initialViewController="cdr-cs-2Xp">
    <device id="retina4_7" orientation="portrait">
        <adaptation id="fullscreen"/>
    </device>
    <dependencies>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="12088"/>
        <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
    </dependencies>
    <scenes>
        <scene sceneID="sTD-c3-irx">
            <objects>
                <viewController id="cdr-cs-2Xp" customClass="#{@name}ViewController" customModuleProvider="target" sceneMemberID="viewController">
                    <layoutGuides>
                        <viewControllerLayoutGuide type="top" id="pyu-Ne-3eG"/>
                        <viewControllerLayoutGuide type="bottom" id="OZh-F1-8Lg"/>
                    </layoutGuides>
                    <view key="view" contentMode="scaleToFill" id="Ks4-pT-FDq">
                        <rect key="frame" x="0.0" y="0.0" width="375" height="667"/>
                        <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
                        <color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/>
                    </view>
                </viewController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="HOn-pc-nfm" userLabel="First Responder" sceneMemberID="firstResponder"/>
            </objects>
            <point key="canvasLocation" x="-262" y="108"/>
        </scene>
    </scenes>
</document>
    CONTENT
    make_riblet_file @name, story_board_file_name, content
  end

  



  def builder_file_name
    "#{@name}Builder.swift"
  end

  def router_file_name
    "#{@name}Router.swift"
  end

  def interactor_file_name
    "#{@name}Interactor.swift"
  end

  def presenter_file_name
    "#{@name}Presenter.swift"
  end

  def view_controller_file_name
    "#{@name}ViewController.swift"
  end

  def story_board_file_name
    "#{@name}.storyboard"
  end

  def make_riblet_file(dir_name, file_name, file_content)
    f = File.new("#{dir_name}Riblet/#{file_name}", 'w')
    f.puts file_content
    f.close
  end

  def make_dir(dir_name)
    if File.directory?(dir_name)
      FileUtils.rm_r dir_name
    end
    Dir.mkdir(dir_name)
  end

end
