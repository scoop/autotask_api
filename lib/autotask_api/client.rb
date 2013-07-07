module AutotaskAPI
  class Client
    attr_accessor :savon_client, :wsdl, :basic_auth

    def initialize
      yield self
      self.savon_client ||= Savon.client do |c|
        c.basic_auth basic_auth
        c.wsdl wsdl
        c.pretty_print_xml true
      end
      self
    end

    def query(query)
      savon_client.call :query, message: query,
        attributes: { xmlns: 'http://autotask.net/ATWS/v1_5/' }
    end
  end
end
