part of 'pages.dart';

class HomeUserPage extends StatefulWidget {
  @override
  _HomeUserPageState createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  bool isToday = false;
  bool isCheckOut = true;

  @override
  void initState() {
    super.initState();
  }

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
              return Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 14.0),
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
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Loading(
                                  color: mainColor,
                                  colorBg: Colors.transparent),
                              SizedBox(height: 5.0),
                              Text("Harap Bersabar",
                                  style:
                                      blackTextFont.copyWith(color: mainColor))
                            ],
                          );
                        } else {
                          final list = querySnapshot.data.documents;
                          return ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (_, index) {
                              String absenID = list[index]['aid'];
                              DateTime checkIn =
                                  list[index]['checkIn'].toDate();

                              DateTime checkOut =
                                  list[index]['checkOut'].toDate();

                              return GestureDetector(
                                onLongPress: () {
                                  showDialog(
                                    builder: (context) => AlertDialog(
                                      title: Text("Hapus Data Absen Ini"),
                                      content: Text(
                                          "Kamu yakin ingin menghapus data absen ini? Data tidak dapat kembali lagi nantinya"),
                                      actions: <Widget>[
                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          onTap: () {
                                            return Flushbar(
                                              duration: Duration(seconds: 3),
                                              flushbarPosition:
                                                  FlushbarPosition.BOTTOM,
                                              backgroundColor:
                                                  Color(0xFFFF5C83),
                                              message:
                                                  "Tekan yang lebih lama untuk menghapus data absen ini",
                                            )..show(context);
                                          },
                                          onLongPress: () {
                                            final Firestore firestore =
                                                Firestore.instance;

                                            DocumentReference documentTask =
                                                firestore.document(
                                                    'absens/$absenID');

                                            documentTask
                                                .delete()
                                                .then((value) =>
                                                    Navigator.of(context).pop())
                                                .then((value) => Flushbar(
                                                      duration:
                                                          Duration(seconds: 3),
                                                      flushbarPosition:
                                                          FlushbarPosition
                                                              .BOTTOM,
                                                      backgroundColor:
                                                          Color(0xFFFF5C83),
                                                      message:
                                                          "Data Absen Telah Berhasil Dihapus!",
                                                    )..show(context));
                                          },
                                          child: Text(
                                            'Benar',
                                            style: blackTextFont,
                                          ),
                                        ),
                                        FlatButton(
                                          color: Colors.red,
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text(
                                            'Batal',
                                            style: whiteTextFont.copyWith(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    context: context,
                                  );
                                  print(
                                      "masuk menggunakan absenID: " + absenID);

                                  // return Hapus();
                                },
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                    top: index == 0 ? 166 : 20,
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
                                                list[index]['name']
                                                    .toUpperCase(),
                                                style: yellowTextFont.copyWith(
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Row(
                                              children: [
                                                Icon(
                                                  MdiIcons.email,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(width: 5),
                                                Text(list[index]['email'],
                                                    style:
                                                        whiteTextFont.copyWith(
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
                                                Text(
                                                    list[index]['branch'] ??
                                                        "-",
                                                    style:
                                                        whiteTextFont.copyWith(
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
                                            0.0,
                                            16.0,
                                            5.0,
                                            16.0,
                                          ),
                                          color: Colors.white,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      MdiIcons.mapMarker,
                                                      color: Colors.green,
                                                      size: 50,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "${checkIn.dateNow}",
                                                            style: blackTextFont
                                                                .copyWith(
                                                                    fontSize:
                                                                        10,
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
                                                        Text(
                                                            "${checkIn.timeNow}",
                                                            style: blackTextFont
                                                                .copyWith(
                                                                    fontSize:
                                                                        10)),
                                                        Text(
                                                            list[index][
                                                                    'location_in'] ??
                                                                "-",
                                                            style: blackTextFont
                                                                .copyWith(
                                                                    fontSize:
                                                                        10)),
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
                                                            size: 50,
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
                                                                  style: blackTextFont.copyWith(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          10)),
                                                              Text(
                                                                  "${checkOut.timeNow}",
                                                                  style: blackTextFont
                                                                      .copyWith(
                                                                          fontSize:
                                                                              10)),
                                                              Text(
                                                                  list[index][
                                                                          'location_out'] ??
                                                                      "-",
                                                                  style: blackTextFont
                                                                      .copyWith(
                                                                          fontSize:
                                                                              10)),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    : StreamBuilder<
                                                            QuerySnapshot>(
                                                        stream: Firestore
                                                            .instance
                                                            .collection(
                                                                'branchs')
                                                            .where('status',
                                                                isEqualTo:
                                                                    'aktif')
                                                            .snapshots(),
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot<
                                                                    QuerySnapshot>
                                                                querySnapshot) {
                                                          return IconButton(
                                                              icon: Icon(
                                                                  MdiIcons
                                                                      .qrcode),
                                                              onPressed:
                                                                  () async {
                                                                final qrcode =
                                                                    await getScan();
                                                                final position =
                                                                    await getLocation();
                                                                final latitude =
                                                                    position
                                                                        .latitude
                                                                        .toStringAsFixed(
                                                                            3);
                                                                final longitude =
                                                                    position
                                                                        .longitude
                                                                        .toStringAsFixed(
                                                                            3);
                                                                final viewLat =
                                                                    position
                                                                        .latitude
                                                                        .toString();
                                                                final viewLong =
                                                                    position
                                                                        .longitude
                                                                        .toString();
                                                                final time =
                                                                    DateTime.now()
                                                                        .timeNow;
                                                                final date = DateTime
                                                                        .now()
                                                                    .dateScanNow;
                                                                bool isTrue =
                                                                    false;

                                                                final list =
                                                                    querySnapshot
                                                                        .data
                                                                        .documents;

                                                                void _onAbsenCheckOut(
                                                                    BuildContext
                                                                        context,
                                                                    String
                                                                        qrcode) {
                                                                  final Firestore
                                                                      firestore =
                                                                      Firestore
                                                                          .instance;

                                                                  DocumentReference
                                                                      documentTask =
                                                                      firestore
                                                                          .document(
                                                                              'absens/$absenID');
                                                                  firestore
                                                                      .runTransaction(
                                                                          (transaction) async {
                                                                    DocumentSnapshot
                                                                        task =
                                                                        await transaction
                                                                            .get(documentTask);
                                                                    if (task
                                                                        .exists) {
                                                                      await transaction
                                                                          .update(
                                                                        task.reference,
                                                                        {
                                                                          'status':
                                                                              'checkOut',
                                                                          'checkOut':
                                                                              DateTime.now(),
                                                                          'location_out':
                                                                              qrcode
                                                                        },
                                                                      );
                                                                    }
                                                                  });

                                                                  Navigator.pop(
                                                                      context);
                                                                }

                                                                list.forEach(
                                                                    (element) {
                                                                  String
                                                                      cabangSemua =
                                                                      element.data[
                                                                          'cabang'];
                                                                  String
                                                                      latSemua =
                                                                      element.data[
                                                                          'latitude'];
                                                                  String
                                                                      longSemua =
                                                                      element.data[
                                                                          'longitude'];

                                                                  if (qrcode ==
                                                                          cabangSemua &&
                                                                      latitude ==
                                                                          latSemua &&
                                                                      longitude ==
                                                                          longSemua) {
                                                                    setState(
                                                                        () {
                                                                      isTrue =
                                                                          !isTrue;
                                                                    });
                                                                  }
                                                                });

                                                                (isTrue)
                                                                    ? buildShowModalBottomSheetBerhasilKeluar(
                                                                        context,
                                                                        viewLat,
                                                                        latitude,
                                                                        viewLong,
                                                                        longitude,
                                                                        qrcode,
                                                                        date,
                                                                        time,
                                                                        userState,
                                                                        _onAbsenCheckOut)
                                                                    : buildShowModalBottomSheetGagalKeluar(
                                                                        context,
                                                                        viewLat,
                                                                        latitude,
                                                                        viewLong,
                                                                        longitude,
                                                                        qrcode,
                                                                        date,
                                                                        time,
                                                                        userState);
                                                              });
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
                ),
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
                                            GoToUserDetailPage(userState.user));
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

  Future<void> buildShowModalBottomSheetGagalKeluar(
      BuildContext context,
      String viewLat,
      String latitude,
      String viewLong,
      String longitude,
      String qrcode,
      String date,
      String time,
      UserLoaded userState) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheetScan(
            icon: MdiIcons.closeCircle,
            colorIc: Colors.red,
            result: "Upss!",
            text: "Silahkan kamu periksa kembali\nkode dan lokasimu!",
            viewLatitude: viewLat,
            latitude: latitude,
            viewLongitude: viewLong,
            longitude: longitude,
            location: "tidak diketahui",
            qrcode: qrcode,
            date: date,
            time: time,
            account: userState.user.name,
            buttonText: "Kembali",
            onPressed: () {
              Navigator.pop(context);
              return Flushbar(
                title:
                    "Data QR code atau titik koordinat tidak sesuai, silahkan scan kembali!",
                duration: Duration(seconds: 4),
                flushbarPosition: FlushbarPosition.BOTTOM,
                backgroundColor: Color(0xFFFF5C83),
                message:
                    "Data QR Code: $qrcode\nLatitude: $latitude\nLongitude: $longitude",
              )..show(context);
            },
          );
        });
  }

  Future<void> buildShowModalBottomSheetBerhasilKeluar(
      BuildContext context,
      String viewLat,
      String latitude,
      String viewLong,
      String longitude,
      String qrcode,
      String date,
      String time,
      UserLoaded userState,
      void _onAbsenCheckOut(BuildContext context, String qrcode)) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheetScan(
            icon: MdiIcons.briefcaseCheck,
            colorIc: Colors.red,
            result: "Berhasil Keluar",
            text: "Absen Keluar Telah Berhasil\nSelamat Istirahat",
            viewLatitude: viewLat,
            latitude: latitude,
            viewLongitude: viewLong,
            longitude: longitude,
            location: qrcode,
            qrcode: qrcode,
            date: date,
            time: time,
            account: userState.user.name,
            buttonText: "Selesai",
            onPressed: () {
              _onAbsenCheckOut(context, qrcode);
              return Flushbar(
                duration: Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.BOTTOM,
                backgroundColor: Color(0xFFFF5C83),
                message: "Anda telah berhasil keluar dari kantor $qrcode",
              )..show(context);
            },
          );
        });
  }
}
