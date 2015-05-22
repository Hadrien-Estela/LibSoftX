// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   SxWindow.m                                         :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/12 02:00:34 by hestela           #+#    #+#             //
//   Updated: 2015/05/12 02:00:35 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"
#include <stdio.h>
#include <time.h>
#include "softx.h"

@implementation SxWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)windowStyle sxWinPtr:(t_sx_win*)win title:(char*)windowTitle
{
	NSView		*contentView;
	int 		glContext;

	glContext = 0;
	repeat = 1;
	if (windowStyle & SX_OPENGL_CONTEXT)
	{
		glContext = 1;
		windowStyle -= SX_OPENGL_CONTEXT;
	}
	visibleCursor = TRUE;
	self = [super initWithContentRect: contentRect
					styleMask: windowStyle
                	backing: NSBackingStoreBuffered
                	defer: NO];
	sx_win = win;
	if (windowTitle)
	{
		NSString		*title_string;
		title_string = [NSString stringWithCString:windowTitle encoding:NSASCIIStringEncoding];
		[self setTitle:title_string];
		[title_string release];
	}
	[self setAcceptsMouseMovedEvents:YES];
	[self setReleasedWhenClosed:NO];
	[self setBackgroundColor: [NSColor blackColor]];
	if (glContext)
		contentView = [[SxOpenGlView alloc] initWithFrame:contentRect winPtr:self];
	else
		contentView = [[SxView alloc] initWithFrame:contentRect winPtr:self];
	[self setContentView:contentView];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(expose) name:@"NSWindowDidDeminiaturizeNotification" object:self];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resize) name:@"NSWindowDidEndLiveResizeNotification" object:self];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(close) name:@"NSWindowWillCloseNotification" object:self];
	return (self);
}

- (void)putPixel:(NSPoint)pixel color:(int32_t)rgb
{
	[[self contentView] putPixel:pixel color:rgb];
}

- (void)setCursorVisibility:(int)boolean
{
	visibleCursor = boolean;
}

- (void)expose
{
	t_event_pool		*event;

	if (sx_win->expose_func)
		sx_win->expose_func(sx_win->expose_params);
	event = (t_event_pool*)malloc(sizeof(t_event_pool));
	event->eventType = SX_EVENT_EXPOSE;
 	event->eventKeyMask = 0;
 	event->eventKey = 0;
	event->eventButton = 0;
	event->mouse_x = 0;
	event->mouse_y = 0;
	event->eventCharacter = 0;
	event->global_x = 0;
	event->global_y = 0;
	event->delta_x = 0;
	event->delta_y = 0;
	event->time = time(NULL);
	event->next = NULL;
	sx_win->push_event(sx_win, event);
}

- (void)resize
{
	t_event_pool		*event;

	event = (t_event_pool*)malloc(sizeof(t_event_pool));
	event->eventType = SX_EVENT_RESIZE;
 	event->eventKeyMask = 0;
 	event->eventKey = 0;
	event->eventButton = 0;
	event->mouse_x = 0;
	event->mouse_y = 0;
	event->eventCharacter = 0;
	event->global_x = 0;
	event->global_y = 0;
	event->delta_x = 0;
	event->delta_y = 0;
	event->time = time(NULL);
	event->next = NULL;
	sx_win->push_event(sx_win, event);
}

- (void)move
{
	t_event_pool		*event;

	event = (t_event_pool*)malloc(sizeof(t_event_pool));
	event->eventType = SX_EVENT_MOVE;
 	event->eventKeyMask = 0;
 	event->eventKey = 0;
	event->eventButton = 0;
	event->mouse_x = 0;
	event->mouse_y = 0;
	event->eventCharacter = 0;
	event->global_x = 0;
	event->global_y = 0;
	event->delta_x = 0;
	event->delta_y = 0;
	event->time = time(NULL);
	event->next = NULL;
	sx_win->push_event(sx_win, event);
}

- (void)close
{
	t_event_pool		*event;

	event = (t_event_pool*)malloc(sizeof(t_event_pool));
	event->eventType = SX_EVENT_CLOSE;
 	event->eventKeyMask = 0;
 	event->eventKey = 0;
	event->eventButton = 0;
	event->mouse_x = 0;
	event->mouse_y = 0;
	event->eventCharacter = 0;
	event->global_x = 0;
	event->global_y = 0;
	event->delta_x = 0;
	event->delta_y = 0;
	event->time = time(NULL);
	event->next = NULL;
	sx_win->push_event(sx_win, event);
}

