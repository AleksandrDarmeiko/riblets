#
#   ComponentGen.rb
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

class ComponentGen < ClassGen

  def initialize(name, dependencies)
    super name
    @dependencies = dependencies
  end

  def dependency(dependency)
    <<-PROPERTY
    var #{dependency.property_name}: #{dependency.property_type} {
      get {
        #{dependency.instantiation_statement}
      }
    }

    PROPERTY
  end

  def content
    dependencies = @dependencies.inject('') { |all, d| all + dependency(d)}
    <<-BODY

class #{@name}Component {
    
    #{dependencies}
}
    BODY
  end

  def file_suffix
    'Component'
  end

end
