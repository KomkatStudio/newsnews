abstract class Mapper<T, U> {
  const Mapper();

  U mapFrom(T entity);

  T mapTo(U model);
}
