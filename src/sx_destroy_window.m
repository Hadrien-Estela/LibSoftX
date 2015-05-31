/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sx_destroy_window.m                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/05/09 02:40:31 by hestela           #+#    #+#             */
/*   Updated: 2015/05/09 03:05:25 by hestela          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "sx_structs.h"
#include <stdlib.h>

static void		destroy(t_sx_win *win_p)
{
	SxWindow		*window;
	t_event_pool	*event_pool;
	t_event_pool	*current;

	window = win_p->win_ptr;
	event_pool =  win_p->eventPool;
	while (event_pool)
	{
		current = event_pool;
		event_pool = event_pool->next;
		free(current);
	}
	[[NSNotificationCenter defaultCenter] removeObserver:window];
	[window orderOut:window];
	[window release];
	free(win_p);
}

void			sx_destroy_window(void *win_ptr)
{
	t_sx_win		*sx_mywin;
	t_sx_win		*it;

	if (!win_ptr)
		return ;
	sx_mywin = (t_sx_win*)win_ptr;
	if (SX_APP->win_lst == sx_mywin)
	{
		SX_APP->win_lst = sx_mywin->next;
		destroy(win_ptr);
	}
	else
	{
		it = SX_APP->win_lst;
		while (it->next != sx_mywin->next)
			it = it->next;
		it->next = sx_mywin->next;
		destroy(win_ptr);
	}
	win_ptr = NULL;
}
