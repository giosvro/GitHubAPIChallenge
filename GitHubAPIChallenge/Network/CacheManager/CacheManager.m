//
//  CacheManager.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 14/11/24.
//

#import "CacheManager.h"

@interface CacheManager ()
- (NSURL *)cacheFileURLForKey:(NSString *)key;
@end

@implementation CacheManager

- (NSURL *)cacheDirectoryURL {
    NSURL *cacheDirectory = [[NSFileManager defaultManager]
                             URLsForDirectory:NSCachesDirectory
                             inDomains:NSUserDomainMask].firstObject;
    
    NSURL *customCacheDirectory = [cacheDirectory URLByAppendingPathComponent:@"NetworkCache"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:customCacheDirectory.path]) {
        [[NSFileManager defaultManager]
         createDirectoryAtURL:customCacheDirectory
         withIntermediateDirectories:YES
         attributes:nil
         error:nil];
    }
    
    return customCacheDirectory;
}

- (NSURL *)cacheFileURLForKey:(NSString *)key {
    NSString *fileName = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    return [[self cacheDirectoryURL] URLByAppendingPathComponent:fileName];
}

- (void)setCacheResponseWith:(NSData *)data forKey:(NSString *)key {
    NSURL *fileURL = [self cacheFileURLForKey:key];
    [data writeToURL:fileURL atomically:YES];
}

- (NSData *)getCacheResponseForKey:(NSString *)key {
    NSURL *fileURL = [self cacheFileURLForKey:key];
    return [NSData dataWithContentsOfURL:fileURL];
}

- (void)clearCache {
    NSURL *cacheDirectory = [self cacheDirectoryURL];
    NSArray *files = [[NSFileManager defaultManager]
                      contentsOfDirectoryAtURL:cacheDirectory
                      includingPropertiesForKeys:nil
                      options:NSDirectoryEnumerationSkipsHiddenFiles
                      error:nil];
    
    for (NSURL *fileURL in files) {
        [[NSFileManager defaultManager] removeItemAtURL:fileURL error:nil];
    }
}

@end
