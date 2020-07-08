import 'dart:io';
import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:Epitel_Indonesia/bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:geolocator/geolocator.dart';

part 'loading.dart';
part 'shared_value.dart';
part 'theme.dart';
part 'shared_methods.dart';
