module AutotaskAPI
  class Entity
    class_attribute :fields, :client
    attr_accessor :attributes

    def initialize(xml)
      self.attributes = {}
      fields.each do |field|
        attributes[field] = xml.at_xpath("Autotask:#{field.to_s.camelize}",
          Autotask: Client::NAMESPACE).text.strip
      end
      attributes
    end

    def method_missing(method, *args, &block)
      if attributes.include?(method.to_sym)
        attributes[method.to_sym]
      else
        super
      end
    end
  end
end
