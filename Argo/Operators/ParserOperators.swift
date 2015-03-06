import Runes
import Box

public func >>-<A, B>(a: ParseResult<A>, f: A -> ParseResult<B>) -> ParseResult<B> {
  switch a {
  case let .Success(box): return f(box.value)
  case let .MissingKey(string): return .MissingKey(string)
  case let .TypeMismatch(string): return .TypeMismatch(string)
  }
}

public func <^><A, B>(f: A -> B, a: ParseResult<A>) -> ParseResult<B> {
  switch a {
  case let .Success(box): return .Success(Box(f(box.value)))
  case let .MissingKey(string): return .MissingKey(string)
  case let .TypeMismatch(string): return .TypeMismatch(string)
  }
}

public func <*><A, B>(f: ParseResult<A -> B>, a: ParseResult<A>) -> ParseResult<B> {
  switch f {
  case let .Success(box): return box.value <^> a
  case let .MissingKey(string): return .MissingKey(string)
  case let .TypeMismatch(string): return .TypeMismatch(string)
  }
}

public func pure<A>(a: A) -> ParseResult<A> {
  return .Success(Box(a))
}
