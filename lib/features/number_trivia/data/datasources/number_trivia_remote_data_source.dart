import 'dart:convert';

import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart ' as http;

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource{
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async{
     final response = await client.get(Uri.parse('http://numbersapi.com/$number'),
       headers: {'Content-Type': 'application/json'},);
     if(response.statusCode == 200){
       return NumberTriviaModel.fromJson(jsonDecode(response.body));
     }else {
       throw ServerException();
     }
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    final response = await client.get(Uri.parse('http://numbersapi.com/random'),
    headers: {'Content-Type' : 'application/json'},);
    if(response.statusCode == 200){
      return NumberTriviaModel.fromJson(jsonDecode(response.body));
    }else {
      throw ServerException();
    }
  }


}
