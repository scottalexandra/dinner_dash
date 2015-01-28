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

# #breakfast items ----------------------------------------------------------
Item.create(title: "Bagel Sandwich",
            description: "Toasted bagel, fried egg, and bacon",
            price: 750,
            image: open(path + "bagel_sandwich.jpg"))

CategoryItem.create(item_id: 1, category_id: 1)

Item.create(title: "Bacon and Egg Cups",
            description: "Bacon cups filled with egg",
            price: 1100,
            image: open(path + "bacon_and_egg_cups.jpg"))

CategoryItem.create(item_id: 2, category_id: 1)

Item.create(title: "Bacon, Egg, and Cheddar Scones",
            description: "Fresh cheddar cheese mixed with bacon and egg",
            price: 1500,
            image: open(path + "scones.jpg"))

CategoryItem.create(item_id: 3, category_id: 1)

#brunch items --------------------------------------------------------------
Item.create(title: "Casserole",
            description: "Delicious casserole filled with bacon",
            price: 1200,
            image: open(path + "casserole.jpg"))

CategoryItem.create(item_id: 4, category_id: 2)

Item.create(title: "Asparagus Mushroom Bacon Quiche",
            description: "Nothing better than a quiche with bacon",
            price: 1100,
            image: open(path + "quiche.jpg"))

CategoryItem.create(item_id: 5, category_id: 2)

Item.create(title: "Grilled Cheese French Toast With Bacon",
            description: "Grilled cheese.  French toast.  Bacon.  Nuff said",
            price: 1500,
            image: open(path + "grilled_cheese.jpg"))

CategoryItem.create(item_id: 6, category_id: 2)

#Lunch ----------------------------------------------------------------

Item.create(title: "Bacon-Wrapped Jalapeno Poppers",
            description: "Super spicy!",
            price: 1000,
            image: open(path + "pepper.jpg"))

CategoryItem.create(item_id: 7, category_id: 3)

Item.create(title: "Bacon Wrapped Chicken",
            description: "Farm raised chicken wrapped in bacon, and grilled to perfection",
            price: 1500,
            image: open(path + "bacon_wrapped_chicken.jpg"))

CategoryItem.create(item_id: 8, category_id: 3)

Item.create(title: "Bacon Potato Soup",
            description: "Hot soup with a touch of bacon",
            price: 800,
            image: open(path + "soup.jpg"))

CategoryItem.create(item_id: 9, category_id: 3)

# Dinner -------------------------------------------------------------
Item.create(title: "Sweet Bacon-Wrapped Venison Tenderloin",
            description: "Freshly hunted venison wrapped in crispy bacon.  It's a meal that is deer to me.",
            price: 2600,
            image: open(path + "venison.jpg"))

CategoryItem.create(item_id: 10, category_id: 4)

Item.create(title: "Spinach Salad with Honey Bacon Dressing",
            description: "Have some healthy salad... smotherer in honey bacon dressing",
            price: 1100,
            image: open(path + "salad.jpg"))

CategoryItem.create(item_id: 11, category_id: 4)

Item.create(title: "Bacon Cheeseburger Pasta",
            description: "Perfect combination of bacon, burger, cheese, and pasta",
            price: 1400,
            image: open(path + "pasta.jpg"))

CategoryItem.create(item_id: 12, category_id: 4)


# dessert -----------------------------------------------------------
Item.create(title: "Pecan-Bacon Squares a la Mode",
            description: "A warm treat topped with delicous vanilla ice cream",
            price: 1600,
            image: open(path + "venison.jpg"))

CategoryItem.create(item_id: 13, category_id: 5)

Item.create(title: "Cupcakes",
            description: "Chocolate-Bacon Cupcakes with Dulce De Lech Frosting",
            price: 1100,
            image: open(path + "cupcakes.jpg"))

CategoryItem.create(item_id: 14, category_id: 5)

Item.create(title: "Apple Bacon Galette",
            description: "Perfet end to a perfect meal",
            price: 1400,
            image: open(path + "galette.jpg"))

CategoryItem.create(item_id: 15, category_id: 5)

Item.create(title: "Bacon Skewers",
            description: "Maple Chocolate Bacon Skewers",
            price: 900,
            image: open(path + "skewers.jpg"))

CategoryItem.create(item_id: 16, category_id: 5)

Item.create(title: "Chocolate Brownies",
            description: "Smothered in vanilla icing and bacon!",
            price: 1000,
            image: open(path + "brownies.jpg"))

CategoryItem.create(item_id: 17, category_id: 5)

Item.create(title: "Ice Cream",
            description: "Bacon infused ice cream",
            price: 1400,
            image: open(path + "ice_cream2.jpg"))

CategoryItem.create(item_id: 18, category_id: 5)

Item.create(title: "Chipotle Bacon Spicy Pecan Caramel Apples",
            description: "Spicy sweet savory crunchy tart crisp",
            price: 1100,
            image: open(path + "apples.jpg"))

CategoryItem.create(item_id: 19, category_id: 5)

Item.create(title: "Bacon Treats",
            description: "Chocolate covered bacon strips with sprinkles",
            price: 1600,
            image: open(path + "choc_covered.jpg"))

CategoryItem.create(item_id: 20, category_id: 5)
