import 'package:hos_mobile2/backend/api_requests/api_calls.dart';

import '../backend/pubilc_.dart';
import '../custom_code/actions/notifica.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ConnextEmailYesNoWidget extends StatefulWidget {
  String userId;
  String groupId;
  String inviteId;
  bool approve;
  ConnextEmailYesNoWidget(
      {Key? key,
      required this.userId,
      required this.groupId,
      required this.inviteId,
      required this.approve})
      : super(key: key);

  @override
  _ConnextEmailYesNoWidgetState createState() =>
      _ConnextEmailYesNoWidgetState();
}

class _ConnextEmailYesNoWidgetState extends State<ConnextEmailYesNoWidget> {
  putInvite(
      {required String groupId,
      required String userId,
      required bool approve,
      required String id}) async {
    try {
      final tt = {
        "groupId": groupId,
        "userId": userId,
        "approve": approve,
        "id": id
      };
      print(tt.runtimeType);
      print("555");
      final res = await http.put(Uri.parse("$url/api/invite/apporve"),
          headers: {
            // 'Accept': 'application/json',
            'content-type': 'application/json',
            'Access-Control_Allow_Origin': '*',
            'x-access-token': '${FFAppState().tokenStore}'
          },
          body: jsonEncode(<String, dynamic>{
            "groupId": groupId,
            "userId": userId,
            "apporve": approve,
            "id": id
          }));
      print("555555 ${res.statusCode} ${res.body}");
      if (res.statusCode == 200) {
        await notifica(context, "อนุญาติสำเร็จ");
      } else {
        await notifica(context, "อนุญาติไม่สำเร็จ");
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'คุณต้องการเข้ากลุ่มใช้หรือไหม',
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Mitr',
                color: FlutterFlowTheme.of(context).primaryBlack,
              ),
        ),
        SvgPicture.asset(
          'assets/images/email.svg',
          width: 24,
          height: 19,
          fit: BoxFit.cover,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
                putInvite(
                    approve: true,
                    groupId: "${widget.groupId}",
                    userId: "${widget.userId}",
                    id: "${widget.inviteId}");
                // final statainvitecall = await PutInviteCall.call(
                //     groupId: "${widget.groupId}",
                //     userId: "${widget.userId}",
                //     approve: true,
                //     token: FFAppState().tokenStore);
                // print("stata ${statainvitecall.statusCode}");
                // if (statainvitecall.statusCode == 200) {
                //   print("${PutInviteCall.resState(statainvitecall.jsonBody)}");
                //   await notifica(context, "อนุญาติสำเร็จ");
                // } else {
                //   await notifica(context, "อนุญาติไม่สำเร็จ");
                // }
                if (mounted) {
                  setState(() {});
                }
                Navigator.pop(context);
              },
              child: Text(
                'ใช้',
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Mitr',
                      color: FlutterFlowTheme.of(context).primaryBlue,
                    ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'ไม่ใช้',
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Mitr',
                      color: FlutterFlowTheme.of(context).primaryRed,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
