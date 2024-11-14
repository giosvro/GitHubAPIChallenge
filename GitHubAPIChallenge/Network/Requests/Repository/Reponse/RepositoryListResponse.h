//
//  RepositoryListResponse.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 09/11/24.
//

#import <Foundation/Foundation.h>
#import "Repository.h"
#import "Response.h"

NS_ASSUME_NONNULL_BEGIN

@interface RepositoryListResponse : NSObject<Response>

@property (nonatomic, readonly, copy) NSArray<Repository *> *repositories;

@end

NS_ASSUME_NONNULL_END
