//
//  MockURLHelper.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 13/11/24.
//

#import <Foundation/Foundation.h>

@interface MockURLHelper : NSObject

+ (void)startMocking;
+ (void)stopMocking;
+ (void)mockResponseWithData:(NSData *)data
                    response:(NSURLResponse *)response
                       error:(NSError *)error
                 forRequestURL:(NSURL *)url;

+ (void)mockJSONResponseForURL:(NSString *)url
                    statusCode:(NSInteger)statusCode
                     jsonFilePath:(NSString *)fileName;

@end

