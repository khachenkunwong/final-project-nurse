import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hos_mobile2/backend/pubilc_.dart';
import 'package:hos_mobile2/custom_code/actions/index.dart';
import 'package:hos_mobile2/leave/select_exchange_workschedule_widget.dart';

import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../model/listnameall_model_get.dart';

class LeaveWidget extends StatefulWidget {
  const LeaveWidget({Key? key}) : super(key: key);

  @override
  _LeaveWidgetState createState() => _LeaveWidgetState();
}

class _LeaveWidgetState extends State<LeaveWidget> {
  String? choiceChipsValue;
  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  TextEditingController? textController4;
  String? dropDownValue;
  List<String> nameListAll = [];
  int stopRerunSelectName = 0;
  List<ChipData> afterSelectName = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> dutyStore = {
    "idDuty": "",
    "duty": "",
    "numberDuty": 0,
    "firstname": "",
    "lastname": ""
  };
  List dutyList = [];

  createLeave(
      {required List<String> memberId,
      required String dutyId,
      required String dutyString,
      required int dutynumber}) async {
    var headers = {
      'Authorization': '${FFAppState().tokenStore}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$url/graphql'));
    String remeberId = memberId
        .toString()
        .replaceAll(' ', '\"')
        .replaceAll(' ', '\"')
        .replaceAll("\"\"", "\"");

