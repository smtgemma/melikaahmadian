class OfferModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final List<OfferData>? data;

  OfferModel({this.success, this.statusCode, this.message, this.data});

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List? ?? [])
          .map((e) => OfferData.fromJson(e))
          .toList(),
    );
  }
}

class OfferData {
  final String? id;
  final String? postId;
  final String? providerId;
  final int? offerPrice;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? cancellationReason;
  final List<PostMedia>? postMedia;
  final Provider? provider;

  OfferData({
    this.id,
    this.postId,
    this.providerId,
    this.offerPrice,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.cancellationReason,
    this.postMedia,
    this.provider,
  });

  factory OfferData.fromJson(Map<String, dynamic> json) {
    return OfferData(
      id: json['id'] ?? '',
      postId: json['postId'] ?? '',
      providerId: json['providerId'] ?? '',
      offerPrice: json['offerPrice'] ?? 0,
      status: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      cancellationReason: json['cancellationReason'],
      postMedia: (json['postMedia'] as List? ?? [])
          .map((e) => PostMedia.fromJson(e))
          .toList(),
      provider: json['provider'] != null
          ? Provider.fromJson(json['provider'])
          : null,
    );
  }
}

class PostMedia {
  final String? type;
  final String? url;
  final String? key;

  PostMedia({this.type, this.url, this.key});

  factory PostMedia.fromJson(Map<String, dynamic> json) {
    return PostMedia(
      type: json['type'] ?? '',
      url: json['url'] ?? '',
      key: json['key'] ?? '',
    );
  }
}

class Provider {
  final String? id;
  final String? fullName;
  final String? image;
  final List<String>? specialization;
  final double? averageRating;
  final int? totalReview;

  Provider({
    this.id,
    this.fullName,
    this.image,
    this.specialization,
    this.averageRating,
    this.totalReview,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'],
      specialization: (json['specialization'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      totalReview: json['totalReview'] ?? 0,
    );
  }
}
