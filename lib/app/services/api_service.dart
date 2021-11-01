import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:coronavirus_tracking_app/app/services/api.dart';

class APIService {
  final API api;

  APIService(this.api);

  Future<String> getAccessToken() async {
    final response = await http.post(api.tokenUri(),
        headers: {"Authorization": "Basic ${api.apiKey}"});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        "Request ${api.apiKey} failed \n Response: ${response.statusCode} ${response.reasonPhrase}");
    throw response;
  }


  Future<int> getEndpointData({
    required String accessToken,
    required EndPoint endPoint
}) async {

    final uri =  api.endPointsUri(endPoint);
    final response = await http.get(uri, headers: {"Authorization": "Bearer $accessToken"});

    print("res ${response.statusCode}");
    if(response.statusCode == 200){

      final List<dynamic> data = json.decode(response.body);

      print("res ${data}");
      if(data.isNotEmpty){
       final Map<String, dynamic> endPointData = data[0];
       final String responseJsonKey =  _responseJsonKeys![endPoint] ?? "";
      final int result = endPointData[responseJsonKey];
      if(result != null){
        return result;
      }}
    }

    print(
        "Request ${api.apiKey} failed \n Response: ${response.statusCode} ${response.reasonPhrase}");
    throw response;

  }


  static final Map<EndPoint, String>? _responseJsonKeys = {
    EndPoint.cases: "cases",
    EndPoint.casesSuspended: "data",
    EndPoint.casesConfirmed: "data",
    EndPoint.deaths: "data",
    EndPoint.recovered: "data"
  };
}
