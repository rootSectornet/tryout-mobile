import 'package:TesUjian/src/response/finishTryoutDetail.dart';
import 'package:TesUjian/src/response/tryoutDetailPondok.dart';
import 'package:TesUjian/src/response/tryoutGetResponse.dart';
import 'package:TesUjian/src/response/tryoutSoalPsikotes.dart';
import 'package:TesUjian/src/response/tryoutdetail.dart';
import 'package:TesUjian/src/response/tryoutinfo.dart';
import 'package:TesUjian/src/response/tryoutsoal.dart';
import 'package:http/http.dart' show Client, MultipartRequest;
// ignore: unused_import
import 'package:TesUjian/helper/paths.dart';
// ignore: unused_import
import 'dart:convert';

class TryoutApi {
  Client _client = new Client();
  Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  // ignore: missing_return
  Future<int> saveTryout(Map<String, String> data) async {
    final response = await _client
        .post("${Paths.BASEURL}${Paths.ENDPOINT_TRYOUT}", body: data);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(res);
      print("ENDPOINT_TRYOUT");
      if (res['success']) {
        return res['data'];
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet kamu error!");
    }
  }

  // ignore: missing_return
  Future<TryoutGetResponse> checkTryout(
      int idMurid, int idJenjang, int idPaket) async {
    final response = await _client.get(
        "${Paths.BASEURL}${Paths.ENDPOINT_TRYOUT}?id_murid=$idMurid&id_jenjang=$idJenjang&id_paket=$idPaket&offset=0&limit=123");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(res);
      print("ENDPOINT_TRYOUT");
      if (res['success']) {
        TryoutGetResponse tryoutGetResponse =
            TryoutGetResponse.fromJson(json.decode(response.body));
        return tryoutGetResponse;
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet kamu error!");
    }
  }

