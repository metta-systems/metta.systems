+++
date = 2012-08-07
title = "Meddle Grammar"
[taxonomies]
category = ["notes"]
tags = ["metta"]
+++
## Types

Built-in types include `int8`, `int16`, `int32`, `int64` for signed integer types of given bit size, `card16`, `card32`, `card64` for unsigned integer types with given size, `octet` for 8-bit bytes, `float` and `double` for single and double precision floating point numbers, `boolean` for true and false, and types `integer` and `cardinal` with generic unspecified bit size for use in non-local interfaces, these two types will be marshalled to a transport type of necessary size to represent the value.

The types `int8`, `int16`, `int32`, `int64`, `card16`, `card32`, `card64` are considered "unsafe" or "dangerous" types and can be used only in local interfaces (or should they be convertible to integer/cardinal for network communication?). `octet` is considered safe and could be used to represent arbitrary sequences of bytes (`sequence<octet> binary;`)

Custom types can be `enum`, `set`, `range`, `type` alias, `sequence`, `array` and `record`.

<!-- more -->

#### enum

Enum simply lists identifiers in some common group. Numeric values are assigned to names automatically in order of declaration.

```
enum priority { low, medium, high }
enum selector { first, second }
```

Enum values are equal at the symbol level, like Ruby symbols or X11 atoms. There are no explicit numeric values available to programmer.

#### set

Set converts enum into a flags field. Enum names become assigned with flags fields bit positions. The order of bits (starting from lsb or msb) is unspecified.

```
set<priority> priority_flags;
```

#### range

Range creates a subtype whose allowed values are in range between first and last, inclusive. Numeric or enum values can be used.

```
range priority.low..priority.high priority_range;
range 0..15 hexnibble;
```

#### type alias

Type alias simply creates an alternative name for an already existing type. It is helpful to shorten type names used across two different interfaces.

```
type card32 address;
type octet attrs;
```

Types used from another interface have to be fully qualified, unless they are inherited from parent interface type.

#### sequence

Sequence defines an ordered container consisting of arbitrary number of items with given type, they can be accessed as a vector, starting from index 0. You can query sequence length, add or remove arbitrary items.

```
sequence<octet> binary;
```

#### array

Array defines a fixed-size storage of items of given type. Array bounds can be defined using an integer, in which case it acts as a fixed-size sequence with indices from 0 to max-1. Or with a range type, in which case the indices will be from range's low value to range's high value, inclusive.

```
array octet[10] ten_bytes;
array integer[hexnibble] nibble_frequencies;
```

Array is currently not implemented in IDL.

#### record

Record is a composite type, consisting of fields of arbitrary types laid out in a specified order.

```
record datarec {
    ten_bytes input;
    nibble_frequencies output;
}

record nibble_statistics {
    datarec data
    status.type status;
}
```

#### choice

Choice is a selection of one type out of many. It is based on an existing enumeration type and uses it to switch between available options.

```
choice pick_one on selector {
    first  => int32,
    second => card32
}
```

#### reference types

Reference types can only be used in local interfaces, since they explicitly refer to memory addresses and are not marshalled. One exception to this is interface references, which always refer to local interface representation. Therefore, all interface types passed or returned are used by reference. E.g. `returns (interface_type_v1)` would return an interface reference.

Passing other types by reference is denoted by appending `&` after the type.

```
do_something(nibble_statistics& ns) returns (other_interface);
# other_interface will be also returned by reference!
```

You can also alias a reference type to an alternative name.

```
type nibble_statistics& my_ref_type;
```

## Interface declaration

#### local

Local interfaces are meant to be used locally only and in general do not generate network marshaling stubs. They also allow use of "unsafe" types in the interface.

#### extends

`extends` is a syntax sugar only - it allows to avoid repeating the whole interface declaration if two versions only extend one another. The IS_A relation does not apply. Interfaces that extend other interfaces will inherit type definitions from their parent into own scope. This means that types and aliases defined in parent interface will be available in all children by default. Interface versions v1 and v2 do not have to have extends relationship. Interface extension does not imply IS_A relationship - extension is structural and scope only, also copying a list of parent interfaces methods into the current interface.

```
module = intf+ ;
intf = ["local"] "interface" ID ["extends" ID] "{" body "}" ;
body = { exception | typedef | method } ;
```

## Exceptions

