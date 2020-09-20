part of 'pages.dart';

class UserPage extends StatefulWidget {
  final int bottomNavBarIndex;
  final User user;

  UserPage({this.bottomNavBarIndex = 0, this.user});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int bottomNavBarIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    getLocation();
    bottomNavBarIndex = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(color: accentColor3),
        SafeArea(
            child: Container(
          color: Color(0xFFF6F7F9),
        )),
        PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              bottomNavBarIndex = index;
            });
          },
          children: [
            HomeUserPage(),
            ProfilePage(),
          ],
        ),
        createCustomBottomNavBar(),
        Align(
          alignment: Alignment.bottomCenter,
          child: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
            if (userState is UserLoaded) {
              void _onAbsenCheckIn(BuildContext context, String qrcode,
                  String latitude, String longitude) {
                DocumentReference documentReference =
                    Firestore.instance.collection('absens').document();
                documentReference.setData({
                  'uid': userState.user.uid,
                  'aid': documentReference.documentID,
                  'name': userState.user.name,
                  'email': userState.user.email,
                  'branch': userState.user.selectedBranch,
                  'location_in': qrcode,
                  'checkIn': DateTime.now(),
                  'location_out': qrcode,
                  'checkOut': DateTime.now(),
                  'lat': latitude,
                  'long': longitude,
                  'status': "checkIn",
                });

                Navigator.pop(context);
              }

              return StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('branchs').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> querySnapshot) {
                    if (querySnapshot.hasError) {
                      return Text('Terdapat Kesalahan');
                    } else {
                      return Container(
                          height: 46,
                          width: 46,
                          margin: EdgeInsets.only(bottom: 42),
                          child: FloatingActionButton(
                              elevation: 0,
                              backgroundColor: accentColor3,
                              child: SizedBox(
                                height: 26,
                                width: 26,
                                child: Icon(MdiIcons.qrcodeScan,
                                    color: Colors.white),
                              ),
                              onPressed: () async {
                                final qrcode = await getScan();
                                final position = await getLocation();
                                final latitude =
                                    position.latitude.toStringAsFixed(3);
                                final longitude =
                                    position.longitude.toStringAsFixed(3);
                                final viewLat = position.latitude.toString();
                                final viewLong = position.longitude.toString();
                                final time = DateTime.now().timeNow;
                                final date = DateTime.now().dateScanNow;
                                bool isTrue = false;

                                final list = querySnapshot.data.documents;

                                list.forEach((element) {
                                  String qrCodeSemua = element.data['qrcode'];
                                  String latSemua = element.data['latitude'];
                                  String longSemua = element.data['longitude'];

                                  if (qrcode == qrCodeSemua &&
                                      latitude == latSemua &&
                                      longitude == longSemua) {
                                    setState(() {
                                      isTrue = !isTrue;
                                    });
                                  }
                                });

                                (isTrue)
                                    ? buildShowModalBottomSheetBerhasilMasuk(
                                        context,
                                        viewLat,
                                        latitude,
                                        viewLong,
                                        longitude,
                                        qrcode,
                                        date,
                                        time,
                                        userState,
                                        _onAbsenCheckIn)
                                    : buildShowModalBottomSheetGagalMasuk(
                                        context,
                                        viewLat,
                                        latitude,
                                        viewLong,
                                        longitude,
                                        qrcode,
                                        date,
                                        time,
                                        userState);
                              }));
                    }
                  });
            } else {
              return Loading(color: mainColor, colorBg: Colors.white);
            }
          }),
        )
      ],
    ));
  }

  Future<void> buildShowModalBottomSheetGagalMasuk(
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

  Future<void> buildShowModalBottomSheetBerhasilMasuk(
      BuildContext context,
      String viewLat,
      String latitude,
      String viewLong,
      String longitude,
      String qrcode,
      String date,
      String time,
      UserLoaded userState,
      void _onAbsenCheckIn(BuildContext context, String qrcode, String latitude,
          String longitude)) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheetScan(
            icon: MdiIcons.checkboxMarkedCircle,
            colorIc: Colors.green,
            result: "Berhasil Masuk",
            text: "Absen Masuk Telah Berhasil\nSelamat Bekerja",
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
            onPressed: () async {
              _onAbsenCheckIn(context, qrcode, latitude, longitude);
              return Flushbar(
                duration: Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.BOTTOM,
                backgroundColor: Color(0xFFFF5C83),
                message: "Anda telah berhasil masuk di kantor $qrcode",
              )..show(context);
            },
          );
        });
  }

  Widget createCustomBottomNavBar() => Align(
        alignment: Alignment.bottomCenter,
        child: ClipPath(
          clipper: BottomNavBarClipper(),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                selectedItemColor: mainColor,
                unselectedItemColor: Color(0xFFE5E5E5),
                currentIndex: bottomNavBarIndex,
                onTap: (index) {
                  setState(() {
                    bottomNavBarIndex = index;
                    pageController.jumpToPage(index);
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      title: Text("Home",
                          style: GoogleFonts.poppins().copyWith(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      icon: Container(
                        margin: EdgeInsets.only(bottom: 6),
                        height: 30,
                        child: Image.asset((bottomNavBarIndex == 0)
                            ? 'assets/ic_home.png'
                            : 'assets/ic_home_grey.png'),
                      )),
                  BottomNavigationBarItem(
                      title: Text("Profile",
                          style: GoogleFonts.poppins().copyWith(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      icon: Container(
                        margin: EdgeInsets.only(bottom: 6),
                        height: 30,
                        child: Image.asset((bottomNavBarIndex == 1)
                            ? 'assets/ic_profile.png'
                            : 'assets/ic_profile_grey.png'),
                      )),
                ]),
          ),
        ),
      );
}
