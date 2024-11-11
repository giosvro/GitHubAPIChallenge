//
//  RepositoryListResponse.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 09/11/24.
//

#import "RepositoryListResponse.h"
#import "Repository.h"

@implementation RepositoryListResponse

+ (instancetype)parseFromData:(NSData *)data error:(NSError **)error {

    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    
    if (*error) {
        return nil;
    }
    
    if (![jsonArray isKindOfClass:[NSArray class]]) {
        if (error) {
            *error = [NSError errorWithDomain:@"DecodeError" code:200 userInfo:@{NSLocalizedDescriptionKey: @"Invalid data format"}];
        }
        return nil;
    }

    NSMutableArray<Repository *> *repositories = [NSMutableArray array];
    
    for (NSDictionary *repoDict in jsonArray) {

        if (![repoDict isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        
        Repository *repository = [[Repository alloc] initWithDictionary:repoDict];
        
        if (repository) {
            [repositories addObject:repository];
        }
    }
    
    RepositoryListResponse *response = [[RepositoryListResponse alloc] initWithRepositories:repositories];
    return response;
}

- (instancetype)initWithRepositories:(NSArray<Repository *> *)repositories {
    self = [super init];
    
    if (self) {
        _repositories = [repositories copy];
    }
    
    return self;
}

@end
