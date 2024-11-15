# GitHubAPIChallenge
An Objective-C framework that encapsulates the GitHub REST API, providing a streamlined interface for interacting with GitHub resources.

## Features

- **RepositoryListService**: Allow searches for repositories of a user.
- **RepositoryTagsServices**: Allow searchs for the tags of a given repository.
- **Encapsulated Models**: Includes `Repository`, `Owner`, `Tag` and `Commit`.

## Installation

GitHubAPIChallenge is available via CocoaPods. You can add it using the following code bellow in you `Podfile` file.

```ruby
  pod 'GitHubAPIChallenge', :git => 'https://github.com/giosvro/GitHubAPIChallenge.git'
```

## How to use it

After installing the framework in your project, you can import it in two ways:

Import the entire framework:
```objective-c
  @import GitHubAPIChallenge;
```

Import only specific components as needed, for example:
```objective-c
  #import "GitHubAPIChallenge/Repository.h"
  #import "GitHubAPIChallenge/Owner.h"
  #import "GitHubAPIChallenge/Tag.h"
  #import "GitHubAPIChallenge/Commit.h"
  #import "GitHubAPIChallenge/RepositoryListService.h"
  #import "GitHubAPIChallenge/RepositoryTagsService.h"
```

## Repository List

To list the repositories of a specific user, use `RepositoryListService` and pass the username to the appropriate parameter. For example:

Create an instance:

```objective-c
RepositoryListService *service = [[RepositoryListService alloc] init];
```

And execute the request by:

```objective-c
[self.service fetchRepositoriesForUsername:username completion:^(NSArray<Repository *> * _Nullable repositories, NSError * _Nullable error) {
    if (repositories) {
        self.repositories = [repositories mutableCopy];
    }
    if (error) {
        completion(error);
    }
}];
```

## Repository Tags 

The same goes for the tags, but on this case, we have an additional parameter repo, witch is the repository name:

```objective-c
RepositoryTagsService *service = [[RepositoryTagsService alloc] init];
```

And execute the request by:

```objective-c
[self.service fetchRepositoryTagsWith:self.username repo:self.repositoryName completion:^(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error) {
    if (tags) {
        self.tags = [tags mutableCopy];
    }
    if (completion) {
        completion(error);
    }
}];
```

## Models

### `Owner`

Represents the owner of a GitHub repository.

- **`login`** (`NSString`): The username of the repository owner.

---

### `Commit`

Represents a commit in a GitHub repository.

- **`sha`** (`NSString`): The unique SHA identifier of the commit.
- **`url`** (`NSString`): The URL associated with the commit.

---

### `Tag`

Represents a tag in a GitHub repository, typically pointing to a specific commit.

- **`name`** (`NSString`): The name of the tag.
- **`commit`** (`Commit`): The commit associated with the tag.

---

### `Repository`

Represents a GitHub repository with its main attributes.

- **`name`** (`NSString`): The name of the repository.
- **`fullName`** (`NSString`): The full name of the repository, including the user or organization name, like `user/repo`.
- **`repositoryDescription`** (`NSString`, optional): A brief description of the repository.
- **`stargazersCount`** (`NSInteger`): The number of stars the repository has received.
- **`watchersCount`** (`NSInteger`): The number of users watching the repository.
- **`language`** (`NSString`, optional): The primary language used in the repository.
- **`owner`** (`Owner`, optional): The repository’s owner, represented by the `Owner` model.

## CacheManager

The `CacheManager` handles caching responses from network requests, allowing the framework to function smoothly even with unstable network connections. It stores the most recent response for each endpoint, which can be retrieved automatically in the event of a connection issue.

### How It Works

- **Automatic Storage**: Each time a request is made, `CacheManager` saves the associated response in the cache. Each response is stored with a unique key, allowing precise retrieval for each endpoint.
- **Offline Use**: When the framework detects a connection issue, `CacheManager` provides the most recent stored response, ensuring data remains available to the user even without an active connection.
- **Storage Location**: `CacheManager` uses the app’s cache directory in a custom folder named `NetworkCache`.

### Project Architecture

The `GitHubAPIChallenge` framework is designed with a modular architecture to promote encapsulation, flexibility, and ease of maintenance. The architecture diagram below provides an overview of the key components and their relationships within the framework:

<div align="center">
    <img src="https://github.com/user-attachments/assets/474a8ad6-6fa3-4738-907e-818d33132add" alt="Untitled Diagram drawio">
</div>

Each component has a specific role, ensuring separation of concerns and clear organization. This modular setup supports dependency injection and encapsulation, making the framework more adaptable and testable.

## Conclusion

We hope that `GitHubAPIChallenge` enhances your development process and provides a reliable, maintainable solution for working with GitHub data. Contributions and feedback are always welcome to make the framework even better!



