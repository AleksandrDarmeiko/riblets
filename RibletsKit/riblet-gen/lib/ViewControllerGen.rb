#
#   ViewControllerGen.rb
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

require_relative 'ClassGen'

class ViewControllerGen < ClassGen

  def file_suffix
    'ViewController'
  end

  def content
    <<-CONTENT
class #{@name}ViewController: #{super_class} {

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
  end

  def super_class
    "ViewController<#{@name}UserAction>"
  end

end