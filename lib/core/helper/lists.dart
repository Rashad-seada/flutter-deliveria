import 'package:delveria/core/helper/images.dart';
import 'package:delveria/features/admin/coupons/data/models/coupon.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/agent_model.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/restaurant.dart';
import 'package:delveria/features/admin/users/data/models/users_model.dart';
import 'package:delveria/features/client/adresses/data/models/address.dart';
import 'package:delveria/features/client/filter/data/models/categories.dart';
import 'package:delveria/features/client/filter/data/models/resturant.dart';
import 'package:delveria/features/client/resturant/data/model/menu_item.dart';

class AppLists {
  static final List<Map<String, String>> onboardingData = [
    {
      "title": 'احصل على طعامك أسرع من أي وقت مضى',
      "description":
          'اطلب في ثوانٍ، يصلك في دقائق — ساخن وطازج إلى باب منزلك.',
      "image": AppImages.slideOne,
    },
    {
      "title": 'توصيل بعناية واهتمام',
      "description":
          'أكثر من مجرد توصيل. نحن نوصل بطموح، ودقة، واهتمام.',
      "image": AppImages.slideTwo,
    },
    {
      "title": 'تتبع التوصيل لحظياً',
      "description":
          'ابقَ على اطلاع — من التحضير حتى الوصول. شاهد طلبك يقترب منك مباشرة وبدقة.',
      "image": AppImages.slideThree,
    },
  ];
  static final List<Restaurant> restaurants = [
    Restaurant(
      "Quick Food restaurant",
      "Burger - Chicken - Boxes - Wings - Sandwiches - Crepes",
      4.7,
    ),
    Restaurant(
      "Eldelka Restaurant",
      "Burger - Chicken - Pasta - Bakeries - Sandwiches",
      4.5,
    ),
    Restaurant(
      "YFC Restaurant",
      "Burger - Chicken - Boxes - Wings - Sandwiches - Crepes",
      4.2,
    ),
    Restaurant(
      "Al Beet Restaurant",
      "Burger - Chicken - Pasta - Bakeries - Sandwiches",
      3.9,
    ),
    Restaurant(
      "Moods Restaurant",
      "Burger - Chicken - Boxes - Wings - Sandwiches - Crepes",
      4.2,
    ),
    Restaurant(
      "Boska Restaurant",
      "Burger - Chicken - Pasta - Bakeries - Sandwiches",
      3.9,
    ),
  ];
  static final List<CategoryItem> categories = [
    CategoryItem("Cuisines", AppImages.snacks),
    CategoryItem("Meal", AppImages.meals),
    CategoryItem("Vegan", AppImages.vegan),
    CategoryItem("Bakeries", AppImages.deserts),
    CategoryItem("Drinks", AppImages.drinks),
  ];
  static final List<String> cuisineTypes = [
    "American Cuisine",
    "Egyptian Cuisine",
    "Indian Cuisine",
    "Japanese",
  ];
  static final List<Restaurant> featuredRestaurants = [
    Restaurant(
      "Quick Food restaurant",
      "Burger - Chicken - Boxes - Wings - Sandwiches - Crepes",
      0,
      category: "American Food",
    ),
    Restaurant(
      "Jac Reastaurant",
      "Burger - Chicken - Boxes - Wings - Sandwiches - Crepes",
      0,
      category: "American Food",
    ),
    Restaurant(
      "Quick Food restaurant",
      "Burger - Chicken - Boxes - Wings - Sandwiches - Crepes",
      0,
      category: "American Food",
    ),
    Restaurant(
      "Jac Reastaurant",
      "Burger - Chicken - Boxes - Wings - Sandwiches - Crepes",
      0,
      category: "American Food",
    ),
  ];
  static final List<MenuItem> menuItems = [
    MenuItem(
      name: "Classic Burger",
      description:
          "Burger Patty, Cheese, Lettuce, Tomato and Onion,mustard, and mayonnaise",
      price: "160 L.E",
      imageUrl: "assets/burger_placeholder.png",
    ),
    MenuItem(
      name: "Classic Burger",
      description:
          "Burger Patty, Cheese, Lettuce, Tomato and Onion,mustard, and mayonnaise.",
      price: "160 L.E",
      imageUrl: "assets/burger_placeholder.png",
    ),
    MenuItem(
      name: "Classic Burger",
      description:
          "Burger Patty, Cheese, Lettuce, Tomato and Onion,mustard, and mayonnaise",
      price: "160 L.E",
      imageUrl: "assets/burger_placeholder.png",
    ),
  ];
  static final List<Map<String, dynamic>> burgerItems = [
    {
      'name': 'Classic Burger',
      'description': 'Burger Patty, Cheese, Lettuce, Tomato and Onion.',
      'price': 160,
      'rating': 5.0,
      'image': 'assets/images/burger_placeholder.png',
    },
    {
      'name': 'Classic Burger',
      'description': 'Burger Patty, Cheese, Lettuce, Tomato and Onion.',
      'price': 200,
      'rating': 4.7,
      'image': 'assets/images/burger_placeholder.png',
    },
    {
      'name': 'Classic Burger',
      'description': 'Burger Patty, Cheese, Lettuce, Tomato and Onion.',
      'price': 250,
      'rating': 4.5,
      'image': 'assets/images/burger_placeholder.png',
    },
    {
      'name': 'Classic Burger',
      'description': 'Burger Patty, Cheese, Lettuce, Tomato and Onion.',
      'price': 300,
      'rating': 4.3,
      'image': 'assets/images/burger_placeholder.png',
    },
  ];
  static List<Address> addresses = [
    Address(
      title: "My Flat 1",
      details: "Qena, Nag Hammadi, Alulminum Blocks\nHouse No12",
      isDefault: true,
    ),
    Address(
      title: "My Flat 2",
      details: "Qena, Nag Hammadi, Alulminum Blocks\nHouse No12",
      isDefault: false,
    ),
  ];
  static List<String> daysOfWeek = ['SU', 'MO', 'TU', 'WE', 'TH', 'FR', 'SA'];
  List<Map<String, dynamic>> sortedItems = List.from(AppLists.burgerItems);
  static List<String> orderStatusList = [
    "Preparing",
    "Ready for pickup",
    "Out of delivery",
    "Completed",
  ];
  static String selectedStatus = "Preparing";

