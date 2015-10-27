// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_loop.m                                          :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/10 00:52:05 by hestela           #+#    #+#             //
//   Updated: 2015/05/10 00:52:08 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"

@implementation SxLoop

- (id) initWithPtr:(void*)sx_ptr
{
  if (self = [super init])
  		sx_p = sx_ptr;
  return (self);
}

- (void) loop
{
	if (sx_p->loop_func)
		sx_p->loop_func(sx_p->loop_datas);
	[self performSelector:@selector(loop) withObject:nil afterDelay:0.0];
}
@end

void			sx_loop(void (*loop_func)(void *datas), void *datas)
{
	t_sx		*sx_p;

	if (!SX_APP || !loop_func)
		return ;
	sx_p = SX_APP;
	sx_p->loop_func = loop_func;
	sx_p->loop_datas = datas;
	sx_p->loop = [[SxLoop alloc] initWithPtr:sx_p];
	[sx_p->loop performSelector:@selector(loop) withObject:nil afterDelay:0.0];
	[NSApp run];
}
