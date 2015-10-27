// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_stop_sound.m                                    :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/22 19:26:03 by hestela           #+#    #+#             //
//   Updated: 2015/05/22 19:26:04 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

void			sx_stop_sound(void *sound_ptr)
{
	NSSound		*sound;

	if (!sound_ptr || !SX_APP)
		return ;
	sound = (NSSound*)sound_ptr;
	[sound stop];
	[sound setLoops:NO];
}