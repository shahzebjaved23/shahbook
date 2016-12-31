# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Friendlevel.create(id:1,friendlevel: "Close Friend")
Friendlevel.create(id:2,friendlevel: "Friend")
Friendlevel.create(id:3,friendlevel: "Acquaintance")

Securitylevel.create(id:1,securitylevel: "Private")
Securitylevel.create(id:2,securitylevel: "Close Friend")
Securitylevel.create(id:3,securitylevel: "Friend")
Securitylevel.create(id:4,securitylevel: "Acquaintance")
Securitylevel.create(id:5,securitylevel: "Public")


