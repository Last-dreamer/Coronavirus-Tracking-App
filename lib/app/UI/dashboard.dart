
import 'package:coronavirus_tracking_app/app/UI/endpoint_card.dart';
import 'package:coronavirus_tracking_app/app/repositories/data_repository.dart';
import 'package:coronavirus_tracking_app/app/services/api.dart';
import 'package:coronavirus_tracking_app/app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String _cases = "";

  @override
  void initState() {
    _updateData();

    super.initState();
  }



  Future<void> _updateData() async {
    final dataRep =  Provider.of<DataRepository>(context, listen: false);
    final cases = await dataRep.getTheEndpoint(EndPoint.cases);
    print("checking ${cases}");
    setState(() {
      _cases = cases.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Corona Tracker"), centerTitle: true,),
      body: ListView(
        children:  [
          EndPointCard(endPoint: EndPoint.cases, value:_cases),
        ],
      ),
    );
  }
}
