

class Geo{
  final String lat;
  final String lng;
  Geo({required this.lat, required this.lng});
  factory Geo.fromJson(Map<String, dynamic> json){
    return Geo(
        lat: json['lat'],
      lng:json['lng']
    );
  }
}

class Address{
 final String street;
 final String city;
 final Geo geo;

 Address({required this.city, required this.street, required this.geo});
 factory Address.fromJson(Map<String, dynamic> json){
   return Address(
       city: json['city'],
       street: json['street'],
     geo: Geo.fromJson(json['geo'])
   );
 }


}


class Company{
  final String name;

  Company({required this.name});
  factory Company.fromJson(Map<String, dynamic> json){
    return Company(
       name: json['name']
    );
  }


}


class UserDetail{
  final int id;
  final String name;
  final String username;
  final Address address;
  final Company company;

  UserDetail({
    required this.company, required this.address,
    required this.name, required this.username, required this.id});

  factory UserDetail.fromJson(Map<String, dynamic> json){
    return UserDetail(
        company: Company.fromJson(json['company']),
        address: Address.fromJson(json['address']),
        name: json['name'],
        username: json['username'],
        id: json['id']
    );
  }

}
