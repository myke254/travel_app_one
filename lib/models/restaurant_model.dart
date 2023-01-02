class Restaurant {
  final String? name;
  final String? address;
  final String? phone;
  final String? hours;
  final List<MenuItem>? menu;
  final List<String>? reviews;
  final double? rating;
  final String? cuisine;
  final String? priceRange;
  final List<String>? photos;

  Restaurant({
    this.name,
    this.address,
    this.phone,
    this.hours,
    this.menu,
    this.reviews,
    this.rating,
    this.cuisine,
    this.priceRange,
    this.photos,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    List<MenuItem> menu = [];
    for (var item in json['menu']) {
      menu.add(MenuItem.fromJson(item));
    }

    return Restaurant(
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      hours: json['hours'],
      menu: menu,
      reviews: List<String>.from(json['reviews']),
      rating: json['rating'],
      cuisine: json['cuisine'],
      priceRange: json['priceRange'],
      photos: List<String>.from(json['photos']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'phone': phone,
        'hours': hours,
        'menu': menu,
        'reviews': reviews,
        'rating': rating,
        'cuisine': cuisine,
        'priceRange': priceRange,
        'photos': photos,
      };
}

class MenuItem {
  final String? name;
  final double? price;
  final String? image;

  MenuItem({
    this.name,
    this.price,
    this.image,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'],
      price: json['price'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'image': image,
      };
}
