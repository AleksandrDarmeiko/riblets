#
#   Generator.rb
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
require_relative 'RibletDependencyMetaData'
require_relative 'ServiceDependencyMetaData'
require_relative 'ComponentGen'
require_relative 'ViewableBuilderGen'
require_relative 'ViewableRouterGen'
require_relative 'ViewableInteractorGen'
require_relative 'PresenterGen'
require_relative 'ViewControllerGen'
require_relative 'StoryboardGen'
require_relative 'BuilderGen'
require_relative 'InteractorGen'
require_relative 'PresentableViewableBuilderGen'
require_relative 'PresentableViewControllerGen'

class Generator

  ARG_KEY_IS_NONE = 0
  ARG_KEY_IS_TYPE = 1
  ARG_KEY_IS_DEPENDENT_RIBLETS = 2
  ARG_KEY_IS_DEPENDENT_SERVICES = 3
  ARG_KEY_IS_NAME = 4


  def determine_arg_key(arg)
    if arg == '-t'
      ARG_KEY_IS_TYPE
    elsif arg == '-r'
      ARG_KEY_IS_DEPENDENT_RIBLETS
    elsif arg == '-s'
      ARG_KEY_IS_DEPENDENT_SERVICES
    elsif arg == '-n'
      ARG_KEY_IS_NAME
    else
      ARG_KEY_IS_NONE
    end
  end

  def determine_args
    type = nil
    name = nil
    dependent_riblets = []
    dependent_services = []


    current_arg_key = ARG_KEY_IS_NONE
    ARGV.each do |arg|
      arg_key = determine_arg_key arg

      if arg_key == ARG_KEY_IS_NONE

        if current_arg_key == ARG_KEY_IS_TYPE
          type = arg
        elsif current_arg_key == ARG_KEY_IS_NAME
          name = arg
        elsif current_arg_key == ARG_KEY_IS_DEPENDENT_RIBLETS
          dependent_riblets << arg
        elsif current_arg_key == ARG_KEY_IS_DEPENDENT_SERVICES
          dependent_services << arg
        end

      else
        current_arg_key  = arg_key
      end
    end

    return type, dependent_riblets, dependent_services, name
  end

  def generate
    args = determine_args
    type = args[0]
    name = args[3]

    dependent_riblets = args[1].map do |dependent_riblet|
      RibletDependencyMetaData.new dependent_riblet
    end

    dependent_services = args[2].map do |dependent_service|
      ServiceDependencyMetaData.new dependent_service
    end

    dependencies = dependent_riblets + dependent_services


    RibletsGenUtils.make_dir name + 'Riblet'

    ComponentGen.new(name, dependencies).make
    if type == 'viewable'
      ViewableBuilderGen.new(name, dependent_riblets, dependent_services).make
      ViewableRouterGen.new(name, dependent_riblets).make
      ViewableInteractorGen.new(name, dependent_services).make
      PresenterGen.new(name).make
      ViewControllerGen.new(name).make
      StoryboardGen.new(name).make
    elsif type == 'viewless'
      BuilderGen.new(name, dependent_riblets, dependent_services).make
      RouterGen.new(name, dependent_riblets).make
      InteractorGen.new(name, dependent_services).make
    elsif type == 'presentable'
      PresentableViewableBuilderGen.new(name, dependent_riblets, dependent_services).make
      ViewableRouterGen.new(name, dependent_riblets).make
      ViewableInteractorGen.new(name, dependent_services).make
      PresentableViewControllerGen.new(name).make
      StoryboardGen.new(name).make
    else
      abort 'type must be one of viewable, viewless or presentable'
    end

  end


end