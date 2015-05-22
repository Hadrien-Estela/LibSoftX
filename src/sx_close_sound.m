// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_close_sound.m                                   :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/22 18:37:46 by hestela           #+#    #+#             //
//   Updated: 2015/05/22 18:37:47 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"

void		sx_close_sound(void *sound_ptr)
{
	NSSound						*sound;

	if (!sound_ptr)
		return ;
	sound = (NSSound*)sound_ptr;
	[sound release];
	sound_ptr = NULL;
}