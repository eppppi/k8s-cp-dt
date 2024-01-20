import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'generated/merge_log.pbgrpc.dart';
import 'package:grpc/grpc_web.dart';
import 'all_mergelogs_page.dart';
import 'all_spans_page.dart';

class CpidPage extends StatefulWidget {
  CpidPage({Key? key, required this.cpid}) : super(key: key);
  final String cpid;

  @override
  State<CpidPage> createState() => _CpidPageState();
}

class _CpidPageState extends State<CpidPage> {
  late Future<List<Span>> _relevantSpans;
  late Future<List<Mergelog>> _relevantMergelogs;

  @override
  void initState() {
    super.initState();
    debugPrint("widget.cpig: ${widget.cpid}");
    _relevantMergelogs = getRelevantMergelogs(widget.cpid);
    _relevantSpans = getRelevantSpans(widget.cpid);
  }

  @override
  Widget build(BuildContext context) {
    // return Placeholder();
    return Scaffold(
      appBar: AppBar(
        title: const Text('CPID Details'),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: SelectableText(
                'CPID: ${widget.cpid}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FutureBuilder(
                      future: _relevantMergelogs,
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
                              return Expanded(
                                  child: SelectableText('No mergelogs.'));
                            } else {
                              return Column(
                                children: [
                                  SelectableText(
                                    'Mergelogs',
                                  ),
                                  Expanded(
                                    child: ListView(
                                      children: [
                                        for (final mergelog in snapshot.data!)
                                          Card(child: mergelogTable(mergelog)),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                        }
                      }),
                    ),
                  ),
                  SizedBox(
                    width: 500,
                    child: FutureBuilder(
                        future: _relevantSpans,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return const Text("none");
                            case ConnectionState.waiting:
                              return const Text("waiting");
                            case ConnectionState.active:
                              return const Text("active");
                            case ConnectionState.done:
                              if (snapshot.data!.isEmpty) {
                                return Expanded(
                                    child: SelectableText('No spans.'));
                              } else {
                                return Column(
                                  children: [
                                    SelectableText(
                                      'Spans',
                                    ),
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          for (final span in snapshot.data!)
                                            Card(
                                                child:
                                                    spanTable(context, span)),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Mergelog>> getRelevantMergelogs(String cpid) async {
  const proxyPort = 9000;
  final channel =
      GrpcWebClientChannel.xhr(Uri.parse('http://localhost:$proxyPort'));
  final stub = MergelogServiceClient(channel);

  final request = CPID(cpid: cpid);

  try {
    final response = await stub.getRelevantMergelogs(request);
    final mergelogs = response.mergelogs;

    // debugPrint('got response $mergelogs');
    return Future.value(mergelogs);
  } catch (e) {
    debugPrint('Caught error: $e');
  }
  await channel.shutdown();
  // TODO: throw error?
  return Future<List<Mergelog>>.value(List<Mergelog>.empty());
}

Future<List<Span>> getRelevantSpans(String cpid) async {
  const proxyPort = 9000;
  final channel =
      GrpcWebClientChannel.xhr(Uri.parse('http://localhost:$proxyPort'));
  final stub = MergelogServiceClient(channel);

  final request = CPID(cpid: cpid);

  try {
    final response = await stub.getRelevantSpans(request);
    final spans = response.spans;

    // debugPrint('got response $spans');
    return Future.value(spans);
  } catch (e) {
    debugPrint('Caught error: $e');
  }
  await channel.shutdown();
  // TODO: throw error?
  return Future<List<Span>>.value(List<Span>.empty());
}
