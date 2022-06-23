


final bookData = [
  {
    'label': 'Chariots of Gods',
    'overview': 'Von Däniken also spends around one-third of the book discussing the possibility that humans could theoretically offer primitive civilizations on interstellar worlds advanced technology',
    'imageUrl': 'https://upload.wikimedia.org/wikipedia/en/2/29/Chariots_Of_The_Gods.jpg',
    'rating': '⭐⭐⭐⭐⭐',
    'genre': 'mystery'
  },
  {
    'label': 'To Kill a Mockingbird',
    'overview': 'Reaction to the novel varied widely upon publication. Despite the number of copies sold and its widespread use in education, literary analysis of it is sparse. Author Mary McDonough Murphy,',
    'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg/800px-To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg',
    'rating': '⭐⭐⭐⭐',
    'genre': 'crime'
  },
  {
    'label': 'Secret Window',
    'overview': 'One day, a man named John Shooter arrives at the cabin and accuses Mort of plagiarizing his short story, "Sowing Season". Upon reading Shooter\'s manuscript, Mort discovers it is virtually identical to his own story, "Secret Window", except for the ending. The following day,',
    'imageUrl': 'https://upload.wikimedia.org/wikipedia/en/7/70/Secret_Window_movie.jpg',
    'rating': '⭐⭐⭐⭐⭐',
    'genre': 'thriller'
  },
];

List<Book>  books = bookData.map((e) => Book.fromJson(e)).toList();

class Book{

  final String imageUrl;
  final String label;
  final String overview;
  final String rating;
  final String genre;

  Book({
    required this.imageUrl,
    required this.genre,
    required this.label,
    required this.overview,
    required this.rating
});


  factory Book.fromJson(Map<String, dynamic> json){
    return Book(
        imageUrl: json['imageUrl'],
        genre: json['genre'],
        label: json['label'],
        overview: json['overview'],
        rating: json['rating']
    );
  }



}