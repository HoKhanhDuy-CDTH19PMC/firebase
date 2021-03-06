import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase/Model/vaccination%20.dart';
class Pet {
  // 1
  String name;
  String notes;
  String type;
  // 2
  List<Vaccination> vaccinations = <Vaccination>[];

  var reference;
  // 3
  // DocumentReference reference;
  // 4
  Pet(this.name, {required this.notes, required this.type,required this.vaccinations});
  // 5
  factory Pet.fromSnapshot(DocumentSnapshot snapshot) {
    Pet newPet = Pet.fromJson(snapshot.data);
    // newPet.reference = snapshot.reference;
    return newPet;
  }
  // 6
    

  factory Pet.fromJson(Map<String, dynamic> json) => _PetFromJson(json);
  // 7
  Map<String, dynamic> toJson() => _PetToJson(this);
  @override
  String toString() => "Pet<$name>";
}
// 1
Pet _PetFromJson(Map<String, dynamic> json) {
  return Pet(
    json['name'] as String,
    notes: json['notes'] as String,
    type: json['type'] as String,
    vaccinations: _convertVaccinations(json['vaccinations'] as List)
  );
}
// 2
List<Vaccination> _convertVaccinations(List vaccinationMap) {
  if (vaccinationMap != null) {
    List<Vaccination> vaccinations =  <Vaccination>[];
       vaccinationMap.forEach((value) {
     vaccinations.add(Vaccination.fromJson(value));
   });
  }else{
    return  <Vaccination>[];

  }
  // List<Vaccination> vaccinations =  <Vaccination>[];
  // vaccinationMap.forEach((value) {
  //   vaccinations.add(Vaccination.fromJson(value));
  // });
   List<Vaccination> vaccinations = <Vaccination>[];
  return vaccinations;
}
// 3
Map<String, dynamic> _PetToJson(Pet instance) => <String, dynamic> {
      'name': instance.name,
      'notes': instance.notes,
      'type': instance.type,
      'vaccinations': _VaccinationList(instance.vaccinations),
    };
// 4

Future<List<Map<String, dynamic>>?> _VaccinationList(List<Vaccination> vaccinations) async {
  if (vaccinations == null) {
    return null;
  }
  List<Map<String, dynamic>> vaccinationMap =<Map<String, dynamic>>[];
  vaccinations.forEach((vaccination) {
    vaccinationMap.add(vaccination.toJson());
  });
  return vaccinationMap;
}


