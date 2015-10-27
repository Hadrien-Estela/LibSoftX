// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_break_loop.m                                    :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/09/18 14:15:41 by hestela           #+#    #+#             //
//   Updated: 2015/09/18 14:15:44 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

void			sx_break_loop(void)
{
	t_sx		*sx_p;

	if (!SX_APP)
		return ;
	sx_p = SX_APP;
	[NSObject cancelPreviousPerformRequestsWithTarget:sx_p->loop selector:@selector(loop) object:nil];
	[NSApp stop:nil];
}