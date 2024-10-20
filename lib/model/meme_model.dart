//Model class take json data as input in class member to create list of a object

class MemeModel {
  bool? _success;
  Data? _data;

  MemeModel({bool? success, Data? data}) {
    if (success != null) {
      this._success = success;
    }
    if (data != null) {
      this._data = data;
    }
  }

  bool? get success => _success;
  set success(bool? success) => _success = success;
  Data? get data => _data;
  set data(Data? data) => _data = data;

  MemeModel.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Memes>? _memes;

  Data({List<Memes>? memes}) {
    if (memes != null) {
      this._memes = memes;
    }
  }

  List<Memes>? get memes => _memes;
  set memes(List<Memes>? memes) => _memes = memes;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['memes'] != null) {
      _memes = <Memes>[];
      json['memes'].forEach((v) {
        _memes!.add(new Memes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._memes != null) {
      data['memes'] = this._memes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Memes {
  String? _id;
  String? _name;
  String? _url;
  int? _width;
  int? _height;
  int? _boxCount;
  int? _captions;

  Memes(
      {String? id,
      String? name,
      String? url,
      int? width,
      int? height,
      int? boxCount,
      int? captions}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (url != null) {
      this._url = url;
    }
    if (width != null) {
      this._width = width;
    }
    if (height != null) {
      this._height = height;
    }
    if (boxCount != null) {
      this._boxCount = boxCount;
    }
    if (captions != null) {
      this._captions = captions;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get url => _url;
  set url(String? url) => _url = url;
  int? get width => _width;
  set width(int? width) => _width = width;
  int? get height => _height;
  set height(int? height) => _height = height;
  int? get boxCount => _boxCount;
  set boxCount(int? boxCount) => _boxCount = boxCount;
  int? get captions => _captions;
  set captions(int? captions) => _captions = captions;

  Memes.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _url = json['url'];
    _width = json['width'];
    _height = json['height'];
    _boxCount = json['box_count'];
    _captions = json['captions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['url'] = this._url;
    data['width'] = this._width;
    data['height'] = this._height;
    data['box_count'] = this._boxCount;
    data['captions'] = this._captions;
    return data;
  }
}
