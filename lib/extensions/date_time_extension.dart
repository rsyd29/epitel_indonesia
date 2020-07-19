part of 'extensions.dart';

extension DateTimeExtension on DateTime {
  String get timeNow =>
      "${this.hour}:${this.minute}:${this.second} ${this.timeZoneName}";
  String get dateNow =>
      "${this.dayName}, ${this.day} ${this.monthName} ${this.year}";

  String get shortDayName {
    switch (this.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      default:
        return 'Sun';
    }
  }

  String get dayName {
    switch (this.weekday) {
      case 1:
        return 'Senin';
      case 2:
        return 'Selasa';
      case 3:
        return 'Rabu';
      case 4:
        return 'Kamis';
      case 5:
        return "Jum'at";
      case 6:
        return 'Sabtu';
      default:
        return 'Minggu';
    }
  }

  String get shortMonthName {
    switch (this.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      default:
        return 'Dec';
    }
  }

  String get monthName {
    switch (this.month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      default:
        return 'Desember';
    }
  }
}
