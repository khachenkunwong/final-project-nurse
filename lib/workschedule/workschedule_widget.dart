import 'package:hos_mobile2/backend/api_requests/api_basic.dart';
import 'package:hos_mobile2/model/me_all_model.dart';
import 'package:hos_mobile2/model/present_model.dart';

import '../backend/api_requests/api_calls.dart';
import '../backend/pubilc_.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../custom_code/actions/index.dart' as actions;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
// เหลือเวรของเพื่อน

class WorkscheduleWidget extends StatefulWidget {
  const WorkscheduleWidget({Key? key}) : super(key: key);

  @override
  _WorkscheduleWidgetState createState() => _WorkscheduleWidgetState();
}

class _WorkscheduleWidgetState extends State<WorkscheduleWidget> {
  ApiCallResponse? crateTableOutput;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<ApiCallResponse>? _apiRequestCompleter1;
  Completer<ApiCallResponse>? _apiRequestCompleter2;
  DateTimeRange? calendarSelectedDay;
  Future<List<DutyPresent>>? futurePresent;
  late Future<List<dynamic>> futureMeAll;
  List dayDuty = ["เช้า", "บ่าย", "ดึก"];
  // List listViewGetPresentResponse1 = [];
  var test;
  late String calendarSelectedDayString;
  late String calendarSelectedmonthString;
  Future<List<dynamic>> getMeAllModel(
      {required String token, required String nameGroup}) async {
    try {
      print("เข้าฟังชัน allme แล้ว");
      final res = await http.get(
        Uri.parse("$url/api/group/schedule/me/all/$nameGroup"),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "$token"
        },
      );
      print("res.body1 ${res.statusCode}");
      print("res.body1 ${res.body}");

      final data = convert.json.decode(res.body) as List<dynamic>;
      // print("data ${data}");
      // for (var dutylist in data) {
      //   // list ออกมาทั้ง index
      //   final _futurePresent =
      //       MeAllModel.fromJson(dutylist as Map<String, dynamic>);
      //   // aa = _dutylist.duty!.first.day;
      //   // print("_dutylist ${aa}");
      //   setState(() {
      //     listViewGetPresentResponse1.add(_futurePresent);
      //   });
      // }
      return data;
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
      print("res.body1 ${res.statusCode}");
      print("res.body1 ${res.body}");

      final body = convert.json.decode(res.body) as Map<String, dynamic>;
      final _futureMeAll = PresentModel.fromJson(body as Map<String, dynamic>);
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

  Future<List<dynamic>> getWithOutModel(
      {required String token, required String nameGroup}) async {
    try {
      print("เข้าฟังชัน allme แล้ว");
      final res = await http.get(
        Uri.parse("$url/api/group/schedule/me/all/$nameGroup"),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "$token"
        },
      );
      print("res.body11 ${res.statusCode}");
      print("res.body11 ${res.body}");

      final data = convert.json.decode(res.body) as List<dynamic>;
      // print("data ${data}");
      // for (var dutylist in data) {
      //   // list ออกมาทั้ง index
      //   final _futurePresent =
      //       MeAllModel.fromJson(dutylist as Map<String, dynamic>);
      //   // aa = _dutylist.duty!.first.day;
      //   // print("_dutylist ${aa}");
      //   setState(() {
      //     listViewGetPresentResponse1.add(_futurePresent);
      //   });
      // }
      return data;
    } catch (error) {
      print(error);
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        crateTableOutput = await CreateTableCall.call();
        if (((crateTableOutput?.statusCode ?? 200)) == 200) {
          await actions.notifica(
            context,
            'สร้างตารางเสร็จสิ้น',
          );
        } else {
          await actions.notifica(
            context,
            'สร้างตารางไม่สำเร็จ',
          );
        }
      } catch (error) {}
    });

    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    print("api ทำงาน");
    // getMeAllModel(
    //     token: FFAppState().tokenStore, nameGroup: 'AAA-โรงพยาบาลบ้านม่วง');
    // เพื่อเอาไว้ใช้การกับ เวรของฉัน
    futureMeAll = getMeAllModel(
        token: FFAppState().tokenStore, nameGroup: "AAA-โรงพยาบาลบ้านม่วง");
    // futureMeAll = getMeAllModel(
    //     token: FFAppState().tokenStore, nameGroup: "AAA-โรงพยาบาลบ้านม่วง");
    // print("FFAppState().namegroup${FFAppState().namegroup}1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBlue01,
        automaticallyImplyLeading: true,
        title: Text(
          'ตารางงาน',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Mitr',
                color: FlutterFlowTheme.of(context).secondaryWhite,
                fontSize: 20,
              ),
        ),
        actions: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Text(
              'เลือก',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Mitr',
                    color: FlutterFlowTheme.of(context).secondaryWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground1,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.99,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                  ),
                  child: FlutterFlowCalendar(
                    color: FlutterFlowTheme.of(context).primaryColor,
                    weekFormat: true,
                    weekStartsMonday: true,
                    onChange: (DateTimeRange? newSelectedDate) {
                      setState(() {
                        calendarSelectedDay = newSelectedDate;
                        // ทุกครั้งที่กดวันที่ในปฏิทิน จะได้วันที่มา
                        calendarSelectedDayString = calendarSelectedDay
                            .toString()
                            .split(" - ")[0]
                            .split(" ")[0]
                            .split("-")[2]
                            .toString();
                        // ทุกครั้งที่กดวันที่ในปฏิทิน จะได้เดิอนมา
                        calendarSelectedmonthString = calendarSelectedDay
                            .toString()
                            .split(" - ")[0]
                            .split(" ")[0]
                            .split("-")[1]
                            .split("0")[1];
                        print(
                            "calendarSelectedmonthString ${calendarSelectedmonthString}");
                      });
                      print(
                          "newSelectedDate ${calendarSelectedDay.toString().split(" - ")[0].split(" ")[0].split("-")[2].runtimeType}");
                    },
                    titleStyle: GoogleFonts.getFont(
                      'Mitr',
                      color: FlutterFlowTheme.of(context).primaryBlack,
                      fontSize: 18,
                    ),
                    dayOfWeekStyle: GoogleFonts.getFont(
                      'Mitr',
                      color: Color(0xFF050000),
                      fontSize: 18,
                    ),
                    dateStyle: GoogleFonts.getFont(
                      'Mitr',
                      color: Color(0xFF050000),
                      fontSize: 18,
                    ),
                    selectedDateStyle: GoogleFonts.getFont(
                      'Mitr',
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    inactiveDateStyle: GoogleFonts.getFont(
                      'Mitr',
                      color: Color(0xFF8E8E8E),
                      fontSize: 18,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                    child: Text(
                      'เวรของฉัน',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Mitr',
                            color: FlutterFlowTheme.of(context)
                                .secondaryButtonDarkBlue,
                          ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: FlutterFlowTheme.of(context).stokeLightGray,
                ),
                FutureBuilder<List<dynamic>>(
                  future: futureMeAll,
                  // (_apiRequestCompleter2 ??= Completer<ApiCallResponse>()
                  //       ..complete(GetPresentCall.call(
                  //         token: FFAppState().tokenStore,
                  //       )))
                  //     .future,
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: FlutterFlowTheme.of(context).primaryColor,
                          ),
                        ),
                      );
                    }
                    final listViewGetPresentResponse = snapshot.data!;
                    // var indexMonth = 0;

                    // print("snapshot.data ${listViewGetPresentResponse.length}");
                    //   print(e[0]);
                    // var listViewGetPresentResponse1 = MeAll.fromJson(data);
                    // for (var vv in listViewGetPresentResponse) {
                    //   var data1 = MeAllModel.fromJson(vv);
                    //   var datatoint = data1
                    //       .duty![int.parse(calendarSelectedDayString) - 1]
                    //       .month;

                    //   print("tyep ${datatoint.runtimeType}");
                    //   if (datatoint == calendarSelectedmonthString) {
                    //     print(
                    //         "aa ${data1.duty![int.parse(calendarSelectedDayString) - 1].month}");
                    //     indexMonth -= 1;
                    //   }
                    //   indexMonth += 1;
                    // }
                    // })}");
                    // print("indexMonth $indexMonth");
                    // print(
                    //     "listViewGetPresentResponse1 ${listViewGetPresentResponse[0]["_duty"][0]["morning"]}");

                    return Builder(
                      builder: (context) {
                        // calendarSelectedDayint = calendarSelectedDayString;
                        // print(
                        //     "calendarSelectedDayString ${int.parse(calendarSelectedDayString).runtimeType}");
                        // print(listViewGetPresentResponse[
                        //         int.parse(calendarSelectedDayString) - 1]
                        //     .id);
                        try {
                          // ตัวนี้คือนำเวรเช้า บ่าย ดึก มาเก็บไว้ใน list
                          List<dynamic> getMyduty = [
                            listViewGetPresentResponse[
                                        int.parse(calendarSelectedmonthString) -
                                            6]["_duty"]
                                    [int.parse(calendarSelectedDayString) - 1]
                                ["morning"],
                            listViewGetPresentResponse[
                                        int.parse(calendarSelectedmonthString) -
                                            6]["_duty"]
                                    [int.parse(calendarSelectedDayString) - 1]
                                ["noon"],
                            listViewGetPresentResponse[
                                        int.parse(calendarSelectedmonthString) -
                                            6]["_duty"]
                                    [int.parse(calendarSelectedDayString) - 1]
                                ["night"]
                          ];
                          int? count = listViewGetPresentResponse[
                                      int.parse(calendarSelectedmonthString) -
                                          6]["_duty"]
                                  [int.parse(calendarSelectedDayString) - 1]
                              ["count"];
                          print(
                              "month1 ${int.parse(calendarSelectedmonthString) - 6} ${int.parse(calendarSelectedDayString) - 1}");
                          print("getMyduty $getMyduty");

                          // List<dynamic> getMyduty = GetPresentCall.oneListDuty(
                          //       (listViewGetPresentResponse.jsonBody ?? ''),
                          //     ) ??
                          //     [];
                          //            FutureBuilder<PresentModel>(
                          // future:futurePresent,
                          // print("getMyduty :$getMyduty");
                          // var sum = getMyduty.reduce((a, b) => a + b);

                          // if (int.parse(calendarSelectedmonthString).toInt() ==
                          //     listViewGetPresentResponse[
                          //             int.parse(calendarSelectedDayString)]
                          //         .month) {
                          //   return Text("เดือนนี้ยังไม่ได้จัด");
                          // }
                          // ถ้าไม่มีเวร
                          if (count == 0) {
                            return Container(
                                height: 50.0,
                                child: Center(
                                    child: Text("ไม่มีเวรของคุณวันนี้")));
                          }
                          // print(listViewGetPresentResponse[
                          //         int.parse(calendarSelectedDayString) - 1]
                          //     .morning);
                          // เมื่อปัดลงจะทำการโหลดค่าข้างในใหม่
                          return RefreshIndicator(
                            onRefresh: () async {
                              setState(() => _apiRequestCompleter2 = null);
                              await waitForApiRequestCompleter2();
                            },
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: 3,
                              itemBuilder: (context, getMydutyIndex) {
                                final getMydutyItem = getMyduty[getMydutyIndex];
                                print(
                                    "getMydutyItem $getMydutyItem $calendarSelectedmonthString");

                                // ถ้า เช้า บ่าย ดึก ไม่มีก็จะแสดงเป็น box ว่าง แต่ถ้า เช้ามีแต่บ่ายกับดึกไม่มีก็จะแสดงแต่เช้า
                                if (getMydutyItem == 0) {
                                  return SizedBox(
                                    width: 1.0,
                                  );
                                }

                                return Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBlue02,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 5, 10, 5),
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
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'Jonh',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .title2,
                                            ),
                                            Text(
                                              ' liam',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .title2,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          // dayDuty คือ list เช้า บ่าย ดึกที่เตรียมไว้
                                          // getMydutyIndex คือ index การ loop ของ listview
                                          '${dayDuty[getMydutyIndex]}',
                                          style: FlutterFlowTheme.of(context)
                                              .title2,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } on RangeError {
                          return Container(
                              height: 50.0,
                              child: Center(
                                  child: Text(
                                      "ตารางเวรเดือนนี้ยังไม่ได้สร้างหรือจัด")));
                        } catch (error) {
                          print(error);
                          return Text("error นอกขอบเขตที่กำหนด");
                        }
                      },
                    );
                  },
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                    child: Text(
                      'เวรของเพื่อน',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Mitr',
                            color: FlutterFlowTheme.of(context)
                                .secondaryButtonDarkBlue,
                          ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: FlutterFlowTheme.of(context).stokeLightGray,
                ),
                FutureBuilder<ApiCallResponse>(
                  future:
                      (_apiRequestCompleter1 ??= Completer<ApiCallResponse>()
                            ..complete(GetPresentCall.call(
                              token: FFAppState().tokenStore,
                            )))
                          .future,
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: FlutterFlowTheme.of(context).primaryColor,
                          ),
                        ),
                      );
                    }
                    final listViewGetPresentResponse = snapshot.data!;
                    return Builder(
                      builder: (context) {
                        final getMyduty = GetPresentCall.oneListDuty(
                              (listViewGetPresentResponse.jsonBody ?? ''),
                            )?.toList() ??
                            [];
                        return RefreshIndicator(
                          onRefresh: () async {
                            setState(() => _apiRequestCompleter1 = null);
                            await waitForApiRequestCompleter1();
                          },
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: getMyduty.length,
                            itemBuilder: (context, getMydutyIndex) {
                              final getMydutyItem = getMyduty[getMydutyIndex];
                              return Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color:
                                    FlutterFlowTheme.of(context).primaryBlue02,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 5, 10, 5),
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
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Jonh',
                                            style: FlutterFlowTheme.of(context)
                                                .title2,
                                          ),
                                          Text(
                                            ' liam',
                                            style: FlutterFlowTheme.of(context)
                                                .title2,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'เช้า',
                                        style:
                                            FlutterFlowTheme.of(context).title2,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future waitForApiRequestCompleter1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = _apiRequestCompleter1?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleter2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = _apiRequestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}