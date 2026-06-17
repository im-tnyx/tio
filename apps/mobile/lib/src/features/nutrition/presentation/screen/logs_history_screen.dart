import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/tokens/foundation/dimens.dart';

class LogItem {
  final String text;
  final DateTime createdAt;

  LogItem({required this.text, required this.createdAt});
}

class LogsHistoryScreen extends StatefulWidget {
  const LogsHistoryScreen({super.key});

  @override
  State<LogsHistoryScreen> createState() => _LogsHistoryScreenState();
}

class _LogsHistoryScreenState extends State<LogsHistoryScreen> {
  List<LogItem> _logs = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchLogs();
  }

  Future<void> _fetchLogs() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final supabase = Supabase.instance.client;
      final currentUser = supabase.auth.currentUser;

      if (currentUser != null) {
        // Fetch from Supabase
        final response = await supabase
            .from('text_logs')
            .select('raw_text, created_at')
            .eq('user_id', currentUser.id)
            .order('created_at', ascending: false);

        final List<dynamic> data = response as List<dynamic>;
        setState(() {
          _logs = data.map((item) {
            return LogItem(
              text: item['raw_text'] as String,
              createdAt: DateTime.parse(item['created_at'] as String),
            );
          }).toList();
        });
      } else {
        // Fetch from Mock SharedPreferences List
        final prefs = await SharedPreferences.getInstance();
        final List<String> rawList =
            prefs.getStringList('mock_text_logs') ?? [];
        final List<LogItem> parsedLogs = rawList.map((entry) {
          final parts = entry.split('|||');
          if (parts.length >= 2) {
            return LogItem(text: parts[1], createdAt: DateTime.parse(parts[0]));
          }
          return LogItem(text: entry, createdAt: DateTime.now());
        }).toList();

        // Sort descending
        parsedLogs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        setState(() {
          _logs = parsedLogs;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load logs: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Log History Feed'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _fetchLogs),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _fetchLogs,
          child: _buildContent(theme),
        ),
      ),
    );
  }

  Widget _buildContent(ThemeData theme) {
    if (_isLoading && _logs.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null && _logs.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.paddingScreen),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _errorMessage!,
                style: TextStyle(color: theme.colorScheme.error),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimens.spaceM),
              ElevatedButton(
                onPressed: _fetchLogs,
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    if (_logs.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          Center(
            child: Text(
              'No food logs found.\nStart by adding your first entry!',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(Dimens.paddingScreen),
      itemCount: _logs.length,
      itemBuilder: (context, index) {
        final log = _logs[index];
        final timeStr = DateFormat('jm').format(log.createdAt.toLocal());
        final dateStr = DateFormat('yMMMMd').format(log.createdAt.toLocal());

        return Card(
          margin: const EdgeInsets.only(bottom: Dimens.spaceM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.radiusCard),
          ),
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spaceM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateStr,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      timeStr,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.spaceS),
                Text(
                  log.text,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
