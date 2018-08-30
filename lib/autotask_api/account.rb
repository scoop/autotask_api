module AutotaskAPI
  class Account < Entity
    self.fields = [ :id, :account_name, :account_type, :last_activity_date,
                    :account_number, :phone, :alternate_phone1, :alternate_phone2,
                    :fax, :bill_to_address1, :bill_to_address2, :bill_to_city,
                    :bill_to_zip_code, :bill_to_state
    ]

    def account_type_name
      self.class.account_type_map[account_type]
    end

    def self.account_type_map
      @account_type_map ||= client.field_info(self.to_s.demodulize).
        xpath('//AT:Field/AT:Name[text()="AccountType"]/..//AT:PickListValue',
             AT: Client::NAMESPACE).
             inject({}) do |memo, node|
        value, label = node.xpath('(AT:Value | AT:Label)/text()',
                                 AT: Client::NAMESPACE).collect(&:to_s)
        memo[value] = label
        memo
      end
    end
  end
end
