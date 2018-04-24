# Scopes & Eager loading
<!-- .slide: data-state="heading" -->

![](ActiveRecord/scopes.jpg){:.heading}
 

## Pré-chargement (Eager&nbsp;loading) ##

But: Eviter le problème des requêtes 1+N

~~~ ruby
cars = Car.all

cars.each do |car|
  puts car.wheels.join(',')
end
~~~

~~~ sql
SELECT `cars`.* FROM `cars`
 
SELECT `wheels`.* FROM `wheels` WHERE `wheels`.`car_id` = 1
SELECT `wheels`.* FROM `wheels` WHERE `wheels`.`car_id` = 2
SELECT `wheels`.* FROM `wheels` WHERE `wheels`.`car_id` = 3
SELECT `wheels`.* FROM `wheels` WHERE `wheels`.`car_id` = 4
~~~
<!-- .element: class="fragment" -->
 

## Pré-chargement (Eager&nbsp;loading) ##

Solution

~~~ ruby
cars = Car.includes(:wheels).all

cars.each do |car|
  puts car.wheels.join(',')
end
~~~

~~~ sql
SELECT `cars`.* FROM `cars`

SELECT `wheels`.* FROM `wheels` WHERE `wheels`.`car_id` IN (1,2,3,4)
~~~
<!-- .element: class="fragment" -->
 

## Resserrer le périmètre (scopes) ##

But: Se définir des périmètres métiers

- se définit sur le modèle où l’on désire le resserrement.
- on utilise les mêmes méthodes que pour la recherche.

~~~ ruby
class Car < ActiveRecord::Base
  scope :white, -> { where(color: 'white') }

  scope :small_wheels,
    -> { joins(:wheels).where('wheels.size' => 13).group(:id) }

  scope :wheels_with_size,
    ->(size) {
      joins(:wheels).where('wheels.size' => size).group(:id)
    }
end
~~~
 

## Scopes: Utilisation ##

Utilisation: comme les méthodes pour la recherche

~~~ ruby
puts Car.white

puts Car.wheels_with_size(13)

puts Car.wheels_with_size(13).white
~~~

~~~ sql
SELECT `cars`.* FROM `cars` WHERE `cars`.`color` = 'white'

SELECT `cars`.* FROM `cars` INNER JOIN `wheels`
  ON `wheels`.`car_id` = `cars`.`id`
  WHERE `wheels`.`size` = 13 GROUP BY id

SELECT `cars`.* FROM `cars` INNER JOIN `wheels`
  ON `wheels`.`car_id` = `cars`.`id`
  WHERE `wheels`.`size` = 13 AND `cars`.`color` = 'white'
  GROUP BY id
~~~
<!-- .element: class="fragment" -->
 

## Scopes: méthodes? ##

En réalité la méthode `scope` sur `ActiveRecord::Base`
n'est qu'un raccourci syntaxique qui définit une méthode
de classe. Ces deux définitions sont identiques:

~~~ ruby
class Car < ActiveRecord::Base
  scope :white, -> { where(color: 'white') }
  
  def self.white
    where(color: 'white')
  end
end
~~~

