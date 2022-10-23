import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  ApiCallResponse? registerOutput;
  TextEditingController? emailRegisterController;
  TextEditingController? fristNameRegisterController;
  TextEditingController? lastNameRegisterController;
  TextEditingController? passwordRegister1Controller;
  late bool passwordRegister1Visibility;
  TextEditingController? passwordRegister2Controller;
  late bool passwordRegister2Visibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late ApiCallResponse updataschedule;
  late ApiCallResponse updataschedule1;

  @override
  void initState() {
    super.initState();
    emailRegisterController = TextEditingController(text: "member1@gmail.com");
    fristNameRegisterController = TextEditingController(text: "พยาบาล");
    lastNameRegisterController = TextEditingController(text: "คนที่ 1");
    passwordRegister1Controller = TextEditingController(text: "member1");
    passwordRegister1Visibility = false;
    passwordRegister2Controller =
        TextEditingController(text: passwordRegister1Controller!.text);
    passwordRegister2Visibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset(
                'assets/images/background.png',
              ).image,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 700,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30,
                                borderWidth: 1,
                                buttonSize: 60,
                                icon: Icon(
                                  Icons.chevron_left,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              updataschedule1 = await ManageSchedule.call();
                              final gg = await ManageSchedule.resUpdateSchedule(
                                  updataschedule.jsonBody);
                              print("ooo" + gg.toString());
                              print("5515${updataschedule.jsonBody}");
                              if (updataschedule.statusCode == 200) {
                                // if (mounted) {
                                //   setState(() {
                                //     loadSave = false;
                                //   });
                                // }
                                await actions.notifica(context, 'สำเร็จ',
                                    color: Colors.green);
                              } else {
                                // if (mounted) {
                                //   setState(() {
                                //     loadSave = false;
                                //   });
                                // }
                                await actions.notifica(
                                  context,
                                  'ไม่สำเร็จ',
                                );
                              }
                            },
                            child: Text(
                              'สมัครสมาชิก',
                              style: FlutterFlowTheme.of(context).title1,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Text(
                                    'ชื่อ',
                                    style: FlutterFlowTheme.of(context).title2,
                                  ),
                                ),
                                TextFormField(
                                  controller: fristNameRegisterController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'กรอกชื่อผู้ใช้ตรงนี้',
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
                                  controller: lastNameRegisterController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'กรอกนามสกุลตรงนี้',
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
                                  'อีเมล',
                                  style: FlutterFlowTheme.of(context).title2,
                                ),
                                TextFormField(
                                  controller: emailRegisterController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'กรอกอีเมลตรงนี้',
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
                                  'รหัสผ่าน',
                                  style: FlutterFlowTheme.of(context).title2,
                                ),
                                TextFormField(
                                  controller: passwordRegister1Controller,
                                  obscureText: !passwordRegister1Visibility,
                                  decoration: InputDecoration(
                                    hintText: 'กรอกรหัสผ่านตรงนี้',
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
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => passwordRegister1Visibility =
                                            !passwordRegister1Visibility,
                                      ),
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        passwordRegister1Visibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Color(0xFF757575),
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  style: GoogleFonts.mitr(
                                    color: Color(0xFF727272),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'รหัสผ่านอีกครั้ง',
                                    style: FlutterFlowTheme.of(context).title2,
                                  ),
                                ),
                                TextFormField(
                                  controller: passwordRegister2Controller,
                                  obscureText: !passwordRegister2Visibility,
                                  decoration: InputDecoration(
                                    hintText: 'กรอกรหัสผ่านอีกครั้ง',
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
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => passwordRegister2Visibility =
                                            !passwordRegister2Visibility,
                                      ),
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        passwordRegister2Visibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Color(0xFF757575),
                                        size: 22,
                                      ),
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
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (((registerOutput?.statusCode ?? 200)) ==
                                    200) {
                                  if ((fristNameRegisterController!.text !=
                                          null &&
                                      fristNameRegisterController!.text !=
                                          '')) {
                                    if ((lastNameRegisterController!.text !=
                                            null &&
                                        lastNameRegisterController!.text !=
                                            '')) {
                                      if ((emailRegisterController!.text !=
                                              null &&
                                          emailRegisterController!.text !=
                                              '')) {
                                        if ((passwordRegister1Controller!
                                                    .text !=
                                                null &&
                                            passwordRegister1Controller!.text !=
                                                '')) {
                                          if ((passwordRegister2Controller!
                                                      .text !=
                                                  null &&
                                              passwordRegister2Controller!
                                                      .text !=
                                                  '')) {
                                            if ((passwordRegister1Controller!
                                                    .text) ==
                                                (passwordRegister2Controller!
                                                    .text)) {
                                              registerOutput =
                                                  await PostRegisterCall.call(
                                                fristName:
                                                    fristNameRegisterController!
                                                        .text,
                                                lastName:
                                                    lastNameRegisterController!
                                                        .text,
                                                email: emailRegisterController!
                                                    .text,
                                                password:
                                                    passwordRegister2Controller!
                                                        .text,
                                              );
                                              await actions.notifica(
                                                context,
                                                'สมัครเสร็จสิ้น',
                                                color: Colors.green,
                                              );
                                              if (fristNameRegisterController!
                                                          .text !=
                                                      "admin" &&
                                                  emailRegisterController!
                                                          .text !=
                                                      "admin@gmail.com" &&
                                                  fristNameRegisterController!
                                                          .text !=
                                                      "leader" &&
                                                  emailRegisterController!
                                                          .text !=
                                                      "leader@gmail.com" &&
                                                  fristNameRegisterController!
                                                          .text !=
                                                      "headmanager" &&
                                                  emailRegisterController!
                                                          .text !=
                                                      "headmanager@gmail.com") {
                                                updataschedule =
                                                    await ManageSchedule.call();
                                                final gg = await ManageSchedule
                                                    .resUpdateSchedule(
                                                        updataschedule
                                                            .jsonBody);
                                                print("ooo" + gg.toString());
                                                print(
                                                    "5515${updataschedule.jsonBody}");
                                                if (updataschedule.statusCode ==
                                                    200) {
                                                  // if (mounted) {
                                                  //   setState(() {
                                                  //     loadSave = false;
                                                  //   });
                                                  // }
                                                  await actions.notifica(
                                                      context, 'สำเร็จ',
                                                      color: Colors.green);
                                                } else {
                                                  // if (mounted) {
                                                  //   setState(() {
                                                  //     loadSave = false;
                                                  //   });
                                                  // }
                                                  await actions.notifica(
                                                    context,
                                                    'ไม่สำเร็จ',
                                                  );
                                                }
                                                Navigator.pop(context);
                                              }
                                            } else {
                                              await actions.notifica(
                                                context,
                                                'กรุณากรอกรหัสผ่านไม่ตรงกัน',
                                              );
                                            }
                                          } else {
                                            await actions.notifica(
                                              context,
                                              'กรุณากรอกยืนยันรหัสผ่าน',
                                            );
                                          }
                                        } else {
                                          await actions.notifica(
                                            context,
                                            'กรุณากรอกรหัสผ่าน',
                                          );
                                        }
                                      } else {
                                        await actions.notifica(
                                          context,
                                          'กรุณากรอกอีเมล',
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
                                      'กรุณากรอกชื่อ',
                                    );
                                  }
                                } else {
                                  await actions.notifica(
                                    context,
                                    'กรุณากรอกข้อมูลให้ครบถ้วนหรืออีเมลนี้มีผู้ใช้แล้ว',
                                  );
                                }

                                setState(() {});
                              },
                              text: 'สมัครสมาชิก',
                              options: FFButtonOptions(
                                width: 285,
                                height: 40,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                textStyle:
                                    FlutterFlowTheme.of(context).bodyText1,
                                elevation: 5,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'มีบัญชี?',
                                  style: FlutterFlowTheme.of(context).subtitle1,
                                ),
                                InkWell(
                                  onTap: () async {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'เข้าสู่ระบบ',
                                    style:
                                        FlutterFlowTheme.of(context).bodyText2,
                                  ),
                                ),
                              ],
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
