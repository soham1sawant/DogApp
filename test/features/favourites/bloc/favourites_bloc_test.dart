import 'package:bloc_test/bloc_test.dart';
import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:dogbreeds_api/dogbreeds_api.dart';
import 'package:favourites_repo/favourites_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mock_lists.dart';

class MockFavouritesRepository extends Mock implements FavouritesRepo {}

void main() {
  group('FavouritesBloc', () {

    

    late FavouritesRepo favouritesRepository;

    setUp(() {
      favouritesRepository = MockFavouritesRepository();
    });

    test('Initial state is FavouritesLoading', () {
      expect(
        FavouritesBloc(favouritesRepository: favouritesRepository).state,
        FavouritesLoading(),
      );
    });

    blocTest<FavouritesBloc, FavouritesState>(
      'emits [FavouritesLoading, FavouritesLoaded] '
      'when favourites is loaded successfullly',
      setUp: () {
        when(favouritesRepository.loadFavourites).thenAnswer((_) async => []);
      },
      build: () => FavouritesBloc(favouritesRepository: favouritesRepository),
      act: (bloc) => bloc.add(FavouritesStarted()),
      expect: () => <FavouritesState>[
        FavouritesLoading(),
        FavouritesLoaded(favouritesList: const FavouritesList()),
      ],
      verify: (_) => verify(favouritesRepository.loadFavourites).called(1),
    );

    blocTest<FavouritesBloc, FavouritesState>(
      'emits [FavouritesLoading, FavouritesLoadingError] '
      'when favourites is not loaded successfullly',
      setUp: () {
        when(favouritesRepository.loadFavourites).thenThrow(Exception('Error'));
      },
      build: () => FavouritesBloc(favouritesRepository: favouritesRepository),
      act: (bloc) => bloc.add(FavouritesStarted()),
      expect: () =>
          <FavouritesState>[FavouritesLoading(), FavouritesLoadingError()],
      verify: (_) => verify(favouritesRepository.loadFavourites).called(1),
    );

    blocTest<FavouritesBloc, FavouritesState>(
      'emits [] when favourites is not loaded and breed is added',
      setUp: () {
        when(favouritesRepository.loadFavourites).thenAnswer((_) async {
          return <BreedsModel>[];
        });
      },
      build: () => FavouritesBloc(favouritesRepository: favouritesRepository),
      act: (bloc) => bloc.add(FavouritesAdded(mockBreedToAdd)),
      expect: () => <FavouritesState>[],
    );

    blocTest<FavouritesBloc, FavouritesState>(
      'emits [FavouritesLoaded] when breed is added successfully',
      setUp: () {
        when(() => favouritesRepository.addBreedToFavourites(mockBreedToAdd))
            .thenAnswer((_) async {});
      },
      build: () => FavouritesBloc(favouritesRepository: favouritesRepository),
      seed: () => FavouritesLoaded(
          favouritesList: FavouritesList(favourites: mockFavouriteBreeds),),
      act: (bloc) => bloc.add(FavouritesAdded(mockBreedToAdd)),
      expect: () => <FavouritesState>[
        FavouritesLoaded(
          favouritesList: FavouritesList(
              favourites: [...mockFavouriteBreeds, mockBreedToAdd],),
        )
      ],
      verify: (_) {
        verify(() => favouritesRepository.addBreedToFavourites(mockBreedToAdd))
            .called(1);
      },
    );

    blocTest<FavouritesBloc, FavouritesState>(
      'emits [FavouritesLoadingError] when breed is not added successfully',
      setUp: () {
        when(() => favouritesRepository.addBreedToFavourites(mockBreedToAdd))
            .thenThrow(Exception('Error'));
      },
      build: () => FavouritesBloc(favouritesRepository: favouritesRepository),
      seed: () => FavouritesLoaded(
          favouritesList: FavouritesList(favourites: mockFavouriteBreeds),),
      act: (bloc) => bloc.add(FavouritesAdded(mockBreedToAdd)),
      expect: () => <FavouritesState>[FavouritesLoadingError()],
      verify: (_) {
        verify(() => favouritesRepository.addBreedToFavourites(mockBreedToAdd))
            .called(1);
      },
    );

    blocTest<FavouritesBloc, FavouritesState>(
      'emits [FavouritesLoaded] when breed is removed successfully',
      setUp: () {
        when(() => favouritesRepository.removeBreedFromFavourites(
            mockBreedToRemove,),).thenAnswer((_) async {});
      },
      build: () => FavouritesBloc(favouritesRepository: favouritesRepository),
      seed: () => FavouritesLoaded(
        favouritesList: FavouritesList(favourites: mockFavouriteBreeds),
      ),
      act: (bloc) => bloc.add(FavouritesRemoved(mockBreedToRemove)),
      expect: () => <FavouritesState>[
        FavouritesLoaded(
          favouritesList: FavouritesList(
            favourites: [...mockFavouriteBreeds]..remove(mockBreedToRemove),
          ),
        )
      ],
      verify: (_) {
        verify(() => favouritesRepository
            .removeBreedFromFavourites(mockBreedToRemove),).called(1);
      },
    );

    blocTest<FavouritesBloc, FavouritesState>(
      'emits [FavouritesLoadingError] when item is not removed successfully',
      setUp: () {
        when(() => favouritesRepository.removeBreedFromFavourites(
            mockBreedToRemove,),).thenThrow(Exception('Error'));
      },
      build: () => FavouritesBloc(favouritesRepository: favouritesRepository),
      seed: () => FavouritesLoaded(
        favouritesList: FavouritesList(favourites: mockFavouriteBreeds),
      ),
      act: (bloc) => bloc.add(FavouritesRemoved(mockBreedToRemove)),
      expect: () => <FavouritesState>[FavouritesLoadingError()],
      verify: (_) {
        verify(() => favouritesRepository
            .removeBreedFromFavourites(mockBreedToRemove),).called(1);
      },
    );
  });
}
