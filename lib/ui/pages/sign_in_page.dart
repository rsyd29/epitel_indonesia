part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSplashPage());

        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                SizedBox(height: size.height * 0.1),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 100, child: Image.asset('assets/logo.png')),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Welcome Back,\nMy Friend\'s!",
                        style: blackTextFont.copyWith(
                            fontSize: 26, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Text(
                        "To attend attendance,\nplease login",
                        style: blackTextFont.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          isEmailValid = EmailValidator.validate(text);
                        });
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Email",
                        hintText: "Email",
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          isPasswordValid = text.length >= 6;
                        });
                      },
                      controller: passwordController,
                      obscureText: !this.showPassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Password",
                        hintText: "Password",
                        suffixIcon: IconButton(
                            icon: Icon(MdiIcons.eye),
                            color: this.showPassword
                                ? accentColor1
                                : Colors.black38,
                            onPressed: () {
                              setState(
                                  () => this.showPassword = !this.showPassword);
                            }),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          "Forgot your password? ",
                          style: greyTextFont.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          child: Text(
                            "Tap Here!",
                            style: blueTextFont.copyWith(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          onTap: () async {
                            if (isEmailValid =
                                EmailValidator.validate(emailController.text) ==
                                    false) {
                              return Flushbar(
                                duration: Duration(seconds: 2),
                                flushbarPosition: FlushbarPosition.BOTTOM,
                                backgroundColor: Color(0xFFFF5C83),
                                message:
                                    "Please give your email address with right format",
                              )..show(context);
                            } else {
                              await AuthServices.resetPassword(
                                  emailController.text);
                              return Flushbar(
                                duration: Duration(seconds: 4),
                                flushbarPosition: FlushbarPosition.BOTTOM,
                                backgroundColor: Color(0xFFFF5C83),
                                message:
                                    "The link to change your password has been sent to your email address, please check your email address!",
                              )..show(context);
                            }
                          },
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 40, bottom: 30),
                      child: isSigningIn
                          ? Loading(color: mainColor, colorBg: Colors.white)
                          : FloatingActionButton(
                              elevation: 0,
                              child: Icon(
                                Icons.arrow_forward,
                                color: isEmailValid && isPasswordValid
                                    ? Colors.white
                                    : Color(0xBEBEBEBE),
                              ),
                              backgroundColor: isEmailValid && isPasswordValid
                                  ? mainColor
                                  : Color(0xFFE4E4E4),
                              onPressed: isEmailValid && isPasswordValid
                                  ? () async {
                                      setState(() {
                                        isSigningIn = true;
                                      });

                                      SignInSignUpResult result =
                                          await AuthServices.signIn(
                                        emailController.text,
                                        passwordController.text,
                                      );

                                      if (result.user == null) {
                                        setState(() {
                                          isSigningIn = false;
                                        });

                                        Flushbar(
                                          duration:
                                              Duration(milliseconds: 1500),
                                          flushbarPosition:
                                              FlushbarPosition.BOTTOM,
                                          backgroundColor: Color(0xFFFF5C83),
                                          message: result.message,
                                        )..show(context);
                                      }
                                    }
                                  : null),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don\'t have an account? ",
                            style: greyTextFont.copyWith(fontSize: 12)),
                        GestureDetector(
                          child: Text(
                            "Tap Here!",
                            style: blueTextFont.copyWith(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToRegistrationPage(RegistrationData()));
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
