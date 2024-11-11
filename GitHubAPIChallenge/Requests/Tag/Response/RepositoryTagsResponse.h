//
//  RepositoryTagsResponse.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 10/11/24.
//

#import <Foundation/Foundation.h>
#import "Tag.h"
#import "Response.h"

NS_ASSUME_NONNULL_BEGIN

@interface RepositoryTagsResponse : NSObject<Response>

@property (nonatomic, readonly, strong) NSArray<Tag *> *tags;

@end

NS_ASSUME_NONNULL_END
