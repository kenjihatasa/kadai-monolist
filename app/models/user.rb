class User < ApplicationRecord
  has_secure_password
  
  has_many :ownerships
  has_many :items, through: :ownerships
  
  has_many :wants
  has_many :want_items, through: :wants, class_name: 'Item', source: :item
  
  has_many :hs
  has_many :h_items, through: :hs, class_name: 'Item', source: :item
  
  
  def want(item)
    self.wants.find_or_create_by(item_id: item.id)
  end

  def unwant(item)
    want = self.wants.find_by(item_id: item.id)
    want.destroy if want
  end

  def want?(item)
    self.want_items.include?(item)
  end
  
  def h(item)
    self.hs.find_or_create_by(item_id: item.id)
  end

  def unh(item)
    h = self.hs.find_by(item_id: item.id)
    h.destroy if have
  end

  def h?(item)
    self.h_items.include?(item)
  end
end
