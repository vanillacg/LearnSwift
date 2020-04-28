一.基本运算符
1. 赋值运算符
    1.如果赋值的右边是一个多元组，它的元素可以马上被分解成多个常量或变量：
    let (x, y) = (1, 2)
    // 现在 x 等于 1，y 等于 2
    2.与 C 语言和 Objective-C 不同，Swift 的赋值操作并不返回任何值。所以下面语句是无效的
    if x = y {
    // 此句错误，因为 x = y 并不返回任何值
}
2.比较运算符
Swift 也提供恒等（===）和不恒等（!==）这两个比较符来判断两个对象是否引用同一个对象实例。更多细节在类与结构章节的 Identity Operators 部分。
如果两个元组的元素相同，且长度相同的话，元组就可以被比较。比较元组大小会按照从左到右、逐值比较的方式，直到发现有两个值不等时停止。如果所有的值都相等，那么这一对元组我们就称它们是相等的
例如：
(1, "zebra") < (2, "apple")   // true，因为 1 小于 2
(3, "apple") < (3, "bird")    // true，因为 3 等于 3，但是 apple 小于 bird
(4, "dog") == (4, "dog")      // true，因为 4 等于 4，dog 等于 dog

当元组中的元素都可以被比较时，你也可以使用这些运算符来比较它们的大小。例如，像下面展示的代码，你可以比较两个类型为 (String, Int) 的元组，因为 Int 和 String 类型的值可以比较。相反，Bool 不能被比较，也意味着存有布尔类型的元组不能被比较。
("blue", false) < ("purple", true) // 错误，因为 < 不能比较布尔类型

注意
Swift 标准库只能比较七个以内元素的元组比较函数。如果你的元组元素超过七个时，你需要自己实现比较运算符。

3.空合运算符（Nil Coalescing Operator)

空合运算符（a ?? b）将对可选类型 a 进行空判断，如果 a 包含一个值就进行解包，否则就返回一个默认值 b。表达式 a 必须是 Optional 类型。默认值 b 的类型必须要和 a 存储值的类型保持一致。

空合运算符是对以下代码的简短表达方法：
a != nil ? a! : b
上述代码使用了三元运算符。当可选类型 a 的值不为空时，进行强制解封（a!），访问 a 中的值；反之返回默认值 b。无疑空合运算符（??）提供了一种更为优雅的方式去封装条件判断和解封两种行为，显得简洁以及更具可读性。
注意
如果 a 为非空值（non-nil），那么值 b 将不会被计算。这也就是所谓的短路求值。
4.区间运算符（Range Operators）
闭区间运算符
闭区间运算符（a...b）定义一个包含从 a 到 b（包括 a 和 b）的所有值的区间。a 的值不能超过 b。
半开区间运算符
半开区间运算符（a..<b）定义一个从 a 到 b 但不包括 b 的区间。 之所以称为半开区间，是因为该区间包含第一个值而不包括最后的值。
单侧区间
闭区间操作符有另一个表达形式，可以表达往一侧无限延伸的区间 —— 例如，一个包含了数组从索引 2 到结尾的所有值的区间。在这些情况下，你可以省略掉区间操作符一侧的值。这种区间叫做单侧区间，因为操作符只有一侧有值
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names[2...] {
    print(name)
}
// Brian
// Jack

半开区间操作符也有单侧表达形式，附带上它的最终值。就像你使用区间去包含一个值，最终值并不会落在区间内

for name in names[..<2] {
    print(name)
}
// Anna
// Alex

二.字符串和字符
1.多行字符串字面量
如果你需要一个字符串是跨越多行的，那就使用多行字符串字面量 — 由一对三个双引号包裹着的具有固定顺序的文本字符集
let multilineString = """
These are the same.
"""

如果你的代码中，多行字符串字面量包含换行符的话，则多行字符串字面量中也会包含换行符。如果你想换行，以便加强代码的可读性，但是你又不想在你的多行字符串字面量中出现换行符的话，你可以用在行尾写一个反斜杠（\）作为续行符。
let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""
2.字符串字面量的特殊字符
// 转义字符 \0(空字符)、\\(反斜线)、\t(水平制表符)、\n(换行符)、\r(回车符)、\"(双引号)、\'(单引号)。
Unicode 标量，写成 \u{n}(u 为小写)，其中 n 为任意一到八位十六进制数且可用的 Unicode 位码。

let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imageination is more important than knowledge" - Enistein
let dollarSign = "\u{24}"             // $，Unicode 标量 U+0024
let blackHeart = "\u{2665}"           // ♥，Unicode 标量 U+2665
let sparklingHeart = "\u{1F496}"      // 💖，Unicode 标量 U+1F496

由于多行字符串字面量使用了三个双引号，而不是一个，所以你可以在多行字符串字面量里直接使用双引号（"）而不必加上转义符（\）。要在多行字符串字面量中使用 """ 的话，就需要使用至少一个转义符（\）
let threeDoubleQuotes = """
Escaping the first quote \"""
Escaping all three quotes \"\"\"
"""

3.初始化空字符串
要创建一个空字符串作为初始值，可以将空的字符串字面量赋值给变量，也可以初始化一个新的 String 实例：
var emptyString = ""               // 空字符串字面量
var anotherEmptyString = String()  // 初始化方法
// 两个字符串均为空并等价。
可以通过检查 Bool 类型的 isEmpty 属性来判断该字符串是否为空：
if emptyString.isEmpty {
    print("Nothing to see here")
}
// 打印输出：“Nothing to see here”

4.字符串是值类型
在 Swift 中 String 类型是值类型。如果你创建了一个新的字符串，那么当其进行常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝。
Swift 默认拷贝字符串的行为保证了在函数/方法向你传递的字符串所属权属于你，无论该值来自于哪里。你可以确信传递的字符串不会被修改，除非你自己去修改它
5.字符串插值
字符串插值是一种构建新字符串的方式，可以在其中包含常量、变量、字面量和表达式。字符串字面量和多行字符串字面量都可以使用字符串插值。你插入的字符串字面量的每一项都在以反斜线为前缀的圆括号中
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// message 是 "3 times 2.5 is 7.5"
在上面的例子中，multiplier 作为 \(multiplier) 被插入到一个字符串常量量中。当创建字符串执行插值计算时此占位符会被替换为 multiplier 实际的值。

6.Unicode
Swift 的 String 和 Character 类型是完全兼容 Unicode 标准的
Swift 的 String 类型是基于 Unicode 标量 建立的。Unicode 标量是对应字符或者修饰符的唯一的 21 位数字，例如 U+0061 表示小写的拉丁字母（LATIN SMALL LETTER A）（"a"），U+1F425 表示小鸡表情（FRONT-FACING BABY CHICK）（"🐥"）。

7.计算字符数量
如果想要获得一个字符串中 Character 值的数量，可以使用 count 属性
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.count) characters")
// 打印输出“unusualMenagerie has 40 characters”
注意在 Swift 中，使用可拓展的字符群集作为 Character 值来连接或改变字符串时，并不一定会更改字符串的字符数量
例如，如果你用四个字符的单词 cafe 初始化一个新的字符串，然后添加一个 COMBINING ACTUE ACCENT(U+0301)作为字符串的结尾。最终这个字符串的字符数量仍然是 4，因为第四个字符是 é，而不是 e：
var word = "cafe"
print("the number of characters in \(word) is \(word.count)")
// 打印输出“the number of characters in cafe is 4”

word += "\u{301}"    // 拼接一个重音，U+0301

print("the number of characters in \(word) is \(word.count)")
// 打印输出“the number of characters in café is 4”

注意
可扩展的字形群可以由多个 Unicode 标量组成。这意味着不同的字符以及相同字符的不同表示方式可能需要不同数量的内存空间来存储。所以 Swift 中的字符在一个字符串中并不一定占用相同的内存空间数量。因此在没有获取字符串的可扩展的字符群的范围时候，就不能计算出字符串的字符数量。如果你正在处理一个长字符串，需要注意 count 属性必须遍历全部的 Unicode 标量，来确定字符串的字符数量。
另外需要注意的是通过 count 属性返回的字符数量并不总是与包含相同字符的 NSString 的 length 属性相同。NSString 的 length 属性是利用 UTF-16 表示的十六位代码单元数字，而不是 Unicode 可扩展的字符群集。

8.字符串索引
每一个 String 值都有一个关联的索引（index）类型，String.Index，它对应着字符串中的每一个 Character 的位置
前面提到，不同的字符可能会占用不同数量的内存空间，所以要知道 Character 的确定位置，就必须从 String 开头遍历每一个 Unicode 标量直到结尾。因此，Swift 的字符串不能用整数（integer）做索引

使用 startIndex 属性可以获取一个 String 的第一个 Character 的索引。使用 endIndex 属性可以获取最后一个 Character 的后一个位置的索引。因此，endIndex 属性不能作为一个字符串的有效下标。如果 String 是空串，startIndex 和 endIndex 是相等的。

通过调用 String 的 index(before:) 或 index(after:) 方法，可以立即得到前面或后面的一个索引。你还可以通过调用 index(_:offsetBy:) 方法来获取对应偏移量的索引，这种方式可以避免多次调用 index(before:) 或 index(after:) 方法。
使用 indices 属性会创建一个包含全部索引的范围（Range），用来在一个字符串中访问单个字符。
for index in greeting.indices {
   print("\(greeting[index]) ", terminator: "")
}
// 打印输出“G u t e n   T a g ! ”

9.插入和删除
调用 insert(_:at:) 方法可以在一个字符串的指定索引插入一个字符，调用 insert(contentsOf:at:) 方法可以在一个字符串的指定索引插入一个段字符串。
var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
// welcome 变量现在等于 "hello!"

welcome.insert(contentsOf:" there", at: welcome.index(before: welcome.endIndex))
// welcome 变量现在等于 "hello there!"
调用 remove(at:) 方法可以在一个字符串的指定索引删除一个字符，调用 removeSubrange(_:) 方法可以在一个字符串的指定索引删除一个子字符串。
welcome.remove(at: welcome.index(before: welcome.endIndex))
// welcome 现在等于 "hello there"

let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)
// welcome 现在等于 "hello"
注意
你可以使用 insert(_:at:)、insert(contentsOf:at:)、remove(at:) 和 removeSubrange(_:) 方法在任意一个确认的并遵循 RangeReplaceableCollection 协议的类型里面，如上文所示是使用在 String 中，你也可以使用在 Array、Dictionary 和 Set 中。

10.子字符串
当你从字符串中获取一个子字符串 —— 例如，使用下标或者 prefix(_:) 之类的方法 —— 就可以得到一个 SubString 的实例，而非另外一个 String。Swift 里的 SubString 绝大部分函数都跟 String 一样，意味着你可以使用同样的方式去操作 SubString 和 String。然而，跟 String 不同的是，你只有在短时间内需要操作字符串时，才会使用 SubString。当你需要长时间保存结果时，就把 SubString 转化为 String 的实例

11.比较字符串
如果两个字符串（或者两个字符）的可扩展的字形群集是标准相等，那就认为它们是相等的。只要可扩展的字形群集有同样的语言意义和外观则认为它们标准相等，即使它们是由不同的 Unicode 标量构成。
例如，LATIN SMALL LETTER E WITH ACUTE(U+00E9)就是标准相等于 LATIN SMALL LETTER E(U+0065)后面加上 COMBINING ACUTE ACCENT(U+0301)。这两个字符群集都是表示字符 é 的有效方式，所以它们被认为是标准相等的：
// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E WITH ACUTE
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}
// 打印输出“These two strings are considered equal”

相反，英语中的 LATIN CAPITAL LETTER A(U+0041，或者 A)不等于俄语中的 CYRILLIC CAPITAL LETTER A(U+0410，或者 A)。两个字符看着是一样的，但却有不同的语言意义：
let latinCapitalLetterA: Character = "\u{41}"

let cyrillicCapitalLetterA: Character = "\u{0410}"

if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters are not equivalent")
}
// 打印“These two characters are not equivalent”

三. 集合类型
1.数组（Arrays）
1.1 创建一个空数组 
var someInts = [Int]()
通过构造函数的类型，someInts 的值类型被推断为 [Int]

1.2 创建一个带有默认值的数组
Swift 中的 Array 类型还提供一个可以创建特定大小并且所有数据都被默认的构造方法。我们可以把准备加入新数组的数据项数量（count）和适当类型的初始值（repeating）传入数组构造函数：
var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles 是一种 [Double] 数组，等价于 [0.0, 0.0, 0.0]

1.3 通过两个数组相加创建一个数组
可以使用加法操作符（+）来组合两种已存在的相同类型数组。新数组的数据类型会被从两个数组的数据类型中推断出来

1.4 用数组字面量构造数组
可以使用数组字面量来进行数组构造，这是一种用一个或者多个数值构造数组的简单方法
var shoppingList: [String] = ["Eggs", "Milk"]
// shoppingList 已经被构造并且拥有两个初始项。

1.5 访问和修改数组
可以使用数组的只读属性 count 来获取数组中的数据项数量
使用布尔属性 isEmpty 作为一个缩写形式去检查 count 属性是否为 0
可以使用 append(_:) 方法在数组后面添加新的数据项
使用加法赋值运算符（+=）也可以直接在数组后面添加一个或多个拥有相同类型的数据项
可以直接使用下标语法来获取数组中的数据项，把我们需要的数据项的索引值放在直接放在数组名称的方括号中
可以用下标来改变某个已有索引值对应的数据值
可以利用下标来一次改变一系列数据值，即使新数据和原有数据的数量是不一样的
shoppingList[4...6] = ["Bananas", "Apples"]
调用数组的 insert(_:at:) 方法来在某个具体索引值之前添加数据项
可以使用 remove(at:) 方法来移除数组中的某一项。这个方法把数组在特定索引值中存储的数据项移除并且返回这个被移除的数据项,数据项被移除后数组中的空出项会被自动填补
把数组中的最后一项移除，可以使用 removeLast() 方法而不是 remove(at:) 方法来避免我们需要获取数组的 count 属性

1.6 数组的遍历
可以使用 for-in 循环来遍历所有数组中的数据项
如果我们同时需要每个数据项的值和索引值，可以使用 enumerated() 方法来进行数组遍历。enumerated() 返回一个由每一个数据项索引值和数据值组成的元组
for (index, value) in shoppingList.enumerated() {
    print("Item \(String(index + 1)): \(value)")
}

2 集合（Sets）
集合（Set）用来存储相同类型并且没有确定顺序的值。当集合元素顺序不重要时或者希望确保每个元素只出现一次时可以使用集合而不是数组
2.1 集合类型的哈希值
一个类型为了存储在集合中，该类型必须是可哈希化的——也就是说，该类型必须提供一个方法来计算它的哈希值。一个哈希值是 Int 类型的，相等的对象哈希值必须相同，比如 a==b,因此必须 a.hashValue == b.hashValue
注意
你可以使用你自定义的类型作为集合的值的类型或者是字典的键的类型，但你需要使你的自定义类型遵循 Swift 标准库中的 Hashable 协议。遵循 Hashable 协议的类型需要提供一个类型为 Int 的可读属性 hashValue。由类型的 hashValue 属性返回的值不需要在同一程序的不同执行周期或者不同程序之间保持相同。
因为 Hashable 协议遵循 Equatable 协议，所以遵循该协议的类型也必须提供一个“是否相等”运算符（==）的实现。这个 Equatable 协议要求任何遵循 == 实现的实例间都是一种相等的关系。也就是说，对于 a,b,c 三个值来说，== 的实现必须满足下面三种情况：
a == a(自反性)
a == b 意味着 b == a(对称性)
a == b && b == c 意味着 a == c(传递性)

