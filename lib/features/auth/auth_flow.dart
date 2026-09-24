import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/language_picker.dart';
import '../../shared/widgets/ui_components.dart';

enum AppRole { driver, tripAdviser, fuelStockManager, ceo }

extension AppRoleDetails on AppRole {
  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      AppRole.driver => l10n.roleDriver,
      AppRole.tripAdviser => l10n.roleTripAdviser,
      AppRole.fuelStockManager => l10n.roleFuelStockManager,
      AppRole.ceo => l10n.roleCeo,
    };
  }

  String shortLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      AppRole.driver => l10n.roleDriverShort,
      AppRole.tripAdviser => l10n.roleTripAdviserShort,
      AppRole.fuelStockManager => l10n.roleFuelStockManagerShort,
      AppRole.ceo => l10n.roleCeoShort,
    };
  }

  String description(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      AppRole.driver => l10n.roleDriverDesc,
      AppRole.tripAdviser => l10n.roleTripAdviserDesc,
      AppRole.fuelStockManager => l10n.roleFuelStockManagerDesc,
      AppRole.ceo => l10n.roleCeoDesc,
    };
  }

  IconData get icon => switch (this) {
        AppRole.driver => Icons.local_shipping_outlined,
        AppRole.tripAdviser => Icons.route_outlined,
        AppRole.fuelStockManager => Icons.local_gas_station_outlined,
        AppRole.ceo => Icons.insights_outlined,
      };

  Color get color => switch (this) {
        AppRole.driver => AppColors.blue,
        AppRole.tripAdviser => const Color(0xFF7557D9),
        AppRole.fuelStockManager => AppColors.warning,
        AppRole.ceo => AppColors.success,
      };

  Color get foregroundColor => switch (this) {
        AppRole.driver => const Color(0xFF125AA8),
        AppRole.tripAdviser => const Color(0xFF5B3EBB),
        AppRole.fuelStockManager => const Color(0xFF9A5A00),
        AppRole.ceo => const Color(0xFF087546),
      };

  String signInLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      AppRole.driver => l10n.roleDriverSignIn,
      AppRole.tripAdviser => l10n.roleTripAdviserSignIn,
      AppRole.fuelStockManager => l10n.roleFuelStockManagerSignIn,
      AppRole.ceo => l10n.roleCeoSignIn,
    };
  }

  String get demoAccount => switch (this) {
        AppRole.driver => 'DR-001',
        AppRole.tripAdviser => 'sokha@n1logistic.com',
        AppRole.fuelStockManager => 'FSM-008',
        AppRole.ceo => 'owner@n1logistic.com',
      };
}

enum _AuthStage { welcome, role, onboarding, login }

class AuthFlow extends StatefulWidget {
  const AuthFlow({
    super.key,
    required this.onAuthenticated,
    required this.locale,
    required this.onLocaleChanged,
  });
  final ValueChanged<AppRole> onAuthenticated;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<AuthFlow> createState() => _AuthFlowState();
}

class _AuthFlowState extends State<AuthFlow> {
  _AuthStage stage = _AuthStage.welcome;
  AppRole? selectedRole;

  void _selectRole(AppRole role) => setState(() {
        selectedRole = role;
        stage = _AuthStage.onboarding;
      });

  void _backToRoles() => setState(() => stage = _AuthStage.role);

  void _backToOnboarding() => setState(() => stage = _AuthStage.onboarding);

