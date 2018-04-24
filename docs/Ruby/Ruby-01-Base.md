# Principes de base

## Tout est *Objet*

Contrairement à certains langages comme C++, C# ou Java qui distinguent des types primitifs et des types objets,
en ruby **TOUT** est objet. (Pour rappel les types primitifs sont `char`, `int`, `float`, etc...).

Ceci est une force puisqu'il est possible d'appeler une méthode sur un nombre:

~~~ irb
>> temperature = -19
>> temperature.abs
=> 19
~~~

Etant donné que tout est objet, les litéraux également:

~~~ irb
>> "hello!".upcase
=> "HELLO!"
~~~


## Tout est *expression*

En ruby il n'y a pas de distinction entre _instruction_ et _expression_, **TOUT** est expression.
Ceci implique que toute "ligne" de code produit une valeur.

Exemple en C

~~~ cpp
int age;

// This is an instruction
srand(100);

// This is an expression
age = 42;

// This is an instruction
if (age >= 18) {
  printf("Come in");
}
~~~

En ruby

~~~ irb
>> srand(100)
=> 105928681577143959150349108252623195217  # <= expression value
>> age = 42
=> 42                                       # <= expression value
>> if age >= 18
>>   puts "Come in"
>> end
Come in
=> nil                                      # <= expression value
~~~

- Toutes les fonctions/méthodes retournent une valeur, il n'y a donc pas de type `void`.
- Les litéraux retourne leur propre valeur.
- Les blocks de code retournent la valeur de leur dernière ligne
- Les structures de contrôles, en particulier le `if`, `unless` et `case`, retourne la valeur de la dernière ligne de la branche selectionnée

Exemple:

~~~ ruby
message = if age >= 18
  prepare_welcome_drink
  "Welcome"
else
  step_forward
  "Get back"
end
~~~


## `nil`, `false`, `true`


nil est un objet, on peut lui appeler des méthodes

nil.to_s


## Structures de contrôles

Toutes les structures de contrôle classiques existent sauf le _for_ (il y a une raison!).

~~~ ruby
if __condition__
  ...
end

if __condition__
  ...
else
  ...
end

if __condition__
  ...
elsif __other_condition__
  ...
elsif __other_condition__
  ...
end

case __valeur__
  ...
when __cas_1__
  ...
when __cas_2__
  ...
else
  ...
end

while __condition__
  ...
end

until __condition__
  ...
end

begin
  ...
end while __condition__

begin
  ...
end until __condition__
~~~

De plus il existe l'inverse du `if` appelé `unless`, il fait la même chose qu'un `if !(...)` mais permet une meilleur lisibilité.

~~~ ruby
unless __condition__
  ...
end
~~~

Une autre particularité sont les versions _modifier_, il s'agit de mettre la structure de contrôle à la fin lorsque le corps
de la structure n'est qu'une ligne. Très utile pour les _one liner_, exemple:

~~~ ruby
if age >= 18
  puts "Come in"
end

# becomes

puts "Come in" if age >= 18
~~~

### `for`

Le `for` n'existe pas en ruby, ou plutôt il n'existe que la forme `foreach`. La particularité est que ce _foreach_ n'est
qu'un appel de la méthode `each` sur la collection à parcourir.

~~~ ruby
for pure_square in [1,2,4,9,16,25]
  puts pure_square
end

# equivalent to

[1,2,4,9,16,25].each { |pure_square| puts pure_square }
~~~


### `next`, `break`, `redo`, `retry`


## Fonctions

En réalité les fonctions n'existent pas, seule les méthodes existent, mais du à la syntaxe et la sémantique de ruby, il est possible
de définir des méthodes _globales_ ce qui correspond à des fonctions.

### définition

### appel

### `return`

Etant donné que tout est expression, la dernière expression de la fonction **est** la valeur de retour, exemples:

~~~ ruby
def divide(a, b)
  a / b
end

def greet(person)
  if person.age >= 18
    "Good morning"
  else
    "Yo!"
  end
end
~~~

Il est néammoins possible de sortir à n'importe quel moment de la fonction avec le mot-clé `return` comme dans d'autres langages.

~~~ ruby
def notify(target, body)
  return unless target
  
  send_email(target, "Notification", body)
end
~~~


