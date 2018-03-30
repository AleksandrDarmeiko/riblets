#
#   ClassGen.rb
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

require_relative 'RibletsGenUtils'

class ClassGen

  def initialize(name)
    @name = name
  end

  def make
    RibletsGenUtils.make_riblet_file @name, file_name, body
  end

  def body
    <<-BODY
#{RibletsGenUtils.head_comment file_name}
    
#{content}    

    BODY
  end

  def file_name
    "#{@name}#{file_suffix}.swift"
  end

  def file_suffix
    ''
  end

  def content
    ''
  end

end