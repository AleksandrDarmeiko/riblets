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

require_relative 'InteractorGen'

class ViewableInteractorGen < InteractorGen

  def content
    <<-CONTENT
enum #{@name}UserAction {
   
}

class #{@name}Interactor : ViewableInteractor<#{@name}Routable, #{@name}UserAction, #{@name}Presenter> {

    #{dependencies}

    #{callbacks}

    override func handleUserAction(_ action: #{@name}UserAction) {
        super.handleUserAction(action)
        
        switch action {
        }
    }

}
    CONTENT
  end

end

