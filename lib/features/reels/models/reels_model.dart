class ReelsModel {
  List<Data>? data;
  Links? links;
  Meta? meta;
  String? status;
  Null? message;

  ReelsModel({this.data, this.links, this.meta, this.status, this.message});

  ReelsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  bool? isMine;
  int? roomId;
  String? video;
  String? preview;
  String? size;
  String? duration;
  int? likesCount;
  String? likesCountTranslated;
  bool? authLikeStatus;

  Data(
      {this.id,
        this.isMine,
        this.roomId,
        this.video,
        this.preview,
        this.size,
        this.duration,
        this.likesCount,
        this.likesCountTranslated,
        this.authLikeStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isMine = json['is_mine'];
    roomId = json['room_id'];
    video = json['video'];
    preview = json['preview'];
    size = json['size'];
    duration = json['duration'];
    likesCount = json['likes_count'];
    likesCountTranslated = json['likes_count_translated'];
    authLikeStatus = json['auth_like_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_mine'] = this.isMine;
    data['room_id'] = this.roomId;
    data['video'] = this.video;
    data['preview'] = this.preview;
    data['size'] = this.size;
    data['duration'] = this.duration;
    data['likes_count'] = this.likesCount;
    data['likes_count_translated'] = this.likesCountTranslated;
    data['auth_like_status'] = this.authLikeStatus;
    return data;
  }
}

class Links {
  String? first;
  String? last;
  String? prev;
  String? next;
  String? url;
  String? label;
  bool? active;

  Links({this.first, this.last, this.prev, this.next, this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Links>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
        this.from,
        this.lastPage,
        this.links,
        this.path,
        this.perPage,
        this.to,
        this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
