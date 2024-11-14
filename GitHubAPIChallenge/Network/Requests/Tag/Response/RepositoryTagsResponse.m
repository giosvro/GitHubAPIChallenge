//
//  RepositoryTagsResponse.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 10/11/24.
//

#import "RepositoryTagsResponse.h"
#import "Tag.h"

@implementation RepositoryTagsResponse

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

    NSMutableArray<Tag *> *tags = [NSMutableArray array];
    
    for (NSDictionary *tagDict in jsonArray) {

        if (![tagDict isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        
        Tag *tag = [[Tag alloc] initWithDictionary:tagDict];
        
        if (tag) {
            [tags addObject:tag];
        }
    }

    RepositoryTagsResponse *response = [[RepositoryTagsResponse alloc] initWithTags:tags];
    return response;
}

- (instancetype)initWithTags:(NSArray<Tag *> *)tags {
    self = [super init];
    if (self) {
        _tags = [tags copy];
    }
    return self;
}

@end

