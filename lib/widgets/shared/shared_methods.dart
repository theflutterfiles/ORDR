String getInitial({String string, int limitTo}) {
  var buffer = StringBuffer();
  var split = string.split(' ');
  for (var i = 0; i < (limitTo ?? split.length); i++) {
    buffer.write(split[i][0]);
  }
  return buffer.toString().toUpperCase();
}

int getDaysUntilCompletion(DateTime date) {
  int diff = date.difference(DateTime.now()).inDays;
  if (diff < 0) {
    diff = 0;
  }
  return diff;
}
