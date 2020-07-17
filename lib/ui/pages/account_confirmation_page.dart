part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  AccountConfirmationPage(this.registrationData);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigningUp = false;
  var deviceId = "";

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToPreferencePage(widget.registrationData));
        return;
      },
      child: Scaffold(
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 50),
                      height: 56,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                context.bloc<PageBloc>().add(GoToPreferencePage(
                                    widget.registrationData));
                              },
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Konfirmasi\nAkun Baru",
                              style: blackTextFont.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 5),
                              width: 100,
                              height: 25,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/bandage_user.png")))),
                          Container(
                            width: 150,
                            height: 150,
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: (widget.registrationData
                                                .profilePicture ==
                                            null)
                                        ? AssetImage("assets/edit_profile.png")
                                        : FileImage(widget
                                            .registrationData.profilePicture),
                                    fit: BoxFit.cover)),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Selamat Datang",
                      style: blackTextFont.copyWith(fontSize: 18),
                    ),
                    Text(
                      widget.registrationData.name,
                      style: blackTextFont.copyWith(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "Nomor ID Perangkatmu: " +
                            widget.registrationData.deviceId,
                        style: blackTextFont.copyWith(fontSize: 12)),
                    SizedBox(
                      height: 50,
                    ),
                    (isSigningUp)
                        ? Loading(colorBg: Colors.transparent, color: mainColor)
                        : SizedBox(
                            width: 250,
                            height: 45,
                            child: RaisedButton(
                                elevation: 0,
                                color: Color(0xFF39AEEF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text("Buat Akun Sekarang",
                                    style:
                                        whiteTextFont.copyWith(fontSize: 16)),
                                onPressed: () async {
                                  setState(() {
                                    isSigningUp = true;
                                  });

                                  imageFileToUpload =
                                      widget.registrationData.profilePicture;

                                  SignInSignUpResult result =
                                      await AuthServices.signUp(
                                    widget.registrationData.email,
                                    widget.registrationData.password,
                                    widget.registrationData.name,
                                    widget.registrationData.role,
                                    widget.registrationData.selectedGender,
                                    widget.registrationData.selectedBranch,
                                    widget.registrationData.deviceId,
                                  );

                                  if (result.user == null) {
                                    setState(() {
                                      isSigningUp = false;
                                    });

                                    Flushbar(
                                      duration: Duration(milliseconds: 1500),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Color(0xFFFF5C83),
                                      message: result.message,
                                    )..show(context);
                                  }
                                })),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
