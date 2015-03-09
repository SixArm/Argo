import Runes
import Box

public func >>-<A, B>(a: DecodeResult<A>, f: A -> DecodeResult<B>) -> DecodeResult<B> {
  switch a {
  case let .Success(box): return f(box.value)
  case let .MissingKey(string): return .MissingKey(string)
  case let .TypeMismatch(string): return .TypeMismatch(string)
  }
}

public func <^><A, B>(f: A -> B, a: DecodeResult<A>) -> DecodeResult<B> {
  switch a {
  case let .Success(box): return .Success(Box(f(box.value)))
  case let .MissingKey(string): return .MissingKey(string)
  case let .TypeMismatch(string): return .TypeMismatch(string)
  }
}

public func <*><A, B>(f: DecodeResult<A -> B>, a: DecodeResult<A>) -> DecodeResult<B> {
  switch f {
  case let .Success(box): return box.value <^> a
  case let .MissingKey(string): return .MissingKey(string)
  case let .TypeMismatch(string): return .TypeMismatch(string)
  }
}

public func pure<A>(a: A) -> DecodeResult<A> {
  return .Success(Box(a))
}
