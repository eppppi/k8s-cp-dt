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

import 'google/protobuf/timestamp.pb.dart' as $2;
import 'merge_log.pbenum.dart';

export 'merge_log.pbenum.dart';

class MergelogRequest extends $pb.GeneratedMessage {
  factory MergelogRequest({
    $core.Iterable<Mergelog>? mergelogs,
  }) {
    final $result = create();
    if (mergelogs != null) {
      $result.mergelogs.addAll(mergelogs);
    }
    return $result;
  }
  MergelogRequest._() : super();
  factory MergelogRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MergelogRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MergelogRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'k8scpdt.mergelog.v1'),
      createEmptyInstance: create)
    ..pc<Mergelog>(1, _omitFieldNames ? '' : 'mergelogs', $pb.PbFieldType.PM,
        subBuilder: Mergelog.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MergelogRequest clone() => MergelogRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MergelogRequest copyWith(void Function(MergelogRequest) updates) =>
      super.copyWith((message) => updates(message as MergelogRequest))
          as MergelogRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MergelogRequest create() => MergelogRequest._();
  MergelogRequest createEmptyInstance() => create();
  static $pb.PbList<MergelogRequest> createRepeated() =>
      $pb.PbList<MergelogRequest>();
  @$core.pragma('dart2js:noInline')
  static MergelogRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MergelogRequest>(create);
  static MergelogRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Mergelog> get mergelogs => $_getList(0);
}

class Mergelogs extends $pb.GeneratedMessage {
  factory Mergelogs({
    $core.Iterable<Mergelog>? mergelogs,
  }) {
    final $result = create();
    if (mergelogs != null) {
      $result.mergelogs.addAll(mergelogs);
    }
    return $result;
  }
  Mergelogs._() : super();
  factory Mergelogs.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Mergelogs.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Mergelogs',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'k8scpdt.mergelog.v1'),
      createEmptyInstance: create)
    ..pc<Mergelog>(1, _omitFieldNames ? '' : 'mergelogs', $pb.PbFieldType.PM,
        subBuilder: Mergelog.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Mergelogs clone() => Mergelogs()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Mergelogs copyWith(void Function(Mergelogs) updates) =>
      super.copyWith((message) => updates(message as Mergelogs)) as Mergelogs;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Mergelogs create() => Mergelogs._();
  Mergelogs createEmptyInstance() => create();
  static $pb.PbList<Mergelogs> createRepeated() => $pb.PbList<Mergelogs>();
  @$core.pragma('dart2js:noInline')
  static Mergelogs getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Mergelogs>(create);
  static Mergelogs? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Mergelog> get mergelogs => $_getList(0);
}

