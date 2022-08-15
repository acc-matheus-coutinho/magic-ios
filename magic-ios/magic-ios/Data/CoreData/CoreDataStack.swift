//
//  CoreDataStack.swift
//  magic-ios
//
//  Created by bruno.luebke.moreira on 22/07/22.
//

import CoreData
import UIKit

class CoreDataStack {

// MARK: - CoreDataStack
    /**
     This computed attribute is responsible to fetch the CoreDataStack instance created at the AppDelegate.
     */
    static var coreDataStack: CoreDataStack? = {
        weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
        weak var coreDataStack = appDelegate?.coreDataStack
        return coreDataStack
    }()

// MARK: - Private Attributes
    private let modelName: String

    private lazy var favorites: NSManagedObject? = fetchFavorites()

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    private lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()

// MARK: - Init
    init(modelName: String) {
        self.modelName = modelName
    }

// MARK: - Private Methods

    /**
     This function creates a new instance of Favorites.
     */
    private func createFavorites(_ favorites: [String] = .init()) -> NSManagedObject? {
        guard let newEntity = NSEntityDescription.entity(forEntityName: "Favorites", in: managedContext) else { return nil }
        let newFavorites = NSManagedObject(entity: newEntity, insertInto: managedContext)
        newFavorites.setValue(favorites, forKey: "cardsIds")
        print("Favorites created")
        return newFavorites
    }

    /**
     This function tries to fetch the Favorites instance saved, if it isn't able to retrieve the instance it the tries to create a first instance and then passes it foward and if it fails to create it passes nil.
     */
    private func fetchFavorites() -> NSManagedObject? {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        var result = [NSManagedObject]()

        do {
            let records = try managedContext.fetch(fetchRequest)
            if let records = records as? [NSManagedObject] {
                result = records
            }
        } catch {
            print("Unable to fetch managed objects for entity Favorites. Creating Favorites...")
            if let newFavorites = createFavorites() {
                result.append(newFavorites)
            } else {
                print("Unable to create Favorites")
            }
        }

        return result.first
    }

// MARK: - Public Methods

    /**
     A function to get the favorite cards ids
     - Returns: a **String array** with the favorites cards ids. If there's no favorites or occurs a error while retrieving the favorites it will return an empty array.
     */
    public func getFavoritesIds() -> [String] {
        (favorites?.value(forKey: "cardsIds") as? [String]) ?? .init()
    }

    /**
     Adds the cards ids to the favorites ManagedObject
     - Parameter favorites: An array of ids to add
     */
    public func addFavorites(_ favorites: [String]) {
        guard var favoritesIds = self.favorites?.value(forKey: "cardsIds") as? [String] else {
            self.favorites?.setValue(favorites, forKey: "cardsIds")
            return
        }
        favoritesIds.append(contentsOf: favorites)
        self.favorites?.setValue(favoritesIds, forKey: "cardsIds")
    }

    /**
     Removes the cards ids to the favorites ManagedObject
     - Parameter favorites: An array of ids to remove
     */
    public func removeFavorites(_ favorites: [String]) {
        guard var favoritesIds = self.favorites?.value(forKey: "cardsIds") as? [String] else {
            self.favorites?.setValue(favorites, forKey: "cardsIds")
            return
        }
        favoritesIds.removeAll(where: { favorites.contains($0) })
        self.favorites?.setValue(favoritesIds, forKey: "cardsIds")
    }

    /**
     Checks if the passed card is a favorite
     - Parameter card: Card instance to check
     - Returns: a bool indicating if the Card passed is a favorie
     */
    public func checkCardInFavorites(_ card: Card) -> Bool {
        return (favorites?.value(forKey: "cardsIds") as? [String])?.contains(card.id ?? "") ?? false
    }

    /**
     Saves all the ManagedContext with the changes published to the ManagedObject.
     Use this to save the favorites.
     */
    public func saveContext () {
        guard managedContext.hasChanges else { return }

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
