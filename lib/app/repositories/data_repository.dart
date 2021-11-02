
import 'package:coronavirus_tracking_app/app/services/api.dart';
import 'package:coronavirus_tracking_app/app/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class DataRepository{

  DataRepository({required this.apiService});
  final APIService apiService;

  String? _accessToken;

  Future<int> getTheEndpoint(EndPoint endPoint) async {

    try {
        _accessToken = await apiService.getAccessToken();
      var check = await apiService.getEndpointData(
          accessToken: _accessToken.toString(), endPoint: endPoint);
      print("check it  5 $check");

      return check;
    } on Response catch(e){
      // if unAuthorized  then refresh the token...
      if(e.statusCode == 401){
        _accessToken = await apiService.getAccessToken();
        return await apiService.getEndpointData(
            accessToken: _accessToken.toString(), endPoint: endPoint);
      }
      rethrow;
    }
  }
}