module AutotaskAPI
  class QueryXML
    Condition = Struct.new(:field, :op, :expression)
    attr_accessor :entity, :op, :field, :expression, :conditions

    def initialize
      yield self
      self.op ||= 'equals'
    end

    def add_condition(field, op, expression)
      self.conditions ||= []
      self.conditions << Condition.new(field, op, expression)
    end

    def to_s
      Nokogiri::XML::Builder.new do
        sXML do
          cdata(Nokogiri::XML::Builder.new do |xml|
            xml.queryxml do
              xml.entity entity
              xml.query do
                if field
                  xml.field field do
                    xml.expression expression, op: op
                  end
                else
                  conditions.each do |condition|
                    xml.condition do
                      xml.field condition.field do
                        xml.expression condition.expression,
                          op: condition.op
                      end
                    end
                  end
                end
              end
            end
          end.doc.root)
        end
      end.doc.root.to_s
    end
  end
end
