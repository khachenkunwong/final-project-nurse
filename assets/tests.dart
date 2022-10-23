import 'package:hos_mobile2/model/saveduty_model.dart';

void main(List<String> args) {
//   String tt = "";
// List yy = [
//   "AAA:{\"id\": \"63517bc0270eff076b75e7c0\",\"userID\": \"63517bbd270eff076b75e78e\",\"year\": 2022,\"month\": 10,\"day\": 24,\"group\": \"new1\",\"v\": 0,\"dutyString\": \"morning\",\"dutyNumber\": 0}\"",
//   "BBB:",
//   "CCC:",
//   "VVV:",
// ];

// String yyy = """{"duty":"tttttttttttt"}""";
// Saveduty yyyy = Saveduty(nameGroup:"BBB",aaa:"$yyy");

// print(yyyy.toJson()["BBB"]);
// {วัน:{"ID user":[เช้า,บ่าย,ดึก]}}
  Map<int, Map<String, List<bool>>> ttt = {
    1: {
      "iduser": [false, false, false]
    }
  };
  print(ttt);
  ttt[1]!.addAll({
    "iduser1": [false, false, false]
  });
  print(ttt);
  ttt[1]!["iduser1"]![0] = true;
  // .addAll({

  //     "iduser1": [false, false, false]

  // });
  print(ttt);
}
