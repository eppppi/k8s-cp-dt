import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'generated/merge_log.pbgrpc.dart';
import 'generated/google/protobuf/empty.pb.dart' as $1;
import 'package:grpc/grpc_web.dart';
// import 'lib/lib.dart';

class AllSpansPage extends StatefulWidget {
  const AllSpansPage({super.key});

  @override
  State<AllSpansPage> createState() => _AllSpansPageState();
}

class _AllSpansPageState extends State<AllSpansPage> {
  late Future<List<Span>> _allSpans;

  @override
  void initState() {
    super.initState();
    _allSpans = getAllSpans();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _allSpans,
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text("none");
          case ConnectionState.waiting:
            return const Text("waiting");
          case ConnectionState.active:
            return const Text("active");
          case ConnectionState.done:
            if (snapshot.data!.isEmpty) {
              return Expanded(child: SelectableText('No spans.'));
            } else {
              return Column(
                children: [
                  SelectableText('size: ${snapshot.data!.length}'),
                  Expanded(
                    child: ListView(
                      children: [
                        for (final span in snapshot.data!)
                          Card(child: spanTable(context, span)),
                      ],
                    ),
                  ),
                ],
              );
            }
        }
      }),
    );
  }
}

Widget spanTable(BuildContext context, Span span) {
  return ListTile(
    title: SelectionArea(
      child: Table(
        border: TableBorder.all(color: Colors.grey),
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: IntrinsicColumnWidth(),
        },
        children: [
          spanTableRow('cpid', span.cpid.cpid.toString()),
          spanTableRow('start time', span.startTime.toDateTime().toString()),
          spanTableRow('end time', span.endTime.toDateTime().toString()),
          spanTableRow('service (controller)', span.service.toString()),
          spanTableRow('Object Kind', span.objectKind.toString()),
          spanTableRow('Object Name', span.objectName.toString()),
          spanTableRow('Message', span.message.toString()),
          spanTableRow('Span ID', span.spanId.toString()),
          spanTableRow('Parent Span ID', span.parentId.toString()),
        ],
      ),
    ),
  );
}

TableRow spanTableRow(String key, String value) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(key),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(value),
      ),
    ],
  );
}

Future<List<Span>> getAllSpans() async {
  const proxyPort = 9000;
  final channel =
      GrpcWebClientChannel.xhr(Uri.parse('http://localhost:$proxyPort'));
  final stub = MergelogServiceClient(channel);

  final emptyRequest = $1.Empty();

  try {
    final response = await stub.getAllSpans(emptyRequest);
    final spans = response.spans;

    debugPrint('got response $spans');
    return Future.value(spans);
  } catch (e) {
    // statusText += "cought error: $e";
    debugPrint('Caught error: $e');
    print('hoge');
  }
  await channel.shutdown();
  // TODO: throw error?
  return Future<List<Span>>.value(List<Span>.empty());
}
