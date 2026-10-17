import 'package:flutter/widgets.dart';

import '../tokens/generated/design_tokens.dart';

enum CountryFlag { unitedStates, southKorea, china, japan }

/// Packaged artwork avoids platform-dependent emoji glyphs and fallback fonts.
class CountryFlagIcon extends StatelessWidget {
  const CountryFlagIcon({required this.country, super.key});
  final CountryFlag country;

  @override
  Widget build(BuildContext context) {
    final name = switch (country) {
      CountryFlag.unitedStates => 'united_states',
      CountryFlag.southKorea => 'south_korea',
      CountryFlag.china => 'china',
      CountryFlag.japan => 'japan',
    };
    return Image.asset(
      'assets/flags/$name.png',
      package: 'lingua_design_system',
      width: IconTokens.tile,
      height: IconTokens.tile,
      excludeFromSemantics: true,
    );
  }
}