2.2 集合类型语法
Swift 中的 Set 类型被写为 Set<Element>，这里的 Element 表示 Set 中允许存储的类型，和数组不同的是，集合没有等价的简化形式。
2.3 创建和构造一个空的集合
可以通过构造器语法创建一个特定类型的空集合
var letters = Set<Character>()
如果上下文提供了类型信息，比如作为函数的参数或者已知类型的变量或常量，我们可以通过一个空的数组字面量创建一个空的 Set
letters.insert("a")
// letters 现在含有1个 Character 类型的值
letters = []
// letters 现在是一个空的 Set，但是它依然是 Set<Character> 类型
2.4用数组字面量创建集合
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
这个 favoriteGenres 变量被声明为“一个 String 值的集合”，写为 Set<String>。由于这个特定的集合含有指定 String 类型的值，所以它只允许存储 String 类型值
注意
favoriteGenres 被声明为一个变量（拥有 var 标示符）而不是一个常量（拥有 let 标示符）,因为它里面的元素将会在下面的例子中被增加或者移除。
2.5访问和修改一个集合
为了找出一个 Set 中元素的数量，可以使用其只读属性 count
使用布尔属性 isEmpty 作为一个缩写形式去检查 count 属性是否为 0
可以通过调用 Set 的 insert(_:) 方法来添加一个新元素
可以通过调用 Set 的 remove(_:) 方法去删除一个元素，如果该值是该 Set 的一个元素则删除该元素并且返回被删除的元素值，否则如果该 Set 不包含该值，则返回 nil。另外，Set 中的所有元素可以通过它的 removeAll() 方法删除
使用 contains(_:) 方法去检查 Set 中是否包含一个特定的值
2.6 遍历一个集合
可以在一个 for-in 循环中遍历一个 Set 中的所有值
Swift 的 Set 类型没有确定的顺序，为了按照特定顺序来遍历一个 Set 中的值可以使用 sorted() 方法，它将返回一个有序数组，这个数组的元素排列顺序由操作符'<'对元素进行比较的结果来确定

3 集合操作
3.1 基本集合操作
使用 intersection(_:) 方法根据两个集合中都包含的值创建的一个新的集合
使用 symmetricDifference(_:) 方法根据在一个集合中但不在两个集合中的值创建一个新的集合
使用 union(_:) 方法根据两个集合的值创建一个新的集合。
使用 subtracting(_:) 方法根据不在该集合中的值创建一个新的集合。
3.2集合成员关系和相等
使用“是否相等”运算符（==）来判断两个集合是否包含全部相同的值
使用 isSubset(of:) 方法来判断一个集合中的值是否也被包含在另外一个集合中。
使用 isSuperset(of:) 方法来判断一个集合中包含另一个集合中所有的值。
使用 isStrictSubset(of:) 或者 isStrictSuperset(of:) 方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
使用 isDisjoint(with:) 方法来判断两个集合是否不含有相同的值（是否没有交集）

4 字典
字典是一种存储多个相同类型的值的容器。每个值（value）都关联唯一的键（key），键作为字典中的这个值数据的标识符。和数组中的数据项不同，字典中的数据项并没有具体顺序。我们在需要通过标识符（键）访问数据的时候使用字典，这种方法很大程度上和我们在现实世界中使用字典查字义的方法一样
4.1字典类型简化语法
Swift 的字典使用 Dictionary<Key, Value> 定义，其中 Key 是字典中键的数据类型，Value 是字典中对应于这些键所存储值的数据类型。
注意
一个字典的 Key 类型必须遵循 Hashable 协议，就像 Set 的值类型。
我们也可以用 [Key: Value] 这样简化的形式去创建一个字典类型。虽然这两种形式功能上相同，但是后者是首选，并且这本指导书涉及到字典类型时通篇采用后者。
4.2创建一个空字典
可以像数组一样使用构造语法创建一个拥有确定类型的空字典
var namesOfIntegers = [Int: String]()
4.3用字典字面量创建字典
一个键值对是一个 key 和一个 value 的结合体。在字典字面量中，每一个键值对的键和值都由冒号分割。这些键值对构成一个列表，其中这些键值对由方括号包含、由逗号分割
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
4.4访问和修改字典
和数组一样，我们可以通过字典的只读属性 count 来获取某个字典的数据项数量
使用布尔属性 isEmpty 作为一个缩写形式去检查 count 属性是否为 0
可以在字典中使用下标语法来添加新的数据项。可以使用一个恰当类型的键作为下标索引，并且分配恰当类型的新值
可以使用下标语法来改变特定键对应的值
字典的 updateValue(_:forKey:) 方法可以设置或者更新特定键对应的值。就像上面所示的下标示例，updateValue(_:forKey:) 方法在这个键不存在对应值的时候会设置新值或者在存在时更新已存在的值。和上面的下标方法不同的，updateValue(_:forKey:) 这个方法返回更新值之前的原值。这样使得我们可以检查更新是否成功
可以使用下标语法来在字典中检索特定键对应的值。因为有可能请求的键没有对应的值存在，字典的下标访问会返回对应值的类型的可选值。如果这个字典包含请求键所对应的值，下标会返回一个包含这个存在值的可选值，否则将返回 nil
可以使用下标语法来通过给某个键的对应值赋值为 nil 来从字典里移除一个键值对
removeValue(forKey:) 方法也可以用来在字典中移除键值对。这个方法在键值对存在的情况下会移除该键值对并且返回被移除的值或者在没有值的情况下返回 nil
4.5字典遍历
可以使用 for-in 循环来遍历某个字典中的键值对。每一个字典中的数据项都以 (key, value) 元组形式返回，并且我们可以使用临时常量或者变量来分解这些元组
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
通过访问 keys 或者 values 属性，我们也可以遍历字典的键或者值
for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
for airportName in airports.values {
    print("Airport name: \(airportName)")
}
如果我们只是需要使用某个字典的键集合或者值集合来作为某个接受 Array 实例的 API 的参数，可以直接使用 keys 或者 values 属性构造一个新数组
Swift 的字典类型是无序集合类型。为了以特定的顺序遍历字典的键或值，可以对字典的 keys 或 values 属性使用 sorted() 方法

四 控制流
1. For-in 循环
1.1可以使用 for-in 循环来遍历一个集合中的所有元素，例如数组中的元素、范围内的数字或者字符串中的字符。
1.2如果你不需要区间序列内每一项的值，你可以使用下划线（_）替代变量名来忽略这个值
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")
// 输出“3 to the power of 10 is 59049”
下划线符号 _ （替代循环中的变量）能够忽略当前值，并且不提供循环遍历时对值的访问

1.3一些用户可能在其 UI 中可能需要较少的刻度。他们可以每 5 分钟作为一个刻度。使用 stride(from:to:by:) 函数跳过不需要的标记
let minutes = 60
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    // 每5分钟渲染一个刻度线（0, 5, 10, 15 ... 45, 50, 55）
}
1.4可以在闭区间使用 stride(from:through:by:) 起到同样作用
let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    // 每3小时渲染一个刻度线（3, 6, 9, 12）
}
2 while 循环
while 循环会一直运行一段语句直到条件变成 false。这类循环适合使用在第一次迭代前，迭代次数未知的情况下。Swift 提供两种 while 循环形式：
while 循环，每次在循环开始时计算条件是否符合；
repeat-while 循环，每次在循环结束时计算条件是否符合。
2.1
while 循环从计算一个条件开始。如果条件为 true，会重复运行一段语句，直到条件变为 false。
2.2
while 循环的另外一种形式是 repeat-while，它和 while 的区别是在判断循环条件之前，先执行一次循环的代码块。然后重复循环直到条件为 false。
注意
Swift 语言的 repeat-while 循环和其他语言中的 do-while 循环是类似的。
3 条件语句
3.1 if 语句最简单的形式就是只包含一个条件，只有该条件为 true 时，才执行相关代码
3.2 Switch 语句会尝试把某个值与若干个模式（pattern）进行匹配。根据第一个匹配成功的模式，switch 语句会执行对应的代码。当有可能的情况较多时，通常用 switch 语句替换 if 语句
3.3 不存在隐式的贯穿
与 C 和 Objective-C 中的 switch 语句不同，在 Swift 中，当匹配的 case 分支中的代码执行完毕后，程序会终止 switch 语句，而不会继续执行下一个 case 分支。这也就是说，不需要在 case 分支中显式地使用 break 语句。这使得 switch 语句更安全、更易用，也避免了漏写 break 语句导致多个语言被执行的错误。
注意
虽然在 Swift 中 break 不是必须的，但你依然可以在 case 分支中的代码执行完毕前使用 break 跳出，详情请参见Switch 语句中的 break。
每一个 case 分支都必须包含至少一条语句。像下面这样书写代码是无效的，因为第一个 case 分支是空的：
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a": // 无效，这个分支下面没有语句
case "A":
    print("The letter A")
default:
    print("Not the letter A")
}
// 这段代码会报编译错误
不像 C 语言里的 switch 语句，在 Swift 中，switch 语句不会一起匹配 "a" 和 "A"。相反的，上面的代码会引起编译期错误：case "a": 不包含任何可执行语句——这就避免了意外地从一个 case 分支贯穿到另外一个，使得代码更安全、也更直观
为了让单个 case 同时匹配 a 和 A，可以将这个两个值组合成一个复合匹配，并且用逗号分开：
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}
// 输出“The letter A”
为了可读性，符合匹配可以写成多行形式，详情请参考复合匹配
3.4 区间匹配
case 分支的模式也可以是一个值的区间。下面的例子展示了如何使用区间匹配来输出任意数字对应的自然语言格式：
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
// 输出“There are dozens of moons orbiting Saturn.”
在上例中，approximateCount 在一个 switch 声明中被评估。每一个 case 都与之进行比较。因为 approximateCount 落在了 12 到 100 的区间，所以 naturalCount 等于 "dozens of" 值，并且此后的执行跳出了 switch 语句。
3.5 元组
可以使用元组在同一个 switch 语句中测试多个值。元组中的元素可以是值，也可以是区间。另外，使用下划线（_）来匹配所有可能的值。
下面的例子展示了如何使用一个 (Int, Int) 类型的元组来分类下图中的点 (x, y)：
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}
// 输出“(1, 1) is inside the box”
3.6 值绑定（Value Bindings）
case 分支允许将匹配的值声明为临时常量或变量，并且在 case 分支体内使用 —— 这种行为被称为值绑定（value binding），因为匹配的值在 case 分支体内，与临时的常量或变量绑定。
下面的例子将下图中的点 (x, y)，使用 (Int, Int) 类型的元组表示，然后分类表示：
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
// 输出“on the x-axis with an x value of 2”
3.7 Where 
case 分支的模式可以使用 where 语句来判断额外的条件
下面的例子把下图中的点 (x, y)进行了分类：
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
// 输出“(1, -1) is on the line x == -y”
3.8 复合型 Cases
当多个条件可以使用同一种方法来处理时，可以将这几种可能放在同一个 case 后面，并且用逗号隔开。当 case 后面的任意一种模式匹配的时候，这条分支就会被匹配。并且，如果匹配列表过长，还可以分行书写
复合匹配同样可以包含值绑定。复合匹配里所有的匹配模式，都必须包含相同的值绑定。并且每一个绑定都必须获取到相同类型的值。这保证了，无论复合匹配中的哪个模式发生了匹配，分支体内的代码，都能获取到绑定的值，并且绑定的值都有一样的类型。
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}
// 输出“On an axis, 9 from the origin”
4 控制转移语句
控制转移语句改变你代码的执行顺序，通过它可以实现代码的跳转。Swift 有五种控制转移语句：
continue
break
fallthrough
return
throw
4.1 Continue
continue 语句告诉一个循环体立刻停止本次循环，重新开始下次循环。就好像在说“本次循环我已经执行完了”，但是并不会离开整个循环体
4.2 Break
break 语句会立刻结束整个控制流的执行。break 可以在 switch 或循环语句中使用，用来提前结束 switch 或循环语句
4.3 贯穿（Fallthrough）
如果你确实需要 C 风格的贯穿的特性，你可以在每个需要该特性的 case 分支中使用 fallthrough 关键字。下面的例子使用 fallthrough 来创建一个数字的描述语句。
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
// 输出“The number 5 is a prime number, and also an integer.”

fallthrough 关键字不会检查它下一个将会落入执行的 case 中的匹配条件。fallthrough 简单地使代码继续连接到下一个 case 中的代码，这和 C 语言标准中的 switch 语句特性是一样的。
4.4 带标签的语句
可以使用标签（statement label）来标记一个循环体或者条件语句，对于一个条件语句，你可以使用 break 加标签的方式，来结束这个被标记的语句。对于一个循环语句，你可以使用 break 或者 continue 加标签，来结束或者继续这条被标记语句的执行
声明一个带标签的语句是通过在该语句的关键词的同一行前面放置一个标签，作为这个语句的前导关键字（introducor keyword），并且该标签后面跟随一个冒号。下面是一个针对 while 循环体的标签语法，同样的规则适用于所有的循环体和条件语句。
 label name: while condition {
     statements
 }

如果上述的 break 语句没有使用 gameLoop 标签，那么它将会中断 switch 语句而不是 while 循环。使用 gameLoop 标签清晰的表明了 break 想要中断的是哪个代码块。
同时请注意，当调用 continue gameLoop 去跳转到下一次循环迭代时，这里使用 gameLoop 标签并不是严格必须的。因为在这个游戏中，只有一个循环体，所以 continue 语句会影响到哪个循环体是没有歧义的。然而，continue 语句使用 gameLoop 标签也是没有危害的。这样做符合标签的使用规则，同时参照旁边的 break gameLoop，能够使游戏的逻辑更加清晰和易于理解
4.5 提前退出
像 if 语句一样，guard 的执行取决于一个表达式的布尔值。我们可以使用 guard 语句来要求条件必须为真时，以执行 guard 语句后的代码。不同于 if 语句，一个 guard 语句总是有一个 else 从句，如果条件不为真则执行 else 从句中的代码
如果 guard 语句的条件被满足，则继续执行 guard 语句大括号后的代码。将变量或者常量的可选绑定作为 guard 语句的条件，都可以保护 guard 语句后面的代码
相比于可以实现同样功能的 if 语句，按需使用 guard 语句会提升我们代码的可读性。它可以使你的代码连贯的被执行而不需要将它包在 else 块中，它可以使你在紧邻条件判断的地方，处理违规的情况

4.6 检测 API 可用性
在 if 或 guard 语句中使用 可用性条件（availability condition)去有条件的执行一段代码，来在运行时判断调用的 API 是否可用。编译器使用从可用性条件语句中获取的信息去验证，在这个代码块中调用的 API 是否可用。
if #available(iOS 10, macOS 10.12, *) {
    // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
} else {
    // 使用先前版本的 iOS 和 macOS 的 API
}
以上可用性条件指定，if 语句的代码块仅仅在 iOS 10 或 macOS 10.12 及更高版本才运行。最后一个参数，*，是必须的，用于指定在所有其它平台中，如果版本号高于你的设备指定的最低版本，if 语句的代码块将会运行
if #available(平台名称 版本号, ..., *) {
    APIs 可用，语句将执行
} else {
    APIs 不可用，语句将不执行
}

