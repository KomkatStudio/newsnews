import 'package:dartz/dartz.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/domain/repositories/news_repositories/news_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newsnews/src/domain/usecases/get_topheadline.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  GetTopHeadline? getTopHeadline;
  MockNewsRepository? mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    getTopHeadline = GetTopHeadline(newsRepository: mockNewsRepository!);
  });

  test('should get top headline from repo', () async {
    //arrange
    when(mockNewsRepository!
            .getTopHeadline(country: 'us', path: '/top-headlines'))
        .thenAnswer((_) async {
      return const Right(<ArticleEntity>[]);
    });

    //act
    final result =
        await getTopHeadline!.call(const Params(path: '/top-headlines'));

    //assert
    expect(result, const Right(<ArticleEntity>[]));
    // verify(mockNewsRepository)
  });
}
//TODO: get testcase in json and load them