//
//  RepositoryTagsResponse.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 10/11/24.
//

#import "RepositoryTagsResponse.h"
#import "Tag.h"

@implementation RepositoryTagsResponse

// Implementing the parseFromData:error: method as per the Response protocol
+ (instancetype)parseFromData:(NSData *)data error:(NSError **)error {
    // Convert the NSData received into a JSON array
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    
    // Check if there was an error during deserialization
    if (*error) {
        return nil; // Return nil if there was an error
    }
    
    // Verify that the deserialized JSON is indeed an array
    if (![jsonArray isKindOfClass:[NSArray class]]) {
        if (error) {
            *error = [NSError errorWithDomain:@"DecodeError" code:200 userInfo:@{NSLocalizedDescriptionKey: @"Invalid data format"}];
        }
        return nil; // Return nil if the format is not an array
    }

    // Create a temporary array to store the tags
    NSMutableArray<Tag *> *tags = [NSMutableArray array];
    
    // Iterate over the JSON array and create instances of `Tag`
    for (NSDictionary *tagDict in jsonArray) {
        // Verify that each item in the array is a dictionary
        if (![tagDict isKindOfClass:[NSDictionary class]]) {
            continue; // Skip to the next item if it is not a dictionary
        }
        
        // Initialize a `Tag` object from the dictionary
        Tag *tag = [[Tag alloc] initWithDictionary:tagDict];
        
        // Add the tag to the tags array if it is valid
        if (tag) {
            [tags addObject:tag];
        }
    }

    // Create an instance of `RepositoryTagsResponse` with the array of tags
    RepositoryTagsResponse *response = [[RepositoryTagsResponse alloc] initWithTags:tags];
    return response;
}

// Private initializer method for `RepositoryTagsResponse`
- (instancetype)initWithTags:(NSArray<Tag *> *)tags {
    self = [super init];
    if (self) {
        _tags = [tags copy]; // Assign the array as an immutable property
    }
    return self;
}

@end

