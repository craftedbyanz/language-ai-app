import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../tokens/generated/design_tokens.dart';

/// Reference keyframe animation, with a fixed layout and motion preferences.
class StreakFlame extends StatefulWidget {
  const StreakFlame({required this.isActive, super.key});

  final bool isActive;

  @override
  State<StreakFlame> createState() => _StreakFlameState();
}

class _StreakFlameState extends State<StreakFlame>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _controller = AnimationController(vsync: this);
  bool _foreground = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final lifecycle = WidgetsBinding.instance.lifecycleState;
    _foreground = lifecycle == null || lifecycle == AppLifecycleState.resumed;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncAnimation();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _foreground = state == AppLifecycleState.resumed;
    _syncAnimation();
  }

  void _syncAnimation() {
    final reducedMotion = MediaQuery.disableAnimationsOf(context);
    if (_controller.duration != null &&
        _foreground &&
        TickerMode.valuesOf(context).enabled &&
        !reducedMotion) {
      if (!_controller.isAnimating) _controller.repeat();
    } else {
      _controller.stop();
      if (reducedMotion) _controller.value = 0;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: RepaintBoundary(
      child: SizedBox.square(
        dimension: IconTokens.streakHero,
        child: Lottie.asset(
          'assets/animations/streak_flame_${widget.isActive ? 'active' : 'inactive'}.json',
          package: 'lingua_design_system',
          controller: _controller,
          fit: BoxFit.contain,
          frameRate: FrameRate.composition,
          onLoaded: (composition) {
            if (!mounted) return;
            _controller.duration = composition.duration;
            _syncAnimation();
          },
        ),
      ),
    ),
  );
}
