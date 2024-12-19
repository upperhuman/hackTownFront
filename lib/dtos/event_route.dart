class EventRouteDTO{
  final int id;
  final String name;
  late String IFrameLink;

  EventRouteDTO(this.id,this.name);

  EventRouteDTO.fromMap(Map<String, dynamic> map)
    : id = map["routeId"],
      name = map["routeName"]
  ;

}
