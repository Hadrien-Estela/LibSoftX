// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_play_sound.m                                    :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/22 18:37:53 by hestela           #+#    #+#             //
//   Updated: 2015/05/22 18:37:53 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

void		sx_play_sound(void *sound_ptr, int loop)
{
	NSSound		*sound;

	if (!sound_ptr || !SX_APP)
		return ;
	sound = (NSSound*)sound_ptr;
	if (loop)
		[sound setLoops:YES];
	[sound play];
}