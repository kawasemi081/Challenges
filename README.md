# Challenge1
This is the Day25's milestorn challenge project.

## Summaries the techniques of projects 1-3

- [Day25](https://www.hackingwithswift.com/100/swiftui/25)

### excerpt: Structs vs Classes

There are five key differences between structs and classes:

1. Classes don’t come with a memberwise initializer; structs get these by default.
1. Classes can use inheritance to build up functionality; structs cannot.
1. If you copy a class, both copies point to the same data; copies of structs are always unique.
1. Classes can have deinitializers; structs cannot.
1. You can change variable properties inside constant classes; properties inside constant structs are fixed regardless of whether the properties are constants or variables.

If you use structs most of the time, switching to a class in one particular place conveys some intent: this thing is different and needs to be used differently. If you always use classes, that distinction gets lost – after all, it’s extremely unlikely you need them that often.

__Tip:__ One of the fascinating details of SwiftUI is how it completely inverts how we use structs and classes. In UIKit we would use structs for data and classes for UI, but in SwiftUI it’s completely the opposite – a good reminder of the importance of learning things, even if you think they aren’t immediately useful.

### challenge: Make a brain training game

![game_logo](https://user-images.githubusercontent.com/5071627/67927894-18a0cd80-fbfd-11e9-80fd-e29617543ca6.png)

#### game rule:

- Each turn of the game the app will randomly pick either rock, paper, or scissors.
- Each turn the app will either prompt the player to win or lose.
- The player must then tap the correct move to win or lose the game.
- If they are correct they score a point; otherwise they lose a point.
- The game ends after 10 questions, at which point their score is shown.

So, if the app chose “Rock” and “Win” the player would need to choose “Paper”, but if the app chose “Rock” and “Lose” the player would need to choose “Scissors”.


- [Challenge detail](https://www.hackingwithswift.com/guide/ios-swiftui/2/3/challenge) 
