//
//  main.m
//  screenrez
//
//  Created by Edward Marczak on 5/18/11.
//  Copyright 2011 Radiotope. All rights reserved.
//

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

int main (int argc, const char * argv[])
{

  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

  NSRect mainScreenRect;
  mainScreenRect = [[[NSScreen screens] objectAtIndex:0] visibleFrame];
  printf("%d, %d", (int)mainScreenRect.size.width,
                   (int)mainScreenRect.size.height);

  [pool drain];
  return 0;
}

