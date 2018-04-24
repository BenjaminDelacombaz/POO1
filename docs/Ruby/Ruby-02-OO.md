# Orienté Objet

## Classes

~~~ ruby
class Car
  def ignite
    ...
  end
  
  def accelerate(velocity)
    ...
  end
end
~~~

### Accessibilités

Il existe trois accessibilités pour les définitions de méthodes:

 - `public`:    Appelable depuis n'importe où.
 - `protected`: Appelable depuis n'importe quel objet de la même classe que `self`.
 - `private`:   Appelable uniquement depuis `self`, donc sans receveur explicite.

La définition de ces accessibilités se fait par block ou par méthode, exemple:

~~~ ruby
class Car
  def ignite
    ...
  end

  # Starting from here, all the following methods are `protected`
  protected
  
  def repair
    ...
  end
  
  # this one will be public though
  public def open_trunk
  end
end
~~~
 

## Instantiation

L'instantiation ne se fait **PAS** avec le mot-clé `new` comme dans d'autres langages.

> Il n'y a pas de mot-clé `new` !

C'est par contre tout naturel, il faut appeler la _méthode_ `new` de la classe:

~~~ irb
>> titine = Car.new
=> #<Car:0x007feecd013d80>
~~~

## Constructeur

Le constructeur en ruby est la méthode avec le nom réservé `initialize`

~~~ ruby
class Car
  def initialize
    # Do what you want here
  end
  
  ...
~~~

Il est bien sur possible de recevoir des paramètres:

~~~ ruby
class Car
  def initialize(brand, color)
    puts "Just created a #{color} #{brand} car"
  end
  
  ...
~~~

~~~ irb
>> titine = Car.new('Lada', 'yellow')
Just created a yellow Lada car
=> #<Car:0x007feecb028390>
~~~


## Receveur

Ruby est un langage purement orienté object, les fonctions n'existent pas, il n'y a 
que des méthodes.

Ceci veut dire que lorsque l'on appelle une méthode, le __receveur__ est l'objet sur lequel
la méthode est appelée.

Le receveur peut être *explicite*, comme dans:

~~~ irb
>> 34.class
=> Fixnum
~~~

`34` est le receveur, `class` est la méthode.

Mais il peut être implicite

~~~ irb
>> def greetings(name)
>> "Ahoy #{name}"
>> end
=> nil

>> greetings "Pascal"
=> "Ahoy Pascal"
>> greetings("Pascal")
=> "Ahoy Pascal"
~~~

`greetings` est la méthode, le receveur est implicite. Losrque l'on n'indique pas le receveur
c'est `self` (le `this` en ruby).

On peut voir quel est l'objet par défaut dans `irb`:

~~~ irb
>> self
=> main
>> self.class
=> Object
~~~

C'est un objet nommé `main`, qui est de la classe `Object` (la super classe de toute classe).

Lorsque l'on définit une classe, on peut appeler une méthode depuis une autre méthode en indiquant
simplement son nom, le receveur par défaut dans une méthode est l'objet courant.

~~~ ruby
class Car
  def ignite
    ...
    accelerate(10)
  end

  def accelerate(velocity)
    ...
  end
end
~~~

## Classes & Objets

Il est possible d'écrire du code dans une définition de classe mais en dehors
d'une définition de méthode. Ce code sera simplement exécuté lors de l'intérprétation.

~~~ ruby
class Car
  puts "hello"
  puts self

  def ignite
  end
  
  def accelerate(velocity)
  end
end
~~~

donne comme résultat:

~~~
hello
Car
~~~

Le `puts self` nous donne `Car`, donc les classes sont aussi des objets!
D'ailleurs on peut appeler des méthodes sur les classes

~~~ irb
>> Car.class
=> Class
~~~

Et oui la classe de la classe Car est `Class`.
D'ailleurs la classe de *toutes* les classes est `Class`.

## Méthodes de classes

Dans d'autres langages orienté-objets il est possible définir des méthodes que l'on peut
appeler sans instance, on les appelles souvent des méthodes de classe par opposition au
méthodes d'instance. Elle sont souvent (C++, C#, Java) préfixée par le mot clé **static**.

