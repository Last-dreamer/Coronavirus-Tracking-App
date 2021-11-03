
import 'package:coronavirus_tracking_app/app/services/api.dart';

class EndPointsData {
  final Map<EndPoint, String> value;

  EndPointsData({ required this.value });

  // getters
  String? get cases => value[EndPoint.cases];
  String? get casesConfirmed => value[EndPoint.casesConfirmed];
  String? get deaths => value[EndPoint.deaths];
  String? get recovered => value[EndPoint.recovered];

  @override
  String toString() => "cases: $cases,  casesConfirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered";

}
