class BookModel {
  dynamic id;
  dynamic title;
  dynamic description;
  dynamic rating;
  dynamic pages;
  dynamic language;
  dynamic audioLen;
  dynamic author;
  dynamic aboutAuthor;
  dynamic userID;
  dynamic bookUrl;
  dynamic audioUrl;
  dynamic category;
  dynamic coverUrl;
  dynamic price;
  dynamic numberOfRating;
  dynamic BookID;

  BookModel({
    this.id,
    this.title,
    this.BookID,
    this.description,
    this.rating,
    this.pages,
    this.language,
    this.audioLen,
    this.author,
    this.userID,
    this.aboutAuthor,
    this.bookUrl,
    this.audioUrl,
    this.category,
    this.coverUrl,
    this.price,
    this.numberOfRating,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      rating: json['rating'],
      pages: json['pages'],
      language: json['language'],
      audioLen: json['audioLen'],
      BookID: json['BookID'],
      author: json['author'],
      userID: json['userID'],
      aboutAuthor: json['aboutAuthor'],
      bookUrl: json['bookUrl'],
      audioUrl: json['audioUrl'],
      category: json['category'],
      coverUrl: json['coverUrl'],
      price: json['price'],
      numberOfRating: json['numberOfRating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'rating': rating,
      'pages': pages,
      'language': language,
      'userID': userID,
      'audioLen': audioLen,
      'BookID': BookID,
      'author': author,
      'aboutAuthor': aboutAuthor,
      'bookUrl': bookUrl,
      'audioUrl': audioUrl,
      'category': category,
      'coverUrl': coverUrl,
      'price': price,
      'numberOfRating': numberOfRating,
    };
  }
}
