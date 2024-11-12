//
//  NetworkManager.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 11/11/24.
//

#import "NetworkManager.h"

@implementation NetworkManager

- (instancetype)initWithSession:(NSURLSession *)session {
    self = [super init];
    if (self) {
        _session = session;
    }
    return self;
}

- (instancetype)init {
    return [self initWithSession:[NSURLSession sharedSession]];
}

- (void)performRequestWithConfig:(id<RequestTypeProtocol>)config
                      completion:(void(^)(id _Nullable parsedObject, NSError * _Nullable error))completion {
    
    // TODO: - Implement connectivity check
    // TODO: - Implement cache

    @try {
        NSURLComponents *urlComponents = [self createUrlComponentsWithConfig:config];
        [self setEndpointPathWithConfig:config urlComponents:&urlComponents];
        [self setQueryItemsWithConfig:config urlComponents:&urlComponents];
        NSURLRequest *urlRequest = [self createUrlRequestWithConfig:config urlComponents:urlComponents];
        
        [self makeDataTaskWithRequest:urlRequest config:config completion:completion];
        
    } @catch (NSException *exception) {
        NSError *error = [NSError errorWithDomain:@"NetworkErrorDomain" code:500 userInfo:@{NSLocalizedDescriptionKey: exception.reason}];
        completion(nil, error);
    }
}

- (NSURLComponents *)createUrlComponentsWithConfig:(id<RequestTypeProtocol>)config {
    NSString *baseUrlString = [config baseUrl];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:baseUrlString];
    
    if (!urlComponents) {
        @throw [NSException exceptionWithName:@"InvalidURLException" reason:@"Failed to create URLComponents from base URL" userInfo:nil];
    }
    return urlComponents;
}

- (void)setEndpointPathWithConfig:(id<RequestTypeProtocol>)config urlComponents:(NSURLComponents **)urlComponents {
    (*urlComponents).path = [config path];
    
    if (!(*urlComponents).URL) {
        @throw [NSException exceptionWithName:@"InvalidPathException" reason:@"Failed to set path in URLComponents" userInfo:nil];
    }
}

- (void)setQueryItemsWithConfig:(id<RequestTypeProtocol>)config urlComponents:(NSURLComponents **)urlComponents {
    NSDictionary *queryItemsDict = [config queryItems];
    if (queryItemsDict.count > 0) {
        NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray array];
        for (NSString *key in queryItemsDict) {
            NSString *value = [queryItemsDict[key] description];
            [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:value]];
        }
        (*urlComponents).queryItems = queryItems;
    }
    
    if (!(*urlComponents).URL) {
        @throw [NSException exceptionWithName:@"InvalidQueryItemsException" reason:@"Failed to set query items in URLComponents" userInfo:nil];
    }
}

- (NSURLRequest *)createUrlRequestWithConfig:(id<RequestTypeProtocol>)config urlComponents:(NSURLComponents *)urlComponents {
    NSURL *url = urlComponents.URL;
    if (!url) {
        @throw [NSException exceptionWithName:@"InvalidURLException" reason:@"Invalid URL after setting components" userInfo:nil];
    }
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    urlRequest.HTTPMethod = [config httpMethod];
    urlRequest.HTTPBody = [config body];
    
    [self setHeadersForRequest:config urlRequest:&urlRequest];
    return [urlRequest copy];
}

- (void)setHeadersForRequest:(id<RequestTypeProtocol>)config urlRequest:(NSMutableURLRequest **)urlRequest {
    NSDictionary *headers = [config headers];
    if (headers.count > 0) {
        for (NSString *key in headers) {
            [*urlRequest setValue:headers[key] forHTTPHeaderField:key];
        }
    }
}

- (void)makeDataTaskWithRequest:(NSURLRequest *)urlRequest
                         config:(id<RequestTypeProtocol>)config
                     completion:(void(^)(id _Nullable parsedObject, NSError * _Nullable error))completion {
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:urlRequest
                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (![response isKindOfClass:[NSHTTPURLResponse class]] || ((NSHTTPURLResponse *)response).statusCode != 200) {
            NSError *responseError = [NSError errorWithDomain:@"NetworkErrorDomain" code:((NSHTTPURLResponse *)response).statusCode userInfo:@{NSLocalizedDescriptionKey: @"Invalid response from server"}];
            completion(nil, responseError);
            return;
        }
        
        NSError *parseError;
        id parsedObject = [[config responseType] parseFromData:data error:&parseError];
        
        if (completion) {
            completion(parsedObject, parseError);
        }
    }];
    
    [task resume];
}

@end