- (void)mouseMoved:(NSEvent *)theEvent
{
	t_event_pool		*event;
	NSPoint 			cursor;
	NSPoint				global;
	NSRect				frame;
	static int			isIn;

	cursor = [theEvent locationInWindow];
	global = [NSEvent mouseLocation];
	frame = [[sx_win->win_ptr contentView] frame];
	if (cursor.x < frame.size.width - 3 && cursor.y < frame.size.height - 3
		&& cursor.x > 3 && cursor.y > 3)
	{
		if (isIn == 0)
		{
			isIn = 1;
			event = (t_event_pool*)malloc(sizeof(t_event_pool));
			event->eventType = SX_EVENT_MOUSE_ENTER;
	 		event->eventKeyMask = 0;
	 		event->eventKey = 0;
			event->eventButton = 0;
			event->mouse_x = 0;
			event->mouse_y = 0;
			event->eventCharacter = 0;
			event->global_x = 0;
			event->global_y = 0;
			event->delta_x = 0;
			event->delta_y = 0;
			event->time = time(NULL);
			event->next = NULL;
			sx_win->push_event(sx_win, event);
		}
		event = (t_event_pool*)malloc(sizeof(t_event_pool));
		event->eventType = SX_EVENT_MOUSE_MOVE;
 		event->eventKeyMask = 0;
 		event->eventKey = 0;
		event->eventButton = 0;
		event->mouse_x = cursor.x;
		event->mouse_y = cursor.y;
		event->eventCharacter = 0;
		event->global_x = global.x;
		event->global_y = global.y;
		event->delta_x = [theEvent deltaX];
		event->delta_y = [theEvent deltaY];
		event->time = time(NULL);
		event->next = NULL;
		sx_win->push_event(sx_win, event);
	}
	else
	{
		if (isIn == 1)
		{
			isIn = 0;
			event = (t_event_pool*)malloc(sizeof(t_event_pool));
			event->eventType = SX_EVENT_MOUSE_EXIT;
	 		event->eventKeyMask = 0;
	 		event->eventKey = 0;
			event->eventButton = 0;
			event->mouse_x = 0;
			event->mouse_y = 0;
			event->eventCharacter = 0;
			event->global_x = 0;
			event->global_y = 0;
			event->delta_x = 0;
			event->delta_y = 0;
			event->time = time(NULL);
			event->next = NULL;
			sx_win->push_event(sx_win, event);
		}
		else
		{
			event = (t_event_pool*)malloc(sizeof(t_event_pool));
			event->eventType = SX_EVENT_MOUSE_MOVE;
	 		event->eventKeyMask = 0;
	 		event->eventKey = 0;
			event->eventButton = 0;
			event->mouse_x = 0;
			event->mouse_y = 0;
			event->eventCharacter = 0;
			event->global_x = global.x;
			event->global_y = global.y;
			event->delta_x = [theEvent deltaX];
			event->delta_y = [theEvent deltaY];
			event->time = time(NULL);
			event->next = NULL;
			sx_win->push_event(sx_win, event);
		}
	}
	if (visibleCursor == FALSE)
	{
		NSRect			nframe;

		nframe = [self contentRectForFrameRect: [self frame]];
		sx_set_cursor_position(nframe.origin.x + nframe.size.width / 2, nframe.origin.y + nframe.size.height / 2);
	}
}

- (void)mouseDown:(NSEvent *)theEvent
{
	t_event_pool		*event;
	NSPoint 			cursor;
	NSRect				frame;

	cursor = [theEvent locationInWindow];
	frame = [[sx_win->win_ptr contentView] frame];
	if (cursor.x < frame.size.width - 3 && cursor.y < frame.size.height - 3
		&& cursor.x > 3 && cursor.y > 3)
	{
		event = (t_event_pool*)malloc(sizeof(t_event_pool));
		event->eventType = SX_EVENT_MOUSE_DOWN;
	 	event->eventKeyMask = 0;
	 	event->eventKey = 0;
		event->eventButton = SX_BUTTON_LEFT;
		event->mouse_x = cursor.x;
		event->mouse_y = cursor.y;
		event->eventCharacter = 0;
		event->global_x = 0;
		event->global_y = 0;
		event->delta_x = 0;
		event->delta_y = 0;
		event->time = time(NULL);
		event->next = NULL;
		sx_win->push_event(sx_win, event);
	}
}

