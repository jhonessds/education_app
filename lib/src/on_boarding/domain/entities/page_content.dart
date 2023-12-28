import 'package:education_app/core/res/media_res.dart';
import 'package:equatable/equatable.dart';

class PageContent extends Equatable {
  PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  factory PageContent.first() {
    return PageContent(
      image: MediaRes.casualReading,
      title: 'Brand new curriculum',
      description: 'This is the first online education platform designed by'
          ' the world\'s top professors',
    );
  }

  factory PageContent.second() {
    return PageContent(
      image: MediaRes.casualLife,
      title: 'Brand new atmosphere',
      description: 'This is the first online education platform designed by'
          ' the world\'s top professors',
    );
  }
  factory PageContent.third() {
    return PageContent(
      image: MediaRes.casualMeditationScience,
      title: 'Easy to join the lesson',
      description: 'This is the first online education platform designed by'
          ' the world\'s top professors',
    );
  }

  final String image;
  final String title;
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
