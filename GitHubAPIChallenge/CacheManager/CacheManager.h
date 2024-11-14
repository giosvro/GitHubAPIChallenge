//
//  CacheManager.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 14/11/24.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject

- (void)setCacheResponseWith:(NSData *)data forKey:(NSString *)key;
- (NSData *)getCacheResponseForKey:(NSString *)key;
- (void)clearCache;

@end