En ruby il n'y a pas besoin de mot-clé supplémentaire puisque les classes sont des objets.
Il suffit de définir des méthodes sur l'objet classe lui-même, exemple:

~~~ ruby
class Car
  # This is a class method
  def Car.wheels_count
    4
  end
  
  # This is a regular method (instance method)
  def ignite
  end
end
~~~

De manière générale en informatique, on n'aime pas la répétition, en ruby c'est pareil.
On profite du fait que dans la définition d'une classe, le receveur **est** la classe
pour utiliser le mot-clé `self` au lieu du nom explicite de la classe, exemple:

~~~ ruby
class Car
  # This is a class method
  def self.wheels_count
    4
  end
  ...
~~~

Maintenant cette méthode est utilisable en l'appelant sur la classe:

~~~ irb
>> Car.wheels_count
=> 4
~~~

Comme toujours ruby est gentil avec le développeur, on peut aussi y accéder
avec la syntaxe à la C++, C#, Java:

~~~ irb
>> Car::wheels_count
=> 4
~~~

On peut aussi appeler une méthode de classe depuis une méthode d'instance
(le contraire n'as pas de sens), pour ceci il nous faut accéder à la classe de
l'instance, ceci se fait avec la méthode `class`, on serait tenter d'écrire:

~~~ ruby
class Car
  ...
  def status
    ...
    puts class.wheels_count
    ...
  end
  ...
~~~

Sauf que l'intérpreteur reconnait d'abord le mot-clé `class` comme une définition
de classe. Il nous faut appeler la méthode `class` en indiquant le receveur
de manière explicite:

~~~ ruby
class Car
  ...
  def status
    ...
    puts self.class.wheels_count
    ...
  end
  ...
~~~


## Attributs

Il n'y a pas de définition d'attributs, en Ruby le Data-Hiding est complet.
Du coup le seul moyen d'accéder à des 'attributs' est par le systèmes des getter/setter.

~~~ ruby
class Car
  def color
  end
  
  def color=(new_color)
  end
end
~~~

Utilisable comme ceci:

~~~ irb
>> titine = Car.new
>> puts titine.color
???
=> nil
>> titine.color = "red"
~~~

Etant donné que l'appel de méthode peut se passer de parenthèses vides `titine.color` ressemble
a une lecture d'un attribut.

Pour le setter, ruby permet un *syntactic sugar* qui est `titine.color = "red"` qui se
transforme en appel de méthode: `titine.color=("red")` (c'est aussi du ruby valide).

On a l'impression complète d'utiliser des attributs mais ce sont bien des méthodes qui
sont appelées et on garde la souplesse de modifier leurs comportements.

### Variables d'instances

Il nous faut compléter le code précédent afin de garder la couleur lors du setter et
de pouvoir retourner la couleur pour le getter.

Pour ceci nous allons utiliser les variables d'instances. Celles-ci meurent à la destruction
de l'instance (l'objet) et non à la fin de la méthode comme les variables locales.

Leurs noms est reconnaissable, elles comportent le signe @ en préfixe. Ceci permet de facilement
les distinguer des variables locales.

~~~ ruby
class Car
  def color
    @color
  end
  
  def color=(new_color)
    @color = new_color
  end
end
~~~

~~~ irb
>> titine = Car.new
>> puts titine.color
=> nil
>> titine.color = "red"
>> puts titine.color
=> "red"
~~~

Et oui, accéder à une variable d'instance encore jamais utilisée retourne `nil` et non pas une
erreur comme pour une variable locale. *It's a feature, not a bug*.

En général on préfère que l'appel à `titine.color` ne retourne pas `nil` si on n'a pas encore définit
de valeur avec le setter, on initialisera donc sa valeur dans le constructeur.

~~~ ruby
class Car
  def initialize
    @color = "blue"
  end
  
  ...
~~~

### Personnalisation

Etant donné que les getter/setter sont de toutes façons des méthodes, il est possible de
personnaliser l'implémentation.

Exemple, on veut que la couleur soit toujours en majuscule:

~~~ ruby
class Car
  def color=(new_color)
    @color = new_color.upcase
  end
end
~~~

### Attributs simplifiés

Comme il est courant de définir des getter/setter simples (qui ne font que d'accéder à la
variable d'instance correspondante), ruby permet de simplifier cette écriture.

Ceci se fait sans mots-clés, mais en utilisant le fait qu'il est possible d'appeler des
méthodes de classe pendant la définition de la classe.

~~~ ruby
class Car
  attr_accessor :color, :brand
end
~~~

Le code ci-dessus est exactement équivalent à:

~~~ ruby
class Car
  def color
    @color
  end

  def color=(value)
    @color = value
  end

  def brand
    @brand
  end

  def brand=(value)
    @brand = value
  end
end
~~~

Il est également possible de ne définir que les getter ou les setter:

~~~ ruby
class Car
  attr_reader :brand
  attr_writer :color
end
~~~

### Utilisation de setter depuis la classe

Lorsque l'on désire utiliser un setter depuis une méthode de l'objet, on
serait tenté d'écrire ceci (voir ligne 5)

~~~ ruby
class Car
  attr_accessor :speed
  
  def ignite
    speed = 20
  end
  
  def speed_report
    "Vou are driving at #{speed} km/h"
  end
end
~~~

Le problème dans ce cas est que `speed = 20` est compris par l'interpréteur
comme une assignation de la valeur 20 à une nouvelle variable locale nommée `speed`.

Ceci n'as donc aucun effet sur le setter nommé `speed=`, par contre à la ligne 9 on
utilise `speed`, il n'y a pas de variable locale nommée comme ceci, l'interpréteur
va regarder si le receveur possède une méthode nommée `speed`, c'est le cas est
le getter est bien appelé.

Pour résoudre le problème du setter, il faut explicitement utiliser le receveur, dans
ce cas `self`. Le code deviens:

~~~ ruby
class Car
  attr_accessor :speed
  
  def ignite
    self.speed = 20
  end
end
~~~

## Héritage

~~~ ruby
class Vehicle
  attr_accessor :speed
  
  def ignite
    self.speed = 20
  end
end

class Car < Vehicle
  def open_trunk
    ...
  end
end
~~~


### Redéfinition de méthodes

Il est bien sûr possible de redéfinir des méthodes, on change donc l'implémentation dans la classe dérivée.

~~~ ruby
class Vehicle
  attr_accessor :speed
  
  def ignite
    self.speed = 20
  end
end

class Car < Vehicle
  def lock_doors
    ...
  end

  def ignite
    lock_doors
    self.speed = 40
  end
end
~~~

Il est aussi possible d'utiliser l'implémentation de base, et de l'appeler au moment voulu par le développeur, ceci avec le mot-clé `super`

~~~ ruby
class Vehicle
  attr_accessor :speed
  
  def ignite
    self.speed = 20
  end
end

class Car < Vehicle
  def lock_doors
    ...
  end

  def ignite
    lock_doors
    super # <= call ignite on Vehicle
  end
end
~~~

**ATTENTION**: Lorsque l'on définit un constructeur dans la classe dérivée, il est également de la responsabilité du développeur d'appeler
le constructeur de base. L'intérêt de ceci est à nouveau de _choisir le moment de l'appel_ ou même de ne _pas appeler l'implémentation de base_.

~~~ ruby
class Vehicle
  def initialize(color)
    @color = color
  end
end

class Moto < Vehicle
  # Sorry, color for moto doesn't matter
  def initialize
    @wheel_count = 2
    
    # Now call the base constructor by passing a chosen argument
    super("black")
  end
end
~~~


## Particularités OO

Ruby possède des particularités intéressantes en relation avec le monde OO.
(Certaines de ces particularités viennent d'autres langages comme Smalltalk, ...)

### The missing method

Dans les principes orientés-objets, les objets intéraggisent entre eux en s'envoyant
des messages. Dans la plupart des langages, ceci se traduit par l'appel de méthodes.

En ruby, on a gardé ce lien avec la théorie. Du coup lorsque l'on envoie un message
inconnu à un objet, celui-ci peut le récupérer et agir comme il l'entend.

C'est la méthode `method_missing` qui est appelée, exemple:

~~~ ruby
class Greeter
  def hi(msg)
    puts "Hi #{msg}"
  end
  
  def method_missing(name, *args)
    puts "#{name} #{args[0]}"
  end
end

greeter = Greeter.new
greeter.hi "Pascal"
=> Hi Pascal
greeter.hello "There"
=> hello There
~~~

### L'appel de la forêt

Un appel de méthode étant un envoi de message, il est possible d'appeler une méthode
dont on possède le nom dans une chaîne de caractère, on utilise la méthode `send` pour ceci.

~~~ ruby
greeter = Greeter.new
greeter.send(:hi, "Pascal")
=> Hi Pascal
greeter.send('hello', "There")
=> hello There
~~~

### Opération portes ouvertes

En ruby les classes sont dites *ouvertes*, ceci veut dire
que l'on peut ré-ouvrir une classe pour y ajouter d'autres méthodes.

Ceci se fait simplement an ayant le même nom de classe et la même superclasse.

Exemple:

~~~ ruby
class Car
  def ignite
  end
  
  def accelerate(velocity)
  end
end

class Car
  attr_accessor :color
end
~~~

Bien sûr, ceci peut se faire dans n'importe quel fichier, et à n'importe quel moment.

De plus, les objets _déjà créés_ auront aussi à disposition les nouvelles définitions!

### Mixins

L'héritage multiple n'existe pas en Ruby, les *interfaces* non plus puisqu'il n'y
a pas de déclaration de types et de contrôle de type.

Il existe cependant un concept intéressant que sont les **mixins**. Ce sont des modules
qui permette d'ajouter du code (des méthodes) à une ou plusieurs classes existantes.
L'intéret est que le code n'est écrit qu'une seule fois.

Exemple:

~~~ ruby
module Walkable
  def walk
    puts "walking..."
  end
  
  def run
    puts "running..."
  end
end

class Bird
  include Walkable
  
  def fly
    puts "Flying"
  end
end

class Eagle < Bird
  def watch
    puts "We are watching you!"
  end
end

class Human
  include Walkable
  
  def run
    puts "running but not so good!"
  end
end
~~~

~~~ irb
joe = Human.new
joe.walk
=> walking...
joe.run
=> running but not so good!

eye = Eagle.new
eye.walk
=> walking...
eye.run
=> running...
~~~


De plus ce principe est dynamique, il est possible d'ajouter des méthodes après coup au module
(comme les classes sont ouvertes, les modules aussi). Et les objets déjà créés peuvent directement
utiliser ces méthodes.

### Polymorphisme

Ruby prend les concepts orientés objets très au sérieux (origine Smalltalk, Alan Kay), l'appel de méthode n'est qu'un _moyen_
de communication entre deux objets. C'est le concpet de _message passing_.

Chaque objet peut envoyer n'importe quel message à un objet destinataire, c'est à ce dernier de choisir quoi faire avec.
Pour rephraser, un objet peut appeler n'importe quelle méthode sur un receveur:

~~~ ruby
 # `self` est l'objet envoyeur
 # `target` est l'objet receveur
 # `do_it` est le message
 target.do_it
~~~

Fort de ce concept, le polymorphisme est automatique, il n'y a pas besoin des `interface` à la C#, Java ou PHP.

#### Duck Typing

De ce fait, si un objet marche comme un canard, fait coin-coin comme un canard, alors **c'est un** canard.

~~~ ruby
class Duck
  ...

  def waddle
    ...
  end
  
  def quack
    ...
  end
end

class Elephant
  ...

  def waddle
    ...
  end
  
  def quack
    ...
  end
end

def is_it_a_duck?(duck)
  # does it waddle?
  duck.waddle
  
  # does it quack?
  duck.quack
  
  # been through until here? It's a duck
  true
rescue
  # Exception caught, it's not a duck
  false
end

a = Duck.new
b = Elephant.new
c = String.new

is_it_a_duck?(a)  # => true
is_it_a_duck?(b)  # => true
is_it_a_duck?(c)  # => false

~~~
