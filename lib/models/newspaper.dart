

class NewSpaper{
  String id;
  String image;
  String title;
  String discription;

  NewSpaper({
    this.id='',
    required this.image,
    required this.title,
    required this.discription
  });

  Map<String, dynamic> toJsonNewSpaper() => {
    'id': id,
    'image': image,
    'text': title,
    'discription': discription
  };

  static NewSpaper fromJsonNewSpaper(Map<String, dynamic> json) => 
    NewSpaper(
      id: json['id'], 
      image: json['image'], 
      title: json['text'], 
      discription: json['discription']
    );

}