Exceptions can be declared to contain arbitrary data fields, which should be initialized and propagated when exception is raised.

```
exception not_found { type.code tc; }
exception network_error { network.operation op; network.host target; }
```

## Methods

Normal methods are declared starting with the name and with parameters declared in parenthesis. Methods taking no parameters should use empty list in parenthesis `()`.

```
void_method_with_no_params_and_returning_no_value();
```

Methods returning values should list them in `returns` clause after parameter list.

```
get_statistics(ten_bytes input)
    returns (nibble_frequencies output, boolean succeeded);
```

Methods that do not return should specify `never returns` instead of return values list.

```
reboot() never returns;
```

Idempotent methods can be called multiple times without causing side effects. For example, a failed network packet send will retry calling a remote idempotent method after it times out. These methods are preceded with `idempotent` and are assumed safe to call muliple times.

```
idempotent sqrt(float x) returns (float y);
```

Methods may raise exceptions, which should be listed in this case in `raises()` clause after `returns()` list (or after parameters if method doesn't return anything).

```
allocate(cardinal bytes) returns (address a) raises (out_of_memory);
```

## Parameters

Parameters passed to methods are by default of `in` type, parameters returned from methods are always `out` types. You can amend parameter direction with `in`, `inout` and `out` keywords.

```
method1(in int64 val, out int64 res); # res will be returned from method1

method2(inout int64 data);
    # data will be passed to method2 as parameter and
    # returned from method2 as result.
```

Specifying `in` for arguments and `out` for return values is redundant and is usually omitted.

## Exceptional conditions

Methods that may raise exceptional conditions should list them in `raises` clause after the parameters or `returns` clause. Methods that do not list exceptions or have an explicitly empty list are forbidden from raising exceptions.

```
method3() raises (bad_code, unexpected_data);
```

----
TODO: Literal constants, IDs and qualified IDs.

```
Const = HexNumber | OctNumber | DecNumber | BinNumber ;
ID = [A-Za-z] { [A-Za-z0-9_] } ;
qualifiedID = ID.ID ;
IDs = ID | qualifiedID , { "," , ID | qualifiedID } ;
IDorConst = ID | Const;
IDlist = ID { "," , ID } ;
typeID = ID | qualifiedID | builtinType ;
```

```
 BNF of the grammar.

 module ::= full_interface_decl
 full_interface_decl ::= local_interface_decl | final_interface_decl | interface_decl
 local_interface_decl ::= 'local' (final_interface_decl | interface_decl)
 final_interface_decl ::= 'final' (local_interface_decl | interface_decl)
 interface_decl ::= 'interface' id ['extends' id] '{' interface_body '}'
 interface_body ::= (exception | typealias | full_method_decl)*
 exception ::= 'exception' id '{' field_list '}'
 field_list ::= (var_decl ';')*
 typealias ::= enumdef | setdef | rangedef | typedef | sequencedef | arraydef | recorddef | choicedef
 enumdef ::= 'enum' id '{' id_list '}'
 setdef ::= 'set' '<' typeid '>' id ';'
 rangedef ::= 'range' id '..' id id ';'
 typedef ::= 'type' id id ';'
 sequencedef ::= 'sequence' '<' typeid '>' id ';'
 arraydef ::= 'array' typeid '[' range ']' id ';'
 recorddef ::= 'record' id '{' field_list '}'
 choicedef ::= 'choice' id 'on' id '{' choice_list '}'
 choice_list ::= choice_decl (',' choice_decl)*
 choice_decl ::= id '=>' type_decl
 full_method_decl ::= idempotent_method_decl | method_decl
 idempotent_method_decl ::= 'idempotent' method_decl
 method_decl ::= id argument_list ['returns' argument_list|'never' 'returns'] ['raises' id_list] ';'
 argument_list ::= '(' [ argument (',' argument)* ] ')'
 argument ::= ['in'|'out'|'inout'] var_decl
 id_list ::= '(' [ id (',' id)* ] ')'
 var_decl ::= type_decl id
 type_decl ::= typeid [reference]
 reference ::= '&'
 typeid ::= id | builtin_type
 id ::= [A-Za-z]([A-Za-z0-9_.])*
 builtin_type ::= 'int8' | 'int16' | 'int32' | 'int64' | 'octet' | 'card16' | 'card32' | 'card64' | 'float' | 'double' | 'boolean'
```
