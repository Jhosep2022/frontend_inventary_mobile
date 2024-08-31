import 'package:equatable/equatable.dart';

abstract class AreasEvent extends Equatable {
  const AreasEvent();

  @override
  List<Object> get props => [];
}

class FetchAreas extends AreasEvent {
  final int companyId;

  const FetchAreas(this.companyId);

  @override
  List<Object> get props => [companyId];
}