- (void)rightMouseDown:(NSEvent *)theEvent
{
	t_event_pool		*event;
	NSPoint 			cursor;
	NSRect				frame;

	cursor = [theEvent locationInWindow];
	frame = [[sx_win->win_ptr contentView] frame];
	if (cursor.x < frame.size.width - 3 && cursor.y < frame.size.height - 3
		&& cursor.x > 3 && cursor.y > 3)
	{
		event = (t_event_pool*)malloc(sizeof(t_event_pool));
		event->eventType = SX_EVENT_MOUSE_DOWN;
	 	event->eventKeyMask = 0;
	 	event->eventKey = 0;
		event->eventButton = SX_BUTTON_RIGHT;
		event->mouse_x = cursor.x;
		event->mouse_y = cursor.y;
		event->eventCharacter = 0;
		event->global_x = 0;
		event->global_y = 0;
		event->delta_x = 0;
		event->delta_y = 0;
		event->time = time(NULL);
		event->next = NULL;
		sx_win->push_event(sx_win, event);
	}
}


- (void)otherMouseDown:(NSEvent *)theEvent
{
	t_event_pool		*event;
	NSPoint 			cursor;
	NSRect				frame;

	cursor = [theEvent locationInWindow];
	frame = [[sx_win->win_ptr contentView] frame];
	if (cursor.x < frame.size.width - 3 && cursor.y < frame.size.height - 3
		&& cursor.x > 3 && cursor.y > 3)
	{
		event = (t_event_pool*)malloc(sizeof(t_event_pool));
		event->eventType = SX_EVENT_MOUSE_DOWN;
	 	event->eventKeyMask = 0;
	 	event->eventKey = 0;
	 	if ([theEvent buttonNumber] == 2)
			event->eventButton = SX_BUTTON_MIDDLE;
		else if ([theEvent buttonNumber] == 3)
			event->eventButton = SX_BUTTON_4;
		else
			event->eventButton = SX_BUTTON_5;
		event->mouse_x = cursor.x;
		event->mouse_y = cursor.y;
		event->eventCharacter = 0;
		event->global_x = 0;
		event->global_y = 0;
		event->delta_x = 0;
		event->delta_y = 0;
		event->time = time(NULL);
		event->next = NULL;
		sx_win->push_event(sx_win, event);
	}
}

