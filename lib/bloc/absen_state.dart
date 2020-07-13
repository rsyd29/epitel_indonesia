part of 'absen_bloc.dart';

class AbsenState extends Equatable {
  final List<Absen> absens;

  const AbsenState(this.absens);

  @override
  List<Object> get props => [absens];
}
