# Best Practices
<!-- .slide: data-state="heading" -->

![CRUD](MVC/follow-the-rules-you-must.jpg){:.heading}
 

## May the _verb_ be with you

Les actions executées en réponses aux requêtes doivent respecter l'intention du verbe HTTP:

* `GET`: **Aucune modification** des données persistées ou état

* `POST`, `PUT`: Ok pour modifier des données ou états

A ne pas confondre avec les requêtes __Idempotante__ 
(peuvent être jouées plusieurs fois sans que le résultat ne change.)

<!-- .element: class="fragment" -->

* `GET`
* `DELETE`
* parfois `PUT`

<!-- .element: class="fragment" -->
 

### Exemple

Mauvais:
```php
Route::get('/visits/{id}/delete', 'VisitsController@delete');
```

Juste:
```php
Route::post('/visits/{id}/delete', 'VisitsController@delete');
```

<!-- .element: class="fragment" -->
 

## Use the _route_ Luke

La gestion des routes est faite par le framework, par gestion on entend:

- le dispatch
- **la génération pour les URL**
<!-- .element: class="fragment" -->
 

### Exemple

Mauvais:
```html
<form id='textedit' method="post" action="/visits/34/edit">
```

Juste:
```html
<form id='textedit' method="post" action="<?= route('visits.edit', ['id' => 34]) ?>">
```

<!-- .element: class="fragment" -->
 

## Don’t underestimate the _Controller_

Les contrôleurs:

* reçoivent les requêtes
* préparent les données
* les renvoient (vue ou data)

Il n'y donc pas _forcément_ une correspondance 1-1 entre modèle et contrôleur.
 

Même si elles gèrent les même données, il faut différencier:

* la partie _front_ pour les utilisateurs ciblés
* la partie _back_ (back-office) pour les gestionnaires

Nous aurons donc jusqu'à 3 contrôleurs pour une même ressource:

<!-- .element: class="fragment" -->

* `ArticlesController` (front)
* `Admin::ArticlesController` (back-office)
* `Api::ArticlesController` (API)

<!-- .element: class="fragment" -->

