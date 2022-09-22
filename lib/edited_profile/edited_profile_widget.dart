import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditedProfileWidget extends StatefulWidget {
  const EditedProfileWidget({
    Key? key,
    this.fristName,
    this.lastName,
  }) : super(key: key);

  final String? fristName;
  final String? lastName;

  @override
  _EditedProfileWidgetState createState() => _EditedProfileWidgetState();
}

class _EditedProfileWidgetState extends State<EditedProfileWidget> {
  ApiCallResponse? stateUpdateProfile;
  TextEditingController? fristnametextController;
  TextEditingController? lastnametextController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fristnametextController = TextEditingController(text: widget.fristName);
    lastnametextController = TextEditingController(text: widget.lastName);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    fristnametextController?.dispose();
    lastnametextController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30,
                              borderWidth: 1,
                              buttonSize: 60,
                              icon: Icon(
                                Icons.chevron_left,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 30,
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Hero(
                              tag: 'profile',
                              transitionOnUserGestures: true,
                              child: Container(
                                width: 120,
                                height: 120,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  'https://picsum.photos/seed/180/600',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'ชื่อ',
                                  style: FlutterFlowTheme.of(context).title2,
                                ),
                                TextFormField(
                                  controller: fristnametextController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'กรอกชื่อ',
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
                                Text(
                                  'นามสกุล',
                                  style: FlutterFlowTheme.of(context).title2,
                                ),
                                TextFormField(
                                  controller: lastnametextController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'กรอกนามสกุล',
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
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if ((fristnametextController!.text != null &&
                                    fristnametextController!.text != '')) {
                                  if ((lastnametextController!.text != null &&
                                      lastnametextController!.text != '')) {
                                    stateUpdateProfile =
                                        await UpdateProfileCall.call(
                                      token: FFAppState().tokenStore,
                                      fristName: fristnametextController!.text,
                                      lastName: lastnametextController!.text,
                                    );
                                    if (((stateUpdateProfile?.statusCode ??
                                            200)) ==
                                        200) {
                                      await actions.notifica(
                                          context, 'บันทึกสำเร็จ',
                                          color: Colors.green);
                                      Navigator.pop(context);
                                    } else {
                                      await actions.notifica(
                                        context,
                                        'เชื่อมต่อ api ไม่สำเร็จ',
                                      );
                                    }
                                  } else {
                                    await actions.notifica(
                                      context,
                                      'กรุณากรอกนามสกุล',
                                    );
                                  }
                                } else {
                                  await actions.notifica(
                                    context,
                                    'กรุณากรอกชื่อให้ครบ',
                                  );
                                }

                                setState(() {});
                              },
                              text: 'บันทึก',
                              options: FFButtonOptions(
                                width: 320,
                                height: 42,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                textStyle:
                                    FlutterFlowTheme.of(context).bodyText1,
                                elevation: 10,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
