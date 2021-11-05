
import 'dart:io';

import 'package:coronavirus_tracking_app/app/repositories/endpoints_data.dart';
import 'package:coronavirus_tracking_app/app/services/api.dart';
import 'package:coronavirus_tracking_app/app/services/endpoint_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCacheService{
  final SharedPreferences sharedPreferences;
  DataCacheService({required this.sharedPreferences});
  
  EndPointsData getData() {
    Map<EndPoint, EndPointData> values = {};
    for (var endpoint in EndPoint.values) {
       final value  =  sharedPreferences.getInt(endpointValueKey(endpoint));
       final dateString = sharedPreferences.getString(endpointDateKey(endpoint));

       if(value != null && dateString !=null){
         final date = DateTime.tryParse(dateString);
         values[endpoint] = EndPointData(value, date!);
       }
    }
    return EndPointsData(value: values);
  }
  
  static String endpointValueKey(EndPoint endPoint) => "$endPoint/value";
  static String endpointDateKey(EndPoint endPoint) => "$endPoint/date";

  Future<void> setData(EndPointsData endPointsData) async {
    endPointsData.value.forEach((endpoint, endpointdata) async {
      await sharedPreferences.setInt(endpointValueKey(endpoint),endpointdata.value);
      await sharedPreferences.setString(endpointDateKey(endpoint), endpointdata.date.toIso8601String());
    });
  }

}