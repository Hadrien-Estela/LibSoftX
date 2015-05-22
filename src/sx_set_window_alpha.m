// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_set_window_alpha.m                              :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/09 15:36:24 by hestela           #+#    #+#             //
//   Updated: 2015/05/09 15:36:25 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"

void			sx_set_window_alpha(void *win_ptr, float alpha)
{
	SxWindow	*window;
	t_sx_win	*sx_wp;

	if (!win_ptr)
		return ;
	sx_wp = (t_sx_win*)win_ptr;
	window = (SxWindow*)sx_wp->win_ptr;
	[window setAlphaValue:alpha];
}