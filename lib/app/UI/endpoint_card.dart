
import 'package:coronavirus_tracking_app/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EndPointCardData{
  final String title;
  final String assetsName;
  final Color color;

  EndPointCardData({required this.title, required this.assetsName, required this.color});

}

class EndPointCard extends StatelessWidget {
  const EndPointCard({Key? key,required this.endPoint, required this.value }) : super(key: key);

  final EndPoint endPoint;
  final String? value;

 static final Map<EndPoint, EndPointCardData> _cardTitle = {
    EndPoint.cases: EndPointCardData(title: "Cases", assetsName: "assets/count.png", color: const Color(0xFFFFF492)),
    EndPoint.casesConfirmed: EndPointCardData(title: "Confirmed Cases", assetsName: "assets/fever.png", color: const Color(0xFFE99600)),
    EndPoint.deaths: EndPointCardData(title: "Deaths", assetsName: "assets/death.png", color: const Color(0xFFE40000)),
    EndPoint.recovered: EndPointCardData(title: "Recovered", assetsName: "assets/patient.png", color: const Color(0xFF704901)),
  };


  String get formattedValue {
    if (value == null) {
      return '';
    }
    return NumberFormat('#,###,###,###').format(int.parse(value.toString()));
  }


  @override
  Widget build(BuildContext context) {
    var cardData = _cardTitle[endPoint];

    
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: InkWell(
      onTap: (){
      },
      splashColor: Colors.red,
      child: Card(
        elevation: 10.0,
        shadowColor: Colors.white24,
        // borderOnForeground: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(cardData!.title, style: Theme.of(context).textTheme.headline6!.copyWith(color: cardData.color),),
              const SizedBox(height: 10,),

              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(cardData.assetsName, color: cardData.color,),

                    Text(formattedValue,
                      style: Theme.of(context).textTheme.headline6!.copyWith(color: cardData.color, fontWeight: FontWeight.w600),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
