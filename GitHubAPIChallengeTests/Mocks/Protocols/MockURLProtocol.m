//
//  MockURLProtocol.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 13/11/24.
//

#import "MockURLProtocol.h"

static NSData *mockResponseData;
static NSURLResponse *mockURLResponse;
static NSError *mockError;
static NSURL *mockRequestURL;

@implementation MockURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return [request.URL isEqual:mockRequestURL] && [NSURLProtocol propertyForKey:@"Mocked" inRequest:request] == nil;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

+ (void)setMockResponseData:(NSData *)data
                   response:(NSURLResponse *)response
                      error:(NSError *)error
              forRequestURL:(NSURL *)url {
    mockResponseData = data;
    mockURLResponse = response;
    mockError = error;
    mockRequestURL = url;
}

- (void)startLoading {

    NSMutableURLRequest *mutableRequest = [self.request mutableCopy];
    [NSURLProtocol setProperty:@YES forKey:@"Mocked" inRequest:mutableRequest];

    if (mockError) {
        [self.client URLProtocol:self didFailWithError:mockError];
    } else {
        [self.client URLProtocol:self didReceiveResponse:mockURLResponse cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:mockResponseData];
        [self.client URLProtocolDidFinishLoading:self];
    }
}

- (void)stopLoading {
    // Método necessário, mas vazio
}

@end
