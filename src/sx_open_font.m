// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_open_font.m                                     :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/21 15:48:03 by hestela           #+#    #+#             //
//   Updated: 2015/05/21 15:48:04 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.h"
#include <fcntl.h>
#include <unistd.h>

void		*sx_open_font(const char *file_ttf, size_t police_size)
{
	CTFontRef					font;
	CFURLRef 					file;
	CFStringRef					file_name;
	CGDataProviderRef 			data;
	CGFontRef 					glyphs;
	int							fd;

	fd = open(file_ttf, O_RDONLY);
	if (fd == -1)
	{
		printf("Unable to load the file: %s\n", file_ttf);
		return (NULL);
	}
	file_name = CFStringCreateWithCString(kCFAllocatorDefault, file_ttf, kCFStringEncodingASCII);
	file = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, file_name, kCFURLPOSIXPathStyle, false);
	data = CGDataProviderCreateWithURL(file);
	glyphs = CGFontCreateWithDataProvider(data);
	font = CTFontCreateWithGraphicsFont(glyphs, police_size, NULL, nil);
	CFRelease(glyphs);
	CFRelease(data);
	CFRelease(file);
	CFRelease(file_name);
	return ((void*)font);
}