#
#   ViewableRouterGen.rb
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

require_relative 'RouterGen'

class ViewableRouterGen < RouterGen

  def content
    <<-CONTENT
/*!
  @brief 

  @discussion 
    public methods for Interactor
 */
protocol #{@name}Routable : ViewableRoutable {
    
}
 
/*!
  @brief 

  @discussion 
    - Helper methods for attaching and detaching Routers
    - State-switching logic for determining states between multiple children
 */
class #{@name}Router: ViewableRouter<#{@name}Interactor, #{@name}ViewController>, #{@name}Routable {

    #{dependencies}

}
    CONTENT
  end


end