  bool isOneDayOrMoreDifference(DateTime lastDate, DateTime currentDate) {
    // Get the date components (day, month, year) for both dates
    int lastDay = lastDate.day;
    int currentDay = currentDate.day;

    int lastMonth = lastDate.month;
    int currentMonth = currentDate.month;

    int lastYear = lastDate.year;
    int currentYear = currentDate.year;

    // Check if the year and month are the same
    if (lastYear == currentYear && lastMonth == currentMonth) {
      // Check if the difference between the days is 1 or more
      return (currentDay - lastDay) > 1;
    }

    // Check if the dates are 1 month apart or more
    if ((currentYear == lastYear && currentMonth - lastMonth >= 1) ||
        (currentYear - lastYear == 1 && currentMonth == 1 && lastMonth == 12)) {
      // Check if the last date is the last day of the month and the current date is the first day of the month
      bool isLastDayOfMonth =
          (lastDate.day == DateTime(lastYear, lastMonth + 1, 0).day);
      bool isFirstDayOfMonth = (currentDate.day == 1);
      return isLastDayOfMonth && isFirstDayOfMonth;
    }
    return false;
  }