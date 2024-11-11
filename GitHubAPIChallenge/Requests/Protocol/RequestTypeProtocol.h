//
//  RequestTypeProtocol.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 09/11/24.
//

#import <Foundation/Foundation.h>
#import "Response.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RequestTypeProtocol <NSObject>

@required
@property (nonatomic, copy, readonly) NSString *httpMethod;
@property (nonatomic, copy, readonly) NSString *baseUrl;
@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, copy, readonly, nullable) NSData *body;
@property (nonatomic, copy, readonly, nullable) NSDictionary *headers;
@property (nonatomic, copy, readonly, nullable) NSDictionary *queryItems;

@property (nonatomic, strong, readonly) Class<Response> responseType;

@end

NS_ASSUME_NONNULL_END
