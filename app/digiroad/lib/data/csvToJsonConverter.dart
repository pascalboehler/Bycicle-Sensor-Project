import 'dart:async';

class csvToJsonConvert {

  // function for conversion from csv string to json
  // add data model as ; separated string
  String csvTojson(String csv, String datamodel) {
    var datatype = new List();
    while (datamodel != "") {
      datatype.add(datamodel.split(";"));
    }
    print(datatype);
    return "Hallo";
  }

}