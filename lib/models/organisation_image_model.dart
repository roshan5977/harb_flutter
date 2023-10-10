import 'dart:convert';

class OrganisationImage {
  int orgImgId;
  int orgRefId;
  List<int> orgImage; 

  OrganisationImage({
    this.orgImgId = 0,
    required this.orgRefId,
    required this.orgImage,
  });

  factory OrganisationImage.fromJson(Map<String, dynamic> map) {
    return OrganisationImage(
      orgImgId: map['org_img_id'],
      orgRefId: map['org_ref_id'],
      orgImage: List<int>.from(map['org_image']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'org_img_id': orgImgId,
      'org_ref_id': orgRefId,
      'org_image': orgImage,
    };
  }

  @override
  String toString() {
    return 'OrganisationImage{orgImgId: $orgImgId, orgRefId: $orgRefId, orgImage: $orgImage}';
  }
}

List<OrganisationImage> organisationImagesFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<OrganisationImage>.from(data.map((item) => OrganisationImage.fromJson(item)));
}

String organisationImagesToJson(List<OrganisationImage> data) {
  final jsonData = data.map((image) => image.toJson()).toList();
  return json.encode(jsonData);
}
