import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'generated/merge_log.pbgrpc.dart';
import 'generated/google/protobuf/empty.pb.dart' as $1;
import 'package:grpc/grpc_web.dart';
import 'lib/lib.dart';

class AllMergelogsPage extends StatefulWidget {
  const AllMergelogsPage({super.key});

  @override
  State<AllMergelogsPage> createState() => _AllMergelogsPageState();
}

class _AllMergelogsPageState extends State<AllMergelogsPage> {
  late Future<List<Mergelog>> _allMergelogs;

  @override
  void initState() {
    super.initState();
    _allMergelogs = getAllMergelogs();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _allMergelogs,
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
              return Expanded(child: SelectableText('No mergelogs.'));
            } else {
              return Column(
                children: [
                  SelectableText('size: ${snapshot.data!.length}'),
                  Expanded(
                    child: ListView(
                      children: [
                        for (final ml in snapshot.data!)
                          Card(child: mergelogTable(ml)),
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

Widget mergelogTable(Mergelog mergelog) {
  return ListTile(
    title: SelectionArea(
      child: Table(
        border: TableBorder.all(color: Colors.grey),
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: IntrinsicColumnWidth(),
        },
        children: [
          // newCpid
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("New CPID"),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(mergelog.newCpid.cpid.toString()),
              ),
            ],
          ),
          // sourceCpids
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Source CPIDs"),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: (mergelog.sourceCpids.isEmpty)
                    ? Text('(None)')
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('(size: ${mergelog.sourceCpids.length})'),
                          for (final cpid in mergelog.sourceCpids)
                            Text(cpid.cpid.toString()),
                        ],
                      ),
              ),
            ],
          ),
          // mergedTime
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Merged Time"),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(mergelog.time.toDateTime().toString()),
              ),
            ],
          ),
          // causeType
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Cause Type"),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(mergelog.causeType.toString()),
              ),
            ],
          ),
          // causeMessage
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Cause Message"),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(mergelog.causeMessage.toString()),
              ),
            ],
          ),
          // by
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("By"),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(mergelog.by.toString()),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Future<List<Mergelog>> getAllMergelogs() async {
  const proxyPort = 9000;
  final channel =
      GrpcWebClientChannel.xhr(Uri.parse('http://localhost:$proxyPort'));
  final stub = MergelogServiceClient(channel);

  final emptyRequest = $1.Empty();

  try {
    final response = await stub.getAllMergelogs(emptyRequest);
    final mergelogs = response.mergelogs;

    debugPrint('got response $mergelogs');
    return Future.value(mergelogs);
  } catch (e) {
    // statusText += "cought error: $e";
    debugPrint('Caught error: $e');
    print('hoge');
  }
  await channel.shutdown();
  // TODO: throw error?
  return Future<List<Mergelog>>.value(List<Mergelog>.empty());
}
