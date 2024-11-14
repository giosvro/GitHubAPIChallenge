//
//  CacheManagerTests.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 14/11/24.
//


#import <XCTest/XCTest.h>
#import "CacheManager.h"

@interface CacheManagerTests : XCTestCase
@property (nonatomic, strong) CacheManager *cacheManager;
@end

@implementation CacheManagerTests

- (void)setUp {
    [super setUp];
    self.cacheManager = [[CacheManager alloc] init];
}

- (void)tearDown {
    [self.cacheManager clearCache];
    self.cacheManager = nil;
    [super tearDown];
}

#pragma mark - CacheManager Tests

- (void)testSetCacheResponseWithForKey {
    NSData *data = [@"Set Cache Response data" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *key = @"testSetCacheResponseWithForKey";
    
    [self.cacheManager setCacheResponseWith:data forKey:key];
    
    NSData *cachedData = [self.cacheManager getCacheResponseForKey:key];
    XCTAssertEqualObjects(data, cachedData, @"The data on chace should be equal to the original one");
}

- (void)testGetCacheResponseForKey {
    NSData *data = [@"Get Cache Response data" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *key = @"testGetCacheResponseForKey";
    
    [self.cacheManager setCacheResponseWith:data forKey:key];
    
    NSData *retrievedData = [self.cacheManager getCacheResponseForKey:key];
    XCTAssertNotNil(retrievedData, @"The retrieved data should not be nil for a valid key.");
    XCTAssertEqualObjects(data, retrievedData, @"The retrieved data should match the data that was set.");
    
    NSData *nonExistentData = [self.cacheManager getCacheResponseForKey:@"nonExistentKey"];
    XCTAssertNil(nonExistentData, @"The retrieved data should be nil for a non-existent key.");
}

- (void)testClearCache {
    NSData *data = [@"Clear cache test" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *key = @"clearCacheKey";
    
    [self.cacheManager setCacheResponseWith:data forKey:key];
    XCTAssertNotNil([self.cacheManager getCacheResponseForKey:key], @"Data should exist before clearing the cache.");
    
    [self.cacheManager clearCache];
    
    NSData *cachedData = [self.cacheManager getCacheResponseForKey:key];
    XCTAssertNil(cachedData, @"Data should be nil after clearing the cache.");
}

@end
