part of 'widgets.dart';

class ReusableTextField extends StatelessWidget {
  final String labelText, hintText;
  final Function controller, trailing;

  ReusableTextField(
      {this.controller, this.trailing, this.labelText, this.hintText});
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: labelText,
          hintText: hintText),
    );
  }
}

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

class ReusableFlushBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Flushbar(
      duration: Duration(milliseconds: 1500),
      flushbarPosition: FlushbarPosition.BOTTOM,
      backgroundColor: Color(0xFFFF5C83),
      message: "Test",
    )..show(context));
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

// class ReusableListProfile extends StatefulWidget {
//   final User user;

//   ReusableListProfile({this.user});
//   @override
//   _ReusableListProfileState createState() => _ReusableListProfileState();
// }

// class _ReusableListProfileState extends State<ReusableListProfile> {
//   static const menuItems = <String>[
//     'active',
//     'not active',
//   ];
//   final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
//       .map(
//         (String value) => DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         ),
//       )
//       .toList();

//   bool isSave = false;
//   bool isDataEdited = false;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: Firestore.instance
//             .collection("users")
//             .where("role", isEqualTo: "user")
//             .orderBy("status", descending: true)
//             .snapshots(),
//         builder:
//             (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
//           if (querySnapshot.hasError) {
//             return Text('Something error');
//           }
//           if (querySnapshot.connectionState == ConnectionState.waiting) {
//             return Loading(color: mainColor, colorBg: Colors.white);
//           } else {
//             final list = querySnapshot.data.documents;
//             return ListView.builder(
//                 itemCount: list.length,
//                 itemBuilder: (_, index) {
//                   String getStatus = list[index]['status'];
//                   return Container(
//                     margin: EdgeInsets.all(5),
//                     height: 75.0,
//                     width: 250.0,
//                     child: Row(
//                       children: [
//                         Container(
//                           height: 50.0,
//                           width: 50.0,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image: (list[index]['profilePicture'] != "")
//                                     ? NetworkImage(
//                                         list[index]['profilePicture'])
//                                     : AssetImage("assets/edit_profile.png"),
//                                 fit: BoxFit.cover),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(left: 20.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(list[index]['name'],
//                                   style: blackTextFont.copyWith(
//                                       fontSize: 16.0,
//                                       fontWeight: FontWeight.bold)),
//                               Text(list[index]['email'],
//                                   style: blackTextFont.copyWith(
//                                       fontSize: 14.0,
//                                       fontWeight: FontWeight.w200)),
//                               Text(list[index]['selectedBranch'],
//                                   style: greyTextFont.copyWith(fontSize: 12.0)),
//                             ],
//                           ),
//                         ),
//                         DropdownButton(
//                             value: getStatus,
//                             items: this._dropDownMenuItems,
//                             onChanged: (String newValue) {
//                               setState(() {
//                                 getStatus = newValue;
//                               });
//                             }),
//                       ],
//                     ),
//                   );
//                 });
//           }
//         });
//   }
// }

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
  final double height;
  final double width;

  ReusableButton({
    @required this.onPressed,
    this.color,
    this.disabledColor,
    this.text,
    this.icons,
    this.height = 45,
    this.width = 250,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: RaisedButton(
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
              SizedBox(
                width: 5,
              ),
              Text(text, style: whiteTextFont.copyWith(fontSize: 12)),
              SizedBox(
                width: 5,
              ),
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
                          child: RaisedButton(
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
