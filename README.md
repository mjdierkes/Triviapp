# Triviapp

Enjoy awesome Trivia questions.


### The Trivia API

This app utilizes the free trivia database, [Open Trivia](https://opentdb.com/). Which is a collection of trivia questions and answers provided by the internet. The raw trivia has HTML elements in it, so both the questions and answers must be filtered. 

There is a standard extension implemented that takes the string value and converts the HTML elements into characters. 

```swift
extension String {
    var decoded: String {
        let attr = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil)

        return attr?.string ?? self
    }
}
```

The raw trivia data is decoded when pulled from the API.


```swift
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        question = try container.decode(String.self, forKey: .question).decoded
    }

```

