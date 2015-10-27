// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_set_current_context.m                           :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/09/08 16:16:24 by hestela           #+#    #+#             //
//   Updated: 2015/09/08 16:18:00 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

void		sx_set_current_context(void *win_ptr)
{
	t_sx_win	*sx_win;
	SxWindow	*window;

	if (!SX_APP || !win_ptr)
		return ;
	sx_win = (t_sx_win*)win_ptr;
	window = (SxWindow*)sx_win->win_ptr;
	if (!window->openGLContext)
		return ;
	[[window contentView] makeCurrentContext];
}
