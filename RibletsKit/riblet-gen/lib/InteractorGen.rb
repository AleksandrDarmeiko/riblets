#
#   InteractorGen.rb
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

class InteractorGen < ClassGen


  def initialize(name, dependent_services)
    super name
    @dependent_services = dependent_services
  end

  def file_suffix
    'Interactor'
  end

  def content
    <<-CONTENT
class #{@name}Interactor : Interactor<#{@name}Routable> {

    #{dependencies}

    #{callbacks}

}
    CONTENT
  end

  def dependencies
    @dependent_services.inject('') do |dependent_services, dependent_service|
      dependent_services + <<-B
var #{dependent_service.property_name}: #{dependent_service.property_type}!
      B
    end
  end

  def callbacks
    <<-CALLBACKS
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

    CALLBACKS
  end

end
