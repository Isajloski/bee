class LocationModel {
  String name;
  String time;
  String date;
  String id;
  String location;

  LocationModel({required this.name, required this.time, required this.date, required this.id, required this.location});

  factory LocationModel.fromMap(Map<String, dynamic> data) {
    return LocationModel(
      name:     data['name'] ?? '',
      time:     data['time'] ?? '',
      date:     data['date'] ?? '',
      id:       data['user_id'] ?? '',
      location: data['location'] ?? '',
    );
  }
}
