part of 'pages.dart';

class UserPage extends StatefulWidget {
  final int bottomNavBarIndex;
  final User user;
  final Absen absen;

  UserPage({this.bottomNavBarIndex = 0, this.user, this.absen});

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

  void checkIn() {}

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
                      child: Icon(MdiIcons.qrcodeScan, color: Colors.white),
                    ),
                    onPressed: () async {
                      if (PermissionStatus.denied == null) {
                        return openLocationSettingsConfiguration();
                      } else {
                        String qrcode = '';
                        qrcode = await getScan();
                        var position = await getLocation();
                        String latitude = position.latitude.toStringAsFixed(1);
                        String longitude =
                            position.longitude.toStringAsFixed(1);
                        String viewLat = position.latitude.toString();
                        String viewLong = position.longitude.toString();

                        var time = DateTime.now().timeNow;
                        var date = DateTime.now().dateNow;

                        if (qrcode == "Setiabudi" &&
                            latitude == '-6.2' &&
                            longitude == '106.8') {
                          return showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return BottomSheetWidget(
                                  icon: MdiIcons.checkboxMarkedCircle,
                                  color: Colors.green,
                                  result: "Berhasil!",
                                  text:
                                      "Absensi Telah Berhasil\nSelamat Bekerja",
                                  latitude: viewLat,
                                  longitude: viewLong,
                                  location: qrcode,
                                  qrcode: qrcode,
                                  date: date,
                                  time: time,
                                  account: userState.user.name,
                                  buttonText: "Done",
                                  onPressed: () async {
                                    DocumentReference documentReference =
                                        Firestore.instance
                                            .collection('absens')
                                            .document();
                                    documentReference.setData({
                                      'uid': userState.user.uid,
                                      'aid': documentReference.documentID,
                                      'name': userState.user.name,
                                      'email': userState.user.email,
                                      'location': qrcode,
                                      'checkIn': DateTime.now(),
                                      'checkOut': DateTime.now(),
                                      'lat': latitude,
                                      'long': longitude,
                                      'status': "checkIn",
                                    });
                                    context
                                        .bloc<PageBloc>()
                                        .add(GoToUserPage());
                                    Navigator.pop(context);
                                  },
                                );
                              });
                        } else {
                          return showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return BottomSheetWidget(
                                  icon: MdiIcons.closeCircle,
                                  color: Colors.red,
                                  result: "Upss!",
                                  text:
                                      "Silahkan kamu periksa kembali\nkode dan lokasimu!",
                                  latitude: viewLat,
                                  longitude: viewLong,
                                  location: qrcode,
                                  qrcode: qrcode,
                                  date: date,
                                  time: time,
                                  account: userState.user.name,
                                  buttonText: "Kembali",
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                );
                              });
                        }
                      }
                    }),
              );
            } else {
              return Loading(color: mainColor, colorBg: Colors.white);
            }
          }),
        )
      ],
    ));
  }

  void getBottomSheet(context) async {
    String qrcode = '';
    qrcode = await getScan();
    // var position;
    // position = await getLocation();
    var position = await Geolocator().getCurrentPosition();
    String latitude = position.latitude.toString();
    String longitude = position.longitude.toString();
    if (qrcode == "Jatinegara") {
      return showModalBottomSheet(
          context: context,
          builder: (context) {
            return BottomSheetWidget(
              icon: MdiIcons.checkboxMarkedCircle,
              color: Colors.green,
              result: "Success!",
              text: "Your absense has succeed in the\n" + qrcode + " location",
              latitude: latitude,
              longitude: longitude,
              qrcode: qrcode,
              time: DateTime.now().millisecondsSinceEpoch.toString(),
              account: "userState.user.name",
              buttonText: "Done",
              onPressed: () async {},
            );
          });
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) {
            return BottomSheetWidget(
              icon: MdiIcons.closeCircle,
              color: Colors.red,
              result: "Failed!",
              text: "Qr Code is not valid",
              latitude: latitude,
              longitude: longitude,
              qrcode: qrcode,
              time: DateTime.now().millisecondsSinceEpoch.toString(),
              account: "userState.user.name",
              buttonText: "Back",
              onPressed: () {},
            );
          });
    }
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
