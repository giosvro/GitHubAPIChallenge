//
//  MockURLProtocol.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 13/11/24.
//

#import <Foundation/Foundation.h>

@interface MockURLProtocol : NSURLProtocol

+ (void)setMockResponseData:(NSData *)data
                   response:(NSURLResponse *)response
                      error:(NSError *)error
              forRequestURL:(NSURL *)url;

@end
