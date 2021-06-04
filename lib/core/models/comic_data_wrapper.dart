class ComicDataWrapper {
  int code;
  String status;
  String copyright;
  String attributionText;
  String attributionHTML;
  String etag;
  Data data;

}

class Data {
  int offset;
  int limit;
  int total;
  int count;
  List<Comic> results;
}

class Comic {
  int id;
  int digitalId;
  String title;
  int issueNumber;
  String variantDescription;
  String description;
  String modified;
  String isbn;
  String upc;
  String diamondCode;
  String ean;
  String issn;
  String format;
  int pageCount;
  List<TextObjects> textObjects;
  String resourceURI;
  List<Urls> urls;
  Series series;
  List<Variants> variants;
  List<CollectedIssues> collectedIssues;
  List<Dates> dates;
  List<Prices> prices;
  Thumbnail thumbnail;
  List<Images> images;
  Creators creators;
  Creators characters;
  Creators stories;
  Events events;
}

class TextObjects {
  String type;
  String language;
  String text;
}

class Urls {
  String type;
  String url;

}

class Series {
  String resourceURI;
  String name;

  
}

class Dates {
  String type;
  String date;

  
}

class Prices {
  String type;
  double price;

  
}


class Creators {
  int available;
  String collectionURI;
  List<Items> items;
  int returned;

 
}

class Items {
  String resourceURI;
  String name;
  String role;

  
}

class Items {
  String resourceURI;
  String name;
  String type;

}

class Events {
  int available;
  String collectionURI;
  List<Null> items;
  int returned;

}