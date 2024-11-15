//
//  RepositoryTagsService.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 12/11/24.
//

#import <Foundation/Foundation.h>
#import <GitHubAPIChallenge/Tag.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The `RepositoryTagsService` class provides functionality to fetch tags associated with a specific GitHub repository.
 * This service interacts with the GitHub API to retrieve tag information based on the specified username and repository name.
 */
@interface RepositoryTagsService : NSObject

/**
 * Initializes a new instance of `RepositoryTagsService`.
 *
 * @return A new instance of `RepositoryTagsService`.
 */
- (nonnull instancetype) init;

/**
 * Fetches the list of tags for a specified GitHub repository.
 *
 * @param username The GitHub username that owns the repository.
 * @param repo The name of the repository for which tags are to be fetched.
 * @param completion A completion handler that is called when the request completes.
 *        - If successful, `tags` contains an array of `Tag` objects representing the repository tags, and `error` is `nil`.
 *        - If an error occurs, `tags` is `nil`, and `error` contains the error information.
 */
- (void)fetchRepositoryTagsWith:(NSString *)username
                           repo:(NSString *)repo
                     completion:(void(^)(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