    request.body =
        '''{"query":"\\r\\nmutation Mutation(\$input: CreateLeaveInput!) {\\r\\n  createLeave(input: \$input)\\r\\n}\\r\\n","variables":{"input":{"memberIds":$remeberId,"dutyId":"$dutyId","shift":{"$dutyString":$dutynumber}}}}''';
    print("request.body ${request.body}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      await notifica(context, "ส่งขอลาแล้ว", color: Colors.green);
      Navigator.pop(context);
    } else {
      print(response.reasonPhrase);
      await notifica(context, "ส่งคำขอไม่สำเร็จ");
    }
  }

  updataLeave(
      {required String type,
      required String detail,
      required String idDuty,
      required String duty,
      required int number}) async {
    final body = {
      "type": "$type",
      "detail": "$detail",
      "_duty": "$idDuty",
      "shift": {"$duty": number}
    };
    print(body);
    final res = await http.post(
        Uri.parse(
          "$url/api/req/take/leave",
        ),
        headers: {
          // 'Accept': 'application/json',
          'content-type': 'application/json',
          'Access-Control_Allow_Origin': '*',
          'x-access-token': '${FFAppState().tokenStore}'
        },
        body: jsonEncode(body));
    if (res.statusCode == 200) {
      await notifica(context, "ส่งคำขอสำเร็จ", color: Colors.green);
    } else {
      await notifica(context, "ส่งคำขอไม่สำเร็จ");
    }
  }

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
    print("หน้าลา");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBlue01,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.chevron_left,
            color: FlutterFlowTheme.of(context).secondaryWhite,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'การลา',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Mitr',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryWhite,
            ),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                        child: Text(
                          'ประเภทการลา',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Mitr',
                                color: FlutterFlowTheme.of(context).primaryGray,
                                fontSize: 18,
                              ),
                        ),
                      ),
                      Text(
                        '*',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Mitr',
                              color: FlutterFlowTheme.of(context).primaryRed,
                            ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: FlutterFlowChoiceChips(
                      initiallySelected: [
                        if (choiceChipsValue != null) choiceChipsValue!
                      ],
                      options: [
                        ChipData('ลาป่วย'),
                        ChipData('ลากิจส่วนตัว'),
                        ChipData('ลาคลอดบุตร'),
                        ChipData('ลาไปช่วยภริยาคลอดบุตร'),
                        ChipData('ลาไปศึกษา,ฝึกอบรม,ปฎิบัติการวิจัย,หรือดูงาน'),
                        ChipData('ลาคัดเลือกทหาร')
                      ],
                      onChanged: (val) =>
                          setState(() => choiceChipsValue = val?.first),
                      selectedChipStyle: ChipStyle(
                        backgroundColor:
                            FlutterFlowTheme.of(context).primaryBlue01,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily: 'Mitr',
                                  color: Colors.white,
                                ),
                        iconColor: Colors.white,
                        iconSize: 18,
                        elevation: 4,
                      ),
                      unselectedChipStyle: ChipStyle(
                        backgroundColor:
                            FlutterFlowTheme.of(context).secondaryWhite,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyText2
                            .override(
                              fontFamily: 'Mitr',
                              color: FlutterFlowTheme.of(context).primaryGray,
                              fontSize: 16,
                            ),
                        iconColor: FlutterFlowTheme.of(context).primaryGray,
                        iconSize: 18,
                        elevation: 4,
                      ),
                      chipSpacing: 20,
                      multiselect: false,
                      alignment: WrapAlignment.start,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                        child: Text(
                          'รายละเอียดของการลา',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Mitr',
                                color: FlutterFlowTheme.of(context).primaryGray,
                                fontSize: 18,
                              ),
                        ),
                      ),
                      // Text(
                      //   '*',
                      //   style: FlutterFlowTheme.of(context).bodyText1.override(
                      //         fontFamily: 'Mitr',
                      //         color: FlutterFlowTheme.of(context).primaryRed,
                      //       ),
                      // ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                    child: TextFormField(
                      controller: textController1,
                      onChanged: (_) => EasyDebounce.debounce(
                        'textController1',
                        Duration(milliseconds: 2000),
                        () => setState(() {}),
                      ),
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'กรุณากรอกลายละเอียด',
                        hintStyle: GoogleFonts.mitr(
                          color: Color(0xFFBDBDBD),
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFBDBDBD),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF727272),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: GoogleFonts.mitr(
                        color: Color(0xFF727272),
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                  //   child: FFButtonWidget(
                  //     onPressed: () {
                  //       print('Button pressed ...');
                  //     },
                  //     text: 'เพิ่ม',
                  //     icon: Icon(
                  //       Icons.attach_file,
                  //       size: 15,
                  //     ),
                  //     options: FFButtonOptions(
                  //       width: 130,
                  //       height: 40,
                  //       color: FlutterFlowTheme.of(context).primaryBlue01,
                  //       textStyle: FlutterFlowTheme.of(context).bodyText1,
                  //       borderSide: BorderSide(
                  //         color: Colors.transparent,
                  //         width: 1,
                  //       ),
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //   ),
                  // ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                        child: Text(
                          'เลือกเพื่อนที่ต้องการมาแทน',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Mitr',
                                color: FlutterFlowTheme.of(context).primaryGray,
                                fontSize: 18,
                              ),
                        ),
                      ),
                      Text(
                        '*',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Mitr',
                              color: FlutterFlowTheme.of(context).primaryRed,
                            ),
                      ),
                    ],
                  ),

                  Query(
                      options: QueryOptions(
                        document: gql(nameAll),
                      ),
                      builder: (QueryResult result, {fetchMore, refetch}) {
                        
                        if (result.hasException) {
                          return Text(result.exception.toString());
                        }
                        if (result.isLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        print("resultresult ${result.data}");
                        print("ttttt");
                        // final productList = Welcome.fromJson(result.data as Map<String, dynamic>);
                        // print(productList);
                        final nameList = GetListnameAll.fromJson(result.data!);
                        print("nameList ${nameList.users!.first.fristName}");
                        if (nameList.users?.isNotEmpty != null) {
                          if (stopRerunSelectName == 0) {
                            for (int i = 0; i < nameList.users!.length; i++) {
                              if (nameList.users![i].actor != "admin" &&
                                  nameList.users![i].actor != "ผู้อำนวยการ") {
                                nameListAll.add(
                                    "${nameList.users![i].fristName} ${nameList.users![i].lastName}");
                              }
                            }
                            stopRerunSelectName = 1;
                          }
                        }
                        return FlutterFlowDropDown(
                          // initialOption: dropDownValue ??= nameListAll.first,
                          options: nameListAll,
                          onChanged: (val) {
                            setState(() {
                              dropDownValue = val;
                              afterSelectName
                                  .add(ChipData('$val', Icons.close));
                            });
                            print("afterSelectName $afterSelectName");
                          },
                          width: MediaQuery.of(context).size.width / 0.95,
                          height: 50,
                          textStyle: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                  fontFamily: 'Mitr',
                                  color: Colors.black,
                                  fontSize: 18),
                          hintText: 'กรุณาเลือก',
                          fillColor: Colors.white,
                          elevation: 2,
                          borderColor: Colors.transparent,
                          borderWidth: 0,
                          borderRadius: 0,
                          margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                          hidesUnderline: true,
                        );
                      }),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: FlutterFlowChoiceChips(
                      // initiallySelected: [
                      //   if (choiceChipsValue != null) choiceChipsValue!
                      // ],
                      options: afterSelectName,
                      onChanged: (val) {
                        setState(() => choiceChipsValue = val?.first);
                        int indexwherelist = afterSelectName.indexWhere(
                            (element) => element.label == val?.first);

                        afterSelectName.removeAt(indexwherelist);

                        print("indexwherelist $indexwherelist");
                      },
                      selectedChipStyle: ChipStyle(
                        backgroundColor:
                            FlutterFlowTheme.of(context).primaryBlue01,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily: 'Mitr',
                                  color: Colors.white,
                                ),
                        iconColor: Colors.white,
                        iconSize: 18,
                        elevation: 4,
                      ),
                      unselectedChipStyle: ChipStyle(
                        backgroundColor:
                            FlutterFlowTheme.of(context).secondaryWhite,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyText2
                            .override(
                              fontFamily: 'Mitr',
                              color: FlutterFlowTheme.of(context).primaryGray,
                              fontSize: 16,
                            ),
                        iconColor: FlutterFlowTheme.of(context).primaryGray,
                        iconSize: 18,
                        elevation: 4,
                      ),
                      chipSpacing: 20,
                      multiselect: false,
                      alignment: WrapAlignment.start,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                        child: Text(
                          'เลือกเวรของฉัน',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Mitr',
                                color: FlutterFlowTheme.of(context).primaryGray,
                                fontSize: 18,
                              ),
                        ),
                      ),
                      Text(
                        '*',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Mitr',
                              color: FlutterFlowTheme.of(context).primaryRed,
                            ),
                      ),
                    ],
                  ),

                  ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dutyList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: FlutterFlowTheme.of(context).secondaryWhite,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
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
                                        '${dutyList[index]["firstname"]}',
                                        style:
                                            FlutterFlowTheme.of(context).title2,
                                      ),
                                      Text(
                                        " ${dutyList[index]["lastname"]}",
                                        style:
                                            FlutterFlowTheme.of(context).title2,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${dutyList[index]["duty"]}",
                                    // IndexWithOutDay เพราะ กรองindexที่จะเข้ามา
                                    // '${dayDuty[IndexWithOutList]}',
                                    style: FlutterFlowTheme.of(context).title2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        try {
                          Map<String, dynamic> dutyStore2 =
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SelectExchangeWorkscheduleWidget2(
                                              dutyList: dutyList,
                                              dutyStore: dutyStore)));
                          dutyList.add(dutyStore2);
                        } catch (error) {
                          print("เกิดข้อผิดพลาด $error");
                        }
                      },
                      text: 'เลือกเวร',
                      // icon: Icon(
                      //   Icons.attach_file,
                      //   size: 15,
                      // ),
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
                        color: FlutterFlowTheme.of(context).primaryBlue01,
                        textStyle: FlutterFlowTheme.of(context).bodyText1,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
