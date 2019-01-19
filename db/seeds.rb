# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
images = [
  { url: 'https://bit.ly/2siExH7', tag_list: 'Santa Barbara, landscape' },
  { url: 'https://bit.ly/2CfKXeF', tag_list: 'Sunshine' },
  { url: 'https://bit.ly/2siExH7', tag_list: 'Sunshine, Beach' },
  { url: 'https://bit.ly/2VMWVpj', tag_list: 'Health' },
  { url: 'https://bit.ly/2H8tLxv', tag_list: 'Sports, health'  },
  { url: 'https://bit.ly/2Ft668B', tag_list: 'landscape'  },
  { url: 'https://bit.ly/2VTF7bM', tag_list: 'desert'  },
  { url: 'https://bit.ly/2QGhAaJ', tag_list: 'Santa Barbara, building' },
  { url: 'https://bit.ly/2D9GhZL', tag_list: 'sea, moon'  },
  { url: 'https://bit.ly/2CjwJcJ', tag_list: 'hot'  },
  { url: 'https://bit.ly/2sqHZ2p', tag_list: 'animal'  },
  { url: 'https://bit.ly/2TLgU5J', tag_list: 'beach, Santa Barbara' },
  { url: 'https://bit.ly/2McJgU4', tag_list: 'Sunshine'  },
  { url: 'https://bit.ly/2FuqGp2', tag_list: 'sea, beach'  },
  { url: 'https://bit.ly/2D8m5qT', tag_list: 'California, landscape' },
  { url: 'https://bit.ly/2ALVmyL', tag_list: 'landscape'  },
  { url: 'https://bit.ly/2ALvras', tag_list: 'moon'  },
  { url: 'https://bit.ly/2SRckD2', tag_list: 'California, Santa Barbara, beach' },
  { url: 'https://bit.ly/2AKtriR', tag_list: 'Sunshine'  },
  { url: 'https://bit.ly/2FqAUYj', tag_list: 'health'  }
]

images.each do |image|
  Image.create! image
end
