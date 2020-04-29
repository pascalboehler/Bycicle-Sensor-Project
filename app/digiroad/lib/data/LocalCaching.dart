import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';

class LocalCaching {
  Future<bool> convertToCSV(List<List<dynamic>> data) async {
    // convert list to csv:
    String csvData = ListToCsvConverter().convert(data);
    // write data to file:
    var csvFile = new File('distanceData.csv');
    csvFile.readAsString().then((oldData) {
      oldData += csvData;
      csvFile.writeAsString(csvData).then((File file) {
        if (file != null) {
          print("${DateTime.now()}: Succeeded writing"); // log to cmd
          return true; // if succeed return true
        } else{
          return false;
        }
      });
    });
    return true;
  }
}
