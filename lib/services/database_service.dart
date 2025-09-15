import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add Volunteer
  Future<void> addVolunteer(Map<String, dynamic> volunteerData) async {
    await _db.collection('volunteers').add(volunteerData);
  }

  // Add Sponsor
  Future<void> addSponsor(Map<String, dynamic> sponsorData) async {
    await _db.collection('sponsors').add(sponsorData);
  }

  // Add Disaster
  Future<void> addDisaster(Map<String, dynamic> disasterData) async {
    await _db.collection('disasters').add(disasterData);
  }

  // Get Volunteers
  Stream<QuerySnapshot> getVolunteers() {
    return _db.collection('volunteers').snapshots();
  }

  // Get Sponsors
  Stream<QuerySnapshot> getSponsors() {
    return _db.collection('sponsors').snapshots();
  }

  // Get Disasters
  Stream<QuerySnapshot> getDisasters() {
    return _db.collection('disasters').snapshots();
  }

  // Assign Volunteer to Disaster (simple update)
  Future<void> assignVolunteer(String volunteerId, String disasterId) async {
    await _db.collection('volunteers').doc(volunteerId).update({
      'assignedDisaster': disasterId,
    });
  }

  // Assign Sponsor to Disaster
  Future<void> assignSponsor(String sponsorId, String disasterId) async {
    await _db.collection('sponsors').doc(sponsorId).update({
      'assignedDisaster': disasterId,
    });
  }
}
