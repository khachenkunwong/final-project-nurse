import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkcalendarWidget extends StatefulWidget {
  const WorkcalendarWidget({Key? key}) : super(key: key);

  @override
  _WorkcalendarWidgetState createState() => _WorkcalendarWidgetState();
}

class _WorkcalendarWidgetState extends State<WorkcalendarWidget> {
  Completer<ApiCallResponse>? _apiRequestCompleter1;
  Completer<ApiCallResponse>? _apiRequestCompleter2;
  DateTimeRange? calendarSelectedDay;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                        color: FlutterFlowTheme.of(context).primaryColor,
                        weekFormat: false,
                        weekStartsMonday: false,
                        onChange: (DateTimeRange? newSelectedDate) {
                          setState(() => calendarSelectedDay = newSelectedDate);
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
                        (_apiRequestCompleter2 ??= Completer<ApiCallResponse>()
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
                              setState(() => _apiRequestCompleter2 = null);
                              await waitForApiRequestCompleter2();
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
                                          'เช้า',
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
                                          'เช้า',
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
                        },
                      );
                    },
                  ),
                ],
              ),
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