- (void)mouseDragged:(NSEvent *)theEvent
{
	t_event_pool		*event;
	NSPoint 			cursor;
	NSPoint				global;
	NSRect				frame;
	static int			isIn;

	cursor = [theEvent locationInWindow];
	global = [NSEvent mouseLocation];
	frame = [[sx_win->win_ptr contentView] frame];
	if (cursor.x < frame.size.width - 3 && cursor.y < frame.size.height - 3
		&& cursor.x > 3 && cursor.y > 3)
	{
		if (isIn == 0)
		{
			isIn = 1;
			event = (t_event_pool*)malloc(sizeof(t_event_pool));
			event->eventType = SX_EVENT_MOUSE_ENTER;
	 		event->eventKeyMask = 0;
	 		event->eventKey = 0;
			event->eventButton = 0;
			event->mouse_x = 0;
			event->mouse_y = 0;
			event->eventCharacter = 0;
			event->global_x = 0;
			event->global_y = 0;
			event->delta_x = 0;
			event->delta_y = 0;
			event->time = time(NULL);
			event->next = NULL;
			sx_win->push_event(sx_win, event);
		}
		event = (t_event_pool*)malloc(sizeof(t_event_pool));
		event->eventType = SX_EVENT_MOUSE_MOVE;
 		event->eventKeyMask = 0;
 		event->eventKey = 0;
		event->eventButton = SX_BUTTON_LEFT;
		event->mouse_x = cursor.x;
		event->mouse_y = cursor.y;
		event->eventCharacter = 0;
		event->global_x = global.x;
		event->global_y = global.y;
		event->delta_x = [theEvent deltaX];
		event->delta_y = [theEvent deltaY];
		event->time = time(NULL);
		event->next = NULL;
		sx_win->push_event(sx_win, event);
	}
	else
	{
		if (isIn == 1)
		{
			isIn = 0;
			event = (t_event_pool*)malloc(sizeof(t_event_pool));
			event->eventType = SX_EVENT_MOUSE_EXIT;
	 		event->eventKeyMask = 0;
	 		event->eventKey = 0;
			event->eventButton = 0;
			event->mouse_x = 0;
			event->mouse_y = 0;
			event->eventCharacter = 0;
			event->global_x = 0;
			event->global_y = 0;
			event->delta_x = 0;
			event->delta_y = 0;
			event->time = time(NULL);
			event->next = NULL;
			sx_win->push_event(sx_win, event);
		}
		else
		{
			event = (t_event_pool*)malloc(sizeof(t_event_pool));
			event->eventType = SX_EVENT_MOUSE_MOVE;
	 		event->eventKeyMask = 0;
	 		event->eventKey = 0;
			event->eventButton = SX_BUTTON_LEFT;
			event->mouse_x = 0;
			event->mouse_y = 0;
			event->eventCharacter = 0;
			event->global_x = global.x;
			event->global_y = global.y;
			event->delta_x = [theEvent deltaX];
			event->delta_y = [theEvent deltaY];
			event->time = time(NULL);
			event->next = NULL;
			sx_win->push_event(sx_win, event);
		}
	}
	if (visibleCursor == FALSE)
	{
		NSRect			nframe;

		nframe = [self contentRectForFrameRect: [self frame]];
		sx_set_cursor_position(nframe.origin.x + nframe.size.width / 2, nframe.origin.y + nframe.size.height / 2);
	}
}


- (void)rightMouseDragged:(NSEvent *)theEvent
{
	t_event_pool		*event;
	NSPoint 			cursor;
	NSPoint				global;
	NSRect				frame;
	static int			isIn;

	cursor = [theEvent locationInWindow];
	global = [NSEvent mouseLocation];
	frame = [[sx_win->win_ptr contentView] frame];
	if (cursor.x < frame.size.width - 3 && cursor.y < frame.size.height - 3
		&& cursor.x > 3 && cursor.y > 3)
	{
		if (isIn == 0)
		{
			isIn = 1;
			event = (t_event_pool*)malloc(sizeof(t_event_pool));
			event->eventType = SX_EVENT_MOUSE_ENTER;
	 		event->eventKeyMask = 0;
	 		event->eventKey = 0;
			event->eventButton = 0;
			event->mouse_x = 0;
			event->mouse_y = 0;
			event->eventCharacter = 0;
			event->global_x = 0;
			event->global_y = 0;
			event->delta_x = 0;
			event->delta_y = 0;
			event->time = time(NULL);
			event->next = NULL;
			sx_win->push_event(sx_win, event);
		}
		event = (t_event_pool*)malloc(sizeof(t_event_pool));
		event->eventType = SX_EVENT_MOUSE_MOVE;
 		event->eventKeyMask = 0;
 		event->eventKey = 0;
		event->eventButton = SX_BUTTON_RIGHT;
		event->mouse_x = cursor.x;
		event->mouse_y = cursor.y;
		event->eventCharacter = 0;
		event->global_x = global.x;
		event->global_y = global.y;
		event->delta_x = [theEvent deltaX];
		event->delta_y = [theEvent deltaY];
		event->time = time(NULL);
		event->next = NULL;
		sx_win->push_event(sx_win, event);
	}
	else
	{
		if (isIn == 1)
		{
			isIn = 0;
			event = (t_event_pool*)malloc(sizeof(t_event_pool));
			event->eventType = SX_EVENT_MOUSE_EXIT;
	 		event->eventKeyMask = 0;
	 		event->eventKey = 0;
			event->eventButton = 0;
			event->mouse_x = 0;
			event->mouse_y = 0;
			event->eventCharacter = 0;
			event->global_x = 0;
			event->global_y = 0;
			event->delta_x = 0;
			event->delta_y = 0;
			event->time = time(NULL);
			event->next = NULL;
			sx_win->push_event(sx_win, event);
		}
		else
		{
			event = (t_event_pool*)malloc(sizeof(t_event_pool));
			event->eventType = SX_EVENT_MOUSE_MOVE;
	 		event->eventKeyMask = 0;
	 		event->eventKey = 0;
			event->eventButton = SX_BUTTON_RIGHT;
			event->mouse_x = 0;
			event->mouse_y = 0;
			event->eventCharacter = 0;
			event->delta_x = [theEvent deltaX];
			event->delta_y = [theEvent deltaY];
			event->delta_x = 0;
			event->delta_y = 0;
			event->time = time(NULL);
			event->next = NULL;
			sx_win->push_event(sx_win, event);
		}
	}
	if (visibleCursor == FALSE)
	{
		NSRect			nframe;

		nframe = [self contentRectForFrameRect: [self frame]];
		sx_set_cursor_position(nframe.origin.x + nframe.size.width / 2, nframe.origin.y + nframe.size.height / 2);
	}
}


