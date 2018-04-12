#
#   Copyright (c) 2018. Aleksandr Darmeiko
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

require_relative 'BuilderGen'

class ViewableBuilderGen < BuilderGen

  def content
    <<-BODY
class #{@name}Builder: ViewableBuilder<#{@name}Component,
                                             #{@name}Router,
                                             #{@name}Interactor,
                                             #{@name}Presenter,
                                             #{@name}ViewController> {
    
    static func defaultBuilder(component: #{@name}Component) -> #{@name}Builder {
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
    func build() -> ViewableRoutable {
        let router = buildPrimaryUnits()
        
        #{dependencies}

        return router
    }
    
}
    BODY
  end



end