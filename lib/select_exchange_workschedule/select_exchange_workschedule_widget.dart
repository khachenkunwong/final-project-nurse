import 'package:hos_mobile2/custom_code/actions/index.dart';

import '../backend/api_requests/api_calls.dart';
import '../backend/pubilc_.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_checkbox_group.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/present_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SelectExchangeWorkscheduleWidget extends StatefulWidget {
  String? id;
  String? userID;
  int? year;
  int? month;
  int? day;
  String? group;
  int? v;

  /// ใน list มี [monning, noon, nignt]
  String? dutyString;

  /// เป็นตัวกำหนดว่าเวรว่างหรือไม่
  int? dutyNumber;

  /// แลกเวร
  SelectExchangeWorkscheduleWidget(
      {Key? key,
      this.id,
      this.userID,
      this.day,
      this.month,
      this.year,
      this.group,
      this.v,
      this.dutyString,
      this.dutyNumber})
      : super(key: key);

  @override
  _SelectExchangeWorkscheduleWidgetState createState() =>
      _SelectExchangeWorkscheduleWidgetState();
}

class _SelectExchangeWorkscheduleWidgetState
    extends State<SelectExchangeWorkscheduleWidget> {
  DateTimeRange? calendarSelectedDay;
  Future<List<DutyPresent>>? futurePresent;
  Completer<ApiCallResponse>? _apiRequestCompleter2;
  List dayDuty = ["เช้า", "บ่าย", "ดึก"];
  List dayDutyEnglist = ["morning", "noon", "night"];
  Map<int, List<bool>> checkboxdaybool = {};
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late String calendarSelectedDayString;
  late String calendarSelectedmonthString;
  late String calendarSelectedyearString;
  bool selete = false;
  List<String> checkboxGroupValues = [];
  List<String> checkboxValues = [];
  /// ใช้สำหรับจำนวนจุด even บนปฎิทิน
  Map<int, List<dynamic>> numberPointEven = {};

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
      final _futureMeAll = PresentModel.fromJson(body);
      final futureMeAll = _futureMeAll.duty as List<DutyPresent>;
      for (int i = 1; i < futureMeAll.length + 1; i++) {
        checkboxdaybool.addAll({
          i: [false, false, false]
        });
        // checkboxbool.add("":[]);
      }
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

      // print("futureMeAll ${futureMeAll[0].day}");
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FFAppState().dutySelectme = [];
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
          selete == true
              ? Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: TextButton(
                    onPressed: () async {
                      // ส่งข้อมูลไปยัง api
                      if (FFAppState().dutySelectme.isNotEmpty) {
                        Navigator.pop(context);
                      } else {
                        await notifica(context, "กรุณาเลือกรายการ",
                            color: Colors.yellow, textColor: Colors.black);
                      }
                    },
                    child: Text(
                      "แลกเวร",
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Mitr',
                            color: FFAppState().dutySelectme.isNotEmpty
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
                  FFAppState().dutySelectme = [];
                  print(
                      "FFAppState().dutySelectme = ${FFAppState().dutySelectme}");
                }
                ;
              },
              child: Text(
                selete ? 'ยกเลิก' : "เลือก",
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Mitr',
                      color: selete == true
                          ? FlutterFlowTheme.of(context).primaryRed
                          : FlutterFlowTheme.of(context).secondaryWhite,
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
                    child: FutureBuilder<List<DutyPresent>>(
                          future: futurePresent,
                          builder: (context, snapshotfuturePresent) {
                        return FlutterFlowCalendar(
                          daysOfWeekHeight: 18,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          weekFormat: false,
                          weekStartsMonday: false,
                          yearduty: widget.year,
                          monthduty: widget.month,
                          dayduty: widget.day,
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
                                  "calendarSelectedmonthString $calendarSelectedDayString");
                            });
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
                        );
                      }
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
                      // print("checkboxdaybool $checkboxdaybool");

                      return Builder(
                        builder: (context) {
                          try {
                            // print(
                            //     "aaaa${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].month} != ${calendarSelectedmonthString}");
                            // if (listViewPresent[int.parse(
                            //                     calendarSelectedDayString
                            //                         .toString()) -
                            //                 1]
                            //             .year !=
                            //         calendarSelectedyearString ||
                            //     listViewPresent[int.parse(
                            //                     calendarSelectedDayString
                            //                         .toString()) -
                            //                 1]
                            //             .month !=
                            //         calendarSelectedmonthString) {
                            //   return Center(
                            //     child: Text("ไม่มีข้อมูลเวรของเดือนนี้"),
                            //   );
                            // }
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
                            print("object $getMyduty");

                            // print(listViewGetPresentResponse[
                            //         int.parse(calendarSelectedDayString) - 1]
                            //     .morning);
                            // เมื่อปัดลงจะทำการโหลดค่าข้างในใหม่
                            print("checkboxdaybool ${checkboxdaybool[1]}");
                            print(
                                "listViewPresent ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].day}");
                            return Column(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 0, 0),
                                    child: Text(
                                      'ชื่อกลุ่ม ${listViewPresent.first.group}',
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
                                      final selected = getMyduty[indexPresent];
                                      // ถ้า เช้า บ่าย ดึก ไม่มีก็จะแสดงเป็น box ว่าง แต่ถ้า เช้ามีแต่บ่ายกับดึกไม่มีก็จะแสดงแต่เช้า
                                      if (getMyduty[indexPresent] == 0) {
                                        return selete == false
                                            ? InkWell(
                                                onTap: () async {
                                                  FFAppState().dutySelectme =
                                                      [];
                                                  print("รอส่งค่าไปยัง api");
                                                  FFAppState().dutySelectme.add(
                                                      """{"id": ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].id},"userID":${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.id},"year":${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].year},"month":${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].month},"day": ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].day},"group":${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].group},"v": ${int.parse("${listViewPresent[int.parse(calendarSelectedDayString) - 1].v}")},"dutyString":${dayDutyEnglist[indexPresent]},"dutyNumber":0,}""");
                                                  print(
                                                      "dutySelectwithoutme ${FFAppState().dutySelectme.length}");
                                                  if (FFAppState()
                                                          .dutySelectme
                                                          .length ==
                                                      1) {
                                                    Navigator.pop(context);
                                                  } else {
                                                    await notifica(context,
                                                        "กรุณาลองใหม่อีกครั้งเนื่องจากรายการที่เลือกมากกว่า 1");
                                                    FFAppState().dutySelectme =
                                                        [];
                                                  }

                                                  // รอเชื่อม api
                                                  // final outputchangduty = await ChangDutyCall.call(
                                                  //     idOne: '${widget.id}',
                                                  //     idUserOne:
                                                  //         '${widget.userID}',
                                                  //     yearOne: '${widget.year}',
                                                  //     monthOne:
                                                  //         '${widget.month}',
                                                  //     dayOne: '${widget.day}',
                                                  //     groupOne:
                                                  //         '${widget.group}',
                                                  //     vOne: int.parse(
                                                  //         widget.v.toString()),
                                                  //     dutyChooseOne:
                                                  //         '${widget.dutyString}',
                                                  //     dutyChooseNumberOne:
                                                  //         int.parse(widget
                                                  //             .dutyNumber
                                                  //             .toString()),
                                                  //     idTwo:
                                                  //         '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].id}',
                                                  //     idUserTwo:
                                                  //         '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.id}',
                                                  //     yearTwo:
                                                  //         '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].year}',
                                                  //     monthTwo:
                                                  //         '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].month}',
                                                  //     dayTwo:
                                                  //         '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].day}',
                                                  //     groupTwo:
                                                  //         '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].group}',
                                                  //     vTwo: int.parse(listViewPresent[
                                                  //             int.parse(calendarSelectedDayString
                                                  //                     .toString()) -
                                                  //                 1]
                                                  //         .v
                                                  //         .toString()),
                                                  //     dutyChooseTwo:
                                                  //         '${dayDutyEnglist[indexPresent]}',
                                                  //     dutyChooseNumberTwo:
                                                  //         getMyduty[indexPresent]);
                                                  // if (outputchangduty
                                                  //         .statusCode ==
                                                  //     200) {
                                                  //   await notifica(
                                                  //       context, "แลกสำเร็จ",
                                                  //       color: Colors.green);
                                                  //   print(
                                                  //       "changDutyCall ${ChangDutyCall.resState(outputchangduty)}");

                                                  //   print(
                                                  //       "id ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].id}");
                                                  //   print(
                                                  //       "id user ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.id}");
                                                  //   print(
                                                  //       "fristName ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.fristName}");
                                                  //   print(
                                                  //       "lastName ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.lastName}");
                                                  //   print(
                                                  //       "actor ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.actor}");
                                                  //   print(
                                                  //       "year ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].year}");
                                                  //   print(
                                                  //       "month ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].month}");
                                                  //   print(
                                                  //       "day ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].day}");
                                                  //   print(
                                                  //       "group ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].group}");
                                                  //   print(
                                                  //       "count ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].count}");
                                                  //   print(
                                                  //       "__v ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].v}");

                                                  //   print(
                                                  //       "${dayDutyEnglist[indexPresent]}");
                                                  //   Navigator.pop(context);
                                                  // } else {
                                                  //   await notifica(context,
                                                  //       "แลกไม่สำเร็จ");
                                                  // }
                                                },
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.17,
                                                  child: Card(
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    color: Colors.white,
                                                    elevation: 2,
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child:
                                                                Image.network(
                                                              'https://picsum.photos/seed/260/600',
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
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
                                                            '${dayDuty[indexPresent]}ว่าง',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .title2,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : FlutterFlowCheckboxGroup(
                                                idSelect:
                                                    '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].id}',
                                                userIDSelect:
                                                    '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.id}',
                                                yearSelect: int.parse(
                                                    '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].year}'),
                                                monthSelect: int.parse(
                                                    '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].month}'),
                                                daySelect: int.parse(
                                                    '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].day}'),
                                                groupSelect:
                                                    '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].group}',
                                                vSelect: int.parse(
                                                    '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].v}'),
                                                dutyStringSelect:
                                                    '${dayDutyEnglist[indexPresent]}',
                                                dutyNumberSelect: int.parse(
                                                    "${getMyduty[indexPresent]}"),
                                                day: int.parse(
                                                    calendarSelectedDayString
                                                        .toString()),
                                                // month: int.parse(
                                                //     calendarSelectedmonthString
                                                //         .toString()),
                                                // year: int.parse(
                                                //     calendarSelectedyearString
                                                //         .toString()),
                                                // data: listViewPresent,
                                                index: indexPresent,
                                                checkboxValues: checkboxValues,
                                                checkboxbool: checkboxdaybool,
                                                selected: selected,
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
                                                  // เมื่อมีการกดติก
                                                  if (isSelected == true) {
                                                    FFAppState().dutySelectme.add(
                                                        """{"id": $id,"userID":$userID,"year":$year,"month":$month,"day": $day,"group":$group,"v": $v,"dutyString":$dutyString,"dutyNumber":$dutyNumber,}""");
                                                    print(
                                                        "dutySelectme ${FFAppState().dutySelectme}");
                                                  } else {
                                                    // ค้นหาตำแหน่งคำที่ต้องการลบ
                                                    int remove = FFAppState()
                                                        .dutySelectme
                                                        .indexWhere((u) =>
                                                            u
                                                                .toString()
                                                                .contains(
                                                                    "$id") &&
                                                            u.toString().contains(
                                                                "$dutyString") &&
                                                            u
                                                                .toString()
                                                                .contains(
                                                                    "$day") &&
                                                            u
                                                                .toString()
                                                                .contains(
                                                                    "$month") &&
                                                            u
                                                                .toString()
                                                                .contains(
                                                                    "$year"));

                                                    if (remove != -1) {
                                                      FFAppState()
                                                          .dutySelectme
                                                          .removeAt(remove);
                                                      // dutySelectwithoutme
                                                      //     .removeAt(
                                                      //         remove);
                                                    }
                                                    print(
                                                        "dutySelectme ${FFAppState().dutySelectme}");
                                                  }
                                                },
                                                activeColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
                                                checkColor: Colors.white,
                                                checkboxBorderColor:
                                                    Color(0xFF95A1AC),
                                                textStyle: GoogleFonts.getFont(
                                                  'Mitr',
                                                  color: Color(0xFF8E8E8E),
                                                  fontSize: 16,
                                                ),
                                                initiallySelected:
                                                    checkboxGroupValues,
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.17,
                                                  child: Card(
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    color: Colors.white,
                                                    elevation: 2,
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child:
                                                                Image.network(
                                                              'https://picsum.photos/seed/260/600',
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
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
                                                            '${dayDuty[indexPresent]}ว่าง',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .title2,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                      }
                                      print("aaaaaa เข้าเงื่อนไขด้านล่าง");
                                      return selete == false
                                          ? InkWell(
                                              onTap: () async {
                                                FFAppState().dutySelectme = [];

                                                print("รอส่งค่าไปยัง api");
                                                FFAppState().dutySelectme.add(
                                                    """{"id": ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].id},"userID":${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.id},"year":${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].year},"month":${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].month},"day": ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].day},"group":${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].group},"v": ${int.parse("${listViewPresent[int.parse(calendarSelectedDayString) - 1].v}")},"dutyString":${dayDutyEnglist[indexPresent]},"dutyNumber":0,}""");
                                                print(
                                                    "dutySelectwithoutme ${FFAppState().dutySelectme.length}");
                                                if (FFAppState()
                                                        .dutySelectme
                                                        .length ==
                                                    1) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SelectExchangeWorkscheduleWidget()));
                                                } else {
                                                  await notifica(context,
                                                      "กรุณาลองใหม่อีกครั้งเนื่องจากรายการที่เลือกมากกว่า 1");
                                                  FFAppState().dutySelectme =
                                                      [];
                                                }
                                                // รอเชื่อม api
                                                // final outputchangduty = await ChangDutyCall.call(
                                                //     idOne: '${widget.id}',
                                                //     idUserOne:
                                                //         '${widget.userID}',
                                                //     yearOne: '${widget.year}',
                                                //     monthOne: '${widget.month}',
                                                //     dayOne: '${widget.day}',
                                                //     groupOne: '${widget.group}',
                                                //     vOne: int.parse(
                                                //         widget.v.toString()),
                                                //     dutyChooseOne:
                                                //         '${widget.dutyString}',
                                                //     dutyChooseNumberOne:
                                                //         int.parse(widget
                                                //             .dutyNumber
                                                //             .toString()),
                                                //     idTwo:
                                                //         '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].id}',
                                                //     idUserTwo:
                                                //         '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.id}',
                                                //     yearTwo:
                                                //         '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].year}',
                                                //     monthTwo:
                                                //         '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].month}',
                                                //     dayTwo:
                                                //         '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].day}',
                                                //     groupTwo:
                                                //         '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].group}',
                                                //     vTwo: int.parse(listViewPresent[
                                                //             int.parse(calendarSelectedDayString
                                                //                     .toString()) -
                                                //                 1]
                                                //         .v
                                                //         .toString()),
                                                //     dutyChooseTwo:
                                                //         '${dayDutyEnglist[indexPresent]}',
                                                //     dutyChooseNumberTwo:
                                                //         getMyduty[
                                                //             indexPresent]);
                                                // if (outputchangduty
                                                //         .statusCode ==
                                                //     200) {
                                                //   await notifica(context,
                                                //       "ส่งคำขอแลกเวรแล้ว",
                                                //       color: Colors.green);
                                                //   print(
                                                //       "changDutyCall ${ChangDutyCall.resState(outputchangduty)}");
                                                //   print(
                                                //       "id ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].id}");
                                                //   print(
                                                //       "id user ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.id}");
                                                //   print(
                                                //       "fristName ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.fristName}");
                                                //   print(
                                                //       "lastName ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.lastName}");
                                                //   print(
                                                //       "actor ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.actor}");
                                                //   print(
                                                //       "year ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].year}");
                                                //   print(
                                                //       "month ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].month}");
                                                //   print(
                                                //       "day ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].day}");
                                                //   print(
                                                //       "group ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].group}");
                                                //   print(
                                                //       "count ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].count}");
                                                //   print(
                                                //       "__v ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].v}");

                                                //   print(
                                                //       "${dayDutyEnglist[indexPresent]}");
                                                //   Navigator.pop(context);
                                                // } else {
                                                //   await notifica(context,
                                                //       "ส่งคำขอไม่สำเร็จ");
                                                // }
                                              },
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.17,
                                                child: Card(
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBlue02,
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
                                                              '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.fristName}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .title2,
                                                            ),
                                                            Text(
                                                              ' ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.lastName}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .title2,
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          // dayDuty คือ list เช้า บ่าย ดึกที่เตรียมไว้
                                                          // getMydutyIndex คือ index การ loop ของ listview
                                                          '${dayDuty[indexPresent]}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .title2,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          // ใส่ชื่อนามกุล duty
                                          : FlutterFlowCheckboxGroup(
                                              idSelect:
                                                  '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].id}',
                                              userIDSelect:
                                                  '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.id}',
                                              yearSelect: int.parse(
                                                  '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].year}'),
                                              monthSelect: int.parse(
                                                  '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].month}'),
                                              daySelect: int.parse(
                                                  '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].day}'),
                                              groupSelect:
                                                  '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].group}',
                                              vSelect: int.parse(
                                                  '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].v}'),
                                              dutyStringSelect:
                                                  '${dayDutyEnglist[indexPresent]}',
                                              dutyNumberSelect: int.parse(
                                                  "${getMyduty[indexPresent]}"),
                                              day: int.parse(
                                                  calendarSelectedDayString
                                                      .toString()),
                                              // month: int.parse(
                                              //     calendarSelectedmonthString
                                              //         .toString()),
                                              // year: int.parse(
                                              //     calendarSelectedyearString
                                              //         .toString()),
                                              // data: listViewPresent,
                                              index: indexPresent,
                                              checkboxbool: checkboxdaybool,
                                              checkboxValues: checkboxValues,
                                              selected: selected,
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
                                                    checkboxGroupValues = val);
                                                // เมื่อมีการกดติก
                                                if (isSelected == true) {
                                                  FFAppState().dutySelectme.add(
                                                      """{"id": $id,"userID":$userID,"year":$year,"month":$month,"day": $day,"group":$group,"v": $v,"dutyString":$dutyString,"dutyNumber":$dutyNumber,}""");
                                                  print(
                                                      "dutySelectme ${FFAppState().dutySelectme}");
                                                } else {
                                                  // ค้นหาตำแหน่งคำที่ต้องการลบ
                                                  int remove = FFAppState()
                                                      .dutySelectme
                                                      .indexWhere((u) =>
                                                          u.toString().contains(
                                                              "$id") &&
                                                          u.toString().contains(
                                                              "$dutyString") &&
                                                          u.toString().contains(
                                                              "$day") &&
                                                          u.toString().contains(
                                                              "$month") &&
                                                          u.toString().contains(
                                                              "$year"));

                                                  if (remove != -1) {
                                                    FFAppState()
                                                        .dutySelectme
                                                        .removeAt(remove);
                                                    // dutySelectwithoutme
                                                    //     .removeAt(
                                                    //         remove);
                                                  }
                                                  print(
                                                      "dutySelectme ${FFAppState().dutySelectme}");
                                                }
                                              },
                                              activeColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                              checkColor: Colors.white,
                                              checkboxBorderColor:
                                                  Color(0xFF95A1AC),
                                              textStyle: GoogleFonts.getFont(
                                                'Mitr',
                                                color: Color(0xFF8E8E8E),
                                                fontSize: 16,
                                              ),
                                              initiallySelected:
                                                  checkboxGroupValues,

                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.17,
                                                child: Card(
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBlue02,
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
                                                              '${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.fristName}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .title2,
                                                            ),
                                                            Text(
                                                              ' ${listViewPresent[int.parse(calendarSelectedDayString.toString()) - 1].user!.lastName}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .title2,
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          // dayDuty คือ list เช้า บ่าย ดึกที่เตรียมไว้
                                                          // getMydutyIndex คือ index การ loop ของ listview
                                                          '${dayDuty[indexPresent]}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .title2,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
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
                            print("error = $error");
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