五 函数
在 Swift 中，每个函数都有一个由函数的参数值类型和返回值类型组成的类型。你可以把函数类型当做任何其他普通变量类型一样处理，这样就可以更简单地把函数当做别的函数的参数，也可以从其他函数中返回函数。函数的定义可以写在其他函数定义中，这样可以在嵌套函数范围内实现功能封装
1. 函数的定义与调用
每个函数有个函数名，用来描述函数执行的任务。要使用一个函数时，用函数名来“调用”这个函数，并传给它匹配的输入值（称作实参）。函数的实参必须与函数参数表里参数的顺序一致
所有的这些信息汇总起来成为函数的定义，并以 func 作为前缀。指定函数返回类型时，用返回箭头 ->（一个连字符后跟一个右尖括号）后跟返回类型的名称的方式来表示
2. 函数参数与返回值
2.1 无参数函数
定义中在函数名后还是需要一对圆括号。当被调用时，也需要在函数名后写一对圆括号
2.2 多参数函数
2.3 无返回值函数ÔÔ
2.4 多重返回值函数
可以用元组（tuple）类型让多个值作为一个复合值从函数中返回
因为元组的成员值已被命名，因此可以通过 . 语法来检索找到的最小值与最大值
元组的成员不需要在元组从函数中返回时命名，因为它们的名字已经在函数返回类型中指定了
2.5 可选元组返回类型
如果函数返回的元组类型有可能整个元组都“没有值”，你可以使用可选的 元组返回类型反映整个元组可以是 nil 的事实。你可以通过在元组类型的右括号后放置一个问号来定义一个可选元组，例如 (Int, Int)? 或 (String, Int, Bool)?
注意
可选元组类型如 (Int, Int)? 与元组包含可选类型如 (Int?, Int?) 是不同的。可选的元组类型，整个元组是可选的，而不只是元组中的每个元素值
为了安全地处理这个“空数组”问题，将 minMax(array:) 函数改写为使用可选元组返回类型，并且当数组为空时返回 nil：
func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
你可以使用可选绑定来检查 minMax(array:) 函数返回的是一个存在的元组值还是 nil：
if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}
// 打印“min is -6 and max is 109”
3. 函数参数标签和参数名称
每个函数参数都有一个参数标签（argument label）以及一个参数名称（parameter name）。参数标签在调用函数的时候使用；调用的时候需要将函数的参数标签写在对应的参数前面。参数名称在函数的实现中使用。默认情况下，函数参数使用参数名称来作为它们的参数标签。
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}
3.1 指定参数标签
可以在参数名称前指定它的参数标签，中间以空格分隔：
func someFunction(argumentLabel parameterName: Int) {
    // 在函数体内，parameterName 代表参数值
}
3.2 忽略参数标签
如果你不希望为某个参数添加一个标签，可以使用一个下划线（_）来代替一个明确的参数标签
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
     // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}
someFunction(1, secondParameterName: 2)
3.3 默认参数值
可以在函数体中通过给参数赋值来为任意一个参数定义默认值（Deafult Value）。当默认值被定义后，调用这个函数时可以忽略这个参数。
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault = 6
someFunction(parameterWithoutDefault: 4) // parameterWithDefault = 12
3.4 可变参数
一个可变参数（variadic parameter）可以接受零个或多个值。函数调用时，你可以用可变参数来指定函数参数可以被传入不确定数量的输入值。通过在变量类型名后面加入（...）的方式来定义可变参数。
下面的这个函数用来计算一组任意长度数字的 算术平均数（arithmetic mean)：
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// 返回 3.0, 是这 5 个数的平均数。
arithmeticMean(3, 8.25, 18.75)
// 返回 10.0, 是这 3 个数的平均数。
注意
一个函数最多只能拥有一个可变参数。
3.5 输入输出参数
函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误。这意味着你不能错误地更改参数值。如果你想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束后仍然存在，那么就应该把这个参数定义为输入输出参数（In-Out Parameters）
定义一个输入输出参数时，在参数定义前加 inout 关键字。一个 输入输出参数有传入函数的值，这个值被函数修改，然后被传出函数，替换原来的值
只能传递变量给输入输出参数。你不能传入常量或者字面量，因为这些量是不能被修改的。当传入的参数作为输入输出参数时，需要在参数名前加 & 符，表示这个值可以被函数修改。
注意
输入输出参数不能有默认值，而且可变参数不能用 inout 标记。
下例中，swapTwoInts(_:_:) 函数有两个分别叫做 a 和 b 的输入输出参数：
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
swapTwoInts(_:_:) 函数简单地交换 a 与 b 的值。该函数先将 a 的值存到一个临时常量 temporaryA 中，然后将 b 的值赋给 a，最后将 temporaryA 赋值给 b。
你可以用两个 Int 型的变量来调用 swapTwoInts(_:_:)。需要注意的是，someInt 和 anotherInt 在传入 swapTwoInts(_:_:) 函数前，都加了 & 的前缀：
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// 打印“someInt is now 107, and anotherInt is now 3”
4. 函数类型
每个函数都有种特定的函数类型，函数的类型由函数的参数类型和返回类型组成
例如：
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
这两个函数的类型是 (Int, Int) -> Int，可以解读为:
“这个函数类型有两个 Int 型的参数并返回一个 Int 型的值”。
func printHelloWorld() {
    print("hello, world")
}
这个函数的类型是：() -> Void，或者叫“没有参数，并返回 Void 类型的函数”。
4.1 使用函数类型
在 Swift 中，使用函数类型就像使用其他类型一样。例如，你可以定义一个类型为函数的常量或变量，并将适当的函数赋值给它：
var mathFunction: (Int, Int) -> Int = addTwoInts
这段代码可以被解读为：
”定义一个叫做 mathFunction 的变量，类型是‘一个有两个 Int 型的参数并返回一个 Int 型的值的函数’，并让这个新变量指向 addTwoInts 函数”。
addTwoInts 和 mathFunction 有同样的类型，所以这个赋值过程在 Swift 类型检查（type-check）中是允许的。
print("Result: \(mathFunction(2, 3))")
// Prints "Result: 5"
就像其他类型一样，当赋值一个函数给常量或变量时，你可以让 Swift 来推断其函数类型：
let anotherMathFunction = addTwoInts
// anotherMathFunction 被推断为 (Int, Int) -> Int 类型
4.2 函数类型作为参数类型
可以用 (Int, Int) -> Int 这样的函数类型作为另一个函数的参数类型。这样你可以将函数的一部分实现留给函数的调用者来提供。
下面是另一个例子，正如上面的函数一样，同样是输出某种数学运算结果：
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// 打印“Result: 8”
这个例子定义了 printMathResult(_:_:_:) 函数，它有三个参数：第一个参数叫 mathFunction，类型是 (Int, Int) -> Int，你可以传入任何这种类型的函数；第二个和第三个参数叫 a 和 b，它们的类型都是 Int，这两个值作为已给出的函数的输入值。
4.3 函数类型作为返回类型
可以用函数类型作为另一个函数的返回类型。你需要做的是在返回箭头（->）后写一个完整的函数类型
4.4 嵌套函数
到目前为止本章中你所见到的所有函数都叫全局函数（global functions），它们定义在全局域中。你也可以把函数定义在别的函数体中，称作 嵌套函数（nested functions）。
默认情况下，嵌套函数是对外界不可见的，但是可以被它们的外围函数（enclosing function）调用。一个外围函数也可以返回它的某一个嵌套函数，使得这个函数可以在其他域中被使用。
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!

六 闭包
闭包是自包含的函数代码块，可以在代码中被传递和使用。Swift 中的闭包与 C 和 Objective-C 中的代码块（blocks）以及其他一些编程语言中的匿名函数（Lambdas）比较相似。
闭包可以捕获和存储其所在上下文中任意常量和变量的引用。被称为包裹常量和变量。 Swift 会为你管理在捕获过程中涉及到的所有内存操作。
在函数章节中介绍的全局和嵌套函数实际上也是特殊的闭包，闭包采用如下三种形式之一：
全局函数是一个有名字但不会捕获任何值的闭包
嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包
1. 闭包表达式
闭包表达式是一种构建内联闭包的方式，它的语法简洁。在保证不丢失它语法清晰明了的同时，闭包表达式提供了几种优化的语法简写形式。
1.1 排序方法
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
1.2 闭包表达式语法
闭包表达式语法有如下的一般形式：
{ (parameters) -> return type in
    statements
}
闭包表达式参数 可以是 in-out 参数，但不能设定默认值。如果你命名了可变参数，也可以使用此可变参数。元组也可以作为参数和返回值。
下面的例子展示了之前 backward(_:_:) 函数对应的闭包表达式版本的代码：
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

闭包的函数体部分由关键字 in 引入。该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始。
1.3 根据上下文推断类型
因为排序闭包函数是作为 sorted(by:) 方法的参数传入的，Swift 可以推断其参数和返回值的类型。sorted(by:) 方法被一个字符串数组调用，因此其参数必须是 (String, String) -> Bool 类型的函数。这意味着 (String, String) 和 Bool 类型并不需要作为闭包表达式定义的一部分。因为所有的类型都可以被正确推断，返回箭头（->）和围绕在参数周围的括号也可以被省略：
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
实际上，通过内联闭包表达式构造的闭包作为参数传递给函数或方法时，总是能够推断出闭包的参数和返回值类型。这意味着闭包作为函数或者方法的参数时，你几乎不需要利用完整格式构造内联闭包。
1.4 单表达式闭包的隐式返回
单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果，如上版本的例子可以改写为：
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
1.5 参数名称缩写
Swift 自动为内联闭包提供了参数名称缩写功能，你可以直接通过 $0，$1，$2 来顺序调用闭包的参数，以此类推
如果你在闭包表达式中使用参数名称缩写，你可以在闭包定义中省略参数列表，并且对应参数名称缩写的类型会通过函数类型进行推断。in 关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成：
reversedNames = names.sorted(by: { $0 > $1 } )
1.6 运算符方法
实际上还有一种更简短的方式来编写上面例子中的闭包表达式。Swift 的 String 类型定义了关于大于号（>）的字符串实现，其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。而这正好与 sorted(by:) 方法的参数需要的函数类型相符合。因此，你可以简单地传递一个大于号，Swift 可以自动推断找到系统自带的那个字符串函数的实现：
reversedNames = names.sorted(by: >)
2. 尾随闭包
如果你需要将一个很长的闭包表达式作为最后一个参数传递给函数，将这个闭包替换成为尾随闭包的形式很有用。尾随闭包是一个书写在函数圆括号之后的闭包表达式，函数支持将其作为最后一个参数调用。在使用尾随闭包时，你不用写出它的参数标签：
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // 函数体部分
}

// 以下是不使用尾随闭包进行函数调用
someFunctionThatTakesAClosure(closure: {
    // 闭包主体部分
})

// 以下是使用尾随闭包进行函数调用
someFunctionThatTakesAClosure() {
    // 闭包主体部分
}
当闭包非常长以至于不能在一行中进行书写时，尾随闭包变得非常有用
3. 值捕获
闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值
Swift 中，可以捕获值的闭包的最简单形式是嵌套函数，也就是定义在其他函数的函数体内的函数。嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。
4. 闭包是引用类型
incrementBySeven 和 incrementByTen 都是常量，但是这些常量指向的闭包仍然可以增加其捕获的变量的值。这是因为函数和闭包都是引用类型。
无论你将函数或闭包赋值给一个常量还是变量，你实际上都是将常量或变量的值设置为对应函数或闭包的引用
5. 逃逸闭包
当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸
当你定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的。
一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中。举个例子，很多启动异步操作的函数接受一个闭包参数作为 completion handler。这类函数会在异步操作开始之后立刻返回，但是闭包直到异步操作结束后才会被调用。在这种情况下，闭包需要“逃逸”出函数，因为闭包需要在函数返回之后被调用。
someFunctionWithEscapingClosure(_:) 函数接受一个闭包作为参数，该闭包被添加到一个函数外定义的数组中。如果你不将这个参数标记为 @escaping，就会得到一个编译错误。
将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self。比如说，在下面的代码中，传递到 someFunctionWithEscapingClosure(_:) 中的闭包是一个逃逸闭包，这意味着它需要显式地引用 self。相对的，传递到 someFunctionWithNonescapingClosure(_:) 中的闭包是一个非逃逸闭包，这意味着它可以隐式引用 self。
例如：
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// 打印出“200”

completionHandlers.first?()
print(instance.x)
// 打印出“100”
6. 自动闭包
自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包

自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。延迟求值对于那些有副作用（Side Effect）和高计算成本的代码来说是很有益处的，因为它使得你能控制代码的执行时机。下面的代码展示了闭包如何延时求值。
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// 打印出“5”

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// 打印出“5”

print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// 打印出“4”
如果你想让一个自动闭包可以“逃逸”，则应该同时使用 @autoclosure 和 @escaping 属性。@escaping 属性的讲解见上面的逃逸闭包。

