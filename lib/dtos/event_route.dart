class EventRouteDTO{
  final int id;
  final String name;
  List<LocationDTO> locations = [];

  EventRouteDTO(this.id,this.name);

  EventRouteDTO.fromMap(Map<String, dynamic> map)
    : id = map["routeId"],
      name = map["routeName"]
  ;

}
class LocationDTO{
  final String name;
  final double latitude;
  final double longitude;
  final String address;
  final String description;
  final int stepNumber;

  LocationDTO(this.name,this.latitude,this.longitude,this.address,this.description,this.stepNumber);
  LocationDTO.fromMap(Map<String, dynamic> map)
    : name = map["name"],
      latitude = map["latitude"],
      longitude = map["longitude"],
      address = map["address"],
      description = map["description"], 
      stepNumber = map["stepNumber"]
  ;

}