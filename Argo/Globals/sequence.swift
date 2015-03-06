import Runes

func sequence<T>(xs: [ParseResult<T>]) -> ParseResult<[T]> {
  return reduce(xs, pure([])) { accum, elem in
    return curry(+) <^> accum <*> (pure <^> elem)
  }
}

func sequence<T>(xs: [String: ParseResult<T>]) -> ParseResult<[String: T]> {
  return reduce(xs, pure([:])) { accum, elem in
    return curry(+) <^> accum <*> ({ [elem.0: $0] } <^> elem.1)
  }
}
