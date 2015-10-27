// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_update_window.m                                 :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/24 11:14:37 by hestela           #+#    #+#             //
//   Updated: 2015/05/24 11:14:37 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

void			sx_update_window(void *win_ptr)
{
	t_sx_win		*sx_win;

	if (!win_ptr || !SX_APP)
		return ;
	sx_win = (t_sx_win*)win_ptr;
	[[sx_win->win_ptr contentView] updateContext];
}