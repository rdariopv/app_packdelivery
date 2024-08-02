import 'dart:convert';

parseResponseBody(String respondBody){
  try{
     return jsonEncode(respondBody);
  }catch(_){
     return respondBody;
  }
}