//
//  Generated code. Do not modify.
//  source: src/api/merge_log.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use causeTypeDescriptor instead')
const CauseType$json = {
  '1': 'CauseType',
  '2': [
    {'1': 'CAUSE_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'CAUSE_TYPE_NEW_CHANGE', '2': 1},
    {'1': 'CAUSE_TYPE_MERGE', '2': 2},
  ],
};

/// Descriptor for `CauseType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List causeTypeDescriptor = $convert.base64Decode(
    'CglDYXVzZVR5cGUSGgoWQ0FVU0VfVFlQRV9VTlNQRUNJRklFRBAAEhkKFUNBVVNFX1RZUEVfTk'
    'VXX0NIQU5HRRABEhQKEENBVVNFX1RZUEVfTUVSR0UQAg==');

@$core.Deprecated('Use mergelogRequestDescriptor instead')
const MergelogRequest$json = {
  '1': 'MergelogRequest',
  '2': [
    {'1': 'mergelogs', '3': 1, '4': 3, '5': 11, '6': '.k8scpdt.mergelog.v1.Mergelog', '10': 'mergelogs'},
  ],
};

/// Descriptor for `MergelogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mergelogRequestDescriptor = $convert.base64Decode(
    'Cg9NZXJnZWxvZ1JlcXVlc3QSOwoJbWVyZ2Vsb2dzGAEgAygLMh0uazhzY3BkdC5tZXJnZWxvZy'
    '52MS5NZXJnZWxvZ1IJbWVyZ2Vsb2dz');

@$core.Deprecated('Use mergelogsDescriptor instead')
const Mergelogs$json = {
  '1': 'Mergelogs',
  '2': [
    {'1': 'mergelogs', '3': 1, '4': 3, '5': 11, '6': '.k8scpdt.mergelog.v1.Mergelog', '10': 'mergelogs'},
  ],
};

/// Descriptor for `Mergelogs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mergelogsDescriptor = $convert.base64Decode(
    'CglNZXJnZWxvZ3MSOwoJbWVyZ2Vsb2dzGAEgAygLMh0uazhzY3BkdC5tZXJnZWxvZy52MS5NZX'
    'JnZWxvZ1IJbWVyZ2Vsb2dz');

@$core.Deprecated('Use mergelogDescriptor instead')
const Mergelog$json = {
  '1': 'Mergelog',
  '2': [
    {'1': 'new_cpid', '3': 1, '4': 1, '5': 11, '6': '.k8scpdt.mergelog.v1.CPID', '10': 'newCpid'},
    {'1': 'source_cpids', '3': 2, '4': 3, '5': 11, '6': '.k8scpdt.mergelog.v1.CPID', '10': 'sourceCpids'},
    {'1': 'time', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'time'},
    {'1': 'cause_type', '3': 4, '4': 1, '5': 14, '6': '.k8scpdt.mergelog.v1.CauseType', '10': 'causeType'},
    {'1': 'cause_message', '3': 5, '4': 1, '5': 9, '10': 'causeMessage'},
    {'1': 'by', '3': 6, '4': 1, '5': 9, '10': 'by'},
  ],
};

/// Descriptor for `Mergelog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mergelogDescriptor = $convert.base64Decode(
    'CghNZXJnZWxvZxI0CghuZXdfY3BpZBgBIAEoCzIZLms4c2NwZHQubWVyZ2Vsb2cudjEuQ1BJRF'
    'IHbmV3Q3BpZBI8Cgxzb3VyY2VfY3BpZHMYAiADKAsyGS5rOHNjcGR0Lm1lcmdlbG9nLnYxLkNQ'
    'SURSC3NvdXJjZUNwaWRzEi4KBHRpbWUYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW'
    '1wUgR0aW1lEj0KCmNhdXNlX3R5cGUYBCABKA4yHi5rOHNjcGR0Lm1lcmdlbG9nLnYxLkNhdXNl'
    'VHlwZVIJY2F1c2VUeXBlEiMKDWNhdXNlX21lc3NhZ2UYBSABKAlSDGNhdXNlTWVzc2FnZRIOCg'
    'JieRgGIAEoCVICYnk=');

@$core.Deprecated('Use cPIDDescriptor instead')
const CPID$json = {
  '1': 'CPID',
  '2': [
    {'1': 'cpid', '3': 1, '4': 1, '5': 9, '10': 'cpid'},
  ],
};

