puts 'Cleaning database .........'
Product.destroy_all
User.destroy_all

puts 'Creating new products.......'
Product.create([{name: 'Green Tea', code: 'GR1', price: '3.11', img_url: 'https://www.bigbasket.com/media/uploads/p/l/40024619-5_4-lipton-green-tea-pure-light.jpg' }, 
    { name: 'Strawberries', code: 'SR1', price: '5.00', img_url: 'https://m.media-amazon.com/images/S/assets.wholefoodsmarket.com/PIE/product/5e013c5f3761e572643cfbf0_dld-upc-00715756200061-glamor-frontpackageglamor-2019-10-16t13-37-23-b560765c-b928-4ad4-b1dd-9a01b2525217-1577139294447._TTD_._SR600,600_._QL100_.jpg' }, 
    { name: 'Coffee', code: 'CF1', price: '11.23', img_url: 'https://m.media-amazon.com/images/I/61mKm0GiOkL._AC_SX385_.jpg' } ])

puts 'Generating new users.......'
User.create([{ email: 'admin@gmail.com', password: '123456', admin: true }, 
{ email: 'shopper@gmail.com', password: '123456', admin: false }])

puts 'Done'