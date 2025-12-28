import 'package:core/core.dart';

final class OnboardingCacheModel with CacheModel {
  const OnboardingCacheModel({required this.showOnboarding});

  const OnboardingCacheModel.empty() : showOnboarding = true;

  final bool showOnboarding;

  @override
  String get id => 'onboarding_cache';

  @override
  OnboardingCacheModel fromDynamicJson(dynamic json) {
    final jsonMap = json as Map<String, dynamic>?;
    if (jsonMap == null || !jsonMap.containsKey('showOnboarding')) {
      return const OnboardingCacheModel.empty();
    }
    final showOnboarding = jsonMap['showOnboarding'] as bool;
    return OnboardingCacheModel(showOnboarding: showOnboarding);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'showOnboarding': showOnboarding};
  }

  OnboardingCacheModel copyWith({bool? showOnboarding}) {
    return OnboardingCacheModel(showOnboarding: showOnboarding ?? this.showOnboarding);
  }
}
