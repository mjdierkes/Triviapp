# Triviapp <img align="right" alt="App Icon" width="40px" src="https://github.com/mjdierkes/Triviapp/blob/main/App%20Icon.png" />

Enjoy awesome Trivia questions.

### Getting Setup
To try out the app download the repo and open the Xcode project. Then change the bundle identifier to your domain name. 

### Customizing the App
To customize the game mechanics you can change how the score is calculated. In the **TriviaManager** class there is a function that updates the score when the user chooses an answer choice.
```swift 
public func updateScore(with answer: String) -> Status {
     if(answer == correctAnswer){
         streak += 1
         score += currentTime * streak
         return .correct
     }
     else {
         streak = 1
         return .incorrect
     }
}
```
In addition there is also way to customize the trivia api.  With the **Options** type you can easily change the settings of the Api and generate a custom URL from that.

```swift
/// Creates modifiers to change the game settings.
public enum Category: String, Decodable {
    case art, sports, history
}

public enum Difficulty: String, Decodable {
    case easy, medium, hard
}

public enum Mode: String, Decodable {
    case any, multiple, boolean
}
```
Note - Some portions of this still need to be implemented. 

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



