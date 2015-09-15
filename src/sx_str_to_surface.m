// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_str_to_surface.m                                :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/21 15:49:47 by hestela           #+#    #+#             //
//   Updated: 2015/05/21 15:49:47 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"
#include <stdio.h>

void		*surface_from_context(CGContextRef ctx)
{
	CGImageRef 				image;
	t_sx_surface			*surface;
	CGDataProviderRef 		dataProvider;
	CFDataRef 				imageData;

    image = CGBitmapContextCreateImage(ctx);
    surface = (t_sx_surface*)malloc(sizeof(t_sx_surface));
	surface->width = CGImageGetWidth(image);
	surface->height = CGImageGetHeight(image);
	surface->buffer = (uint32_t*)malloc(sizeof(uint32_t) * (surface->width * surface->height));
	dataProvider = CGImageGetDataProvider(image);
	imageData = CGDataProviderCopyData(dataProvider);
	memcpy(surface->buffer, CFDataGetBytePtr(imageData), sizeof(uint32_t) * (surface->width * surface->height));
	CGImageRelease(image);
	CFRelease(imageData);
	free(CGBitmapContextGetData(ctx));
	CGContextRelease(ctx);
	return ((void*)surface);
}

CGContextRef 		createContextFromLine(CTLineRef line, uint32_t bg)
{
	void				*data;
	CGColorSpaceRef 	space;
	CGBitmapInfo 		bitmapInfo;
	CGContextRef 		ctx;
	CGFloat 			ascent, descent, leading;
	size_t 				width;
	size_t 				height;

	width = (size_t)ceilf(CTLineGetTypographicBounds(line, &ascent, &descent, &leading));
	height = (size_t)ceilf(ascent + descent);
	data = (void*)malloc((width * height) * sizeof(uint32_t));
	space = CGColorSpaceCreateDeviceRGB();
	bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little;
	ctx = CGBitmapContextCreate(data, width, height, 8, width * 4, space, bitmapInfo);
	CGColorSpaceRelease(space);
	CGContextClearRect(ctx, CGRectMake(0.0, 0.0, width, height));
	if (((bg >> 24) & 0xFF) > 0x00)
	{
		CGContextSetRGBFillColor(ctx, ((bg >> 16) & 0xFF) / 255.0f, ((bg >> 8) & 0xFF) / 255.0f, (bg & 0xFF) / 255.0f, ((bg >> 24) & 0xFF) / 255.0f);
		CGContextFillRect(ctx, CGRectMake(0.0, 0.0, width, height));
	}	
	return (ctx);
}

void			drawText(CGContextRef ctx, CTLineRef line)
{
	CGFloat 			ascent, descent, leading;

	CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
	CGContextSetTextPosition(ctx, 0.0, descent);
    CGContextSetTextDrawingMode(ctx, kCGTextFill);
    CTLineDraw(line, ctx);
}

void			*sx_str_to_surface(void *font, char *s, uint32_t f, uint32_t b)
{
	CTLineRef 					line;
	CGContextRef 				ctx;
	CFDictionaryRef				attributes;
	CFAttributedStringRef 		attrString;
	NSColor						*foreground;
	CFStringRef 				keys[2];
	CFTypeRef 					values[2];

	if (!font || !s)
		return (NULL);
	//foreground color
	foreground = [NSColor colorWithCalibratedRed:((f >> 16) & 0xFF) / 255.0f
											green:((f >> 8) & 0xFF) / 255.0f
											blue:(f & 0xFF) / 255.0f
											alpha:((f >> 24) & 0xFF) / 255.0f];

	// Create the string
	CTFontRef font_Test = font;
	CFStringRef stringRef = CFStringCreateWithCString(NULL, s, kCFStringEncodingUTF8);
	keys[0] = kCTFontAttributeName;
	keys[1] = kCTForegroundColorAttributeName;
	values[0] = font_Test;
	values[1] = foreground.CGColor;
	attributes = CFDictionaryCreate(kCFAllocatorDefault,
									(const void**)&keys,
                                    (const void**)&values,
                                    sizeof(keys)/sizeof(keys[1]),
                                    &kCFTypeDictionaryKeyCallBacks,
                                    &kCFTypeDictionaryValueCallBacks);
	attrString = CFAttributedStringCreate(kCFAllocatorDefault, stringRef, attributes);
	// draw in context
    line = CTLineCreateWithAttributedString(attrString);
  	ctx = createContextFromLine(line, b);
  	drawText(ctx, line);
    CFRelease(line);
    CFRelease(attributes);
    CFRelease(attrString);
    CFRelease(stringRef);
    [foreground release];
	return (surface_from_context(ctx));
}