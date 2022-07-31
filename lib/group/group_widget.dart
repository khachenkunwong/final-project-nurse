import 'package:hos_mobile2/model/member_model.dart';

import '../backend/api_requests/api_calls.dart';
import '../backend/pubilc_.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GroupWidget extends StatefulWidget {
  const GroupWidget({Key? key}) : super(key: key);

  @override
  _GroupWidgetState createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  Completer<ApiCallResponse>? _apiRequestCompleter;
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Group>>? futureMember;
  late Future futureSearch;
  List listSearchEmail1 = [];
  List listSearchEmail2 = [];
  Future<List<Group>> getMemberModel({required String token}) async {
    try {
      print(token);
      final res = await http.get(
        Uri.parse("$url/api/group/me/member"),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "$token"
        },
      );
      print("res.body1 ${res.statusCode}");
      print("res.body1 ${res.body}");

      final bodyMember = convert.json.decode(res.body) as Map<String, dynamic>;
      final _futureMember =
          MemberCall.fromJson(bodyMember as Map<String, dynamic>);
      final futureMember = _futureMember.group as List<Group>;

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
      return futureMember;
    } catch (error) {
      print(error);
    }
    return [];
  }

  // SearchMemberModel({required String token, required int numberGroup}) async {
  //   try {
  //     print(token);
  //     final res = await http.get(
  //       Uri.parse("$url/api/group/me/member"),
  //       headers: {
  //         "Accept": "application/json",
  //         "Access-Control_Allow_Origin": "*",
  //         "x-access-token": "$token"
  //       },
  //     );
  //     print("res.body1 ${res.statusCode}");
  //     print("res.body1 ${res.body}");

  //     final bodyMember = convert.json.decode(res.body) as Map<String, dynamic>;
  //     final _futureMember =
  //         MemberCall.fromJson(bodyMember as Map<String, dynamic>);
  //     final futureMember = _futureMember.group as List<Group>;
  //     setState(() {
  //       listSearchEmail1 = futureMember[numberGroup]
  //           .member!
  //           .map((member) => member.email)
  //           .toList();
  //           listSearchEmail2 = futureMember[numberGroup]
  //           .member!
  //           .map((member) => member.email)
  //           .toList();

  //     });

  //     print("listSearchEmail$listSearchEmail1");

  //     // print("_futurePresent ${_futurePresent.duty}");
  //     // for (var dutylist in data) {
  //     //   // list ออกมาทั้ง index
  //     //   final _futurePresent =
  //     //       PresentModel.fromJson(dutylist as Map<String, dynamic>);
  //     //   // aa = _dutylist.duty!.first.day;
  //     //   // print("_dutylist ${aa}");
  //     //   setState(() {
  //     //     futurePresent.add(_futurePresent);
  //     //   });
  //     // }

  //   } catch (error) {
  //     print(error);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    print("token ${FFAppState().tokenStore}");
    futureMember = getMemberModel(token: FFAppState().tokenStore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: AlignmentDirectional(0, -1),
            child: FutureBuilder<List<Group>>(
              future: futureMember,
              builder: (context, snapshotGroup) {
                // Customize what your widget looks like when it's loading.
                print("snapshotGroup $snapshotGroup");
                if (!snapshotGroup.hasData) {
                  print("ไม่มีข้อมูล");
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
                final GetGroupMyMemberResponse = snapshotGroup.data!;
                return Builder(builder: (context) {
                  return ListView.builder(
                      itemCount: GetGroupMyMemberResponse.length,
                      itemBuilder: (context, indexGroup) {
                        final ItemGroup = GetGroupMyMemberResponse[indexGroup];
                        print(indexGroup);
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20, 20, 20, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'ชื่อกลุ่ม ${ItemGroup.nameGroup}',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context).title2,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 10, 0),
                                        child: Text(
                                          'ผู้ดูแล',
                                          style: FlutterFlowTheme.of(context)
                                              .title2,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: TextFormField(
                                            controller: textController,
                                            onChanged: (string) {
                                              listSearchEmail1 =
                                                  listSearchEmail2
                                                      .where((u) => u
                                                          .toString()
                                                          .contains(string))
                                                      .toList();
                                              print(listSearchEmail1);
                                              setState(() {});
                                            },
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: 'ค้นหา',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              prefixIcon: Icon(
                                                Icons.search,
                                                size: 16,
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .title3,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Builder(
                                    builder: (context) {
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: ItemGroup.leader!.length,
                                        itemBuilder: (context, indexLeader) {
                                          final itemLeader =
                                              ItemGroup.leader![indexLeader];
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Hero(
                                                  tag: 'profile',
                                                  transitionOnUserGestures:
                                                      true,
                                                  child: Container(
                                                    width: 45,
                                                    height: 45,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.network(
                                                      'https://picsum.photos/seed/180/600',
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 0, 0, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${itemLeader.fristName} ${itemLeader.lastName}",
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title2,
                                                      ),
                                                      Text(
                                                        '${itemLeader.email}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 0),
                                    child: Text(
                                      'สมาชิก',
                                      style:
                                          FlutterFlowTheme.of(context).title2,
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      // final getMymember = GetGroupMyMemberCall
                                      //         .getOneMyGroupMemberListFristName(
                                      //       (containerGetGroupMyMemberResponse
                                      //               .jsonBody ??
                                      //           ''),
                                      //     )?.toList() ??
                                      //     [];
                                      return RefreshIndicator(
                                        onRefresh: () async {
                                          setState(() =>
                                              _apiRequestCompleter = null);
                                          await waitForApiRequestCompleter();
                                        },
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: ItemGroup.member!.length,
                                          itemBuilder: (context, indexMember) {
                                            final itemMember =
                                                ItemGroup.member![indexMember];
                                            return InkWell(
                                              onTap: () {
                                                print(
                                                    "คลิกแล้ว item ที่ $indexMember");
                                                print(itemMember.fristName);
                                                print(itemMember.lastName);
                                                print(itemMember.email);
                                                print(itemMember.location);
                                                print(itemMember.actor);
                                              },
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 10, 0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 45,
                                                      height: 45,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.network(
                                                        'https://picsum.photos/seed/180/600',
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  20, 0, 0, 0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${itemMember.fristName} ${itemMember.lastName}",
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .title2,
                                                          ),
                                                          Text(
                                                            '${itemMember.email}',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .title3,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Future waitForApiRequestCompleter({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = _apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
