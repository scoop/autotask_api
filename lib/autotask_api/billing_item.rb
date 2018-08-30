# frozen_string_literal: true

module AutotaskAPI
  # BillingItem
  class BillingItem < Entity
    self.fields =
      %i[
        id user_defined_fields account_manager_when_approved_id type
        sub_type item_name description quantity rate total_amount
        our_cost item_date approved_time invoice_id item_approver_id
        account_id ticket_id allocation_code_id role_id time_entry_id
        non_billable tax_dollars purchase_order_number extended_price
        line_item_id line_item_full_description
        line_item_group_description internal_currency_extended_price
        internal_currency_rate internal_currency_tax_dollars
        internal_currency_total_amount
      ]
  end
end
