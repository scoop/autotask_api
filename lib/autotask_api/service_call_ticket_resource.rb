module AutotaskAPI
  class ServiceCallTicketResource < Entity
    self.fields = [ :id, :ticket_id, :resource_id ]
    belongs_to :service_call_ticket
    has_one :resource
  end
end
