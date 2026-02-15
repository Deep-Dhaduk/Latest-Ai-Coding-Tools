import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/storage_service.dart';
import '../widgets/glass_card.dart';
import '../widgets/progress_ring.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE8F4FC),
              Color(0xFFD4E9F7),
              Color(0xFFB8DDF0),
            ],
          ),
        ),
        child: SafeArea(
          child: Consumer<StorageService>(
            builder: (context, storage, _) {
              if (!storage.loaded) {
                return const Center(child: CircularProgressIndicator());
              }
              return _buildContent(context, storage);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, StorageService storage) {
    final progress = storage.goalMl > 0
        ? (storage.currentMl / storage.goalMl).clamp(0.0, 1.0)
        : 0.0;
    final glasses = storage.currentMl ~/ 250;
    final nf = NumberFormat.decimalPattern();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
            child: Column(
              children: [
                Text(
                  'Hydrate',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2C5282),
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Today’s intake',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF2C5282).withOpacity(0.8),
                      ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GlassCard(
                    borderRadius: 999,
                    padding: const EdgeInsets.all(24),
                    child: ProgressRing(
                      progress: progress,
                      size: 200,
                      strokeWidth: 14,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${storage.currentMl}',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF2C5282),
                            ),
                      ),
                      Text(
                        'ml',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: const Color(0xFF2C5282).withOpacity(0.7),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: GlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$glasses glasses · ${nf.format(storage.currentMl)} of ${nf.format(storage.goalMl)} ml',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFF2C5282),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: GestureDetector(
                onTapDown: (_) => _pulseController.forward(),
                onTapUp: (_) => _pulseController.reverse(),
                onTapCancel: () => _pulseController.reverse(),
                onTap: () => storage.addWater(),
                child: ScaleTransition(
                  scale: Tween<double>(begin: 1, end: 0.92).animate(
                    CurvedAnimation(
                      parent: _pulseController,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: GlassCard(
                    borderRadius: 999,
                    padding: const EdgeInsets.all(20),
                    opacity: 0.4,
                    child: const Icon(
                      Icons.add_rounded,
                      size: 48,
                      color: Color(0xFF2C5282),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: Text(
              'History',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: const Color(0xFF2C5282).withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
        if (storage.todayHistory.isEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: GlassCard(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Tap + to add a glass of water',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF2C5282).withOpacity(0.7),
                          ),
                    ),
                  ),
                ),
              ),
            ),
          )
        else
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final ml = storage.todayHistory[
                    storage.todayHistory.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                  child: GlassCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.water_drop_rounded,
                          color: const Color(0xFF5B9BD5).withOpacity(0.9),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '+ $ml ml',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: const Color(0xFF2C5282),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: storage.todayHistory.length,
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}
