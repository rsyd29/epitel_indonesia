part of 'pages.dart';

class HomeUserPage extends StatefulWidget {
  @override
  _HomeUserPageState createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  bool isToday = false;
  bool isCheckOut = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return Scaffold(
      body: Stack(
        children: [
          // NOTE: CONTENT
          BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
            if (userState is UserLoaded) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: StreamBuilder<QuerySnapshot>(
                    stream: (isToday)
                        ? Firestore.instance
                            .collection("absens")
                            .where("uid", isEqualTo: userState.user.uid)
                            .where("status", isEqualTo: "checkOut")
                            .snapshots()
                        : Firestore.instance
                            .collection("absens")
                            .where("uid", isEqualTo: userState.user.uid)
                            .where("status", isEqualTo: "checkIn")
                            .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> querySnapshot) {
                      if (querySnapshot.hasError) {
                        return Text('Something error');
                      }
                      if (querySnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Loading(
                            color: mainColor, colorBg: Colors.transparent);
                      } else {
                        final list = querySnapshot.data.documents;
                        return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (_, index) {
                            String absenID = list[index]['aid'];
                            DateTime checkIn = list[index]['checkIn'].toDate();

                            DateTime checkOut =
                                list[index]['checkOut'].toDate();

                            return GestureDetector(
                              onTap: () {
                                print("masuk menggunakan absenID: " + absenID);
                              },
                              child: Container(
                                color: Colors.white,
                                margin: EdgeInsets.only(
                                  top: index == 0 ? 166 : 20,
                                  // bottom: index != 0 ? 76 : 0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(10),
                                      color: Color(0xFF00AFF0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              list[index]['name'].toUpperCase(),
                                              style: yellowTextFont.copyWith(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            children: [
                                              Icon(
                                                MdiIcons.email,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 5),
                                              Text(list[index]['email'],
                                                  style: whiteTextFont.copyWith(
                                                    fontSize: 10,
                                                  )),
                                              SizedBox(width: 5),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(MdiIcons.mapMarker,
                                                  color: Colors.white),
                                              SizedBox(width: 5),
                                              Text(list[index]['location'],
                                                  style: whiteTextFont.copyWith(
                                                    fontSize: 10,
                                                  )),
                                              SizedBox(width: 5),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.fromLTRB(
                                          10.0,
                                          16.0,
                                          10.0,
                                          16.0,
                                        ),
                                        color: Colors.white,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    MdiIcons.mapMarker,
                                                    color: Colors.green,
                                                    size: 40,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("${checkIn.dateNow}",
                                                          style: blackTextFont
                                                              .copyWith(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      Text("Masuk",
                                                          style: blackTextFont
                                                              .copyWith(
                                                                  color: Colors
                                                                      .green,
                                                                  fontSize:
                                                                      10)),
                                                      Text("${checkIn.timeNow}",
                                                          style: blackTextFont
                                                              .copyWith(
                                                                  fontSize: 10))
                                                    ],
                                                  )
                                                ],
                                              ),
                                              (checkOut != checkIn)
                                                  ? Row(
                                                      children: [
                                                        Icon(
                                                          MdiIcons.mapMarker,
                                                          color: Colors.red,
                                                          size: 40,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                "${checkOut.dateNow}",
                                                                style: blackTextFont.copyWith(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            Text("Keluar",
                                                                style: blackTextFont
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            10)),
                                                            Text(
                                                                "${checkOut.timeNow}",
                                                                style: blackTextFont
                                                                    .copyWith(
                                                                        fontSize:
                                                                            10))
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  : IconButton(
                                                      icon:
                                                          Icon(MdiIcons.qrcode),
                                                      onPressed: () async {
                                                        if (PermissionStatus
                                                                .denied ==
                                                            null) {
                                                          return openLocationSettingsConfiguration();
                                                        } else {
                                                          String qrcode = '';
                                                          qrcode =
                                                              await getScan();
                                                          var position =
                                                              await getLocation();
                                                          String latitude =
                                                              position
                                                                  .latitude
                                                                  .toStringAsFixed(
                                                                      2);
                                                          String longitude =
                                                              position.longitude
                                                                  .toStringAsFixed(
                                                                      2);
                                                          String viewLat =
                                                              position.latitude
                                                                  .toString();
                                                          String viewLong =
                                                              position.longitude
                                                                  .toString();

                                                          var time =
                                                              DateTime.now()
                                                                  .timeNow;
                                                          var date =
                                                              DateTime.now()
                                                                  .dateNow;

                                                          if (qrcode ==
                                                                  "Setiabudi" &&
                                                              latitude ==
                                                                  "-6.22" &&
                                                              longitude ==
                                                                  "106.83") {
                                                            return showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return BottomSheetWidget(
                                                                    icon: MdiIcons
                                                                        .checkboxMarkedCircle,
                                                                    color: Colors
                                                                        .green,
                                                                    result:
                                                                        "Berhasil!",
                                                                    text:
                                                                        "Absen Keluar Telah Berhasil\nSelamat Istirahat",
                                                                    latitude:
                                                                        latitude,
                                                                    longitude:
                                                                        longitude,
                                                                    location:
                                                                        qrcode,
                                                                    qrcode:
                                                                        qrcode,
                                                                    date: date,
                                                                    time: time,
                                                                    account:
                                                                        userState
                                                                            .user
                                                                            .name,
                                                                    buttonText:
                                                                        "Selesai",
                                                                    onPressed:
                                                                        () async {
                                                                      final Firestore
                                                                          firestore =
                                                                          Firestore
                                                                              .instance;

                                                                      DocumentReference
                                                                          documentTask =
                                                                          firestore
                                                                              .document('absens/$absenID');
                                                                      firestore
                                                                          .runTransaction(
                                                                              (transaction) async {
                                                                        DocumentSnapshot
                                                                            task =
                                                                            await transaction.get(documentTask);
                                                                        if (task
                                                                            .exists) {
                                                                          await transaction
                                                                              .update(
                                                                            task.reference,
                                                                            {
                                                                              'status': 'checkOut',
                                                                              'checkOut': DateTime.now()
                                                                            },
                                                                          );
                                                                        }
                                                                      });
                                                                      context
                                                                          .bloc<
                                                                              PageBloc>()
                                                                          .add(
                                                                              GoToUserPage());
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  );
                                                                });
                                                          } else if (qrcode ==
                                                                  "Jatinegara" &&
                                                              latitude ==
                                                                  "-6.21" &&
                                                              longitude ==
                                                                  "106.86") {
                                                            return showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return BottomSheetWidget(
                                                                    icon: MdiIcons
                                                                        .checkboxMarkedCircle,
                                                                    color: Colors
                                                                        .green,
                                                                    result:
                                                                        "Berhasil!",
                                                                    text:
                                                                        "Absen Keluar Telah Berhasil\nSelamat Istirahat",
                                                                    latitude:
                                                                        latitude,
                                                                    longitude:
                                                                        longitude,
                                                                    location:
                                                                        qrcode,
                                                                    qrcode:
                                                                        qrcode,
                                                                    date: date,
                                                                    time: time,
                                                                    account:
                                                                        userState
                                                                            .user
                                                                            .name,
                                                                    buttonText:
                                                                        "Selesai",
                                                                    onPressed:
                                                                        () async {
                                                                      final Firestore
                                                                          firestore =
                                                                          Firestore
                                                                              .instance;

                                                                      DocumentReference
                                                                          documentTask =
                                                                          firestore
                                                                              .document('absens/$absenID');
                                                                      firestore
                                                                          .runTransaction(
                                                                              (transaction) async {
                                                                        DocumentSnapshot
                                                                            task =
                                                                            await transaction.get(documentTask);
                                                                        if (task
                                                                            .exists) {
                                                                          await transaction
                                                                              .update(
                                                                            task.reference,
                                                                            {
                                                                              'status': 'checkOut',
                                                                              'checkOut': DateTime.now()
                                                                            },
                                                                          );
                                                                        }
                                                                      });
                                                                      context
                                                                          .bloc<
                                                                              PageBloc>()
                                                                          .add(
                                                                              GoToUserPage());
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  );
                                                                });
                                                          } else if (qrcode ==
                                                                  "Antang Makassar" &&
                                                              latitude ==
                                                                  "-5.17" &&
                                                              longitude ==
                                                                  "119.48") {
                                                            return showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return BottomSheetWidget(
                                                                    icon: MdiIcons
                                                                        .checkboxMarkedCircle,
                                                                    color: Colors
                                                                        .green,
                                                                    result:
                                                                        "Berhasil!",
                                                                    text:
                                                                        "Absen Keluar Telah Berhasil\nSelamat Istirahat",
                                                                    latitude:
                                                                        latitude,
                                                                    longitude:
                                                                        longitude,
                                                                    location:
                                                                        qrcode,
                                                                    qrcode:
                                                                        qrcode,
                                                                    date: date,
                                                                    time: time,
                                                                    account:
                                                                        userState
                                                                            .user
                                                                            .name,
                                                                    buttonText:
                                                                        "Selesai",
                                                                    onPressed:
                                                                        () async {
                                                                      final Firestore
                                                                          firestore =
                                                                          Firestore
                                                                              .instance;

                                                                      DocumentReference
                                                                          documentTask =
                                                                          firestore
                                                                              .document('absens/$absenID');
                                                                      firestore
                                                                          .runTransaction(
                                                                              (transaction) async {
                                                                        DocumentSnapshot
                                                                            task =
                                                                            await transaction.get(documentTask);
                                                                        if (task
                                                                            .exists) {
                                                                          await transaction
                                                                              .update(
                                                                            task.reference,
                                                                            {
                                                                              'status': 'checkOut',
                                                                              'checkOut': DateTime.now()
                                                                            },
                                                                          );
                                                                        }
                                                                      });
                                                                      context
                                                                          .bloc<
                                                                              PageBloc>()
                                                                          .add(
                                                                              GoToUserPage());
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  );
                                                                });
                                                          } else if (qrcode ==
                                                                  "Kaliabang Bekasi" &&
                                                              latitude ==
                                                                  "-6.20" &&
                                                              longitude ==
                                                                  "107.00") {
                                                            return showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return BottomSheetWidget(
                                                                    icon: MdiIcons
                                                                        .checkboxMarkedCircle,
                                                                    color: Colors
                                                                        .green,
                                                                    result:
                                                                        "Berhasil!",
                                                                    text:
                                                                        "Absen Keluar Telah Berhasil\nSelamat Istirahat",
                                                                    latitude:
                                                                        latitude,
                                                                    longitude:
                                                                        longitude,
                                                                    location:
                                                                        qrcode,
                                                                    qrcode:
                                                                        qrcode,
                                                                    date: date,
                                                                    time: time,
                                                                    account:
                                                                        userState
                                                                            .user
                                                                            .name,
                                                                    buttonText:
                                                                        "Selesai",
                                                                    onPressed:
                                                                        () async {
                                                                      final Firestore
                                                                          firestore =
                                                                          Firestore
                                                                              .instance;

                                                                      DocumentReference
                                                                          documentTask =
                                                                          firestore
                                                                              .document('absens/$absenID');
                                                                      firestore
                                                                          .runTransaction(
                                                                              (transaction) async {
                                                                        DocumentSnapshot
                                                                            task =
                                                                            await transaction.get(documentTask);
                                                                        if (task
                                                                            .exists) {
                                                                          await transaction
                                                                              .update(
                                                                            task.reference,
                                                                            {
                                                                              'status': 'checkOut',
                                                                              'checkOut': DateTime.now()
                                                                            },
                                                                          );
                                                                        }
                                                                      });
                                                                      context
                                                                          .bloc<
                                                                              PageBloc>()
                                                                          .add(
                                                                              GoToUserPage());
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  );
                                                                });
                                                          } else if (qrcode ==
                                                                  "Kodau Bekasi" &&
                                                              latitude ==
                                                                  "-6.29" &&
                                                              longitude ==
                                                                  "106.94") {
                                                            return showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return BottomSheetWidget(
                                                                    icon: MdiIcons
                                                                        .checkboxMarkedCircle,
                                                                    color: Colors
                                                                        .green,
                                                                    result:
                                                                        "Berhasil!",
                                                                    text:
                                                                        "Absen Keluar Telah Berhasil\nSelamat Istirahat",
                                                                    latitude:
                                                                        latitude,
                                                                    longitude:
                                                                        longitude,
                                                                    location:
                                                                        qrcode,
                                                                    qrcode:
                                                                        qrcode,
                                                                    date: date,
                                                                    time: time,
                                                                    account:
                                                                        userState
                                                                            .user
                                                                            .name,
                                                                    buttonText:
                                                                        "Selesai",
                                                                    onPressed:
                                                                        () async {
                                                                      final Firestore
                                                                          firestore =
                                                                          Firestore
                                                                              .instance;

                                                                      DocumentReference
                                                                          documentTask =
                                                                          firestore
                                                                              .document('absens/$absenID');
                                                                      firestore
                                                                          .runTransaction(
                                                                              (transaction) async {
                                                                        DocumentSnapshot
                                                                            task =
                                                                            await transaction.get(documentTask);
                                                                        if (task
                                                                            .exists) {
                                                                          await transaction
                                                                              .update(
                                                                            task.reference,
                                                                            {
                                                                              'status': 'checkOut',
                                                                              'checkOut': DateTime.now()
                                                                            },
                                                                          );
                                                                        }
                                                                      });
                                                                      context
                                                                          .bloc<
                                                                              PageBloc>()
                                                                          .add(
                                                                              GoToUserPage());
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  );
                                                                });
                                                          } else if (qrcode ==
                                                                  "Bekasi Timur" &&
                                                              latitude ==
                                                                  "-6.23" &&
                                                              longitude ==
                                                                  "107.01") {
                                                            return showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return BottomSheetWidget(
                                                                    icon: MdiIcons
                                                                        .checkboxMarkedCircle,
                                                                    color: Colors
                                                                        .green,
                                                                    result:
                                                                        "Berhasil!",
                                                                    text:
                                                                        "Absen Keluar Telah Berhasil\nSelamat Istirahat",
                                                                    latitude:
                                                                        latitude,
                                                                    longitude:
                                                                        longitude,
                                                                    location:
                                                                        qrcode,
                                                                    qrcode:
                                                                        qrcode,
                                                                    date: date,
                                                                    time: time,
                                                                    account:
                                                                        userState
                                                                            .user
                                                                            .name,
                                                                    buttonText:
                                                                        "Selesai",
                                                                    onPressed:
                                                                        () async {
                                                                      final Firestore
                                                                          firestore =
                                                                          Firestore
                                                                              .instance;

                                                                      DocumentReference
                                                                          documentTask =
                                                                          firestore
                                                                              .document('absens/$absenID');
                                                                      firestore
                                                                          .runTransaction(
                                                                              (transaction) async {
                                                                        DocumentSnapshot
                                                                            task =
                                                                            await transaction.get(documentTask);
                                                                        if (task
                                                                            .exists) {
                                                                          await transaction
                                                                              .update(
                                                                            task.reference,
                                                                            {
                                                                              'status': 'checkOut',
                                                                              'checkOut': DateTime.now()
                                                                            },
                                                                          );
                                                                        }
                                                                      });
                                                                      context
                                                                          .bloc<
                                                                              PageBloc>()
                                                                          .add(
                                                                              GoToUserPage());
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  );
                                                                });
                                                          } else if (qrcode ==
                                                                  "Cikampek" &&
                                                              latitude ==
                                                                  "-6.40" &&
                                                              longitude ==
                                                                  "107.44") {
                                                            return showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return BottomSheetWidget(
                                                                    icon: MdiIcons
                                                                        .checkboxMarkedCircle,
                                                                    color: Colors
                                                                        .green,
                                                                    result:
                                                                        "Berhasil!",
                                                                    text:
                                                                        "Absen Keluar Telah Berhasil\nSelamat Istirahat",
                                                                    latitude:
                                                                        latitude,
                                                                    longitude:
                                                                        longitude,
                                                                    location:
                                                                        qrcode,
                                                                    qrcode:
                                                                        qrcode,
                                                                    date: date,
                                                                    time: time,
                                                                    account:
                                                                        userState
                                                                            .user
                                                                            .name,
                                                                    buttonText:
                                                                        "Selesai",
                                                                    onPressed:
                                                                        () async {
                                                                      final Firestore
                                                                          firestore =
                                                                          Firestore
                                                                              .instance;

                                                                      DocumentReference
                                                                          documentTask =
                                                                          firestore
                                                                              .document('absens/$absenID');
                                                                      firestore
                                                                          .runTransaction(
                                                                              (transaction) async {
                                                                        DocumentSnapshot
                                                                            task =
                                                                            await transaction.get(documentTask);
                                                                        if (task
                                                                            .exists) {
                                                                          await transaction
                                                                              .update(
                                                                            task.reference,
                                                                            {
                                                                              'status': 'checkOut',
                                                                              'checkOut': DateTime.now()
                                                                            },
                                                                          );
                                                                        }
                                                                      });
                                                                      context
                                                                          .bloc<
                                                                              PageBloc>()
                                                                          .add(
                                                                              GoToUserPage());
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  );
                                                                });
                                                          } else if (qrcode ==
                                                                  "Pettarani Makassar" &&
                                                              latitude ==
                                                                  "-5.16" &&
                                                              longitude ==
                                                                  "119.44") {
                                                            return showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return BottomSheetWidget(
                                                                    icon: MdiIcons
                                                                        .checkboxMarkedCircle,
                                                                    color: Colors
                                                                        .green,
                                                                    result:
                                                                        "Berhasil!",
                                                                    text:
                                                                        "Absen Keluar Telah Berhasil\nSelamat Istirahat",
                                                                    latitude:
                                                                        latitude,
                                                                    longitude:
                                                                        longitude,
                                                                    location:
                                                                        qrcode,
                                                                    qrcode:
                                                                        qrcode,
                                                                    date: date,
                                                                    time: time,
                                                                    account:
                                                                        userState
                                                                            .user
                                                                            .name,
                                                                    buttonText:
                                                                        "Selesai",
                                                                    onPressed:
                                                                        () async {
                                                                      final Firestore
                                                                          firestore =
                                                                          Firestore
                                                                              .instance;

                                                                      DocumentReference
                                                                          documentTask =
                                                                          firestore
                                                                              .document('absens/$absenID');
                                                                      firestore
                                                                          .runTransaction(
                                                                              (transaction) async {
                                                                        DocumentSnapshot
                                                                            task =
                                                                            await transaction.get(documentTask);
                                                                        if (task
                                                                            .exists) {
                                                                          await transaction
                                                                              .update(
                                                                            task.reference,
                                                                            {
                                                                              'status': 'checkOut',
                                                                              'checkOut': DateTime.now()
                                                                            },
                                                                          );
                                                                        }
                                                                      });
                                                                      context
                                                                          .bloc<
                                                                              PageBloc>()
                                                                          .add(
                                                                              GoToUserPage());
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  );
                                                                });
                                                          } else if (qrcode ==
                                                                  "Cibitung" &&
                                                              latitude ==
                                                                  "-6.26" &&
                                                              longitude ==
                                                                  "107.08") {
                                                            return showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return BottomSheetWidget(
                                                                    icon: MdiIcons
                                                                        .checkboxMarkedCircle,
                                                                    color: Colors
                                                                        .green,
                                                                    result:
                                                                        "Berhasil!",
                                                                    text:
                                                                        "Absen Keluar Telah Berhasil\nSelamat Istirahat",
                                                                    latitude:
                                                                        latitude,
                                                                    longitude:
                                                                        longitude,
                                                                    location:
                                                                        qrcode,
                                                                    qrcode:
                                                                        qrcode,
                                                                    date: date,
                                                                    time: time,
                                                                    account:
                                                                        userState
                                                                            .user
                                                                            .name,
                                                                    buttonText:
                                                                        "Selesai",
                                                                    onPressed:
                                                                        () async {
                                                                      final Firestore
                                                                          firestore =
                                                                          Firestore
                                                                              .instance;

                                                                      DocumentReference
                                                                          documentTask =
                                                                          firestore
                                                                              .document('absens/$absenID');
                                                                      firestore
                                                                          .runTransaction(
                                                                              (transaction) async {
                                                                        DocumentSnapshot
                                                                            task =
                                                                            await transaction.get(documentTask);
                                                                        if (task
                                                                            .exists) {
                                                                          await transaction
                                                                              .update(
                                                                            task.reference,
                                                                            {
                                                                              'status': 'checkOut',
                                                                              'checkOut': DateTime.now()
                                                                            },
                                                                          );
                                                                        }
                                                                      });
                                                                      context
                                                                          .bloc<
                                                                              PageBloc>()
                                                                          .add(
                                                                              GoToUserPage());
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  );
                                                                });
                                                          } else if (qrcode ==
                                                                  "Kosambi Karawang" &&
                                                              latitude ==
                                                                  "-6.37" &&
                                                              longitude ==
                                                                  "107.38") {
                                                            return showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return BottomSheetWidget(
                                                                    icon: MdiIcons
                                                                        .checkboxMarkedCircle,
                                                                    color: Colors
                                                                        .green,
                                                                    result:
                                                                        "Berhasil!",
                                                                    text:
                                                                        "Absen Keluar Telah Berhasil\nSelamat Istirahat",
                                                                    latitude:
                                                                        latitude,
                                                                    longitude:
                                                                        longitude,
                                                                    location:
                                                                        qrcode,
                                                                    qrcode:
                                                                        qrcode,
                                                                    date: date,
                                                                    time: time,
                                                                    account:
                                                                        userState
                                                                            .user
                                                                            .name,
                                                                    buttonText:
                                                                        "Selesai",
                                                                    onPressed:
                                                                        () async {
                                                                      final Firestore
                                                                          firestore =
                                                                          Firestore
                                                                              .instance;

                                                                      DocumentReference
                                                                          documentTask =
                                                                          firestore
                                                                              .document('absens/$absenID');
                                                                      firestore
                                                                          .runTransaction(
                                                                              (transaction) async {
                                                                        DocumentSnapshot
                                                                            task =
                                                                            await transaction.get(documentTask);
                                                                        if (task
                                                                            .exists) {
                                                                          await transaction
                                                                              .update(
                                                                            task.reference,
                                                                            {
                                                                              'status': 'checkOut',
                                                                              'checkOut': DateTime.now()
                                                                            },
                                                                          );
                                                                        }
                                                                      });
                                                                      context
                                                                          .bloc<
                                                                              PageBloc>()
                                                                          .add(
                                                                              GoToUserPage());
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  );
                                                                });
                                                          } else if (qrcode ==
                                                                  "Manado" &&
                                                              latitude ==
                                                                  "1.49" &&
                                                              longitude ==
                                                                  "124.84") {
                                                            return showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return BottomSheetWidget(
                                                                    icon: MdiIcons
                                                                        .checkboxMarkedCircle,
                                                                    color: Colors
                                                                        .green,
                                                                    result:
                                                                        "Berhasil!",
                                                                    text:
                                                                        "Absen Keluar Telah Berhasil\nSelamat Istirahat",
                                                                    latitude:
                                                                        latitude,
                                                                    longitude:
                                                                        longitude,
                                                                    location:
                                                                        qrcode,
                                                                    qrcode:
                                                                        qrcode,
                                                                    date: date,
                                                                    time: time,
                                                                    account:
                                                                        userState
                                                                            .user
                                                                            .name,
                                                                    buttonText:
                                                                        "Selesai",
                                                                    onPressed:
                                                                        () async {
                                                                      final Firestore
                                                                          firestore =
                                                                          Firestore
                                                                              .instance;

                                                                      DocumentReference
                                                                          documentTask =
                                                                          firestore
                                                                              .document('absens/$absenID');
                                                                      firestore
                                                                          .runTransaction(
                                                                              (transaction) async {
                                                                        DocumentSnapshot
                                                                            task =
                                                                            await transaction.get(documentTask);
                                                                        if (task
                                                                            .exists) {
                                                                          await transaction
                                                                              .update(
                                                                            task.reference,
                                                                            {
                                                                              'status': 'checkOut',
                                                                              'checkOut': DateTime.now()
                                                                            },
                                                                          );
                                                                        }
                                                                      });
                                                                      context
                                                                          .bloc<
                                                                              PageBloc>()
                                                                          .add(
                                                                              GoToUserPage());
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  );
                                                                });
                                                          } else if (qrcode ==
                                                                  "Karawang" &&
                                                              latitude ==
                                                                  "-6.30" &&
                                                              longitude ==
                                                                  "107.29") {
                                                            return showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return BottomSheetWidget(
                                                                    icon: MdiIcons
                                                                        .checkboxMarkedCircle,
                                                                    color: Colors
                                                                        .green,
                                                                    result:
                                                                        "Berhasil!",
                                                                    text:
                                                                        "Absen Keluar Telah Berhasil\nSelamat Istirahat",
                                                                    latitude:
                                                                        latitude,
                                                                    longitude:
                                                                        longitude,
                                                                    location:
                                                                        qrcode,
                                                                    qrcode:
                                                                        qrcode,
                                                                    date: date,
                                                                    time: time,
                                                                    account:
                                                                        userState
                                                                            .user
                                                                            .name,
                                                                    buttonText:
                                                                        "Selesai",
                                                                    onPressed:
                                                                        () async {
                                                                      final Firestore
                                                                          firestore =
                                                                          Firestore
                                                                              .instance;

                                                                      DocumentReference
                                                                          documentTask =
                                                                          firestore
                                                                              .document('absens/$absenID');
                                                                      firestore
                                                                          .runTransaction(
                                                                              (transaction) async {
                                                                        DocumentSnapshot
                                                                            task =
                                                                            await transaction.get(documentTask);
                                                                        if (task
                                                                            .exists) {
                                                                          await transaction
                                                                              .update(
                                                                            task.reference,
                                                                            {
                                                                              'status': 'checkOut',
                                                                              'checkOut': DateTime.now()
                                                                            },
                                                                          );
                                                                        }
                                                                      });
                                                                      context
                                                                          .bloc<
                                                                              PageBloc>()
                                                                          .add(
                                                                              GoToUserPage());
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  );
                                                                });
                                                          } else {
                                                            return showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return BottomSheetWidget(
                                                                    icon: MdiIcons
                                                                        .closeCircle,
                                                                    color: Colors
                                                                        .red,
                                                                    result:
                                                                        "Upss!",
                                                                    text:
                                                                        "Silahkan kamu periksa kembali\nkode dan lokasimu!",
                                                                    latitude:
                                                                        latitude,
                                                                    longitude:
                                                                        longitude,
                                                                    location:
                                                                        "tidak diketahui",
                                                                    qrcode:
                                                                        qrcode,
                                                                    date: date,
                                                                    time: time,
                                                                    account:
                                                                        userState
                                                                            .user
                                                                            .name,
                                                                    buttonText:
                                                                        "Kembali",
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  );
                                                                });
                                                          }
                                                        }
                                                      }),
                                            ])),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }),
                padding: EdgeInsets.only(bottom: 76),
              );
            } else {
              return Loading();
            }
          }),

          // NOTE: HEADER
          Container(
            height: 155,
            color: accentColor3,
          ),
          BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
            if (userState is UserLoaded) {
              return SafeArea(
                child: ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                      height: 150,
                      color: accentColor3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 24.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 13,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: (userState.user.role ==
                                                      "admin")
                                                  ? AssetImage(
                                                      "assets/bandage_admin.png")
                                                  : AssetImage(
                                                      "assets/bandage_user.png"))),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.bloc<PageBloc>().add(
                                            GoToEditProfilePage(
                                                userState.user));
                                        print(userState.user.uid);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Color(0xFF64B5F6),
                                                width: 1)),
                                        child: Stack(
                                          children: [
                                            Loading(
                                                colorBg: Colors.transparent,
                                                color: accentColor1),
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: (userState.user
                                                                  .profilePicture ==
                                                              ""
                                                          ? AssetImage(
                                                              "assets/edit_profile.png")
                                                          : NetworkImage(userState
                                                              .user
                                                              .profilePicture)),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          size.width - 2 * defaultMargin - 78,
                                      child: Text(
                                        userState.user.name,
                                        style: whiteTextFont.copyWith(
                                            fontSize: 18),
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    Text(
                                      userState.user.email,
                                      style: yellowTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Row(children: [
                              Column(children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isToday = !isToday;
                                    });
                                  },
                                  child: Text(
                                    "Hari Ini",
                                    style: whiteTextFont.copyWith(
                                        fontSize: 16,
                                        color: !isToday
                                            ? Colors.white
                                            : Color(0xFF007CDB)),
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                Container(
                                    height: 4.0,
                                    width: size.width * 0.5,
                                    color: !isToday
                                        ? accentColor1
                                        : Colors.transparent),
                              ]),
                              Column(children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isToday = !isToday;
                                    });
                                  },
                                  child: Text(
                                    "Kemarin",
                                    style: whiteTextFont.copyWith(
                                        fontSize: 16,
                                        color: isToday
                                            ? Colors.white
                                            : Color(0xFF007CDB)),
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                Container(
                                    height: 4.0,
                                    width: size.width * 0.5,
                                    color: isToday
                                        ? accentColor1
                                        : Colors.transparent),
                              ]),
                            ]),
                          )
                        ],
                      )),
                ),
              );
            } else {
              return Loading();
            }
          }),
        ],
      ),
    );
  }
}
