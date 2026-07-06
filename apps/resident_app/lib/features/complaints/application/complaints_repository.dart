import '../../../core/models/media_attachment.dart';
import 'complaint.dart';

abstract class ComplaintsRepository {
  Future<List<Complaint>> fetchComplaints();
  Future<Complaint?> fetchComplaintById(String id);
  Future<Complaint> createComplaint({
    required String title,
    required String description,
    required String locationLabel,
    required bool geoMismatch,
    double? latitude,
    double? longitude,
    required List<MediaAttachment> mediaAttachments,
  });
}
