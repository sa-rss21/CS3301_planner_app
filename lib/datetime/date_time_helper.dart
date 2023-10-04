//convert DateTime obj to string

String convert(DateTime time)
{
  String year = time.year.toString();
  String day = time.day.toString();
  if (day.length == 1){
    day = '0' + day;
  }
  String month = time.month.toString();
  if (month.length == 1){
    month = '0' + month;
  }
  return year + month + day;
}