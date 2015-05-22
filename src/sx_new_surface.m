// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_new_surface.m                                   :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/17 18:03:50 by hestela           #+#    #+#             //
//   Updated: 2015/05/17 18:08:36 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"

void		*sx_new_surface(size_t width, size_t height)
{
	t_sx_surface		*surface;

	surface = (t_sx_surface*)malloc(sizeof(t_sx_surface));
	surface->width = width; 
	surface->height = height;
	surface->buffer = (uint32_t*)malloc(sizeof(uint32_t) * (width * height));
	bzero(surface->buffer, sizeof(uint32_t) * (width * height));
	return ((void*)surface);
}

void		sx_clear_surface(void *surface)
{
	t_sx_surface		*buf;

	buf = (t_sx_surface*)surface;
	bzero(buf->buffer, sizeof(uint32_t) * (buf->width * buf->height));
}
