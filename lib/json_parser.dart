import 'dart:convert';
import 'package:http/http.dart' as http;

class JsonParser {
  parseJson(String url) async {
    final uri = Uri.parse(url);
    final jsonData = await http.get(uri);
    return (jsonDecode(jsonData.body));
  }
}
