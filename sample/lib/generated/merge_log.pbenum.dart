//
//  Generated code. Do not modify.
//  source: src/api/merge_log.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CauseType extends $pb.ProtobufEnum {
  static const CauseType CAUSE_TYPE_UNSPECIFIED = CauseType._(0, _omitEnumNames ? '' : 'CAUSE_TYPE_UNSPECIFIED');
  static const CauseType CAUSE_TYPE_NEW_CHANGE = CauseType._(1, _omitEnumNames ? '' : 'CAUSE_TYPE_NEW_CHANGE');
  static const CauseType CAUSE_TYPE_MERGE = CauseType._(2, _omitEnumNames ? '' : 'CAUSE_TYPE_MERGE');

  static const $core.List<CauseType> values = <CauseType> [
    CAUSE_TYPE_UNSPECIFIED,
    CAUSE_TYPE_NEW_CHANGE,
    CAUSE_TYPE_MERGE,
  ];

  static final $core.Map<$core.int, CauseType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CauseType? valueOf($core.int value) => _byValue[value];

  const CauseType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
