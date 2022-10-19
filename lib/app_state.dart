import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _chcknull = prefs.getString('ff_chcknull') ?? _chcknull;
    _tokenStore = prefs.getString('ff_tokenStore') ?? _tokenStore;
    _namegroup = prefs.getString('ff_namegroup') ?? _namegroup;
    _dutySelectwithoutme = prefs.getStringList('ff_dutySelectwithoutme') ?? _dutySelectwithoutme;
     _dutySelectme = prefs.getStringList('ff_dutySelectme') ?? _dutySelectme;
  }

  late SharedPreferences prefs;

  String _chcknull = 'ว่าง';
  String get chcknull => _chcknull;
  set chcknull(String _value) {
    _chcknull = _value;
    prefs.setString('ff_chcknull', _value);
  }

  String _tokenStore = '';
  String get tokenStore => _tokenStore;
  set tokenStore(String _value) {
    _tokenStore = _value;
    prefs.setString('ff_tokenStore', _value);
  }

  String _namegroup = '';
  String get namegroup => _namegroup;
  set namegroup(String _value) {
    _namegroup = _value;
    prefs.setString('ff_namegroup', _value);
  }

  List<String> _dutySelectwithoutme = [];
  List<String> get dutySelectwithoutme => _dutySelectwithoutme;
  set dutySelectwithoutme(List<String> _value) {
    _dutySelectwithoutme = _value;
    prefs.setStringList('ff_dutySelectwithoutme', _value);
  }

  List<String> _dutySelectme = [];
  List<String> get dutySelectme => _dutySelectme;
  set dutySelectme(List<String> _value) {
    _dutySelectme = _value;
    prefs.setStringList('ff_dutySelectme', _value);
  }
}

// LatLng? _latLngFromString(String? val) {
//   if (val == null) {
//     return null;
//   }
//   final split = val.split(',');
//   final lat = double.parse(split.first);
//   final lng = double.parse(split.last);
//   return LatLng(lat, lng);
// }
