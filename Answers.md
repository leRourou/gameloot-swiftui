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
J'obtiens dans la console l'erreur `ForEach<Array<String>, String, Text>: the ID Magie de feu occurs multiple times within the collection, this will give undefined results!`.
Cette erreur s'explique par le fait que les items rajoutés aient tous le même nom, ainsi SwiftUI ne peut pas déterminer l'identifiant unique pour chaque élément dans le ForEach. Il s'attend à ce que chaque élément ait un identifiant unique, mais avec deux éléments portant la même valeur, cela crée une ambiguïté.

### 🔧 Exercice 3
Dans la vue `AddItemView`, on ajoute un `@EnvironmentObject` :
```swift
@EnvironmentObject var inventory : Inventory
```
Puis on appelle la méthode `addItem` de la classe `Inventory` avec comme paramètre le nom de l'item donné par l'utilisateur dans le `TextField`
```swift
Button(action: {
        inventory.addItem(item: $name.wrappedValue)
}, label: {
        Text("Ajouter")
})
```

### 🔧 Exercice 4
On instancie une variable `dismiss` de type `DismissAction` grâce à `@Environment`. 
```swift
@Environment(\.dismiss) private var dismiss
```
On appelle `dismiss()` lors de l'ajout d'un item, cela a pour effet de fermer la vue.
```swift
Button(action: {
        inventory.addItem(item: $name.wrappedValue)
        dismiss()
}, label: {
        Text("Ajouter")
})
```

## Partie 2 - Un meilleur inventaire 👑
### 🔧 Exercice 1
Enum `LootItem` :
```swift
struct LootItem: Identifiable, Hashable {
    let id: UUID = UUID()
    var quantity: Int = 1
    var name: String
    var type: ItemType
    var rarity: Rarity
    var attackStrength: Int?
    var game: Game

    // On rajoute un item vide statique accessible sans instancier la classe.
    static var emptyLootItem = LootItem(
        name: "",
        type: ItemType.unknown,
        rarity: Rarity.common,
        attackStrength: 0,
        game: Game.emptyGame
    )
}
```

### 🔧 Exercice 2
On créé une nouvelle structure :
```swift
struct InventoryListItem: View {
    public var item: LootItem
    var body: some View {
        NavigationLink {
            LootDetailView(item: item)
        } label: {
            HStack(alignment: .center, spacing: 3) {
                Image(systemName: "circle.fill")
                    .renderingMode(.template)
                    .foregroundColor(item.rarity.getColor())
                Text("\(item.type.getEmoji()) \(item.name)")
            }
        }
    }
}
```
L'erreur sur `Identifiable` apparaît car les éléments du ForEach doivent être uniques et idetnifiables par une valeur, comme un ID. Or, on ne passe aucune valeur de ce genre.
```swift
struct LootItem: Identifiable, Hashable {
    let id: UUID = UUID() // On rajoute l'ID sous forme d'UUID, un type de données dont l'unicité est garantie
    var quantity: Int = 1
    var name: String
    var type: ItemType
    var rarity: Rarity
    var attackStrength: Int?
    var game: Game
    
    static var emptyLootItem = LootItem(
        name: "",
        type: ItemType.unknown,
        rarity: Rarity.common,
        attackStrength: 0,
        game: Game.emptyGame
    )
}
```

### 🔧 Exercice 3
```swift
struct AddItemView: View {
    @State private var lootItem: LootItem = LootItem.emptyLootItem
    @State private var isAttackItem: Bool = false
    @EnvironmentObject private var inventory: Inventory
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Section {
                TextField("Nom de l'objet", text: $lootItem.name)
                Picker("Rareté", selection: $lootItem.rarity) {
                    ForEach(Rarity.allCases, id: \.self) { rarity in
                        HStack(alignment: .center, spacing: 3) {
                            Text(String(describing: rarity).capitalized)
                        }
                    }
                }
            }
            Section {
                Picker("Jeu", selection: $lootItem.game) {
                    ForEach(MockData.availableGames, id: \.self) { game in
                        Text(game.name)
                    }
                }
                
                
                Stepper("Combien : \(lootItem.quantity)", value: $lootItem.quantity, in: 0...100, step: 1)}
            
            Section {
                Toggle("Item d'attaque ?", isOn: Binding(
                    get: { lootItem.attackStrength != nil },
                    set: { newValue in
                        if newValue {
                            lootItem.attackStrength = 0
                        } else {
                            lootItem.attackStrength = nil
                        }
                    }
                ))
                
                Group {
                    if lootItem.attackStrength != nil {
                        Stepper("Force d'attaque : \(lootItem.attackStrength!)", value: Binding(
                            get: { lootItem.attackStrength ?? 0 },
                            set: { newValue in lootItem.attackStrength = newValue }
                        ), in: 0...100, step: 1)
                    }
                }
            }

            
            Section {
                Text("Type : " + $lootItem.type.wrappedValue.getEmoji())
                Picker("Type", selection: $lootItem.type) {
                    ForEach(ItemType.allCases, id: \.self) { tag in
                        Text(tag.getEmoji())
                    }
                }.pickerStyle(.palette)
                
            }
            
            
            Button(action: {
                inventory.addItem(item: lootItem)
                dismiss()
            }, label: {
                Text("Ajouter l'objet")
            })
        }
    }
}
```

## Partie 6 - Remplir la vue de détail du Loot
### 🔧 Exercice 2
Voici la struct de `LootDetailView`: 
```swift
struct LootDetailView: View {
    public var item: LootItem
    
    var body: some View {
        Rectangle()
            .fill(Color(item.rarity.getColor()))
            .frame(width: 150, height: 150)
            .cornerRadius(20)
            .shadow(color: Color(item.rarity.getColor()), radius: 40)
            .overlay(
                Text(item.type.getEmoji())
                    .font(.system(size: 80))
                    .foregroundColor(.white)
            )
            .padding(.bottom, 50)
        Text(item.name)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .font(.system(size: 36))
            .foregroundStyle(Color(item.rarity.getColor()))
        if (item.rarity == Rarity.unique) {
            VStack() {
                Rectangle()
                    .fill(item.rarity.getColor())
                    .cornerRadius(20)
                    .frame(height: 50)
                    .padding(10)
                    .overlay(
                        Text("Item Unique 🏆")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    )
            }
        }
        VStack(
        ) {
            List() {
                Section(
                    header: Text("INFORMATIONS")
                ) {
                    HStack {
                        if let cover = item.game.coverName {
                            Image(cover)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 58)
                                .clipShape(.rect(cornerRadius: 4))

                        } else {
                            Image(systemName: "rectangle.slash")
                                .scaledToFit()
                                .frame(height: 58)
                                .padding(Edge.Set.horizontal, 8)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [.gray]), startPoint: .top, endPoint: .bottom)
                                )
                                .clipShape(.rect(cornerRadius: 4))
                                .foregroundStyle(Color.black)
                                .opacity(0.4)

                        }

                        Text("Game: \(item.game.name)")
                    }
                    HStack {
                        Text("In-game: \(item.name)")
                    }
                    HStack {
                        Text("Puissance (ATQ): \(item.attackStrength!)")
                    }
                    HStack {
                        Text("Possédé(s): \(item.quantity)")
                    }
                    HStack {
                        Text("Rareté : \(item.rarity.getString())")
                    }
                }
            }
        }
    }
}
```
