
import 'package:coronavirus_tracking_app/app/services/api.dart';
import 'package:flutter/material.dart';

class EndPointCard extends StatelessWidget {
  const EndPointCard({Key? key,required this.endPoint, required this.value }) : super(key: key);

  final EndPoint endPoint;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Cases", style: Theme.of(context).textTheme.headline6,),
            Text(value, style: Theme.of(context).textTheme.bodyText1,)
          ],
        ),
      ),
    ),
    );
  }
}
