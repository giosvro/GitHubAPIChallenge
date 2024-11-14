//
//  Response.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 10/11/24.
//

#import <Foundation/Foundation.h>

@protocol Response <NSObject>
+ (instancetype _Nullable)parseFromData:(NSData * _Nonnull)data error:(NSError * _Nullable * _Nullable)error;
@end