- (void)otherMouseDragged:(NSEvent *)theEvent
{
	t_event_pool		*event;
	NSPoint 			cursor;
	NSRect				frame;
	NSPoint				global;
	static int			isIn;

	cursor = [theEvent locationInWindow];
	global = [NSEvent mouseLocation];
	frame = [[sx_win->win_ptr contentView] frame];
	if (cursor.x < frame.size.width - 3 && cursor.y < frame.size.height - 3
		&& cursor.x > 3 && cursor.y > 3)
	{
		if (isIn == 0)
		{
			isIn = 1;
			event = (t_event_pool*)malloc(sizeof(t_event_pool));
			event->eventType = SX_EVENT_MOUSE_ENTER;
	 		event->eventKeyMask = 0;
	 		event->eventKey = 0;
			event->eventButton = 0;
			event->mouse_x = 0;
			event->mouse_y = 0;
			event->eventCharacter = 0;
			event->global_x = 0;
			event->global_y = 0;
			event->delta_x = 0;
			event->delta_y = 0;
			event->time = time(NULL);
			event->next = NULL;
			sx_win->push_event(sx_win, event);
		}
		event = (t_event_pool*)malloc(sizeof(t_event_pool));
		event->eventType = SX_EVENT_MOUSE_MOVE;
 		event->eventKeyMask = 0;
 		event->eventKey = 0;
		if ([theEvent buttonNumber] == 2)
			event->eventButton = SX_BUTTON_MIDDLE;
		else if ([theEvent buttonNumber] == 3)
			event->eventButton = SX_BUTTON_4;
		else
			event->eventButton = SX_BUTTON_5;
		event->mouse_x = cursor.x;
		event->mouse_y = cursor.y;
		event->eventCharacter = 0;
		event->global_x = global.x;
		event->global_y = global.y;
		event->delta_x = [theEvent deltaX];
		event->delta_y = [theEvent deltaY];
		event->time = time(NULL);
		event->next = NULL;
		sx_win->push_event(sx_win, event);
	}
	else
	{
		if (isIn == 1)
		{
			isIn = 0;
			event = (t_event_pool*)malloc(sizeof(t_event_pool));
			event->eventType = SX_EVENT_MOUSE_EXIT;
	 		event->eventKeyMask = 0;
	 		event->eventKey = 0;
			event->eventButton = 0;
			event->mouse_x = 0;
			event->mouse_y = 0;
			event->eventCharacter = 0;
			event->global_x = 0;
			event->global_y = 0;
			event->delta_x = 0;
			event->delta_y = 0;
			event->time = time(NULL);
			event->next = NULL;
			sx_win->push_event(sx_win, event);
		}
		else
		{
			event = (t_event_pool*)malloc(sizeof(t_event_pool));
			event->eventType = SX_EVENT_MOUSE_MOVE;
	 		event->eventKeyMask = 0;
	 		event->eventKey = 0;
			if ([theEvent buttonNumber] == 2)
				event->eventButton = SX_BUTTON_MIDDLE;
			else if ([theEvent buttonNumber] == 3)
				event->eventButton = SX_BUTTON_4;
			else
				event->eventButton = SX_BUTTON_5;
			event->mouse_x = cursor.x;
			event->mouse_y = cursor.y;
			event->eventCharacter = 0;
			event->global_x = global.x;
			event->global_y = global.y;
			event->delta_x = [theEvent deltaX];
			event->delta_y = [theEvent deltaY];
			event->time = time(NULL);
			event->next = NULL;
			sx_win->push_event(sx_win, event);
		}
	}
	if (visibleCursor == FALSE)
	{
		NSRect			nframe;

		nframe = [self contentRectForFrameRect: [self frame]];
		sx_set_cursor_position(nframe.origin.x + nframe.size.width / 2, nframe.origin.y + nframe.size.height / 2);
	}
}


