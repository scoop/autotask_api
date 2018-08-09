module AutotaskAPI
  class Account < Entity
    self.fields = [ :id, :account_name, :account_type, :last_activity_date ]

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