七 枚举
枚举为一组相关的值定义了一个共同的类型，使你可以在你的代码中以类型安全的方式来使用这些值
Swift 中的枚举更加灵活，不必给每一个枚举成员提供一个值。如果给枚举成员提供一个值（称为原始值），则该值的类型可以是字符串、字符，或是一个整型值或浮点数。
此外，枚举成员可以指定任意类型的关联值存储到枚举成员中，就像其他语言中的联合体（unions）和变体（variants）。你可以在一个枚举中定义一组相关的枚举成员，每一个枚举成员都可以有适当类型的关联值。
在 Swift 中，枚举类型是一等（first-class）类型。它们采用了很多在传统上只被类（class）所支持的特性，例如计算属性（computed properties），用于提供枚举值的附加信息，实例方法（instance methods），用于提供和枚举值相关联的功能。枚举也可以定义构造函数（initializers）来提供一个初始值；可以在原始实现的基础上扩展它们的功能；还可以遵循协议（protocols）来提供标准的功能。
1. 枚举语法
使用 enum 关键词来创建枚举并且把它们的整个定义放在一对大括号内：
enum SomeEnumeration {
    // 枚举定义放在这里
}
下面是用枚举表示指南针四个方向的例子：
enum CompassPoint {
    case north
    case south
    case east
    case west
}
枚举中定义的值（如 north，south，east 和 west）是这个枚举的成员值（或成员）。你可以使用 case 关键字来定义一个新的枚举成员值。
注意
与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的 CompassPoint 例子中，north，south，east 和 west 不会被隐式地赋值为 0，1，2 和 3。相反，这些枚举成员本身就是完备的值，这些值的类型是已经明确定义好的 CompassPoint 类型。
每个枚举定义了一个全新的类型。像 Swift 中其他类型一样，它们的名字（例如 CompassPoint 和 Planet）以一个大写字母开头。给枚举类型起一个单数名字而不是复数名字，以便于：
directionToHead 的类型可以在它被 CompassPoint 的某个值初始化时推断出来。一旦 directionToHead 被声明为 CompassPoint 类型，你可以使用更简短的点语法将其设置为另一个 CompassPoint 的值：
directionToHead = .east
var directionToHead = CompassPoint.west
2. 使用 Switch 语句匹配枚举值
你可以使用 switch 语句匹配单个枚举值：
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
// 打印“Watch out for penguins”
在判断一个枚举类型的值时，switch 语句必须穷举所有情况。如果忽略了 .west 这种情况，上面那段代码将无法通过编译，因为它没有考虑到 CompassPoint 的全部成员。强制穷举确保了枚举成员不会被意外遗漏。
3. 枚举成员的遍历
令枚举遵循 CaseIterable 协议。Swift 会生成一个 allCases 属性，用于表示一个包含枚举所有成员的集合。
下面是一个例子：
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// 打印“3 beverages available”
4. 关联值
有时候把其他类型的值和成员值一起存储起来会很有用。这额外的信息称为关联值，并且你每次在代码中使用该枚举成员时，还可以修改这个关联值
在 Swift 中，使用如下方式定义表示两种商品条形码的枚举：
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
以上代码可以这么理解：
“定义一个名为 Barcode 的枚举类型，它的一个成员值是具有 (Int，Int，Int，Int) 类型关联值的 upc，另一个成员值是具有 String 类型关联值的 qrCode。”
这个定义不提供任何 Int 或 String 类型的关联值，它只是定义了，当 Barcode 常量和变量等于 Barcode.upc 或 Barcode.qrCode 时，可以存储的关联值的类型。
然后你可以使用任意一种条形码类型创建新的条形码，例如：
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
上面的例子创建了一个名为 productBarcode 的变量，并将 Barcode.upc 赋值给它，关联的元组值为 (8, 85909, 51226, 3)。
同一个商品可以被分配一个不同类型的条形码，例如：
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
这时，原始的 Barcode.upc 和其整数关联值被新的 Barcode.qrCode 和其字符串关联值所替代。Barcode 类型的常量和变量可以存储一个 .upc 或者一个 .qrCode（连同它们的关联值），但是在同一时间只能存储这两个值中的一个。
你可以使用一个 switch 语句来检查不同的条形码类型，和之前使用 Switch 语句来匹配枚举值的例子一样。然而，这一次，关联值可以被提取出来作为 switch 语句的一部分。你可以在 switch 的 case 分支代码中提取每个关联值作为一个常量（用 let 前缀）或者作为一个变量（用 var 前缀）来使用：
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// 打印“QR code: ABCDEFGHIJKLMNOP.”
如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注一个 let 或者 var：
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// 打印“QR code: ABCDEFGHIJKLMNOP.”
5. 原始值
作为关联值的替代选择，枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同
原始值可以是字符串、字符，或者任意整型值或浮点型值。每个原始值在枚举声明中必须是唯一的。
注意
原始值和关联值是不同的。原始值是在定义枚举时被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚举成员，它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值可以变化。
5.1 原始值的隐式赋值
在使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为你赋值
当使用整数作为原始值时，隐式赋值的值依次递增 1。如果第一个枚举成员没有设置原始值，其原始值将为 0
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称
使用枚举成员的 rawValue 属性可以访问该枚举成员的原始值：
let earthsOrder = Planet.earth.rawValue
// earthsOrder 值为 3

let sunsetDirection = CompassPoint.west.rawValue
// sunsetDirection 值为 "west"
5.2 使用原始值初始化枚举实例
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
如果在定义枚举类型的时候使用了原始值，那么将会自动获得一个初始化方法，这个方法接收一个叫做 rawValue 的参数，参数类型即为原始值类型，返回值则是枚举成员或 nil。你可以使用这个初始化方法来创建一个新的枚举实例。
这个例子利用原始值 7 创建了枚举成员 Uranus：
let possiblePlanet = Planet(rawValue: 7)
// possiblePlanet 类型为 Planet? 值为 Planet.uranus
原始值构造器是一个可失败构造器，因为并不是每一个原始值都有与之对应的枚举成员。更多信息请参见可失败构造器
6. 递归枚举
递归枚举是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加上 indirect 来表示该成员可递归。
下面的例子中，枚举类型存储了简单的算术表达式：
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
你也可以在枚举类型开头加上 indirect 关键字来表明它的所有成员都是可递归的：
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

八 类和结构体
Swift 并不要求你为自定义的结构体和类的接口与实现代码分别创建文件。你只需在单一的文件中定义一个结构体或者类，系统将会自动生成面向其它代码的外部接口。
注意
通常一个类的实例被称为对象。然而相比其他语言，Swift 中结构体和类的功能更加相近，本章中所讨论的大部分功能都可以用在结构体或者类上。因此，这里会使用实例这个更通用的术语。
1. 结构体和类对比
Swift 中结构体和类有很多共同点。两者都可以：
定义属性用于存储值
定义方法用于提供功能
定义下标操作用于通过下标语法访问它们的值
定义构造器用于设置初始值
通过扩展以增加默认实现之外的功能
遵循协议以提供某种标准功能

与结构体相比，类还有如下的附加功能：
继承允许一个类继承另一个类的特征
类型转换允许在运行时检查和解释一个类实例的类型
析构器允许一个类实例释放任何其所被分配的资源
引用计数允许对一个类的多次引用

类支持的附加功能是以增加复杂性为代价的。作为一般准则，优先使用结构体，因为它们更容易理解，仅在适当或必要时才使用类
1.1 类型定义的语法
结构体和类有着相似的定义方式。你通过 struct 关键字引入结构体，通过 class 关键字引入类，并将它们的具体定义放在一对大括号中：
struct SomeStructure {
    // 在这里定义结构体
}
class SomeClass {
    // 在这里定义类
}
注意
每当你定义一个新的结构体或者类时，你都是定义了一个新的 Swift 类型。请使用 UpperCamelCase 这种方式来命名类型（如这里的 SomeClass 和 SomeStructure），以便符合标准 Swift 类型的大写命名风格（如 String，Int 和 Bool）。请使用 lowerCamelCase 这种方式来命名属性和方法（如 framerate 和 incrementCount），以便和类型名区分
1.2 结构体和类的实例

创建结构体和类实例的语法非常相似：
let someResolution = Resolution()
let someVideoMode = VideoMode()
构造器语法的最简单形式是在结构体或者类的类型名称后跟随一对空括号，如 Resolution() 或 VideoMode()
1.3 属性访问
你可以通过使用点语法访问实例的属性。其语法规则是，实例名后面紧跟属性名，两者以点号（.）分隔，不带空格
你也可以访问子属性，如 VideoMode 中 resolution 属性的 width 属性：
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
// 打印 "The width of someVideoMode is 0"
你也可以使用点语法为可变属性赋值：
someVideoMode.resolution.width = 1280
1.4 结构体类型的成员逐一构造器
所有结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员的属性。新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中：
let vga = Resolution(width: 640, height: 480)
与结构体不同，类实例没有默认的成员逐一构造器
2. 结构体和枚举是值类型
值类型是这样一种类型，当它被赋值给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
实际上，Swift 中所有的基本类型：整数（integer）、浮点数（floating-point number）、布尔值（boolean）、字符串（string)、数组（array）和字典（dictionary），都是值类型，其底层也是使用结构体实现的。
Swift 中所有的结构体和枚举类型都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型的属性，在代码中传递的时候都会被复制。
注意
标准库定义的集合，例如数组，字典和字符串，都对复制进行了优化以降低性能成本。新集合不会立即复制，而是跟原集合共享同一份内存，共享同样的元素。在集合的某个副本要被修改前，才会复制它的元素。而你在代码中看起来就像是立即发生了复制
请看下面这个示例，其使用了上一个示例中的 Resolution 结构体：
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
在以上示例中，声明了一个名为 hd 的常量，其值为一个初始化为全高清视频分辨率（1920 像素宽，1080 像素高）的 Resolution 实例。
然后示例中又声明了一个名为 cinema 的变量，并将 hd 赋值给它。因为 Resolution 是一个结构体，所以会先创建一个现有实例的副本，然后将副本赋值给 cinema 。尽管 hd 和 cinema 有着相同的宽（width）和高（height），但是在幕后它们是两个完全不同的实例。
下面，为了符合数码影院放映的需求（2048 像素宽，1080 像素高），cinema 的 width 属性被修改为稍微宽一点的 2K 标准：
cinema.width = 2048
查看 cinema 的 width 属性，它的值确实改为了 2048：
print("cinema is now  \(cinema.width) pixels wide")
// 打印 "cinema is now 2048 pixels wide"
然而，初始的 hd 实例中 width 属性还是 1920：
print("hd is still \(hd.width) pixels wide")
// 打印 "hd is still 1920 pixels wide"
将 hd 赋值给 cinema 时，hd 中所存储的值会拷贝到新的 cinema 实例中。结果就是两个完全独立的实例包含了相同的数值。由于两者相互独立，因此将 cinema 的 width 修改为 2048 并不会影响 hd 中的 width 的值，如下图所示：

枚举也遵循相同的行为准则：
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")
// 打印 "The current direction is north"
// 打印 "The remembered direction is west"
当 rememberedDirection 被赋予了 currentDirection 的值，实际上它被赋予的是值的一个拷贝。赋值过程结束后再修改 currentDirection 的值并不影响 rememberedDirection 所储存的原始值的拷贝
3. 类是引用类型
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，使用的是已存在实例的引用，而不是其拷贝
需要注意的是 tenEighty 和 alsoTenEighty 被声明为常量而不是变量。然而你依然可以改变 tenEighty.frameRate 和 alsoTenEighty.frameRate，这是因为 tenEighty 和 alsoTenEighty 这两个常量的值并未改变。它们并不“存储”这个 VideoMode 实例，而仅仅是对 VideoMode 实例的引用。所以，改变的是底层 VideoMode 实例的 frameRate 属性，而不是指向 VideoMode 的常量引用的值。
3.1 恒等运算符
因为类是引用类型，所以多个常量和变量可能在幕后同时引用同一个类实例。（对于结构体和枚举来说，这并不成立。因为它们作为值类型，在被赋予到常量、变量或者传递到函数时，其值总是会被拷贝。）
判定两个常量或者变量是否引用同一个类实例有时很有用。为了达到这个目的，Swift 提供了两个恒等运算符：
相同（===）
不相同（!==）
使用这两个运算符检测两个常量或者变量是否引用了同一个实例：
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// 打印 "tenEighty and alsoTenEighty refer to the same VideoMode instance."
请注意，“相同”（用三个等号表示，===）与“等于”（用两个等号表示，==）的不同。“相同”表示两个类类型（class type）的常量或者变量引用同一个类实例。“等于”表示两个实例的值“相等”或“等价”，判定时要遵照设计者定义的评判标准。
3.2 
Swift 中引用了某个引用类型实例的常量或变量，与 C 语言中的指针类似，不过它并不直接指向某个内存地址，也不要求你使用星号（*）来表明你在创建一个引用。相反，Swift 中引用的定义方式与其它的常量或变量的一样。如果需要直接与指针交互，你可以使用标准库提供的指针和缓冲区类型 

九 属性
属性将值与特定的类、结构体或枚举关联。存储属性会将常量和变量存储为实例的一部分，而计算属性则是直接计算（而不是存储）值。计算属性可以用于类、结构体和枚举，而存储属性只能用于类和结构体
存储属性和计算属性通常与特定类型的实例关联。但是，属性也可以直接与类型本身关联，这种属性称为类型属性
还可以定义属性观察器来监控属性值的变化，以此来触发自定义的操作。属性观察器可以添加到类本身定义的存储属性上，也可以添加到从父类继承的属性上
1. 存储属性
简单来说，一个存储属性就是存储在特定类或结构体实例里的一个常量或变量。存储属性可以是变量存储属性（用关键字 var 定义），也可以是常量存储属性（用关键字 let 定义）。
1.1 常量结构体实例的存储属性
如果创建了一个结构体实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使被声明为可变属性也不行
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// 该区间表示整数 0，1，2，3
rangeOfFourItems.firstValue = 6
// 尽管 firstValue 是个可变属性，但这里还是会报错
因为 rangeOfFourItems 被声明成了常量（用 let 关键字），所以即使 firstValue 是一个可变属性，也无法再修改它了。
这种行为是由于结构体属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。
属于引用类型的类则不一样。把一个引用类型的实例赋给一个常量后，依然可以修改该实例的可变属性

1.2 延时加载存储属性
延时加载存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延时加载存储属性。
延时加载存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延时加载存储属性。
注意
必须将延时加载属性声明成变量（使用 var 关键字），因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延时加载。
当属性的值依赖于一些外部因素且这些外部因素只有在构造过程结束之后才会知道的时候，延时加载属性就会很有用。或者当获得属性的值因为需要复杂或者大量的计算，而需要采用需要的时候再计算的方式，延时加载属性也会很有用。
注意
如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。
1.3 存储属性和实例变量
2. 计算属性
2.1 简化 Setter 声明
2.2 只读计算属性
只有 getter 没有 setter 的计算属性叫只读计算属性。只读计算属性总是返回一个值，可以通过点运算符访问，但不能设置新的值。
注意
必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let 关键字只用来声明常量属性，表示初始化后再也无法修改的值。
3. 属性观察器
属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，即使新值和当前值相同的时候也不例外。
你可以为除了延时加载存储属性之外的其他存储属性添加属性观察器，你也可以在子类中通过重写属性的方式为继承的属性（包括存储属性和计算属性）添加属性观察器
可以为属性添加其中一个或两个观察器：
willSet 在新的值被设置之前调用
didSet 在新的值被设置之后调用
willSet 观察器会将新的属性值作为常量参数传入，在 willSet 的实现代码中可以为这个参数指定一个名称，如果不指定则参数仍然可用，这时使用默认名称 newValue 表示。
同样，didSet 观察器会将旧的属性值作为参数传入，可以为该参数指定一个名称或者使用默认参数名 oldValue。如果在 didSet 方法中再次对该属性赋值，那么新值会覆盖旧的值。
在父类初始化方法调用之后，在子类构造器中给父类的属性赋值时，会调用父类属性的 willSet 和 didSet 观察器。而在父类初始化方法调用之前，给子类的属性赋值时不会调用子类属性的观察器。
注意
如果将带有观察器的属性通过 in-out 方式传入函数，willSet 和 didSet 也会调用。这是因为 in-out 参数采用了拷入拷出内存模式：即在函数内部使用的是参数的 copy，函数结束后，又对参数重新赋值。关于 in-out 参数详细的介绍，请参考输入输出参数
4. 全局变量和局部变量
计算属性和观察属性所描述的功能也可以用于全局变量和局部变量。全局变量是在函数、方法、闭包或任何类型之外定义的变量。局部变量是在函数、方法或闭包内部定义的变量。
注意
全局的常量或变量都是延迟计算的，跟延时加载存储属性相似，不同的地方在于，全局的常量或变量不需要标记 lazy 修饰符。
局部范围的常量和变量从不延迟计算。
5. 类型属性
类型属性用于定义某个类型所有实例共享的数据，比如所有实例都能用的一个常量（就像 C 语言中的静态常量），或者所有实例都能访问的一个变量（就像 C 语言中的静态变量）。
存储型类型属性可以是变量或常量，计算型类型属性跟实例的计算型属性一样只能定义成变量属性。
跟实例的存储型属性不同，必须给存储型类型属性指定默认值，因为类型本身没有构造器，也就无法在初始化过程中使用构造器给类型属性赋值。
存储型类型属性是延迟初始化的，它们只有在第一次被访问的时候才会被初始化。即使它们被多个线程同时访问，系统也保证只会对其进行一次初始化，并且不需要对其使用 lazy 修饰符
5.1 类型属性语法
在 C 或 Objective-C 中，与某个类型关联的静态常量和静态变量，是作为 global（全局）静态变量定义的。但是在 Swift 中，类型属性是作为类型定义的一部分写在类型最外层的花括号内，因此它的作用范围也就在类型支持的范围内
使用关键字 static 来定义类型属性。在为类定义计算型类型属性时，可以改用关键字 class 来支持子类对父类的实现进行重写。下面的例子演示了存储型和计算型类型属性的语法
5.2 获取和设置类型属性的值
跟实例属性一样，类型属性也是通过点运算符来访问。但是，类型属性是通过类型本身来访问，而不是通过实例