  @override
  Widget build(BuildContext context) {
    final child = switch (stage) {
      _AuthStage.welcome => WelcomeScreen(
          onContinue: () => setState(() => stage = _AuthStage.role),
          locale: widget.locale,
          onLocaleChanged: widget.onLocaleChanged,
        ),
      _AuthStage.role => RoleSelectionScreen(
          onBack: () => setState(() => stage = _AuthStage.welcome),
          onSelect: _selectRole,
        ),
      _AuthStage.onboarding => OnboardingScreen(
          role: selectedRole!,
          onBack: _backToRoles,
          onContinue: () => setState(() => stage = _AuthStage.login),
        ),
      _AuthStage.login => LoginScreen(
          role: selectedRole!,
          onBack: _backToOnboarding,
          onChangeRole: _backToRoles,
          onLogin: widget.onAuthenticated,
        ),
    };
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 340),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: KeyedSubtree(key: ValueKey(stage), child: child),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
    required this.onContinue,
    required this.locale,
    required this.onLocaleChanged,
  });
  final VoidCallback onContinue;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        body: Stack(
          children: [
            const _WelcomeBackdrop(),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxHeight < 700;
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: ListView(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        children: [
                          const _BrandMark(light: true),
                          SizedBox(height: compact ? 34 : 76),
                          const ExcludeSemantics(child: _WelcomeIllustration()),
                          SizedBox(
                              height: compact ? AppSpacing.xl : AppSpacing.xxl),
                          Text(
                            l10n.welcomeHeadline,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                height: 1.12,
                                fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            l10n.welcomeSubtitle,
                            style: const TextStyle(
                                color: Color(0xFFC8D8E9), height: 1.45),
                          ),
                          const SizedBox(height: AppSpacing.xxl),
                          SizedBox(
                            height: 54,
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: onContinue,
                              style: FilledButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppColors.navy,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              icon: const Icon(Icons.arrow_forward),
                              label: Text(l10n.openApp,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800)),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Center(
                              child: Text(l10n.operationsMadeSimple,
                                  style: const TextStyle(
                                      color: Color(0xFFAEC3D8), fontSize: 12))),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 14, 16, 0),
                  child: LanguageToggleButton(
                    locale: locale,
                    onLocaleChanged: onLocaleChanged,
                    light: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen(
      {super.key, required this.onBack, required this.onSelect});
  final VoidCallback onBack;
  final ValueChanged<AppRole> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: onBack),
          title: const _BrandMark(),
        ),
        body: SafeArea(
          top: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 620 ? 2 : 1;
                  return CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                        sliver: SliverMainAxisGroup(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(l10n.selectRoleTitle,
                                      style: const TextStyle(
                                          fontSize: 29,
                                          fontWeight: FontWeight.w900)),
                                  const SizedBox(height: 8),
                                  Text(l10n.selectRoleSubtitle,
                                      style: const TextStyle(
                                          color: AppColors.muted)),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                            SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => _RoleCard(
                                    role: AppRole.values[index],
                                    onTap: () =>
                                        onSelect(AppRole.values[index])),
                                childCount: AppRole.values.length,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columns,
                                mainAxisExtent: 120 +
                                    (MediaQuery.textScalerOf(context)
                                                .scale(17) -
                                            17) *
                                        4,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 14,
                              ),
                            ),
                            const SliverToBoxAdapter(
                                child: SizedBox(height: 12)),
                            SliverToBoxAdapter(
                              child: Center(
                                child: Text(l10n.selectRoleFooter,
                                    style: const TextStyle(
                                        color: AppColors.muted, fontSize: 12)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen(
      {super.key,
      required this.role,
      required this.onBack,
      required this.onContinue});
  final AppRole role;
  final VoidCallback onBack, onContinue;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  Timer? _advanceTimer;
  var page = 0;

  static const _slideDuration = Duration(milliseconds: 800);

  @override
  void initState() {
    super.initState();
    _scheduleAdvance();
  }

  @override
  void dispose() {
    _advanceTimer?.cancel();
    controller.dispose();
    super.dispose();
  }

  void _scheduleAdvance() {
    _advanceTimer?.cancel();
    _advanceTimer = Timer(_slideDuration, () {
      if (!mounted) return;

      if (page == 2) {
        widget.onContinue();
        return;
      }

      controller.nextPage(
        duration: const Duration(milliseconds: 520),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _goBack() {
    if (page == 0) {
      widget.onBack();
      return;
    }
    controller.previousPage(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pages = [
      _OnboardingPage(
        role: widget.role,
        icon: widget.role.icon,
        eyebrow: l10n.onboardingWorkspaceEyebrow,
        title: l10n.onboardingBuiltFor(widget.role.label(context)),
        body: widget.role.description(context),
      ),
      _OnboardingPage(
        role: widget.role,
        icon: Icons.account_tree_outlined,
        eyebrow: l10n.onboardingFlowEyebrow,
        title: _flowTitle(context, widget.role),
        body: _flowBody(context, widget.role),
      ),
      _OnboardingPage(
        role: widget.role,
        icon: Icons.verified_user_outlined,
        eyebrow: l10n.onboardingReadyEyebrow,
        title: l10n.onboardingReadyTitle,
        body: l10n.onboardingReadyBody,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: _goBack),
        title: const _BrandMark(),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: controller,
                      itemCount: pages.length,
                      onPageChanged: (value) {
                        HapticFeedback.selectionClick();
                        setState(() => page = value);
                        _scheduleAdvance();
                      },
                      itemBuilder: (context, index) => pages[index],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Semantics(
                    liveRegion: true,
                    child: Text(
                      l10n.onboardingAutoAdvance,
                      style: const TextStyle(
                          color: AppColors.muted, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen(
      {super.key,
      required this.role,
      required this.onBack,
      required this.onChangeRole,
      required this.onLogin});
  final AppRole role;
  final VoidCallback onBack, onChangeRole;
  final ValueChanged<AppRole> onLogin;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  var hidePassword = true;
  var isLoading = false;

  bool get _usesEmail =>
      widget.role == AppRole.tripAdviser || widget.role == AppRole.ceo;

  Future<void> _submit() async {
    if (isLoading || !formKey.currentState!.validate()) return;
    HapticFeedback.mediumImpact();
    setState(() => isLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 550));
    if (mounted) widget.onLogin(widget.role);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: widget.onBack),
          title: const _BrandMark(),
        ),
        body: SafeArea(
          top: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
                children: [
                  _RoleIcon(role: widget.role, size: 58),
                  const SizedBox(height: 24),
                  Text(l10n.welcomeBack,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 7),
                  Text(
                      l10n.signInToWorkspace(widget.role.label(context)),
                      style: const TextStyle(color: AppColors.muted)),
                  const SizedBox(height: 28),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: widget.role.color.withValues(alpha: .08),
                        borderRadius: BorderRadius.circular(14)),
                    child: Row(children: [
                      Icon(widget.role.icon,
                          color: widget.role.foregroundColor),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Text(
                              l10n.signingInAs(widget.role.label(context)),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800))),
                      TextButton(
                          onPressed: widget.onChangeRole,
                          child: Text(l10n.change))
                    ]),
                  ),
                  const SizedBox(height: 22),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: widget.role.demoAccount,
                          keyboardType: _usesEmail
                              ? TextInputType.emailAddress
                              : TextInputType.text,
                          textInputAction: TextInputAction.next,
                          autofillHints: _usesEmail
                              ? const [AutofillHints.email]
                              : const [AutofillHints.username],
                          decoration: InputDecoration(
                              labelText: widget.role.signInLabel(context),
                              prefixIcon: const Icon(Icons.person_outline)),
                          validator: (value) => value == null ||
                                  value.trim().isEmpty
                              ? l10n.enterYourField(
                                  widget.role.signInLabel(context).toLowerCase())
                              : null,
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          initialValue: 'n1demo',
                          obscureText: hidePassword,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.password],
                          onFieldSubmitted: (_) => _submit(),
                          decoration: InputDecoration(
                              labelText: l10n.password,
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                  onPressed: () => setState(
                                      () => hidePassword = !hidePassword),
                                  tooltip: hidePassword
                                      ? l10n.showPassword
                                      : l10n.hidePassword,
                                  icon: Icon(hidePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined))),
                          validator: (value) =>
                              value == null || value.length < 4
                                  ? l10n.enterValidPassword
                                  : null,
                        ),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(l10n.forgotPasswordMessage),
                              )),
                          child: Text(l10n.forgotPassword))),
                  const SizedBox(height: 16),
                  PrimaryButton(
                      label: l10n.signIn,
                      icon: Icons.login,
                      isLoading: isLoading,
                      onPressed: _submit),
                  const SizedBox(height: 18),
                  Center(
                      child: Text(l10n.demoAccessNote,
                          style: const TextStyle(
                              color: AppColors.muted, fontSize: 12))),
                ],
              ),
            ),
          ),
        ),
      );
  }
}

