part of 'widgets.dart';

class ReusableStyleTextProfile extends StatelessWidget {
  final String title;
  ReusableStyleTextProfile({@required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        // margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListTile(
            title: Text(title,
                style: blackTextFont.copyWith(
                    fontSize: 18, fontWeight: FontWeight.w600))));
  }
}

class ReusableList extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  ReusableList({@required this.title, this.icon, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
          child: Container(
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  icon,
                  color: accentColor3,
                ),
                title: Text(title, style: blackTextFont.copyWith(fontSize: 14)),
                trailing: Icon(
                  MdiIcons.arrowRight,
                  color: accentColor3,
                ),
                onTap: onTap,
              ))),
    );
  }
}

class ReusableSizedBox extends StatelessWidget {
  final double height;
  ReusableSizedBox({@required this.height});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
            height: height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Color(0xFFF6F7F9))));
  }
}

class ReusableButton extends StatelessWidget {
  final Color color, disabledColor;
  final Function onPressed;
  final IconData icons;
  final String text;
  final double height, width, icWidth;
  final TextStyle textStyle;

  ReusableButton({
    @required this.onPressed,
    this.color,
    this.disabledColor,
    this.textStyle,
    this.text,
    this.icons,
    this.height = 45,
    this.width = 250,
    this.icWidth = 5,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
          onPressed: onPressed,
          color: color,
          disabledColor: disabledColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icons,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: icWidth),
              Text(text, style: textStyle),
              SizedBox(width: icWidth),
              Icon(
                icons,
                color: Colors.white,
                size: 20,
              ),
            ],
          )),
    );
  }
}

class NotReusableSizedBoxAndButton extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final String text, versi, app;
  NotReusableSizedBoxAndButton(
      {@required this.onPressed, this.color, this.text, this.versi, this.app});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: <Widget>[
      SingleChildScrollView(
          child: Container(
              // margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              alignment: Alignment.topCenter,
              height: 120.0,
              color: Colors.white,
              child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: defaultMargin, vertical: 15.0),
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(versi, style: blackTextFont),
                        Text(app, style: blackTextFont)
                      ],
                    ),
                    Row(children: <Widget>[
                      Container(
                          height: 55.0,
                          width: size.width - 50,
                          margin: EdgeInsets.only(top: 10.0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 0,
                            child: Text(text,
                                style: whiteTextFont.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            color: color,
                            onPressed: onPressed,
                          ))
                    ])
                  ]))))
    ]);
  }
}
