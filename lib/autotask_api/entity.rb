module AutotaskAPI
  class Entity
    class_attribute :fields, :client, :find_cache
    attr_accessor :attributes, :raw_xml

    def initialize(xml)
      self.raw_xml = xml
      self.attributes = {}
      fields.each do |field|
        attributes[field] = xml.at_xpath("Autotask:#{field.to_s == 'id' ? 'id' : field.to_s.camelize.gsub(/Id$/, 'ID')}",
          Autotask: Client::NAMESPACE).text.strip rescue ''
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

    def self.find(id, field = 'id')
      self.find_cache ||= {}
      find_cache[id] ||= find_all(id, field).first
    end

    def self.find_all(id, field = 'id')
      raise 'No initialized client!' unless client
      query = AutotaskAPI::QueryXML.new do |q|
        q.entity = to_s.demodulize
        q.field = field
        q.expression = id
      end
      client.entities_for(query)
    end

    def self.belongs_to(name, options = {})
      name = name.to_s
      klass = "AutotaskAPI::#{(options[:class_name] || name).to_s.classify}"
      foreign_key = name.foreign_key
      define_method name do
        klass.constantize.find send(foreign_key)
      end
    end

    def self.has_one(name, options = {})
      name = name.to_s
      options.reverse_merge! foreign_key: self.to_s.foreign_key.camelize
      klass = "AutotaskAPI::#{(options[:class_name] || name).to_s.classify}"
      define_method name do
        klass.constantize.find id, options[:foreign_key]
      end
    end
  end
end
