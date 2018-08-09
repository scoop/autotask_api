module AutotaskAPI
  class InstalledProduct < Entity
    self.fields = [ :id, :product_id, :contract_id, :service_id,
                    :service_bundle_id, :reference_number, :reference_title,
                    :serial_number, :warranty_expiration_date ]
    belongs_to :service
    belongs_to :service_bundle
  end
end
