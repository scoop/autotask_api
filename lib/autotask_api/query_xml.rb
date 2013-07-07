module AutotaskAPI
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