class _RoleCard extends StatefulWidget {
  const _RoleCard({required this.role, required this.onTap});
  final AppRole role;
  final VoidCallback onTap;

  @override
  State<_RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<_RoleCard> {
  var hovered = false;
  var focused = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final role = widget.role;
    final active = hovered || focused;
    final neutralBorder = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF2C3A50)
        : const Color(0xFFE2E8F0);
    return Semantics(
      button: true,
      label: l10n.continueAsRole(role.label(context)),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => hovered = true),
        onExit: (_) => setState(() => hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: active
                ? role.color.withValues(alpha: .06)
                : Theme.of(context).colorScheme.surface,
            border: Border.all(
              color: active
                  ? role.foregroundColor.withValues(alpha: .62)
                  : neutralBorder,
              width: active ? 1.4 : 1,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: active
                ? [
                    BoxShadow(
                        color: role.color.withValues(alpha: .12),
                        blurRadius: 18,
                        offset: const Offset(0, 7))
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              onHover: (value) => setState(() => hovered = value),
              onFocusChange: (value) => setState(() => focused = value),
              borderRadius: BorderRadius.circular(18),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    _RoleIcon(role: role),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(role.label(context),
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w900)),
                          const SizedBox(height: 5),
                          Text(role.description(context),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 12,
                                  height: 1.35)),
                        ],
                      ),
                    ),
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                          color: role.color.withValues(alpha: .12),
                          shape: BoxShape.circle),
                      child: Icon(Icons.arrow_forward_rounded,
                          size: 18, color: role.foregroundColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleIcon extends StatelessWidget {
  const _RoleIcon({required this.role, this.size = 48});
  final AppRole role;
  final double size;
  @override
  Widget build(BuildContext context) => Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: role.color.withValues(alpha: .13),
          borderRadius: BorderRadius.circular(size * .28)),
      child: Icon(role.icon, color: role.color, size: size * .48));
}

