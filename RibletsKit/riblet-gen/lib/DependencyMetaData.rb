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

require_relative 'Extensions'

class DependencyMetaData

  def initialize(name)
    @name = name
  end

  def property_name
    @name.uncapitalize + suffix
  end

  def property_type
    @name + suffix
  end

  def suffix
    ''
  end

  def instantiation_statement
    ''
  end

end
