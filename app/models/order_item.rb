class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  before_save :set_unit_price
  before_save :set_total

  def unit_price
    if persisted? 
      apply_discount
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

  def apply_discount
    if product.code == 'GR1' && quantity >= 2 && self[:discounted] == false
      self[:discounted] = true
      self[:unit_price] = self[:unit_price] / 2
    elsif product.code == 'GR1' && quantity < 2 && self[:discounted] == true 
      self[:discounted] = false   
      self[:unit_price] = self[:unit_price] * 2

    elsif product.code == 'SR1' && quantity >= 3 && self[:discounted] == false
      self[:discounted] = true
      self[:unit_price] = self[:unit_price] - 0.5
    elsif product.code == 'SR1' && quantity < 3 && self[:discounted] == true 
      self[:discounted] = false   
      self[:unit_price] = self[:unit_price] + 0.5

    elsif product.code == 'CF1' && quantity >= 3 && self[:discounted] == false
      self[:discounted] = true
      self[:unit_price] = self[:unit_price] * 0.66
    elsif product.code == 'CF1' && quantity < 3 && self[:discounted] == true 
      self[:discounted] = false   
      self[:unit_price] = self[:unit_price] / 0.66

    else
      self[:unit_price]
    end
  end
end
