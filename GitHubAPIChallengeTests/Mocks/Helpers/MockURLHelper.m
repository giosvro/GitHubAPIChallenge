//
//  MockURLHelper.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 13/11/24.
//

#import "MockURLHelper.h"
#import "MockURLProtocol.h"

@implementation MockURLHelper

+ (void)startMocking {
    [NSURLProtocol registerClass:[MockURLProtocol class]];
}

+ (void)stopMocking {
    [NSURLProtocol unregisterClass:[MockURLProtocol class]];
}

+ (void)mockResponseWithData:(NSData *)data
                    response:(NSURLResponse *)response
                       error:(NSError *)error
                 forRequestURL:(NSURL *)url {
    [MockURLProtocol setMockResponseData:data response:response error:error forRequestURL:url];
}

+ (void)mockJSONResponseForURL:(NSString *)url
                    statusCode:(NSInteger)statusCode
                  jsonFilePath:(NSString *)fileName {
    
    NSError *fileError;
    
    NSString *filePath = [[NSBundle bundleForClass:[self class]]
                          pathForResource:fileName
                          ofType:@"json"];
    
    NSData *data = [NSData
                    dataWithContentsOfFile:filePath
                    options:NSDataReadingMappedIfSafe
                    error:&fileError];
    
    if (fileError) {
        NSLog(@"Cannot find JSON: %@", fileError.localizedDescription);
        return;
    }
    
    NSURL *mockedUrl = [NSURL URLWithString:url];
    
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc]
                                   initWithURL:mockedUrl
                                   statusCode:statusCode
                                   HTTPVersion:@"HTTP/1.1"
                                   headerFields:@{@"Content-Type": @"application/json"}];
        
    [self mockResponseWithData:data response:response error:nil forRequestURL:mockedUrl];
}

@end

