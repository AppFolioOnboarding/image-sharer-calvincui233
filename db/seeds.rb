# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
images = [
  { url: 'https://bit.ly/2siExH7' },
  { url: 'https://bit.ly/2CfKXeF' },
  { url: 'https://bit.ly/2siExH7' },
  { url: 'https://bit.ly/2VMWVpj' },
  { url: 'https://bit.ly/2H8tLxv' },
  { url: 'https://bit.ly/2Ft668B' },
  { url: 'https://bit.ly/2VTF7bM' },
  { url: 'https://bit.ly/2QGhAaJ' },
  { url: 'https://bit.ly/2D9GhZL' },
  { url: 'https://bit.ly/2CjwJcJ' },
  { url: 'https://bit.ly/2sqHZ2p' },
  { url: 'https://bit.ly/2TLgU5J' },
  { url: 'https://bit.ly/2McJgU4' },
  { url: 'https://bit.ly/2FuqGp2' },
  { url: 'https://bit.ly/2D8m5qT' },
  { url: 'https://bit.ly/2ALVmyL' },
  { url: 'https://bit.ly/2ALvras' },
  { url: 'https://bit.ly/2SRckD2' },
  { url: 'https://bit.ly/2AKtriR' },
  { url: 'https://bit.ly/2FqAUYj' }
]

images.each do |image|
  Image.create! image
end
