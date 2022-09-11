import 'package:hos_mobile2/firstscreen/firstscreen_widget.dart';

import '../backend/api_requests/api_calls.dart';
import '../edited_profile/edited_profile_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../group/group_widget.dart';
import '../leavehistory/leavehistory_widget.dart';
import '../custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ApiCallResponse? logoutCallOutput;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("ออกจากหน้า โปรไฟล์");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiCallResponse>(
      future: GetProfileCall.call(
        token: FFAppState().tokenStore,
      ),
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
        final profileGetProfileResponse = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Material(
                      color: Colors.transparent,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.99,
                        height: 350,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
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
                            Builder(
                              builder: (context) {
                                final getProfileFullName =
                                    GetProfileCall.getListFullName(
                                          (profileGetProfileResponse.jsonBody ??
                                              ''),
                                        )?.toList() ??
                                        [];
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      List.generate(getProfileFullName.length,
                                          (getProfileFullNameIndex) {
                                    final getProfileFullNameItem =
                                        getProfileFullName[
                                            getProfileFullNameIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 10, 0),
                                      child: Text(
                                        getProfileFullNameItem,
                                        style:
                                            FlutterFlowTheme.of(context).title2,
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                'คณะแพทยศาสตร์ มหาวิทยาลัยพะเยา',
                                style: FlutterFlowTheme.of(context).title2,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                'สาขา วิชาเวชกิจฉุกเฉิน',
                                style: FlutterFlowTheme.of(context).title2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: InkWell(
                        onTap: () async {
                          if (profileGetProfileResponse.statusCode == 200) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditedProfileWidget(
                                  fristName: GetProfileCall.getFristName(
                                    (profileGetProfileResponse.jsonBody ?? ''),
                                  ).toString(),
                                  lastName: GetProfileCall.getLastName(
                                    (profileGetProfileResponse.jsonBody ?? ''),
                                  ).toString(),
                                ),
                              ),
                            );
                          } else {
                            await actions.notifica(
                              context,
                              'เชื่อมกับ api   ไม่สำเร็จ',
                            );
                          }
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.99,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              shape: BoxShape.rectangle,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 0, 10),
                                  child: Text(
                                    'แก้ไขโปรไฟล์',
                                    style: FlutterFlowTheme.of(context).title2,
                                  ),
                                ),
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  borderWidth: 1,
                                  buttonSize: 60,
                                  icon: Icon(
                                    Icons.mode_edit,
                                    color: Color(0xFF008AB1),
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupWidget(),
                            ),
                          );
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.99,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              shape: BoxShape.rectangle,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 0, 10),
                                  child: Text(
                                    'กลุ่ม',
                                    style: FlutterFlowTheme.of(context).title2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LeavehistoryWidget(),
                            ),
                          );
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.99,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              shape: BoxShape.rectangle,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 0, 10),
                                  child: Text(
                                    'ประวัติการลา',
                                    style: FlutterFlowTheme.of(context).title2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          try {
                            logoutCallOutput = await LogoutCall.call(
                              token: FFAppState().tokenStore,
                            );
                            if (mounted) {
                              setState(() => FFAppState().tokenStore = '');
                            }

                            if (((logoutCallOutput?.statusCode ?? 200)) ==
                                200) {
                              await actions.notifica(
                                context,
                                'ออกจากระบบแล้ว',
                                color: Colors.green,
                              );
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FirstscreenWidget(),
                                  ));

                            } else if (logoutCallOutput?.statusCode == 404) {
                              await actions.notifica(
                                context,
                                'Not fount',
                              );
                            } else {
                              await actions.notifica(
                                context,
                                'ออกจากระบบไม่สำเร็จ',
                              );
                            }
                          } catch (err) {
                            print("เกิดข้อผิดพลาด $err");
                            await actions.notifica(
                              context,
                              'เกิดข้อผิดพลาด',
                            );
                          }
                        },
                        text: 'ออกจากระบบ',
                        options: FFButtonOptions(
                          width: 350,
                          height: 42,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle: FlutterFlowTheme.of(context).bodyText1,
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
        );
      },
    );
  }
}
