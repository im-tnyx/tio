import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/theme/tokens/foundation/dimens.dart';
import '../../../../core/widgets/action_buttons.dart';

class NutritionDashboardScreen extends StatefulWidget {
  const NutritionDashboardScreen({super.key});

  @override
  State<NutritionDashboardScreen> createState() =>
      _NutritionDashboardScreenState();
}

class _NutritionDashboardScreenState extends State<NutritionDashboardScreen> {
  final _logController = TextEditingController();
  bool _isSaving = false;
  String? _statusMessage;
  bool _isLive = false;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  void _checkStatus() {
    final currentUser = Supabase.instance.client.auth.currentUser;
    setState(() {
      _isLive = currentUser != null;
    });
  }

  @override
  void dispose() {
    _logController.dispose();
    super.dispose();
  }

  Future<void> _handleLogSubmit() async {
    final rawText = _logController.text.trim();
    if (rawText.isEmpty) return;

    setState(() {
      _isSaving = true;
      _statusMessage = null;
    });

    try {
      final supabase = Supabase.instance.client;
      final currentUser = supabase.auth.currentUser;

      if (currentUser != null) {
        // Sync to Supabase
        await supabase.from('text_logs').insert({
          'user_id': currentUser.id,
          'raw_text': rawText,
          'created_at': DateTime.now().toIso8601String(),
        });
      } else {
        // Mock Mode: Save locally to SharedPreferences list
        final prefs = await SharedPreferences.getInstance();
        final List<String> currentLogs =
            prefs.getStringList('mock_text_logs') ?? [];
        final logEntry = '${DateTime.now().toIso8601String()}|||$rawText';
        currentLogs.add(logEntry);
        await prefs.setStringList('mock_text_logs', currentLogs);
      }

      _logController.clear();
      setState(() {
        _statusMessage = 'Log submitted successfully!';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error saving log: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('TIO Health OS'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Dimens.paddingScreen),
            child: Chip(
              label: Text(_isLive ? 'Supabase Live' : 'Offline Mock'),
              backgroundColor: _isLive
                  ? Colors.green.withValues(alpha: 0.15)
                  : Colors.amber.withValues(alpha: 0.15),
              labelStyle: TextStyle(
                color: _isLive ? Colors.green : Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              side: BorderSide.none,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.paddingScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: Dimens.spaceM),
              Text(
                'What did you eat?',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Dimens.spaceXS),
              Text(
                'Type your food or health entries. We will store raw unstructured logs for Phase 1.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: Dimens.spaceXL),
              TextField(
                controller: _logController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText:
                      'e.g., I had a bowl of oats with milk, sliced bananas, and a cup of black coffee for breakfast.',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimens.radiusCard),
                  ),
                ),
              ),
              const SizedBox(height: Dimens.spaceXL),
              if (_statusMessage != null) ...[
                Text(
                  _statusMessage!,
                  style: TextStyle(
                    color: _statusMessage!.contains('Error')
                        ? theme.colorScheme.error
                        : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Dimens.spaceM),
              ],
              if (_isSaving)
                const Center(child: CircularProgressIndicator())
              else
                PrimaryButton(
                  text: 'Log Food Entry',
                  onPressed: _handleLogSubmit,
                  expand: true,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
