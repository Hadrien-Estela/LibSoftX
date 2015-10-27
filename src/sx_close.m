// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_close.m                                         :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/09 02:01:22 by hestela           #+#    #+#             //
//   Updated: 2015/05/09 02:17:27 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"
#include <stdlib.h>

void		sx_close(void)
{
	t_sx				*sx;
	NSApplication		*app;

	if (!SX_APP)
		return ;
	sx = SX_APP;
	app = sx->app_ptr;
	[NSApp stop:nil];
	[app release];
	free(sx);
	SX_APP = NULL;
}
