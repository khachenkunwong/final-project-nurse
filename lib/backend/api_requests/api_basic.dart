// import 'package:hos_mobile2/model/present_model.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;

// import '../pubilc_.dart';

// class ApiCall {
//   static Future<PresentModel> getPresentModel({required String token,required String nameGroup}) async {
//     try {
//       final res = await http.get(
//         Uri.parse("$url/api/group/schedule/me/all/$nameGroup"),
//         headers: {
//           "Accept": "application/json",
//           "Access-Control_Allow_Origin": "*",
//           "x-access-token": "$token"
//         },
//       );
//       print("res.body ${res.body}");
//       // final body = convert.json.decode(res.body);
//       final data = convert.jsonDecode(res.body) as Map<String, dynamic>;

//       // for (var dutylist in body) {
//       //   final _dutylist = PresentModel.fromJson(dutylist);

//       //   print(_dutylist);

//       var data2 = PresentModel.fromJson(data);
//       // }

//       return data2;
//     } catch (e) {
//       print(e);
//     }
//     return PresentModel.fromJson(
//         {"error": "ไม่ส่งค่าภายในแอปไม่ได้เกียวกับหลังบ้าน"});
//   }
// }
