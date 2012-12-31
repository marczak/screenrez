//
//  NSScreen+DisplayName.h
//  screenrez
//
//  Created by Joseph M. Wollard on 12/30/12.
//  Shamelessly ripped from http://commanigy.com/blog/2011/1/14/how-to-get-display-name-from-nsscreen
//
//

#import <Cocoa/Cocoa.h>

@interface NSScreen (DisplayName)

- (NSString *)displayName;

@end