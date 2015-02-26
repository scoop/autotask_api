module AutotaskAPI
  class ServiceCall < Entity
    self.fields = [ :id, :start_date_time, :end_date_time,
                    :account_id, :description ]
    has_one :service_call_ticket
  end
end
