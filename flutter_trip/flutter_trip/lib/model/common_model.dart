//String icon	String	Nullable
//String title	String	Nullable
//String url	String	NonNull
//String statusBarColor	String	Nullable
//bool hideAppBar	bool	Nullable

class CommonModel{
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel({this.title, this.url, this.statusBarColor, this.hideAppBar,this.icon});

  factory CommonModel.fromJson(Map<String,dynamic> json){
    return CommonModel(
        icon: json['icon'],
        title:json['title'],
        url:json['url'],
        statusBarColor:json['statusBarColor'],
        hideAppBar: json['hideAppBar'],
    );
  }
}