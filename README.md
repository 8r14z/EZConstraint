# EZConstraint
Constraint your views with chaining style

```swift
view
  .constraint(.top, to: anotherView)
  .constraint(.bottom, to: anotherView)
  .constraint(.leading, to: anotherView, constant: 20)
  .constraint(.trailing, to: anotherView, constant: 20)
```