### surcharge et paramètres multiples

La surcharge de méthode n'existe pas en ruby, il n'est pas possible de définir plusieurs fois le même nom de méthode avec des
paramètres différent, comme en C# ou Java.

Par contre il est possible de recevoir un nombre variable d'argument et de les utiliser à l'intérieur de la méthode pour faire une sélection.

~~~ ruby
def notify(*args)
  # args est un tableau contenant les arguments
  case args.size
  when 1
    send_email("phi@cpnv.ch", "System Notification", args[0])
  when 2
    send_email(args[0], "System Notification", args[1])
  end
end

notify("chef@cpnv.ch", "New intranet release deployed")
notify("Minor release deployed")

~~~

Il est également possible de définir des paramètres nommés, et à l'appel de ne spécifier qu'un certain nombre, et dans n'importe quel ordre.

~~~ ruby
def notify(target: "phi@cpnv.ch", body: nil)
  send_email(target, "System Notification", body)
end

notify(target: "chef@cpnv.ch", body: "New intranet release deployed")
notify(body: "Minor release deployed")

~~~

### Méthodes avec ? ou !

#### Predicate

Lorsque l'on développe une classe, il arrive souvent que l'on implémente des méthodes qui doivent retourner `true` ou `false`
suite à une sorte de question. Ruby a une façon élégante pour vous permettre une telle implémentation, vous pouvez ajouter un
point d'interogation à la fin du nom de la méthode (il fait partie intégrante du nom).

Cette convention aporte en lisibilité dans le code et aussi en facilitant l'exploration d'une API.

~~~ ruby
def divisible_by_6?(number)
  number.even? && divisible_by_3?(number)
end

if divisible_by_6? column_index
  ...
end
~~~

#### Bang

Il est également possible d'ajouter un point d'exclamation à la fin d'une méthode (il fait partie intégrante du nom) pour
indiquer que cette méthode fait quelque chose de _dangereux_. Il est laissé au développeur de déterminer la "dangerosité"
ou non de sa méthode.

Dans la librairie standard de ruby, les méthodes modifiant _en place_ l'objet (le receveur) ont souvent le point d'exclamation.

Exemple:

~~~ irb
>> name = "Pascal"
=> "Pascal"
>> name.upcase
=> "PASCAL"
>> name
=> "Pascal"
>> name.upcase!
=> "PASCAL"
>> name
=> "PASCAL"
~~~


## Killer feature: Blocks de code

Dans tout langage il existe le besoin de passer en paramètre à une méthode, un bout de code utilisateur qui doit être executé par
cette méthode. C'est le principe des **callbacks**, littéralement un appel en _arrière_.

Appel de méthode standard:
> image 

Appel de méthode avec un callback:
> image

En ruby ceci a été pensé et implémenté directement dans le langage. Toute méthode peut recevoir un **block de code** en paramètre sans
une écriture explicite.

### exemple simple

~~~ ruby
File.open("alice.txt") do |file|
  # Ceci est le corps du block de code
end
~~~

Il est délimité par `do` et `end`, une version _one-liner_ existe aussi en utilisant des accolades:

~~~ ruby
File.open("alice.txt") { |file| __Ceci_est_le_corps_du_block_de_code__ }
~~~

Dans cet exemple, on demande l'ouverture d'un fichier et si cela se passe bien, le block de code sera appelé. Notez le passage
de paramètre du callback, spécifié entre | (pipes). `file` représente l'objet fichier ouvert sur lequel il est possible d'appeler
des méthodes pour le manipuler.
A la fin du block de code, la main reviens à la méthode `open`, qui profite pour fermer le fichier.

L'implémentation de `File.open` ressemble à ceci:

~~~ ruby
def open(filename)
  file = system_open_file(filename)
  yield file  # <= appel du block de code avec passage de paramètre
  system_close_file(file)
end
~~~

### exemple avec plusieurs appels du callback

Ce principe est très utilisé pour fournir un large arsenal de fonctionnalité pour les collections.

Prenons en exemple un algorithme de recherche d'un élément dans un tableau (pseudo-ruby):

~~~
def array_search(array, what)
  foreach item in array
    if item == what
      return true
    end
  end
  return false
end
~~~

Comment modifier cet algorithme pour qu'au lieu d'une égalité stricte nous aimerions un match de regexp?

