part of 'shared.dart';

const double defaultMargin = 24;

Color mainColor = Color(0xFF00AFF0);
Color accentColor1 = Color(0xFFFDF111);
Color accentColor2 = Color(0xFFBBBBBB);
Color accentColor3 = Color(0xFF2196F3);

TextStyle blackTextFont = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle whiteTextFont = GoogleFonts.poppins()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle blueTextFont = GoogleFonts.poppins()
    .copyWith(color: mainColor, fontWeight: FontWeight.w500);
TextStyle greyTextFont = GoogleFonts.poppins()
    .copyWith(color: accentColor2, fontWeight: FontWeight.w500);
TextStyle yellowTextFont = GoogleFonts.poppins()
    .copyWith(color: accentColor1, fontWeight: FontWeight.w500);
TextStyle redTextFont = GoogleFonts.poppins()
    .copyWith(color: Colors.red, fontWeight: FontWeight.w500);

TextStyle whiteNumberFont =
    GoogleFonts.sourceSansPro().copyWith(color: Colors.white);
TextStyle blackNumberFont =
    GoogleFonts.sourceSansPro().copyWith(color: Colors.black);
TextStyle yellowNumberFont =
    GoogleFonts.sourceSansPro().copyWith(color: accentColor1);