class _BrandMark extends StatelessWidget {
  const _BrandMark({this.light = false});
  final bool light;
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Image.asset(
            'assets/images_Logo/N1 logo.png',
            width: 44,
            height: 44,
            fit: BoxFit.contain,
            excludeFromSemantics: true,
          ),
          const SizedBox(width: 10),
          Flexible(
              child: Text(
            'N1 TRANSPORTATION',
            style: TextStyle(
              color: light ? Colors.white : AppColors.navy,
              fontSize: 14,
              letterSpacing: .6,
              fontWeight: FontWeight.w900,
            ),
          )),
        ],
      );
}

class _WelcomeBackdrop extends StatelessWidget {
  const _WelcomeBackdrop();
  @override
  Widget build(BuildContext context) => ColoredBox(
      color: AppColors.navy,
      child: Stack(children: [
        Positioned(
            top: -80,
            right: -100,
            child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                    color: Color(0xFF235B9A), shape: BoxShape.circle))),
        Positioned(
            bottom: 150,
            left: -130,
            child: Container(
                width: 290,
                height: 290,
                decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: .12),
                    shape: BoxShape.circle)))
      ]));
}

class _WelcomeIllustration extends StatelessWidget {
  const _WelcomeIllustration();
  @override
  Widget build(BuildContext context) => Container(
        height: 190,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .1),
          border: Border.all(color: Colors.white.withValues(alpha: .15)),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 34,
              right: 34,
              top: 92,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const Positioned(
              left: 28,
              top: 51,
              child:
                  Icon(Icons.factory_outlined, color: Colors.white, size: 46),
            ),
            const Positioned(
              right: 28,
              top: 47,
              child:
                  Icon(Icons.location_on, color: Color(0xFFFFB24A), size: 50),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 23,
              child: Icon(Icons.local_shipping, color: Colors.white, size: 55),
            ),
          ],
        ),
      );
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage(
      {required this.role,
      required this.icon,
      required this.eyebrow,
      required this.title,
      required this.body});
  final AppRole role;
  final IconData icon;
  final String eyebrow, title, body;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: role.color.withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Icon(icon, color: role.color, size: 58),
                    ),
                    const SizedBox(height: 42),
                    Text(eyebrow,
                        style: TextStyle(
                            color: role.foregroundColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.1)),
                    const SizedBox(height: 12),
                    Text(title,
                        style: const TextStyle(
                            fontSize: 30,
                            height: 1.14,
                            fontWeight: FontWeight.w900)),
                    const SizedBox(height: 14),
                    Text(body,
                        style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 16,
                            height: 1.48)),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

String _flowTitle(BuildContext context, AppRole role) {
  final l10n = AppLocalizations.of(context)!;
  return switch (role) {
    AppRole.driver => l10n.flowTitleDriver,
    AppRole.tripAdviser => l10n.flowTitleTripAdviser,
    AppRole.fuelStockManager => l10n.flowTitleFuelStockManager,
    AppRole.ceo => l10n.flowTitleCeo,
  };
}

String _flowBody(BuildContext context, AppRole role) {
  final l10n = AppLocalizations.of(context)!;
  return switch (role) {
    AppRole.driver => l10n.flowBodyDriver,
    AppRole.tripAdviser => l10n.flowBodyTripAdviser,
    AppRole.fuelStockManager => l10n.flowBodyFuelStockManager,
    AppRole.ceo => l10n.flowBodyCeo,
  };
}
