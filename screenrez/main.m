//
//  main.m
//  screenrez
//
//  Created by Edward Marczak on 5/18/11.
//  Copyright 2011 Radiotope. All rights reserved.
//

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
#import "NSScreen+DisplayName.h"

int main (int argc, const char * argv[])
{

  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    NSArray *screens = [NSScreen screens];
    NSMutableDictionary *screensDictionary = [NSMutableDictionary dictionary];
    [screensDictionary setObject:[NSMutableArray array] forKey:@"Screens"];
    
    // Loop over the screen objects using fast enumeration
    for (NSScreen *screen in screens)
    {
        // Capture the data about the screen that we care about
        NSMutableDictionary *ephemeralDict = [NSMutableDictionary dictionary];
        NSRect frame                       = [screen frame];
        NSRect usableFrame                 = [screen visibleFrame];
        NSString *displayName              = [screen displayName];
        NSString *resolution               = [NSString stringWithFormat:@"%dx%d",
                                              (int)frame.size.width,
                                              (int)frame.size.height];
        NSString *usableResolution         = [NSString stringWithFormat:@"%dx%d",
                                              (int)usableFrame.size.width,
                                              (int)usableFrame.size.height];
        
        // Add the data to our to the ephemeral dictionary
        [ephemeralDict setObject:displayName forKey:@"Name"];
        [ephemeralDict setObject:resolution forKey:@"Resolution"];
        [ephemeralDict setObject:usableResolution forKey:@"ResolutionSansDockAndMenu"];
        
        // Add the ephemeral dictionary to its non-ephemeral home
        [[screensDictionary objectForKey:@"Screens"] addObject:ephemeralDict];
    }
    

    // Convert the screens dictionary to a serialized property list
    NSString *errorString;
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:screensDictionary format:NSPropertyListXMLFormat_v1_0 errorDescription:&errorString];
    
    // If there was an error converting the data, let the user know, and bail out.
    if (errorString != nil)
    {
        fprintf(stderr,
               "Error formatting output: %s\n",
               [errorString cStringUsingEncoding:[NSString defaultCStringEncoding]]);
        return 1;
    }

    // Convert the serialized plist data to a plain ol' string and print it
    NSString *plist = [[NSString alloc] initWithData:plistData encoding:NSASCIIStringEncoding];
    printf("%s\n", [[plist description] cStringUsingEncoding:[NSString defaultCStringEncoding]]);

    [pool drain];
  return 0;
}

