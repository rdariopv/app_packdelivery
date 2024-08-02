import 'http_method.dart';
import 'send_request.dart';

typedef Parser<T> = T Function(dynamic data);

class Http{
  final String baseUrl;

  Http({this.baseUrl=''});
  request<T>(
      String path,
      { HttpMethod method = HttpMethod.get,
        Map<String,String> headers= const{},
        Map<String,dynamic> queryParameters= const{},
        dynamic body,
        Parser<T>? parser,
      }) async{
          late Uri url;
          if(path.startsWith('http://') || path.startsWith('https://')){
            url=Uri.parse(path);
          }else{
            url=Uri.parse("$baseUrl$path");
          }

          if(queryParameters.isNotEmpty){
            url=url.replace(
              queryParameters: {
                ...url.queryParameters,
                ...queryParameters
              }
            );
          }
          final response = await sendRequest(url: url, method: method, headers: headers, body: body,);
  }
}