// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_new_window.m                                    :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/09 02:01:44 by hestela           #+#    #+#             //
//   Updated: 2015/05/09 02:07:21 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"
#include <stdlib.h>
#include "softx.h"

static void			push_event(t_sx_win *sx_win, t_event_pool *event)
{
	t_event_pool		*lst;

	if (!sx_win->eventPool)
		sx_win->eventPool = event;
	else
	{
		lst = sx_win->eventPool;
		while (lst->next)
			lst = lst->next;
		lst->next = event;
	}
}

static void			init_window(t_sx_win *sx_win, size_t x, size_t y, char *title, uint32_t flags)
{
	SxWindow		*new_window;
	NSRect			frame;

	frame.size.width = x;
	frame.size.height = y;
	frame.origin.x = SX_SCREEN_X / 2 - x / 2;
	frame.origin.y = SX_SCREEN_Y / 2 - y / 2;
	new_window = [SxWindow alloc];
	new_window = [new_window initWithContentRect: frame
								styleMask: (NSBorderlessWindowMask | flags)
								sxWinPtr: sx_win
								title: title];
	sx_win->win_ptr = (void*)new_window;	
}

static t_sx_win		*alloc_and_push(t_sx *sx_ptr)
{
	t_sx_win			*new_win;
	t_sx_win			*sx_win_lst;
	
	new_win = (t_sx_win*)malloc(sizeof(t_sx_win));
	new_win->next = NULL;
	new_win->eventPool = NULL;
	new_win->push_event = push_event;
	new_win->win_id = 0;
	sx_win_lst = sx_ptr->win_lst;
	if (sx_ptr->win_lst)
	{
		while(sx_win_lst->next)
			sx_win_lst = sx_win_lst->next;
		sx_win_lst->next = new_win;
		new_win->win_id = sx_win_lst->win_id;
	}
	else
		sx_ptr->win_lst = new_win;
	return (new_win);
}

void			*sx_new_window(size_t x, size_t y, char *title, uint32_t flags)
{
	t_sx_win	*new_win;

	new_win = alloc_and_push(SX_APP);
	if (flags & SX_WINDOW_OPENGL4_CONTEXT)
		new_win->gl = TRUE;
	else
		new_win->gl = FALSE;
	init_window(new_win, x, y, title, flags);
	return ((void*)new_win);
}
