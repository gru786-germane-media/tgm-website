class ContactUsServicesDropDownModel {
  int? id;
  String? name;

  ContactUsServicesDropDownModel({this.id, this.name});

  ContactUsServicesDropDownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

 
}
