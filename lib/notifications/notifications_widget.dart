import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hos_mobile2/custom_code/actions/index.dart';

import '../backend/api_requests/api_calls.dart';
import '../backend/pubilc_.dart';
import '../components/connext_email_yes_no_widget.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import '../model/changduty_model_get.dart';
import '../model/changmyduty_model.dart';
import '../model/invite_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/leave_model.dart';
import '../model/present_model.dart';
import '../model/showleave_model.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({Key? key}) : super(key: key);

  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  DateTimeRange? calendarSelectedDay;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<InviteModel> futureInvite;
  late Future<List<Datum>> futureGetChangDuty;
  Future<List<DutyPresent>>? futurePresent;
  late String calendarSelectedDayString;
  late String calendarSelectedmonthString;
  late String calendarSelectedyearString;
  Map<String, bool> lordinvite = {};
  List dayDuty = ["เช้า", "บ่าย", "ดึก"];
  late String stoteDuty;
  late String stoteDuty2;
  late Future<List<DatumLeave>> futureleave;
  Map<String, bool> lordaddproveGroup = {};

  apporveLaeve({required String notificationId, required bool approve}) async {
    var headers = {
      'Authorization': '${FFAppState().tokenStore}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$url/graphql'));
    request.body =
        '''{"query":"mutation ApproveLeaveMember(\$input: ApproveLeaveMemberInput!) {\\r\\n  approveLeaveMember(input: \$input)\\r\\n}","variables":{"input":{"notificationId":"$notificationId","approve":$approve}}}''';
    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      await notifica(context, "สำเร็จ", color: Colors.green);
    } else {
      print(response.reasonPhrase);
      await notifica(
        context,
        "ไม่สำเร็จ",
      );
    }
  }

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
        await notifica(context, "ส่งคำขอสำเร็จ", color: Colors.green);
      } else {
        await notifica(context, "ส่งคำขอไม่สำเร็จ");
      }
    } catch (error) {
      print(error);
    }
  }

  Future<InviteModel> getInviteModel({required String token}) async {
    try {
      print(token);
      final res = await http.get(
        Uri.parse("$url/api/invite/invite"),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "$token"
        },
      );
      print("res.body1 ${res.statusCode}");
      print("res.body1 ${res.body}");

      final body = convert.json.decode(res.body) as Map<String, dynamic>;
      final futureInvite = InviteModel.fromJson(body);
      return futureInvite;
    } catch (error) {
      print(error);
    }
    return InviteModel();
  }

  Future<List<Datum>> getChangDutyModel() async {
    try {
      final res = await http.get(
        Uri.parse("$url/api/changduty/invite"),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "${FFAppState().tokenStore}"
        },
      );
      print("getChangDutyModel code ${res.statusCode}");
      print("getChangDutyModel  body${res.body}");

      final body = convert.json.decode(res.body) as Map<String, dynamic>;
      final _futureGetChangDuty = GetChangDuty.fromJson(body);
      final futureGetChangDuty = _futureGetChangDuty.data as List<Datum>;
      if (res.statusCode == 200) {
        await notifica(context, "แสดงข้อมูลสำเร็จ", color: Colors.green);
        return futureGetChangDuty;
      } else {
        await notifica(context, "แสดงข้อมูลไม่สำเร็จ");
      }
      // print("_futurePresent ${_futurePresent.duty}");
      // for (var dutylist in data) {
      //   // list ออกมาทั้ง index
      //   final _futurePresent =
      //       PresentModel.fromJson(dutylist as Map<String, dynamic>);
      //   // aa = _dutylist.duty!.first.day;
      //   // print("_dutylist ${aa}");
      //   setState(() {
      //     futurePresent.add(_futurePresent);
      //   });
      // }

    } catch (error) {
      print(error);
    }
    return [];
  }

  Future<List<DutyPresent>> getPresentModel({required String token}) async {
    try {
      print(token);
      final res = await http.get(
        Uri.parse("$url/api/schedule/me/present"),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "$token"
        },
      );
      print("res.body12 ${res.statusCode}");
      print("res.body12 ${res.body}");

      final body = convert.json.decode(res.body) as Map<String, dynamic>;
      final _futureMeAll = PresentModel.fromJson(body);
      final futureMeAll = _futureMeAll.duty as List<DutyPresent>;
      // print("_futurePresent ${_futurePresent.duty}");
      // for (var dutylist in data) {
      //   // list ออกมาทั้ง index
      //   final _futurePresent =
      //       PresentModel.fromJson(dutylist as Map<String, dynamic>);
      //   // aa = _dutylist.duty!.first.day;
      //   // print("_dutylist ${aa}");
      //   setState(() {
      //     futurePresent.add(_futurePresent);
      //   });
      // }
      return futureMeAll;
    } catch (error) {
      print(error);
    }
    return [];
  }

  // ยังไม่ได้ใช้ในนี้
  Future<List<DatumLeave>> getLeaveModel({required String token}) async {
    try {
      print(token);
      final res = await http.get(
        Uri.parse("$url/api/req/leader/take/leave"),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "$token"
        },
      );
      print("res.body3 ${res.statusCode}");
      print("res.body3 ${res.body}");

      final body = convert.json.decode(res.body) as Map<String, dynamic>;
      final _futureLeave = GetLeave.fromJson(body);
      final futureLeave = _futureLeave.data as List<DatumLeave>;
      if (res.statusCode == 200) {
        await notifica(context, "แสดงคำขอแล้ว", color: Colors.green);
        return futureLeave;
      } else {
        await notifica(context, "แสดงคำขอไม่สำเร็จ");
      }
      // print("_futurePresent ${_futurePresent.duty}");
      // for (var dutylist in data) {
      //   // list ออกมาทั้ง index
      //   final _futurePresent =
      //       PresentModel.fromJson(dutylist as Map<String, dynamic>);
      //   // aa = _dutylist.duty!.first.day;
      //   // print("_dutylist ${aa}");
      //   setState(() {
      //     futurePresent.add(_futurePresent);
      //   });
      // }
      return futureLeave;
    } catch (error) {
      print(error);
    }
    return [];
  }

  Future<void> _refresh() async {
    setState(() {
      futureInvite = getInviteModel(token: FFAppState().tokenStore);
      futurePresent = getPresentModel(token: FFAppState().tokenStore);
      futureGetChangDuty = getChangDutyModel();
    });
    return await Future.delayed(Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    futureInvite = getInviteModel(token: FFAppState().tokenStore);
    futurePresent = getPresentModel(token: FFAppState().tokenStore);
    futureGetChangDuty = getChangDutyModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     print('FloatingActionButton pressed ...');
      //   },
      //   backgroundColor: FlutterFlowTheme.of(context).primaryColor,
      //   icon: Icon(
      //     Icons.send,
      //     size: 35,
      //   ),
      //   elevation: 10,
      //   label: Container(),
      // ),
      body: SafeArea(
        child: Builder(builder: (context) {
          return LayoutBuilder(
            builder: (context, constraints) => RefreshIndicator(
              onRefresh: _refresh,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Query(
                        options: QueryOptions(
                            document: gql(shownotificationLeave),
                            variables: {
                              "filter": {"type": "LEAVE_DUTY"}
                            }),
                        builder: (QueryResult result, {fetchMore, refetch}) {
                          if (result.hasException) {
                            return Text(result.exception.toString());
                          }
                          if (result.isLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          // final productList = Welcome.fromJson(result.data as Map<String, dynamic>);
                          // print(productList);
                          final shownotificationLeave =
                              ShownotificationLeave.fromJson(result.data!)
                                  .notifications;
                          print("shownotificationLeave ${result.data}");
                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              // scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: shownotificationLeave!.length,
                              itemBuilder: (BuildContext context,
                                  int indexGetLeaveMyDuty) {
                                if (shownotificationLeave[indexGetLeaveMyDuty]
                                        .noift ==
                                    "1") {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.99,
                                      // height: 400,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 16, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/noti.svg',
                                                      width: 27.89,
                                                      height: 30.72,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16, 0, 0, 0),
                                                      child: Text(
                                                        "ขอลา",
                                                        style: GoogleFonts.mitr(
                                                          color:
                                                              Color(0xff727272),
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "วันนี้ 07:14 น.",
                                                  style: GoogleFonts.mitr(
                                                    color: Color(0xffbdbdbd),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 16, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "ขอลาโดย: ${shownotificationLeave[indexGetLeaveMyDuty].fields?.createdBy?.fristName} ${shownotificationLeave[indexGetLeaveMyDuty].fields?.createdBy?.lastName}",
                                                  style: GoogleFonts.mitr(
                                                    color: Color(0xff727272),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 16),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.89,
                                              // height: 280,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color(0xffececec),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "วันที่ ${shownotificationLeave[indexGetLeaveMyDuty].fields?.dutyId?.day}/${shownotificationLeave[indexGetLeaveMyDuty].fields?.dutyId?.month}/${shownotificationLeave[indexGetLeaveMyDuty].fields?.dutyId?.year}",
                                                          style:
                                                              GoogleFonts.mitr(
                                                            color: Color(
                                                                0xff727272),
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Card(
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryWhite,
                                                            elevation: 2,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          5,
                                                                          10,
                                                                          5),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: 56,
                                                                    height: 56,
                                                                    clipBehavior:
                                                                        Clip.antiAlias,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Image
                                                                        .network(
                                                                      'https://picsum.photos/seed/260/600',
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Text(
                                                                        '${shownotificationLeave[indexGetLeaveMyDuty].fields?.createdBy?.fristName}',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .title2,
                                                                      ),
                                                                      Text(
                                                                        ' ${shownotificationLeave[indexGetLeaveMyDuty].fields?.createdBy?.lastName}',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .title2,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Builder(builder:
                                                                      (context) {
                                                                    if (shownotificationLeave[indexGetLeaveMyDuty].fields?.shift?.morning !=
                                                                            null &&
                                                                        shownotificationLeave[indexGetLeaveMyDuty].fields?.shift?.morning ==
                                                                            1) {
                                                                      return Text(
                                                                        "เช้า",
                                                                        // IndexWithOutDay เพราะ กรองindexที่จะเข้ามา
                                                                        // '${dayDuty[IndexWithOutList]}',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .title2,
                                                                      );
                                                                    } else if (shownotificationLeave[indexGetLeaveMyDuty].fields?.shift?.morning !=
                                                                            null &&
                                                                        shownotificationLeave[indexGetLeaveMyDuty].fields?.shift?.morning ==
                                                                            0) {
                                                                      return Text(
                                                                        "เช้าว่าง",
                                                                        // IndexWithOutDay เพราะ กรองindexที่จะเข้ามา
                                                                        // '${dayDuty[IndexWithOutList]}',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .title2,
                                                                      );
                                                                    } else if (shownotificationLeave[indexGetLeaveMyDuty].fields?.shift?.noon !=
                                                                            null &&
                                                                        shownotificationLeave[indexGetLeaveMyDuty].fields?.shift?.noon ==
                                                                            1) {
                                                                      return Text(
                                                                        "บ่าย",
                                                                        // IndexWithOutDay เพราะ กรองindexที่จะเข้ามา
                                                                        // '${dayDuty[IndexWithOutList]}',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .title2,
                                                                      );
                                                                    } else if (shownotificationLeave[indexGetLeaveMyDuty].fields?.shift?.noon !=
                                                                            null &&
                                                                        shownotificationLeave[indexGetLeaveMyDuty].fields?.shift?.noon ==
                                                                            0) {
                                                                      return Text(
                                                                        "บ่ายว่าง",
                                                                        // IndexWithOutDay เพราะ กรองindexที่จะเข้ามา
                                                                        // '${dayDuty[IndexWithOutList]}',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .title2,
                                                                      );
                                                                    } else if (shownotificationLeave[indexGetLeaveMyDuty].fields?.shift?.night !=
                                                                            null &&
                                                                        shownotificationLeave[indexGetLeaveMyDuty].fields?.shift?.night ==
                                                                            1) {
                                                                      return Text(
                                                                        "ดึก",
                                                                        // IndexWithOutDay เพราะ กรองindexที่จะเข้ามา
                                                                        // '${dayDuty[IndexWithOutList]}',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .title2,
                                                                      );
                                                                    } else if (shownotificationLeave[indexGetLeaveMyDuty].fields?.shift?.night !=
                                                                            null &&
                                                                        shownotificationLeave[indexGetLeaveMyDuty].fields?.shift?.night ==
                                                                            0) {
                                                                      return Text(
                                                                        "ดึกว่าง",
                                                                        // IndexWithOutDay เพราะ กรองindexที่จะเข้ามา
                                                                        // '${dayDuty[IndexWithOutList]}',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .title2,
                                                                      );
                                                                    }
                                                                    return Text(
                                                                      "error",
                                                                      // IndexWithOutDay เพราะ กรองindexที่จะเข้ามา
                                                                      // '${dayDuty[IndexWithOutList]}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .title2,
                                                                    );
                                                                  }),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 9.50),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 15, 0, 15),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    apporveLaeve(
                                                        notificationId:
                                                            "${shownotificationLeave[indexGetLeaveMyDuty].id}",
                                                        approve: true);
                                                  },
                                                  child: Text(
                                                    'อนุมัติ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Mitr',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryColor,
                                                        ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    apporveLaeve(
                                                        notificationId:
                                                            "${shownotificationLeave[indexGetLeaveMyDuty].id}",
                                                        approve: false);
                                                  },
                                                  child: Text(
                                                    'ปฏิเสธ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Mitr',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryRed,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              });
                        }),

                    Query(
                        options: QueryOptions(
                            document: gql(changMyDutyGraphQL),
                            variables: {
                              "filter": {"type": "CHANGE_DUTY"}
                            }),
                        builder: (QueryResult result, {fetchMore, refetch}) {
                          if (result.hasException) {
                            return Text(result.exception.toString());
                          }
                          if (result.isLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          // final productList = Welcome.fromJson(result.data as Map<String, dynamic>);
                          // print(productList);
                          final getChangMyDuty =
                              ChangMyDuty.fromJson(result.data!).notifications!;

                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              // scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: getChangMyDuty.length,
                              itemBuilder: (BuildContext context,
                                  int indexGetChangMyDuty) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.99,
                                    // height: 400,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 16, 16, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/noti.svg',
                                                    width: 27.89,
                                                    height: 30.72,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 0, 0, 0),
                                                    child: Text(
                                                      "มีการเปลี่ยนแปลงเวร",
                                                      style: GoogleFonts.mitr(
                                                        color:
                                                            Color(0xff727272),
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "วันนี้ 07:14 น.",
                                                style: GoogleFonts.mitr(
                                                  color: Color(0xffbdbdbd),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 16, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "ชื่อกลุ่ม: ${getChangMyDuty[indexGetChangMyDuty].fields?.group?.nameGroup}",
                                                style: GoogleFonts.mitr(
                                                  color: Color(0xff727272),
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 0, 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "คนที่เปลี่ยนแปลง: ${getChangMyDuty[indexGetChangMyDuty].approveBy?.fristName} ${getChangMyDuty[indexGetChangMyDuty].approveBy?.lastName}",
                                                style: GoogleFonts.mitr(
                                                  color: Color(0xff727272),
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 16),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.89,
                                            // height: 280,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color(0xffececec),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "วันที่ ${getChangMyDuty[indexGetChangMyDuty].fields?.prev?.day}/${getChangMyDuty[indexGetChangMyDuty].fields?.prev?.month}/${getChangMyDuty[indexGetChangMyDuty].fields?.prev?.year}",
                                                        style: GoogleFonts.mitr(
                                                          color:
                                                              Color(0xff727272),
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Card(
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryWhite,
                                                          elevation: 2,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10,
                                                                        5,
                                                                        10,
                                                                        5),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: 56,
                                                                  height: 56,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    'https://picsum.photos/seed/260/600',
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Text(
                                                                      '${getChangMyDuty[indexGetChangMyDuty].user?.fristName}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .title2,
                                                                    ),
                                                                    Text(
                                                                      ' ${getChangMyDuty[indexGetChangMyDuty].user?.lastName}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .title2,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  "ว่างบ่าย",
                                                                  // IndexWithOutDay เพราะ กรองindexที่จะเข้ามา
                                                                  // '${dayDuty[IndexWithOutList]}',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .title2,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 9.50),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .arrow_downward_outlined,
                                                        size: 20,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 9.50),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Card(
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryWhite,
                                                          elevation: 2,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10,
                                                                        5,
                                                                        10,
                                                                        5),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: 56,
                                                                  height: 56,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    'https://picsum.photos/seed/260/600',
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Text(
                                                                      '${getChangMyDuty[indexGetChangMyDuty].user?.fristName}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .title2,
                                                                    ),
                                                                    Text(
                                                                      ' ${getChangMyDuty[indexGetChangMyDuty].user?.lastName}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .title2,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  "บ่าย",
                                                                  // IndexWithOutDay เพราะ กรองindexที่จะเข้ามา
                                                                  // '${dayDuty[IndexWithOutList]}',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .title2,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }),

                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.99,
                    //   color: Colors.white,
                    //   child: Column(
                    //     children: [
                    //       Padding(
                    //         padding:
                    //             EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    //         child: Row(
                    //           mainAxisSize: MainAxisSize.max,
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 SvgPicture.asset(
                    //                   'assets/images/noti.svg',
                    //                   width: 27.89,
                    //                   height: 30.72,
                    //                   fit: BoxFit.cover,
                    //                 ),
                    //                 Padding(
                    //                   padding: EdgeInsetsDirectional.fromSTEB(
                    //                       16, 0, 0, 0),
                    //                   child: Text(
                    //                     "มีการเปลี่ยนแปลงเวร",
                    //                     style: GoogleFonts.mitr(
                    //                       color: Color(0xff727272),
                    //                       fontSize: 18,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Text(
                    //               "วันนี้ 07:14 น.",
                    //               style: GoogleFonts.mitr(
                    //                 color: Color(0xffbdbdbd),
                    //                 fontSize: 14,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.all(16.0),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               "ชื่อกลุ่ม: โรงพยาบาลบ้านดุง",
                    //               style: GoogleFonts.mitr(
                    //                 color: Color(0xff727272),
                    //                 fontSize: 16,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Container(
                    //         width: MediaQuery.of(context).size.width * 0.95,
                    //         height: 280,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(10),
                    //           color: Color(0xffececec),
                    //         ),
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(16.0),
                    //           child: Column(
                    //             mainAxisSize: MainAxisSize.max,
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Column(
                    //                 mainAxisSize: MainAxisSize.max,
                    //                 mainAxisAlignment: MainAxisAlignment.start,
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text(
                    //                     "วันที่ 11/10/2565",
                    //                     style: GoogleFonts.mitr(
                    //                       color: Color(0xff727272),
                    //                       fontSize: 16,
                    //                     ),
                    //                   ),
                    //                   Container(
                    //                     child: Card(
                    //                       clipBehavior:
                    //                           Clip.antiAliasWithSaveLayer,
                    //                       color: FlutterFlowTheme.of(context)
                    //                           .secondaryWhite,
                    //                       elevation: 2,
                    //                       shape: RoundedRectangleBorder(
                    //                         borderRadius:
                    //                             BorderRadius.circular(10),
                    //                       ),
                    //                       child: Padding(
                    //                         padding:
                    //                             EdgeInsetsDirectional.fromSTEB(
                    //                                 10, 5, 10, 5),
                    //                         child: Row(
                    //                           mainAxisSize: MainAxisSize.max,
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment
                    //                                   .spaceBetween,
                    //                           children: [
                    //                             Container(
                    //                               width: 56,
                    //                               height: 56,
                    //                               clipBehavior: Clip.antiAlias,
                    //                               decoration: BoxDecoration(
                    //                                 shape: BoxShape.circle,
                    //                               ),
                    //                               child: Image.network(
                    //                                 'https://picsum.photos/seed/260/600',
                    //                               ),
                    //                             ),
                    //                             Row(
                    //                               mainAxisSize:
                    //                                   MainAxisSize.max,
                    //                               children: [
                    //                                 Text(
                    //                                   'นาย Anohan',
                    //                                   style:
                    //                                       FlutterFlowTheme.of(
                    //                                               context)
                    //                                           .title2,
                    //                                 ),
                    //                                 Text(
                    //                                   ' kai',
                    //                                   style:
                    //                                       FlutterFlowTheme.of(
                    //                                               context)
                    //                                           .title2,
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                             Text(
                    //                               "ว่างบ่าย",
                    //                               // IndexWithOutDay เพราะ กรองindexที่จะเข้ามา
                    //                               // '${dayDuty[IndexWithOutList]}',
                    //                               style: FlutterFlowTheme.of(
                    //                                       context)
                    //                                   .title2,
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               SizedBox(height: 9.50),
                    //               Row(
                    //                 mainAxisSize: MainAxisSize.max,
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.center,
                    //                 children: [
                    //                   Icon(
                    //                     Icons.arrow_downward_outlined,
                    //                     size: 20,
                    //                     color: Colors.black,
                    //                   ),
                    //                 ],
                    //               ),
                    //               SizedBox(height: 9.50),
                    //               Column(
                    //                 mainAxisSize: MainAxisSize.max,
                    //                 mainAxisAlignment: MainAxisAlignment.start,
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text(
                    //                     "วันที่ 11/10/2565",
                    //                     style: GoogleFonts.mitr(
                    //                       color: Color(0xff727272),
                    //                       fontSize: 16,
                    //                     ),
                    //                   ),
                    //                   Container(
                    //                     child: Card(
                    //                       clipBehavior:
                    //                           Clip.antiAliasWithSaveLayer,
                    //                       color: FlutterFlowTheme.of(context)
                    //                           .secondaryWhite,
                    //                       elevation: 2,
                    //                       shape: RoundedRectangleBorder(
                    //                         borderRadius:
                    //                             BorderRadius.circular(10),
                    //                       ),
                    //                       child: Padding(
                    //                         padding:
                    //                             EdgeInsetsDirectional.fromSTEB(
                    //                                 10, 5, 10, 5),
                    //                         child: Row(
                    //                           mainAxisSize: MainAxisSize.max,
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment
                    //                                   .spaceBetween,
                    //                           children: [
                    //                             Container(
                    //                               width: 56,
                    //                               height: 56,
                    //                               clipBehavior: Clip.antiAlias,
                    //                               decoration: BoxDecoration(
                    //                                 shape: BoxShape.circle,
                    //                               ),
                    //                               child: Image.network(
                    //                                 'https://picsum.photos/seed/260/600',
                    //                               ),
                    //                             ),
                    //                             Row(
                    //                               mainAxisSize:
                    //                                   MainAxisSize.max,
                    //                               children: [
                    //                                 Text(
                    //                                   'นาย Anohan',
                    //                                   style:
                    //                                       FlutterFlowTheme.of(
                    //                                               context)
                    //                                           .title2,
                    //                                 ),
                    //                                 Text(
                    //                                   ' kai',
                    //                                   style:
                    //                                       FlutterFlowTheme.of(
                    //                                               context)
                    //                                           .title2,
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                             Text(
                    //                               "บ่าย",
                    //                               // IndexWithOutDay เพราะ กรองindexที่จะเข้ามา
                    //                               // '${dayDuty[IndexWithOutList]}',
                    //                               style: FlutterFlowTheme.of(
                    //                                       context)
                    //                                   .title2,
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding:
                    //             EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                    //         child: Row(
                    //           mainAxisSize: MainAxisSize.max,
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: [
                    //             InkWell(
                    //               onTap: () async {
                    //                 // try {
                    //                 //   final getState =
                    //                 //       await updateChangdutyCall.call(
                    //                 //           token: FFAppState()
                    //                 //               .tokenStore,
                    //                 //           apporve: true,
                    //                 //           chagnId:
                    //                 //               '${snapshot.data![indexgetInvite].id}');
                    //                 //   if (getState
                    //                 //           .statusCode ==
                    //                 //       200) {
                    //                 //     print(
                    //                 //         "getstata ${getState.jsonBody}");
                    //                 //     await notifica(
                    //                 //         context,
                    //                 //         "ส่งคำขอสำเร็จ",
                    //                 //         color:
                    //                 //             Colors.green);
                    //                 //   } else {
                    //                 //     print(
                    //                 //         "getstata ${getState.jsonBody}");
                    //                 //     await notifica(
                    //                 //         context,
                    //                 //         "ส่งคำขอไม่สำเร็จ");
                    //                 //   }
                    //                 //   _refresh();
                    //                 // } catch (error) {
                    //                 //   print(
                    //                 //       "เกิดข้อผิดพลาดตอนแลกเวร $error");
                    //                 // }
                    //               },
                    //               child: Text(
                    //                 'อนุมัติ',
                    //                 style: FlutterFlowTheme.of(context)
                    //                     .bodyText1
                    //                     .override(
                    //                       fontFamily: 'Mitr',
                    //                       color: FlutterFlowTheme.of(context)
                    //                           .primaryColor,
                    //                     ),
                    //               ),
                    //             ),
                    //             InkWell(
                    //               onTap: () async {
                    //                 // try {
                    //                 //   final getState =
                    //                 //       await updateChangdutyCall.call(
                    //                 //           token: FFAppState()
                    //                 //               .tokenStore,
                    //                 //           apporve: false,
                    //                 //           chagnId:
                    //                 //               '${snapshot.data![indexgetInvite].id}');
                    //                 //   if (getState
                    //                 //           .statusCode ==
                    //                 //       200) {
                    //                 //     print(
                    //                 //         "getstata ${getState.jsonBody}");
                    //                 //     await notifica(
                    //                 //         context,
                    //                 //         "ยกเลิกสำเร็จ",
                    //                 //         color:
                    //                 //             Colors.green);
                    //                 //   } else {
                    //                 //     print(
                    //                 //         "getstata ${getState.jsonBody}");
                    //                 //     await notifica(
                    //                 //         context,
                    //                 //         "ยกเลิกไม่สำเร็จกรุณากดใหม่อีกครั้ง");
                    //                 //   }
                    //                 //   _refresh();
                    //                 // } catch (error) {
                    //                 //   print(
                    //                 //       "เกิดข้อผิดพลาดตอนแลกเวร $error");
                    //                 // }
                    //               },
                    //               child: Text(
                    //                 'ปฏิเสธ',
                    //                 style: FlutterFlowTheme.of(context)
                    //                     .bodyText1
                    //                     .override(
                    //                       fontFamily: 'Mitr',
                    //                       color: FlutterFlowTheme.of(context)
                    //                           .primaryRed,
                    //                     ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    FutureBuilder<InviteModel>(
                        future: futureInvite,
                        builder: (context, snapshot) {
                          if (snapshot.data?.invite?.length == 0) {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ไม่มีแจ้งเตือนยังไม่ได้อยู่ในกลุ่ม",
                                  style: GoogleFonts.mitr(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ],
                            );
                          }
                          if (snapshot.hasData) {
                            final listview = snapshot.data!.invite;

                            if (listview == null) {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "ไม่มีแจ้งเตือนยังไม่ได้อยู่ในกลุ่ม",
                                    style: GoogleFonts.mitr(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ],
                              );
                            }
                            for (var numberInvite = 0;
                                numberInvite < listview.length;
                                numberInvite++) {
                              lordinvite.addEntries(
                                  {"refrest1 ${numberInvite}": false}.entries);
                              lordinvite.addEntries(
                                  {"refrest2 ${numberInvite}": false}.entries);
                            }

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              // scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: listview.length,
                              itemBuilder:
                                  (BuildContext context, int indexInvite) {
                                final getDataLeader =
                                    listview[indexInvite].leader;
                                final getDataMember =
                                    listview[indexInvite].member;
                                final getDataGroup =
                                    listview[indexInvite].group;

                                final getDataInvite = listview[indexInvite];
                                return Column(
                                  children: [
                                    Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryWhite,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 5, 5, 5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 56,
                                              height: 56,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.network(
                                                'https://picsum.photos/seed/260/600',
                                              ),
                                            ),
                                            Text(
                                              // '${getDataLeader!.fristName} ${getDataLeader.lastName} (${getDataLeader.actor})',
                                              "${getDataLeader!.fristName} ${getDataLeader.lastName} (${getDataLeader.actor})",
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .title2,
                                            ),
                                            // Text(
                                            //   'แลกทั้งหมด',
                                            //   textAlign: TextAlign.center,
                                            //   style: FlutterFlowTheme.of(context)
                                            //       .bodyText1
                                            //       .override(
                                            //         fontFamily: 'Mitr',
                                            //         color: FlutterFlowTheme.of(context)
                                            //             .primaryBlue,
                                            //       ),
                                            // ),
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 60,
                                              icon: Icon(
                                                Icons.keyboard_arrow_up,
                                                color: Colors.black,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    50, 30, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              // mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/email.svg',
                                                      width: 24,
                                                      height: 19,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 0, 0, 0),
                                                      child: Text(
                                                        'คำเชิญเข้ากลุ่ม',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Mitr',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryGray,
                                                                  fontSize: 16,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -0.8, 0),
                                                  child: Text(
                                                    "ชื่อกลุ่มที่เชิญเข้า ${getDataGroup?.nameGroup}",
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Mitr',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryGray,
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                ),
                                                // Center(
                                                //   child: Icon(
                                                //       Icons.change_circle,
                                                //       size: 24.0),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                lordinvite["refrest1 ${indexInvite}"] ==
                                                        false
                                                    ? InkWell(
                                                        onTap: () async {
                                                          setState(() {
                                                            lordinvite[
                                                                    "refrest1 ${indexInvite}"] =
                                                                true;
                                                          });
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryWhite,
                                                            context: context,
                                                            builder: (context) {
                                                              return Padding(
                                                                padding: MediaQuery.of(
                                                                        context)
                                                                    .viewInsets,
                                                                child:
                                                                    Container(
                                                                  height: 200,
                                                                  child: ConnextEmailYesNoWidget(
                                                                      userId:
                                                                          "${getDataInvite.member!.id}",
                                                                      groupId:
                                                                          "${getDataInvite.group!.id}",
                                                                      inviteId:
                                                                          "${getDataInvite.id}",
                                                                      approve:
                                                                          true),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                          if (mounted) {
                                                            setState(() {
                                                              lordinvite[
                                                                      "refrest1 ${indexInvite}"] =
                                                                  false;
                                                            });
                                                          }
                                                        },
                                                        child: Text(
                                                          'เข้ากลุ่ม',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBlue,
                                                              ),
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBlue,
                                                        ),
                                                      ),
                                                lordinvite["refrest2 ${indexInvite}"] ==
                                                        false
                                                    ? InkWell(
                                                        onTap: () async {
                                                          print(
                                                              "lordinvite ${lordinvite}");
                                                          setState(() {
                                                            lordinvite[
                                                                    "refrest2 ${indexInvite}"] =
                                                                true;
                                                          });
                                                          print(
                                                              "lordinvite ${lordinvite}");
                                                          putInvite(
                                                              approve: false,
                                                              groupId:
                                                                  "${getDataInvite.group!.id}",
                                                              userId:
                                                                  "${getDataInvite.member!.id}",
                                                              id: "${getDataInvite.id}");
                                                          final statainvitecall = await PutInviteCall.call(
                                                              inviteId:
                                                                  "${getDataInvite.id}",
                                                              groupId:
                                                                  "${getDataInvite.group!.id}",
                                                              userId:
                                                                  "${getDataInvite.member!.id}",
                                                              approve: false,
                                                              token: FFAppState()
                                                                  .tokenStore);
                                                          print(
                                                              "stata ${statainvitecall.statusCode}");
                                                          if (statainvitecall
                                                                  .statusCode ==
                                                              200) {
                                                            print(
                                                                "${PutInviteCall.resState(statainvitecall.jsonBody)}");
                                                            await notifica(
                                                                context,
                                                                "ปฎิเศษสำเร็จ",
                                                                color: Colors
                                                                    .green);
                                                          } else {
                                                            await notifica(
                                                                context,
                                                                "ปฎิเศษไม่สำเร็จ");
                                                          }
                                                          if (mounted) {
                                                            setState(() {
                                                              lordinvite[
                                                                      "refrest2 ${indexInvite}"] =
                                                                  false;
                                                            });
                                                          }
                                                        },
                                                        child: Text(
                                                          'ปฎิเศษ',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryRed,
                                                              ),
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryRed,
                                                        ),
                                                      )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                    FutureBuilder<List<Datum>>(
                        future: futureGetChangDuty,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("เกิดข้อผิดพลาดเกี่ยวกับแอป"),
                            );
                          }
                          if (snapshot.data!.length == 0) {
                            return Center(
                              child: Text(""),
                            );
                          }
                          // if (snapshot.data!.first.memberApprove == false) {
                          //   return Card(
                          //       clipBehavior: Clip.antiAliasWithSaveLayer,
                          //       color: FlutterFlowTheme.of(context)
                          //           .secondaryWhite,
                          //       elevation: 2,
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(20.0),
                          //         child: Center(
                          //           child: Text("ปฎิเศษแล้ว"),
                          //         ),
                          //       ));
                          // }
                          return Builder(builder: (context) {
                            return Column(
                              children: [
                                // Card(
                                //   clipBehavior: Clip.antiAliasWithSaveLayer,
                                //   color: FlutterFlowTheme.of(context)
                                //       .secondaryWhite,
                                //   elevation: 2,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(10),
                                //   ),
                                //   child: Padding(
                                //     padding: EdgeInsetsDirectional.fromSTEB(
                                //         5, 5, 5, 5),
                                //     child: Row(
                                //       mainAxisSize: MainAxisSize.max,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Expanded(
                                //           flex: 1,
                                //           child: Container(
                                //             width: 56,
                                //             height: 56,
                                //             clipBehavior: Clip.antiAlias,
                                //             decoration: BoxDecoration(
                                //               shape: BoxShape.circle,
                                //             ),
                                //             child: Image.network(
                                //               'https://picsum.photos/seed/260/600',
                                //             ),
                                //           ),
                                //         ),
                                //         Text(
                                //           // '${getDataLeader!.fristName} ${getDataLeader.lastName} (${getDataLeader.actor})',
                                //           "${snapshot.data!.first.member2!.fristName} ${snapshot.data!.first.member2!.lastName} (${snapshot.data!.first.member2!.actor})",
                                //           style: FlutterFlowTheme.of(context)
                                //               .title2,
                                //         ),
                                //         // Text(
                                //         //   'แลกทั้งหมด',
                                //         //   textAlign: TextAlign.center,
                                //         //   style: FlutterFlowTheme.of(context)
                                //         //       .bodyText1
                                //         //       .override(
                                //         //         fontFamily: 'Mitr',
                                //         //         color: FlutterFlowTheme.of(context)
                                //         //             .primaryBlue,
                                //         //       ),
                                //         // ),
                                //         FlutterFlowIconButton(
                                //           borderColor: Colors.transparent,
                                //           borderRadius: 30,
                                //           borderWidth: 1,
                                //           buttonSize: 60,
                                //           icon: Icon(
                                //             Icons.keyboard_arrow_up,
                                //             color: Colors.black,
                                //             size: 30,
                                //           ),
                                //           onPressed: () {
                                //             print('IconButton pressed ...');
                                //           },
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    // scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (BuildContext context,
                                        int indexgetInvite) {
                                      if (snapshot.data![indexgetInvite]
                                              .memberShift1![0].morning !=
                                          null) {
                                        stoteDuty = "เช้า";
                                      } else if (snapshot.data![indexgetInvite]
                                              .memberShift1![0].noon !=
                                          null) {
                                        stoteDuty = "บ่าย";
                                      } else {
                                        stoteDuty = "ดึก";
                                      }
                                      if (snapshot.data![indexgetInvite]
                                              .memberShift2![0].morning !=
                                          null) {
                                        stoteDuty2 = "เช้า";
                                      } else if (snapshot.data![indexgetInvite]
                                              .memberShift2![0].noon !=
                                          null) {
                                        stoteDuty2 = "บ่าย";
                                      } else {
                                        stoteDuty2 = "ดึก";
                                      }
                                      print(
                                          "ttttttttt ${snapshot.data!.first.approve}");
                                      return Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: Colors.white,
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 20, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/noti.svg',
                                                    width: 27.89,
                                                    height: 30.72,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 0, 0),
                                                    child: Text(
                                                      'แลกเปลี่ยนเวร',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .title2
                                                          .override(
                                                            fontFamily: 'Mitr',
                                                            color: Color(
                                                                0xFF606060),
                                                            fontSize: 18,
                                                          ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        'วันนี้ 07:14 น.',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title3,
                                                      ),
                                                      Text(
                                                        '${snapshot.data!.first.member2!.fristName} ${snapshot.data!.first.member2!.lastName}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Mitr',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryRed,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FlutterFlowCalendar(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                              weekFormat: false,
                                              weekStartsMonday: false,
                                              onChange: (DateTimeRange?
                                                  newSelectedDate) {
                                                setState(() {
                                                  calendarSelectedDay =
                                                      newSelectedDate;
                                                  calendarSelectedDayString =
                                                      calendarSelectedDay
                                                          .toString()
                                                          .split(" - ")[0]
                                                          .split(" ")[0]
                                                          .split("-")[2]
                                                          .toString();
                                                  // ทุกครั้งที่กดวันที่ในปฏิทิน จะได้เดิอนมา
                                                  calendarSelectedmonthString =
                                                      calendarSelectedDay
                                                          .toString()
                                                          .split(" - ")[0]
                                                          .split(" ")[0]
                                                          .split("-")[1]
                                                          .split("0")[1]
                                                          .toString();
                                                  calendarSelectedyearString =
                                                      calendarSelectedDay
                                                          .toString()
                                                          .split(" - ")[0]
                                                          .split(" ")[0]
                                                          .split("-")[0]
                                                          .toString();
                                                });
                                              },
                                              titleStyle: GoogleFonts.getFont(
                                                'Mitr',
                                                color: Color(0xFF050000),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                              ),
                                              dayOfWeekStyle:
                                                  GoogleFonts.getFont(
                                                'Mitr',
                                                color: Color(0xFF050000),
                                                fontSize: 16,
                                              ),
                                              dateStyle: GoogleFonts.getFont(
                                                'Mitr',
                                                color: Color(0xFF050000),
                                                fontSize: 16,
                                              ),
                                              selectedDateStyle:
                                                  GoogleFonts.getFont(
                                                'Mitr',
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                              inactiveDateStyle:
                                                  GoogleFonts.getFont(
                                                'Mitr',
                                                color: Color(0xFF8E8E8E),
                                                fontSize: 16,
                                              ),
                                              daysOfWeekHeight: 20,
                                              yearduty: int.parse(snapshot
                                                  .data![indexgetInvite]
                                                  .duty2!
                                                  .year
                                                  .toString()),
                                              monthduty: int.parse(snapshot
                                                  .data![indexgetInvite]
                                                  .duty2!
                                                  .month
                                                  .toString()),
                                              dayduty: int.parse(snapshot
                                                  .data![indexgetInvite]
                                                  .duty2!
                                                  .day
                                                  .toString()),
                                              changTwoDuty: true,
                                              yearduty2: int.parse(snapshot
                                                  .data![indexgetInvite]
                                                  .duty1!
                                                  .year
                                                  .toString()),
                                              monthduty2: int.parse(snapshot
                                                  .data![indexgetInvite]
                                                  .duty1!
                                                  .month
                                                  .toString()),
                                              dayduty2: int.parse(snapshot
                                                  .data![indexgetInvite]
                                                  .duty1!
                                                  .day
                                                  .toString()),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                "วันที่ ${snapshot.data![indexgetInvite].duty1!.day} เดือน ${snapshot.data![indexgetInvite].duty1!.month} ปี ${snapshot.data![indexgetInvite].duty1!.year} ชื่อกลุ่ม ${snapshot.data![indexgetInvite].group1}",
                                                style: GoogleFonts.mitr(
                                                  fontSize: 16,
                                                  color: Color(0xFF606060),
                                                ),
                                              ),
                                            ),
                                            Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryWhite,
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 5, 10, 5),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 56,
                                                      height: 56,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.network(
                                                        'https://picsum.photos/seed/260/600',
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          '${snapshot.data![indexgetInvite].member1!.fristName}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .title2,
                                                        ),
                                                        Text(
                                                          ' ${snapshot.data![indexgetInvite].member1!.lastName}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .title2,
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      // dayDuty คือ list เช้า บ่าย ดึกที่เตรียมไว้
                                                      // getMydutyIndex คือ index การ loop ของ listview
                                                      '${stoteDuty}',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Icon(Icons.change_circle,
                                                  size: 24.0),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                "วันที่ ${snapshot.data![indexgetInvite].duty2!.day} เดือน ${snapshot.data![indexgetInvite].duty2!.month} ปี ${snapshot.data![indexgetInvite].duty2!.year} ชื่อกลุ่ม ${snapshot.data![indexgetInvite].group2}",
                                                style: GoogleFonts.mitr(
                                                  fontSize: 16,
                                                  color: Color(0xFF606060),
                                                ),
                                              ),
                                            ),
                                            Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryWhite,
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 5, 10, 5),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 56,
                                                      height: 56,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.network(
                                                        'https://picsum.photos/seed/260/600',
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          '${snapshot.data![indexgetInvite].member2!.fristName}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .title2,
                                                        ),
                                                        Text(
                                                          ' ${snapshot.data![indexgetInvite].member2!.lastName}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .title2,
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      // dayDuty คือ list เช้า บ่าย ดึกที่เตรียมไว้
                                                      // getMydutyIndex คือ index การ loop ของ listview
                                                      '${stoteDuty2}',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(-1, 0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 5, 0, 0),
                                                child: Text(
                                                  'เวรของฉัน',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Mitr',
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryButtonDarkBlue,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .stokeLightGray,
                                            ),
                                            FutureBuilder<List<DutyPresent>>(
                                              future: futurePresent,
                                              // (_apiRequestCompleter2 ??= Completer<ApiCallResponse>()
                                              //       ..complete(GetPresentCall.call(
                                              //         token: FFAppState().tokenStore,
                                              //       )))
                                              //     .future,
                                              builder:
                                                  (context, snapshotPresent) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshotPresent.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final listViewPresent =
                                                    snapshotPresent.data!;

                                                return Builder(
                                                  builder: (context) {
                                                    try {
                                                      print(
                                                          "aaaa${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].month} != ${calendarSelectedmonthString}");
                                                      if (listViewPresent[int.parse(
                                                                          calendarSelectedDayString
                                                                              .toString()) -
                                                                      1]
                                                                  .year !=
                                                              calendarSelectedyearString ||
                                                          listViewPresent[int.parse(
                                                                          calendarSelectedDayString
                                                                              .toString()) -
                                                                      1]
                                                                  .month !=
                                                              calendarSelectedmonthString) {
                                                        return Center(
                                                          child: Text(
                                                              "ไม่มีข้อมูลเวรของเดือนนี้"),
                                                        );
                                                      }
                                                      if (listViewPresent[int.parse(
                                                                      calendarSelectedDayString
                                                                          .toString()) -
                                                                  1]
                                                              .count ==
                                                          0) {
                                                        return Container(
                                                            height: 50.0,
                                                            child: Center(
                                                                child: Text(
                                                                    "ไม่มีเวรของคุณวันนี้")));
                                                      }
                                                      // ตัวนี้คือนำเวรเช้า บ่าย ดึก มาเก็บไว้ใน list
                                                      List<dynamic> getMyduty =
                                                          [
                                                        listViewPresent[int.parse(
                                                                    calendarSelectedDayString
                                                                        .toString()) -
                                                                1]
                                                            .morning,
                                                        listViewPresent[int.parse(
                                                                    calendarSelectedDayString
                                                                        .toString()) -
                                                                1]
                                                            .noon,
                                                        listViewPresent[int.parse(
                                                                    calendarSelectedDayString
                                                                        .toString()) -
                                                                1]
                                                            .night
                                                      ];

                                                      // print(listViewGetPresentResponse[
                                                      //         int.parse(calendarSelectedDayString) - 1]
                                                      //     .morning);
                                                      // เมื่อปัดลงจะทำการโหลดค่าข้างในใหม่
                                                      return Column(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1, 0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          5,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                '${listViewPresent.first.group} ',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Mitr',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryButtonDarkBlue,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          ListView.builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount: 3,
                                                            itemBuilder: (context,
                                                                indexPresent) {
                                                              // ถ้า เช้า บ่าย ดึก ไม่มีก็จะแสดงเป็น box ว่าง แต่ถ้า เช้ามีแต่บ่ายกับดึกไม่มีก็จะแสดงแต่เช้า
                                                              if (getMyduty[
                                                                      indexPresent] ==
                                                                  0) {
                                                                return SizedBox();
                                                              }

                                                              return Card(
                                                                clipBehavior: Clip
                                                                    .antiAliasWithSaveLayer,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBlue02,
                                                                elevation: 2,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          5,
                                                                          10,
                                                                          5),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            56,
                                                                        height:
                                                                            56,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .network(
                                                                          'https://picsum.photos/seed/260/600',
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Text(
                                                                            '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.fristName}',
                                                                            style:
                                                                                FlutterFlowTheme.of(context).title2,
                                                                          ),
                                                                          Text(
                                                                            ' ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.lastName}',
                                                                            style:
                                                                                FlutterFlowTheme.of(context).title2,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        // dayDuty คือ list เช้า บ่าย ดึกที่เตรียมไว้
                                                                        // getMydutyIndex คือ index การ loop ของ listview
                                                                        '${dayDuty[indexPresent]}',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .title2,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    } on RangeError {
                                                      return Container(
                                                          height: 50.0,
                                                          child: Center(
                                                              child: Text(
                                                                  "ตารางเวรเดือนนี้ยังไม่ได้สร้างหรือจัด")));
                                                    } catch (error) {
                                                      print("error = ${error}");
                                                      return Text(
                                                          "error นอกขอบเขตที่กำหนด");
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 15),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      try {
                                                        final getState =
                                                            await updateChangdutyCall.call(
                                                                token: FFAppState()
                                                                    .tokenStore,
                                                                apporve: true,
                                                                chagnId:
                                                                    '${snapshot.data![indexgetInvite].id}');
                                                        if (getState
                                                                .statusCode ==
                                                            200) {
                                                          print(
                                                              "getstata ${getState.jsonBody}");
                                                          await notifica(
                                                              context,
                                                              "ส่งคำขอสำเร็จ",
                                                              color:
                                                                  Colors.green);
                                                        } else {
                                                          print(
                                                              "getstata ${getState.jsonBody}");
                                                          await notifica(
                                                              context,
                                                              "ส่งคำขอไม่สำเร็จ");
                                                        }
                                                        _refresh();
                                                      } catch (error) {
                                                        print(
                                                            "เกิดข้อผิดพลาดตอนแลกเวร $error");
                                                      }
                                                    },
                                                    child: Text(
                                                      'แลกเปลี่ยน',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      try {
                                                        final getState =
                                                            await updateChangdutyCall.call(
                                                                token: FFAppState()
                                                                    .tokenStore,
                                                                apporve: false,
                                                                chagnId:
                                                                    '${snapshot.data![indexgetInvite].id}');
                                                        if (getState
                                                                .statusCode ==
                                                            200) {
                                                          print(
                                                              "getstata ${getState.jsonBody}");
                                                          await notifica(
                                                              context,
                                                              "ยกเลิกสำเร็จ",
                                                              color:
                                                                  Colors.green);
                                                        } else {
                                                          print(
                                                              "getstata ${getState.jsonBody}");
                                                          await notifica(
                                                              context,
                                                              "ยกเลิกไม่สำเร็จกรุณากดใหม่อีกครั้ง");
                                                        }
                                                        _refresh();
                                                      } catch (error) {
                                                        print(
                                                            "เกิดข้อผิดพลาดตอนแลกเวร $error");
                                                      }
                                                    },
                                                    child: Text(
                                                      'ยกเลิก',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryRed,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            );
                          });
                        }),
                    Container(
                      height: 50.0,
                      width: 50.0,
                    ),
                    // chang my duty graph
                    // Query(
                    //     options: QueryOptions(
                    //         document: gql(changMyDutyGraphQL),
                    //         variables: {
                    //           "filter": {"type": "CHANGE_DUTY"}
                    //         }),
                    //     builder: (QueryResult result, {fetchMore, refetch}) {
                    //       if (result.hasException) {
                    //         return Text(result.exception.toString());
                    //       }
                    //       if (result.isLoading) {
                    //         return Center(
                    //           child: CircularProgressIndicator(),
                    //         );
                    //       }
                    //       // final productList = Welcome.fromJson(result.data as Map<String, dynamic>);
                    //       // print(productList);
                    //       final productList =
                    //           ChangMyDuty.fromJson(result.data!);

                    //       return Text("test$productList");
                    //     }),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
