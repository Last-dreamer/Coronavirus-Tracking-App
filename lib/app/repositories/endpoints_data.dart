
import 'package:coronavirus_tracking_app/app/services/api.dart';
import 'package:coronavirus_tracking_app/app/services/endpoint_data.dart';

class EndPointsData {
  final Map<EndPoint, EndPointData> value;

  EndPointsData({ required this.value});

  // getters
  EndPointData? get cases => value[EndPoint.cases];
  EndPointData? get casesConfirmed => value[EndPoint.casesConfirmed];
  EndPointData? get deaths => value[EndPoint.deaths];
  EndPointData? get recovered => value[EndPoint.recovered];

  @override
  String toString() => "cases: $cases,  casesConfirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered";

}
