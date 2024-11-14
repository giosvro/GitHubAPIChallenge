//
//  RepositoryTagsRequest.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 10/11/24.
//

#import <Foundation/Foundation.h>
#import "RequestTypeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface RepositoryTagsRequest : NSObject <RequestTypeProtocol>

@property (nonatomic, readonly, copy) NSString *repositoryName;
@property (nonatomic, readonly, copy) NSString *ownerName;

- (instancetype)initWithRepositoryName:(NSString *)repositoryName ownerName:(NSString *)ownerName;

@end

NS_ASSUME_NONNULL_END
