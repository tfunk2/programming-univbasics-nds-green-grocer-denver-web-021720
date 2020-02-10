require 'pry'
require 'pp'
def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  item_index = 0
  while item_index < collection.length do
    
  if name == collection[item_index][:item]
   return collection[item_index]
   
    end
    item_index += 1
  end
end


def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  new_cart = []
  item_index = 0
  
  while item_index < cart.length do
    new_cart_item_comparison = find_item_by_name_in_collection(cart[item_index][:item], new_cart)
    if new_cart_item_comparison
      new_cart_item_comparison[:count] += 1 
    else
      new_cart_item = {
        :item => cart[item_index][:item],
        :price => cart[item_index][:price],
        :clearance => cart[item_index][:clearance],
        :count => 1
      }
      new_cart << new_cart_item
    end
    item_index += 1
  end
  new_cart
end



def apply_coupons(cart, coupons)
  i = 0
  while i < coupons.length do 
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    couponed_item_name = "#{coupons[i][:item]} W/COUPON"
    couponed_cart_item = find_item_by_name_in_collection(couponed_item_name, cart)
      
      if cart_item && cart_item[:count] >= coupons[i][:num]
        if couponed_cart_item 
          couponed_cart_item[:count] += coupons[i][:num]
          cart_item -= coupons[i][:num]
        else
          newly_couponed_item = {
            :item => couponed_item_name,
            :price => coupons[i][:cost] / coupons[i][:num],
            :clearance => cart_item[:clearance],
            :count => coupons[i][:num]
          }
          cart << newly_couponed_item
          cart_item[:count] -= coupons[i][:num]
        end
      end
    i += 1 
  end
  cart
end


# REMEMBER: This method **should** update cart
def apply_clearance(cart)
  i = 0 
  while i < cart.length do
    if cart[i][:clearance] == true
      cart[i][:price] = (cart[i][:price] * 0.8).round(2)
    end
    i += 1 
  end 
  cart
end



def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  cart_consolidated = consolidate_cart(cart)
  coupons_applied = apply_coupons(cart_consolidated, coupons)
  clearance_applied = apply_clearance(coupons_applied)
  i = 0
  final_total = 0
  
  while i < clearance_applied.length do
    final_total += (clearance_applied[i][:price] * clearance_applied[i][:count])
    i += 1
  end
  if final_total > 100
    final_total * 0.9
  else
    final_total
  end
end