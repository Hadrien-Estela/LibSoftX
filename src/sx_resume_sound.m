// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_resume_sound.m                                  :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/22 19:37:14 by hestela           #+#    #+#             //
//   Updated: 2015/05/22 19:37:15 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"

void			sx_resume_sound(void *sound_ptr)
{
	NSSound		*sound;

	if (!sound_ptr)
		return ;
	sound = (NSSound*)sound_ptr;
	[sound resume];
}