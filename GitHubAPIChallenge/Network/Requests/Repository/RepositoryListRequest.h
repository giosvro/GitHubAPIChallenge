//
//  RepositoryListRequest.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 09/11/24.
//

#import <Foundation/Foundation.h>
#import "RequestTypeProtocol.h"

@interface RepositoryListRequest : NSObject <RequestTypeProtocol>

- (instancetype)initWithUsername:(NSString *)username;

@property (nonatomic, copy) NSString *username;

@end
