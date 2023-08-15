  import 'package:intl/intl.dart';

bool shouldShowButtons(List week) {
    // Get the current day of the week (e.g., "Monday", "Tuesday")
    String currentDayOfWeek = DateFormat('EEEE').format(DateTime.now());

    // Check if the current day is present in the list of days
    bool isDayInWeek = week.contains(currentDayOfWeek);

    // Return true if the current day is in the list, otherwise false
    return isDayInWeek;
  }