//
//  CoreDataPostsResponseStorage.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 3/02/23.
//

import Foundation
import CoreData

final class CoreDataPostsResponseStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: - Private

//    private func fetchRequest(for requestDto: PostsRequestDTO) -> NSFetchRequest<PostsRequestEntity> {
////        let request: NSFetchRequest = PostsRequestEntity.fetchRequest()
////        request.predicate = NSPredicate(format: "%K = %@ AND %K = %d",
////                                        #keyPath(PostsRequestEntity.query), requestDto.query,
////                                        #keyPath(PostsRequestEntity.page), requestDto.page)
////        return request
//    }

//    private func deleteResponse(for requestDto: PostsRequestDTO, in context: NSManagedObjectContext) {
////        let request = fetchRequest(for: requestDto)
////
////        do {
////            if let result = try context.fetch(request).first {
////                context.delete(result)
////            }
////        } catch {
////            print(error)
////        }
//    }
}

extension CoreDataPostsResponseStorage: PostsResponseStorage {
    func getResponse(completion: @escaping (Result<[PostResponseDTO]?, CoreDataStorageError>) -> Void) {
        
        // Realiza una tarea en segundo plano utilizando el almacenamiento Core Data
        coreDataStorage.performBackgroundTask { context in
            do {
//                let fetchRequest = NSFetchRequest<PostResponseEntity>(entityName: "PostResponseEntity")
//                fetchRequest.predicate = NSPredicate(format: "id = %@", requestDto.id)
//                let results = try context.fetch(fetchRequest)
//                let requestEntity = results
//                completion(.success(requestEntity.toDTO()))
            } catch {
                // Devuelve un resultado fallido con el error de lectura de Core Data
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func save(response responseDto: [PostResponseDTO], for requestDto: PostsRequestDTO) {
        coreDataStorage.performBackgroundTask { context in
            do {
                // Delete Response
//                self.deleteResponse(for: requestDto, in: context)
                
                let entities = responseDto.toEntity(in: context)
                        entities.forEach { entity in
                            context.insert(entity)
                        }
                
                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataPostsResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}


extension PostResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> PostResponseEntity {
        let entity: PostResponseEntity = .init(context: context)
        entity.id = Int64(id)
        entity.title = title
        entity.userID = Int64(userID)
        entity.body = body
        return entity
    }
}

extension Array where Element == PostResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> [PostResponseEntity] {
        return self.map { $0.toEntity(in: context) }
    }
}
