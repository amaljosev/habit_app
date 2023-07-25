import 'individual_bar.dart';

class BarData {
  final double monday;
  final double tuesday;
  final double wednesday;
  final double thursday;
  final double friday;
  final double saturday;
  final double sunday;

  BarData(
      {required this.monday,
      required this.tuesday,
      required this.wednesday,
      required this.thursday,
      required this.friday,
      required this.saturday,
      required this.sunday});
      List <IndividualBar> barData=[];
void initializeBarData(){
  barData=[
    IndividualBar(x: 0, y: monday),
    IndividualBar(x: 1, y: tuesday),
    IndividualBar(x: 2, y: wednesday),
    IndividualBar(x: 3, y: thursday),
    IndividualBar(x: 4, y: friday),
    IndividualBar(x: 5, y: saturday),
    IndividualBar(x: 6, y: sunday),
    
  ];
}
}
