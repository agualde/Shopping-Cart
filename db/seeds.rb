puts 'Cleaning database .........'
Checkout.destroy_all
OrderItem.destroy_all
Product.destroy_all
User.destroy_all
Category.destroy_all

puts 'Creating categories............'
Category.create([ {name: 'grains'}, {name: 'drinks'}, {name: 'meats'}, {name: 'snacks'}, {name: 'fruits'} ])

fruits = Category.find_by(name: 'fruits')
drinks = Category.find_by(name: 'drinks')
meats = Category.find_by(name: 'meats')
snacks = Category.find_by(name: 'snacks')
grains = Category.find_by(name: 'grains')


lorem_ispum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."

puts 'Creating new products.......'
Product.create([
{name: 'Green Tea', code: 'GR1', price: '3.11', img_url: 'https://www.bigbasket.com/media/uploads/p/l/40024619-5_4-lipton-green-tea-pure-light.jpg', category: drinks, tags: 'drinks relaxing night meditations', description: lorem_ispum }, 
{ name: 'Strawberries', code: 'SR1', price: '5.00', img_url: 'https://m.media-amazon.com/images/S/assets.wholefoodsmarket.com/PIE/product/5e013c5f3761e572643cfbf0_dld-upc-00715756200061-glamor-frontpackageglamor-2019-10-16t13-37-23-b560765c-b928-4ad4-b1dd-9a01b2525217-1577139294447._TTD_._SR600,600_._QL100_.jpg', category: fruits, tags: 'fruit refreshing fresh berries berry', description: lorem_ispum }, 
{ name: 'Coffee', code: 'CF1', price: '11.23', img_url: 'https://m.media-amazon.com/images/I/61mKm0GiOkL._AC_SX385_.jpg', category: drinks, tags: 'energetic tasty mornings breakfast', description: lorem_ispum },
{name: 'Doritos',price: 0.99, code: 'DT1',img_url: 'https://m.media-amazon.com/images/I/81lmtPFluSL._AC_SX342_.jpg', tags: 'snacks nachos cheese chips frito lay', category: snacks, description: lorem_ispum},
{name: 'Chicken Breast',price: 4.99, code: 'CK1',img_url: 'https://assets.sainsburys-groceries.co.uk/gol/7874927/1/640x640.jpg', tags: 'meats protein diet fit', category: meats, description: lorem_ispum},
{name: 'White Rice',price: 1, code: 'WR1',img_url: 'https://m.media-amazon.com/images/I/71nXF+mgBoL._SL1000_.jpg', tags: 'grain carbohydrates carbs cheap', category: grains, description: lorem_ispum},
{name: 'Green Salad',price: 1.99, code: 'GR2', img_url: 'https://www.freshexpress.com/wp-content/uploads/2021/09/FEX_TenderLeaf_SpringMix_Bag_5oz_86104_US_FRONT-322x400.png', tags: ' veggies vegetables fit healthy', category: fruits, description: lorem_ispum},
{name: 'Grapes', price: 2.50, code: 'UVA',img_url: 'https://media.istockphoto.com/photos/grape-dark-grape-grapes-with-leaves-isolated-with-clipping-path-full-picture-id803721418?k=20&m=803721418&s=612x612&w=0&h=U2vUEoYYZD6xdYJc-2dhZpa1EvIxkXdiUaAlE-Kexn4=', tags: 'fruits fresh delicious', category:fruits, description: lorem_ispum },
{name: 'Mountain Dew', price: 2.75,code: 'MD1',img_url: 'https://static.carrefour.es/hd_510x_/img_pim_food/532460_00_1.jpg', tags: 'soda pop pepsi coca cola', category: drinks, description: lorem_ispum},
{name: 'Peanut Butter',price: 3.00,code: 'PB1',img_url: 'https://www.meijer.com/content/dam/meijer/product/0005/15/0072/00/0005150072001_2_A1C1_0600.png', tags: 'snack protein rich tasty fit fats', category: snacks, description: lorem_ispum}
])

puts 'Generating new users.......'
User.create([{ email: 'admin@gmail.com', password: '123456', admin: true }, 
{ email: 'shopper@gmail.com', password: '123456', admin: false }])

puts 'Done'