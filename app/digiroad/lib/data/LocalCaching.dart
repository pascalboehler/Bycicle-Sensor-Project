import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

class LocalCaching {
  static void convertToCSV(List<List<dynamic>> data) async {
    // convert list to csv:
    String csvData = ListToCsvConverter().convert(data);
    // write data to file:
    Directory localDir = await getApplicationDocumentsDirectory();
    var csvFile = new File(localDir.path + '/distanceData.csv');
    if(await csvFile.exists()) {
      print("File exists");
      csvFile.readAsString().then((oldData) {
        //oldData += csvData;
        //print(oldData);
        csvFile.writeAsString(csvData + '\r\n', mode: FileMode.append).then((File file) {
          if (file != null) {
            print("${DateTime.now()}: Succeeded writing"); // log to cmd
            return true; // if succeed return true
          } else{
            return false;
          }
        });
      });
    } else {
      print("File does not exists");
      csvFile.writeAsString(csvData, mode: FileMode.append).then((File file) {
        if (file != null) {
          print("${DateTime.now()}: Succeeded writing"); // log to cmd
        } else{
        }
      });
    }
  }

  static void exportCSVFile() async {

  }
}
