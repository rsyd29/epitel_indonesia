// import 'dart:async';

// import 'package:Epitel_Indonesia/models/models.dart';
// import 'package:Epitel_Indonesia/services/services.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'absen_event.dart';
// part 'absen_state.dart';

// class AbsenBloc extends Bloc<AbsenEvent, AbsenState> {
//   @override
//   AbsenState get initialState => AbsenState([]);

//   @override
//   Stream<AbsenState> mapEventToState(
//     AbsenEvent event,
//   ) async* {
//     if (event is FetchAbsens) {
//       await AbsenServices.saveAbsen(event.uid, event.absen);
//       List<Absen> absens = state.absens;
//       yield AbsenState(absens);
//     }
//   }
// }
