//
//  STTokView.h
//  stitch
//
//  Created by Alexander List on 1/20/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Opentok/Opentok.h>

static NSString* const kApiKey = @"16178811";    // Replace with your API Key
static NSString* const kSessionId = @"2_MX4xNjE3ODgxMX4xMjcuMC4wLjF-U3VuIEphbiAyMCAwMjoyMDoxNCBQU1QgMjAxM34wLjAxNDExMjU5Mn4"; // Replace with your generated Session ID
static NSString* const kToken = @"T1==cGFydG5lcl9pZD0xNjE3ODgxMSZzaWc9NzRhM2E4NWYwM2ZkN2E0YzIyYzU0M2E0NDQwZDdjMTE1ODUwNDI4MTpzZXNzaW9uX2lkPTJfTVg0eE5qRTNPRGd4TVg0eE1qY3VNQzR3TGpGLVUzVnVJRXBoYmlBeU1DQXdNam95TURveE5DQlFVMVFnTWpBeE0zNHdMakF4TkRFeE1qVTVNbjQmY3JlYXRlX3RpbWU9MTM1ODY3NzIxOCZleHBpcmVfdGltZT0xMzYxMjY5MjE4JnJvbGU9cHVibGlzaGVyJm5vbmNlPTg0NzQ4JnNka192ZXJzaW9uPXRiLWRhc2hib2FyZC1qYXZhc2NyaXB0LXYx";     // Replace with your generated Token (use Project Tools or from a server-side library)

@interface STTokView : UIView <OTSessionDelegate, OTSubscriberDelegate, OTPublisherDelegate>

@property (nonatomic, strong) OTSession * session;

- (void)doConnect;

@end
