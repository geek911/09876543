import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

TimeOfDay parseTime(String time) {
  var dateTime = DateFormat("h:mm a").parse(time);
  return TimeOfDay.fromDateTime(dateTime);
}
