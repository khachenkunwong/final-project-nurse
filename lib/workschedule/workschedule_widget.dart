import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hos_mobile2/custom_code/actions/index.dart';
import 'package:hos_mobile2/index.dart';
import 'package:hos_mobile2/model/present_model.dart';

import '../backend/pubilc_.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_checkbox_group.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/changdutyall_model.dart';
import '../model/without_model.dart';
// เหลือเวรของเพื่อน

class WorkscheduleWidget extends StatefulWidget {
  const WorkscheduleWidget({Key? key}) : super(key: key);

  @override
  _WorkscheduleWidgetState createState() => _WorkscheduleWidgetState();
}

class _WorkscheduleWidgetState extends State<WorkscheduleWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool errorduty = true;

  DateTimeRange? calendarSelectedDay;
  Future<List<DutyPresent>>? futurePresent;
  Future<List<DutyWithOutModel>>? futureWithOut;
  late Future<List<dynamic>> futureMeAll;
  List dayDuty = ["เช้า", "บ่าย", "ดึก"];
  List dayDutyEnglist = ["morning", "noon", "night"];
  List<String> checkboxValues = [];
  Map<String, bool> checkboxValuesbool = {};
  List dutySelectwithoutme = [];
  var index1 = 0;
  String DutySelect = "";
  List<String> checkboxGroupValues = [];
  Map<String, List<bool>> checkboxdaybool = {};
  Map<String, List<bool>> checkboxdayboolcopy = {};
  Map<int, List<dynamic>> numberPointEven = {};
  Map<String, List<int>> itemmemberinday = {};

  int saveindex = -1;
  // List<int>

  late String calendarSelectedDayString;
  late String calendarSelectedmonthString;
  late String calendarSelectedyearString;
  bool selete = false;

  @override
  void dispose() {
    dayDutyEnglist.clear();
    dayDuty.clear();
    super.dispose();
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

      print("_futurePresent ${futureMeAll.length}");
      for (int i = 1; i < futureMeAll.length + 1; i++) {
        if (futureMeAll[i - 1].count == 1) {
          numberPointEven.addAll({
            i: [DateTime.utc(DateTime.now().year, DateTime.now().month, i)]
          });
        } else if (futureMeAll[i - 1].count == 2) {
          numberPointEven.addAll({
            i: [
              DateTime.utc(DateTime.now().year, DateTime.now().month, i),
              DateTime.utc(DateTime.now().year, DateTime.now().month, i)
            ]
          });
        } else if (futureMeAll[i - 1].count == 3) {
          numberPointEven.addAll({
            i: [
              DateTime.utc(DateTime.now().year, DateTime.now().month, i),
              DateTime.utc(DateTime.now().year, DateTime.now().month, i),
              DateTime.utc(DateTime.now().year, DateTime.now().month, i)
            ]
          });
        } else {
          numberPointEven.addAll({i: []});
        }

        print("numberPointEven$numberPointEven");
      }

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

  Future<List<DutyWithOutModel>> getWithOutModel(
      {required String token}) async {
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
      print("res.body11 ${res.statusCode}");
      print("res.body11 ${res.body}");

      final body = convert.json.decode(res.body) as Map<String, dynamic>;
      final _futureWithOut = WithOutCall.fromJson(body);
      final futureWithOut = _futureWithOut.duty as List<DutyWithOutModel>;
      print("res.body11จำนวนวัน ${futureWithOut[1].duty!.length}");

      // for (int v = 1; v < futureWithOut.first.duty!.length + 1; v++) {
      //   for (int p = 1; p < futureWithOut[v].duty!.length + 1; p++ )
      //   print("futureWithOut.first.duty ${futureWithOut[v].duty?[p].count}");
      // }

      for (int i = 0; i < futureWithOut.length; i++) {
        for (int c = 0; c < futureWithOut[i].duty!.length; c++) {
          checkboxdaybool.addAll({
            "${futureWithOut[i].duty![c].day}/${futureWithOut[i].duty![c].month}/${futureWithOut[i].duty![c].year} ${futureWithOut[i].user!.id}":
                [false, false, false]
          });
          checkboxdayboolcopy.addAll({
            "${futureWithOut[i].duty![c].day}/${futureWithOut[i].duty![c].month}/${futureWithOut[i].duty![c].year} ${futureWithOut[i].user!.id}":
                [false, false, false]
          });
        }
        print("chckbox ${checkboxdaybool.length}");

        // checkboxdaybool
        //     .addAll({"$i": List<bool>.filled(3, false, growable: false)});

        // checkboxValuesbool.addAll({
        //   "${i}/${itemWityOutMeDuty.month}/${itemWityOutMeDuty.year} ${itemWithOut.duty![indexWithOutMeDuty].id} ${dayDutyEnglist[indexDutyList]}":
        //       false
        // });
      }
      List arms = List<bool>.filled(10, true, growable: false);
      print("armssss $arms");

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
      await notifica(context, "เกิดข้อผิดพลายในการเรียกรายการเพื่อนของฉัน");
      print("เกิดข้อผิดพลายในการเรียกรายการเพื่อนของฉัน ${error}");
    }
    return [];
  }

  Future<void> _refresh() async {
    setState(() {
      futurePresent = getPresentModel(token: FFAppState().tokenStore);
      futureWithOut = getWithOutModel(token: FFAppState().tokenStore);
    });
    return await Future.delayed(Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // try {
      // crateTableOutput = await CreateTableCall.call();
      //   if (((crateTableOutput?.statusCode ?? 200)) == 200) {
      //     await actions.notifica(
      //       context,
      //       'สร้างตารางเสร็จสิ้น',
      //     );
      //   } else {
      //     await actions.notifica(
      //       context,
      //       'สร้างตารางไม่สำเร็จ',
      //     );
      //   }
      // } catch (error) {}
    });

    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    print("api ทำงาน");

    futurePresent = getPresentModel(token: FFAppState().tokenStore);
    futureWithOut = getWithOutModel(token: FFAppState().tokenStore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LeaveWidget()));
              },
              child: Icon(Icons.send),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBlue01,
        automaticallyImplyLeading: false,
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
          selete == true
              ? Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: TextButton(
                    onPressed: () async {
                      print(
                          "FFAppState().dutySelectwithoutme ${FFAppState().dutySelectwithoutme.last}");
                      if (FFAppState().dutySelectwithoutme.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SelectExchangeWorkscheduleWidget(),
                          ),
                        );
                      } else {
                        await notifica(context, "กรุณาเลือกรายการ",
                            color: Colors.yellow, textColor: Colors.black);
                      }
                    },
                    child: Text(
                      "ถัดไป",
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Mitr',
                            color: FFAppState().dutySelectwithoutme.isNotEmpty
                                ? FlutterFlowTheme.of(context).secondaryWhite
                                : Colors.grey[300],
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                )
              : Container(),
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  selete = !selete;
                });
                if (!selete) {
                  FFAppState().dutySelectwithoutme = [];
                  setState(() {
                    checkboxdaybool = checkboxdayboolcopy;
                  });
                  print(
                      "FFAppState().dutySelectwithoutme = ${FFAppState().dutySelectme}");
                }
              },
              child: Text(
                selete == true ? "ยกเลิก" : 'เลือก',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Mitr',
                      color: selete == true
                          ? FlutterFlowTheme.of(context).primaryRed
                          : FlutterFlowTheme.of(context).secondaryWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
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
          child: LayoutBuilder(
            builder: (context, constraints) => RefreshIndicator(
              onRefresh: _refresh,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.99,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                      ),
                      child: FutureBuilder<List<DutyPresent>>(
                          future: futurePresent,
                          builder: (context, snapshotfuturePresent) {
                            return FlutterFlowCalendar(
                              color: FlutterFlowTheme.of(context).primaryColor,
                              weekFormat: true,
                              weekStartsMonday: true,
                              // yearduty: 2022,
                              // monthduty: 8,
                              // dayduty: 17,
                              // แก้
                              // rowHeight:100.0,

                              onChange: (DateTimeRange? newSelectedDate) {
                                setState(() {
                                  calendarSelectedDay = newSelectedDate;
                                  // ทุกครั้งที่กดวันที่ในปฏิทิน จะได้วันที่มา
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
                                          .toString();

                                  calendarSelectedyearString =
                                      calendarSelectedDay
                                          .toString()
                                          .split(" - ")[0]
                                          .split(" ")[0]
                                          .split("-")[0]
                                          .toString();
                                  // print("calendarSelectedmonthString ${newSelectedDate}");
                                });

                                // print(
                                //     "newSelectedDate ${calendarSelectedDay.toString().split(" - ")[0].split(" ")[0].split("-")[0]}");
                              },
                              eventPoint: (day) {
                                if (numberPointEven[day.day] != null &&
                                    day.month == DateTime.now().month &&
                                    day.year == DateTime.now().year) {
                                  return numberPointEven[day.day]!;
                                }

                                return [];
                              },
                              titleStyle: GoogleFonts.getFont(
                                'Mitr',
                                color:
                                    FlutterFlowTheme.of(context).primaryBlack,
                                fontSize: 18,
                              ),
                              dayOfWeekStyle: GoogleFonts.getFont(
                                'Mitr',
                                color: Color(0xFF050000),
                                fontSize: 16,
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
                              daysOfWeekHeight: 18,
                            );
                          }),
                    ),
                    // ตารางเวรของฉัน
                    Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                        child: Text(
                          'เวรของฉัน',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
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
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                              ),
                            ),
                          );
                        }
                        final listViewPresent = snapshotPresent.data!;

                        return Builder(
                          builder: (context) {
                            try {
                              print(
                                  "aaaa${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].month} != $calendarSelectedmonthString");
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "ไม่มีข้อมูลเวรของเดือนนี้",
                                      style: GoogleFonts.getFont(
                                        'Mitr',
                                        color: Color(0xFF8E8E8E),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
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
                                      "ไม่มีเวรของคุณวันนี้",
                                      style: GoogleFonts.getFont(
                                        'Mitr',
                                        color: Color(0xFF8E8E8E),
                                        fontSize: 16,
                                      ),
                                    )));
                              }
                              // ตัวนี้คือนำเวรเช้า บ่าย ดึก มาเก็บไว้ใน list
                              List<dynamic> getMyduty = [
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
                                  // Align(
                                  //   alignment: AlignmentDirectional(-1, 0),
                                  //   child: Padding(
                                  //     padding: EdgeInsetsDirectional.fromSTEB(
                                  //         5, 5, 0, 0),
                                  //     child: Text(
                                  //       '${listViewPresent.first.group}',
                                  //       style: FlutterFlowTheme.of(context)
                                  //           .bodyText1
                                  //           .override(
                                  //             fontFamily: 'Mitr',
                                  //             color:
                                  //                 FlutterFlowTheme.of(context)
                                  //                     .secondaryButtonDarkBlue,
                                  //           ),
                                  //     ),
                                  //   ),
                                  // ),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
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
                                ],
                              );
                            } on RangeError {
                              return Container(
                                  height: 50.0,
                                  child: Center(
                                      child: Text(
                                          "ตารางเวรเดือนนี้ยังไม่ได้สร้างหรือจัด")));
                            } catch (error) {
                              print("error = $error");
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
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
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

                    Builder(builder: (context) {
                      return FutureBuilder<List<DutyWithOutModel>>(
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
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                ),
                              ),
                            );
                          }
                          final listViewWithOut = snapshotWithOutMe.data!;
                          // print(
                          //     "listViewWithOut ${listViewWithOut.first.duty!.first.month}");

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
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: listViewWithOut.length,
                                itemBuilder: (context, indexWithOut) {
                                  print("arms8888 ${indexWithOut}");
                                  final itemWithOut =
                                      listViewWithOut[indexWithOut];
                                  final itemFristName =
                                      itemWithOut.user!.fristName;
                                  final itemLastName =
                                      itemWithOut.user!.lastName;

                                  // itemWithOut.id
                                  // print("itemFristName $itemFristName");
                                  // print("itemLastName $itemLastName");

                                  return Builder(builder: (context) {
                                    return ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: itemWithOut.duty!.length,
                                        itemBuilder:
                                            (context, indexWithOutMeDuty) {
                                          // print("วันที่ $indexWithOutMeDuty");
                                          final itemWityOutMeDuty = itemWithOut
                                              .duty![indexWithOutMeDuty];
                                          // print(
                                          //     "itemWityOutMeDuty ${itemWityOutMeDuty.year}")
                                          print(
                                              "uuuu ${int.parse(itemWityOutMeDuty.month.toString())} ${int.parse(calendarSelectedmonthString)}");
                                          try {
                                            if (int.parse(itemWityOutMeDuty
                                                        .year
                                                        .toString()) ==
                                                    int.parse(
                                                        calendarSelectedyearString) &&
                                                int.parse(itemWityOutMeDuty
                                                        .month
                                                        .toString()) ==
                                                    int.parse(
                                                        calendarSelectedmonthString) &&
                                                int.parse(itemWityOutMeDuty.day
                                                        .toString()) ==
                                                    int.parse(
                                                        calendarSelectedDayString)) {
                                              if (itemWityOutMeDuty.count ==
                                                  0) {
                                                if (index1 == 0) {
                                                  index1 += 1;
                                                  return Container(
                                                    height: 100.0,
                                                    width: 100.0,
                                                    child: Center(
                                                      child: Text(
                                                          'ไม่มีเวรวันนี้'),
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

                                              // for (int y = 0; y < 3; y++) {
                                              //   if (dutylist[y] != 0) {
                                              //     saveindex += 1;
                                              //     print(
                                              //         "saveindex1 $saveindex");
                                              //   }
                                              // }

                                              // itemmemberinday.addAll({
                                              //   "50": [].add(saveindex),
                                              // });
                                              // // saveindex = -1;

                                              // print(
                                              //     "armmmmmm $itemmemberinday");

                                              return Builder(
                                                  builder: (context) {
                                                print("object");
                                                // แสดงเวรของเพื่อน
                                                return ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    itemCount: 3,
                                                    itemBuilder: (context,
                                                        indexDutyList) {
                                                      if (dutylist[
                                                              indexDutyList] ==
                                                          0) {
                                                        return SizedBox();
                                                      }
                                                      final selected = dutylist[
                                                          indexDutyList];

                                                      // print(
                                                      //     "checkboxValuesbool ${checkboxValuesbool}");
                                                      // if (saveindex ==)

                                                      // print(
                                                      //     "saveindex $saveindex");
                                                      return selete == true
                                                          ? FlutterFlowCheckboxGroup(
                                                              idSelect:
                                                                  itemWityOutMeDuty
                                                                      .id
                                                                      .toString(),
                                                              userIDSelect:
                                                                  itemWityOutMeDuty
                                                                      .user
                                                                      .toString(),
                                                              yearSelect: int.parse(
                                                                  itemWityOutMeDuty
                                                                      .year
                                                                      .toString()),
                                                              monthSelect: int.parse(
                                                                  itemWityOutMeDuty
                                                                      .month
                                                                      .toString()),
                                                              daySelect: int.parse(
                                                                  itemWityOutMeDuty
                                                                      .day
                                                                      .toString()),
                                                              groupSelect:
                                                                  itemWityOutMeDuty
                                                                      .group
                                                                      .toString(),
                                                              vSelect:
                                                                  itemWityOutMeDuty
                                                                      .v!,
                                                              dutyStringSelect:
                                                                  "${dayDutyEnglist[indexDutyList]}",
                                                              dutyNumberSelect:
                                                                  1,
                                                              day: int.parse(
                                                                  calendarSelectedDayString
                                                                      .toString()),
                                                              index:
                                                                  indexDutyList,
                                                              checkboxValues:
                                                                  checkboxValues,
                                                              checkboxbool:
                                                                  checkboxdaybool,
                                                              selected:
                                                                  selected,
                                                              onChanged: (val,
                                                                  id,
                                                                  userID,
                                                                  year,
                                                                  month,
                                                                  day,
                                                                  group,
                                                                  v,
                                                                  dutyString,
                                                                  dutyNumber,
                                                                  isSelected) {
                                                                setState(() =>
                                                                    checkboxGroupValues =
                                                                        val);

                                                                print(
                                                                    "val $val $id $userID $isSelected");
                                                                print(
                                                                    checkboxGroupValues);
                                                                // เมื่อมีการกดติก
                                                                if (isSelected ==
                                                                    true) {
                                                                  // dutySelectwithoutme
                                                                  //     .add({
                                                                  //   "id": id,
                                                                  //   "userID":
                                                                  //       userID,
                                                                  //   "year":
                                                                  //       year,
                                                                  //   "month":
                                                                  //       month,
                                                                  //   "day": day,
                                                                  //   "group":
                                                                  //       group,
                                                                  //   "v": v,
                                                                  //   "dutyString":
                                                                  //       dutyString,
                                                                  //   "dutyNumber":
                                                                  //       dutyNumber,
                                                                  // });
                                                                  Me reStringtoClass =
                                                                      Me.fromJson({
                                                                    "id":
                                                                        "${itemWityOutMeDuty.id}",
                                                                    "userID":
                                                                        "${itemWityOutMeDuty.user}",
                                                                    "year": int.parse(
                                                                        itemWityOutMeDuty
                                                                            .year
                                                                            .toString()),
                                                                    "month": int.parse(
                                                                        itemWityOutMeDuty
                                                                            .month
                                                                            .toString()),
                                                                    "day": int.parse(
                                                                        itemWityOutMeDuty
                                                                            .day
                                                                            .toString()),
                                                                    "group":
                                                                        "${itemWityOutMeDuty.group.toString()}",
                                                                    "v":
                                                                        itemWityOutMeDuty
                                                                            .v!,
                                                                    "dutyString":
                                                                        "${dayDutyEnglist[indexDutyList]}",
                                                                    "dutyNumber":
                                                                        1,
                                                                  });
                                                                  String
                                                                      classtojson =
                                                                      meallToJson(
                                                                          reStringtoClass);

                                                                  print(
                                                                      "ทำงานน");
                                                                  print(
                                                                      "tttt $classtojson");

                                                                  // FFAppState()
                                                                  //     .dutySelectwithoutme
                                                                  //     .add(
                                                                  //         """{"id": $id,"userID":$userID,"year":$year,"month":$month,"day": $day,"group":$group,"v": $v,"dutyString":$dutyString,"dutyNumber":$dutyNumber,}""");
                                                                  FFAppState()
                                                                      .dutySelectwithoutme
                                                                      .add(
                                                                          classtojson);
                                                                  print(
                                                                      "dutySelectwithoutme1 ${FFAppState().dutySelectwithoutme}");
                                                                } else {
                                                                  //                                             widget.listvievDutySearch

                                                                  // .where((u) =>
                                                                  //     u.email!.toLowerCase().toString().contains(string))
                                                                  // .toList();
                                                                  // ค้นหาตำแหน่งคำที่ต้องการลบ
                                                                  int remove = FFAppState().dutySelectwithoutme.indexWhere((u) =>
                                                                      u.toString().contains("$id") &&
                                                                      u.toString().contains(
                                                                          "$dutyString") &&
                                                                      u.toString().contains(
                                                                          "$day") &&
                                                                      u.toString().contains(
                                                                          "$month") &&
                                                                      u.toString().contains(
                                                                          "$year"));
                                                                  // print(
                                                                  //     "removetest $remove");
                                                                  // int remove = dutySelectwithoutme.indexWhere((note) =>
                                                                  //     note
                                                                  //         .toString()
                                                                  //         .contains(
                                                                  //             "$id") &&
                                                                  //     note
                                                                  //         .toString()
                                                                  //         .contains(
                                                                  //             "$dutyString"));
                                                                  if (remove !=
                                                                      -1) {
                                                                    FFAppState()
                                                                        .dutySelectwithoutme
                                                                        .removeAt(
                                                                            remove);
                                                                    // dutySelectwithoutme
                                                                    //     .removeAt(
                                                                    //         remove);
                                                                  }
                                                                  print(
                                                                      "dutySelectwithoutme ${FFAppState().dutySelectwithoutme}");
                                                                }
                                                              },
                                                              activeColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryColor,
                                                              checkColor:
                                                                  Colors.white,
                                                              checkboxBorderColor:
                                                                  Color(
                                                                      0xFF95A1AC),
                                                              textStyle:
                                                                  GoogleFonts
                                                                      .getFont(
                                                                'Mitr',
                                                                color: Color(
                                                                    0xFF8E8E8E),
                                                                fontSize: 16,
                                                              ),
                                                              // initiallySelected:
                                                              //     checkboxGroupValues,
                                                              child: SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1.17,
                                                                child:
                                                                    Container(
                                                                  child: Card(
                                                                    clipBehavior:
                                                                        Clip.antiAliasWithSaveLayer,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryWhite,
                                                                    elevation:
                                                                        2,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              10,
                                                                              5,
                                                                              10,
                                                                              5),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
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
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            child:
                                                                                Image.network(
                                                                              'https://picsum.photos/seed/260/600',
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Text(
                                                                                // "ชื่อต้น",
                                                                                '$itemFristName',
                                                                                style: FlutterFlowTheme.of(context).title2,
                                                                              ),
                                                                              Text(
                                                                                // " นามสกุล",
                                                                                ' $itemLastName',
                                                                                style: FlutterFlowTheme.of(context).title2,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Text(
                                                                            "${dayDuty[indexDutyList]}",
                                                                            // "เช้า",
                                                                            // IndexWithOutDay เพราะ กรองindexที่จะเข้ามา
                                                                            // '${dayDuty[IndexWithOutList]}',
                                                                            style:
                                                                                FlutterFlowTheme.of(context).title2,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              // initialized: checkboxGroupValues != null,
                                                            )
                                                          : Slidable(
                                                              endActionPane:
                                                                  ActionPane(
                                                                motion:
                                                                    const ScrollMotion(),
                                                                children: [
                                                                  SlidableAction(
                                                                    onPressed:
                                                                        (context) async {
                                                                      FFAppState()
                                                                          .dutySelectwithoutme
                                                                          .add(
                                                                              """{"id": "${itemWityOutMeDuty.id}","userID":"${itemWityOutMeDuty.user}","year":${int.parse(itemWityOutMeDuty.year.toString())},"month":${int.parse(itemWityOutMeDuty.month.toString())},"day": ${int.parse(itemWityOutMeDuty.day.toString())},"group":"${itemWityOutMeDuty.group.toString()}","v": ${itemWityOutMeDuty.v!},"dutyString":"${dayDutyEnglist[indexDutyList]}","dutyNumber":1}""");

                                                                      // Me ttt = Me
                                                                      //     .fromJson({
                                                                      //   "id":
                                                                      //       "${itemWityOutMeDuty.id}",
                                                                      //   "userID":
                                                                      //       "${itemWityOutMeDuty.user}",
                                                                      //   "year": int.parse(itemWityOutMeDuty
                                                                      //       .year
                                                                      //       .toString()),
                                                                      //   "month": int.parse(itemWityOutMeDuty
                                                                      //       .month
                                                                      //       .toString()),
                                                                      //   "day": int.parse(itemWityOutMeDuty
                                                                      //       .day
                                                                      //       .toString()),
                                                                      //   "group":
                                                                      //       "${itemWityOutMeDuty.group.toString()}",
                                                                      //   "v": itemWityOutMeDuty
                                                                      //       .v!,
                                                                      //   "dutyString":
                                                                      //       "${dayDutyEnglist[indexDutyList]}",
                                                                      //   "dutyNumber":
                                                                      //       1,
                                                                      // });
                                                                      // String
                                                                      //     tttt =
                                                                      //     meallToJson(
                                                                      //         ttt);

                                                                      // print(
                                                                      //     "ทำงานน");
                                                                      // print(
                                                                      //     "tttt $tttt");

                                                                      print(
                                                                          "dutySelectwithoutme ${FFAppState().dutySelectwithoutme}");
                                                                      if (FFAppState()
                                                                              .dutySelectwithoutme
                                                                              .length ==
                                                                          1) {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => SelectExchangeWorkscheduleWidget()));
                                                                      } else {
                                                                        await notifica(
                                                                            context,
                                                                            "กรุณาลองใหม่อีกครั้งเนื่องจากรายการที่เลือกมากกว่า 1");
                                                                        FFAppState().dutySelectwithoutme =
                                                                            [];
                                                                      }

                                                                      // yy.add(xx);
                                                                      // yy.add(xx);
                                                                      // print(yy);
                                                                      // print(
                                                                      //     "ttt $itemFristName $itemLastName  เวรที่เลือก ${dutylist[indexDutyList]} เวรทั้งหมด ${dayDutyEnglist[indexDutyList]}");
                                                                      // Navigator
                                                                      //     .push(
                                                                      //   context,
                                                                      //   MaterialPageRoute(
                                                                      //     builder: (context) =>
                                                                      //         SelectExchangeWorkscheduleWidget(
                                                                      //       id: itemWityOutMeDuty.id.toString(),
                                                                      //       userID:
                                                                      //           itemWityOutMeDuty.user.toString(),
                                                                      //       year:
                                                                      //           int.parse(itemWityOutMeDuty.year.toString()),
                                                                      //       month:
                                                                      //           int.parse(itemWityOutMeDuty.month.toString()),
                                                                      //       day:
                                                                      //           int.parse(itemWityOutMeDuty.day.toString()),
                                                                      //       group:
                                                                      //           itemWityOutMeDuty.group.toString(),
                                                                      //       v: itemWityOutMeDuty.v,
                                                                      //       dutyString:
                                                                      //           "${dayDutyEnglist[indexDutyList]}",
                                                                      //       dutyNumber:
                                                                      //           1,
                                                                      //     ),
                                                                      //   ),
                                                                      // );
                                                                    },
                                                                    backgroundColor:
                                                                        Color(
                                                                            0xFFF00A2FD),
                                                                    foregroundColor:
                                                                        Colors
                                                                            .white,
                                                                    icon: Icons
                                                                        .change_circle,
                                                                    label:
                                                                        'แลกเปลี่ยน',
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Container(
                                                                child: Card(
                                                                  clipBehavior:
                                                                      Clip.antiAliasWithSaveLayer,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryWhite,
                                                                  elevation: 2,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      Padding(
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
                                                                          child:
                                                                              Image.network(
                                                                            'https://picsum.photos/seed/260/600',
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Text(
                                                                              // "ชื่อต้น",
                                                                              '$itemFristName',
                                                                              style: FlutterFlowTheme.of(context).title2,
                                                                            ),
                                                                            Text(
                                                                              // " นามสกุล",
                                                                              ' $itemLastName',
                                                                              style: FlutterFlowTheme.of(context).title2,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                          "${dayDuty[indexDutyList]}",
                                                                          // "เช้า",
                                                                          // IndexWithOutDay เพราะ กรองindexที่จะเข้ามา
                                                                          // '${dayDuty[IndexWithOutList]}',
                                                                          style:
                                                                              FlutterFlowTheme.of(context).title2,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                    });
                                              });
                                            }
                                          } catch (error) {
                                            if (errorduty) {
                                              errorduty = false;
                                              return Center(
                                                child: Text("เกิดข้อผิดพลาด"),
                                              );
                                            }
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
                      );
                    }),
                    Container(
                      width: 100.0,
                      height: 100.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
