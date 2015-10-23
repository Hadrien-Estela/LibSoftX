// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   SxView.m                                           :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/12 02:02:31 by hestela           #+#    #+#             //
//   Updated: 2015/05/12 02:02:33 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "softx.h"
#include "sx_structs.hpp"
#include <Cocoa/Cocoa.h>
#import <AppKit/NSOpenGLView.h>
#import <OpenGL/OpenGL.h>
#import <OpenGL/gl3.h>


@implementation SxOpenGlView

- (id)initWithFrame:(NSRect)frameRect winPtr:(SxWindow*)pWindow context:(NSUInteger)ctx
{
    //Pix format for openGl3.0
    NSOpenGLPixelFormatAttribute pixelFormatAttributes3[] =
    {
        NSOpenGLPFADepthSize, 32,
        NSOpenGLPFADoubleBuffer,
        NSOpenGLPFAOpenGLProfile, NSOpenGLProfileVersionLegacy,
        0
    };

    //Pix format for openGl4
    NSOpenGLPixelFormatAttribute pixelFormatAttributes4[] =
    {
        NSOpenGLPFADepthSize, 32,
        NSOpenGLPFADoubleBuffer,
        NSOpenGLPFAOpenGLProfile, NSOpenGLProfileVersion4_1Core,
        0
    };

    // Create the format
    NSOpenGLPixelFormat *format;
    if (ctx & SX_WINDOW_OPENGL3_CONTEXT)
        format = [[NSOpenGLPixelFormat alloc] initWithAttributes:pixelFormatAttributes3];
    else
        format = [[NSOpenGLPixelFormat alloc] initWithAttributes:pixelFormatAttributes4];

    //Init View and context
    self = [super initWithFrame:frameRect pixelFormat:format];
    [self setNeedsDisplay:YES];
    glEnable(GL_DEPTH_TEST);
    window = pWindow;
    return (self);
}

- (void)clear
{
    glClearColor(0, 0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

- (void)updateContext
{
   [[self openGLContext] flushBuffer];
}

- (void)makeCurrentContext
{
    [[self openGLContext] makeCurrentContext];
}

- (void)reshape
{
    glViewport(0, 0, [self bounds].size.width, [self bounds].size.height);
}

@end
