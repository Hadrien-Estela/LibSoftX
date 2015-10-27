// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_blit_surface.m                                  :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/17 18:18:54 by hestela           #+#    #+#             //
//   Updated: 2015/05/17 18:28:18 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

void		sx_blit_surface(void *win, void *surface, size_t x, size_t y)
{
	t_sx_win				*sx_win;
	t_sx_surface			*surface_t;
	NSSize					surface_size;
	NSPoint					to_place;

	if (!win || !surface || !SX_APP)
		return ;
	sx_win = (t_sx_win*)win;
	surface_t = (t_sx_surface*)surface;
	surface_size.width = surface_t->width;
	surface_size.height = surface_t->height;
	to_place.x = x;
	to_place.y = y;
	[[sx_win->win_ptr contentView] blitSurface:surface_t->buffer size:surface_size to:to_place];
}
