class ReviewModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final Meta? meta;
  final List<ReviewData>? data;

  ReviewModel({
     this.success,
     this.statusCode,
     this.message,
     this.meta,
     this.data,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      meta: Meta.fromJson(json['meta'] ?? {}),
      data: (json['data'] as List? ?? [])
          .map((e) => ReviewData.fromJson(e))
          .toList(),
    );
  }
}

// ------------------------------------------------------

class Meta {
  final int total;
  final int page;
  final int limit;
  final int totalPage;

  Meta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 25,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}

// ------------------------------------------------------

class ReviewData {
  final String id;
  final String reviewerId;
  final String revieweeId;
  final String postId;
  final double rating;
  final String comment;
  final String createdAt;
  final String updatedAt;
  final Reviewer reviewer;

  ReviewData({
    required this.id,
    required this.reviewerId,
    required this.revieweeId,
    required this.postId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.reviewer,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      id: json['id'] ?? '',
      reviewerId: json['reviewerId'] ?? '',
      revieweeId: json['revieweeId'] ?? '',
      postId: json['postId'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      comment: json['comment'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      reviewer: Reviewer.fromJson(json['reviewer'] ?? {}),
    );
  }
}

// ------------------------------------------------------

class Reviewer {
  final String id;
  final String fullName;
  final String image;

  Reviewer({
    required this.id,
    required this.fullName,
    required this.image,
  });

  factory Reviewer.fromJson(Map<String, dynamic> json) {
    return Reviewer(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