十 方法
方法是与某些特定类型相关联的函数
结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一。在 Objective-C 中，类是唯一能定义方法的类型。但在 Swift 中，你不仅能选择是否要定义一个类/结构体/枚举，还能灵活地在你创建的类型（类/结构体/枚举）上定义方法。
1. 实例方法
实例方法是属于某个特定类、结构体或者枚举类型实例的方法。实例方法提供访问和修改实例属性的方法或提供与实例目的相关的功能，并以此来支撑实例的功能 
函数参数可以同时有一个局部名称（在函数体内部使用）和一个外部名称（在调用函数时使用），详情参见指定外部参数名。方法参数也一样，因为方法就是函数，只是这个函数与某个类型相关联了。
1.1. self 属性
类型的每一个实例都有一个隐含属性叫做 self，self 完全等同于该实例本身。你可以在一个实例的实例方法中使用这个隐含的 self 属性来引用当前实例
你不必在你的代码里面经常写 self 使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。在这种情况下，参数名称享有优先权，并且在引用属性时必须使用一种更严格的方式。这时你可以使用 self 属性来区分参数名称和属性名称
1.2 在实例方法中修改值类型
结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。
但是，如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择 可变（mutating）行为，然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的 self 属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
// 打印“The point is now at (3.0, 4.0)”
注意，不能在结构体类型的常量（a constant of structure type）上调用可变方法，因为其属性不能被改变，即使属性是变量属性
let fixedPoint = Point(x: 3.0, y: 3.0)
fixedPoint.moveBy(x: 2.0, y: 3.0)
// 这里将会报告一个错误
1.3 在可变方法中给 self 赋值
可变方法能够赋给隐含属性 self 一个全新的实例
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}
枚举的可变方法可以把 self 设置为同一枚举类型中不同的成员：
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight 现在等于 .high
ovenLight.next()
// ovenLight 现在等于 .off
2. 类型方法
实例方法是被某个类型的实例调用的方法
在方法的 func 关键字之前加上关键字 static，来指定类型方法。类还可以用关键字 class 来允许子类重写父类的方法实现。
注意
在 Objective-C 中，你只能为 Objective-C 的类类型（classes）定义类型方法（type-level methods）。在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。每一个类型方法都被它所支持的类型显式包含。
class SomeClass {
    class func someTypeMethod() {
        // 在这里实现类型方法
    }
}
SomeClass.someTypeMethod()

在类型方法的方法体（body）中，self 属性指向这个类型本身，而不是类型的某个实例。

十一 下标
下标可以定义在类、结构体和枚举中，是访问集合、列表或序列中元素的快捷方式
一个类型可以定义多个下标，通过不同索引类型进行重载。下标不限于一维，你可以定义具有多个入参的下标满足自定义类型的需求
1. 下标语法
下标允许你通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行存取
与定义实例方法类似，定义下标使用 subscript 关键字，指定一个或多个输入参数和返回类型；与实例方法不同的是，下标可以设定为读写或只读。这种行为由 getter 和 setter 实现，有点类似计算型属性
subscript(index: Int) -> Int {
    get {
      // 返回一个适当的 Int 类型的值
    }
    set(newValue) {
      // 执行适当的赋值操作
    }
}
2. 下标用法
下标的确切含义取决于使用场景。下标通常作为访问集合，列表或序列中元素的快捷方式。你可以针对自己特定的类或结构体的功能来自由地以最恰当的方式实现下标。
注意
Swift 的 Dictionary 类型的下标接受并返回可选类型的值。上例中的 numberOfLegs 字典通过下标返回的是一个 Int? 或者说“可选的 int”。Dictionary 类型之所以如此实现下标，是因为不是每个键都有个对应的值，同时这也提供了一种通过键删除对应值的方式，只需将键对应的值赋值为 nil 即可。
3. 下标选项
下标可以接受任意数量的入参，并且这些入参可以是任意类型。下标的返回值也可以是任意类型。下标可以使用变量参数和可变参数，但不能使用输入输出参数，也不能给参数设置默认值。

十二 继承
一个类可以继承另一个类的方法，属性和其它特性。当一个类继承其它类时，继承类叫子类，被继承类叫超类（或父类）。在 Swift 中，继承是区分「类」与其它类型的一个基本特征
1. 不继承于其它类的类，称之为基类。
注意
Swift 中的类并不是从一个通用的基类继承而来的。如果你不为自己定义的类指定一个超类的话，这个类就会自动成为基类。
2. 子类生成
子类生成指的是在一个已有类的基础上创建一个新的类。子类继承超类的特性，并且可以进一步完善。你还可以为子类添加新的特性
class SomeClass: SomeSuperclass {
    // 这里是子类的定义
}
3. 重写
子类可以为继承来的实例方法，类方法，实例属性，类属性，或下标提供自己定制的实现。我们把这种行为叫重写
如果要重写某个特性，你需要在重写定义的前面加上 override 关键字。这么做，就表明了你是想提供一个重写版本，而非错误地提供了一个相同的定义。意外的重写行为可能会导致不可预知的错误，任何缺少 override 关键字的重写都会在编译时被认定为错误
override 关键字会提醒 Swift 编译器去检查该类的超类（或其中一个父类）是否有匹配重写版本的声明。这个检查可以确保你的重写定义是正确的
3.1 访问超类的方法，属性及下标
在合适的地方，你可以通过使用 super 前缀来访问超类版本的方法，属性或下标：
在方法 someMethod() 的重写实现中，可以通过 super.someMethod() 来调用超类版本的 someMethod() 方法。
在属性 someProperty 的 getter 或 setter 的重写实现中，可以通过 super.someProperty 来访问超类版本的 someProperty 属性。
在下标的重写实现中，可以通过 super[someIndex] 来访问超类版本中的相同下标。
3.2 重写方法
在子类中，你可以重写继承来的实例方法或类方法，提供一个定制或替代的方法实现
3.3 重写属性
可以重写继承来的实例属性或类型属性，提供自己定制的 getter 和 setter，或添加属性观察器，使重写的属性可以观察到底层的属性值什么时候发生改变。
3.3.1 重写属性的 Getters 和 Setters
子类并不知道继承来的属性是存储型的还是计算型的，它只知道继承来的属性会有一个名字和类型。你在重写一个属性时，必须将它的名字和类型都写出来。这样才能使编译器去检查你重写的属性是与超类中同名同类型的属性相匹配的
重写属性观察器
3.3.2 重写属性观察器
你可以通过重写属性为一个继承来的属性添加属性观察器。这样一来，无论被继承属性原本是如何实现的，当其属性值发生改变时，你就会被通知到
注意
你不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。这些属性的值是不可以被设置的，所以，为它们提供 willSet 或 didSet 实现也是不恰当。 此外还要注意，你不可以同时提供重写的 setter 和重写的属性观察器。如果你想观察属性值的变化，并且你已经为那个属性提供了定制的 setter，那么你在 setter 中就可以观察到任何值变化了
4. 防止重写  https://swifter.tips/final/
可以通过把方法，属性或下标标记为 final 来防止它们被重写，只需要在声明关键字前加上 final 修饰符即可（例如：final var、final func、final class func 以及 final subscript）。
通过在关键字 class 前添加 final 修饰符（final class）来将整个类标记为 final 。这样的类是不可被继承的，试图继承这样的类会导致编译报错

十三 构造过程
构造过程是使用类、结构体或枚举类型的实例之前的准备过程。在新实例使用前有个过程是必须的，它包括设置实例中每个存储属性的初始值和执行其他必须的设置或构造过程
你要通过定义构造器来实现构造过程，它就像用来创建特定类型新实例的特殊方法。与 Objective-C 中的构造器不同，Swift 的构造器没有返回值。它们的主要任务是保证某种类型的新实例在第一次使用前完成正确的初始化
1. 存储属性的初始赋值
类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态
注意
当你为存储型属性分配默认值或者在构造器中为设置初始值时，它们的值是被直接设置的，不会触发任何属性观察者。
1.1 构造器
可以在构造器中为存储型属性设置初始值
构造器在创建某个特定类型的新实例时被调用。它的最简形式类似于一个不带任何形参的实例方法，以关键字 init 命名：
init() {
    // 在此处执行构造过程
}
1.2 默认属性值
也可以在属性声明时为其设置默认值
2. 自定义构造过程
可以通过输入形参和可选属性类型来自定义构造过程，也可以在构造过程中分配常量属性
2.1 形参的构造过程
下面例子中定义了一个用来保存摄氏温度的结构体 Celsius。它定义了两个不同的构造器：init(fromFahrenheit:) 和 init(fromKelvin:)，二者分别通过接受不同温标下的温度值来创建新的实例：
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius 是 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// freezingPointOfWater.temperatureInCelsius 是 0.0
第一个构造器拥有一个构造形参，其实参标签为 fromFahrenheit，形参命名为 fahrenheit；第二个构造器也拥有一个构造形参，其实参标签为 fromKelvin，形参命名为 kelvin。这两个构造器都将单一的实参转换成摄氏温度值，并保存在属性 temperatureInCelsius 中
2.2 形参命名和实参标签
跟函数和方法形参相同，构造形参可以同时使用在构造器里使用的形参命名和一个外部调用构造器时使用的实参标签,然而，构造器并不像函数和方法那样在括号前有一个可辨别的方法名。因此在调用构造器时，主要通过构造器中形参命名和类型来确定应该被调用的构造器
然而，构造器并不像函数和方法那样在括号前有一个可辨别的方法名。因此在调用构造器时，主要通过构造器中形参命名和类型来确定应该被调用的构造器。正因如此，如果你在定义构造器时没有提供实参标签，Swift 会为构造器的每个形参自动生成一个实参标签。
以下例子中定义了一个结构体 Color，它包含了三个常量：red、green 和 blue。这些属性可以存储 0.0 到 1.0 之间的值，用来表明颜色中红、绿、蓝成分的含量。
Color 提供了一个构造器，为红蓝绿提供三个合适 Double 类型的形参命名。Color 也提供了第二个构造器，它只包含名为 white 的 Double 类型的形参，它为三个颜色的属性提供相同的值。
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}
两种构造器都能通过为每一个构造器形参提供命名值来创建一个新的 Color 实例：
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
注意，如果不通过实参标签传值，这个构造器是没法调用的。如果构造器定义了某个实参标签，就必须使用它，忽略它将导致编译期错误：
let veryGreen = Color(0.0, 1.0, 0.0)
2.3 不带实参标签的构造器形参
如果你不希望构造器的某个形参使用实参标签，可以使用下划线（_）来代替显式的实参标签来重写默认行为
2.4 可选属性类型
如果你自定义的类型有一个逻辑上允许值为空的存储型属性——无论是因为它无法在初始化时赋值，还是因为它在之后某个时机可以赋值为空——都需要将它声明为 可选类型。可选类型的属性将自动初始化为 nil，表示这个属性是特意在构造过程设置为空
2.5 构造过程中常量属性的赋值
你可以在构造过程中的任意时间点给常量属性赋值，只要在构造过程结束时它设置成确定的值。一旦常量属性被赋值，它将永远不可更改。
注意
对于类的实例来说，它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改。
你可以修改上面的 SurveyQuestion 示例，用常量属性替代变量属性 text，表示问题内容 text 在 SurveyQuestion 的实例被创建之后不会再被修改。尽管 text 属性现在是常量，我们仍然可以在类的构造器中设置它的值：
class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
// 打印“How about beets?”
beetsQuestion.response = "I also like beets. (But not with cheese.)"
2.6 默认构造器
如果结构体或类为所有属性提供了默认值，又没有提供任何自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器。这个默认构造器将简单地创建一个所有属性值都设置为它们默认值的实例
2.7 结构体的逐一成员构造器
结构体如果没有定义任何自定义构造器，它们将自动获得一个逐一成员构造器（memberwise initializer）。不像默认构造器，即使存储型属性没有默认值，结构体也能会获得逐一成员构造器。
逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法。新实例的属性初始值可以通过名字传入逐一成员构造器中
下面例子中定义了一个结构体 Size，它包含两个属性 width 和 height。根据这两个属性默认赋值为 0.0 ，它们的类型被推断出来为 Double。
结构体 Size 自动获得了一个逐一成员构造器 init(width:height:)。你可以用它来创建新的 Size 实例：
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0
2.8 值类型的构造器代理
构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能避免多个构造器间的代码重复。
构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型（结构体和枚举类型）不支持继承，所以构造器代理的过程相对简单，因为它们只能代理给自己的其它构造器。类则不同，它可以继承自其它类（请参考继承）。这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化
对于值类型，你可以使用 self.init 在自定义的构造器中引用相同类型中的其它构造器。并且你只能在构造器内部调用 self.init。
请注意，如果你为某个值类型定义了一个自定义的构造器，你将无法访问到默认构造器（如果是结构体，还将无法访问逐一成员构造器）。这种限制避免了在一个更复杂的构造器中做了额外的重要设置，但有人不小心使用自动生成的构造器而导致错误的情况。
注意
假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器写到扩展（extension）中，而不是写在值类型的原始定义中
3. 类的继承和构造过程
类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值
3.1 指定构造器和便利构造器
指定构造器是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并调用合适的父类构造器让构造过程沿着父类链继续往上进行。
类倾向于拥有极少的指定构造器，普遍的是一个类只拥有一个指定构造器,每一个类都必须至少拥有一个指定构造器
便利构造器是类中比较次要的、辅助型的构造器
你可以定义便利构造器来调用同一个类中的指定构造器，并为部分形参提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入值的实例。
3.2 指定构造器和便利构造器的语法
类的指定构造器的写法跟值类型简单构造器一样：
init(parameters) {
    statements
}

便利构造器也采用相同样式的写法，但需要在 init 关键字之前放置 convenience 关键字，并使用空格将它们俩分开：
convenience init(parameters) {
    statements
}

3.3 类类型的构造器代理
为了简化指定构造器和便利构造器之间的调用关系，Swift 构造器之间的代理调用遵循以下三条规则：
规则 1
    指定构造器必须调用其直接父类的的指定构造器。
规则 2
    便利构造器必须调用同类中定义的其它构造器。
规则 3
    便利构造器最后必须调用指定构造器。
一个更方便记忆的方法是：
指定构造器必须总是向上代理
便利构造器必须总是横向代理
注意
这些规则不会影响类的实例如何创建。任何上图中展示的构造器都可以用来创建完全初始化的实例。这些规则只影响类的构造器如何实现。
3.4 两段式构造过程
Swift 中类的构造过程包含两个阶段。第一个阶段，类中的每个存储型属性赋一个初始值。当每个存储型属性的初始值被赋值后，第二阶段开始，它给每个类一次机会，在新实例准备使用之前进一步自定义它们的存储型属性。
两段式构造过程的使用让构造过程更安全，同时在整个类层级结构中给予了每个类完全的灵活性。两段式构造过程可以防止属性值在初始化之前被访问，也可以防止属性被另外一个构造器意外地赋予不同的值。
注意
Swift 的两段式构造过程跟 Objective-C 中的构造过程类似。最主要的区别在于阶段 1，Objective-C 给每一个属性赋值 0 或空值（比如说 0 或 nil）。Swift 的构造流程则更加灵活，它允许你设置定制的初始值，并自如应对某些属性不能以 0 或 nil 作为合法默认值的情况。
Swift 编译器将执行 4 种有效的安全检查，以确保两段式构造过程不出错地完成：
安全检查 1
    指定构造器必须保证它所在类的所有属性都必须先初始化完成，之后才能将其它构造任务向上代理给父类中的构造器。
