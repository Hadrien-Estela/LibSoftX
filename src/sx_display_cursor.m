// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_display_cursor.m                                :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/16 01:31:40 by hestela           #+#    #+#             //
//   Updated: 2015/05/16 01:32:08 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"

void		sx_display_cursor(int boolean)
{
	t_sx_win	*win_lst;

	win_lst = SX_APP->win_lst;

	while (win_lst)
	{
		if (boolean == FALSE)
			[win_lst->win_ptr setCursorVisibility:FALSE];
		else if (boolean == TRUE)
			[win_lst->win_ptr setCursorVisibility:TRUE];
		win_lst = win_lst->next;
	}
	if (boolean == FALSE)
		[NSCursor hide];
	else if (boolean == TRUE)
		[NSCursor unhide];
}

void		sx_set_cursor_position(size_t x, size_t y)
{
	CGPoint		point;

	point.x = x;
	point.y = SX_SCREEN_Y - y;
	CGWarpMouseCursorPosition(point);
}