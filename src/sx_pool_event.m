// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_pool_event.m                                    :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/12 11:57:17 by hestela           #+#    #+#             //
//   Updated: 2015/05/12 11:58:45 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"
#include <time.h>
#include "softx.h"

int			sx_pool_event(void *win_ptr, struct s_sx_event *event)
{
	t_event_pool	*e;
	t_sx_win		*sx_win_p;

	sx_win_p = (t_sx_win*)win_ptr;
	e = sx_win_p->eventPool;	
	while (e && e->time - time(NULL) > 1)
	{
		sx_win_p->eventPool = sx_win_p->eventPool->next;
		free(e);
		e = sx_win_p->eventPool;
	}
	if (!e)
		return (0);
	sx_win_p->eventPool = sx_win_p->eventPool->next;
	*event = *(struct s_sx_event*)e;
	free(e);
	return (1);
}
