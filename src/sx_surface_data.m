// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_surface_data.m                                  :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/17 18:13:19 by hestela           #+#    #+#             //
//   Updated: 2015/05/17 18:16:25 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"

uint32_t		*sx_surface_data(void *surface, size_t *width, size_t *height)
{
	t_sx_surface		*buf;

	if (!surface)
		return (NULL);
	buf = (t_sx_surface*)surface;
	*width = buf->width;
	*height = buf->height;
	return (buf->buffer);
}
