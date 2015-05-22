// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_open.m                                          :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/09 02:02:08 by hestela           #+#    #+#             //
//   Updated: 2015/05/09 02:09:31 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"

static void				detachapp(void)
{
	NSApplication		*app;

	app = SX_APP->app_ptr;
	for (NSRunningApplication * app in [NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.apple.iTerm"])
    {
      	[app activateWithOptions:NSApplicationActivateIgnoringOtherApps];
      	break;
    }
	ProcessSerialNumber psn = { 0, kCurrentProcess };
	(void) TransformProcessType(&psn, kProcessTransformToForegroundApplication);
	[[NSRunningApplication currentApplication] activateWithOptions:NSApplicationActivateIgnoringOtherApps];
	[app arrangeInFront:nil];
}

static void				initscreenconstants(void)
{
	SX_SCREEN_X = [[NSScreen mainScreen] frame].size.width;
	SX_SCREEN_Y = [[NSScreen mainScreen] frame].size.height;
}

static void				allocandcreateapp(void)
{
	SX_APP = (t_sx*)malloc(sizeof(t_sx));
	SX_APP->app_ptr = [NSApplication sharedApplication];
	SX_APP->win_lst = NULL;
	SX_APP->loop_func = NULL;
	SX_APP->loop_datas = NULL;
	SX_APP->loop = NULL;
}

void					sx_open(void)
{
	static int			first;

	if (first == 0 || SX_APP == NULL)
	{
		allocandcreateapp();
		initscreenconstants();
		detachapp();
		first++; 
	}
}
