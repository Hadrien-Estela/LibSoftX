// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_destroy_surface.m                               :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/17 18:11:09 by hestela           #+#    #+#             //
//   Updated: 2015/05/17 18:12:37 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"
#include <stdlib.h>

void		sx_destroy_surface(void *surface)
{
	t_sx_surface	*surface_t;

	if (!surface)
		return ;
	surface_t = (t_sx_surface*)surface;
	free(surface_t->buffer);
	free(surface_t);
	surface = NULL;
}
