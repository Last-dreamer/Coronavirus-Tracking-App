import 'package:coronavirus_tracking_app/app/repositories/endpoints_data.dart';
import 'package:coronavirus_tracking_app/app/services/api.dart';
import 'package:coronavirus_tracking_app/app/services/api_service.dart';
import 'package:coronavirus_tracking_app/app/services/data_cache_services.dart';
import 'package:coronavirus_tracking_app/app/services/endpoint_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({required this.apiService, required this.dataCacheService});

  final DataCacheService dataCacheService;
  final APIService apiService;

  String? _accessToken;

  // // getting a single endpoint
  // Future<int> getTheEndpoint(EndPoint endPoint) async {
  //
  //   try {
  //       _accessToken = await apiService.getAccessToken();
  //     var check = await apiService.getEndpointData(
  //         accessToken: _accessToken.toString(), endPoint: endPoint);
  //     print("check it  5 $check");
  //
  //     return check;
  //   } on Response catch(e){
  //     // if unAuthorized  then refresh the token...
  //     if(e.statusCode == 401){
  //       _accessToken = await apiService.getAccessToken();
  //       return await apiService.getEndpointData(
  //           accessToken: _accessToken.toString(), endPoint: endPoint);
  //     }
  //     rethrow;
  //   }
  // }

  // calling all endpoints

  // getting a single endpoint
  Future<EndPointData> getTheEndpoint(EndPoint endPoint) async =>
      await _getDataRefreshingToken<EndPointData>(
        getData: () => apiService.getEndpointData(
            accessToken: _accessToken.toString(), endPoint: endPoint),
      );

  // getting all the data from sharedPreference...
  EndPointsData getALlDataFromCache() => dataCacheService.getData();

  // getting all endpoints ...
  Future<EndPointsData> getAllEndpoint() async {
   final allData = await _getDataRefreshingToken<EndPointsData>(getData: _getAllEndPoints);
   dataCacheService.setData(allData);
   return allData;
  }

  // a generic  function for multiple calls...
  Future<T> _getDataRefreshingToken<T>(
      {required Future<T> Function() getData}) async {
    try {
       _accessToken = await apiService.getAccessToken();
      return await getData();
    } on Response catch (e) {
      // if unAuthorized  then refresh the token...
      if (e.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await getData();
      }
      rethrow;
    }
  }

  // getting all data in parallel
  Future<EndPointsData> _getAllEndPoints() async {
    // getting all the data in parallel...
    var value = await Future.wait([
      apiService.getEndpointData(
          accessToken: _accessToken.toString(), endPoint: EndPoint.cases),
      apiService.getEndpointData(
          accessToken: _accessToken.toString(),
          endPoint: EndPoint.casesConfirmed),
      apiService.getEndpointData(
          accessToken: _accessToken.toString(), endPoint: EndPoint.deaths),
      apiService.getEndpointData(
          accessToken: _accessToken.toString(), endPoint: EndPoint.recovered),
    ]);
    print("value $value");
    return EndPointsData(value: {
      EndPoint.cases: value[0],
      EndPoint.casesConfirmed: value[1],
      EndPoint.deaths: value[2],
      EndPoint.recovered: value[3],
    });
  }
}
