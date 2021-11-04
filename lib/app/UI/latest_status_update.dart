

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class LatestStatusUpdateFormatter{

  final DateTime latestUpdate;
  LatestStatusUpdateFormatter({required this.latestUpdate});

  String latestStatusUpdateText(){
    if(latestUpdate != null){
      final formatter = DateFormat.yMd().add_Hm().format(latestUpdate);
      return "Latest Update: $formatter";
    }

    return '';
  }
}

class LatestStatusUpdate extends StatelessWidget {
  const LatestStatusUpdate({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0), child: Text(text, textAlign: TextAlign.center,),);
  }
}
