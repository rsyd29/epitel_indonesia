part of 'pages.dart';

class HomeAdminPage extends StatefulWidget {
  @override
  _HomeAdminPageState createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  bool isToday = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
      if (userState is UserLoaded) {
        return Scaffold(
          body: Stack(
            children: [
              // NOTE: CONTENT
              BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) {
                  if (userState is UserLoaded) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 14.0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: (isToday)
                            ? Firestore.instance
                                .collection("absens")
                                // .where("status", isEqualTo: "checkOut")
                                .orderBy("checkOut", descending: true)
                                .snapshots()
                            : Firestore.instance
                                .collection("absens")
                                .where("status", isEqualTo: "checkIn")
                                // .orderBy("checkIn", descending: true)
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
                                DateTime checkIn =
                                    list[index]['checkIn'].toDate();

                                DateTime checkOut =
                                    list[index]['checkOut'].toDate();

                                return GestureDetector(
                                  onTap: () {
                                    print("masuk menggunakan absenID: " +
                                        absenID);
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    margin: EdgeInsets.only(
                                      top: index == 0 ? 216 : 20,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                  style:
                                                      yellowTextFont.copyWith(
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
                                                      style: whiteTextFont
                                                          .copyWith(
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
                                                      style: whiteTextFont
                                                          .copyWith(
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
                                                MainAxisAlignment.spaceBetween,
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
                                                  : Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                      child: Text(
                                                          'Belum CheckOut',
                                                          style:
                                                              whiteTextFont)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                      padding: EdgeInsets.only(bottom: 76),
                    );
                  } else {
                    return Loading();
                  }
                },
              ),
              // NOTE: Hapus Semua Data Absen
              Container(
                margin: EdgeInsets.only(top: 190.0, left: 14.0, right: 14.0),
                child: ReusableButton(
                  icons: MdiIcons.trashCan,
                  width: double.infinity,
                  onPressed: () {
                    showDialog(
                      builder: (context) => AlertDialog(
                        title: Text("Hapus Semua Data Absen Karyawan"),
                        content: Text(
                            "Kamu yakin ingin menghapus semua data absen karyawan?"),
                        actions: <Widget>[
                          InkWell(
                            borderRadius: BorderRadius.circular(3),
                            onLongPress: () {
                              print("Semua Data Absen Telah Berhasil Dihapus!");
                              final Firestore firestore = Firestore.instance;

                              firestore
                                  .collection("absens")
                                  .getDocuments()
                                  .then((snapshot) {
                                    for (DocumentSnapshot ds
                                        in snapshot.documents) {
                                      ds.reference.delete();
                                    }
                                  })
                                  .then((value) => Navigator.of(context).pop())
                                  .then((value) => Flushbar(
                                        duration: Duration(seconds: 3),
                                        flushbarPosition:
                                            FlushbarPosition.BOTTOM,
                                        backgroundColor: Color(0xFFFF5C83),
                                        message:
                                            "Semua Data Absen Telah Berhasil Dihapus!",
                                      )..show(context));
                            },
                            child: Text(
                              'Benar',
                              style: blackTextFont,
                            ),
                          ),
                          FlatButton(
                            color: Colors.red,
                            onPressed: () => Navigator.of(context).pop(),
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
                  },
                  color: Colors.red,
                  disabledColor: Color(0xFFE4E4E4),
                  text: "Hapus Semua Data Absen",
                  textStyle: whiteTextFont.copyWith(fontSize: 16.0),
                ),
              ),
              // NOTE: HEADER
              Container(
                height: 133,
                color: accentColor3,
              ),
              SafeArea(
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
                                      width: 50,
                                      height: 13,
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
              ),
            ],
          ),
        );
      } else {
        return Loading(
          color: mainColor,
          colorBg: Colors.white,
        );
      }
    });
  }
}
