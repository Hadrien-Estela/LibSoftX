// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_clear_surface.m                                 :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/09/18 14:19:50 by hestela           #+#    #+#             //
//   Updated: 2015/09/18 14:19:50 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

void		sx_clear_surface(void *surface)
{
	t_sx_surface		*buf;

	buf = (t_sx_surface*)surface;
	bzero(buf->buffer, sizeof(uint32_t) * (buf->width * buf->height));
}
