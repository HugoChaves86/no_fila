import 'package:dio/dio.dart';

class SiacRepository {
  final Dio dio = Dio();
  final _baseUrl = 'http://localhost:8000';
  final _path = '/siac_proof_of_registration';

  Future<String> loginSiac(String cpf, String senha) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await dio.post(
      _baseUrl + _path,
      options: Options(headers: headers),
      data: {
        'cpf': cpf,
        'senha': senha,
      },
    );

    if (response.statusCode == 200) {
      return response.data.toString();
    } else {
      throw Exception(response.data['detail'] ?? 'Erro desconhecido');
    }
  }
}