如上所述，一个对象的内存只有在其所有存储型属性确定之后才能完全初始化。为了满足这一规则，指定构造器必须保证它所在类的属性在它往上代理之前先完成初始化。
安全检查 2
    指定构造器必须在为继承的属性设置新值之前向上代理调用父类构造器。如果没这么做，指定构造器赋予的新值将被父类中的构造器所覆盖。
安全检查 3
    便利构造器必须为任意属性（包括所有同类中定义的）赋新值之前代理调用其它构造器。如果没这么做，便利构造器赋予的新值将被该类的指定构造器所覆盖。
安全检查 4
    构造器在第一阶段构造完成之前，不能调用任何实例方法，不能读取任何实例属性的值，不能引用 self 作为一个值。
类的实例在第一阶段结束以前并不是完全有效的。只有第一阶段完成后，类的实例才是有效的，才能访问属性和调用方法。
以下是基于上述安全检查的两段式构造过程展示：
阶段 1
类的某个指定构造器或便利构造器被调用。
完成类的新实例内存的分配，但此时内存还没有被初始化。
指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化。
指定构造器切换到父类的构造器，对其存储属性完成相同的任务。
这个过程沿着类的继承链一直往上执行，直到到达继承链的最顶部。
当到达了继承链最顶部，而且继承链的最后一个类已确保所有的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段 1 完成。
阶段 2
从继承链顶部往下，继承链中每个类的指定构造器都有机会进一步自定义实例。构造器此时可以访问 self、修改它的属性并调用实例方法等等。
最终，继承链中任意的便利构造器有机会自定义实例和使用 self。
3.5 构造器的继承和重写
跟 Objective-C 中的子类不同，Swift 中的子类默认情况下不会继承父类的构造器。Swift 的这种机制可以防止一个父类的简单构造器被一个更精细的子类继承，而在用来创建子类时的新实例时没有完全或错误被初始化。
当你在编写一个和父类中指定构造器相匹配的子类构造器时，你实际上是在重写父类的这个指定构造器。因此，你必须在定义子类构造器时带上 override 修饰符。即使你重写的是系统自动提供的默认构造器，也需要带上 override 修饰符
正如重写属性，方法或者是下标，override 修饰符会让编译器去检查父类中是否有相匹配的指定构造器，并验证构造器参数是否被按预想中被指定
4. 可失败构造器
定义一个构造器可失败的类，结构体或者枚举是很有用的。这里所指的“失败” 指的是，如给构造器传入无效的形参，或缺少某种所需的外部资源，又或是不满足某种必要的条件等
为了妥善处理这种构造过程中可能会失败的情况。你可以在一个类，结构体或是枚举类型的定义中，添加一个或多个可失败构造器。其语法为在 init 关键字后面添加问号（init?）。
注意
可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其参数类型相同。
4.1 枚举类型的可失败构造器
可以通过一个带一个或多个形参的可失败构造器来获取枚举类型中特定的枚举成员。如果提供的形参无法匹配任何枚举成员，则构造失败
4.2 带原始值的枚举类型的可失败构造器
带原始值的枚举类型会自带一个可失败构造器 init?(rawValue:)，该可失败构造器有一个合适的原始值类型的 rawValue 形参，选择找到的相匹配的枚举成员，找不到则构造失败
4.3 构造失败的传递
类、结构体、枚举的可失败构造器可以横向代理到它们自己其他的可失败构造器。类似的，子类的可失败构造器也能向上代理到父类的可失败构造器
4.4 重写一个可失败构造器
如同其它的构造器，你可以在子类中重写父类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个父类的可失败构造器。这使你可以定义一个不会构造失败的子类，即使父类的构造器允许构造失败。
注意，当你用子类的非可失败构造器重写父类的可失败构造器时，向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包。
注意
你可以用非可失败构造器重写可失败构造器，但反过来却不行。
5. 必要构造器
在类的构造器前添加 required 修饰符表明所有该类的子类都必须实现该构造器
class SomeClass {
    required init() {
        // 构造器的实现代码
    }
}
在子类重写父类的必要构造器时，必须在子类的构造器前也添加 required 修饰符，表明该构造器要求也应用于继承链后面的子类。在重写父类中必要的指定构造器时，不需要添加 override 修饰符
class SomeSubclass: SomeClass {
    required init() {
        // 构造器的实现代码
    }
}
6. 通过闭包或函数设置属性的默认值
如果某个存储型属性的默认值需要一些自定义或设置，你可以使用闭包或全局函数为其提供定制的默认值。每当某个属性所在类型的新实例被构造时，对应的闭包或函数会被调用，而它们的返回值会当做默认值赋值给这个属性
class SomeClass {
    let someProperty: SomeType = {
        // 在这个闭包中给 someProperty 创建一个默认值
        // someValue 必须和 SomeType 类型相同
        return someValue
    }()
}

十四 析构过程
析构器只适用于类类型，当一个类的实例被释放之前，析构器会被立即调用。析构器用关键字 deinit 来标示，类似于构造器要用 init 来标示
1. 析构过程原理
Swift 会自动释放不再需要的实例以释放资源。如自动引用计数章节中所讲述，Swift 通过自动引用计数（ARC) 处理实例的内存管理。通常当你的实例被释放时不需要手动地去清理
在类的定义中，每个类最多只能有一个析构器，而且析构器不带任何参数和圆括号，如下所示：
deinit {
    // 执行析构过程
}
析构器是在实例释放发生前被自动调用的。你不能主动调用析构器。子类继承了父类的析构器，并且在子类析构器实现的最后，父类的析构器会被自动调用。即使子类没有提供自己的析构器，父类的析构器也同样会被调用

十五 可选链
可选链式调用是一种可以在当前值可能为 nil 的可选值上请求和调用属性、方法及下标的方法。如果可选值有值，那么调用就会成功；如果可选值是 nil，那么调用将返回 nil。
注意
Swift 的可选链式调用和 Objective-C 中向 nil 发送消息有些相像，但是 Swift 的可选链式调用可以应用于任意类型，并且能检查调用是否成功。

1. 使用可选链式调用代替强制展开
通过在想调用的属性、方法，或下标的可选值后面放一个问号（?），可以定义一个可选链。这一点很像在可选值后面放一个叹号（!）来强制展开它的值。它们的主要区别在于当可选值为空时可选链式调用只会调用失败，然而强制展开将会触发运行时错误。
里需要特别指出，可选链式调用的返回结果与原本的返回结果具有相同的类型，但是被包装成了一个可选值。例如，使用可选链式调用访问属性，当可选链式调用成功时，如果属性原本的返回结果是 Int 类型，则会变为 Int? 类型。
2. 为可选链式调用定义模型类
通过使用可选链式调用可以调用多层属性、方法和下标,这样可以在复杂的模型中向下访问各种子属性，并且判断能否访问子属性的属性、方法和下标。
3. 通过可选链式调用访问属性
正如使用可选链式调用代替强制展开中所述，可以通过可选链式调用在一个可选值上访问它的属性，并判断访问是否成功
4. 通过可选链式调用来调用方法
可以通过可选链式调用来调用方法，并判断是否调用成功，即使这个方法没有返回值。
在可选值上通过可选链式调用来调用这个方法，该方法的返回类型会是 Void?，而不是 Void，因为通过可选链式调用得到的返回值都是可选的。
5. 通过可选链式调用访问下标
通过可选链式调用，我们可以在一个可选值上访问下标，并且判断下标调用是否成功
5.1 访问可选类型的下标
如果下标返回可选类型值，比如 Swift 中 Dictionary 类型的键的下标，可以在下标的结尾括号后面放一个问号来在其可选返回值上进行可选链式调用
6. 连接多层可选链式调用
可以通过连接多个可选链式调用在更深的模型层级中访问属性、方法以及下标。然而，多层可选链式调用不会增加返回值的可选层级。
如果你访问的值不是可选的，可选链式调用将会返回可选值。
如果你访问的值就是可选的，可选链式调用不会让可选返回值变得“更可选”。
因此：
通过可选链式调用访问一个 Int 值，将会返回 Int?，无论使用了多少层可选链式调用。
类似的，通过可选链式调用访问 Int? 值，依旧会返回 Int? 值，并不会返回 Int??。
7. 在方法的可选返回值上进行可选链式调用
上面的例子展示了如何在一个可选值上通过可选链式调用来获取它的属性值。我们还可以在一个可选值上通过可选链式调用来调用方法，并且可以根据需要继续在方法的可选返回值上进行可选链式调用

十六 错误处理
错误处理（Error handling） 是响应错误以及从错误中恢复的过程。Swift 在运行时提供了抛出、捕获、传递和操作可恢复错误（recoverable errors）的一等支持（first-class support）。
1. 表示与抛出错误
在 Swift 中，错误用遵循 Error 协议的类型的值来表示。这个空协议表明该类型可以用于错误处理。
Swift 的枚举类型尤为适合构建一组相关的错误状态，枚举的关联值还可以提供错误状态的额外信息。例如，在游戏中操作自动贩卖机时，你可以这样表示可能会出现的错误状态：
enum VendingMachineError: Error {
    case invalidSelection                     //选择无效
    case insufficientFunds(coinsNeeded: Int) //金额不足
    case outOfStock                             //缺货
}
抛出一个错误可以让你表明有意外情况发生，导致正常的执行流程无法继续执行。抛出错误使用 throw 语句。例如，下面的代码抛出一个错误，提示贩卖机还需要 5 个硬币：
throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
2. 处理错误
某个错误被抛出时，附近的某部分代码必须负责处理这个错误，例如纠正这个问题、尝试另外一种方式、或是向用户报告错误。
Swift 中有 4 种处理错误的方式。你可以把函数抛出的错误传递给调用此函数的代码、用 do-catch 语句处理错误、将错误作为可选类型处理、或者断言此错误根本不会发生
2.1 用 throwing 函数传递错误
为了表示一个函数、方法或构造器可以抛出错误，在函数声明的参数之后加上 throws 关键字。一个标有 throws 关键字的函数被称作 throwing 函数。
如果这个函数指明了返回值类型，throws 关键词需要写在返回箭头（->）的前面。
func canThrowErrors() throws -> String

func cannotThrowErrors() -> String
2.2 用 Do-Catch 处理错误
你可以使用一个 do-catch 语句运行一段闭包代码来处理错误。如果在 do 子句中的代码抛出了一个错误，这个错误会与 catch 子句做匹配，从而决定哪条子句能处理它。
下面是 do-catch 语句的一般形式：
do {
    try expression
    statements
} catch pattern 1 {
    statements
} catch pattern 2 where condition {
    statements
} catch {
    statements
}
2.3 将错误转换成可选值
可以使用 try? 通过将错误转换成一个可选值来处理错误。如果是在计算 try? 表达式时抛出错误，该表达式的结果就为 nil
2.4 禁用错误传递
有时你知道某个 throwing 函数实际上在运行时是不会抛出错误的，在这种情况下，你可以在表达式前面写 try! 来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言中。如果真的抛出了错误，你会得到一个运行时错误
3. 指定清理操作
你可以使用 defer 语句在即将离开当前代码块时执行一系列语句。该语句让你能执行一些必要的清理工作，不管是以何种方式离开当前代码块的——无论是由于抛出错误而离开，或是由于诸如 return、break 的语句

十七
类型转换
类型转换可以判断实例的类型，也可以将实例看做是其父类或者子类的实例
类型转换在 Swift 中使用 is 和 as 操作符实现。这两个操作符分别提供了一种简单达意的方式去检查值的类型或者转换它的类型。
1. 为类型转换定义类层次
可以将类型转换用在类和子类的层次结构上，检查特定类实例的类型并且转换这个类实例的类型成为这个层次结构中的其他类型
2. 检查类型
用类型检查操作符（is）来检查一个实例是否属于特定子类型。若实例属于那个子类型，类型检查操作符返回 true，否则返回 false
3. 向下转型
条件形式 as? 返回一个你试图向下转成的类型的可选值。强制形式 as! 把试图向下转型和强制解包转换结果结合为一个操作。
当你不确定向下转型可以成功时，用类型转换的条件形式（as?）。条件形式的类型转换总是返回一个可选值，并且若下转是不可能的，可选值将是 nil。这使你能够检查向下转型是否成功。
只有你可以确定向下转型一定会成功时，才使用强制形式（as!）。当你试图向下转型为一个不正确的类型时，强制形式的类型转换会触发一个运行时错误。
if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    }
“尝试将 item 转为 Movie 类型。若成功，设置一个新的临时常量 movie 来存储返回的可选 Movie 中的值”
4. Any 和 AnyObject 的类型转换
Swift 为不确定类型提供了两种特殊的类型别名：
Any 可以表示任何类型，包括函数类型。
AnyObject 可以表示任何类类型的实例。
只有当你确实需要它们的行为和功能时才使用 Any 和 AnyObject。最好还是在代码中指明需要使用的类型

Any 类型可以表示所有类型的值，包括可选类型。Swift 会在你用 Any 类型来表示一个可选值的时候，给你一个警告。如果你确实想使用 Any 类型来承载可选值，你可以使用 as 操作符显式转换为 Any，如下所示：
let optionalNumber: Int? = 3
things.append(optionalNumber)        // 警告
things.append(optionalNumber as Any) // 没有警告

十八 嵌套类型
枚举常被用于为特定类或结构体实现某些功能。类似地，枚举可以方便的定义工具类或结构体，从而为某个复杂的类型所使用。为了实现这种功能，Swift 允许你定义嵌套类型，可以在支持的类型中定义嵌套的枚举、类和结构体
要在一个类型中嵌套另一个类型，将嵌套类型的定义写在其外部类型的 {} 内，而且可以根据需要定义多级嵌套

十九 扩展

扩展可以给一个现有的类，结构体，枚举，还有协议添加新的功能。它还拥有不需要访问被扩展类型源代码就能完成扩展的能力（即逆向建模）
Swift 中的扩展可以：
添加计算型实例属性和计算型类属性
定义实例方法和类方法
提供新的构造器
定义下标
定义和使用新的嵌套类型
使已经存在的类型遵循（conform）一个协议

