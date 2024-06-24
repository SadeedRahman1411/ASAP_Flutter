class ChatUser {
  ChatUser({
    required this.Active,
    required this.Email,
    required this.about,
    required this.name,
  });
  late final bool Active;
  late final String Email;
  late final String about;
  late final String name;

  ChatUser.fromJson(Map<String, dynamic> json){
    Active = json['Active']??'';
    Email = json['Email']??'';
    about = json['about']??'';
    name = json['name']??'';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Active'] = Active;
    data['Email'] = Email;
    data['about'] = about;
    data['name'] = name;
    return data;
  }
}