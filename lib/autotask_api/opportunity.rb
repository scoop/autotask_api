module AutotaskAPI
  class Opportunity < Entity
    self.fields = [ :id, :title, :amount, :owner_resource_id ]
    belongs_to :owner_resource, class_name: :resource
  end
end
