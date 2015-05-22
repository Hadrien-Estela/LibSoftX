// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_close_font.m                                    :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/21 15:48:11 by hestela           #+#    #+#             //
//   Updated: 2015/05/21 15:48:13 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"

void		sx_close_font(void *font_ptr)
{
	CTFontRef 		font;

	if (!font_ptr)
		return ;
	font = (CTFontRef)font_ptr;
	CFRelease(font);
	font_ptr = NULL;
}