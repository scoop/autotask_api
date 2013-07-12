module AutotaskAPI
  class Resource < Entity
    self.fields = [ :email, :first_name, :last_name, :user_name ]

    def full_name
      [ first_name, last_name ].join
    end
  end
end
