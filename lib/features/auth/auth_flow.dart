import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/ui_components.dart';

enum AppRole { driver, tripAdviser, fuelStockManager, ceo }

extension AppRoleDetails on AppRole {
  String get label => switch (this) {
        AppRole.driver => 'Driver',
        AppRole.tripAdviser => 'Trip Adviser',
        AppRole.fuelStockManager => 'Fuel Stock Manager',
        AppRole.ceo => 'CEO / Owner',
      };

  String get shortLabel => switch (this) {
        AppRole.driver => 'Driver operations',
        AppRole.tripAdviser => 'Trip planning',
        AppRole.fuelStockManager => 'Fuel operations',
        AppRole.ceo => 'Business overview',
      };

  String get description => switch (this) {
        AppRole.driver =>
          'View assigned trips, update delivery status, and request fuel.',
        AppRole.tripAdviser =>
          'Plan trips, assign vehicles and drivers, then monitor progress.',
        AppRole.fuelStockManager =>
          'Approve fuel requests and keep vehicle fuel stock accurate.',
        AppRole.ceo =>
          'Monitor logistics performance, delivery, fuel, and operating costs.',
      };

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

  String get signInLabel => switch (this) {
        AppRole.driver => 'Driver ID',
        AppRole.tripAdviser => 'Work email',
        AppRole.fuelStockManager => 'Employee ID',
        AppRole.ceo => 'Work email',
      };

  String get demoAccount => switch (this) {
        AppRole.driver => 'DR-001',
        AppRole.tripAdviser => 'sokha@n1logistic.com',
        AppRole.fuelStockManager => 'FSM-008',
        AppRole.ceo => 'owner@n1logistic.com',
      };
}

enum _AuthStage { welcome, role, onboarding, login }

class AuthFlow extends StatefulWidget {
  const AuthFlow({super.key, required this.onAuthenticated});
  final ValueChanged<AppRole> onAuthenticated;

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
  const WelcomeScreen({super.key, required this.onContinue});
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) => Scaffold(
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
                          const Text(
                            'Logistics that\nmove with confidence.',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                height: 1.12,
                                fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          const Text(
                            'One operational workspace for your fleet, fuel, trips, and delivery performance.',
                            style: TextStyle(
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
                              label: const Text('Open N1 Logistic',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w800)),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          const Center(
                              child: Text('Operations made simple',
                                  style: TextStyle(
                                      color: Color(0xFFAEC3D8), fontSize: 12))),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
}

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen(
      {super.key, required this.onBack, required this.onSelect});
  final VoidCallback onBack;
  final ValueChanged<AppRole> onSelect;

  @override
  Widget build(BuildContext context) => Scaffold(
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
                            const SliverToBoxAdapter(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Select your role',
                                      style: TextStyle(
                                          fontSize: 29,
                                          fontWeight: FontWeight.w900)),
                                  SizedBox(height: 8),
                                  Text(
                                      'Your workspace is tailored to the work you do.',
                                      style: TextStyle(color: AppColors.muted)),
                                  SizedBox(height: 24),
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
                            const SliverToBoxAdapter(
                              child: Center(
                                child: Text(
                                    'You can switch roles from the dashboard later.',
                                    style: TextStyle(
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
    final pages = [
      _OnboardingPage(
        role: widget.role,
        icon: widget.role.icon,
        eyebrow: 'YOUR WORKSPACE',
        title: 'Built for ${widget.role.label}.',
        body: widget.role.description,
      ),
      _OnboardingPage(
        role: widget.role,
        icon: Icons.account_tree_outlined,
        eyebrow: 'ONE CLEAR FLOW',
        title: _flowTitle(widget.role),
        body: _flowBody(widget.role),
      ),
      _OnboardingPage(
        role: widget.role,
        icon: Icons.verified_user_outlined,
        eyebrow: 'READY WHEN YOU ARE',
        title: 'Stay in control, anywhere.',
        body:
            'Important updates, clear next steps, and practical information are always within reach.',
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
                      'Your workspace will open automatically',
                      style: TextStyle(color: AppColors.muted, fontSize: 12),
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
  Widget build(BuildContext context) => Scaffold(
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
                  Text('Welcome back',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 7),
                  Text('Sign in to your ${widget.role.label} workspace.',
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
                          child: Text('Signing in as ${widget.role.label}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800))),
                      TextButton(
                          onPressed: widget.onChangeRole,
                          child: const Text('Change'))
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
                              labelText: widget.role.signInLabel,
                              prefixIcon: const Icon(Icons.person_outline)),
                          validator: (value) => value == null ||
                                  value.trim().isEmpty
                              ? 'Enter your ${widget.role.signInLabel.toLowerCase()}'
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
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                  onPressed: () => setState(
                                      () => hidePassword = !hidePassword),
                                  tooltip: hidePassword
                                      ? 'Show password'
                                      : 'Hide password',
                                  icon: Icon(hidePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined))),
                          validator: (value) =>
                              value == null || value.length < 4
                                  ? 'Enter a valid password'
                                  : null,
                        ),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    'Please contact N1 Logistic support to reset your password.'),
                              )),
                          child: const Text('Forgot password?'))),
                  const SizedBox(height: 16),
                  PrimaryButton(
                      label: 'Sign in',
                      icon: Icons.login,
                      isLoading: isLoading,
                      onPressed: _submit),
                  const SizedBox(height: 18),
                  const Center(
                      child: Text('Demo access · No account creation required',
                          style:
                              TextStyle(color: AppColors.muted, fontSize: 12))),
                ],
              ),
            ),
          ),
        ),
      );
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
    final role = widget.role;
    final active = hovered || focused;
    final neutralBorder = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF2C3A50)
        : const Color(0xFFE2E8F0);
    return Semantics(
      button: true,
      label: 'Continue as ${role.label}',
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
                          Text(role.label,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w900)),
                          const SizedBox(height: 5),
                          Text(role.description,
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
          Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
              color: light ? Colors.white : AppColors.navy,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              child: Text(
                'N1',
                style: TextStyle(
                  color: light ? AppColors.navy : Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'N1 LOGISTIC',
            style: TextStyle(
              color: light ? Colors.white : AppColors.navy,
              letterSpacing: 1.3,
              fontWeight: FontWeight.w900,
            ),
          ),
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

String _flowTitle(AppRole role) => switch (role) {
      AppRole.driver => 'From assigned trip to proof of delivery.',
      AppRole.tripAdviser => 'Create, assign, and monitor every trip.',
      AppRole.fuelStockManager => 'Approve fuel with live stock visibility.',
      AppRole.ceo => 'See the business, not just the numbers.',
    };

String _flowBody(AppRole role) => switch (role) {
      AppRole.driver =>
        'See the next action immediately: start, navigate, load, deliver, and complete.',
      AppRole.tripAdviser =>
        'Set the vehicle, driver, pickup, delivery, material, and quantity in one clear workflow.',
      AppRole.fuelStockManager =>
        'Receive a request, approve or reject it, then record the fuel issued.',
      AppRole.ceo =>
        'Review delivery, active fleet, fuel usage, cost, and driver performance from one dashboard.',
    };
