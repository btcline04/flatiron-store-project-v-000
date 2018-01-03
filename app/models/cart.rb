class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user

  def total
    sum = 0
    line_items.each do |li|
      sum += (li.item.price * li.quantity)
    end
    sum
  end

  def cart_checkout
    self.status = "submitted"
    line_items.each do |li|
      li.item.inventory = li.item.inventory - li.quantity
      li.item.save
    end
  self.save
  end

  def add_item(item)
    add = line_items.find_by(item_id: item)
    if add
      add.quantity += 1
    else
      add = line_items.create(item_id: item)
      add.create_item
    end
    add
  end

end
