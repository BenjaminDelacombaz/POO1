# Introduction
<!-- .slide: data-state="heading" -->

Ce document présente le pattern **ActiveRecord** comme définit par [Martin Fowler](http://martinfowler.com/eaaCatalog/activeRecord.html).

L'implémentation utilisée est celle en Ruby.
 

## DAL: Data Access Layer

Tout logiciel possèdent une couche d'accès aux données.
On la nomme `DAL`. Ceci est le terme général.

![DAL](ActiveRecord/dal.jpg)

Il est possible d'implémenter son DAL de façons très différentes.

Voici quelques-unes d'entre-elles
 

## RecordSet

Exemple dans un langage *curly braces*:

~~~ java
DbConnection connection = new DbConnection("adapter:mysql;hostname=localhost;username=root;password:'';database=poo1_shop");
connection.Open();

DbResult result = connection.Execute("SELECT * FROM products");
while (!result.IsEmpty()) {
  DbRecordSet record = result.Next();
  
  print(record['name']);
  print(record['price']);
}
~~~

+ Simple (simpliste ?)
{: .advantage \n}

- SQL partout dans le code de l'application
{: .disadvantage \n}
 

## Table Data Gateway

~~~ java
class ProductGateway {
  public DbResult findAll();
  public DbResult findAllByPriceLowerThan(Money threshold);
  public DbRecordSet findById(int id);
  public void update(string name, Money price);
  public void insert(int id, string name, Money price);
  public void delete(int id);
}
~~~

+ Code SQL localisé dans le Gateway
{: .advantage \n}

- Pas de DomainObject
{: .disadvantage \n}
 

## Row Data Gateway

~~~ java
class Product {
  protected int id;
  protected string name;
  protected Money price;
  
  public Product(int id)   { this.id = id; }
  public int    getId()    { return id; }
  public string getName()  { return name; }
  public void   setName(string value) { name = value; }
  public string getPrice() { return price; }
  public void   setPrice(Money value) { price = value; }
  
  public void insert();
  public void update();
  public void delete();
}
~~~

~~~ java
class ProductFinder {
  public Array<Product> findAll();
  public Product findById(int id);
}
~~~

+ DomainObject pour les produits
{: .advantage \n}

- Il faut une classe supplémentaire pour les *finders*
{: .disadvantage \n}
 

## Data Mapper (ORM)

~~~ java
class Product {
  protected int id;
  protected string name;
  protected Money price;
  
  public Product(int id) { this.id = id; }
  public int getId() { return id; }
  
  public string getName() { return name; }
  public void   setName(string value) { name = value; }
  
  public string getPrice() { return price; }
  public void   setPrice(Money value) { price = value; }
}

class ProductMapper {
  public Array<Product> findAll();
  public Product findById(int id);
  public void update(Product product);
  public void insert(Product product);
  public void delete(Product product);
}
~~~

+ DomainObject pour les produits
+ DomainObject découplé de la stratégie de persistance
{: .advantage \n}

- Utilisation de la classe Mapper pour toutes les opérations de persistance
{: .disadvantage \n}
 

## ActiveRecord (ORM)

*Row Data Gateway* + méthodes de *Business Logic* dans la même classe.

+ DomainObject pour les produits
+ Méthodes de persistance dans les DomainObjects
{: .advantage \n}

- DomainObject couplé à la stratégie de persistance
{: .disadvantage \n}
 

## Connexion

~~~ ruby
require 'active_record'

ActiveRecord::Base.establish_connection(
	adapter:  'mysql2',
	host:     'localhost',
	username: 'root',
	password: '',
	database: 'poo1_shop'
)
~~~
 

## Exemple

~~~ ruby
class Product < ActiveRecord::Base
end
~~~

Découvre les champs de la table *automatiquement*.
Comment? **Conventions de nommage**
<!-- .element: class="fragment" -->

<!-- .element: class="fragment" -->

La table doit être nommée comme le nom de la classe mais
en minuscule et au pluriel => `products`

<!-- .element: class="fragment" -->

Pas content? Pas de problème, mais alors il faut être explicite:
<!-- .element: class="fragment" -->

~~~ ruby
class Product < ActiveRecord::Base
  self.table_name = 'TBL_LEGACY_PRODUCT'
end
~~~
<!-- .element: class="fragment" -->

