import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:kartal/kartal.dart';

class LoginRequiredPopup extends StatefulWidget {
  const LoginRequiredPopup({
    super.key,
    required this.onLoginPressed,
  });

  final VoidCallback onLoginPressed;

  @override
  State<LoginRequiredPopup> createState() => _LoginRequiredPopupState();
}

class _LoginRequiredPopupState extends BaseState<LoginRequiredPopup>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    if (!productViewModel.state.isLogin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() => _isVisible = true);
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _close() async {
    await _controller.reverse();
    if (!mounted) return;
    setState(() => _isVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    if (productViewModel.state.isLogin || !_isVisible) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;
    final dialogWidth = context.sized.width > 560
        ? context.sized.width * 0.34
        : context.sized.width * 0.88;

    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () async {
                  await _close();
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.scrim.withValues(
                        alpha: isDark ? 0.62 : 0.42,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: dialogWidth.clamp(300, 420),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(normal),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  colorScheme.surface.withValues(
                                    alpha: isDark ? 0.995 : 0.99,
                                  ),
                                  colorScheme.surfaceContainerHigh.withValues(
                                    alpha: isDark ? 0.98 : 0.97,
                                  ),
                                  colorScheme.surfaceContainerHighest
                                      .withValues(
                                    alpha: isDark ? 0.96 : 0.95,
                                  ),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                normal * 1.8,
                              ),
                              border: Border.all(
                                color: colorScheme.outline.withValues(
                                  alpha: 0.16,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.shadow.withValues(
                                    alpha: isDark ? 0.28 : 0.12,
                                  ),
                                  blurRadius: context.sized.height * 0.03,
                                  offset: Offset(0, normal),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(
                                context.sized.height * 0.028,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: normal * 0.75,
                                            vertical: low * 0.75,
                                          ),
                                          decoration: BoxDecoration(
                                            color: colorScheme.primary
                                                .withValues(alpha: 0.10),
                                            borderRadius: BorderRadius.circular(
                                              normal * 1.4,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.lock_outline_rounded,
                                                size: context.sized.normalValue,
                                                color: colorScheme.primary,
                                              ),
                                              SizedBox(width: low * 0.55),
                                              Flexible(
                                                child: Text(
                                                  LocaleKeys
                                                      .general_button_login
                                                      .tr(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: theme
                                                      .textTheme.labelLarge
                                                      ?.copyWith(
                                                    color: colorScheme.primary,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: low),
                                      IconButton(
                                        onPressed: () async {
                                          await _close();
                                        },
                                        style: IconButton.styleFrom(
                                          backgroundColor: colorScheme
                                              .surfaceContainerHighest
                                              .withValues(
                                            alpha: isDark ? 0.86 : 0.94,
                                          ),
                                          foregroundColor:
                                              colorScheme.onSurfaceVariant,
                                        ),
                                        icon: const Icon(Icons.close_rounded),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: normal * 1.1),
                                  Center(
                                    child: Container(
                                      width: context.sized.height * 0.095,
                                      height: context.sized.height * 0.095,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            colorScheme.primary.withValues(
                                              alpha: 0.22,
                                            ),
                                            colorScheme.secondary.withValues(
                                              alpha: 0.16,
                                            ),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: colorScheme.primary
                                                .withValues(alpha: 0.18),
                                            blurRadius:
                                                context.sized.height * 0.02,
                                            spreadRadius:
                                                context.sized.lowValue * 0.2,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.mark_chat_unread_rounded,
                                        size: context.sized.height * 0.045,
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: normal * 1.15),
                                  Text(
                                    LocaleKeys.popup_login_required_title.tr(),
                                    textAlign: TextAlign.center,
                                    style:
                                        theme.textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      height: 1.2,
                                    ),
                                  ),
                                  SizedBox(height: low * 0.75),
                                  Text(
                                    LocaleKeys.popup_login_required_description
                                        .tr(),
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                      height: 1.5,
                                    ),
                                  ),
                                  SizedBox(height: normal * 1.25),
                                  Container(
                                    padding: EdgeInsets.all(normal),
                                    decoration: BoxDecoration(
                                      color: colorScheme.surfaceContainerHigh
                                          .withValues(
                                        alpha: isDark ? 0.84 : 0.94,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        normal * 1.25,
                                      ),
                                      border: Border.all(
                                        color: colorScheme.outline.withValues(
                                          alpha: 0.12,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.shield_outlined,
                                          color: colorScheme.primary,
                                          size: context.sized.normalValue * 1.2,
                                        ),
                                        SizedBox(width: low * 0.75),
                                        Expanded(
                                          child: Text(
                                            LocaleKeys.auth_login_banner_message
                                                .tr(),
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                              color:
                                                  colorScheme.onSurfaceVariant,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: normal * 1.25),
                                  SizedBox(
                                    width: double.infinity,
                                    child: FilledButton.icon(
                                      onPressed: () async {
                                        await _close();
                                        widget.onLoginPressed();
                                      },
                                      icon: const Icon(Icons.login_rounded),
                                      label: Text(
                                        LocaleKeys.general_button_login.tr(),
                                      ),
                                      style: FilledButton.styleFrom(
                                        minimumSize: Size.fromHeight(
                                          context.sized.height * 0.064,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            normal * 1.2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: low * 0.75),
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextButton(
                                      onPressed: () async {
                                        await _close();
                                      },
                                      style: TextButton.styleFrom(
                                        minimumSize: Size.fromHeight(
                                          context.sized.height * 0.058,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            normal * 1.2,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        LocaleKeys.general_button_close.tr(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
