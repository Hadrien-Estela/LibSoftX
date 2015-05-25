/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sx_structs.h                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/05/09 01:29:40 by hestela           #+#    #+#             */
/*   Updated: 2015/05/09 02:09:19 by hestela          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef SX_STRUCTS_H
# define SX_STRUCTS_H

#include <ctype.h>
#include <Cocoa/Cocoa.h>
#import <AppKit/NSOpenGLView.h>
#include <stdint.h>
#include <time.h>

typedef struct s_sx_win t_sx_win;
typedef struct s_sx 	t_sx;

@class SxView;

@interface 				SxWindow: NSWindow
{
	t_sx_win			*sx_win;
	int					repeat;
}

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)windowStyle sxWinPtr:(t_sx_win*)win title:(char*)windowTitle;
- (void)setRepeat:(int)nRepeat;
- (void)expose;
- (void)resize;
- (void)close;
- (void)move;
- (void)putPixel:(NSPoint)pixel color:(int32_t)rgb;
- (void)mouseMoved:(NSEvent *)theEvent;
- (void)mouseDown:(NSEvent *)theEvent;
- (void)otherMouseDown:(NSEvent *)theEvent;
- (void)rightMouseDown:(NSEvent *)theEvent;
- (void)mouseDragged:(NSEvent *)theEvent;
- (void)rightMouseDragged:(NSEvent *)theEvent;
- (void)otherMouseDragged:(NSEvent *)theEvent;
- (void)mouseUp:(NSEvent *)theEvent;
- (void)rightMouseUp:(NSEvent *)theEvent;
- (void)otherMouseUp:(NSEvent *)theEvent;
- (void)keyDown:(NSEvent *)theEvent;
- (void)keyUp:(NSEvent *)theEvent;

@end

@interface 				SxView: NSView
{
   SxWindow 			*window;
   CGContextRef			contextRef;
}

- (id)initWithFrame:(NSRect)frameRect winPtr:(SxWindow*)pWindow;
- (void)putPixel:(NSPoint)pixel color:(int32_t)rgb;
- (void)blitSurface:(uint32_t*)surface size:(NSSize)size to:(NSPoint)place;
- (void)clear;
- (void)updateContext;

@end

@interface 		SxLoop:	NSObject
{
  t_sx			*sx_p;
}

- (id) initWithPtr:(void*)sx_ptr;
- (void) loop;

@end

typedef	struct 			s_event_pool
{
	int8_t				eventType;
	uint32_t			eventKeyMask;
	uint8_t				eventKey;
	int32_t				eventCharacter;
	int8_t				eventButton;
	size_t				mouse_x;
	size_t				mouse_y;
	size_t				global_x;
	size_t				global_y;
	float				delta_x;
	float				delta_y;
	time_t				time;
	void				*next;
}						t_event_pool;

struct					s_sx_win
{
	size_t				win_id;
	SxWindow			*win_ptr;
	void				(*expose_func)(void *params);
	void				*expose_params;
	t_event_pool		*eventPool;
	void				(*push_event)(t_sx_win *sx_win_p, t_event_pool *event);
	void				*next;
};

struct					s_sx
{
	NSApplication		*app_ptr;
	t_sx_win			*win_lst;
	SxLoop				*loop;
	void				(*loop_func)(void *datas);
	void				*loop_datas;
};

typedef struct 			s_sx_surface
{
	size_t				width;
	size_t				height;
	uint32_t			*buffer;
}						t_sx_surface;

t_sx					*SX_APP;
size_t					SX_SCREEN_X;
size_t					SX_SCREEN_Y;

#endif
