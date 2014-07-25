
basic data type (value type, not need `new`):

1. int: 32 bit integer;
2. uint: unsigned int, big integer;
3. Number: 64 bit float point number.
4. String:
5. Boolean: true and false;

complex data type:
Array,Date,Error,Function,RegExp,XML and XMLList.

Variable Declaration

    var varName:Type;
    var varName:Type = value;

untyped variable

    var h;
    var g:*;

The default value:

1. int: 0;
2. Boolean: false;
3. String: null;

    var i:int = 9;
    var j:int = i / 2;
    trace(j); // 4
    var k:Number = i / 2;
    trace(k); // 4.5
    
constant Declaration

    const name:Type = value;
AVM = ActionScript Virtual Machine
