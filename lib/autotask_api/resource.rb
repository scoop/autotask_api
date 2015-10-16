module AutotaskAPI
  class Resource < Entity
    self.fields = [ :id, :email, :first_name, :last_name, :user_name, :active ]

    def self.find_by_email(email)
      query = AutotaskAPI::QueryXML.new do |query|
        query.entity = self.to_s.demodulize
        query.field = 'email'
        query.expression = email
      end
      client.entities_for(query).first
    end

    def full_name
      [ first_name, last_name ].join(' ')
    end

    def firstname_lastname_initial
      "#{first_name} #{last_name[0]}."
    end

    def active?
      active.to_s == 'true'
    end
  end
end
