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

require_relative 'ClassGen'

class PresenterGen < ClassGen

  def content
    <<-CONTENT
/*!
  @brief 

  @discussion 
  - Do any view logic here. Any if-else construction must be declared here
  - public methods for Interactor. Methods present Model structures provided by Interactor into ViewController 
    display methods calls with prepared for viewing data. Name of any method for this purpose must be started with "present".
  
 */
class #{@name}Presenter: Presenter<#{@name}ViewController> {

}
    CONTENT
  end


  def file_suffix
    'Presenter'
  end

end