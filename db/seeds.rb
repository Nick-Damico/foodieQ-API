# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Recipe.create!(title: 'Orange Cream Cake', description: 'Everyone will enjoy the old-fashioned flavor of this super-moist cake topped with a soft light frosting. "This dessert reminds me of the frozen Creamsicles I enjoyed as a child," remarks Star Pooley of Paradise, California.')
Recipe.create!(title: 'Orange Chicken with Brussels Sprouts', description: 'This 30-minute recipe for orange chicken atop brussel sprouts is easy to make and so delicious! It’s an easy dinner recipe that your whole family will love.')

admin = User.new
admin.email = 'admin@foodieq.com'
admin.password = 'adminBoss'
admin.password_confirmation = 'adminBoss'
admin.admin = true
admin.save
user = User.new
user.email = 'user@bananas.com'
user.password = 'bananaBro'
user.password_confirmation = 'bananaBro'
user.save
