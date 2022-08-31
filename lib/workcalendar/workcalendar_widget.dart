import '../backend/api_requests/api_calls.dart';
import '../backend/pubilc_.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/present_model.dart';
import '../model/without_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WorkcalendarWidget extends StatefulWidget {
  const WorkcalendarWidget({Key? key}) : super(key: key);

  @override
  _WorkcalendarWidgetState createState() => _WorkcalendarWidgetState();
}

class _WorkcalendarWidgetState extends State<WorkcalendarWidget> {
  ApiCallResponse? crateTableOutput;
  Completer<ApiCallResponse>? _apiRequestCompleter1;
  Completer<ApiCallResponse>? _apiRequestCompleter2;
  DateTimeRange? calendarSelectedDay;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<DutyPresent>>? futurePresent;
  Future<List<DutyWithOutModel>>? futureWithOut;
  late Future<List<dynamic>> futureMeAll;
  List dayDuty = ["เช้า", "บ่าย", "ดึก"];
  var index1 = 0;

  late String calendarSelectedDayString;
  late String calendarSelectedmonthString;
  late String calendarSelectedyearString;
  
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

  Future<List<DutyWithOutModel>> getWithOutModel( {required String token}) async {
    try {
      print("เข้าฟังชัน getWithOutModel แล้ว");
      final res = await http.get(
        Uri.parse("$url/api/group/schedule/without/me"),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "$token"
        },
      );
      // print("res.body11 ${res.statusCode}");
      // print("res.body11 ${res.body}");

      final body = convert.json.decode(res.body) as Map<String, dynamic>;
      final _futureWithOut = WithOutCall.fromJson(body as Map<String, dynamic>);
      final futureWithOut = _futureWithOut.duty as List<DutyWithOutModel>;
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
      return futureWithOut;
    } catch (error) {
      print(error);
    }
    return [];
  }



  @override
  void initState() {
    super.initState();
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    futurePresent = getPresentModel(token: FFAppState().tokenStore);
    futureWithOut = getWithOutModel(token: FFAppState().tokenStore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        icon: Icon(
          Icons.send,
          size: 35,
        ),
        elevation: 10,
        label: Container(),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.99,
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FlutterFlowCalendar(
                      daysOfWeekHeight: 18,
                      color: FlutterFlowTheme.of(context).primaryColor,
                      weekFormat: false,
                      weekStartsMonday: false,
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
                          .split("0")[1]
                          .toString();
                      calendarSelectedyearString = calendarSelectedDay
                          .toString()
                          .split(" - ")[0]
                          .split(" ")[0]
                          .split("-")[0]
                          .toString();
                      print(
                          "calendarSelectedmonthString ${calendarSelectedmonthString}");
                    });
   
                      },
                      titleStyle: GoogleFonts.getFont(
                        'Mitr',
                        color: Color(0xFF050000),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      dayOfWeekStyle: GoogleFonts.getFont(
                        'Mitr',
                        color: Color(0xFF050000),
                        fontSize: 16,
                      ),
                      dateStyle: GoogleFonts.getFont(
                        'Mitr',
                        color: Color(0xFF050000),
                        fontSize: 16,
                      ),
                      selectedDateStyle: GoogleFonts.getFont(
                        'Mitr',
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      inactiveDateStyle: GoogleFonts.getFont(
                        'Mitr',
                        color: Color(0xFF8E8E8E),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
             
             // ตารางเวรของฉัน
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
              FutureBuilder<List<DutyPresent>>(
                future: futurePresent,
                // (_apiRequestCompleter2 ??= Completer<ApiCallResponse>()
                //       ..complete(GetPresentCall.call(
                //         token: FFAppState().tokenStore,
                //       )))
                //     .future,
                builder: (context, snapshotPresent) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshotPresent.hasData) {
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
                  final listViewPresent = snapshotPresent.data!;

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
                            child: Text("ไม่มีข้อมูลเวรของเดือนนี้"),
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
                                  child: Text("ไม่มีเวรของคุณวันนี้")));
                        }
                        // ตัวนี้คือนำเวรเช้า บ่าย ดึก มาเก็บไว้ใน list
                        List<dynamic> getMyduty = [
                          listViewPresent[int.parse(
                                      calendarSelectedDayString.toString()) -
                                  1]
                              .morning,
                          listViewPresent[int.parse(
                                      calendarSelectedDayString.toString()) -
                                  1]
                              .noon,
                          listViewPresent[int.parse(
                                      calendarSelectedDayString.toString()) -
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
                              alignment: AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5, 5, 0, 0),
                                child: Text(
                                  '${listViewPresent.first.group}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Mitr',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryButtonDarkBlue,
                                      ),
                                ),
                              ),
                            ),
                            RefreshIndicator(
                              onRefresh: () async {
                                setState(() => _apiRequestCompleter2 = null);
                                await waitForApiRequestCompleter2();
                              },
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: 3,
                                itemBuilder: (context, indexPresent) {
                                  // ถ้า เช้า บ่าย ดึก ไม่มีก็จะแสดงเป็น box ว่าง แต่ถ้า เช้ามีแต่บ่ายกับดึกไม่มีก็จะแสดงแต่เช้า
                                  if (getMyduty[indexPresent] == 0) {
                                    return SizedBox();
                                  }

                                  return Card(
                                    clipBehavior:
                                        Clip.antiAliasWithSaveLayer,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBlue02,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(
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
                                                '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.fristName}',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .title2,
                                              ),
                                              Text(
                                                ' ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.lastName}',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .title2,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            // dayDuty คือ list เช้า บ่าย ดึกที่เตรียมไว้
                                            // getMydutyIndex คือ index การ loop ของ listview
                                            '${dayDuty[indexPresent]}',
                                            style:
                                                FlutterFlowTheme.of(context)
                                                    .title2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
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
                        return Text("error นอกขอบเขตที่กำหนด");
                      }
                    },
                  );
                },
              ),
             
              // เวรของเพื่อน
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
              FutureBuilder<List<DutyWithOutModel>>(
                future: futureWithOut,
                // (_apiRequestCompleter1 ??= Completer<ApiCallResponse>()
                //       ..complete(GetPresentCall.call(
                //         token: FFAppState().tokenStore,
                //       )))
                //     .future,
                builder: (context, snapshotWithOutMe) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshotWithOutMe.hasData) {
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
                  final listViewWithOut = snapshotWithOutMe.data!;

                  return Builder(builder: (context) {
                    // final getMyduty = GetPresentCall.oneListDuty(
                    //       (listViewGetPresentResponse.jsonBody ?? ''),
                    //     )?.toList() ??

                    try {
                      // if (listViewWithOut[
                      //             int.parse(calendarSelectedmonthString) - 7]
                      //         .duty![int.parse(calendarSelectedDayString) - 1]
                      //         .count ==
                      //     0) {
                      //   return Container(
                      //       height: 50.0,
                      //       child:
                      //           Center(child: Text("ไม่มีเวรของคุณวันนี้")));
                      // }

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewWithOut.length,
                        itemBuilder: (context, indexWithOut) {
                          final itemWithOut = listViewWithOut[indexWithOut];
                          final itemFristName = itemWithOut.user!.fristName;
                          final itemLastName = itemWithOut.user!.lastName;
                          print("itemFristName $itemFristName");
                          print("itemLastName $itemLastName");

                          return Builder(builder: (context) {
                            return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: itemWithOut.duty!.length,
                                itemBuilder: (context, indexWithOutMeDuty) {
                                  print("วันที่ $indexWithOutMeDuty");
                                  final itemWityOutMeDuty =
                                      itemWithOut.duty![indexWithOutMeDuty];
                                  print(
                                      "itemWityOutMeDuty ${itemWityOutMeDuty.year}");
                                  if (int.parse(itemWityOutMeDuty.year
                                              .toString()) ==
                                          int.parse(
                                              calendarSelectedyearString) &&
                                      int.parse(itemWityOutMeDuty.month
                                              .toString()) ==
                                          int.parse(
                                              calendarSelectedmonthString) &&
                                      int.parse(itemWityOutMeDuty.day
                                              .toString()) ==
                                          int.parse(
                                              calendarSelectedDayString)) {
                                    if (itemWityOutMeDuty.count == 0) {
                                      if (index1 == 0) {
                                        index1 += 1;
                                        return Container(
                                          height: 100.0,
                                          width: 100.0,
                                          child: Center(
                                            child: Text('ไม่มีเวรวันนี้'),
                                          ),
                                        );
                                      }
                                      index1 += 1;
                                      return SizedBox();
                                    }
                                    final dutylist = [
                                      itemWityOutMeDuty.morning,
                                      itemWityOutMeDuty.noon,
                                      itemWityOutMeDuty.night
                                    ];
                                    return Builder(builder: (context) {
                                      print("object");
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: 3,
                                          itemBuilder:
                                              (context, indexDutyList) {
                                            if (dutylist[indexDutyList] ==
                                                0) {
                                              return SizedBox();
                                            }
                                            return Container(
                                              child: Card(
                                                clipBehavior: Clip
                                                    .antiAliasWithSaveLayer,
                                                color: FlutterFlowTheme.of(
                                                        context)
                                                    .secondaryWhite,
                                                elevation: 2,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              10, 5, 10, 5),
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
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
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
                                                            '${itemFristName}',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .title2,
                                                          ),
                                                          Text(
                                                            ' ${itemLastName}',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .title2,
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        "${dayDuty[indexDutyList]}",
                                                        // IndexWithOutDay เพราะ กรองindexที่จะเข้ามา
                                                        // '${dayDuty[IndexWithOutList]}',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .title2,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    });
                                  }
                                  return SizedBox();
                                });
                          });
                        },
                      );
                    } on RangeError {
                      return Container(
                          height: 50.0,
                          child: Center(
                              child: Text(
                                  "ตารางเวรเดือนนี้ยังไม่ได้สร้างหรือจัด")));
                    } catch (error) {
                      print("error 2 $error");
                      return Text("เกิดข้อผิดพลาด");
                    }
                  });
                },
              ),
             Container(width: 100.0,height: 100.0,)
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
