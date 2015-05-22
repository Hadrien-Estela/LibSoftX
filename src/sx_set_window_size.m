// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_set_window_size.m                               :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/14 06:44:17 by hestela           #+#    #+#             //
//   Updated: 2015/05/14 06:55:37 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "softx.h"
#include "sx_structs.h"

void		sx_set_window_size(void *win_ptr, size_t x, size_t y)
{
	t_sx_win		*sx_win;
	NSRect			frame;
	size_t			ox;
	size_t			oy;

	sx_win = (t_sx_win*)win_ptr;
	sx_window_position(win_ptr, &ox, &oy);
	frame = NSMakeRect(ox, oy, x, y);
	frame = [NSWindow frameRectForContentRect:frame styleMask: [sx_win->win_ptr styleMask]];
	[sx_win->win_ptr setFrame:frame display:YES animate:YES];
}