/// Descriptor for `CPID`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cPIDDescriptor = $convert.base64Decode(
    'CgRDUElEEhIKBGNwaWQYASABKAlSBGNwaWQ=');

@$core.Deprecated('Use postSpansRequestDescriptor instead')
const PostSpansRequest$json = {
  '1': 'PostSpansRequest',
  '2': [
    {'1': 'spans', '3': 1, '4': 3, '5': 11, '6': '.k8scpdt.mergelog.v1.Span', '10': 'spans'},
  ],
};

/// Descriptor for `PostSpansRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List postSpansRequestDescriptor = $convert.base64Decode(
    'ChBQb3N0U3BhbnNSZXF1ZXN0Ei8KBXNwYW5zGAEgAygLMhkuazhzY3BkdC5tZXJnZWxvZy52MS'
    '5TcGFuUgVzcGFucw==');

@$core.Deprecated('Use spanDescriptor instead')
const Span$json = {
  '1': 'Span',
  '2': [
    {'1': 'cpid', '3': 1, '4': 1, '5': 11, '6': '.k8scpdt.mergelog.v1.CPID', '10': 'cpid'},
    {'1': 'start_time', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startTime'},
    {'1': 'end_time', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endTime'},
    {'1': 'service', '3': 4, '4': 1, '5': 9, '10': 'service'},
    {'1': 'object_kind', '3': 5, '4': 1, '5': 9, '10': 'objectKind'},
    {'1': 'object_name', '3': 6, '4': 1, '5': 9, '10': 'objectName'},
    {'1': 'message', '3': 7, '4': 1, '5': 9, '10': 'message'},
    {'1': 'span_id', '3': 8, '4': 1, '5': 9, '10': 'spanId'},
    {'1': 'parent_id', '3': 9, '4': 1, '5': 9, '10': 'parentId'},
  ],
};

/// Descriptor for `Span`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spanDescriptor = $convert.base64Decode(
    'CgRTcGFuEi0KBGNwaWQYASABKAsyGS5rOHNjcGR0Lm1lcmdlbG9nLnYxLkNQSURSBGNwaWQSOQ'
    'oKc3RhcnRfdGltZRgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXN0YXJ0VGlt'
    'ZRI1CghlbmRfdGltZRgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB2VuZFRpbW'
    'USGAoHc2VydmljZRgEIAEoCVIHc2VydmljZRIfCgtvYmplY3Rfa2luZBgFIAEoCVIKb2JqZWN0'
    'S2luZBIfCgtvYmplY3RfbmFtZRgGIAEoCVIKb2JqZWN0TmFtZRIYCgdtZXNzYWdlGAcgASgJUg'
    'dtZXNzYWdlEhcKB3NwYW5faWQYCCABKAlSBnNwYW5JZBIbCglwYXJlbnRfaWQYCSABKAlSCHBh'
    'cmVudElk');

@$core.Deprecated('Use getAllSpansResponseDescriptor instead')
const GetAllSpansResponse$json = {
  '1': 'GetAllSpansResponse',
  '2': [
    {'1': 'spans', '3': 1, '4': 3, '5': 11, '6': '.k8scpdt.mergelog.v1.Span', '10': 'spans'},
  ],
};

/// Descriptor for `GetAllSpansResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllSpansResponseDescriptor = $convert.base64Decode(
    'ChNHZXRBbGxTcGFuc1Jlc3BvbnNlEi8KBXNwYW5zGAEgAygLMhkuazhzY3BkdC5tZXJnZWxvZy'
    '52MS5TcGFuUgVzcGFucw==');

@$core.Deprecated('Use getRelevantSpansResponseDescriptor instead')
const GetRelevantSpansResponse$json = {
  '1': 'GetRelevantSpansResponse',
  '2': [
    {'1': 'spans', '3': 1, '4': 3, '5': 11, '6': '.k8scpdt.mergelog.v1.Span', '10': 'spans'},
  ],
};

/// Descriptor for `GetRelevantSpansResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRelevantSpansResponseDescriptor = $convert.base64Decode(
    'ChhHZXRSZWxldmFudFNwYW5zUmVzcG9uc2USLwoFc3BhbnMYASADKAsyGS5rOHNjcGR0Lm1lcm'
    'dlbG9nLnYxLlNwYW5SBXNwYW5z');

