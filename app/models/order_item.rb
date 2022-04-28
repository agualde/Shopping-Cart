class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  before_save :set_unit_price
  before_save :set_total

  def unit_price
    
    if persisted? 

      # Discount logic is implemented at the unit_price level. Three conditions have to be met for a discount to be applied:

      # 1 - The product's code needs to match a desired product code (GR1 which means "Green Tea" in this case).
      # 2 - A quantity cuota needs to be met (2 or more in this case).
      # 3 - We check a boolean value in the OrderItem table that defaults to false, implying that this item in your cart has not been discounted before
      if product.code == 'GR1' && quantity >= 2 && self[:discounted] == false
        # When all conditions are met:
        # - The product gets marked as discounted
        self[:discounted] = true
        # - Discount gets applied (Half off in this case)
        self[:unit_price] = self[:unit_price] / 2
      # If the product quantity in your cart drops below a desired treshold  
      elsif product.code == 'GR1' && quantity < 2 && self[:discounted] == true 
        # - We mark it as not discounted
        self[:discounted] = false   
        # - And return the unit_price of the item to it's original value
        self[:unit_price] = self[:unit_price] * 2

      # In this case:
      # 1 - We find "Strawberries" by their code
      # 2- When 3 or more are in your cart
      # 3- And they havn't been discounted before  
      elsif product.code == 'SR1' && quantity >= 3 && self[:discounted] == false
        # - The product gets marked as discounted
        self[:discounted] = true
        # - And fifty (50) cents are removed from each unit added to your cart
        self[:unit_price] = self[:unit_price] - 0.5
      # A previously discounted bundle of "Strawberries" gets identified  
      elsif product.code == 'SR1' && quantity < 3 && self[:discounted] == true 
        # It's discounted status is reset to false
        self[:discounted] = false   
        # And fifty (50) cents gets added to each unit item 
        self[:unit_price] = self[:unit_price] + 0.5

      # 1 - Coffe get's identified by it's code
      # 2 - When 3 or more are in your cart
      # 3 - And it hasn't been discounted before
      elsif product.code == 'CF1' && quantity >= 3 && self[:discounted] == false
        # - The product gets marked as discounted
        self[:discounted] = true
        self[:unit_price] = self[:unit_price] / (2 / 3)
      elsif product.code == 'CF1' && quantity < 3 && self[:discounted] == true 
        self[:discounted] = false   
        self[:unit_price] = self[:unit_price] * (2 / 3)
        
      else
        self[:unit_price]
      end
 
    else
      product.price
    end

  end

  def total
   unit_price * quantity
  end

  private 

  def set_unit_price
    self[:unit_price] = unit_price
  end

  def set_total
    self[:total] = total * quantity
  end
end
