// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_screen_dimensions.m                             :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/12 02:36:55 by hestela           #+#    #+#             //
//   Updated: 2015/05/12 02:38:17 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

void		sx_screen_dimensions(size_t *width, size_t *height)
{
	if (!SX_APP || !width || !height)
		return ;
	*width = SX_SCREEN_X;	
	*height = SX_SCREEN_Y;
}
