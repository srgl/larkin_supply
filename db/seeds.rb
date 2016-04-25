# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

dispatcher = User.new
dispatcher.email = 'dispatcher@larkin.com'
dispatcher.password = 'larkin'
dispatcher.password_confirmation = 'larkin'
dispatcher.save!

driver = User.new
driver.email = 'driver@larkin.com'
driver.password = 'larkin'
driver.password_confirmation = 'larkin'
driver.save!