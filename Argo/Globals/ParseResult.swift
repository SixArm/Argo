import Box

public enum ParseResult<T> {
  case Success(Box<T>)
  case TypeMismatch(String)
  case MissingKey(String)

  public var value: T? {
    switch self {
    case let .Success(box): return box.value
    default: return .None
    }
  }

  public static func optional<A>(p: ParseResult<A>) -> ParseResult<A?> {
    switch p {
    case let .Success(box): return .Success(Box(.Some(box.value)))
    case let .MissingKey(string): return .Success(Box(.None))
    case let .TypeMismatch(string): return .TypeMismatch(string)
    }
  }
}
