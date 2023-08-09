import 'package:flutter/material.dart';
import 'package:selector_wheel/selector_wheel/models/selector_wheel_value.dart';
import 'package:selector_wheel/selector_wheel/selector_wheel.dart';

class ScreenMe extends StatefulWidget {
  const ScreenMe({super.key});

  @override
  State<ScreenMe> createState() => _ScreenMeState();
}

class _ScreenMeState extends State<ScreenMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
        body: Row(
      
      children: [
        // Overriding the colors of the selector wheel
        Card( 
          child: SizedBox(
            width: 100,
            height: 100, 
            child: SelectorWheel( 
              childCount: 10,
              convertIndexToValue: (int index) {
                // Convert the index to a value from 1 to 10
                final value = index + 1;
        
                return SelectorWheelValue(
                  label: '$value', // Display the value directly
                  value: value.toDouble(),
                  index: index,
                );
              },
              onValueChanged: (SelectorWheelValue<double> value) {
                // Print the selected value
                print(value);
              },
            ),
          ),
        ),
        SizedBox(
          width: 100,
          height: 100, 
          child: SelectorWheel(
            childCount: 10, // Including weekdays, so total items are 10
            convertIndexToValue: (int index) {
              if (index < 7) {
                // Return weekday names for index 0 to 6
                final weekdays = [
                  'Sunday',
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday'
                ];
                final value = weekdays[index];
                return SelectorWheelValue(
                  label: value,
                  value: value,
                  index: index,
                );
              } else {
                // Return numeric values for index 7 to 9 (as per previous example)
                final numericValue = index - 6;
                return SelectorWheelValue(
                  label: '$numericValue',
                  value: numericValue.toDouble(),
                  index: index,
                );
              }
            },
            onValueChanged: (SelectorWheelValue<dynamic> value) {
              print(value);
            },
          ),
        ),
      ],
    ));
  }
}
