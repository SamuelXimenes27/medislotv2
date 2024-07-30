import 'package:http/http.dart';
import 'package:medislot/data/data.dart';
import 'package:medislot/infra/http/http.dart';

HttpClient makeHttpAdapter() => HttpAdapter(Client());
