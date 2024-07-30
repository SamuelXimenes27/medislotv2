import 'package:equatable/equatable.dart';
import 'package:medislot/data/data.dart';
import 'package:medislot/domain/domain.dart';

abstract class SearchClinics {
  Future<List<ClinicEntity>> search(SearchClinicsParams param);
}

class SearchClinicsParams extends Equatable {
  final CityModel? citySelected;
  final SpecialityModel? specialtySelected;
  final DateTime? datetime;

  const SearchClinicsParams({this.citySelected, this.specialtySelected, this.datetime});

  @override
  List<Object?> get props => [citySelected, specialtySelected, datetime];
}
