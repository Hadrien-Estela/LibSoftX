// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_display_window.m                                :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/13 14:03:04 by hestela           #+#    #+#             //
//   Updated: 2015/05/13 14:05:19 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

void		sx_display_window(void *win_ptr, int boolean)
{
	t_sx_win		*sx_wp;
	SxWindow		*window;

	if (!win_ptr)
		return ;
	sx_wp = (t_sx_win*)win_ptr;
	window = (SxWindow*)sx_wp->win_ptr;
	if (boolean == FALSE)
	{
		[window orderOut:window];
	}
	else if (boolean == TRUE)
	{
		[window makeKeyAndOrderFront:window];
		[window display];
	}
}