  // ignore: missing_return
  Future<TryoutDetailResponse> getMatpels(int id) async {
    print("idnya" + id.toString());
    final response = await _client
        .get("${Paths.BASEURL}${Paths.ENDPOINT_TRYOUT_MATPELS}?id_tryout=$id");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(res);
      print("ENDPOINT_TRYOUT_MATPELS");
      if (res['success']) {
        TryoutDetailResponse tryoutDetailResponse =
            TryoutDetailResponse.fromJson(json.decode(response.body));
        return tryoutDetailResponse;
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<TryoutDetailPondokResponse> getMatpelPondoks(int id) async {
    print("idnya" + id.toString());
    final response = await _client.get(
        "${Paths.BASEURL}${Paths.ENDPOINT_TRYOUT_MATPELS_PONDOK}?id_tryout=$id");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(res);
      print("ENDPOINT_TRYOUT_MATPELS_PONDOK");
      if (res['success']) {
        TryoutDetailPondokResponse tryoutDetailPondokResponse =
            TryoutDetailPondokResponse.fromJson(json.decode(response.body));
        return tryoutDetailPondokResponse;
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<FinishTryoutDetail> checkmatpel(
      int idTryout, int idTryoutDetail) async {
    final response = await _client.get(
        "${Paths.BASEURL}${Paths.ENDPOINT_CHECK_MATPELS_STATUS}/$idTryout?id_tryoutDetail=$idTryoutDetail");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      // print(res);
      print("ENDPOINT_CHECK_MATPELS_STATUS");
      if (res['success']) {
        FinishTryoutDetail finishTryoutDetail =
            FinishTryoutDetail.fromJson(json.decode(response.body));
        return finishTryoutDetail;
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<TryoutInfoResponse> getInfo(int id) async {
    final response = await _client
        .get("${Paths.BASEURL}${Paths.ENDPOINT_TRYOUT_INFO}?id=$id");
    print(id);
    print(response.body);
    print("getInfo");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(id);
      print(res);
      print("getInfo");
      if (res['success']) {
        TryoutInfoResponse tryoutInfoResponse =
            TryoutInfoResponse.fromJson(json.decode(response.body));
        return tryoutInfoResponse;
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<TryoutSoalResponse> getSoal(
      // ignore: non_constant_identifier_names
      int id_matpel,
      // ignore: non_constant_identifier_names
      int id_tryout_detail) async {
    try {
      final response = await _client.get(
          "${Paths.BASEURL}${Paths.ENDPOINT_TRYOUT_SOAL}?id_matpel=$id_matpel&id_tryout_detail=$id_tryout_detail");
      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        print("getSoal");
        if (res['success']) {
          TryoutSoalResponse tryoutSoalResponse =
              TryoutSoalResponse.fromJson(json.decode(response.body));
          return tryoutSoalResponse;
        } else {
          Future.error("${res['data']}");
        }
      } else {
        Future.error("Yah, Internet Kamu error!");
      }
    } catch (err) {
      print(err);
      print("sdsdsd");
      Future.error(err.toString());
    }
  }

  // ignore: missing_return
  Future<TryoutSoalPsikotes> getSoalPsikotes(
      // ignore: non_constant_identifier_names
      int id_tryout_detail) async {
    try {
      print(id_tryout_detail);
      final response = await _client.get(
          "${Paths.BASEURL}${Paths.PSIKOTES_SOAL}?id_tryout=$id_tryout_detail");
      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        print("getSoal");
        if (res['success']) {
          TryoutSoalPsikotes tryoutSoalPsikotes =
              TryoutSoalPsikotes.fromJson(json.decode(response.body));
          return tryoutSoalPsikotes;
        } else {
          Future.error("${res['data']}");
        }
      } else {
        Future.error("Yah, Internet Kamu error!");
      }
    } catch (err) {
      print(err);
      print("sdsdsd");
      Future.error(err.toString());
    }
  }

  // ignore: missing_return
  Future<TryoutSoalPsikotes> getSoalBacaQuran(
      // ignore: non_constant_identifier_names
      int id_tryout_detail) async {
    try {
      print(id_tryout_detail);
      final response = await _client.get(
          "${Paths.BASEURL}${Paths.BACAQURAN_SOAL}?id_tryout=$id_tryout_detail");
      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        print("getSoal");
        if (res['success']) {
          TryoutSoalPsikotes tryoutSoalPsikotes =
              TryoutSoalPsikotes.fromJson(json.decode(response.body));
          return tryoutSoalPsikotes;
        } else {
          Future.error("${res['data']}");
        }
      } else {
        Future.error("Yah, Internet Kamu error!");
      }
    } catch (err) {
      print(err);
      print("sdsdsd");
      Future.error(err.toString());
    }
  }

  // ignore: missing_return
  Future<TryoutSoalPsikotes> getSoalAmmaliyah(
      // ignore: non_constant_identifier_names
      int id_tryout_detail) async {
    try {
      print(id_tryout_detail);
      final response = await _client.get(
          "${Paths.BASEURL}${Paths.AMMALIYAH_SOAL}?id_tryout=$id_tryout_detail");
      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        print("getSoal");
        if (res['success']) {
          TryoutSoalPsikotes tryoutSoalPsikotes =
              TryoutSoalPsikotes.fromJson(json.decode(response.body));
          return tryoutSoalPsikotes;
        } else {
          Future.error("${res['data']}");
        }
      } else {
        Future.error("Yah, Internet Kamu error!");
      }
    } catch (err) {
      print(err);
      print("sdsdsd");
      Future.error(err.toString());
    }
  }

  // ignore: missing_return
  Future<TryoutSoalPsikotes> getSoalQoliyah(
      // ignore: non_constant_identifier_names
      int id_tryout_detail) async {
    try {
      print(id_tryout_detail);
      final response = await _client.get(
          "${Paths.BASEURL}${Paths.QOLIYAH_SOAL}?id_tryout=$id_tryout_detail");
      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        print("getSoal");
        if (res['success']) {
          TryoutSoalPsikotes tryoutSoalPsikotes =
              TryoutSoalPsikotes.fromJson(json.decode(response.body));
          return tryoutSoalPsikotes;
        } else {
          Future.error("${res['data']}");
        }
      } else {
        Future.error("Yah, Internet Kamu error!");
      }
    } catch (err) {
      print(err);
      print("sdsdsd");
      Future.error(err.toString());
    }
  }

  // ignore: missing_return
  Future<TryoutSoalPsikotes> getSoalHafalanJuz(
      // ignore: non_constant_identifier_names
      int id_tryout_detail) async {
    try {
      print(id_tryout_detail);
      final response = await _client.get(
          "${Paths.BASEURL}${Paths.HAFALANJUZ_SOAL}?id_tryout=$id_tryout_detail");
      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        print("getSoal");
        if (res['success']) {
          TryoutSoalPsikotes tryoutSoalPsikotes =
              TryoutSoalPsikotes.fromJson(json.decode(response.body));
          return tryoutSoalPsikotes;
        } else {
          Future.error("${res['data']}");
        }
      } else {
        Future.error("Yah, Internet Kamu error!");
      }
    } catch (err) {
      print(err);
      print("sdsdsd");
      Future.error(err.toString());
    }
  }

  // ignore: missing_return
  Future<TryoutSoalPsikotes> getSoalHukumTajwids(
      // ignore: non_constant_identifier_names
      int id_tryout_detail) async {
    try {
      print(id_tryout_detail);
      final response = await _client.get(
          "${Paths.BASEURL}${Paths.HUKUMTAJWIDS_SOAL}?id_tryout=$id_tryout_detail");
      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        print("getSoal");
        if (res['success']) {
          TryoutSoalPsikotes tryoutSoalPsikotes =
              TryoutSoalPsikotes.fromJson(json.decode(response.body));
          return tryoutSoalPsikotes;
        } else {
          Future.error("${res['data']}");
        }
      } else {
        Future.error("Yah, Internet Kamu error!");
      }
    } catch (err) {
      print(err);
      print("sdsdsd");
      Future.error(err.toString());
    }
  }

  // ignore: missing_return
  Future<TryoutSoalPsikotes> getSoalBerhitungSoal(
      // ignore: non_constant_identifier_names
      int id_tryout_detail) async {
    try {
      print(id_tryout_detail);
      final response = await _client.get(
          "${Paths.BASEURL}${Paths.BERHITUNGSOAL_SOAL}?id_tryout=$id_tryout_detail");
      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        print("getSoal");
        if (res['success']) {
          TryoutSoalPsikotes tryoutSoalPsikotes =
              TryoutSoalPsikotes.fromJson(json.decode(response.body));
          return tryoutSoalPsikotes;
        } else {
          Future.error("${res['data']}");
        }
      } else {
        Future.error("Yah, Internet Kamu error!");
      }
    } catch (err) {
      print(err);
      print("sdsdsd");
      Future.error(err.toString());
    }
  }

