//
//  Generated code. Do not modify.
//  source: src/api/merge_log.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/empty.pb.dart' as $1;
import 'merge_log.pb.dart' as $0;

export 'merge_log.pb.dart';

@$pb.GrpcServiceName('k8scpdt.mergelog.v1.MergelogService')
class MergelogServiceClient extends $grpc.Client {
  static final _$postMergelogs =
      $grpc.ClientMethod<$0.MergelogRequest, $1.Empty>(
          '/k8scpdt.mergelog.v1.MergelogService/PostMergelogs',
          ($0.MergelogRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$getAllMergelogs = $grpc.ClientMethod<$1.Empty, $0.Mergelogs>(
      '/k8scpdt.mergelog.v1.MergelogService/GetAllMergelogs',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Mergelogs.fromBuffer(value));
  static final _$getRelevantMergelogs =
      $grpc.ClientMethod<$0.CPID, $0.Mergelogs>(
          '/k8scpdt.mergelog.v1.MergelogService/GetRelevantMergelogs',
          ($0.CPID value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Mergelogs.fromBuffer(value));
  static final _$deleteAllMergelogs = $grpc.ClientMethod<$1.Empty, $1.Empty>(
      '/k8scpdt.mergelog.v1.MergelogService/DeleteAllMergelogs',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$postSpans = $grpc.ClientMethod<$0.PostSpansRequest, $1.Empty>(
      '/k8scpdt.mergelog.v1.MergelogService/PostSpans',
      ($0.PostSpansRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$getAllSpans =
      $grpc.ClientMethod<$1.Empty, $0.GetAllSpansResponse>(
          '/k8scpdt.mergelog.v1.MergelogService/GetAllSpans',
          ($1.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetAllSpansResponse.fromBuffer(value));
  static final _$getRelevantSpans =
      $grpc.ClientMethod<$0.CPID, $0.GetRelevantSpansResponse>(
          '/k8scpdt.mergelog.v1.MergelogService/GetRelevantSpans',
          ($0.CPID value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetRelevantSpansResponse.fromBuffer(value));
  static final _$deleteAllSpans = $grpc.ClientMethod<$1.Empty, $1.Empty>(
      '/k8scpdt.mergelog.v1.MergelogService/DeleteAllSpans',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  MergelogServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Empty> postMergelogs($0.MergelogRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$postMergelogs, request, options: options);
  }

  $grpc.ResponseFuture<$0.Mergelogs> getAllMergelogs($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAllMergelogs, request, options: options);
  }

  $grpc.ResponseFuture<$0.Mergelogs> getRelevantMergelogs($0.CPID request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRelevantMergelogs, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteAllMergelogs($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAllMergelogs, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> postSpans($0.PostSpansRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$postSpans, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAllSpansResponse> getAllSpans($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAllSpans, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetRelevantSpansResponse> getRelevantSpans(
      $0.CPID request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRelevantSpans, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteAllSpans($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAllSpans, request, options: options);
  }
}

@$pb.GrpcServiceName('k8scpdt.mergelog.v1.MergelogService')
abstract class MergelogServiceBase extends $grpc.Service {
  $core.String get $name => 'k8scpdt.mergelog.v1.MergelogService';

  MergelogServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.MergelogRequest, $1.Empty>(
        'PostMergelogs',
        postMergelogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MergelogRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.Mergelogs>(
        'GetAllMergelogs',
        getAllMergelogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.Mergelogs value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CPID, $0.Mergelogs>(
        'GetRelevantMergelogs',
        getRelevantMergelogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CPID.fromBuffer(value),
        ($0.Mergelogs value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.Empty>(
        'DeleteAllMergelogs',
        deleteAllMergelogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PostSpansRequest, $1.Empty>(
        'PostSpans',
        postSpans_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PostSpansRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.GetAllSpansResponse>(
        'GetAllSpans',
        getAllSpans_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.GetAllSpansResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CPID, $0.GetRelevantSpansResponse>(
        'GetRelevantSpans',
        getRelevantSpans_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CPID.fromBuffer(value),
        ($0.GetRelevantSpansResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.Empty>(
        'DeleteAllSpans',
        deleteAllSpans_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> postMergelogs_Pre(
      $grpc.ServiceCall call, $async.Future<$0.MergelogRequest> request) async {
    return postMergelogs(call, await request);
  }

  $async.Future<$0.Mergelogs> getAllMergelogs_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return getAllMergelogs(call, await request);
  }

  $async.Future<$0.Mergelogs> getRelevantMergelogs_Pre(
      $grpc.ServiceCall call, $async.Future<$0.CPID> request) async {
    return getRelevantMergelogs(call, await request);
  }

  $async.Future<$1.Empty> deleteAllMergelogs_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return deleteAllMergelogs(call, await request);
  }

  $async.Future<$1.Empty> postSpans_Pre($grpc.ServiceCall call,
      $async.Future<$0.PostSpansRequest> request) async {
    return postSpans(call, await request);
  }

  $async.Future<$0.GetAllSpansResponse> getAllSpans_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return getAllSpans(call, await request);
  }

  $async.Future<$0.GetRelevantSpansResponse> getRelevantSpans_Pre(
      $grpc.ServiceCall call, $async.Future<$0.CPID> request) async {
    return getRelevantSpans(call, await request);
  }

  $async.Future<$1.Empty> deleteAllSpans_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return deleteAllSpans(call, await request);
  }

  $async.Future<$1.Empty> postMergelogs(
      $grpc.ServiceCall call, $0.MergelogRequest request);
  $async.Future<$0.Mergelogs> getAllMergelogs(
      $grpc.ServiceCall call, $1.Empty request);
  $async.Future<$0.Mergelogs> getRelevantMergelogs(
      $grpc.ServiceCall call, $0.CPID request);
  $async.Future<$1.Empty> deleteAllMergelogs(
      $grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.Empty> postSpans(
      $grpc.ServiceCall call, $0.PostSpansRequest request);
  $async.Future<$0.GetAllSpansResponse> getAllSpans(
      $grpc.ServiceCall call, $1.Empty request);
  $async.Future<$0.GetRelevantSpansResponse> getRelevantSpans(
      $grpc.ServiceCall call, $0.CPID request);
  $async.Future<$1.Empty> deleteAllSpans(
      $grpc.ServiceCall call, $1.Empty request);
}
