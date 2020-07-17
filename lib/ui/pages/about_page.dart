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
                  margin: EdgeInsets.only(top: 20, bottom: 20),
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
                          "Tentang\nAplikasi",
                          style: blackTextFont.copyWith(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/budiman.png"),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "@rsyd29\nBudiman Rasyid",
                      style: blackTextFont.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SocmedBox(
                      onTap: null,
                      socmed: "Instagram",
                      acc: "@rsyd29",
                    ),
                    SocmedBox(
                      onTap: null,
                      socmed: "WhatsApp",
                      acc: "089636986438",
                    ),
                    SocmedBox(
                      onTap: null,
                      socmed: "Email",
                      acc: "brasyid@gmail.com",
                    ),
                    SocmedBox(
                      onTap: null,
                      socmed: "GitHub",
                      acc: "github.com/rsyd29",
                    ),
                    SizedBox(height: 20),
                    Text(
                      "#EpitelIndonesia",
                      style: blackTextFont.copyWith(fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
