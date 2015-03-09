import Runes

func sequence<T>(xs: [DecodeResult<T>]) -> DecodeResult<[T]> {
  return reduce(xs, pure([])) { accum, elem in
    return curry(+) <^> accum <*> (pure <^> elem)
  }
}

func sequence<T>(xs: [String: DecodeResult<T>]) -> DecodeResult<[String: T]> {
  return reduce(xs, pure([:])) { accum, elem in
    return curry(+) <^> accum <*> ({ [elem.0: $0] } <^> elem.1)
  }
}
