// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_put_pixel.m                                     :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/09 05:21:35 by hestela           #+#    #+#             //
//   Updated: 2015/05/09 05:24:22 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

void			sx_put_pixel(void *win_ptr, size_t x, size_t y, int32_t rgb)
{
	t_sx_win	*sx_wp;
	SxWindow	*window;
	NSPoint		pixel;

	if (!win_ptr || !SX_APP)
		return ;
	sx_wp = (t_sx_win*)win_ptr;
	window = (SxWindow*)sx_wp->win_ptr;
	pixel = NSMakePoint(x, y);
	[window putPixel:pixel color:rgb];
}
