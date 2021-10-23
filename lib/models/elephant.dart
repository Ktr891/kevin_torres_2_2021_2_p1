class Elephant {
  String sId = '';
  int? index = 0;
  String? name = '';
  String? affiliation = '';
  String? species = '';
  String? sex = '';
  String? fictional = '';
  String? dob = '';
  String? dod = '';
  String? wikilink = '';
  String? image = '';
  String? note = '';

  Elephant(
      {required this.sId,
      required this.index,
      required this.name,
      required this.affiliation,
      required this.species,
      required this.sex,
      required this.fictional,
      required this.dob,
      required this.dod,
      required this.wikilink,
      required this.image,
      required this.note});

  Elephant.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    index = json['index'];
    name = json['name'];
    affiliation = json['affiliation'];
    species = json['species'];
    sex = json['sex'];
    fictional = json['fictional'];
    dob = json['dob'];
    dod = json['dod'];
    wikilink = json['wikilink'];
    image = json['image'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['index'] = this.index;
    data['name'] = this.name;
    data['affiliation'] = this.affiliation;
    data['species'] = this.species;
    data['sex'] = this.sex;
    data['fictional'] = this.fictional;
    data['dob'] = this.dob;
    data['dod'] = this.dod;
    data['wikilink'] = this.wikilink;
    data['image'] = this.image;
    data['note'] = this.note;
    return data;
  }
}
