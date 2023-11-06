import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html;

class Mangalib {
  final _dio = Dio()
    ..options.baseUrl = 'https://mangalib.me'
    ..interceptors.add(LogInterceptor())
    ..httpClientAdapter = Http2Adapter(
      ConnectionManager(idleTimeout: Duration(seconds: 10)),
    );

    Future<String> parse(String slug) async {
      
      final response = await _dio.get('/');
      final document = html.parse(response.data.toString());

      final anchors = document.querySelectorAll('title');
      return anchors[0].text;
      
    }
    Future<Map> getInfoBySlug(String slug) async {
      
      final response = await _dio.get('/manga-short-info?slug=$slug'); // 404 if bad slug todo to implement
      return response.data;

      
    }
    
}