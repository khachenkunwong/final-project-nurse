import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeavehistoryWidget extends StatefulWidget {
  const LeavehistoryWidget({Key? key}) : super(key: key);

  @override
  _LeavehistoryWidgetState createState() => _LeavehistoryWidgetState();
}

class _LeavehistoryWidgetState extends State<LeavehistoryWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            print('IconButton pressed ...');
          },
        ),
        title: Text(
          'ประวัติการลา',
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryWhite,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Text(
                      'ประวัติการลา',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Mitr',
                            color: FlutterFlowTheme.of(context).primaryBlack,
                            fontSize: 18,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ประเภท',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Mitr',
                                color:
                                    FlutterFlowTheme.of(context).primaryBlack,
                                fontSize: 18,
                              ),
                        ),
                        Text(
                          'ส่งคำขอเมื่อ',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Mitr',
                                color:
                                    FlutterFlowTheme.of(context).primaryBlack,
                                fontSize: 18,
                              ),
                        ),
                        Text(
                          'สถานะ',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Mitr',
                                color:
                                    FlutterFlowTheme.of(context).primaryBlack,
                                fontSize: 18,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'ลาป่วย',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Mitr',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBlack,
                                          fontSize: 18,
                                        ),
                                  ),
                                  Text(
                                    'ลาป่วย',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Mitr',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBlack,
                                          fontSize: 18,
                                        ),
                                  ),
                                  Text(
                                    'ลาป่วย',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Mitr',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBlack,
                                          fontSize: 18,
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '12/05/2565',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Mitr',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryGray,
                                          fontSize: 18,
                                        ),
                                  ),
                                  Text(
                                    '18/04/2565',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Mitr',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryGray,
                                          fontSize: 18,
                                        ),
                                  ),
                                  Text(
                                    '05/04/2565',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Mitr',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryGray,
                                          fontSize: 18,
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'รอตรอจสอบ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Mitr',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryGray,
                                          fontSize: 18,
                                        ),
                                  ),
                                  Text(
                                    'ไม่อนุมัติิ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Mitr',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryRed,
                                          fontSize: 18,
                                        ),
                                  ),
                                  Text(
                                    'อนุมัติ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Mitr',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBlue,
                                          fontSize: 18,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
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
