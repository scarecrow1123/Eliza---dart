library eliza;

import 'dart:io';
import 'dart:math';
import 'converter.dart';

class Eliza {

  var responseKeys;
  var responseValues;
  Converter converter = new Converter();

  Eliza() {
    responseKeys = converter.responseTable.map( (x) => new RegExp(x[0], caseSensitive:false) );
    responseValues = converter.responseTable.map( (x) => x[1] );
  }

  String translate (String str, Map dict) {
    var words = str.toLowerCase().split(" ");
    for (int i = 0; i < words.length; i++) {
      if (dict.containsKey(words[i])) {
        words[i] = dict[words[i]];
      }
    }
    return words.join(" ");
  }

  String respond (String str) {
    for (int i = 0; i < responseKeys.length; i++) {
      var key = responseKeys.elementAt(i);
      if (key.hasMatch(str)) {
        var rand = new Random().nextInt(responseValues.elementAt(i).length-1);
        var resp = responseValues.elementAt(i).elementAt(rand);
        var pos = resp.indexOf("%");
        while (pos > -1) {
          var num = int.parse(resp.substring(pos+1, pos+2));
          resp = resp.substring(0, pos) + translate(key.firstMatch(str).group(num), converter.viewPointTable) + resp.substring(pos+2, resp.length-1);
          pos = resp.indexOf("%");
        }
        if (resp.substring(resp.length-3, resp.length-1) == "?.") {
          resp = resp.substring(0, resp.length-3) + ".";
        }
        if (resp.substring(resp.length-3, resp.length-1) == "??") {
          resp = resp.substring(0, resp.length-3) + "?";
        }
        return resp;
      }
    }
  }
}