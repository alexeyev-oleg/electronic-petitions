import '../../features/complaints/application/complaint.dart';
import '../../features/enforcement/application/enforcement_report.dart';
import '../../features/notifications/application/app_notification.dart';
import '../../features/petitions/application/petition.dart';
import '../models/petition_attachment.dart';

class MockSeedData {
  static List<Complaint> complaints() {
    return const [
      Complaint(
        id: 'c1',
        title: 'Broken streetlight',
        description: 'The streetlight near the corner is not working at night.',
        status: 'triage',
        locationLabel: 'Herzl St 12',
        latitude: 32.794,
        longitude: 34.989,
      ),
      Complaint(
        id: 'c2',
        title: 'Overflowing public trash bin',
        description: 'The trash bin in the park is overflowing and needs service.',
        status: 'in_progress',
        locationLabel: 'Central Park entrance',
        latitude: 32.812,
        longitude: 34.998,
      ),
    ];
  }

  static List<EnforcementReport> enforcementReports() {
    return const [
      EnforcementReport(
        id: 'e1',
        title: 'Illegal parking across sidewalk',
        description: 'A vehicle blocks the sidewalk and prevents pedestrian access.',
        status: 'triage',
        locationLabel: 'Allenby St 8',
        latitude: 32.819,
        longitude: 34.998,
        geoMismatch: false,
        trustLabel: 'standard',
      ),
      EnforcementReport(
        id: 'e2',
        title: 'Possible illegal dumping',
        description: 'Construction debris was left in a public area.',
        status: 'review_required',
        locationLabel: 'Manual address required',
        geoMismatch: true,
        trustLabel: 'low_geo_confidence',
      ),
      EnforcementReport(
        id: 'e3',
        title: 'Blocked fire lane',
        description:
            'Delivery truck parked in a marked fire lane near a school entrance.',
        status: 'triage',
        locationLabel: 'Ha-Neviim St 44',
        latitude: 32.821,
        longitude: 34.995,
        geoMismatch: false,
        trustLabel: 'standard',
      ),
    ];
  }

  static List<Petition> petitions() {
    return const [
      Petition(
        id: 'p1',
        title: 'Improve neighborhood park lighting',
        summary: 'Residents request improved lighting and safer evening access.',
        status: 'published',
        signatureCount: 128,
        isOwnedByCurrentUser: false,
        attachments: [
          PetitionAttachment(
            path: 'mock://petitions/p1/site-photo.jpg',
            kind: PetitionAttachmentKind.photo,
            displayName: 'site-photo.jpg',
          ),
        ],
      ),
      Petition(
        id: 'p2',
        title: 'Add shaded bus stops',
        summary: 'Install shaded waiting areas at major public transit stops.',
        status: 'moderation_review',
        signatureCount: 12,
        isOwnedByCurrentUser: true,
        attachments: [
          PetitionAttachment(
            path: 'mock://petitions/p2/stop-layout.jpg',
            kind: PetitionAttachmentKind.photo,
            displayName: 'stop-layout.jpg',
          ),
          PetitionAttachment(
            path: 'mock://petitions/p2/cost-estimate.pdf',
            kind: PetitionAttachmentKind.pdf,
            displayName: 'cost-estimate.pdf',
          ),
          PetitionAttachment(
            path: 'mock://petitions/p2/community-letter.docx',
            kind: PetitionAttachmentKind.doc,
            displayName: 'community-letter.docx',
          ),
        ],
      ),
      Petition(
        id: 'p3',
        title: 'Repair coastal promenade tiles',
        summary: 'Replace damaged tiles and improve accessibility along the promenade.',
        status: 'published',
        signatureCount: 64,
        isOwnedByCurrentUser: false,
      ),
    ];
  }

  static List<AppNotification> notifications() {
    return const [
      AppNotification(
        id: 'n1',
        title: 'Petition update',
        body: 'A petition you follow has moved to official review.',
        createdAtLabel: 'Today',
        isRead: false,
      ),
      AppNotification(
        id: 'n2',
        title: 'Complaint status changed',
        body: 'Your complaint is now in progress.',
        createdAtLabel: 'Yesterday',
        isRead: true,
      ),
      AppNotification(
        id: 'n3',
        title: 'Violation report received',
        body: 'Your report was accepted for municipal review.',
        createdAtLabel: '2 days ago',
        isRead: false,
      ),
    ];
  }
}