Il faut modifier la ligne contenant le `if`:

~~~
    if item.match(regexp)
~~~

Comment généraliser ceci? En déléguant à un block de code écrit par l'appelant.

~~~ ruby
def array_search(array)
  for item in array
    if yield(item)  # <= Appel du block de code
      return true
    end
  end
  return false
end
~~~

Voici les appels possibles:

~~~ ruby
array_search(array) { |item| item == "Paul" }
array_search(array) { |item| item.match(/^P/) }
~~~


#### Transformer un tableau

Ceci existe déjà dans la classe array: `Array#map` ou `Array#collect`, voici l'utilisation:

~~~ irb
>> numbers = [1,2,3,4,5]
=> [1,2,3,4,5]
>> squares = numbers.map { |number| number*number }
=> [1,4,9,16,25]
~~~

Implémentation de `map`:

~~~ ruby
def map
  result = []
  each do |item|
    result << yield(item)
  end
  result
end
~~~

### closure

L'intérêt du block de code écrit du côté appelant et que ce code a accès à **TOUT** ce qui est disponible dans le _lexical scope_,
c'est à dire, les variables (locales, d'instances, ...) et les méthodes du contexte courrant.

~~~ ruby
# variable locale
exposant = 3
# utilisable DANS le block de code
puissances = nombres.map { |nombre| nombre**exposant }
~~~


<!--
(every other programming language wanted it, but without being baked in from day one it had to be added thus it looks ugly (js) or is too verbose (php use))

closure => capture tout ce qui est accéssible dans la "closure" actuelle. (Meme self est utilisabel, attention: OO pas encore vu,
chapitre Block & closure dans OO?)
-->

## Types standard

Ruby est un langage *fortement* typé, chaque valeur a un type bien précis et donc son propre ensemble de méthodes disponibles (par type).

Les types standard suivants existent:

  - String
  - Regexp
  - Integer
  - Float
  - Complex
  - Rational
  - Time

Voici d'autres types intéressants:

### Les symboles

Dans la plupart des langages, lorsque l'on veut donner des **significations** à une valeur d'une variable, on utilise:

  1. Des constantes (avec des valeurs numériques sans significations particulières)
  2. Un type énuméré.
  
Exemple en C#:

~~~ java
const int SUCCESS = 0;
const int ERROR_FILE_NOT_FOUND      = 100;
const int ERROR_INVALID_PATH        = 101;
const int ERROR_NETWORK_UNREACHABLE = 102;

enum Error {
  SUCCESS,
  ERROR_FILE_NOT_FOUND,
  ERROR_INVALID_PATH,
  ERROR_NETWORK_UNREACHABLE
}
~~~

En ruby il n'y a pas besoin, les *symboles* sont la pour ça.

Un symbole est une **valeur** qui **est** un **nom propre** utilisé dans le code. La seul chose intéressante que l'on peut faire avec
un symbole est de le comparer (test d'égualité) à un autre symbole. Les symboles s'écrivent avec un `:` en prefixe du nom:

~~~ ruby
error_code = :error_invalid_path
...
if error_code == :error_invalid_path
  ...
end
~~~

Ils sont également très utilisés comme *clés* dans les tableaux associatifs.


### Interval: `Range`


### Tableaux: `Array`


### Tableaux associatifs: `Hash`


### lambda




lambda: syntaxe 2.0 (aussi indiquer les autres variantes: lambda, proc et Proc.new pour réf sans trop de détails)
(avec affectation dans var puis .call après coup.)


## Gestion d'erreurs: les exceptions



<!--

  principes de bases:
    everything is an object
    everything has a value
    nil, false, true, other
    String, Number
    String interpolation
    Array, Hash
    Symbol
    
    Method names:
      predicates ?
      returns new data, does not mutate self
      mutates self!

  Killer feature:
    blocks
      (every other programming language wanted it, but without being baked in from day one it had to be added thus it looks ugly (js) or is too verbose (php use))
    (closure)
    
  OO:
    Class, Object
    receiver
    Data-hiding
    Inheritance
    Polymorphism
  
  Other:
    Class is an Object
      calling methods on class => attr_*
    Duck-typing
    open class
    meta prog (reflection)
    Exception

-->
