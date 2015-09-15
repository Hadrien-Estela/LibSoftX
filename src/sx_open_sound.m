// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_open_sound.m                                    :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/22 18:37:39 by hestela           #+#    #+#             //
//   Updated: 2015/05/22 18:37:40 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"
#include <fcntl.h>
#include <unistd.h>

void		*sx_open_sound(char *audio_file)
{
	CFURLRef 					file;
	CFStringRef					file_name;
	NSSound						*sound;
	int							fd;

	fd = open(audio_file, O_RDONLY);
	if (fd == -1)
	{
		printf("Unable to load the file: %s\n", audio_file);
		return (NULL);
	}
	close(fd);
	file_name = CFStringCreateWithCString(kCFAllocatorDefault, audio_file, kCFStringEncodingASCII);
	file = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, file_name, kCFURLPOSIXPathStyle, false);
	sound = [[NSSound alloc] initWithContentsOfURL:(NSURL*)file
										byReference:YES];

	CFRelease(file);
	CFRelease(file_name);
	return ((void*)sound);
}