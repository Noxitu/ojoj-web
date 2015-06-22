# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

grzesiu = User.create :name => 'Grzesiu', :password => 'grzeg'
tester = User.create :name => 'Tester', :password => 'tets'

root_permission = Permission.create :name => 'Manage permissions'
Permission.create :name => 'Manage tasks'
tester_permission = Permission.create :name => 'Tester API'
Permission.create :name => 'Manage subs'
Permission.create :name => 'Manage shares'

grzesiu.permissions << root_permission
tester.permissions << tester_permission