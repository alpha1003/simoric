import 'dart:convert';
import 'package:http/http.dart' as http;

class MensajeProvider {
  String _url = "https://www.onurix.com/api/v1/send-sms?";
  String _key = "8e2225dae8abd67f715191e96c816d7a5a482609608d5be6652a3";
  int _client = 2031;

  Future<String> enviarSms(String telefono, String mensaje) async {
    final data = {
      "key": _key,
      "client": _client,
      "phone": telefono,
      "sms": mensaje,
      "country-code": "CO",
    };

    String dir = "key=$_key" +
        "&client=$_client" +
        "&sms=$mensaje" +
        "&phone=$telefono" +
        "&country-code=CO";

    //final res = await http.post();

    final res = await http.post(_url + dir);

    Map<String, dynamic> result = json.decode(res.body);

    if (result.containsKey("error")) {
      print("Error: " + result['msg']);
      return "Error: " + result['msg'];
    } else {
      return "La alerta fue enviada con éxito";
    }
  }

  Future<String> llamar(String telefono, String mensaje) async {
    int retries = 2;
    String url = "https://www.onurix.com/api/v1/call/send?";

    String dir = "key=$_key" +
        "&client=$_client" +
        "&phone=57$telefono" +
        "&message=$mensaje" +
        "&voice=Mariana" +
        "&retries=$retries" +
        "&country-code=CO";

    final res = await http.post(url + dir);

    Map<String, dynamic> result = json.decode(res.body);

    if (result.containsKey("error")) {
      print("Error: " + result['msg']);
      return "Error: " + result['msg'];
    } else {
      return "La llamada fue enviada con éxito";
    }
  }
}
