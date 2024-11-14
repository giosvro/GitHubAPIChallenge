//
//  RepositoryTagsService.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 12/11/24.
//

#import <Foundation/Foundation.h>
#import <GitHubAPIChallenge/Tag.h>

NS_ASSUME_NONNULL_BEGIN

@interface RepositoryTagsService : NSObject

- (nonnull instancetype) init;

- (void)fetchRepositoryTagsWith:(NSString *)username
                           repo:(NSString *)repo
                     completion:(void(^)(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
