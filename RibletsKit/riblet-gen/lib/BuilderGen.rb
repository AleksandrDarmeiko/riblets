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

class BuilderGen < ClassGen


  def initialize(name, dependent_riblets, dependent_services)
    super(name)
    @dependent_riblets = dependent_riblets
    @dependent_services = dependent_services
  end

  def content
    <<-BODY
class #{@name}Builder: Builder<#{@name}Component,
                                             #{@name}Router,
                                             #{@name}Interactor> {
    
    static func defaultBuilder(component: #{@name}Component) -> #{@name}Builder {
        return #{@name}Builder(component, 
                                  routerClass: #{@name}Router.self, 
                                  interactorClass: #{@name}Interactor.self)
    }
    
    /*!
      @brief 

      @discussion 
      - Defines secondary dependencies
      - Define communication dependencies
     */
    func build() -> Routable {
        let router = buildPrimaryUnits()
        
        #{dependencies}

        return router
    }
    
}
    BODY
  end

  def file_suffix
    'Builder'
  end

  def dependencies
    dependent_riblets = @dependent_riblets.inject('') do |dependent_riblets, dependent_riblet|
      dependent_riblets + <<-B
router.#{dependent_riblet.property_name} = component.#{dependent_riblet.property_name}
      B
    end

    dependent_services = @dependent_services.inject('') do |dependent_services, dependent_service|
      dependent_services + <<-B
router.interactor.#{dependent_service.property_name} = component.#{dependent_service.property_name}
      B
    end

    dependent_riblets + dependent_services
  end

end