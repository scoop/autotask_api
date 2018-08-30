# frozen_string_literal: true

module AutotaskAPI
  # Invoice
  class Invoice < Entity
    self.fields = [:id, :user_defined_fields, :account_id,
                     :creator_resource_id, :invoice_date_time,
                     :create_date_time, :invoice_number,
                     :invoice_total, :total_tax_value, :from_date,
                     :order_number, :is_voided, :tax_region_name, :batch_id,
                     :invoice_editor_template_id]
  end
end
