// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   sx_surface_from_image.m                            :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/05/21 01:11:27 by hestela           #+#    #+#             //
//   Updated: 2015/05/21 01:11:38 by hestela          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

#include "sx_structs.hpp"
#include <sys/mman.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <stdio.h>
#include <string.h>

#define JPEG_MAGIC 0xD8FF
#define PNG_MAGIC  0x0A1A0A0D474E5089

enum {NA, JPEG, PNG};

static int			getfiletype(void *map)
{
	uint64_t		*big_magic;
	uint16_t		*small_magic;

	big_magic = (uint64_t*)map;
	if (*big_magic == PNG_MAGIC)
		return (PNG);
	small_magic = (uint16_t*)map;
	if (*small_magic == JPEG_MAGIC)
		return (JPEG);
	return (NA);
}

static void		big_to_litte_endian(uint32_t *pixel)
{
	uint8_t 	*byte;
	uint8_t 	tmp;

	byte = (uint8_t*)pixel;
	tmp = byte[0];
	byte[0] = byte[2];
	byte[2] = tmp;
}

static void		change_endian(uint32_t *array, size_t size)
{
	size_t		i;

	i = 0;
	while (i < size)
	{
		big_to_litte_endian(&array[i]);
		i++;
	}
}

static void		*png(const char *file)
{

	CGDataProviderRef 		provider;
	CGImageRef 				image;
	t_sx_surface			*surface;
	CGDataProviderRef 		dataProvider;
	CFDataRef 				imageData;

	provider = CGDataProviderCreateWithFilename(file);
	image = CGImageCreateWithPNGDataProvider(provider, NULL, NO, kCGRenderingIntentDefault);
	surface = (t_sx_surface*)malloc(sizeof(t_sx_surface));
	surface->width = CGImageGetWidth(image);
	surface->height = CGImageGetHeight(image);
	surface->buffer = (uint32_t*)malloc(sizeof(uint32_t) * (surface->width * surface->height));
	dataProvider = CGImageGetDataProvider(image);
	imageData = CGDataProviderCopyData(dataProvider);
	memcpy(surface->buffer, CFDataGetBytePtr(imageData), sizeof(uint32_t) * (surface->width * surface->height));
	CGImageRelease(image);
	CGDataProviderRelease(provider);
	CFRelease(imageData);
	change_endian(surface->buffer, surface->width * surface->height);
	return (surface);
}

static void		*jpeg(const char *file)
{
	CGDataProviderRef 		provider;
	CGImageRef 				image;
	t_sx_surface			*surface;

	provider = CGDataProviderCreateWithFilename(file);
	image = CGImageCreateWithJPEGDataProvider(provider, NULL, NO, kCGRenderingIntentDefault);
	surface = (t_sx_surface*)malloc(sizeof(t_sx_surface));
	surface->width = CGImageGetWidth(image);
	surface->height = CGImageGetHeight(image);
	surface->buffer = (uint32_t*)malloc(sizeof(uint32_t) * (surface->width * surface->height));
	CGDataProviderRef dataProvider = CGImageGetDataProvider(image);
	CFDataRef imageData = CGDataProviderCopyData(dataProvider);
	memcpy(surface->buffer, CFDataGetBytePtr(imageData), sizeof(uint32_t) * (surface->width * surface->height));
	CGImageRelease(image);
	CGDataProviderRelease(provider);
	CFRelease(imageData);
	change_endian(surface->buffer, surface->width * surface->height);
	return (surface);
}

void		*sx_surface_from_image(const char *file)
{
	int						fd;
	struct stat				st;
	void 					*map;
	int						type;
	
	fd = open(file, O_RDONLY);
	if (fd == -1)
	{
		printf("Unable to load the file: %s\n", file);
		return (NULL);
	}
	fstat(fd, &st);
	map = mmap(0, st.st_size + 1, PROT_READ, MAP_PRIVATE, fd, 0);
	close(fd);
	type = getfiletype(map);
	munmap(map, st.st_size);
	if (type == PNG)
		return (png(file));
	else if (type == JPEG)
		return (jpeg(file));
	printf("Unroconized file: %s\n", file);
	return (NULL);
}
