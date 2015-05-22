// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_set_key_repeat.m                                :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/16 02:21:50 by hestela           #+#    #+#             //
//   Updated: 2015/05/16 02:21:51 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"

void		sx_set_key_repeat(void *win_ptr, int boolean)
{
	t_sx_win		*sx_win;

	if (!win_ptr)
		return ;
	sx_win = (t_sx_win*)win_ptr;
	[sx_win->win_ptr setRepeat:boolean]; 
}