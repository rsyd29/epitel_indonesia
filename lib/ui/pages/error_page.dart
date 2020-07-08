part of 'pages.dart';

class ErrorPage extends StatefulWidget {
  final User user;

  ErrorPage(this.user);
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  String profilePath;
  File profileImageFile;

  @override
  void initState() {
    super.initState();
    profilePath = widget.user.profilePicture;
    getDeviceinfo();
  }

  void getDeviceinfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo;
    androidDeviceInfo = await deviceInfo.androidInfo;
    if (this.mounted) {
      setState(() {
        deviceId = androidDeviceInfo
            .androidId; // instantiate Android Device Infoformation
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
      if (userState is UserLoaded) {
        if (imageFileToUpload != null) {
          uploadImage(imageFileToUpload).then((downloadURL) {
            imageFileToUpload = null;
            context
                .bloc<UserBloc>()
                .add(UpdateData(profilePicture: downloadURL));
          });
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 5),
                    width: 100,
                    height: 25,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: (userState.user.role == "admin")
                                ? AssetImage("assets/bandage_admin.png")
                                : AssetImage("assets/bandage_user.png")))),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: accentColor2, width: 1)),
                  child: Stack(
                    children: [
                      // Loading(
                      //     colorBg: Colors.transparent,
                      //     color: accentColor1,
                      //     size: 150),
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: (userState.user.profilePicture == ""
                                    ? AssetImage("assets/edit_profile.png")
                                    : NetworkImage(
                                        userState.user.profilePicture)),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(widget.user.name,
                    style: blackTextFont.copyWith(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text("Your device ID: " + widget.user.deviceId,
                    style: blackTextFont.copyWith(fontSize: 12)),
                SizedBox(height: 5),
                Text("You login using the device ID: " + deviceId,
                    style: blackTextFont.copyWith(fontSize: 12)),
                SizedBox(height: 5),
                Text(
                  "\"Your account is not active or device not registered,\nplease ask the admin!\"",
                  style: redTextFont.copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ReusableButton(
                    height: 45,
                    width: 120,
                    icons: MdiIcons.backburger,
                    color: Colors.red,
                    text: "Back",
                    onPressed: () {
                      context.bloc<UserBloc>().add(SignOut());
                      AuthServices.signOut();
                    }),
              ],
            ),
          ),
        );
      } else {
        return Loading(colorBg: Colors.white, color: mainColor);
      }
    });
  }
}