- (void)mouseUp:(NSEvent *)theEvent
{
	t_event_pool		*event;
	NSPoint 			cursor;
	NSRect				frame;

	cursor = [theEvent locationInWindow];
	frame = [[sx_win->win_ptr contentView] frame];
	if (cursor.x < frame.size.width - 3 && cursor.y < frame.size.height - 3
		&& cursor.x > 3 && cursor.y > 3)
	{
		event = (t_event_pool*)malloc(sizeof(t_event_pool));
		event->eventType = SX_EVENT_MOUSE_UP;
	 	event->eventKeyMask = 0;
	 	event->eventKey = 0;
		event->eventButton = SX_BUTTON_LEFT;
		event->mouse_x = cursor.x;
		event->mouse_y = cursor.y;
		event->eventCharacter = 0;
		event->global_x = 0;
		event->global_y = 0;
		event->delta_x = 0;
		event->delta_y = 0;
		event->time = time(NULL);
		event->next = NULL;
		sx_win->push_event(sx_win, event);
	}
}


- (void)rightMouseUp:(NSEvent *)theEvent
{
	t_event_pool		*event;
	NSPoint 			cursor;
	NSRect				frame;

	cursor = [theEvent locationInWindow];
	frame = [[sx_win->win_ptr contentView] frame];
	if (cursor.x < frame.size.width - 3 && cursor.y < frame.size.height - 3
		&& cursor.x > 3 && cursor.y > 3)
	{
		event = (t_event_pool*)malloc(sizeof(t_event_pool));
		event->eventType = SX_EVENT_MOUSE_UP;
	 	event->eventKeyMask = 0;
	 	event->eventKey = 0;
		event->eventButton = SX_BUTTON_RIGHT;
		event->mouse_x = cursor.x;
		event->mouse_y = cursor.y;
		event->eventCharacter = 0;
		event->global_x = 0;
		event->global_y = 0;
		event->delta_x = 0;
		event->delta_y = 0;
		event->time = time(NULL);
		event->next = NULL;
		sx_win->push_event(sx_win, event);
	}
}

- (void)otherMouseUp:(NSEvent *)theEvent
{
	t_event_pool		*event;
	NSPoint 			cursor;
	NSRect				frame;

	cursor = [theEvent locationInWindow];
	frame = [[sx_win->win_ptr contentView] frame];
	if (cursor.x < frame.size.width - 3 && cursor.y < frame.size.height - 3
		&& cursor.x > 3 && cursor.y > 3)
	{
		event = (t_event_pool*)malloc(sizeof(t_event_pool));
		event->eventType = SX_EVENT_MOUSE_UP;
	 	event->eventKeyMask = 0;
	 	event->eventKey = 0;
		if ([theEvent buttonNumber] == 2)
			event->eventButton = SX_BUTTON_MIDDLE;
		else if ([theEvent buttonNumber] == 3)
			event->eventButton = SX_BUTTON_4;
		else
			event->eventButton = SX_BUTTON_5;
		event->mouse_x = cursor.x;
		event->mouse_y = cursor.y;
		event->eventCharacter = 0;
		event->global_x = 0;
		event->global_y = 0;
		event->delta_x = 0;
		event->delta_y = 0;
		event->time = time(NULL);
		event->next = NULL;
		sx_win->push_event(sx_win, event);
	}
}


