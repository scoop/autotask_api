require 'savon'
require 'nokogiri'

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

  class QueryXML
    attr_accessor :entity, :op, :field, :expression

    def initialize
      yield self
      self.op ||= 'equals'
    end

    def to_s
      Nokogiri::XML::Builder.new do
        sXML do
          cdata(Nokogiri::XML::Builder.new do |xml|
            xml.queryxml do
              xml.entity entity
              xml.query do
                xml.field field do
                  xml.expression expression, op: op
                end
              end
            end
          end.doc.root)
        end
      end.doc.root.to_s
    end
  end
end
