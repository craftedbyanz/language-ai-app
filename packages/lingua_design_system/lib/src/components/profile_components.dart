import 'package:flutter/material.dart';

import '../tokens/generated/design_tokens.dart';

enum ProfileSettingSymbol {
  account,
  lesson,
  voice,
  appearance,
  notification,
  subscription,
  redeem,
  invite,
  rate,
  feedback,
  terms,
  privacy,
  logout,
  language,
}

class ProfileSettingIcon extends StatelessWidget {
  const ProfileSettingIcon({required this.symbol, super.key});
  final ProfileSettingSymbol symbol;

  @override
  Widget build(BuildContext context) => Image.asset(
    'assets/icons/profile/${symbol.name}.png',
    package: 'lingua_design_system',
    width: IconTokens.profileSetting,
    height: IconTokens.profileSetting,
    color: ColorTokens.textSecondary,
    colorBlendMode: BlendMode.srcIn,
    excludeFromSemantics: true,
  );
}

class ProfileIdentity extends StatelessWidget {
  const ProfileIdentity({required this.name, required this.plan, super.key});
  final String name;
  final String plan;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            key: const Key('profile-avatar'),
            width: LayoutTokens.profileAvatar,
            height: LayoutTokens.profileAvatar,
            padding: const EdgeInsets.all(SpaceTokens.xs),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ColorTokens.border),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: FeatureTokens.profileAvatarFill,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/icons/profile/person.png',
                  package: 'lingua_design_system',
                  width: IconTokens.profileAvatar,
                  height: IconTokens.profileAvatar,
                  color: FeatureTokens.profileAvatarGlyph,
                  colorBlendMode: BlendMode.srcIn,
                  excludeFromSemantics: true,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -SpaceTokens.xs,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ColorTokens.background,
                borderRadius: BorderRadius.circular(RadiusTokens.full),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpaceTokens.sm,
                  vertical: SpaceTokens.xs,
                ),
                child: Text(
                  plan,
                  style: TypographyTokens.profileBadge.copyWith(
                    color: ColorTokens.textSecondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: SpaceTokens.lg),
      Text(name, style: TypographyTokens.profileName),
    ],
  );
}

/// Visual preview only, consistent with the deferred purchasing policy.
class ProfileUpgradePreview extends StatelessWidget {
  const ProfileUpgradePreview({
    required this.title,
    required this.caption,
    required this.action,
    super.key,
  });
  final String title;
  final String caption;
  final String action;

  @override
  Widget build(BuildContext context) => Container(
    key: const Key('profile-upgrade-preview'),
    constraints: const BoxConstraints(
      minHeight: LayoutTokens.profilePromoHeight,
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: SpaceTokens.md,
      vertical: SpaceTokens.md,
    ),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          ColorTokens.primaryStrong,
          FeatureTokens.homeWritingFill,
          FeatureTokens.profilePromoEnd,
        ],
      ),
      borderRadius: BorderRadius.circular(RadiusTokens.card),
    ),
    child: Row(
      children: [
        const ProfileBrandMark(),
        const SizedBox(width: SpaceTokens.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TypographyTokens.profilePromoTitle.copyWith(
                  color: ColorTokens.textOnPrimary,
                ),
              ),
              Text(
                caption,
                style: TypographyTokens.profileSection.copyWith(
                  color: ColorTokens.textOnPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: SpaceTokens.sm),
        // A preview badge, not an independent purchase target.
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: SpaceTokens.md,
            vertical: SpaceTokens.sm,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: GlassTokens.homeDockButtonFill),
            borderRadius: BorderRadius.circular(RadiusTokens.full),
          ),
          child: Text(
            action,
            style: TypographyTokens.profileRow.copyWith(
              color: ColorTokens.textOnPrimary,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Full-colour artwork shared by the Profile promo and footer.
class ProfileBrandMark extends StatelessWidget {
  const ProfileBrandMark({super.key});

  @override
  Widget build(BuildContext context) => Image.asset(
    'assets/icons/profile/plus.png',
    package: 'lingua_design_system',
    width: IconTokens.profilePromo,
    height: IconTokens.profilePromo,
    excludeFromSemantics: true,
  );
}
