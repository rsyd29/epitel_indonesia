part of 'models.dart';

class Branch extends Equatable {
  final String bid;
  final String cabang;
  final String latitude;
  final String longitude;
  final String kota;
  final String qrcode;
  final String status;

  Branch(
    this.bid, {
    this.cabang,
    this.latitude,
    this.longitude,
    this.kota,
    this.qrcode,
    this.status,
  });

  Branch copyWith({
    String bid,
    String cabang,
    String latitude,
    String longitude,
    String kota,
    String qrcode,
    String status,
  }) =>
      Branch(this.bid,
          cabang: cabang ?? this.cabang,
          latitude: latitude ?? this.latitude,
          longitude: longitude ?? this.longitude,
          kota: kota ?? this.kota,
          qrcode: qrcode ?? this.qrcode,
          status: status ?? this.status);

  @override
  String toString() {
    return "[$bid] - $cabang, $kota";
  }

  @override
  List<Object> get props => [
        bid,
        cabang,
        latitude,
        longitude,
        kota,
        qrcode,
        status,
      ];
}
