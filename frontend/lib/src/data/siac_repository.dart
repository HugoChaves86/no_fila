import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:no_fila/src/models/siac.dart';

class SiacRepository {
  final Dio dio;
  final _baseUrl = 'http://localhost:8080';
  final _path = '/siac_proof_of_registration';

  SiacRepository({required this.dio});

  Future<UsuarioSiac> loginSiac(String cpf, String senha) async {
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
      Map<String, dynamic> json = jsonDecode(response.data);
      return UsuarioSiac.fromJson(json);
    } else {
      throw Exception('Erro ao conectar com o SIAC');
    }
  }
}
