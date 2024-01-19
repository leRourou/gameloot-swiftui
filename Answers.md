# SwiftUI

## Partie 2 - Looter

### 🔧 Exercice 1
Le problème ici est que les éléments du tableau `loot` n'ont pas de moyen de se différencier entre eux. En effet `List` requiert que les éléments du tableau soient identifiables.
Une solution ici serait de créer un nouveau `struct` héritant de `Identifiable` avec 2 propriétés : `id` de type `UUID` et `value` de type `String`, l'UUID, instancié lors de la création d'un objet de type `Loot` nous garantie que les données seront uniques et identifiables.

```swift
struct Loot: Identifiable {
        let id = UUID();
        let value: String;
    }
    
    var lootList: [Loot] = [
        Loot(value: "Epée"),
        Loot(value: "Bouclier"),
        Loot(value: "Armure")
    ]

    var body: some View {
        List(lootList) { item in
            Text(item.value)
        }
    }
```

Une autre solution consisterait à utiliser plutôt un `ForEach` qu'une `list`:
```swift
ForEach(loot, id: \.self) { item in
        Text(item)
}
```
Cela permet de rendre chaque itération unique et identifiable par un ID.


### 🔧 Exercice 2
En plus d'avoir ajouté la fonction `addItem()`, vous avez également ajouté un bouton avec la vue `Button`. Enfin, vous avez remplacé la vue `List` par un `ForEach` renvoyant une vue `Text` et encapsulé le tout dans une vue `List`.
Cela a pour objectif de créer une liste de loots, mais avec comme différence que le premier élément de la liste est un bouton permettant d'appeler la fonction de rajout.


### 🔧 Exercice 3
Ce code ne fonctionne pas à cause du caractère immutable de la liste `loot`: cela signifie qu'elle ne peut pas être modifiée.
En placant `@State` devant la liste `loot`, on déclare la liste comme un état de la vue. Cela signifie qu'elle peut être modifiée, et que sa modification entraînera un re-rendu de la vue.

## Partie 4 - Ajouter un item

### 🔧 Exercice 1
Si l'ajout d'item ne fonctionne pas, c'est parce que le composant n'est pas re-rendu, puisqu'il n'a pas détecté de modifications dans l'état `inventory`.
J'obtiens dans la console l'erreur `ForEach<Array<String>, String, Text>: the ID Magie de feu occurs multiple times within the collection, this will give undefined results!`.
Cette erreur s'explique par le fait que les items rajoutés aient tous le même nom, ainsi SwiftUI ne peut pas déterminer l'identifiant unique pour chaque élément dans le ForEach. Il s'attend à ce que chaque élément ait un identifiant unique, mais avec deux éléments portant la même valeur, cela crée une ambiguïté.


### 🔧 Exercice 2
- On ajoute à la classe `Inventory` le mot-clé `ObservableObject`, pour déclaer que ses propriétés publiées grâce à `@Published` déclenchent automatiquement des mises à jour de l’interface utilisateur lorsqu’elles changent
- On ajoute à la propriété `loot` le mot-clé `@Published`, pour déclarer qu'il s'agit d'une propriété d’un objet observable dont la modification entraîne une mise à jour de l’interface utilisateur.
- On ajoute à l'état `inventory` le mot-clé `@StateObject` pour l'initialiser comme un objet observable en tant que propriété de la vue et garantir qu'ilne sera créé qu'une fois.

```swift
class Inventory: ObservableObject {
    @Published var loot = ["Epée", "Bouclier", "Armure"]
    
    func addItem(item: String) {
        loot.append(item)
    }
}

struct ContentView: View {
    @StateObject var inventory = Inventory()
    @State var showAddItemView : Bool = false;
// ...
```

On utilise `@StateObject`, car il a l'avantage de ne pas être re-créé lors du rendu de la vue, contrairement à `@ObservedState`. On n'utilisera pas non plus `@State` qui n'est pas fait pour accueuillir des objets.
