

import 'package:json_annotation/json_annotation.dart';

part 'objectidcust.g.dart';

@JsonSerializable()
class ObjId {


  int timestamp;

  int machineIdentifier;

  int processIdentifier;

  int counter;


  ObjId({this.timestamp,this.machineIdentifier,this.processIdentifier,this.counter});

  factory ObjId.fromJson(Map<String, dynamic> json) => _$ObjIdFromJson(json);

  Map<String, dynamic> toJson() => _$ObjIdToJson(this);


  @override
  String toString() => toHexString();

  final List<String> _hexChars = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f'
  ];

  String toHexString() {
    List<String> charCodes = List<String>(24);
    int i = 0;
    for (final b in toBytes()) {
      charCodes[i++] = _hexChars[b >> 4 & 0xF];
      charCodes[i++] = _hexChars[b & 0xF];
    }
    return charCodes.join('');
  }

  List<int> toBytes() {
    List<int> bytes = List<int>(12);
    bytes[0] = _int3(timestamp);
    bytes[1] = _int2(timestamp);
    bytes[2] = _int1(timestamp);
    bytes[3] = _int0(timestamp);
    bytes[4] = _int2(machineIdentifier);
    bytes[5] = _int1(machineIdentifier);
    bytes[6] = _int0(machineIdentifier);
    bytes[7] = _int1(processIdentifier);
    bytes[8] = _int0(processIdentifier);
    bytes[9] = _int2(counter);
    bytes[10] = _int1(counter);
    bytes[11] = _int0(counter);
    return bytes;
  }

  int _int3(int x) => (x & 0xFF000000) >> 24;
  int _int2(int x) => (x & 0x00FF0000) >> 16;
  int _int1(int x) => (x & 0x0000FF00) >> 8;
  int _int0(int x) => (x & 0x000000FF);


}