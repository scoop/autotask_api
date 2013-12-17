module AutotaskAPI
  class Client
    NAMESPACE = 'http://autotask.net/ATWS/v1_5/'
    attr_accessor :savon_client, :wsdl, :basic_auth, :query, :log

    def initialize
      yield self
      self.savon_client ||= Savon.client do |c|
        c.basic_auth basic_auth
        c.wsdl wsdl
        c.pretty_print_xml true
        c.log !!log
        c.read_timeout 30
        c.open_timeout 30
      end
      Entity.client ||= self
    end

    def response
      savon_client.call :query, message: query,
        attributes: { xmlns: NAMESPACE }
    end

    def update(xml)
      savon_client.call :update, message: "<Entities>#{xml}</Entities>",
        attributes: { xmlns: NAMESPACE }
    end

    def create(xml)
      savon_client.call :create, message: "<Entities>#{xml}</Entities>",
        attributes: { xmlns: NAMESPACE }
    end

    def entities_for(query)
      self.query = query

      entities = response.xpath '//Autotask:Entity',
        Autotask: NAMESPACE

      return [] if entities.blank?

      klass = ('AutotaskAPI::' + entities.first.attribute('type').to_s).constantize
      entities.collect do |entity|
        klass.new entity
      end
    end

    def field_info(entity_name)
      savon_client.call :get_field_info, message: { psObjectType: entity_name }
    end

    def udf_info(entity_name)
      savon_client.call :get_udf_info, message: { psTable: entity_name }
    end
  end
end
