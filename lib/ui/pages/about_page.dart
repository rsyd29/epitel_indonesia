part of 'pages.dart';

class AboutPage extends StatefulWidget {
  final User user;
  AboutPage(this.user);
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (widget.user.role == 'admin') {
          context.bloc<PageBloc>().add(GoToAdminPage(bottomNavBarIndex: 1));
        } else {
          context.bloc<PageBloc>().add(GoToUserPage(bottomNavBarIndex: 1));
        }
        return;
      },
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 22),
                  height: 56,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            if (widget.user.role == 'admin') {
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToAdminPage(bottomNavBarIndex: 1));
                            } else {
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToUserPage(bottomNavBarIndex: 1));
                            }
                          },
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                      Center(
                        child: Text(
                          "About the Application",
                          style: blackTextFont.copyWith(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                    "Aplikasi ini merupakan tugas Budiman Rasyid dari kelas 3IA13 di Universitas Gunadarma, tugas ini bertujuan untuk memenuhi salah satu syarat sidang yaitu penulisan ilmiah")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
