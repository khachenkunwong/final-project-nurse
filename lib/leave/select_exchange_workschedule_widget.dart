import 'package:hos_mobile2/custom_code/actions/index.dart';

import '../backend/api_requests/api_calls.dart';
import '../backend/pubilc_.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/dutyseletewithoutme_model.dart';
import '../model/present_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SelectExchangeWorkscheduleWidget2 extends StatefulWidget {
  Map<String, dynamic> dutyStore;
  List dutyList;
  SelectExchangeWorkscheduleWidget2(
      {Key? key, required this.dutyList, required this.dutyStore})
      : super(key: key);

  @override
  _SelectExchangeWorkscheduleWidget2State createState() =>
      _SelectExchangeWorkscheduleWidget2State();
}

class _SelectExchangeWorkscheduleWidget2State
    extends State<SelectExchangeWorkscheduleWidget2> {
  DateTimeRange? calendarSelectedDay;
  Future<List<DutyPresent>>? futurePresent;
  Completer<ApiCallResponse>? _apiRequestCompleter2;
  List dayDuty = ["เช้า", "บ่าย", "ดึก"];
  List dayDutyEnglist = ["morning", "noon", "night"];
  final scaffoldKey = GlobalKey<ScaffoldState>();
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

  Future<void> _refresh() async {
    return await Future.delayed(Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    print("เริ่มหน้าแลกเวร");
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    futurePresent = getPresentModel(token: FFAppState().tokenStore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBlue01,
        automaticallyImplyLeading: true,
        title: Text(
          'กรุณาเลือกเวรของคุณ',
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Mitr',
                color: FlutterFlowTheme.of(context).secondaryWhite,
              ),
        ),
        actions: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Text(
              'เลือก',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Mitr',
                    color: FlutterFlowTheme.of(context).secondaryWhite,
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
          // height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground1,
          ),
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.99,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FlutterFlowCalendar(
                      daysOfWeekHeight: 18,
                      color: FlutterFlowTheme.of(context).primaryColor,
                      weekFormat: false,
                      weekStartsMonday: false,
                      // yearduty: widget.year,
                      // monthduty: widget.month,
                      // dayduty: widget.day,
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
                              .toString();
                          calendarSelectedyearString = calendarSelectedDay
                              .toString()
                              .split(" - ")[0]
                              .split(" ")[0]
                              .split("-")[0]
                              .toString();
                          print(
                              "calendarSelectedmonthString22 ${calendarSelectedmonthString}");
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
                            // print(
                            //     "aaaa${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].month} != ${calendarSelectedmonthString}");
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
                            // if (listViewPresent[int.parse(
                            //                 calendarSelectedDayString
                            //                     .toString()) -
                            //             1]
                            //         .count ==
                            //     0) {
                            //   return Container(
                            //       height: 50.0,
                            //       child: Center(
                            //           child: Text("ไม่มีเวรของคุณวันนี้")));
                            // }
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
                                    setState(
                                        () => _apiRequestCompleter2 = null);
                                    await waitForApiRequestCompleter2();
                                  },
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 3,
                                    itemBuilder: (context, indexPresent) {
                                      print("aaaaaa ${getMyduty}");
                                      // ถ้า เช้า บ่าย ดึก ไม่มีก็จะแสดงเป็น box ว่าง แต่ถ้า เช้ามีแต่บ่ายกับดึกไม่มีก็จะแสดงแต่เช้า
                                      if (getMyduty[indexPresent] == 1) {
                                        
                                        return InkWell(
                                          onTap: () async {
                                            widget.dutyStore = {
                                              "idDuty":
                                                  "${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].id}",
                                              "duty":
                                                  "${dayDutyEnglist[indexPresent]}",
                                              "numberDuty": getMyduty[indexPresent],
                                              "firstname": "${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.fristName}",
                                              "lastname": "${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.lastName}"
                                            };
                                            Navigator.pop(
                                                context, widget.dutyStore);
                                          },
                                          child: Card(
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 5, 10, 5),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
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
                                                        '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.fristName}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title2,
                                                      ),
                                                      Text(
                                                        ' ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.lastName}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title2,
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    // dayDuty คือ list เช้า บ่าย ดึกที่เตรียมไว้
                                                    // getMydutyIndex คือ index การ loop ของ listview
                                                    '${dayDuty[indexPresent]}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .title2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      print("aaaaaa เข้าเงื่อนไขด้านล่าง");
                                      return SizedBox();
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
                  Container(
                    width: 50.0,
                    height: 50.0,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
