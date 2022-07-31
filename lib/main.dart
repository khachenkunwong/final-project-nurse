import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterFlowTheme.initialize();

  FFAppState(); // Initialize FFAppState

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HosMobile2',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      themeMode: _themeMode,
      home: FirstscreenWidget(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage}) : super(key: key);

  final String? initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'workschedule';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'workschedule': WorkscheduleWidget(),
      'workcalendar': WorkcalendarWidget(),
      'notifications': NotificationsWidget(),
      'profile': ProfileWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPage);
    return Scaffold(
      body: tabs[_currentPage],
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF00A2FD),
        unselectedItemColor: Color(0xFF727272),
        selectedBackgroundColor: Color(0x00000000),
        borderRadius: 8,
        itemBorderRadius: 8,
        margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        width: double.infinity,
        elevation: 0,
        items: [
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentIndex == 0 ? Icons.home : Icons.home,
                  color:
                      currentIndex == 0 ? Color(0xFF00A2FD) : Color(0xFF727272),
                  size: 24,
                ),
                Text(
                  'ตารางงาน',
                  overflow: TextOverflow.ellipsis,
                  style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Mitr',
                        color: FlutterFlowTheme.of(context).primaryBlack,
                      ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentIndex == 1
                      ? Icons.calendar_today
                      : Icons.calendar_today,
                  color:
                      currentIndex == 1 ? Color(0xFF00A2FD) : Color(0xFF727272),
                  size: 24,
                ),
                Text(
                  'ปฏิทิน',
                  overflow: TextOverflow.ellipsis,
                  style: FlutterFlowTheme.of(context).subtitle1,
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentIndex == 2 ? Icons.notifications : Icons.notifications,
                  color:
                      currentIndex == 2 ? Color(0xFF00A2FD) : Color(0xFF727272),
                  size: 24,
                ),
                Text(
                  'แจ้งเตือน',
                  overflow: TextOverflow.ellipsis,
                  style: FlutterFlowTheme.of(context).subtitle1,
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentIndex == 3 ? Icons.person : Icons.person,
                  color:
                      currentIndex == 3 ? Color(0xFF00A2FD) : Color(0xFF727272),
                  size: 24,
                ),
                Text(
                  'โปรไฟล์',
                  overflow: TextOverflow.ellipsis,
                  style: FlutterFlowTheme.of(context).subtitle1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
