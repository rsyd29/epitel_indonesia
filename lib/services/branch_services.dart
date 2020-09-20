part of 'services.dart';

class BranchServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection('branchs');

  static Future<void> updateUser(Branch branch) async {
    await _userCollection.document(branch.bid).setData({
      'bid': branch.bid,
      'cabang': branch.cabang,
      'latitude': branch.latitude,
      'longitude': branch.longitude,
      'kota': branch.kota,
      'qrcode': branch.qrcode,
      'status': branch.status,
    });
    return UpdateBranchData(branch: branch);
  }

  static Future<Branch> getBranch(String bid) async {
    DocumentSnapshot snapshot = await _userCollection.document(bid).get();

    return Branch(
      snapshot.data['bid'],
      cabang: snapshot.data['cabang'],
      latitude: snapshot.data['latitude'],
      longitude: snapshot.data['longitude'],
      kota: snapshot.data['kota'],
      qrcode: snapshot.data['qrcode'],
      status: snapshot.data['status'],
    );
  }
}

class UpdateBranchData {
  final Branch branch;
  final Branch bid;

  UpdateBranchData({this.branch, this.bid});
}
