import 'package:client/app/api/category/category.api.dart';
import 'package:client/app/core/exception/exception.dart';
import 'package:client/app/core/failure/failure.dart';
import 'package:client/app/data/models/category_model.dart';
import 'package:fpdart/fpdart.dart';

class CategoryRepositories {
  final CategoryApi remoteDataSource;
  CategoryRepositories({
    required this.remoteDataSource,
  });

  Future<Either<Failure, CategoryModel>> getCategoryById(
      {required int id}) async {
    try {
      final CategoryModel response = await remoteDataSource.getById(id: id);

      return Right(response);
    } on ClientException catch (e) {
      return Left(ClientFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure("Something wrong in server"));
    }
  }

  Future<Either<Failure, List<CategoryModel>>> getCategories(
      {int limit = 10, int offset = 1}) async {
    try {
      final response =
          await remoteDataSource.getAll(limit: limit, offset: offset);

      return Right(response);
    } on ClientException catch (e) {
      return Left(ClientFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure("Something wrong in server"));
    }
  }

  Future<Either<Failure, void>> createCategory(
      {required CategoryModel category}) async {
    try {
      await remoteDataSource.createCategory(category: category);
      return const Right(null);
    } on ClientException catch (e) {
      return Left(ClientFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure("Something wrong in server"));
    }
  }

  Future<Either<Failure, void>> deleteCategoryById({required int id}) async {
    try {
      await remoteDataSource.deleteCategoryById(id: id);

      return const Right(null);
    } on ClientException catch (e) {
      return Left(ClientFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure("Something wrong in server"));
    }
  }
}
