module AutotaskAPI
  class Product < Entity
    self.fields = [ :name, :vendor_product_number, :manufacturer_product_name, :manufacturer_name ]
  end
end
