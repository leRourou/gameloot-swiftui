# SwiftUI

## Partie 2 - Looter

### 🔧 Exercice 1
Le problème ici est que les éléments du tableau `loot` n'ont pas de moyen de se différencier entre eux. En effet `List` requiert que les éléments du tableau soient identifiables.
La solution ici serait de créer un nouveau `struct` héritant de `Identifiable` avec 2 propriétés : `id` de type `UUID` et `value` de type `String`, l'UUID, instancié lors de la création d'un objet de type `Loot` nous garantie que les données seront uniques et identifiables.

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

### 🔧 Exercice 2
En plus d'avoir ajouté la fonction `addItem()`, vous avez également ajouté un bouton avec le composant `Button`. Enfin, vous avez remplacé le composant `List` par un `ForEach` renvoyant un composant `Text` et encapsulé le tout dans un composant `List`.
Cela a pour objectif de créer une liste de loots, mais avec comme différence que le premier élément de la liste est un bouton permettant d'appeler la fonction de rajout.


### 🔧 Exercice 3
Ce code ne fonctionne pas à cause du caractère immutable de la liste `loot`: cela signifie qu'elle ne peut pas être modifiée.
En placant `@State` devant la liste `loot`, on déclare la liste comme un état de l'application. Cela signifie qu'elle peut être modifiée, et que sa modification entraînera un re-rendu du composant.


