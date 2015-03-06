import Runes

// MARK: Values

// Pull value from JSON
public func <|<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, key: String) -> ParseResult<A> {
  return decodeObject(json) >>- { (A.fromJSON <^> $0[key]) ?? .MissingKey(key) }
}

// Pull optional value from JSON
public func <|?<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, key: String) -> ParseResult<A?> {
  return .optional(json <| key)
}

// Pull embedded value from JSON
public func <|<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, keys: [String]) -> ParseResult<A> {
  return flatReduce(keys, json, <|) >>- { A.fromJSON($0) }
}

// Pull embedded optional value from JSON
public func <|?<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, keys: [String]) -> ParseResult<A?> {
  return .optional(json <| keys)
}

// MARK: Arrays

// Pull array from JSON
public func <||<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, key: String) -> ParseResult<[A]> {
  return json <| key >>- decodeArray
}

// Pull optional array from JSON
public func <||?<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, key: String) -> ParseResult<[A]?> {
  return .optional(json <|| key)
}

// Pull embedded array from JSON
public func <||<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, keys: [String]) -> ParseResult<[A]> {
  return json <| keys >>- decodeArray
}

// Pull embedded optional array from JSON
public func <||?<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, keys: [String]) -> ParseResult<[A]?> {
  return .optional(json <|| keys)
}

