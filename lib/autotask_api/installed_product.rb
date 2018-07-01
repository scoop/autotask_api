module AutotaskAPI
  class InstalledProduct < Entity
    self.fields = [ :id, :product_id, :reference_number, :reference_title,
                    :serial_number, :warranty_expiration_date ]
  end
end
