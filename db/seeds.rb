# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

achille_org = Org.find_by_permalink('achille')
if achille_org.blank?
  achille_org = Org.create!(
    {
      name: 'Achillé Inc.',
      permalink: 'achille',
      url: 'http://achille.io',
      phone: '(650) 888-5962',
      email: 'matt@achille.io'
    }
  )
  puts "Creating org: #{achille_org.permalink}: #{achille_org.id.to_s}"
end