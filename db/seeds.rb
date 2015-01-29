Admin.create([{ first_name: "Admin_first",
                last_name: "Admin_last",
                email: "admin@email.com",
                password: "password"
                }])

User.create([{ first_name: "Alice",
               last_name: "alast_name",
               email: "alice@email.com",
               display_name: "user_1",
               password: "password" },
             { first_name: "Bob",
               last_name: "blast_name",
               email: "bob@email.com",
               display_name: "user_2",
               password: "password" },
             { first_name: "Carol",
               last_name: "clast_name",
               email: "carlo@email.com",
               display_name: "user_3",
               password: "password" },
             { first_name: "Dave",
               last_name: "dlast_name",
               email: "dave@email.com",
               display_name: "user_4",
               password: "password" },
             { first_name: "eve",
               last_name: "elast_name",
               email: "eve@email.com",
               display_name: "user_5",
               password: "password"
               }])

categories = Category.create([{ name: "Breakfast" },
                              { name: "Brunch" },
                              { name: "Lunch" },
                              { name: "Dinner" },
                              { name: "Dessert"
                                }])

path = 'app/assets/images/'

#breakfast -----------------------------------------------------------------
item1 = Item.new(title: "Bagel Sandwich",
                 description: "Toasted bagel, fried egg, and bacon",
                 price: 750,
                 image: open(path + "bagel_sandwich.jpg"))

item1.categories << categories[0]
item1.save

item2 = Item.new(title: "Bacon and Egg Cups",
                 description: "Bacon cups filled with egg",
                 price: 1100,
                 image: open(path + "bacon_and_egg_cups.jpg"))

item2.categories << categories[0]
item2.save

item3 = Item.new(title: "Bacon, Egg, and Cheddar Scones",
                 description: "Fresh cheddar cheese mixed with bacon and egg",
                 price: 1500,
                 image: open(path + "scones.jpg"))

item3.categories << categories[0]
item3.save

#Brunch --------------------------------------------------------------------
item4 = Item.new(title: "Casserole",
                 description: "Delicious casserole filled with bacon",
                 price: 1200,
                 image: open(path + "casserole.jpg"))

item4.categories << categories[1]
item4.save

item5 = Item.new(title: "Asparagus Mushroom Bacon Quiche",
                 description: "Nothing better than a quiche with bacon",
                 price: 1100,
                 image: open(path + "quiche.jpg"))

item5.categories << categories[1]
item5.save

item6 = Item.new(title: "Grilled Cheese French Toast With Bacon",
                 description: "Grilled cheese.  French toast.  Bacon.  Nuff said",
                 price: 1500,
                 image: open(path + "grilled_cheese.jpg"))

item6.categories << categories[1]
item6.save

#Lunch items----------------------------------------------------------------

item7 = Item.new(title: "Bacon-Wrapped Jalapeno Poppers",
                 description: "Super spicy!",
                 price: 1000,
                 image: open(path + "pepper.jpg"))

item7.categories << categories[2]
item7.save

item8 = Item.new(title: "Bacon Wrapped Chicken",
                 description: "Farm raised chicken wrapped in bacon, and grilled to perfection",
                 price: 1500,
                 image: open(path + "bacon_wrapped_chicken.jpg"))

item8.categories << categories[2]
item8.save

item9 = Item.new(title: "Bacon Potato Soup",
                description: "Hot soup with a touch of bacon",
                price: 800,
                image: open(path + "soup.jpg"))

item9.categories << categories[2]
item9.save

# Dinner items-------------------------------------------------------------
item10 = Item.new(title: "Sweet Bacon-Wrapped Venison Tenderloin",
                  description: "Freshly hunted venison wrapped in crispy bacon.  It's a meal that is deer to me.",
                  price: 2600,
                  image: open(path + "venison.jpg"))

item10.categories << categories[3]
item10.save

item11 = Item.new(title: "Spinach Salad with Honey Bacon Dressing",
                  description: "Have some healthy salad... smotherer in honey bacon dressing",
                  price: 1100,
                  image: open(path + "salad.jpg"))

item11.categories << categories[3]
item11.save

item12 = Item.new(title: "Bacon Cheeseburger Pasta",
                  description: "Perfect combination of bacon, burger, cheese, and pasta",
                  price: 1400,
                  image: open(path + "pasta.jpg"))

item12.categories << categories[3]
item12.save


# dessert items-----------------------------------------------------------
item13 = Item.new(title: "Pecan-Bacon Squares a la Mode",
                  description: "A warm treat topped with delicous vanilla ice cream",
                  price: 1600,
                  image: open(path + "ice_cream.jpg"))

item13.categories << categories[4]
item13.save

item14 = Item.new(title: "Cupcakes",
                  description: "Chocolate-Bacon Cupcakes with Dulce De Lech Frosting",
                  price: 1100,
                  image: open(path + "cupcakes.jpg"))

item14.categories << categories[4]
item14.save

item15 = Item.new(title: "Apple Bacon Galette",
                  description: "Perfet end to a perfect meal",
                  price: 1400,
                  image: open(path + "galette.jpg"))

item15.categories << categories[4]
item15.save

item16 = Item.new(title: "Bacon Skewers",
                  description: "Maple Chocolate Bacon Skewers",
                  price: 900,
                  image: open(path + "skewers.jpg"))

item16.categories << categories[4]
item16.save

item17 = Item.new(title: "Chocolate Brownies",
                  description: "Smothered in vanilla icing and bacon!",
                  price: 1000,
                  image: open(path + "brownies.jpg"))

item17.categories << categories[4]
item17.save

item18 = Item.new(title: "Ice Cream",
                  description: "Bacon infused ice cream",
                  price: 1400,
                  image: open(path + "ice_cream2.jpg"))

item18.categories << categories[4]
item18.save

item19 = Item.new(title: "Chipotle Bacon Spicy Pecan Caramel Apples",
                  description: "Spicy sweet savory crunchy tart crisp",
                  price: 1100,
                  image: open(path + "apples.jpg"))

item19.categories << categories[4]
item19.save

item20 = Item.new(title: "Bacon Treats",
                  description: "Chocolate covered bacon strips with sprinkles",
                  price: 1600,
                  image: open(path + "choc_covered.jpg"))

item20.categories << categories[4]
item20.save
