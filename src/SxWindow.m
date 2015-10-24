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

#include "sx_structs.hpp"
#include <stdio.h>
#include <time.h>
#include "softx.h"

@implementation SxWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)windowStyle sxWinPtr:(t_sx_win*)win title:(char*)windowTitle
{
	NSView		*contentView;
	int			keepRatio;

	repeat = TRUE;
	keepRatio = FALSE;
	fullscreen = FALSE;
	openGLContext = 0;

	// Check keep ratio flag
	if (windowStyle & SX_WINDOW_KEEP_RATIO)
	{
		keepRatio = TRUE;
		windowStyle -= SX_WINDOW_KEEP_RATIO;
	}

	// Check OpenGl context Flag
	if (windowStyle & SX_WINDOW_OPENGL4_CONTEXT)
	{
		openGLContext = SX_WINDOW_OPENGL4_CONTEXT;
		windowStyle -= SX_WINDOW_OPENGL4_CONTEXT;
	}

	// Check Fullscreen flag
	if (windowStyle & SX_WINDOW_FULLSCREEN)
	{
		fullscreen = TRUE;
		windowStyle -= SX_WINDOW_FULLSCREEN;
	}

	// init window
	self = [super initWithContentRect: contentRect
					styleMask: windowStyle
                	backing: NSBackingStoreBuffered
                	defer: NO];
	[self setAcceptsMouseMovedEvents:YES];
	[self setReleasedWhenClosed:NO];
	[self setBackgroundColor: [NSColor blackColor]];
	sx_win = win;

	// set title
	if (windowTitle && (windowStyle & SX_WINDOW_TITLED))
	{
		NSString		*title_string;
		title_string = [NSString stringWithCString:windowTitle encoding:NSASCIIStringEncoding];
		[self setTitle:title_string];
		[title_string release];
	}

	// set ratio keeping
	if (keepRatio)
		[self setAspectRatio:self.frame.size];	

	// set content View
	if (openGLContext == SX_WINDOW_OPENGL4_CONTEXT)
		contentView = [[SxOpenGlView alloc] initWithFrame:contentRect winPtr:self context:openGLContext];
	else
		contentView = [[SxView alloc] initWithFrame:contentRect winPtr:self];
	[self setContentView:contentView];

	// Set events observers
	[self setCollectionBehavior:(NSWindowCollectionBehaviorFullScreenPrimary)];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(expose) name:@"NSWindowDidDeminiaturizeNotification" object:self];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resize) name:@"NSWindowDidEndLiveResizeNotification" object:self];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(close) name:@"NSWindowWillCloseNotification" object:self];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resize) name:@"NSWindowDidEnterFullScreenNotification" object:self];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enteredFullScreen) name:@"NSWindowDidEnterFullScreenNotification" object:self];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resize) name:@"NSWindowDidExitFullScreenNotification" object:self];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitedFullScreen) name:@"NSWindowDidExitFullScreenNotification" object:self];

	// start in full screen
	if (fullscreen)
	{
		[NSMenu setMenuBarVisible:false];
		[self toggleFullScreen:nil];
	}

	return (self);
}

- (BOOL)canBecomeKeyWindow { return YES; }

- (void)enteredFullScreen
{
	fullscreen = TRUE;
}

- (void)exitedFullScreen
{
	fullscreen = FALSE;
}

- (void)putPixel:(NSPoint)pixel color:(int32_t)rgb
{
	[[self contentView] putPixel:pixel color:rgb];
}

- (void)expose
{
	t_event_pool		*event;

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
	event->eventButton = 0;
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
}


- (void)mouseUp:(NSEvent *)theEvent
{
	t_event_pool		*event;
	NSPoint 			cursor;
	NSRect				frame;

	cursor = [theEvent locationInWindow];
	frame = [[sx_win->win_ptr contentView] frame];
	event = (t_event_pool*)malloc(sizeof(t_event_pool));
	event->eventType = SX_EVENT_MOUSE_UP;
 	event->eventKeyMask = 0;
 	event->eventKey = 0;
	event->eventButton = SX_BUTTON_LEFT;
	if (cursor.x < frame.size.width - 3 && cursor.y < frame.size.height - 3
	&& cursor.x > 3 && cursor.y > 3)
	{
		event->mouse_x = cursor.x;
		event->mouse_y = cursor.y;
	}
	else
	{
		event->mouse_x = 0;
		event->mouse_y = 0;
	}
	event->eventCharacter = 0;
	event->global_x = 0;
	event->global_y = 0;
	event->delta_x = 0;
	event->delta_y = 0;
	event->time = time(NULL);
	event->next = NULL;
	sx_win->push_event(sx_win, event);
}


- (void)rightMouseUp:(NSEvent *)theEvent
{
	t_event_pool		*event;
	NSPoint 			cursor;
	NSRect				frame;

	cursor = [theEvent locationInWindow];
	frame = [[sx_win->win_ptr contentView] frame];
	event = (t_event_pool*)malloc(sizeof(t_event_pool));
	event->eventType = SX_EVENT_MOUSE_UP;
 	event->eventKeyMask = 0;
 	event->eventKey = 0;
	event->eventButton = SX_BUTTON_RIGHT;
	if (cursor.x < frame.size.width - 3 && cursor.y < frame.size.height - 3
	&& cursor.x > 3 && cursor.y > 3)
	{
		event->mouse_x = cursor.x;
		event->mouse_y = cursor.y;
	}
	else
	{
		event->mouse_x = 0;
		event->mouse_y = 0;
	}
	event->eventCharacter = 0;
	event->global_x = 0;
	event->global_y = 0;
	event->delta_x = 0;
	event->delta_y = 0;
	event->time = time(NULL);
	event->next = NULL;
	sx_win->push_event(sx_win, event);
}

- (void)otherMouseUp:(NSEvent *)theEvent
{
	t_event_pool		*event;
	NSPoint 			cursor;
	NSRect				frame;

	cursor = [theEvent locationInWindow];
	frame = [[sx_win->win_ptr contentView] frame];
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
	if (cursor.x < frame.size.width - 3 && cursor.y < frame.size.height - 3
	&& cursor.x > 3 && cursor.y > 3)
	{
		event->mouse_x = cursor.x;
		event->mouse_y = cursor.y;
	}
	else
	{
		event->mouse_x = 0;
		event->mouse_y = 0;
	}
	event->eventCharacter = 0;
	event->global_x = 0;
	event->global_y = 0;
	event->delta_x = 0;
	event->delta_y = 0;
	event->time = time(NULL);
	event->next = NULL;
	sx_win->push_event(sx_win, event);
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