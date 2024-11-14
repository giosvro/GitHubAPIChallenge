//
//  RepositoryTagsServiceTests.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 13/11/24.
//

#import <XCTest/XCTest.h>
#import "RepositoryTagsService.h"
#import "Tag.h"
#import "MockURLHelper.h"

@interface RepositoryTagsServiceTests : XCTestCase
@property (nonatomic, strong) RepositoryTagsService *tagsService;
@end

@implementation RepositoryTagsServiceTests

- (void)setUp {
    [super setUp];
    [MockURLHelper startMocking];
    self.tagsService = [[RepositoryTagsService alloc] init];
}

- (void)tearDown {
    [MockURLHelper stopMocking];
    self.tagsService = nil;
    [super tearDown];
}

- (void)testFetchRepositoryTagsForValidUsernameAndRepo {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch tags for a valid username and repo"];
    
    // Setup intercept
    NSString *urlString = @"https://api.github.com/repos/onevcat/Kingfisher/tags";
    NSString *fileName = @"mock_tags";
    [MockURLHelper mockJSONResponseForURL:urlString statusCode:200 jsonFilePath:fileName];
    
    NSString *validUsername = @"onevcat";
    NSString *validRepo = @"Kingfisher";
    
    [self.tagsService fetchRepositoryTagsWith:validUsername repo:validRepo completion:^(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error) {
        XCTAssertNil(error, @"Unexpected error: %@", error.localizedDescription);
        XCTAssertNotNil(tags, @"Response tags are nil");
        
        Tag *tag = tags.firstObject;
        XCTAssertEqualObjects(tag.name, @"8.1.0", @"Incorrect tag name");
        XCTAssertEqualObjects(tag.commit.sha, @"c0940e241945e6378c01fbd45fd3815579d47ef5", @"Incorrect sha");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"Test expectation fulfill timeout: %@", error.localizedDescription);
        }
    }];
}

- (void)testFetchRepositoryTagsForInvalidRepo {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch tags for an invalid repo"];
    
    // Setup intercept
    NSString *urlString = @"https://api.github.com/repos/octocat/RepoInexistenteParaTeste/tags";
    NSError *mockError = [NSError errorWithDomain:NSURLErrorDomain code:404 userInfo:@{NSLocalizedDescriptionKey: @"Not Found"}];
    [MockURLHelper mockResponseWithData:nil response:nil error:mockError forRequestURL:[NSURL URLWithString:urlString]];

    NSString *validUsername = @"octocat";
    NSString *invalidRepo = @"RepoInexistenteParaTeste";
    
    [self.tagsService fetchRepositoryTagsWith:validUsername repo:invalidRepo completion:^(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error) {
        XCTAssertNotNil(error, @"An error should exist for a invalid repository name");
        XCTAssertNil(tags, @"Tags should be nil for a repository that don't exist");
        
        XCTAssertEqual(error.code, 404, @"Incorrect error code");
        XCTAssertEqualObjects(error.localizedDescription, @"Not Found", @"Incorrect message error");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"Test expectation fulfill timeout: %@", error.localizedDescription);
        }
    }];
}

@end
