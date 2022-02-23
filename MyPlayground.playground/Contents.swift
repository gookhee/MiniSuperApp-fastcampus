import UIKit

var list = [1,2]
print(list.map{ $0*2 })
print(list.map{[$0*2, $0*2]})
print(list.flatMap{[$0*2, $0*2]})

[2, 4]
[[2, 2], [4, 4]]
[2, 2, 4, 4]

print(list.flatMap({ [String($0)+"1" , String($0)+"2"] }))


enum Test: CaseIterable {
    case A
    case B
    case C
}

print(Test.allCases.flatMap({ _ in ["1", "2"] }))
