// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_window_position.m                               :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/12 04:21:28 by hestela           #+#    #+#             //
//   Updated: 2015/05/12 04:23:11 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

void		sx_window_position(void *win_ptr, size_t *x, size_t *y)
{
	t_sx_win		*sx_win;
	NSRect			frame;

	if (!win_ptr)
		return ;
	sx_win = (t_sx_win*)win_ptr;
	frame = [sx_win->win_ptr frame];
	*x = frame.origin.x;
	*y = frame.origin.y;
}
