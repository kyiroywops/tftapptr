import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/presentation/providers/matchs_providers.dart';

class ProPlayersScreen extends ConsumerStatefulWidget {
  const ProPlayersScreen({Key? key}) : super(key: key);

  @override
  _ProPlayersScreenState createState() => _ProPlayersScreenState();
}

class _ProPlayersScreenState extends ConsumerState<ProPlayersScreen> {
  late List<String> cachedMatchIds;
  bool isLoading = false;
  String? errorMessage;

 
  @override
  void initState() {
    super.initState();
    fetchMatchIds();
  }

  void fetchMatchIds() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final puuid = '9wtqe0_9jqnAzHb-NzMeHQ0CQADVq0GQsS-F_2nU_ZEiO4QhjhXPKRTLppRTza9S1927K-eONC5IGQ';
      final matchIds = await ref.read(matchIdsProvider({'puuid': puuid, 'region': 'americas'}).future);
      setState(() {
        cachedMatchIds = matchIds;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partidas del Jugador'),
      ),
      body: isLoading
          ? const CircularProgressIndicator()
          : errorMessage != null
              ? ErrorWidget(
                  errorMessage: errorMessage!,
                  retryCallback: fetchMatchIds,
                )
              : ListView.builder(
                  itemCount: cachedMatchIds.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(cachedMatchIds[index]),
                  ),
                ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback retryCallback;

  const ErrorWidget({Key? key, required this.errorMessage, required this.retryCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage),
          ElevatedButton(
            onPressed: retryCallback,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
