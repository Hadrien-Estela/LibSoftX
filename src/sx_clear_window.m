// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_clear_window.m                                  :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/09 13:51:24 by hestela           #+#    #+#             //
//   Updated: 2015/05/09 13:54:15 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"

void				sx_clear_window(void *win_ptr)
{
	t_sx_win		*sx_wp;
	SxWindow		*window;

	sx_wp = (t_sx_win*)win_ptr;
	window = (SxWindow*)sx_wp->win_ptr;
	[[window contentView] clear];
}

