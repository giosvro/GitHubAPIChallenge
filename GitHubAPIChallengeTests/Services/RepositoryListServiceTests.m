//
//  RepositoryListServiceTests.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 13/11/24.
//

#import <XCTest/XCTest.h>
#import "RepositoryListService.h"
#import "Repository.h"
#import "MockURLHelper.h"

@interface RepositoryListServiceTests : XCTestCase
@property (nonatomic, strong) RepositoryListService *repositoryService;
@end

@implementation RepositoryListServiceTests

- (void)setUp {
    [super setUp];
    [MockURLHelper startMocking];
    self.repositoryService = [[RepositoryListService alloc] init];
}

- (void)tearDown {
    [MockURLHelper stopMocking];
    self.repositoryService = nil;
    [super tearDown];
}

- (void)testFetchRepositoriesForValidUsername {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch repositories for valid username"];
    
    // Setup intercept
    NSString *urlString = @"https://api.github.com/users/onevcat/repos";
    NSString *fileName = @"mock_repositories";
    [MockURLHelper mockJSONResponseForURL:urlString statusCode:200 jsonFilePath:fileName];
    
    NSString *validUsername = @"onevcat";
    
    [self.repositoryService fetchRepositoriesForUsername:validUsername completion:^(NSArray<Repository *> * _Nullable repositories, NSError * _Nullable error) {
        XCTAssertNil(error, @"Unexpected error: %@", error.localizedDescription);
        XCTAssertNotNil(repositories, @"Repositories should't be nil for a valid repo name");
        XCTAssertTrue(repositories.count > 0, @"The response must have at least 1 repo");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"Test expectation fulfill timeout: %@", error.localizedDescription);
        }
    }];
}

- (void)testFetchRepositoriesForInvalidUsername {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch repositories for invalid username"];
    
    // Setup intercept
    NSString *invalidUsername = @"usuarioInexistenteDeTesteParaGitHubAPI";
    NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", invalidUsername];
    NSError *mockError = [NSError errorWithDomain:NSURLErrorDomain code:404 userInfo:@{NSLocalizedDescriptionKey: @"Not Found"}];
    [MockURLHelper mockResponseWithData:nil response:nil error:mockError forRequestURL:[NSURL URLWithString:urlString]];
        
    [self.repositoryService fetchRepositoriesForUsername:invalidUsername completion:^(NSArray<Repository *> * _Nullable repositories, NSError * _Nullable error) {
        XCTAssertNotNil(error, @"An error should exist for a invalid user name");
        XCTAssertNil(repositories, @"Repositories should be nil for a repository that don't exist");
                
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"Test expectation fulfill timeout: %@", error.localizedDescription);
        }
    }];
}

@end