1. 扩展的语法
使用 extension 关键字声明扩展：
extension SomeType {
  // 在这里给 SomeType 添加新的功能
}
扩展可以扩充一个现有的类型，给它添加一个或多个协议。协议名称的写法和类或者结构体一样：
extension SomeType: SomeProtocol, AnotherProtocol {
  // 协议所需要的实现写在这里
}
这种遵循协议的方式在 使用扩展遵循协议 中有描述。
扩展可以使用在现有范型类型上，就像 扩展范型类型 中描述的一样。你还可以使用扩展给泛型类型有条件的添加功能，就像 扩展一个带有 Where 字句的范型 中描述的一样。
注意
对一个现有的类型，如果你定义了一个扩展来添加新的功能，那么这个类型的所有实例都可以使用这个新功能，包括那些在扩展定义之前就存在的实例。
2. 计算型属性
扩展可以给现有类型添加计算型实例属性和计算型类属性。
3. 构造器
扩展可以给现有的类型添加新的构造器。它使你可以把自定义类型作为参数来供其他类型的构造器使用，或者在类型的原始实现上添加额外的构造选项。
扩展可以给一个类添加新的便利构造器，但是它们不能给类添加新的指定构造器或者析构器。指定构造器和析构器必须始终由类的原始实现提供。
注意
如果你通过扩展提供一个新的构造器，你有责任确保每个通过该构造器创建的实例都是初始化完整的。
4. 方法
5. 可变实例方法
通过扩展添加的实例方法同样也可以修改（或 mutating（改变））实例本身。结构体和枚举的方法，若是可以修改 self 或者它自己的属性，则必须将这个实例方法标记为 mutating，就像是改变了方法的原始实现。
6. 下标
7. 嵌套类型

二十 协议
协议 定义了一个蓝图，规定了用来实现某一特定任务或者功能的方法、属性，以及其他需要的东西。类、结构体或枚举都可以遵循协议，并为协议定义的这些要求提供具体实现
1. 协议语法
协议的定义方式与类、结构体和枚举的定义非常相似：
protocol SomeProtocol {
    // 这里是协议的定义部分
}
要让自定义类型遵循某个协议，在定义类型时，需要在类型名称后加上协议名称，中间以冒号（:）分隔。遵循多个协议时，各协议之间用逗号（,）分隔：
struct SomeStructure: FirstProtocol, AnotherProtocol {
    // 这里是结构体的定义部分
}
若一个拥有父类的类在遵循协议时，应该将父类名放在协议名之前，以逗号分隔：
class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
    // 这里是类的定义部分
}
2. 属性要求
协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性。协议不指定属性是存储属性还是计算属性，它只指定属性的名称和类型。此外，协议还指定属性是可读的还是可读可写的
协议总是用 var 关键字来声明变量属性，在类型声明后加上 { set get } 来表示属性是可读可写的，可读属性则用 { get } 来表示：
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

在协议中定义类型属性时，总是使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性：
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}
3. 方法要求
协议可以要求遵循协议的类型实现某些指定的实例方法或类方法。这些方法作为协议的一部分，像普通方法一样放在协议的定义中，但是不需要大括号和方法体。可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同
4. 异变方法要求
如果你在协议中定义了一个实例方法，该方法会改变遵循该协议的类型的实例，那么在定义协议时需要在方法前加 mutating 关键字。这使得结构体和枚举能够遵循此协议并满足此方法要求。
注意
实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating 关键字。
5. 构造器要求
协议可以要求遵循协议的类型实现指定的构造器。
protocol SomeProtocol {
    init(someParameter: Int)
}
5.1 协议构造器要求的类实现
你可以在遵循协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器。无论哪种情况，你都必须为构造器实现标上 required 修饰符：
class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        // 这里是构造器的实现部分
    }
}
使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能符合协议。
关于 required 构造器的更多内容，请参考 必要构造器。
注意
如果类已经被标记为 final，那么不需要在协议构造器的实现中使用 required 修饰符，因为 final 类不能有子类。关于 final 修饰符的更多内容，请参见 防止重写。
如果一个子类重写了父类的指定构造器，并且该构造器满足了某个协议的要求，那么该构造器的实现需要同时标注 required 和 override 修饰符：
protocol SomeProtocol {
    init()
}

class SomeSuperClass {
    init() {
        // 这里是构造器的实现部分
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
    // 因为遵循协议，需要加上 required
    // 因为继承自父类，需要加上 override
    required override init() {
        // 这里是构造器的实现部分
    }
}
5.2 可失败构造器要求
6. 协议作为类型
尽管协议本身并未实现任何功能，但是协议可以被当做一个功能完备的类型来使用。
协议可以像其他普通类型一样使用，使用场景如下：
作为函数、方法或构造器中的参数类型或返回值类型
作为常量、变量或属性的类型
作为数组、字典或其他容器中的元素类型
注意
协议是一种类型，因此协议类型的名称应与其他类型（例如 Int，Double，String）的写法相同，使用大写字母开头的驼峰式写法，例如（FullyNamed 和 RandomNumberGenerator）。

下面是将协议作为类型使用的例子：
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
generator 属性的类型为 RandomNumberGenerator，因此任何遵循了 RandomNumberGenerator 协议的类型的实例都可以赋值给 generator，除此之外并无其他要求。
Dice 类还有一个构造器，用来设置初始状态。构造器有一个名为 generator，类型为 RandomNumberGenerator 的形参。在调用构造方法创建 Dice 的实例时，可以传入任何遵循 RandomNumberGenerator 协议的实例给 generator。
7. 委托
委托是一种设计模式，它允许类或结构体将一些需要它们负责的功能委托给其他类型的实例。委托模式的实现很简单：定义协议来封装那些需要被委托的功能，这样就能确保遵循协议的类型能提供这些功能。委托模式可以用来响应特定的动作，或者接收外部数据源提供的数据，而无需关心外部数据源的类型。
为了防止强引用导致的循环引用问题，可以把协议声明为弱引用
8. 在扩展里添加协议遵循
即便无法修改源代码，依然可以通过扩展令已有类型遵循并符合协议
注意
通过扩展令已有类型遵循并符合协议时，该类型的所有实例也会随之获得协议中定义的各项功能。
通过扩展遵循并采纳协议，和在原始定义中遵循并符合协议的效果完全相同。协议名称写在类型名之后，以冒号隔开，然后在扩展的大括号内实现协议要求的内容
9. 有条件地遵循协议
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
let myDice = [d6, d12]
print(myDice.textualDescription)
下面的扩展让 Array 类型只要在存储遵循 TextRepresentable 协议的元素时就遵循 TextRepresentable 协议。
10. 在扩展里声明采纳协议
当一个类型已经符合了某个协议中的所有要求，却还没有声明采纳该协议时，可以通过空的扩展来让它采纳该协议：
struct Hamster {
    var name: String
       var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}
注意
即使满足了协议的所有要求，类型也不会自动遵循协议，必须显式地遵循协议。
11. 协议类型的集合
协议类型可以在数组或者字典这样的集合中使用，在 协议类型 提到了这样的用法
12. 协议的继承
协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔：
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // 这里是协议的定义部分
}
13. 类专属的协议
你通过添加 AnyObject 关键字到协议的继承列表，就可以限制协议只能被类类型采纳（以及非结构体或者非枚举的类型）。
protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
    // 这里是类专属协议的定义部分
}
14. 协议合成
要求一个类型同时遵循多个协议是很有用的。你可以使用协议组合来复合多个协议到一个要求里。协议组合行为就和你定义的临时局部协议一样拥有构成中所有协议的需求。协议组合不定义任何新的协议类型。
协议组合使用 SomeProtocol & AnotherProtocol 的形式
class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}
函数接受一个类型为 Location & Named 的参数，这意味着“任何 Location 的子类，并且遵循 Named 协议”
15. 检查协议一致性
可以使用类型转换中描述的 is 和 as 操作符来检查协议一致性，即是否符合某协议，并且可以转换到指定的协议类型。检查和转换协议的语法与检查和转换类型是完全一样的
is 用来检查实例是否符合某个协议，若符合则返回 true，否则返回 false；
as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil；
as! 将实例强制向下转换到某个协议类型，如果强转失败，将触发运行时错误。

16. 可选的协议要求
协议可以定义可选要求，遵循协议的类型可以选择是否实现这些要求。在协议中使用 optional 关键字作为前缀来定义可选要求
可选要求用在你需要和 Objective-C 打交道的代码中。协议和可选要求都必须带上 @objc 属性。标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举均不能遵循这种协议。
17. 协议扩展
协议可以通过扩展来为遵循协议的类型提供属性、方法以及下标的实现。通过这种方式，你可以基于协议本身来实现这些功能，而无需在每个遵循协议的类型中都重复同样的实现，也无需使用全局函数。
17.1 提供默认实现
可以通过协议扩展来为协议要求的属性、方法以及下标提供默认的实现
17.2 为协议扩展添加限制条件
在扩展协议的时候，可以指定一些限制条件，只有遵循协议的类型满足这些限制条件时，才能获得协议扩展提供的默认实现


二十一 泛型
泛型代码让你能根据自定义的需求，编写出适用于任意类型的、灵活可复用的函数及类型。你可避免编写重复的代码，用一种清晰抽象的方式来表达代码的意图
1. 泛型解决的问题
通常需要一个更实用更灵活的函数来交换两个任意类型的值，幸运的是，泛型代码帮你解决了这种问题。
2. 泛型函数
泛型版本的函数使用占位符类型名（这里叫做 T ），而不是 实际类型名（例如 Int、String 或 Double），占位符类型名并不关心 T 具体的类型，但它要求 a 和b 必须是相同的类型，T 的实际类型由每次调用 swapTwoValues(_:_:) 来决定。
泛型函数和非泛型函数的另外一个不同之处在于这个泛型函数名（swapTwoValues(_:_:)）后面跟着占位类型名（T），并用尖括号括起来（<T>）。这个尖括号告诉 Swift 那个 T 是 swapTwoValues(_:_:) 函数定义内的一个占位类型名，因此 Swift 不会去查找名为 T的实际类型
3. 类型参数
占位类型 T 是一个类型参数的例子，类型参数指定并命名一个占位类型，并且紧随在函数名后面，使用一对尖括号括起来（例如 <T>)
你可提供多个类型参数，将它们都写在尖括号中，用逗号分开。
4. 命名类型参数
类型参数具有描述下的名称，例如字典 Dictionary<Key, Value> 中的 Key 和 Value 及数组 Array<Element> 中的 Element，这能告诉阅读代码的人这些参数类型与泛型类型或函数之间的关系
5. 泛型类型
除了泛型函数，Swift 还允许自定义泛型类型。这些自定义类、结构体和枚举可以适用于任意类型，类似于 Array 和 Dictionary
6.泛型扩展
当对泛型类型进行扩展时，你并不需要提供类型参数列表作为定义的一部分。原始类型定义中声明的类型参数列表在扩展中可以直接使用，并且这些来自原始类型中的参数名称会被用作原始定义中类型参数的引用
7.类型约束
如果能对泛型函数或泛型类型中添加特定的类型约束，这将在某些情况下非常有用。类型约束指定类型参数必须继承自指定类、遵循特定的协议或协议组合。
例如，Swift 的 Dictionary 类型对字典的键的类型做了些限制。在 字典的描述 中，字典键的类型必须是可哈希（hashable）的。也就是说，必须有一种方法能够唯一地表示它。字典键之所以要是可哈希的，是为了便于检查字典中是否已经包含某个特定键的值。若没有这个要求，字典将无法判断是否可以插入或替换某个指定键的值，也不能查找到已经存储在字典中的指定键的值。
8.类型约束语法
在一个类型参数名后面放置一个类名或者协议名，并用冒号进行分隔，来定义类型约束。下面将展示泛型函数约束的基本语法（与泛型类型的语法相同）：
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // 这里是泛型函数的函数体部分
}
9. 关联类型
定义一个协议时，声明一个或多个关联类型作为协议定义的一部分将会非常有用。关联类型为协议中的某个类型提供了一个占位符名称，其代表的实际类型在协议被遵循时才会被指定。关联类型通过 associatedtype 关键字来指定
struct IntStack: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // Container 协议的实现部分
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]

IntStack 在实现 Container 的要求时，指定 Item 为 Int 类型，即 typealias Item = Int，从而将 Container 协议中抽象的 Item 类型转换为具体的 Int 类型。
10.扩展现有类型来指定关联类型
在扩展添加协议一致性中描述了如何利用扩展让一个已存在的类型符合一个协议，这包括使用了关联类型协议。
Swift 的 Array 类型已经提供 append(_:) 方法，count 属性，以及带有 Int 索引的下标来检索其元素。这三个功能都符合 Container 协议的要求，也就意味着你只需声明 Array 遵循Container 协议，就可以扩展 Array，使其遵从 Container 协议。你可以通过一个空扩展来实现这点，正如通过扩展采纳协议中的描述：
extension Array: Container {}
11. 给关联类型添加约束
可以在协议里给关联类型添加约束来要求遵循的类型满足约束。例如，下面的代码定义了 Container 协议， 要求关联类型 Item 必须遵循 Equatable 协议：
protocol Container {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
12. 在关联类型约束里使用协议
13.泛型 Where 语句
类型约束让你能够为泛型函数、下标、类型的类型参数定义一些强制要求。
14. 具有泛型 Where 子句的扩展
可以使用泛型 where 子句作为扩展的一部分
15 具有泛型 Where 子句的关联类型
具有泛型 Where 子句的关联类型
你可以在关联类型后面加上具有泛型 where 的字句。例如，建立一个包含迭代器（Iterator）的容器，就像是标准库中使用的 Sequence 协议那样。你应该这么写：
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }

    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}
迭代器（Iterator）的泛型 where 子句要求：无论迭代器是什么类型，迭代器中的元素类型，必须和容器项目的类型保持一致。
一个协议继承了另一个协议，你通过在协议声明的时候，包含泛型 where 子句，来添加了一个约束到被继承协议的关联类型。例如，下面的代码声明了一个 ComparableContainer 协议，它要求所有的 Item 必须是 Comparable 的。
protocol ComparableContainer: Container where Item: Comparable { }

