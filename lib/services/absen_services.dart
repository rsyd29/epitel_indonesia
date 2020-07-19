// part of 'services.dart';

// class AbsenServices {
//   FirebaseUser absen;

//   static CollectionReference absenCollection =
//       Firestore.instance.collection('absens');

//   static Future<void> saveAbsen(String uid, Absen absen) async {
//     await absenCollection.document(absen.aid).setData({
//       'aid': absen.aid ?? "",
//       'uid': uid ?? "",
//       'location': absen.location ?? "",
//       'account': absen.user.name ?? "",
//       'checkIn': absen.checkIn.millisecondsSinceEpoch ??
//           DateTime.now().millisecondsSinceEpoch,
//       'checkOut': absen.checkOut.millisecondsSinceEpoch ?? "",
//       'lat': absen.lat,
//       'long': absen.long,
//     });
//   }

//   static Future<List<Absen>> getAbsens(String uid) async {
//     QuerySnapshot snapshot = await absenCollection.getDocuments();
//     var documents =
//         snapshot.documents.where((document) => document.data['uid'] == uid);

//     List<Absen> absens = [];
//     for (var document in documents) {
//       User user = await UserServices.getUser(uid);
//       absens.add(Absen(
//         document.data['aid'],
//         user,
//         document.data['location'],
//         document.data['name'],
//         DateTime.fromMillisecondsSinceEpoch(document.data['checkIn']),
//         DateTime.fromMillisecondsSinceEpoch(document.data['checkOut']),
//         document.data['lat'],
//         document.data['long'],
//       ));
//     }
//     return absens;
//   }
// }
