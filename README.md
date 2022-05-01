- Steps to run locally:

1 - From terminal run 'rails db:create'
2 - run 'bundle install'
3 - 'yarn add stimulus-use'
4 - 'rails generate devise:install'
5 - 'rails g rails_admin:install'
6 - 'rails db:migrate'
7 - 'rails db:seed'

- Base level logic:

A simple DB structure is implemented consisting of four models:
1 - User,
2 - Product,
3 - OrderItem and
4 - Cart

A User can visit the Product index and show page, select a product. A call to action in the form of button 'Add to Cart' and a 'Quantity' number field is present. This action generates an Order Item which is composed of user_id, product_id, quantity, unit_price and total_price. In the Order Item model we define methods to calculate prices based on quantity and unit price, discounts are applied accordingly at the unit price level. An Order Item belongs to a Cart which consists of total and subtotal. Inside the Cart model we have methods that collect and calculate total price which is informed by the Order Item's total unit price and quantity.

- Sessions and cookies:

  A session is used to track users shopping carts. The variable current_cart is in the ApplicationHelper and imported into the ApplicationController.

- Admin access and privileges:

Two users are provided:

1 - email: shopper@gmail.com, password: 123456, admin: false

2 - email: admin@gmail.com, password: 123456, admin: true

After adding the devise gem for authentication a boolean value is added to the User model table named "admin".

The gem "rails_admin" was added to allow users marked as admins to access full CRUD capabilities from a panel found at the root URL ending in "/admin". A user without the
true boolean value in this position will get redirected to the root_path

- PG_Search:

The gem is implemented and a search form performing a GET request is present in the Product index page which redirects to itself. If a query is present
the method .global_search is applied.

- Discount logic:

  It is implemented at the unit_price level in the OrderItem model as a private method called when the unit_price is being computed in the model itself.

  Three conditions have to be met for a discount to be applied:

  1 - A product's code needs to match a desired product code (GR1 which means "Green Tea" in this case).
  2 - A quantity cuota needs to be met (2 or more in this case).
  3 - A boolean value in the OrderItem table that defaults to false has to equal false implying that this item in your cart has not been discounted before
  if product.code == 'GR1' && quantity >= 2 && self[:discounted] == false

  After all conditions are met:

  The product gets marked as discounted
  self[:discounted] = true

  Discount gets applied (In this case half off)
  self[:unit_price] = self[:unit_price] / 2

  If the product quantity in your cart drops below a desired treshold and the discount had been applied before,
  elsif product.code == 'GR1' && quantity < 2 && self[:discounted] == true

  We mark it as not discounted
  self[:discounted] = false

  And return the unit_price of the item to it's original value
  self[:unit_price] = self[:unit_price] x 2

  In this case:

  1 - We find "Strawberries" by their code
  2 - When 3 or more are in your cart
  3 - And they havn't been discounted before
  elsif product.code == 'SR1' && quantity >= 3 && self[:discounted] == false

  The product gets marked as discounted
  self[:discounted] = true

  And fifty (50) cents are removed from each unit added to your cart
  self[:unit_price] = self[:unit_price] - 0.5

  A previously discounted bundle of "Strawberries" gets identified
  elsif product.code == 'SR1' && quantity < 3 && self[:discounted] == true

  It's discounted status is reset to false
  self[:discounted] = false

  And fifty (50) cents gets added per unit item
  self[:unit_price] = self[:unit_price] + 0.5

  1 - Coffe get's identified by it's code
  2 - When 3 or more are in your cart
  3 - And it hasn't been discounted before
  elsif product.code == 'CF1' && quantity >= 3 && self[:discounted] == false

  The product gets marked as discounted
  self[:discounted] = true

  A discount of two thirds is applied to each unit item
  self[:unit_price] = self[:unit_price] / (2 / 3)

  If the Coffee quantity in your cart where to drop below three (3) units and the discount had been applied before
  elsif product.code == 'CF1' && quantity < 3 && self[:discounted] == true

  The cart item containing the coffee gets marked as not discounted
  self[:discounted] = false

  And its price is returned to the default value
  self[:unit_price] = self[:unit_price] \* (2 / 3)