  static List categoriesType = [
    "Italian",
    "American",
    "Egyptian",
    "Indian",
    "Fast food",
    "Chinesss food",
  ];
  static List<RestaurantAdmin> restaurantsAdmin = [
    RestaurantAdmin(
      name: "Eldekka Restaurant",
      cuisine: "Italian Cuisine",
      rating: 3.9,
      description: "street restaurants-styles tacos with a variety of fillings",
    ),
    RestaurantAdmin(
      name: "Eldekka Restaurant",
      cuisine: "Italian Cuisine",
      rating: 3.9,
      description: "street restaurants-styles tacos with a variety of fillings",
    ),
    RestaurantAdmin(
      name: "Eldekka Restaurant",
      cuisine: "Italian Cuisine",
      rating: 3.9,
      description: "street restaurants-styles tacos with a variety of fillings",
    ),
  ];

  static List<String> resturantCategories = [
    "Italian Food",
    "Egyptian Food",
    "Chiness Food",
    "Indian Food",
  ];

  static List<UsersModel> usersList = [
    UsersModel(
      name: "Aya Muhammed Khamis",
      email: "ayakhamis720@gmail.com",
      orderNum: "No of Orders:17",
      moneySpent: "Money Spent : 5200 L.E",
      phoneNum: "01026679996",
    ),
  ];

  static List<UsersModel> usersListFilter = [
    UsersModel(
      name: "Aya Muhammed Khamis",
      email: "ayakhamis720@gmail.com",
      orderNum: "No of Orders:32",
      moneySpent: "Money Spent : 5200 L.E",
      phoneNum: "01026679996",
    ),
    UsersModel(
      name: "Soha Muhammed Khamis",
      email: "Sohakhamis720@gmail.com",
      orderNum: "No of Orders:25",
      moneySpent: "Money Spent : 5200 L.E",
      phoneNum: "01026679996",
    ),
    UsersModel(
      name: "Reem Muhammed Khamis",
      email: "Reemkhamis720@gmail.com",
      orderNum: "No of Orders: 18",
      moneySpent: "Money Spent : 5200 L.E",
      phoneNum: "01026679996",
    ),
    UsersModel(
      name: "Gana Muhammed Khamis",
      email: "Ganakhamis720@gmail.com",
      orderNum: "No of Orders:10",
      moneySpent: "Money Spent : 5200 L.E",
      phoneNum: "01026679996",
    ),
  ];

  static List<String> orderStatusListCoupone = [
    "Quick Food ",
    "ELDekka",
    "YFC Restaurant",
    "Al Elbeet",
    "Completed",
  ];
  static List<Coupon> coupons = [
    Coupon(
      id: '1',
      code: 'SUMMER20',
      expiredDate: DateTime(2024, 7, 3),
      value: 20,
      discountType: 'bill',
      applicableRestaurants: ['Quick food', 'Pasta Paradise', 'Sushi Spot'],
      isActive: false,
      usagePerUserLimit: 1,
      minimumOrderValue: 0,
      couponType: 'seasonal',
      description: 'Summer sale',
      usersUsed: [],
    ),
    Coupon(
      id: '2',
      code: 'welcome10',
      expiredDate: DateTime(2025, 8, 31),
      value: 10,
      discountType: 'bill',
      applicableRestaurants: ['The Grill House', 'Pasta Paradise', 'Sushi Spot'],
      isActive: true,
      usagePerUserLimit: 1,
      minimumOrderValue: 0,
      couponType: 'promotional',
      description: 'Welcome offer',
      usersUsed: [],
    ),
    Coupon(
      id: '3',
      code: 'WEEKEND25',
      expiredDate: DateTime(2025, 8, 31),
      value: 25,
      discountType: 'delivery',
      applicableRestaurants: ['The Grill House', 'Pasta Paradise', 'ELDEKKA'],
      isActive: true,
      usagePerUserLimit: 1,
      minimumOrderValue: 500,
      couponType: 'seasonal',
      description: 'Weekend special',
      usersUsed: [],
    ),
  ];

  static String orderStatusListCouponeStatus = "Quick Food";

  static List<Agent> agents = [
    Agent(
      name: "Aser Mohammed Khamis",
      phoneNumber: "01026679996",
      userName: "Admin",
      password: "123456789#FM",
    ),
    Agent(
      name: "Ali Mohammed Khamis",
      phoneNumber: "01026679996",
      userName: "Admin",
      password: "123456789#FM",
    ),
    Agent(
      name: "Taha Mohammed Khamis",
      phoneNumber: "01026679996",
      userName: "Admin",
      password: "123456789#FM",
    ),
    Agent(
      name: "Amr Mohammed Khamis",
      phoneNumber: "01026679996",
      userName: "Admin",
      password: "123456789#FM",
    ),
    Agent(
      name: "Zein Mohammed Khamis",
      phoneNumber: "01026679996",
      userName: "Admin",
      password: "123456789#FM",
    ),
  ];

  static String selectedOrderStatusAgent = "Pick up";

  static List<String> agentdeliveryList = [
    "Pick up",
    "On the way",
    "Delivered",
  ];
}