// // มีเลือกเวลาละใส่ เ
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
//                     child: Text(
//                       'แนบไฟล์ (ถ้ามี)',
//                       style: FlutterFlowTheme.of(context).bodyText1.override(
//                             fontFamily: 'Mitr',
//                             color: FlutterFlowTheme.of(context).primaryGreen,
//                           ),
//                     ),
//                   ),
// // มีเลือกเวลาละใส่ เ
                  // Row(
                  //   mainAxisSize: MainAxisSize.max,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                  //       child: Text(
                  //         'วันที่ขอลา',
                  //         style: FlutterFlowTheme.of(context)
                  //             .bodyText1
                  //             .override(
                  //               fontFamily: 'Mitr',
                  //               color: FlutterFlowTheme.of(context).primaryGray,
                  //               fontSize: 18,
                  //             ),
                  //       ),
                  //     ),
                  //     Text(
                  //       '*',
                  //       style: FlutterFlowTheme.of(context).bodyText1.override(
                  //             fontFamily: 'Mitr',
                  //             color: FlutterFlowTheme.of(context).primaryRed,
                  //           ),
                  //     ),
                  //   ],
                  // ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                  //   child: TextFormField(
                  //     controller: textController2,
                  //     onChanged: (_) => EasyDebounce.debounce(
                  //       'textController2',
                  //       Duration(milliseconds: 2000),
                  //       () => setState(() {}),
                  //     ),
                  //     autofocus: true,
                  //     obscureText: false,
                  //     decoration: InputDecoration(
                  //       hintText: '14 เม.ย 2565',
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: FlutterFlowTheme.of(context).primaryGray,
                  //           width: 1,
                  //         ),
                  //         borderRadius: const BorderRadius.only(
                  //           topLeft: Radius.circular(4.0),
                  //           topRight: Radius.circular(4.0),
                  //         ),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: FlutterFlowTheme.of(context).primaryGray,
                  //           width: 1,
                  //         ),
                  //         borderRadius: const BorderRadius.only(
                  //           topLeft: Radius.circular(4.0),
                  //           topRight: Radius.circular(4.0),
                  //         ),
                  //       ),
                  //       prefixIcon: Icon(
                  //         Icons.calendar_today,
                  //       ),
                  //     ),
                  //     style: FlutterFlowTheme.of(context).title3,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                  //   child: TextFormField(
                  //     controller: textController3,
                  //     onChanged: (_) => EasyDebounce.debounce(
                  //       'textController3',
                  //       Duration(milliseconds: 2000),
                  //       () => setState(() {}),
                  //     ),
                  //     autofocus: true,
                  //     obscureText: false,
                  //     decoration: InputDecoration(
                  //       hintText: '21 เม.ย 2565',
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: FlutterFlowTheme.of(context).primaryGray,
                  //           width: 1,
                  //         ),
                  //         borderRadius: const BorderRadius.only(
                  //           topLeft: Radius.circular(4.0),
                  //           topRight: Radius.circular(4.0),
                  //         ),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: FlutterFlowTheme.of(context).primaryGray,
                  //           width: 1,
                  //         ),
                  //         borderRadius: const BorderRadius.only(
                  //           topLeft: Radius.circular(4.0),
                  //           topRight: Radius.circular(4.0),
                  //         ),
                  //       ),
                  //       prefixIcon: Icon(
                  //         Icons.calendar_today,
                  //       ),
                  //     ),
                  //     style: FlutterFlowTheme.of(context).title3,
                  //   ),
                  // ),
                  // Row(
                  //   mainAxisSize: MainAxisSize.max,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                  //       child: Text(
                  //         'เบอร์โทรติดต่อ',
                  //         style: FlutterFlowTheme.of(context)
                  //             .bodyText1
                  //             .override(
                  //               fontFamily: 'Mitr',
                  //               color: FlutterFlowTheme.of(context).primaryGray,
                  //               fontSize: 18,
                  //             ),
                  //       ),
                  //     ),
                  //     Text(
                  //       '*',
                  //       style: FlutterFlowTheme.of(context).bodyText1.override(
                  //             fontFamily: 'Mitr',
                  //             color: FlutterFlowTheme.of(context).primaryRed,
                  //           ),
                  //     ),
                  //   ],
                  // ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                  //   child: TextFormField(
                  //     controller: textController4,
                  //     onChanged: (_) => EasyDebounce.debounce(
                  //       'textController4',
                  //       Duration(milliseconds: 2000),
                  //       () => setState(() {}),
                  //     ),
                  //     autofocus: true,
                  //     obscureText: false,
                  //     decoration: InputDecoration(
                  //       hintText: 'กรุณากรอกเบอร์โทร',
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: FlutterFlowTheme.of(context).primaryGray,
                  //           width: 1,
                  //         ),
                  //         borderRadius: const BorderRadius.only(
                  //           topLeft: Radius.circular(4.0),
                  //           topRight: Radius.circular(4.0),
                  //         ),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: FlutterFlowTheme.of(context).primaryGray,
                  //           width: 1,
                  //         ),
                  //         borderRadius: const BorderRadius.only(
                  //           topLeft: Radius.circular(4.0),
                  //           topRight: Radius.circular(4.0),
                  //         ),
                  //       ),
                  //     ),
                  //     style: FlutterFlowTheme.of(context).title3,
                  //   ),
                  // ),

                  Query(
                      options: QueryOptions(
                        document: gql(nameAll),
                      ),
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
                        final nameList = GetListnameAll.fromJson(result.data!);
                        print("nameList ${nameList.users!.first.fristName}");
                        return Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                            child: FFButtonWidget(
                              onPressed: textController1?.text == null ||
                                      choiceChipsValue == null ||
                                      dutyList.length == 0
                                  ? () {
                                      print(
                                          'Button pressed ... idDuty ${dutyStore["idDuty"]} ${dutyStore["duty"] == ""} - ${textController1?.text == null} - ${choiceChipsValue == null} - $dutyList - ${choiceChipsValue == null}');
                                    }
                                  : () async {
                                      // ตรงนี้ควรแก้
                                      List<String> listMemberId = [];
                                      int indexSearch = 0;
                                      // if (afterSelectName.length > 1) {
                                      for (int t = 0;
                                          t < afterSelectName.length;
                                          t++) {
                                        // print(
                                        //     "afterSelectName[t].label${nameList.users!.first.fristName!.replaceAll(" ", "")}  ${afterSelectName[t].label.replaceAll(" ", "")} ${afterSelectName[t]
                                        //                 .label
                                        //                 .replaceAll(" ", "")}");

                                        indexSearch = nameList.users!
                                            .indexWhere((element) =>
                                                (element.fristName!
                                                        .replaceAll(" ", "") +
                                                    element.lastName!
                                                        .replaceAll(" ", "")) ==
                                                afterSelectName[t]
                                                    .label
                                                    .replaceAll(" ", ""));
                                        print(
                                            "request.body 1111 ${indexSearch}");
                                        if (indexSearch >= 0) {
                                          listMemberId.add(
                                              " ${nameList.users![indexSearch].id!} ");
                                        }
                                      }
                                      // } else{
                                      //   indexSearch = nameList.users!
                                      //         .indexWhere((element) =>
                                      //             element.fristName ==
                                      //                 afterSelectName[t]
                                      //                     .label
                                      //                     .split(" ")[0] &&
                                      //             element.lastName ==
                                      //                 afterSelectName[t]
                                      //                     .label
                                      //                     .split(" ")[1]);
                                      //   listMemberId.add(
                                      //           " ${nameList.users![indexSearch].id!} ");
                                      // }
                                      print("indexSearch $indexSearch");
                                      // listMemberId.add(afterSelectName[t].label);

                                      createLeave(
                                          memberId: listMemberId,
                                          dutyId: '${dutyList[0]["idDuty"]}',
                                          dutyString: '${dutyList[0]["duty"]}',
                                          dutynumber: dutyList[0]
                                              ["numberDuty"]);
                                      // await updataLeave(
                                      //   type: "$choiceChipsValue",
                                      //   detail: '${textController1!.text}',
                                      //   idDuty: '${dutyList[0]["idDuty"]}',
                                      //   duty: '${dutyList[0]["duty"]}',
                                      //   number: dutyList[0]["numberDuty"],
                                      // );
                                    },
                              text: 'ส่งให้หัวหน้าพบาบาล',
                              options: FFButtonOptions(
                                width: 300,
                                height: 40,
                                color: textController1?.text == null ||
                                        choiceChipsValue == null ||
                                        dutyList.length == 0
                                    ? FlutterFlowTheme.of(context).primaryGray
                                    : FlutterFlowTheme.of(context).primaryBlue,
                                textStyle:
                                    FlutterFlowTheme.of(context).bodyText1,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
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
    );
  }
}