  // ignore: missing_return
  Future<TryoutSoalPsikotes> getSoalBahasaIndonesia(
      // ignore: non_constant_identifier_names
      int id_tryout_detail) async {
    try {
      print(id_tryout_detail);
      final response = await _client.get(
          "${Paths.BASEURL}${Paths.BAHASAINDONESIA_SOAL}?id_tryout=$id_tryout_detail");
      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        print("getSoal");
        if (res['success']) {
          TryoutSoalPsikotes tryoutSoalPsikotes =
              TryoutSoalPsikotes.fromJson(json.decode(response.body));
          return tryoutSoalPsikotes;
        } else {
          Future.error("${res['data']}");
        }
      } else {
        Future.error("Yah, Internet Kamu error!");
      }
    } catch (err) {
      print(err);
      print("sdsdsd");
      Future.error(err.toString());
    }
  }

  // ignore: missing_return
  Future<TryoutSoalPsikotes> getSoalBerhitungAngka(
      // ignore: non_constant_identifier_names
      int id_tryout_detail) async {
    try {
      print(id_tryout_detail);
      final response = await _client.get(
          "${Paths.BASEURL}${Paths.BERHITUNGANGKA_SOAL}?id_tryout=$id_tryout_detail");
      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        print("getSoal");
        if (res['success']) {
          TryoutSoalPsikotes tryoutSoalPsikotes =
              TryoutSoalPsikotes.fromJson(json.decode(response.body));
          return tryoutSoalPsikotes;
        } else {
          Future.error("${res['data']}");
        }
      } else {
        Future.error("Yah, Internet Kamu error!");
      }
    } catch (err) {
      print(err);
      print("sdsdsd");
      Future.error(err.toString());
    }
  }

  // ignore: missing_return
  Future<String> finishMatpel(int idTryoutDetail) async {
    // print('test');
    final response = await _client.post(
        "${Paths.BASEURL}${Paths.ENDPOINT_FINISH_MATPELS_STATUS}/$idTryoutDetail",
        headers: _headers);
    if (response.statusCode == 200) {
      return 'ok';
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<String> finishMatpelPsikotes(int idTryoutDetail) async {
    // print('test');
    final response = await _client.post(
        "${Paths.BASEURL}${Paths.ENDPOINT_FINISH_MATPELS_PSIKOTES_STATUS}/$idTryoutDetail",
        headers: _headers);
    if (response.statusCode == 200) {
      return 'ok';
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<String> finishTryout(int idTryout) async {
    // print('test');
    final response = await _client.post(
        "${Paths.BASEURL}${Paths.ENDPOINT_FINISH_TRYOUT_STATUS}/$idTryout",
        headers: _headers);
    if (response.statusCode == 200) {
      return 'ok';
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<bool> kumpulkan(Map<String, String> data) async {
    // print('test');
    var uri = Uri.parse("${Paths.BASEURL}${Paths.ENDPOINT_KUMPULKAN_V2}");
    var request = MultipartRequest('PUT', uri)..fields.addAll(data);
    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }
}
