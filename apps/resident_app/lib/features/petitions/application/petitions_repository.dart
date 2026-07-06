import '../../../core/models/petition_attachment.dart';
import 'petition.dart';

abstract class PetitionsRepository {
  Future<List<Petition>> fetchPetitions();
  Future<List<Petition>> fetchMyPetitions();
  Future<Petition?> fetchPetitionById(String id);
  Future<Petition> createPetition({
    required String title,
    required String summary,
    List<PetitionAttachment> attachments = const [],
  });
  Future<Petition> signPetition(String petitionId);
}
