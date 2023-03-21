class Product{

  final dynamic id;
  final String image;
  final String name;
  final String brand;
  final String rate;
  // int favorito = 0;

  Product({required this.image, required this.name, required this.brand, required this.rate, favorito,  this.id});

  factory Product.fromMap(Map<String, dynamic>json) => Product(
    
    id: json["id"],
    image: json["image"], 
    name: json["name"], 
    brand: json["brand"], 
    rate: "${json["rate"]}", 
    // favorito: json["favorito"]
  );

  Map<String, dynamic> toMap(){
    return{
      "id":id,
      "image": image,
      "name": name,
      "brand": brand,
      "rate":rate,
      // "favorito": favorito,
    };
  }
}