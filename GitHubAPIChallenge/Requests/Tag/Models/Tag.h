//
//  Tag.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 09/11/24.
//

#import <Foundation/Foundation.h>
#import "Commit.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tag : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, strong) Commit *commit;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
