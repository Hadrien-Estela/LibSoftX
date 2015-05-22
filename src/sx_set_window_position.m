// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_set_window_position.m                           :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/09 15:35:51 by hestela           #+#    #+#             //
//   Updated: 2015/05/09 15:35:52 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"

void			sx_set_window_position(void *win_ptr, size_t x, size_t y)
{
	t_sx_win	*sx_win;
	NSPoint		position;

	sx_win = (t_sx_win*)win_ptr;
	position = NSMakePoint(x, y);
	[sx_win->win_ptr setFrameOrigin: position];
}