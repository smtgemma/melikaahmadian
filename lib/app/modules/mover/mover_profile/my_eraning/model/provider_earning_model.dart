// ================= ROOT RESPONSE =================

class ProviderEarningsResponse {
  final bool? success;
  final int? statusCode;
  final String? message;
  final ProviderEarningsData? data;

  ProviderEarningsResponse({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory ProviderEarningsResponse.fromJson(Map<String, dynamic> json) {
    return ProviderEarningsResponse(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: json["data"] != null
          ? ProviderEarningsData.fromJson(json["data"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "statusCode": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

// ================= DATA =================

class ProviderEarningsData {
  final MonthlyEarnings? monthlyEarnings;
  final List<CompletedMove>? completedMoves;
  final Meta? meta;

  ProviderEarningsData({
    this.monthlyEarnings,
    this.completedMoves,
    this.meta,
  });

  factory ProviderEarningsData.fromJson(Map<String, dynamic> json) {
    return ProviderEarningsData(
      monthlyEarnings: json["monthlyEarnings"] != null
          ? MonthlyEarnings.fromJson(json["monthlyEarnings"])
          : null,
      completedMoves: json["completedMoves"] != null
          ? List<CompletedMove>.from(
        json["completedMoves"].map((x) => CompletedMove.fromJson(x)),
      )
          : [],
      meta: json["meta"] != null ? Meta.fromJson(json["meta"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "monthlyEarnings": monthlyEarnings?.toJson(),
    "completedMoves":
    completedMoves?.map((x) => x.toJson()).toList(),
    "meta": meta?.toJson(),
  };
}

// ================= MONTHLY EARNINGS =================

class MonthlyEarnings {
  final int? month;
  final int? year;
  final String? monthName;
  final int? totalCompleted;
  final int? companyCommission;
  final int? netTotal;

  MonthlyEarnings({
    this.month,
    this.year,
    this.monthName,
    this.totalCompleted,
    this.companyCommission,
    this.netTotal,
  });

  factory MonthlyEarnings.fromJson(Map<String, dynamic> json) {
    return MonthlyEarnings(
      month: json["month"],
      year: json["year"],
      monthName: json["monthName"],
      totalCompleted: json["totalCompleted"],
      companyCommission: json["companyCommission"],
      netTotal: json["netTotal"],
    );
  }

  Map<String, dynamic> toJson() => {
    "month": month,
    "year": year,
    "monthName": monthName,
    "totalCompleted": totalCompleted,
    "companyCommission": companyCommission,
    "netTotal": netTotal,
  };
}

// ================= COMPLETED MOVE =================

class CompletedMove {
  final String? id;
  final String? postId;
  final String? offerId;
  final int? amount;
  final DateTime? completedAt;
  final Post? post;

  CompletedMove({
    this.id,
    this.postId,
    this.offerId,
    this.amount,
    this.completedAt,
    this.post,
  });

  factory CompletedMove.fromJson(Map<String, dynamic> json) {
    return CompletedMove(
      id: json["id"],
      postId: json["postId"],
      offerId: json["offerId"],
      amount: json["amount"],
      completedAt: json["completedAt"] != null
          ? DateTime.parse(json["completedAt"])
          : null,
      post: json["post"] != null ? Post.fromJson(json["post"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "postId": postId,
    "offerId": offerId,
    "amount": amount,
    "completedAt": completedAt?.toIso8601String(),
    "post": post?.toJson(),
  };
}

// ================= POST =================

class Post {
  final String? id;
  final Address? pickupAddress;
  final Address? dropoffAddress;
  final List<Media>? media;
  final Author? author;

  Post({
    this.id,
    this.pickupAddress,
    this.dropoffAddress,
    this.media,
    this.author,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      pickupAddress: json["pickupAddress"] != null
          ? Address.fromJson(json["pickupAddress"])
          : null,
      dropoffAddress: json["dropoffAddress"] != null
          ? Address.fromJson(json["dropoffAddress"])
          : null,
      media: json["media"] != null
          ? List<Media>.from(
        json["media"].map((x) => Media.fromJson(x)),
      )
          : [],
      author:
      json["author"] != null ? Author.fromJson(json["author"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "pickupAddress": pickupAddress?.toJson(),
    "dropoffAddress": dropoffAddress?.toJson(),
    "media": media?.map((x) => x.toJson()).toList(),
    "author": author?.toJson(),
  };
}

// ================= ADDRESS =================

class Address {
  final String? address;
  final double? latitude;
  final double? longitude;

  Address({
    this.address,
    this.latitude,
    this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json["address"],
      latitude: (json["latitude"] as num?)?.toDouble(),
      longitude: (json["longitude"] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
  };
}

// ================= MEDIA =================

class Media {
  final String? type;
  final String? url;

  Media({
    this.type,
    this.url,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      type: json["type"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
    "type": type,
    "url": url,
  };
}

// ================= AUTHOR =================

class Author {
  final String? id;
  final String? fullName;
  final String? image;

  Author({
    this.id,
    this.fullName,
    this.image,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json["id"],
      fullName: json["fullName"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "image": image,
  };
}

// ================= META =================

class Meta {
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPage;

  Meta({
    this.total,
    this.page,
    this.limit,
    this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json["total"],
      page: json["page"],
      limit: json["limit"],
      totalPage: json["totalPage"],
    );
  }

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "limit": limit,
    "totalPage": totalPage,
  };
}
