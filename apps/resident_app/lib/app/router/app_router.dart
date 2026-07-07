import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/auth_gate_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/kyc_verification_screen.dart';
import '../../features/auth/presentation/screens/phone_verification_screen.dart';
import '../../features/complaints/presentation/screens/complaint_create_screen.dart';
import '../../features/complaints/presentation/screens/complaint_detail_screen.dart';
import '../../features/complaints/presentation/screens/complaints_list_screen.dart';
import '../../features/enforcement/application/enforcement_report_draft.dart';
import '../../features/enforcement/presentation/screens/enforcement_evidence_review_screen.dart';
import '../../features/enforcement/presentation/screens/enforcement_report_create_screen.dart';
import '../../features/enforcement/presentation/screens/enforcement_report_detail_screen.dart';
import '../../features/enforcement/presentation/screens/enforcement_reports_list_screen.dart';
import '../../features/help/presentation/screens/about_screen.dart';
import '../../features/help/presentation/screens/contact_feedback_screen.dart';
import '../../features/help/presentation/screens/faq_screen.dart';
import '../../features/help/presentation/screens/help_screen.dart';
import '../../features/location/presentation/screens/location_confirm_screen.dart';
import '../../core/models/location_confirm_payload.dart';
import '../../features/notifications/presentation/screens/inbox_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';
import '../../features/petitions/presentation/screens/my_petitions_screen.dart';
import '../../features/petitions/presentation/screens/petition_create_screen.dart';
import '../../features/petitions/presentation/screens/petition_detail_screen.dart';
import '../../features/petitions/presentation/screens/petitions_list_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

final appRouterProvider = Provider<GoRouter>(
  (_) => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthGateScreen(),
      ),
      GoRoute(
        path: '/auth/verify-phone',
        builder: (context, state) => const PhoneVerificationScreen(),
      ),
      GoRoute(
        path: '/auth/kyc',
        builder: (context, state) => const KycVerificationScreen(),
      ),
      GoRoute(
        path: '/petitions',
        builder: (context, state) => const PetitionsListScreen(),
      ),
      GoRoute(
        path: '/petitions/create',
        builder: (context, state) => const PetitionCreateScreen(),
      ),
      GoRoute(
        path: '/petitions/mine',
        builder: (context, state) => const MyPetitionsScreen(),
      ),
      GoRoute(
        path: '/petitions/:petitionId',
        builder: (context, state) => PetitionDetailScreen(
          petitionId: state.pathParameters['petitionId']!,
        ),
      ),
      GoRoute(
        path: '/complaints',
        builder: (context, state) => const ComplaintsListScreen(),
      ),
      GoRoute(
        path: '/complaints/create',
        builder: (context, state) => const ComplaintCreateScreen(),
      ),
      GoRoute(
        path: '/complaints/:complaintId',
        builder: (context, state) => ComplaintDetailScreen(
          complaintId: state.pathParameters['complaintId']!,
        ),
      ),
      GoRoute(
        path: '/enforcement',
        builder: (context, state) => const EnforcementReportsListScreen(),
      ),
      GoRoute(
        path: '/enforcement/create',
        builder: (context, state) => const EnforcementReportCreateScreen(),
      ),
      GoRoute(
        path: '/enforcement/review',
        builder: (context, state) => EnforcementEvidenceReviewScreen(
          draft: state.extra! as EnforcementReportDraft,
        ),
      ),
      GoRoute(
        path: '/enforcement/:reportId',
        builder: (context, state) => EnforcementReportDetailScreen(
          reportId: state.pathParameters['reportId']!,
        ),
      ),
      GoRoute(
        path: '/location/confirm',
        builder: (context, state) => LocationConfirmScreen(
          payload: state.extra! as LocationConfirmPayload,
        ),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/inbox',
        builder: (context, state) => const InboxScreen(),
      ),
      GoRoute(
        path: '/help',
        builder: (context, state) => const HelpScreen(),
      ),
      GoRoute(
        path: '/help/faq',
        builder: (context, state) => const FaqScreen(),
      ),
      GoRoute(
        path: '/help/about',
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: '/help/contact',
        builder: (context, state) => const ContactFeedbackScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
    ],
  ),
);
