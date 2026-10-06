import 'package:flutter/material.dart';
import 'package:ota_test/features/my_home_page/view/my_home_page.dart';
import 'package:ota_test/features/update/provider/update_provider.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 0.85).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startUpdate();
    });
  }

  Future<void> _startUpdate() async {
    final provider = context.read<UpdateProvider>();

    // Start the animated progress bar (goes to 85% while downloading)
    _animationController.forward();

    await provider.checkAndUpdate();

    if (!mounted) return;

    // Complete the progress bar to 100%
    await _animationController.animateTo(
      1.0,
      duration: const Duration(milliseconds: 400),
    );

    if (!mounted) return;

    // Navigate to home
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MyHomePage()),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UpdateProvider>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              Icon(
                Icons.system_update_alt_rounded,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 32),
              Text(
                _statusText(provider.status),
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, _) {
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: _progressAnimation.value,
                          minHeight: 10,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${(_progressAnimation.value * 100).toInt()}%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  );
                },
              ),
              if (provider.status == AppUpdateStatus.error) ...[
                const SizedBox(height: 24),
                Text(
                  provider.errorMessage ?? 'Unknown error',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  String _statusText(AppUpdateStatus status) {
    switch (status) {
      case AppUpdateStatus.checking:
        return 'Checking for updates...';
      case AppUpdateStatus.downloading:
        return 'Downloading update...';
      case AppUpdateStatus.restartRequired:
        return 'Update ready!';
      case AppUpdateStatus.noUpdate:
        return 'You\'re up to date!';
      case AppUpdateStatus.error:
        return 'Update check failed.\nContinuing...';
    }
  }
}
