# RESTfulness
<!-- .slide: data-state="heading" -->

![RESTfulness](MVC/restfulness.jpg){:.heading}
 

## Pourquoi?

MVC a permis d'organiser son code de manière clair. Ceci permet de reprendre facilement 
le code d'autres développeurs.

Etant donné que la plupart des opérations que l'on fait sur ses modèles sont du CRUD,
on peut aller encore plus loin en définissants nos controlleurs comme controlleur
de **ressources**.

Ceci permet encore un meilleur découpage du système et donc facilite la maintenance
ainsi que l'accessibilités.
 

## C'est quoi REST?

[How I explained REST to my wife](http://www.looah.com/source/view/2284)

[Comment j’ai expliqué REST à ma femme](http://www.pompage.net/traduction/comment-j-ai-explique-rest-a-ma-femme)
 

## URI, URL, URN, Urghhh!

**U**niform **R**esource **Identifier**  
**U**niform **R**esource **Locator**  
**U**niform **R**esource **Name**  

{:.put-left}

![URI](MVC/uri.png)
{:.put-right}

                        hierarchical part
            ┌───────────────────┴─────────────────────┐
                        authority               path
            ┌───────────────┴───────────────┐┌───┴────┐
      abc://username:password@example.com:123/path/data?key=value#fragid1
      └┬┘   └───────┬───────┘ └────┬────┘ └┬┘           └───┬───┘ └──┬──┘
    scheme  user information     host     port            query   fragment
    
      urn:example:mammal:monotreme:echidna
      └┬┘ └──────────────┬───────────────┘
    scheme              path
 

## RESTful routes

| Verb      | Path                    | Rails   | Laravel | Description
|-----------|-------------------------|---------|---------|------------
| GET       | /resources              | index   | index   | Display a list of resources
| GET       | /resources/{create,new} | new     | create  | Form for resource creation
| POST      | /resources              | create  | store   | Create a new resource
| GET       | /resources/:id          | show    | show    | Display a specific resource
| GET       | /resources/:id/edit     | edit    | edit    | Form for resource edition 
| PUT/PATCH | /resources/:id          | update  | update  | Update a specific resource
| DELETE    | /resources/:id          | destroy | destroy | Delete a specific resource
{: .simple}
 

### La 8ème roue du carrosse

Chaque action modifiante possède _deux_ routes:

1. Une pour présenter la resource à modifier à l'utilisateur
2. L'autre pour faire la modification proprement dite

~~~
GET /resource/{id}/edit
PUT /resource/{id}
~~~

<!-- .element: class="fragment" -->

Pour la suppression d'une resource, il n'existe que l'opération de modification:

<!-- .element: class="fragment" -->

    DELETE /resource/{id}

<!-- .element: class="fragment" -->

Il nous manque donc

<!-- .element: class="fragment" -->

    GET /resource/{id}/delete

<!-- .element: class="fragment" -->

Pourquoi?

<!-- .element: class="fragment" -->

_ Tout simplement parce que la plupart du temps, le lien qui pointe vers l'action de suppression demande
une confirmation en javascript. Du coup, inutile de présenter la resource à supprimer avant.

Ceci nous amène donc dans certains cas à ajouter cette route manquante lorsque l'on sait que le javascript peut
être non actif.
 

### Ressources uniques

Certaines ressources sont uniques, les routes sont différentes puisqu'il n'y a pas d'**id**.

| Verb      | Path                   | Rails   | Description
|-----------|------------------------|---------|------------
| GET       | /resource              | show    | Display the resource
| GET       | /resource/{create,new} | new     | Form for the resource creation
| POST      | /resource              | create  | Create the resource
| GET       | /resource              | show    | Display the resource
| GET       | /resource/edit         | edit    | Form for the resource edition 
| PUT/PATCH | /resource              | update  | Update the resource
| DELETE    | /resource              | destroy | Delete the resource
{: .simple}

_ Cette spécificité n'est gérée nativement que par certains frameworks. Pour les autres, à vous
de mettre en place une convention pour les routes et actions.
 

### Ressources imbriquées (Nested resources)

Il arrive souvent qu'une ressource soit dépendante d'une autre, ou plutôt que cette ressource soit imbriquée
dans une autre, deux exemples:

* `Article`: article du blog
  * `Comment`: les commentaires _liés_ à cet article


* `Category`: Une catégorie de produit
  * `Product`: les produits dans cette catégorie

 

#### Fully nested routes

| Verb   | Path                           | Action  | Description
|--------|--------------------------------|---------|------------
| GET    | /articles/123/comments         | index   | Comments list for this article
| POST   | /articles/123/comments         | create  | Create a comment for this article
| GET    | /articles/123/comments/76      | show    | Display the single comment
| GET    | /articles/123/comments/76/edit | edit    | Form to edit the comment
{: .simple}

#### Shallow routes

| Verb   | Path                     | Action  | Description
|--------|--------------------------|---------|------------
| GET    | /categories/23/products  | index   | List products of this category
| POST   | /categories/23/products  | create  | Create a product in this category
| GET    | /products/42             | show    | Display the product
| GET    | /products/42/edit        | edit    | Form to edit the product
{: .simple}
 

## Exemple

Si on s'en tient à des ressources _RESTful_, il est rare de devoir ajouter des `actions` personnalisées.
Il suffit de trouver la **nouvelle** ressource exposée et de l'exprimer en termes **CRUD**iens.

L'exemple typique est le *login* *logout*, sans trop réflechir on se dit qu'il faut simplement ajouter
ces deux actions dans le `UsersController`.

<!-- .element: class="fragment" -->

**FAUX!** Enfin pas *RESTful!*

<!-- .element: class="fragment" -->

Cette fois ci en reflechissant, le login et le logout n'ont rien à voir avec la gestion des utilisateurs
(CRUD), donc pourquoi ajouter des actions dans ce controlleur?

<!-- .element: class="fragment" -->
 

### Login, logout

En réalité un `login` en terme de ressource est la _création_ d'une nouvelle session,  
le `logout` est la _destruction_ de cette session.

On se dirige donc vers un `SessionsController` avec:

| Action    | Description
|-----------|----------------------
| new       | Formulaire de login
| create    | Soumission du formulaire de login
| destroy   | Logout
{: .simple}
 

La mise à jour d'une session n'a pas de sens, il n'a donc pas ces actions, par contre on peut imaginer ce
que peut montrer les actions suivantes:

| Action    | Description
|-----------|----------------------
| index     | Lister les sessions courantes (les utilisateurs actuellement connectés)
| show      | Afficher les détails de la session: temps de connexion, type de connexion (credentials, OAuth, cookie, ...)
{: .simple}

