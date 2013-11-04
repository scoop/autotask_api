require 'time'

module AutotaskAPI
  class AccountNote < Entity
    self.fields = [ :id, :account_id, :action_type, :note, :start_date_time,
                    :end_date_time, :contact_id, :assigned_resource_id ]

    belongs_to :account
    belongs_to :contact
    belongs_to :assigned_resource, class_name: :resource

    delegate :account_name, to: :account

    def start_time
      Time.parse start_date_time
    end

    def end_time
      Time.parse end_date_time
    end
  end
end