class Mergelog extends $pb.GeneratedMessage {
  factory Mergelog({
    CPID? newCpid,
    $core.Iterable<CPID>? sourceCpids,
    $2.Timestamp? time,
    CauseType? causeType,
    $core.String? causeMessage,
    $core.String? by,
  }) {
    final $result = create();
    if (newCpid != null) {
      $result.newCpid = newCpid;
    }
    if (sourceCpids != null) {
      $result.sourceCpids.addAll(sourceCpids);
    }
    if (time != null) {
      $result.time = time;
    }
    if (causeType != null) {
      $result.causeType = causeType;
    }
    if (causeMessage != null) {
      $result.causeMessage = causeMessage;
    }
    if (by != null) {
      $result.by = by;
    }
    return $result;
  }
  Mergelog._() : super();
  factory Mergelog.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Mergelog.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Mergelog',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'k8scpdt.mergelog.v1'),
      createEmptyInstance: create)
    ..aOM<CPID>(1, _omitFieldNames ? '' : 'newCpid', subBuilder: CPID.create)
    ..pc<CPID>(2, _omitFieldNames ? '' : 'sourceCpids', $pb.PbFieldType.PM,
        subBuilder: CPID.create)
    ..aOM<$2.Timestamp>(3, _omitFieldNames ? '' : 'time',
        subBuilder: $2.Timestamp.create)
    ..e<CauseType>(4, _omitFieldNames ? '' : 'causeType', $pb.PbFieldType.OE,
        defaultOrMaker: CauseType.CAUSE_TYPE_UNSPECIFIED,
        valueOf: CauseType.valueOf,
        enumValues: CauseType.values)
    ..aOS(5, _omitFieldNames ? '' : 'causeMessage')
    ..aOS(6, _omitFieldNames ? '' : 'by')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Mergelog clone() => Mergelog()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Mergelog copyWith(void Function(Mergelog) updates) =>
      super.copyWith((message) => updates(message as Mergelog)) as Mergelog;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Mergelog create() => Mergelog._();
  Mergelog createEmptyInstance() => create();
  static $pb.PbList<Mergelog> createRepeated() => $pb.PbList<Mergelog>();
  @$core.pragma('dart2js:noInline')
  static Mergelog getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Mergelog>(create);
  static Mergelog? _defaultInstance;

  @$pb.TagNumber(1)
  CPID get newCpid => $_getN(0);
  @$pb.TagNumber(1)
  set newCpid(CPID v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasNewCpid() => $_has(0);
  @$pb.TagNumber(1)
  void clearNewCpid() => clearField(1);
  @$pb.TagNumber(1)
  CPID ensureNewCpid() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<CPID> get sourceCpids => $_getList(1);

  @$pb.TagNumber(3)
  $2.Timestamp get time => $_getN(2);
  @$pb.TagNumber(3)
  set time($2.Timestamp v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearTime() => clearField(3);
  @$pb.TagNumber(3)
  $2.Timestamp ensureTime() => $_ensure(2);

  @$pb.TagNumber(4)
  CauseType get causeType => $_getN(3);
  @$pb.TagNumber(4)
  set causeType(CauseType v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasCauseType() => $_has(3);
  @$pb.TagNumber(4)
  void clearCauseType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get causeMessage => $_getSZ(4);
  @$pb.TagNumber(5)
  set causeMessage($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasCauseMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearCauseMessage() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get by => $_getSZ(5);
  @$pb.TagNumber(6)
  set by($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasBy() => $_has(5);
  @$pb.TagNumber(6)
  void clearBy() => clearField(6);
}

class CPID extends $pb.GeneratedMessage {
  factory CPID({
    $core.String? cpid,
  }) {
    final $result = create();
    if (cpid != null) {
      $result.cpid = cpid;
    }
    return $result;
  }
  CPID._() : super();
  factory CPID.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CPID.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CPID',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'k8scpdt.mergelog.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cpid')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CPID clone() => CPID()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CPID copyWith(void Function(CPID) updates) =>
      super.copyWith((message) => updates(message as CPID)) as CPID;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CPID create() => CPID._();
  CPID createEmptyInstance() => create();
  static $pb.PbList<CPID> createRepeated() => $pb.PbList<CPID>();
  @$core.pragma('dart2js:noInline')
  static CPID getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CPID>(create);
  static CPID? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cpid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cpid($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCpid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCpid() => clearField(1);
}

class PostSpansRequest extends $pb.GeneratedMessage {
  factory PostSpansRequest({
    $core.Iterable<Span>? spans,
  }) {
    final $result = create();
    if (spans != null) {
      $result.spans.addAll(spans);
    }
    return $result;
  }
  PostSpansRequest._() : super();
  factory PostSpansRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PostSpansRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PostSpansRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'k8scpdt.mergelog.v1'),
      createEmptyInstance: create)
    ..pc<Span>(1, _omitFieldNames ? '' : 'spans', $pb.PbFieldType.PM,
        subBuilder: Span.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PostSpansRequest clone() => PostSpansRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PostSpansRequest copyWith(void Function(PostSpansRequest) updates) =>
      super.copyWith((message) => updates(message as PostSpansRequest))
          as PostSpansRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PostSpansRequest create() => PostSpansRequest._();
  PostSpansRequest createEmptyInstance() => create();
  static $pb.PbList<PostSpansRequest> createRepeated() =>
      $pb.PbList<PostSpansRequest>();
  @$core.pragma('dart2js:noInline')
  static PostSpansRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PostSpansRequest>(create);
  static PostSpansRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Span> get spans => $_getList(0);
}

class Span extends $pb.GeneratedMessage {
  factory Span({
    CPID? cpid,
    $2.Timestamp? startTime,
    $2.Timestamp? endTime,
    $core.String? service,
    $core.String? objectKind,
    $core.String? objectName,
    $core.String? message,
    $core.String? spanId,
    $core.String? parentId,
  }) {
    final $result = create();
    if (cpid != null) {
      $result.cpid = cpid;
    }
    if (startTime != null) {
      $result.startTime = startTime;
    }
    if (endTime != null) {
      $result.endTime = endTime;
    }
    if (service != null) {
      $result.service = service;
    }
    if (objectKind != null) {
      $result.objectKind = objectKind;
    }
    if (objectName != null) {
      $result.objectName = objectName;
    }
    if (message != null) {
      $result.message = message;
    }
    if (spanId != null) {
      $result.spanId = spanId;
    }
    if (parentId != null) {
      $result.parentId = parentId;
    }
    return $result;
  }
  Span._() : super();
  factory Span.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Span.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Span',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'k8scpdt.mergelog.v1'),
      createEmptyInstance: create)
    ..aOM<CPID>(1, _omitFieldNames ? '' : 'cpid', subBuilder: CPID.create)
    ..aOM<$2.Timestamp>(2, _omitFieldNames ? '' : 'startTime',
        subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(3, _omitFieldNames ? '' : 'endTime',
        subBuilder: $2.Timestamp.create)
    ..aOS(4, _omitFieldNames ? '' : 'service')
    ..aOS(5, _omitFieldNames ? '' : 'objectKind')
    ..aOS(6, _omitFieldNames ? '' : 'objectName')
    ..aOS(7, _omitFieldNames ? '' : 'message')
    ..aOS(8, _omitFieldNames ? '' : 'spanId')
    ..aOS(9, _omitFieldNames ? '' : 'parentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Span clone() => Span()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Span copyWith(void Function(Span) updates) =>
      super.copyWith((message) => updates(message as Span)) as Span;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Span create() => Span._();
  Span createEmptyInstance() => create();
  static $pb.PbList<Span> createRepeated() => $pb.PbList<Span>();
  @$core.pragma('dart2js:noInline')
  static Span getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Span>(create);
  static Span? _defaultInstance;

  @$pb.TagNumber(1)
  CPID get cpid => $_getN(0);
  @$pb.TagNumber(1)
  set cpid(CPID v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCpid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCpid() => clearField(1);
  @$pb.TagNumber(1)
  CPID ensureCpid() => $_ensure(0);

  @$pb.TagNumber(2)
  $2.Timestamp get startTime => $_getN(1);
  @$pb.TagNumber(2)
  set startTime($2.Timestamp v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasStartTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartTime() => clearField(2);
  @$pb.TagNumber(2)
  $2.Timestamp ensureStartTime() => $_ensure(1);

  @$pb.TagNumber(3)
  $2.Timestamp get endTime => $_getN(2);
  @$pb.TagNumber(3)
  set endTime($2.Timestamp v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasEndTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndTime() => clearField(3);
  @$pb.TagNumber(3)
  $2.Timestamp ensureEndTime() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get service => $_getSZ(3);
  @$pb.TagNumber(4)
  set service($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasService() => $_has(3);
  @$pb.TagNumber(4)
  void clearService() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get objectKind => $_getSZ(4);
  @$pb.TagNumber(5)
  set objectKind($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasObjectKind() => $_has(4);
  @$pb.TagNumber(5)
  void clearObjectKind() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get objectName => $_getSZ(5);
  @$pb.TagNumber(6)
  set objectName($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasObjectName() => $_has(5);
  @$pb.TagNumber(6)
  void clearObjectName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get message => $_getSZ(6);
  @$pb.TagNumber(7)
  set message($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearMessage() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get spanId => $_getSZ(7);
  @$pb.TagNumber(8)
  set spanId($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasSpanId() => $_has(7);
  @$pb.TagNumber(8)
  void clearSpanId() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get parentId => $_getSZ(8);
  @$pb.TagNumber(9)
  set parentId($core.String v) {
    $_setString(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasParentId() => $_has(8);
  @$pb.TagNumber(9)
  void clearParentId() => clearField(9);
}

class GetAllSpansResponse extends $pb.GeneratedMessage {
  factory GetAllSpansResponse({
    $core.Iterable<Span>? spans,
  }) {
    final $result = create();
    if (spans != null) {
      $result.spans.addAll(spans);
    }
    return $result;
  }
  GetAllSpansResponse._() : super();
  factory GetAllSpansResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetAllSpansResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAllSpansResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'k8scpdt.mergelog.v1'),
      createEmptyInstance: create)
    ..pc<Span>(1, _omitFieldNames ? '' : 'spans', $pb.PbFieldType.PM,
        subBuilder: Span.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetAllSpansResponse clone() => GetAllSpansResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetAllSpansResponse copyWith(void Function(GetAllSpansResponse) updates) =>
      super.copyWith((message) => updates(message as GetAllSpansResponse))
          as GetAllSpansResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAllSpansResponse create() => GetAllSpansResponse._();
  GetAllSpansResponse createEmptyInstance() => create();
  static $pb.PbList<GetAllSpansResponse> createRepeated() =>
      $pb.PbList<GetAllSpansResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAllSpansResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAllSpansResponse>(create);
  static GetAllSpansResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Span> get spans => $_getList(0);
}

class GetRelevantSpansResponse extends $pb.GeneratedMessage {
  factory GetRelevantSpansResponse({
    $core.Iterable<Span>? spans,
  }) {
    final $result = create();
    if (spans != null) {
      $result.spans.addAll(spans);
    }
    return $result;
  }
  GetRelevantSpansResponse._() : super();
  factory GetRelevantSpansResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetRelevantSpansResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRelevantSpansResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'k8scpdt.mergelog.v1'),
      createEmptyInstance: create)
    ..pc<Span>(1, _omitFieldNames ? '' : 'spans', $pb.PbFieldType.PM,
        subBuilder: Span.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetRelevantSpansResponse clone() =>
      GetRelevantSpansResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetRelevantSpansResponse copyWith(
          void Function(GetRelevantSpansResponse) updates) =>
      super.copyWith((message) => updates(message as GetRelevantSpansResponse))
          as GetRelevantSpansResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRelevantSpansResponse create() => GetRelevantSpansResponse._();
  GetRelevantSpansResponse createEmptyInstance() => create();
  static $pb.PbList<GetRelevantSpansResponse> createRepeated() =>
      $pb.PbList<GetRelevantSpansResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRelevantSpansResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRelevantSpansResponse>(create);
  static GetRelevantSpansResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Span> get spans => $_getList(0);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
