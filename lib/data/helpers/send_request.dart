import 'dart:convert';

import 'package:app_packdelivery/data/helpers/http_method.dart';
import 'package:http/http.dart';

dynamic _parseBody(dynamic body){
  try{
   return  jsonEncode(body);
  } catch(_){
    return body;
  }

}

Future<Response> sendRequest({
  required Uri url,
  required HttpMethod method,
  required Map<String,String> headers,
  required dynamic body,
}){
  if(method != HttpMethod.get){
      final contentType = headers["Content-Type"];
      if(contentType == null || contentType.contains("application/json")){
        headers['Content-Type']="application/json; charset=UTF-8";
        body = _parseBody(body);
      }
  }
  switch(method){
    case HttpMethod.get:
      return get(url,headers:headers);
    case HttpMethod.post:
     return post(url,headers: headers,body: body);
    case HttpMethod.put:
      return put(url,headers: headers,body: body);
    case HttpMethod.patch:
      return patch(url,headers: headers,body: body);
    case HttpMethod.delete:
      return delete(url,headers: headers,body: body);
  }

}