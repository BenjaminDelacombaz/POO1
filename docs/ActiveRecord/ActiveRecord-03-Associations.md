# Associations
<!-- .slide: data-state="heading" -->

![Associations](ActiveRecord/associations.jpg){:.heading}
 

## Principes

On _déclare_ l'association dans le corps de la classe du modèle.
(Merci ruby, ceci appelle la méthode de classe `has_many`)

~~~ ruby
class Car < ActiveRecord::Base
  has_many :wheels
end
~~~

Ceci a pour effet d'ajouter plusieurs méthodes (d'instance) afin de pouvoir manipuler la relation comme un objet.
Pour ce `has_many` les méthodes sont:

~~~ ruby
  def wheels(force_reload = false)
  end
  
  def wheels=(objects)
  end
~~~
 

## Principes (bis)

Voici comment l'utiliser

~~~ irb
>> titine = Car.first
=> #<Car id: 1, color: "white">
>> titine.wheels
=> [#<Wheel id: 1, car_id: 1, size: 15>, #<Wheel id: 2, car_id: 1, size: 15>]  
~~~

Comment AR arrive-t-il à sortir ces enregistrement avec si peu d'indications?
**Conventions de nommage**
<!-- .element: class="fragment" -->

`has_many :wheels` permet de _trouver_ que les objets associés sont des `Wheel`.
La jointure SQL doit connaître la clé étrangère, il se trouve que `has_many` est appelé dans la classe `Car` ce qui permet de générer
`car_id`.

<!-- .element: class="fragment" -->

~~~ ruby
class Car < ActiveRecord::Base
  has_many :wheels, class_name: 'Wheel', foreign_key: 'car_id'
end
~~~
<!-- .element: class="fragment" -->

La doc de référence de `has_many` sur [RoR](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-has_many) ou
[API Dock](http://apidock.com/rails/ActiveRecord/Associations/ClassMethods/has_many)

<!-- .element: class="fragment small" -->
 

## Association 1 - N

![](ActiveRecord/assoc_cars_wheels.png){:.uml}
<!-- http://yuml.me/diagram/scruffy;scale:120/class/[cars|id;color{bg:orange}]1-n[wheels|id;car_id;size{bg:orange}].svg -->

~~~ ruby
class Car < ActiveRecord::Base
  has_many :wheels
end

class Wheel < ActiveRecord::Base
  belongs_to :car
end
~~~
 

## Association 1 - 1

![](ActiveRecord/assoc_cars_engines.png){:.uml}
<!-- http://yuml.me/diagram/scruffy;scale:120/class/[cars|id;color{bg:orange}]1-1[engines|id;car_id;power{bg:orange}].svg -->

~~~ ruby
class Car < ActiveRecord::Base
  has_one :engine
end

class Engine < ActiveRecord::Base
  belongs_to :car
end
~~~
 

## Association N - N directe

![](ActiveRecord/assoc_cars_accessories.png){:.uml}
<!-- http://yuml.me/diagram/scruffy;scale:120/class/[cars|id;color{bg:orange}]1-n[accessories_cars|car_id;accessory_id{bg:green}],[accessories_cars|car_id;accessory_id{bg:green}]n-1[accessories|id;kind;description{bg:orange}].svg -->

~~~ ruby
class Car < ActiveRecord::Base
  has_and_belongs_to_many :accessories
end

class Accessory < ActiveRecord::Base
  has_and_belongs_to_many :cars
end
~~~
 

## Association N - N indirecte

![](ActiveRecord/assoc_cars_equipments.png){:.uml}
<!-- http://yuml.me/diagram/scruffy;scale:120/class/[cars|id;color{bg:orange}]1-n[car_equipments|id;car_id;accessory_id;offered{bg:green}],[car_equipments|id;car_id;accessory_id;offered{bg:green}]n-1[accessories|id;kind;description{bg:orange}].svg -->

~~~ ruby
class Car < ActiveRecord::Base
  has_many :car_equipments
  has_many :accessories, through: :car_equipments
end

class Accessory < ActiveRecord::Base
  has_many :car_equipments
  has_many :cars, through: :car_equipments
end

class CarEquipment < ActiveRecord::Base
  belongs_to :car
  belongs_to :accessory
end
~~~
 

## Exemples ##

~~~ ruby
car = Car.first

puts car.wheels.count 

puts car.accessories
~~~

~~~ sql
SELECT `cars`.* FROM `cars` LIMIT 1

SELECT COUNT(*) FROM `wheels` WHERE `wheels`.`car_id` = 1

SELECT `accessories`.* FROM `accessories`
  INNER JOIN `accessories_cars`
  ON `accessories`.`id` = `accessories_cars`.`accessory_id`
  WHERE `accessories_cars`.`car_id` = 1
~~~
<!-- .element: class="fragment" -->
 

## Exemples ##

~~~ irb
>> car = Car.first
=> #<Car id: 1, color: "white">
>> car.wheels.count
=> 2
>> car.accessories
=> []
>> car.accessories << Accessory.find_by(name: 'autoradio')
=> [#<Accessory id: 1, name: "autoradio", kind: nil, description: "Radio">]
>> car.accessories
=> [#<Accessory id: 1, name: "autoradio", kind: nil, description: "Radio">]
>> car.accessories.delete(Accessory.find_by(name: 'autoradio'))
=> [#<Accessory id: 1, name: "autoradio", kind: nil, description: "Radio">]
>> car.accessories
=> []
~~~
 

## Associations lointaines ##

has_many :through
has_one :through
belongs_to :through ???

 

## Gestion des dépendances ##

dependant => :

Avec :destroy, cascade des dépendances => bien!

 

## Requêtage

Sur des associations de collections (`has_many` et `has_and_belongs_to_many`), il est possible d'utiliser
toutes les méthodes de requêtage déjà vue.

Exemple:

~~~ ruby
Car.first.accessories.where('price < ?', 20).order(:name)
~~~