- (void)keyDown:(NSEvent *)theEvent
{
	t_event_pool		*event;

	if (!repeat && [theEvent isARepeat] == TRUE)
		return ;
	event = (t_event_pool*)malloc(sizeof(t_event_pool));
	event->eventType = SX_EVENT_KEY_DOWN;
	event->eventKeyMask = 0;
	if ([theEvent modifierFlags] & NSShiftKeyMask || [theEvent modifierFlags] & NSAlphaShiftKeyMask)
		event->eventKeyMask = event->eventKeyMask | SX_KEY_MASK_SHIFT;
	if ([theEvent modifierFlags] & NSControlKeyMask)
		event->eventKeyMask = event->eventKeyMask | SX_KEY_MASK_CTRL;
	if ([theEvent modifierFlags] & NSAlternateKeyMask)
		event->eventKeyMask = event->eventKeyMask | SX_KEY_MASK_ALT;
	if ([theEvent modifierFlags] & NSCommandKeyMask)
		event->eventKeyMask = event->eventKeyMask | SX_KEY_MASK_CMD;
	if (!event->eventKeyMask)
		event->eventKeyMask = event->eventKeyMask | SX_KEY_MASK_NONE;
 	event->eventKey = [theEvent keyCode];
	event->eventButton = 0;
	event->mouse_x = 0;
	event->mouse_y = 0;
	event->eventCharacter = [[theEvent characters] characterAtIndex:0];
	event->global_x = 0;
	event->global_y = 0;
	event->delta_x = 0;
	event->delta_y = 0;
	event->time = time(NULL);
	event->next = NULL;
	sx_win->push_event(sx_win, event);
}


- (void)keyUp:(NSEvent *)theEvent
{
	t_event_pool		*event;

	event = (t_event_pool*)malloc(sizeof(t_event_pool));
	event->eventType = SX_EVENT_KEY_UP;
 	event->eventKeyMask = 0;
	if ([theEvent modifierFlags] & NSShiftKeyMask || [theEvent modifierFlags] & NSAlphaShiftKeyMask)
		event->eventKeyMask = event->eventKeyMask | SX_KEY_MASK_SHIFT;
	if ([theEvent modifierFlags] & NSControlKeyMask)
		event->eventKeyMask = event->eventKeyMask | SX_KEY_MASK_CTRL;
	if ([theEvent modifierFlags] & NSAlternateKeyMask)
		event->eventKeyMask = event->eventKeyMask | SX_KEY_MASK_ALT;
	if ([theEvent modifierFlags] & NSCommandKeyMask)
		event->eventKeyMask = event->eventKeyMask | SX_KEY_MASK_CMD;
	if (!event->eventKeyMask)
		event->eventKeyMask = event->eventKeyMask | SX_KEY_MASK_NONE;
 	event->eventKey = [theEvent keyCode];
	event->eventButton = 0;
	event->mouse_x = 0;
	event->mouse_y = 0;
	event->eventCharacter = 0;
	event->global_x = 0;
	event->global_y = 0;
	event->delta_x = 0;
	event->delta_y = 0;
	event->time = time(NULL);
	event->next = NULL;
	sx_win->push_event(sx_win, event);
}

- (void) scrollWheel:(NSEvent *)theEvent
{
	t_event_pool		*event;
	NSPoint 			cursor;
	NSRect				frame;
	NSPoint				origin;
	float				delta;

	cursor = [theEvent locationInWindow];
	frame = [[sx_win->win_ptr contentView] frame];
	if (cursor.x < frame.size.width - 3 && cursor.y < frame.size.height - 3
		&& cursor.x > 3 && cursor.y > 3)
	{
		event = (t_event_pool*)malloc(sizeof(t_event_pool));
		event->eventType = SX_EVENT_MOUSE_SCROLL;
	 	event->eventKeyMask = 0;
	 	event->eventKey = 0;
	 	origin = [theEvent locationInWindow];
  		delta = [theEvent deltaY];
  		if (delta > 0)
    		event->eventButton = SX_SCROLL_UP;
  		else if (delta < 0)
    		event->eventButton = SX_SCROLL_DOWN;
    	else
    	{
    		free(event);
    		return ;
    	}
		event->mouse_x = cursor.x;
		event->mouse_y = cursor.y;
		event->eventCharacter = 0;
		event->global_x = 0;
		event->global_y = 0;
		event->delta_x = [theEvent deltaX];
		event->delta_y = [theEvent deltaY];
		event->time = time(NULL);
		event->next = NULL;
		sx_win->push_event(sx_win, event);
	}
}

- (void)setRepeat:(int)nRepeat
{
	repeat = nRepeat;
}

@end