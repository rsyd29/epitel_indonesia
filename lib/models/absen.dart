part of 'models.dart';

class Absen extends Equatable {
  final User user;
  final String location;
  final String name;
  final DateTime checkIn;
  final DateTime checkOut;
  final String lat;
  final String long;

  Absen(this.user, this.location, this.name, this.checkIn, this.checkOut,
      this.lat, this.long);

  Absen copyWith(
          {User user,
          String location,
          String name,
          String checkIn,
          String checkOut,
          String lat,
          String long}) =>
      Absen(
          user ?? this.user,
          location ?? this.location,
          name ?? this.name,
          checkIn ?? this.checkIn,
          checkOut ?? this.checkOut,
          lat ?? this.lat,
          long ?? this.long);

  @override
  List<Object> get props =>
      [user, location, name, checkIn, checkOut, lat, long];
}
