public func parse<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> T? {
  return parse(object).value
}

public func parse<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> [T]? {
  return parse(object).value
}

public func parse<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> DecodeResult<T> {
  return T.decode(JSON.parse(object))
}

public func parse<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> DecodeResult<[T]> {
  return decodeArray(JSON.parse(object))
}
