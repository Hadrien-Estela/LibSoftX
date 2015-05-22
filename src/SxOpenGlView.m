// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   SxOpenGlView.m                                     :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/16 17:05:46 by hestela           #+#    #+#             //
//   Updated: 2015/05/16 17:05:47 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"
#import <OpenGL/gl3.h>

@implementation SxOpenGlView

- (id)initWithFrame:(NSRect)frameRect winPtr:(SxWindow*)pWindow
{
	NSOpenGLPixelFormat* pixFmt;
	NSTrackingArea    *area;
	NSOpenGLPixelFormatAttribute attrs[] =
  	{
   		NSOpenGLPFADepthSize, 32,
    	NSOpenGLPFADoubleBuffer,
    	NSOpenGLPFAOpenGLProfile,
    	NSOpenGLProfileVersion4_1Core,
    	0
  	};

  	window = pWindow;
	pixFmt = [[NSOpenGLPixelFormat alloc] initWithAttributes:attrs];
	self = [super initWithFrame:frameRect pixelFormat:pixFmt];

	// context = [[NSOpenGLContext alloc] initWithFormat:pixFmt shareContext:[NSOpenGLContext currentContext]]; //other_context];
 //   	[self setOpenGLContext:context];
 //    [context setView:self];
 //    [context makeCurrentContext];
 //    [self clearGLContext];

    area = [[NSTrackingArea alloc] initWithRect:[self frame]
                                    options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow | NSTrackingCursorUpdate)
                                    owner:self
                                    userInfo:nil];
    [self addTrackingArea:area];
    [self setNeedsDisplay:YES];
 //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update)
	// 				    name:NSViewGlobalFrameDidChangeNotification
	// 				    object:nil];
 //    [self setNextKeyView:self];
	// glClearColor(1, 0, 0, 1);
 //    glClear(GL_COLOR_BUFFER_BIT);
 //    glFlush();
 //    glDisable(GL_DEPTH_TEST);

	return (self);
}

- (void)putPixel:(NSPoint)pixel color:(int32_t)rgb
{
    pixel = (NSPoint)pixel;
    rgb = (int32_t)rgb;
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glClearColor(0, 0, 0, 0);
    glFlush();
    [self setNeedsDisplay:YES];
}

- (void)clear
{
   
}

@end