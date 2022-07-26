import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectExchangeWorkscheduleWidget extends StatefulWidget {
  const SelectExchangeWorkscheduleWidget({Key? key}) : super(key: key);

  @override
  _SelectExchangeWorkscheduleWidgetState createState() =>
      _SelectExchangeWorkscheduleWidgetState();
}

class _SelectExchangeWorkscheduleWidgetState
    extends State<SelectExchangeWorkscheduleWidget> {
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.99,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: FlutterFlowCalendar(
                  color: FlutterFlowTheme.of(context).primaryColor,
                  weekFormat: true,
                  weekStartsMonday: false,
                  onChange: (DateTimeRange? newSelectedDate) {
                    setState(() => calendarSelectedDay = newSelectedDate);
                  },
                  titleStyle: GoogleFonts.getFont(
                    'Mitr',
                    color: Color(0xFF050000),
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
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: FlutterFlowTheme.of(context).primaryBlue02,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              'นาย Jonh liam',
                              style: FlutterFlowTheme.of(context).title2,
                            ),
                            Text(
                              'เช้า',
                              style: FlutterFlowTheme.of(context).title2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
