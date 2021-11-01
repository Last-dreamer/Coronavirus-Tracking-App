
import 'package:coronavirus_tracking_app/app/services/api_keys.dart';


enum EndPoint {
  cases,
  casesSuspended,
  casesConfirmed,
  deaths,
  recovered
}

class API{

  final String apiKey;
  API({required this.apiKey});

  factory API.fromSandBox() => API(apiKey: ApiKeys.sandBox);

  static String host = "ncov2019-admin.firebaseapp.com";

  Uri tokenUri() => Uri(
    scheme: "https",
    host: host,
    path: "token"
  );


  Uri endPoints(EndPoint endPoint) => Uri(
    scheme: "https",
    host: host,
    path:_paths[endPoint]
  );

  static final Map<EndPoint, String> _paths = {
    EndPoint.cases: "cases",
    EndPoint.casesSuspended: "casesSuspended",
    EndPoint.casesConfirmed: "casesConfirmed",
    EndPoint.deaths: "deaths",
    EndPoint.recovered: "recovered"
  };

}