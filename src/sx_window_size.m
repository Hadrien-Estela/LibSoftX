// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_window_size.m                                   :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/12 04:18:06 by hestela           #+#    #+#             //
//   Updated: 2015/05/12 04:22:24 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

void		sx_window_size(void *win_ptr, size_t *width, size_t *height)
{
	t_sx_win		*sx_win;
	NSRect			frame;

	if (!win_ptr || !SX_APP || !width || !height)
		return ;
	sx_win = (t_sx_win*)win_ptr;
	frame = [sx_win->win_ptr contentRectForFrameRect: [sx_win->win_ptr frame]];
	*width = frame.size.width;
	*height = frame.size.height;
}