二十二 自动引用计数
Swift 使用自动引用计数（ARC）机制来跟踪和管理你的应用程序的内存
1. 自动引用计数的工作机制
当你每次创建一个类的新的实例的时候，ARC 会分配一块内存来储存该实例信息。内存中会包含实例的类型信息，以及这个实例所有相关的存储型属性的值。
此外，当实例不再被使用时，ARC 释放实例所占用的内存，并让释放的内存能挪作他用。这确保了不再被使用的实例，不会一直占用内存空间。
2. 类实例之间的循环强引用
可能会写出一个类实例的强引用数永远不能变成 0 的代码。如果两个类实例互相持有对方的强引用，因而每个实例都让对方一直存在，就是这种情况。这就是所谓的循环强引用
你可以通过定义类之间的关系为弱引用或无主引用，以替代强引用
3. 解决实例之间的循环强引用
Swift 提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题：弱引用（weak reference）和无主引用（unowned reference）
弱引用和无主引用允许循环引用中的一个实例引用另一个实例而不保持强引用。这样实例能够互相引用而不产生循环强引用
3.1 弱引用
展示了两个属性的值都允许为 nil，并会潜在的产生循环强引用
当其他的实例有更短的生命周期时，使用弱引用
因为弱引用不会保持所引用的实例，即使引用存在，实例也有可能被销毁。因此，ARC 会在引用的实例被销毁后自动将其弱引用赋值为 nil。并且因为弱引用需要在运行时允许被赋值为 nil，所以它们会被定义为可选类型变量，而不是常量
3.2 无主引用
当其他实例有相同的或者更长生命周期时，请使用无主引用
展示了一个属性的值允许为 nil，而另一个属性的值不允许为 nil，这也可能会产生循环强引用。这种场景最适合通过无主引用来解决
。和弱引用不同的是，无主引用在其他实例有相同或者更长的生命周期时使用。你可以在声明属性或者变量时，在前面加上关键字 unowned 表示这是一个无主引用。
使用无主引用，你必须确保引用始终指向一个未销毁的实例。
如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误
注意
上面的例子展示了如何使用安全的无主引用。对于需要禁用运行时的安全检查的情况（例如，出于性能方面的原因），Swift 还提供了不安全的无主引用。与所有不安全的操作一样，你需要负责检查代码以确保其安全性。 你可以通过 unowned(unsafe) 来声明不安全无主引用。如果你试图在实例被销毁后，访问该实例的不安全无主引用，你的程序会尝试访问该实例之前所在的内存地址，这是一个不安全的操作。
3.3 无主引用和隐式解包可选值属性
存在着第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为 nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解包可选值属性。
这使两个属性在初始化完成后能被直接访问（不需要可选展开），同时避免了循环引用。这一节将为你展示如何建立这种关系。
为了满足这种需求，通过在类型结尾处加上感叹号（City!）的方式，将 Country 的 capitalCity 属性声明为隐式解包可选值类型的属性。这意味着像其他可选类型一样，capitalCity 属性的默认值为 nil，但是不需要展开它的值就能访问它
4. 闭包的循环强引用
循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了这个类实例时
循环强引用的产生，是因为闭包和类相似，都是引用类型。当你把一个闭包赋值给某个属性时，你是将这个闭包的引用赋值给了属性。实质上，这跟之前的问题是一样的——两个强引用让彼此一直有效。但是，和两个类实例不同，这次一个是类实例，另一个是闭包。
5 解决闭包的循环强引用
在定义闭包时同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用
5.1 定义捕获列表
定义捕获列表
捕获列表中的每一项都由一对元素组成，一个元素是 weak 或 unowned 关键字，另一个元素是类实例的引用（例如 self）或初始化过的变量（如 delegate = self.delegate!）。这些项在方括号中用逗号分开。
如果闭包有参数列表和返回类型，把捕获列表放在它们前面：
lazy var someClosure: (Int, String) -> String = {
    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
    // 这里是闭包的函数体
}
如果闭包没有指明参数列表或者返回类型，它们会通过上下文推断，那么可以把捕获列表和关键字 in 放在闭包最开始的地方：
lazy var someClosure: () -> String = {
    [unowned self, weak delegate = self.delegate!] in
    // 这里是闭包的函数体
}
5.2 弱引用和无主引用
在闭包和捕获的实例总是互相引用并且总是同时销毁时，将闭包内的捕获定义为 无主引用。
相反的，在被捕获的引用可能会变为 nil 时，将闭包内的捕获定义为 弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为 nil。这使我们可以在闭包体内检查它们是否存在。
注意
如果被捕获的引用绝对不会变为 nil，应该用无主引用，而不是弱引用。
 lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

二十三 内存安全

Swift 会阻止你代码里不安全的行为
Swift 也保证同时访问同一块内存时不会冲突，通过约束代码里对于存储地址的写操作，去获取那一块内存的访问独占权。

1. 理解内存访问冲突
内存的访问，会发生在你给变量赋值，或者传递参数给函数时
1.1 内存访问性质
内存访问冲突时，要考虑内存访问上下文中的这三个性质：访问是读还是写，访问的时长，以及被访问的存储地址。特别是，冲突会发生在当你有两个访问符合下列的情况：
至少有一个是写访问
它们访问的是同一个存储地址
它们的访问在时间线上部分重叠

读和写访问的区别很明显：一个写访问会改变存储地址，而读操作不会。存储地址是指向正在访问的东西（例如一个变量，常量或者属性）的位置的值 。内存访问的时长要么是瞬时的，要么是长期的。
如果一个访问不可能在其访问期间被其它代码访问，那么就是一个瞬时访问。

1.2 In-Out 参数的访问冲突
一个函数会对它所有的 in-out 参数进行长期写访问。in-out 参数的写访问会在所有非 in-out 参数处理完之后开始，直到函数执行完毕为止

长期访问的存在会造成一个结果，你不能在访问以 in-out 形式传入后的原变量，即使作用域原则和访问权限允许——任何访问原变量的行为都会造成冲突。例如：
var stepSize = 1

func increment(_ number: inout Int) {
    number += stepSize
}

increment(&stepSize)
// 错误：stepSize 访问冲突

注意
因为操作符也是函数，它们也会对 in-out 参数进行长期访问。例如，假设 balance(_:_:) 是一个名为 <^> 的操作符函数，那么 playerOneScore <^> playerOneScore 也会造成像 balance(&playerOneScore, &playerOneScore) 一样的冲突。
1.3 方法里 self 的访问冲突
一个结构体的 mutating 方法会在调用期间对 self 进行写访问

2. 属性的访问冲突
结构体，元组和枚举的类型都是由多个独立的值组成的，例如结构体的属性或元组的元素。因为它们都是值类型，修改值的任何一部分都是对于整个值的修改，意味着其中一个属性的读或写访问都需要访问整一个值。例如，元组元素的写访问重叠会产生冲突：
var playerInformation = (health: 10, energy: 20)
balance(&playerInformation.health, &playerInformation.energy)
// 错误：playerInformation 的属性访问冲突
遵循下面的原则时
你访问的是实例的存储属性，而不是计算属性或类的属性
结构体是本地变量的值，而非全局变量
结构体要么没有被闭包捕获，要么只被非逃逸闭包捕获了

二十四 访问控制
访问控制可以限定其它源文件或模块中的代码对你的代码的访问级别

1. 模块和源文件
Swift 中的访问控制模型基于模块和源文件这两个概念
模块指的是独立的代码单元，框架或应用程序会作为一个独立的模块来构建和发布。在 Swift 中，一个模块可以使用 import 关键字导入另外一个模块。
源文件就是 Swift 中的源代码文件，它通常属于一个模块，即一个应用程序或者框架。尽管我们一般会将不同的类型分别定义在不同的源文件中，但是同一个源文件也可以包含多个类型、函数之类的定义

2. 访问级别
访问级别
Swift 为代码中的实体提供了五种不同的访问级别。这些访问级别不仅与源文件中定义的实体相关，同时也与源文件所属的模块相关。
Open 和 Public 级别可以让实体被同一模块源文件中的所有实体访问，在模块外也可以通过导入该模块来访问源文件里的所有实体。通常情况下，你会使用 Open 或 Public 级别来指定框架的外部接口。Open 和 Public 的区别在后面会提到。
Internal 级别让实体被同一模块源文件中的任何实体访问，但是不能被模块外的实体访问。通常情况下，如果某个接口只在应用程序或框架内部使用，就可以将其设置为 Internal 级别。
File-private 限制实体只能在其定义的文件内部访问。如果功能的部分细节只需要在文件内使用时，可以使用 File-private 来将其隐藏。
Private 限制实体只能在其定义的作用域，以及同一文件内的 extension 访问。如果功能的部分细节只需要在当前作用域内使用时，可以使用 Private 来将其隐藏。
Open 为最高访问级别（限制最少），Private 为最低访问级别（限制最多）。
Open 只能作用于类和类的成员，它和 Public 的区别如下：
Public 或者其它更严访问级别的类，只能在其定义的模块内部被继承。
Public 或者其它更严访问级别的类成员，只能在其定义的模块内部的子类中重写。
Open 的类，可以在其定义的模块中被继承，也可以在引用它的模块中被继承。
Open 的类成员，可以在其定义的模块中子类中重写，也可以在引用它的模块中的子类重写

3. 访问级别基本原则
Swift 中的访问级别遵循一个基本原则：实体不能定义在具有更低访问级别（更严格）的实体中。
例如：
一个 Public 的变量，其类型的访问级别不能是 Internal，File-private 或是 Private。因为无法保证变量的类型在使用变量的地方也具有访问权限。
函数的访问级别不能高于它的参数类型和返回类型的访问级别。因为这样就会出现函数可以在任何地方被访问，但是它的参数类型和返回类型却不可以的情况。
4. 默认访问级别
如果你没有为代码中的实体显式指定访问级别，那么它们默认为 internal 级别（有一些例外情况，稍后会进行说明）。因此，在大多数情况下，我们不需要显式指定实体的访问级别。
5. 单 target 应用程序的访问级别
当你编写一个单目标应用程序时，应用的所有功能都是为该应用服务，而不需要提供给其他应用或者模块使用，所以我们不需要明确设置访问级别，使用默认的访问级别 Internal 即可。但是，你也可以使用 fileprivate 访问或 private 访问级别，用于隐藏一些功能的实现细节。
6. 框架的访问级别
当你开发框架时，就需要把一些对外的接口定义为 Open 或 Public，以便使用者导入该框架后可以正常使用其功能。这些被你定义为对外的接口，就是这个框架的 API
注意
框架的内部实现仍然可以使用默认的访问级别 internal，当你需要对框架内部其它部分隐藏细节时可以使用 private 或 fileprivate。对于框架的对外 API 部分，你就需要将它们设置为 open 或 public 了。
7. 单元测试 target 的访问级别
当你的应用程序包含单元测试 target 时，为了测试，测试模块需要访问应用程序模块中的代码。默认情况下只有 open 或 public 级别的实体才可以被其他模块访问。然而，如果在导入应用程序模块的语句前使用 @testable 特性，然后在允许测试的编译设置（Build Options -> Enable Testability）下编译这个应用程序模块，单元测试目标就可以访问应用程序模块中所有内部级别的实体。
8. 访问控制语法

通过修饰符 open、public、internal、fileprivate、private 来声明实体的访问级别：
public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}
9. 自定义类型
如果想为一个自定义类型指定访问级别，在定义类型时进行指定即可。新类型只能在它的访问级别限制范围内使用

一个类型的访问级别也会影响到类型成员（属性、方法、构造器、下标）的默认访问级别。如果你将类型指定为 private 或者 fileprivate 级别，那么该类型的所有成员的默认访问级别也会变成 private 或者 fileprivate 级别。如果你将类型指定为 internal 或 public（或者不明确指定访问级别，而使用默认的 internal ），那么该类型的所有成员的默认访问级别将是 internal。
重点
上面提到，一个 public 类型的所有成员的访问级别默认为 internal 级别，而不是 public 级别。如果你想将某个成员指定为 public 级别，那么你必须显式指定。这样做的好处是，在你定义公共接口的时候，可以明确地选择哪些接口是需要公开的，哪些是内部使用的，避免不小心将内部使用的接口公开。
public class SomePublicClass {                  // 显式 public 类
    public var somePublicProperty = 0            // 显式 public 类成员
    var someInternalProperty = 0                 // 隐式 internal 类成员
    fileprivate func someFilePrivateMethod() {}  // 显式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
}

10. 元组类型
元组的访问级别将由元组中访问级别最严格的类型来决定。例如，如果你构建了一个包含两种不同类型的元组，其中一个类型为 internal，另一个类型为 private，那么这个元组的访问级别为 private。
注意
元组不同于类、结构体、枚举、函数那样有单独的定义。元组的访问级别是在它被使用时自动推断出的，而无法明确指定。
11.函数类型
函数的访问级别根据访问级别最严格的参数类型或返回类型的访问级别来决定。但是，如果这种访问级别不符合函数定义所在环境的默认访问级别，那么就需要明确地指定该函数的访问级别。
12.枚举类型
枚举成员的访问级别和该枚举类型相同，你不能为枚举成员单独指定不同的访问级别。
比如下面的例子，枚举 CompassPoint 被明确指定为 public，那么它的成员 North、South、East、West 的访问级别同样也是 public：
public enum CompassPoint {
    case north
    case south
    case east
    case west
}
13. 嵌套类型
如果在 private 的类型中定义嵌套类型，那么该嵌套类型就自动拥有 private 访问级别。如果在 public 或者 internal 级别的类型中定义嵌套类型，那么该嵌套类型自动拥有 internal 访问级别。如果想让嵌套类型拥有 public 访问级别，那么需要明确指定该嵌套类型的访问级别。

14. 子类的访问级别不得高于父类的访问级别。例如，父类的访问级别是 internal，子类的访问级别就不能是 public。
可以通过重写为继承来的类成员提供更高的访问级别。
15.常量、变量、属性、下标
常量、变量、属性不能拥有比它们的类型更高的访问级别。例如，你不能定义一个 public 级别的属性，但是它的类型却是 private 级别的。同样，下标也不能拥有比索引类型或返回类型更高的访问级别。
如果常量、变量、属性、下标的类型是 private 级别的，那么它们必须明确指定访问级别为 private：
private var privateInstance = SomePrivateClass()
16 Getter 和 Setter
常量、变量、属性、下标的 Getters 和 Setters 的访问级别和它们所属类型的访问级别相同。
Setter 的访问级别可以低于对应的 Getter 的访问级别，这样就可以控制变量、属性或下标的读写权限
17. 构造器
自定义构造器的访问级别可以低于或等于其所属类型的访问级别。唯一的例外是必要构造器，它的访问级别必须和所属类型的访问级别相同
18.默认构造器
默认构造器的访问级别与所属类型的访问级别相同，除非类型的访问级别是 public。如果一个类型被指定为 public 级别，那么默认构造器的访问级别将为 internal。如果你希望一个 public 级别的类型也能在其他模块中使用这种无参数的默认构造器，你只能自己提供一个 public 访问级别的无参数构造器
19.结构体默认的成员逐一构造器
如果结构体中任意存储型属性的访问级别为 private，那么该结构体默认的成员逐一构造器的访问级别就是 private。否则，这种构造器的访问级别依然是 internal。
如同前面提到的默认构造器，如果你希望一个 public 级别的结构体也能在其他模块中使用其默认的成员逐一构造器，你依然只能自己提供一个 public 访问级别的成员逐一构造器。
20. 协议
如果想为一个协议类型明确地指定访问级别，在定义协议时指定即可。这将限制该协议只能在适当的访问级别范围内被遵循。
21. 协议继承
如果定义了一个继承自其他协议的新协议，那么新协议拥有的访问级别最高也只能和被继承协议的访问级别相同。例如，你不能将继承自 internal 协议的新协议定义为 public 协议。
22. 协议遵循
一个类型可以遵循比它级别更低的协议
23. Extension
Extension 可以在访问级别允许的情况下对类、结构体、枚举进行扩展
Extension 的成员具有和原始类型成员一致的访问级别。
使用 extension 扩展了一个 public 或者 internal 类型，extension 中的成员就默认使用 internal 访问级别，和原始类型中的成员一致。如果你使用 extension 扩展了一个 private 类型，则 extension 的成员默认使用 private 访问级别。
24. Extension 的私有成员
扩展同一文件内的类，结构体或者枚举，extension 里的代码会表现得跟声明在原类型里的一模一样。也就是说你可以这样：
在类型的声明里声明一个私有成员，在同一文件的 extension 里访问。
在 extension 里声明一个私有成员，在同一文件的另一个 extension 里访问。
在 extension 里声明一个私有成员，在同一文件的类型声明里访问。
25. 泛型
泛型类型或泛型函数的访问级别取决于泛型类型或泛型函数本身的访问级别，还需结合类型参数的类型约束的访问级别，根据这些访问级别中的最低访问级别来确定
26 类型别名
你定义的任何类型别名都会被当作不同的类型，以便于进行访问控制。类型别名的访问级别不可高于其表示的类型的访问级别。例如，private 级别的类型别名可以作为 private、file-private、internal、public 或者 open 类型的别名，但是 public 级别的类型别名只能作为 public 类型的别名，不能作为 internal、file-private 或 private 类型的别名。