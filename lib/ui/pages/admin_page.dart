part of 'pages.dart';

class AdminPage extends StatefulWidget {
  final int bottomNavBarIndex;

  AdminPage({this.bottomNavBarIndex = 0});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int bottomNavBarIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();

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
            HomeAdminPage(),
            ProfilePage(),
          ],
        ),
        createCustomBottomNavBar(),
        BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) => Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 46,
              width: 46,
              margin: EdgeInsets.only(bottom: 42),
              child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: accentColor3,
                  child: SizedBox(
                    height: 26,
                    width: 26,
                    child: Icon(MdiIcons.plus, color: Colors.white),
                  ),
                  onPressed: () {
                    context
                        .bloc<PageBloc>()
                        .add(GoToAddPage((userState as UserLoaded).user));
                    print("Tambah Akun");
                  }),
            ),
          ),
        )
      ],
    ));
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
