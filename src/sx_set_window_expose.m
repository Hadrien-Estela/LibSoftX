// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_set_expose.m                                    :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/12 02:47:47 by hestela           #+#    #+#             //
//   Updated: 2015/05/12 03:00:09 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"

void	sx_set_expose(void *win_ptr, void (*f)(void *data), void *data)
{
	t_sx_win		*sx_win_p;

	if (!win_ptr)
		return ;
	sx_win_p = (t_sx_win*)win_ptr;
	sx_win_p->expose_func = f;
	sx_win_p->expose_params = data;
}
