// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_window_is_fullscreen.m                          :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/09/18 16:12:48 by hestela           #+#    #+#             //
//   Updated: 2015/09/18 16:12:48 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

int				sx_window_is_fullscreen(void *win_ptr)
{
	t_sx_win	*sx_win;
	SxWindow	*window;

	sx_win = (t_sx_win*)win_ptr;
	window = (SxWindow*)sx_win->win_ptr;
	if (window->fullscreen)
		return (1);
	else
		return (0);
}