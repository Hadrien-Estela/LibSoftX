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

#include "sx_structs.h"
#include <Cocoa/Cocoa.h>
#include <stdio.h>

@implementation SxView

- (id)initWithFrame:(NSRect)frameRect winPtr:(SxWindow*)pWindow
{
    NSTrackingArea    *area;

    self = [super initWithFrame:frameRect];
    window = pWindow;
    area = [[NSTrackingArea alloc] initWithRect:[self frame]
                                    options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow | NSTrackingCursorUpdate)
                                    owner:self
                                    userInfo:nil];
    contextRef = (CGContextRef)[[NSGraphicsContext graphicsContextWithWindow:window] graphicsPort];
    CGContextFlush(contextRef);
    [self addTrackingArea:area];
    [self setNeedsDisplay:YES];
    return (self);
}

- (void)putPixel:(NSPoint)pixel color:(int32_t)rgb
{
	float 	r;
	float 	g;
	float	b;

  	r = ((rgb >> 16) & 0xFF) / 255.0;   // Extract the green component
  	g = ((rgb >> 8) & 0xFF) / 255.0;    // Extract the 
  	b = ((rgb) & 0xFF) / 255.0;        	// Extract the BB byt

   CGContextSetRGBFillColor(contextRef, r, g, b, 1);
   CGContextFillRect(contextRef, CGRectMake (pixel.x, pixel.y, 1, 1));
   CGContextFlush(contextRef);
}

- (void)blitSurface:(uint32_t*)buf size:(NSSize)size to:(NSPoint)place
{
    CGColorSpaceRef     color_space;
    CGDataProviderRef   provider;
    CGImageRef          image;
    NSRect              rect;

    color_space = CGColorSpaceCreateDeviceRGB();
    provider = CGDataProviderCreateWithData(nil, buf, size.width * size.height, nil);
    image = CGImageCreate(size.width,            // width
                            size.height,         // height
                            8,              // Bits per Component
                            32,             // Bits per pixel
                            4 * size.width,      // bytes per row
                            color_space,    // color space (here device dependent)
                            kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst,
                            provider,
                            nil,
                            NO,
                            kCGRenderingIntentDefault);
    
    rect.size = size;
    rect.origin = place;
    CGContextDrawImage(contextRef, rect, image);
    CGContextFlush(contextRef);
    CGColorSpaceRelease(color_space);
    CGDataProviderRelease(provider);
    CGImageRelease(image);
}

- (void)clear
{
    NSRect       frame;

    frame = [self frame];
   	CGContextSetRGBFillColor(contextRef, 0, 0, 0, 1);
    CGContextFillRect(contextRef, CGRectMake (0, 0, frame.size.width, frame.size.height));
    CGContextFlush(contextRef);
}

- (void)testFont
{
   
}

@end
