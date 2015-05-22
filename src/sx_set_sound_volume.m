// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_set_sound_volume.m                              :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/22 19:25:54 by hestela           #+#    #+#             //
//   Updated: 2015/05/22 19:25:54 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"

void		sx_set_sound_volume(void *sound_ptr, float volume)
{
	NSSound		*sound;

	if (!sound_ptr)
		return ;
	sound = (NSSound*)sound_ptr;
	[sound setVolume:volume];
}