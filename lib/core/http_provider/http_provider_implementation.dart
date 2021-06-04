import 'dart:convert';
import 'dart:io';

import 'package:catalogmarvellucas/core/consts/api_consts.dart';
import 'package:catalogmarvellucas/core/errors/http_errors.dart';
import 'package:catalogmarvellucas/core/http_provider/http_provider.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart';
import 'package:crypto/crypto.dart' as crypto;

class HttpProviderImplementation implements HttpProvider {
  @override
  Future fetch(String url, Map<String, dynamic>? parametros) async {
    var result;
    try {
      final defaultParameters = _getDefaultParameters(parametros);
      final urlCompleta = Uri.https(ApiConsts.baseUrl, url, defaultParameters);
      final response = await get(urlCompleta);
      result = _response(response);
    } on SocketException {
      throw FetchDataException('Sem conexão com a internet');
    } on Exception {
      throw FetchDataException('Erro não identificado');
    }
    return result;
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 400:
        throw BadRequestException(response.body);
      case 401:
        throw UnauthorisedException(response.body);
      case 403:
        throw UnauthorisedException(response.body);
      case 500:
        throw BadRequestException(response.body);
      default:
        throw FetchDataException(
          'Ocorreu um erro durante a comunicação com o servidor',
        );
    }
  }

  Map<String, String> _gerarParametrosEspeciais() {
    final agoraEmMilisegundos =
        DateTime.now().microsecondsSinceEpoch.toString();
    return {
      'apikey': ApiConsts.apiKeyPublica,
      'ts': agoraEmMilisegundos,
      'hash': _gerarMd5Hash(
          '$agoraEmMilisegundos${ApiConsts.apikeyPrivada}${ApiConsts.apiKeyPublica}')
    };
  }

  String _gerarMd5Hash(String data) {
    return HEX.encode(crypto.md5.convert(Utf8Encoder().convert(data)).bytes);
  }

  Map<String, dynamic> _getDefaultParameters(Map<String, dynamic>? parametros) {
    final parametrosAuth = _gerarParametrosEspeciais();
    if (parametros != null) {
      parametros.addAll(parametrosAuth);
    } else {
      parametros = parametrosAuth;
    }
    return parametros;
  }
}
