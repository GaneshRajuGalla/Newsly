//
//  PersistenceManager.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 18/09/24.
//

import Foundation
import CoreData

class PersistenceManager: ObservableObject {
    
    // MARK: - Properties
    let container: NSPersistentContainer
    @Published var favoriteArticles:[ArticleEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "ArticleContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error Loading Core Data \(error)")
            } else {
                print("Successfully loaded core data.")
            }
            self.fetchArticles()
        }
    }
    
    // MARK: - Methods
    
    func fetchArticles() {
        let request = NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
        
        do {
            favoriteArticles = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching. \(error)")
        }
    }
    
    func addArticle(title: String, desp: String, url: String, urlToImage: String) {
        let newArticle = ArticleEntity(context: container.viewContext)
        newArticle.title = title
        newArticle.desp = desp
        newArticle.url = url
        newArticle.urlToImage = urlToImage
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchArticles()
        } catch {
            print("Error Saving \(error)")
        }
    }
    
    func isArticleFavorite(url: String) -> Bool {
        let request = NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
        request.predicate = NSPredicate(format: "url == %@", url)
        request.fetchLimit = 1
        
        do {
            let count = try container.viewContext.count(for: request)
            return count > 0
        } catch {
            print("Error checking if article is favorite: \(error)")
            return false
        }
    }

    func removeArticle(url: String) {
        let request = NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
        request.predicate = NSPredicate(format: "url == %@", url)
        request.fetchLimit = 1
        
        do {
            if let articleToRemove = try container.viewContext.fetch(request).first {
                container.viewContext.delete(articleToRemove)
                saveData()
                print("Deleted from core data successfully")
            }
        } catch {
            print("Error deleting article: \(error)")
        }
    }
}
