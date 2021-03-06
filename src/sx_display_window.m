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
#import <OpenGL/gl3.h>

void		sx_display_window(void *win_ptr, int boolean)
{
	t_sx_win		*sx_wp;
	SxWindow		*window;

	if (!win_ptr || !SX_APP)
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
	if (sx_wp->gl == TRUE)
	{
		glEnable(GL_DEPTH_TEST);
		glEnable(GL_MULTISAMPLE);
	}
}
