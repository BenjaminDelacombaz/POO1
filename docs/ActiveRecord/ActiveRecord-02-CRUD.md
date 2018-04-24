# CRUD
<!-- .slide: data-state="heading" -->

![CRUD](ActiveRecord/crud.jpg){:.heading}
 

## Create ##

~~~ irb
>> titine = Car.new
=> #<Car id: nil, color: nil>
>> titine.color = 'red'
=> "red"
>> titine
=> #<Car id: nil, color: "red">
>> titine.save
=> true
~~~

~~~ irb
>> titine = Car.new(color: 'red')
=> #<Car id: nil, color: "red">
>> titine.save
=> true
~~~
<!-- .element: class="fragment" -->

~~~ irb
>> titine = Car.create(color: 'red')
=> #<Car id: 5, color: "red">
~~~
<!-- .element: class="fragment" -->
 

## Read ##

~~~ irb
>> Car.find 2
=> #<Car id: 2, color: "red">
>> Car.all
=> [#<Car id: 1, color: "white">, #<Car id: 2, color: "red">, #<Car id: 3, color: nil>, #<Car id: 4, color: "red">]
>> Car.first
=> #<Car id: 1, color: "white">
>> Car.last
=> #<Car id: 4, color: "red">
~~~

Obtenir un objet par un ou plusieurs de ses attributs: <!-- .element: class="fragment" -->

~~~ irb
>> Car.find_by color: 'white'
=> #<Car id: 1, color: "white">
>> Engine.find_by power: 130
=> #<Engine id: 1, car_id: 2, power: 130, brand: "Porsche">
>> Engine.find_by power: 130, brand: 'GM'
=> #<Engine id: 3, car_id: 4, power: 130, brand: "GM">
~~~
<!-- .element: class="fragment" -->
 

## Update ##

~~~ irb
>> titine = Car.create(color: 'red')
=> #<Car id: 5, color: "red">
>> titine.color = 'yellow'
=> "yellow"
>> titine.save
=> true
~~~

~~~ irb
>> titine = Car.first
=> #<Car id: 1, color: "white">
>> titine.color = 'black'
=> "black"
>> titine.save
=> true
~~~
<!-- .element: class="fragment" -->

~~~ irb
>> titine = Car.first
=> #<Car id: 1, color: "white">
>> titine.update(color: 'black')
=> true
~~~
<!-- .element: class="fragment" -->
 

## Delete ##

~~~ irb
>> titine = Car.last
=> #<Car id: 5, color: "red">
>> titine.destroy
=> #<Car id: 5, color: "red">
>> Car.find(5)
ActiveRecord::RecordNotFound: Could not find Car with id=5
>> titine.color = 'white'
TypeError: can't modify frozen hash
>> titine
=> #<Car id: 5, color: "red">
~~~
 

## Recherche ##

~~~ irb
>> Car.where("color = 'red'")
=> [#<Car id: 2, color: "red">, #<Car id: 4, color: "red">]
>> user_form_color = 'red'
=> "red"
>> Car.where("color = '#{user_form_color}'")
=> [#<Car id: 2, color: "red">, #<Car id: 4, color: "red">]
~~~

~~~ irb
>> user_form_color = "' OR 1 AND id = 1) -- "
=> "' OR 1 AND id = 1) -- "
>> Car.where("color = '#{user_form_color}'")
=> [#<Car id: 1, color: "white">]
~~~
<!-- .element: class="fragment" -->

~~~ irb
>> Car.where('color = ?', user_form_color)
=> []
~~~
<!-- .element: class="fragment" -->

~~~ irb
>> Car.where(color: 'red')
=> [#<Car id: 2, color: "red">, #<Car id: 4, color: "red">]
~~~
<!-- .element: class="fragment" -->
 

## Requêtage ##

### `order`

### `limit` & `offset`

### `group` & `having`

### `distinct`

### `pluck`
 
~~~ irb
>> Engine.distinct.pluck(:brand)
=> ["Porsche", "VW", "GM"]
~~~

