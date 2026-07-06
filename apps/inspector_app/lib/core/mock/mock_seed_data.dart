import '../../core/models/media_attachment.dart';
import '../../features/triage/application/triage_report.dart';

class MockSeedData {
  static List<TriageReport> triageReports() {
    return const [
      TriageReport(
        id: 'e1',
        title: 'Illegal parking across sidewalk',
        description:
            'A vehicle blocks the sidewalk and prevents pedestrian access.',
        status: 'triage',
        locationLabel: 'Allenby St 8',
        latitude: 32.819,
        longitude: 34.998,
        geoMismatch: false,
        trustLabel: 'standard',
        submittedAtLabel: 'Today',
        mediaAttachments: [
          MediaAttachment(
            path: 'mock://enforcement/e1/photo-1.jpg',
            kind: MediaKind.photo,
          ),
          MediaAttachment(
            path: 'mock://enforcement/e1/video-1.mp4',
            kind: MediaKind.video,
          ),
        ],
      ),
      TriageReport(
        id: 'e2',
        title: 'Possible illegal dumping',
        description: 'Construction debris was left in a public area.',
        status: 'review_required',
        locationLabel: 'Manual address required',
        geoMismatch: true,
        trustLabel: 'low_geo_confidence',
        submittedAtLabel: 'Yesterday',
        mediaAttachments: [
          MediaAttachment(
            path: 'mock://enforcement/e2/photo-1.jpg',
            kind: MediaKind.photo,
          ),
        ],
      ),
      TriageReport(
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
        submittedAtLabel: '2 days ago',
      ),
    ];
  }
}
