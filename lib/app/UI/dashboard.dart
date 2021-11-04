import 'package:coronavirus_tracking_app/app/UI/endpoint_card.dart';
import 'package:coronavirus_tracking_app/app/repositories/data_repository.dart';
import 'package:coronavirus_tracking_app/app/repositories/endpoints_data.dart';
import 'package:coronavirus_tracking_app/app/services/api.dart';
import 'package:coronavirus_tracking_app/app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'latest_status_update.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
   EndPointsData? endPointsData;

  @override
  void initState() {
    _updateData();
    print("String data $endPointsData");

    super.initState();
  }

  Future<void> _updateData() async {

    print("String data  2 $endPointsData");
    final dataRep = Provider.of<DataRepository>(context, listen: false);


    // final mine  = await dataRep.getTheEndpoint(EndPoint.recovered);
    // print("mine data  $mine");
    final cases = await dataRep.getAllEndpoint();


    print("checking $cases");
    setState(() {
      endPointsData = cases;
    });

  }

  @override
  Widget build(BuildContext context) {
    final formatter = LatestStatusUpdateFormatter(latestUpdate: endPointsData?.value[EndPoint.cases]?.date ?? DateTime.now());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF222222),
        title: const Text("Corona Tracker"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            const SizedBox(height: 10,),

            LatestStatusUpdate(text: formatter.latestStatusUpdateText().toString(),),

            for (var endpoints in EndPoint.values)
                EndPointCard(
                    endPoint: endpoints,
                    value: endPointsData?.value[endpoints]?.value.toString() ?? ''),
          ],
        ),
      ),
    );
  }
}
