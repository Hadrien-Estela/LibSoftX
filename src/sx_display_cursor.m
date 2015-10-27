// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_display_cursor.m                                :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/16 01:31:40 by hestela           #+#    #+#             //
//   Updated: 2015/05/16 01:32:08 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

void		sx_display_cursor(int boolean)
{
	if (!SX_APP)
		return ;
	if (boolean == FALSE)
		[NSCursor hide];
	else if (boolean == TRUE)
		[NSCursor unhide];
}
