part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 150, bottom: 30),
              height: 109,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/logo_tulisan.png")),
              ),
            ),
            Container(
              width: 250,
              height: 46,
              margin: EdgeInsets.only(top: 100, bottom: 20),
              child: MaterialButton(
                  elevation: 0,
                  child: Text(
                    "Daftar Akun Sekarang",
                    style: whiteTextFont.copyWith(fontSize: 18),
                  ),
                  color: mainColor,
                  onPressed: () {
                    context
                        .bloc<PageBloc>()
                        .add(GoToRegistrationPage(RegistrationData()));
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sudah memiliki akun? ",
                  style: greyTextFont.copyWith(fontWeight: FontWeight.w400),
                ),
                BlocBuilder<UserBloc, UserState>(
                  builder: (_, userState) => GestureDetector(
                    onTap: () => context.bloc<PageBloc>().add(GoToLoginPage()),
                    child: Text(
                      "Masuk sekarang",
                      style: blueTextFont,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
