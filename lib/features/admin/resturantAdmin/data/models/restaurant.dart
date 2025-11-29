class RestaurantAdmin {
  final String name;
  final String cuisine;
  final double rating;
  final String description;
  final bool isDataShowing;

  RestaurantAdmin({
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.description,
    this.isDataShowing = true,
  });
}

