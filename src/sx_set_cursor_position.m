// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_set_cursor_position.m                           :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/09/18 14:06:04 by hestela           #+#    #+#             //
//   Updated: 2015/09/18 14:06:05 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

void		sx_set_cursor_position(size_t x, size_t y)
{
	CGPoint		point;

	if (!SX_APP)
		return ;
	point.x = x;
	point.y = SX_SCREEN_Y - y;
	CGWarpMouseCursorPosition(point);
}