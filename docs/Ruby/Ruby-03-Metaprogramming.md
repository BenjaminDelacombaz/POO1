# Métaprogrammation

La méta-programmation est le fait de programmer par le programme.

Il s'agit donc de code qui écrit (et fait exécuter) du code. Une variante s'appelle le code auto-modifiant (self modifying code).

Afin de pouvoir réaliser ceci, il faut des moyens d'introspection du code pendant l'exécution, ceci s'appelle en général la **réflexion**.

## Réflexion

Une des premières questions que l'on se pose est

> De quelle classe est cet objet?

~~~ irb
>> "Hello".class
=> String
~~~

La méthode `class` nous renseigne! Attention: elle renvoie bien un objet, pas une chaine de caractères.

### Méthodes

En ayant un object de type `Class` a disposition, on peut lui demander quelles sont les méthodes qu'il possède:

~~~ irb
>> String.instance_methods
=> [:<=>, :==, :===, :eql?, :hash, :casecmp, :+, :*, ..., :length, :size, ...]
~~~

Nous avons demandé ici les méthodes d'instances, donc les méthodes que l'on peut appeler sur un **objet** de type `String`.

Il est également possible d'obtenir les méthodes que l'on peut appeler directement sur la classe:

~~~ irb
>> String.methods
=> [:try_convert, :allocate, :new, :superclass, :freeze, :===, ...]
~~~

Par ce biais, il est possible d'obtenir les méthodes que l'on peut appeler sur n'importe quel objet, donc si je demande les
méthodes qu'il existe sur un objet chaine de caractères, j'obtient la même chose que si je demande les méthodes d'instances
sur la classe `String`:

~~~ irb
>> "Hello".methods
=> [:<=>, :==, :===, :eql?, :hash, :casecmp, :+, :*, ..., :length, :size, ...]
>> # Preuve
>> "Hello".methods == String.instance_methods
=> true
~~~

### Hierarchie

Il peut être intéressant de connaitre le parent ou les ancêtres d'une classe:

~~~ irb
>> String.superclass
=> Object
>> String.ancestors
=> [String, Comparable, Object, Kernel, BasicObject]
~~~


## Modification de code

### Classes

Class.new() {}

Class.class_eval {}

Class.class_eval <<EOC

### Méthodes

Class.define_method {}

Class.remove_method
Class.undef_method

### Objets

def object.new_method
end

objet.define_singleton_method {}

## Accès aux données

instance_variable_*


