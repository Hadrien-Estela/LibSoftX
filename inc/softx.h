/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   softx.h                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hestela <hestela@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/05/09 01:24:51 by hestela           #+#    #+#             */
/*   Updated: 2015/05/23 14:05:34 by hestela          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef SOFTX_H
# define SOFTX_H

# include <ctype.h>
# include <stdint.h>

/*
** Window Style Masks
*/
# define		SX_WINDOW_NO_MASK		0
# define		SX_WINDOW_TITLED		1
# define		SX_WINDOW_CLOSABLE		2
# define		SX_WINDOW_MINIMIZABLE	4
# define		SX_WINDOW_RESIZABLE		8

/*
** Window Event Type
*/
# define		SX_EVENT_RESIZE			1
# define		SX_EVENT_CLOSE			2
# define		SX_EVENT_MOVE			3
# define		SX_EVENT_KEY_DOWN		4
# define		SX_EVENT_KEY_UP			5
# define		SX_EVENT_MOUSE_DOWN		6
# define		SX_EVENT_MOUSE_UP		7
# define		SX_EVENT_MOUSE_MOVE		8
# define		SX_EVENT_MOUSE_SCROLL	9
# define		SX_EVENT_MOUSE_ENTER	10
# define		SX_EVENT_MOUSE_EXIT		11
# define		SX_EVENT_EXPOSE			12

/*
** Mouse Buttons
*/
# define		SX_BUTTON_LEFT			1
# define		SX_BUTTON_RIGHT			2
# define		SX_BUTTON_MIDDLE		3
# define		SX_BUTTON_4				4
# define		SX_BUTTON_5				5

# define		SX_SCROLL_UP			1
# define		SX_SCROLL_DOWN			2

/*
** Key Masks
*/
# define		SX_KEY_MASK_NONE		0
# define		SX_KEY_MASK_CTRL		1
# define		SX_KEY_MASK_CMD			2
# define		SX_KEY_MASK_ALT			4
# define		SX_KEY_MASK_SHIFT		8

/*
** Key Codes
*/
# ifdef SX_AZERTY
#  define		SX_KEY_A			12
# else
#  define		SX_KEY_A			0
# endif
# define		SX_KEY_B			11
# define		SX_KEY_C			8
# define		SX_KEY_D			2
# define		SX_KEY_E			14
# define		SX_KEY_F			3
# define		SX_KEY_G			5
# define		SX_KEY_H			4
# define		SX_KEY_I			34
# define		SX_KEY_J			38
# define		SX_KEY_K			40
# define		SX_KEY_L			37
# ifdef SX_AZERTY
#  define		SX_KEY_M			41
# else
#  define		SX_KEY_M			46
# endif
# define		SX_KEY_N			45
# define		SX_KEY_O			31
# define		SX_KEY_P			35
# ifdef SX_AZERTY
#  define		SX_KEY_Q			0
# else
#  define		SX_KEY_Q			12
# endif
# define		SX_KEY_R			15
# define		SX_KEY_S			1
# define		SX_KEY_T			17
# define		SX_KEY_U			32
# define		SX_KEY_V			9
# ifdef SX_AZERTY
#  define		SX_KEY_W			6
# else
#  define		SX_KEY_W			13
# endif
# define		SX_KEY_X			7
# define		SX_KEY_Y			16
# ifdef SX_AZERTY
#  define		SX_KEY_Z			13
# else
#  define		SX_KEY_Z			6
# endif
# define		SX_KEY_1			18
# define		SX_KEY_2			19
# define		SX_KEY_3			20
# define		SX_KEY_4			21
# define		SX_KEY_5			23
# define		SX_KEY_6			22
# define		SX_KEY_7			26
# define		SX_KEY_8			28
# define		SX_KEY_9			25
# define		SX_KEY_0			29
# define		SX_KEY_F1			122
# define		SX_KEY_F2			120
# define		SX_KEY_F3			99
# define		SX_KEY_F4			118
# define		SX_KEY_F5			96
# define		SX_KEY_F6			97
# define		SX_KEY_F7			98
# define		SX_KEY_F8			100
# define		SX_KEY_F9			101
# define		SX_KEY_F10			109
# define		SX_KEY_F11			103
# define		SX_KEY_F12			111
# define		SX_KEY_LEFT			123
# define		SX_KEY_UP			126
# define		SX_KEY_RIGHT		124
# define		SX_KEY_DOWN			125
# define		SX_KEY_ESCAPE		53
# define		SX_KEY_SPACE		49
# define		SX_KEY_TAB			48
# define		SX_KEY_RETURN		36
# define		SX_KEY_BACKSPACE	51

/*
** True & False
*/
# ifndef FALSE
#  define FALSE 0
# endif

# ifndef TRUE
#  define TRUE 1
# endif

/*
** SoftX event structure
*/
struct			s_sx_event
{
	int8_t		type;
	uint32_t	key_mask;
	uint8_t		key_code;
	uint32_t	character;
	int8_t		button;
	size_t		mouse_x;
	size_t		mouse_y;
	size_t		global_x;
	size_t		global_y;
	float		delta_x;
	float		delta_y;
};

/*
** -------------------- Sx
*/

/*
** initialize Cocoa Application and SX datas
*/
void			sx_open(void);

/*
** Close the Cocoa Application and free SX datas
*/
void			sx_close(void);

/*
** Return the screen dimensions
*/
void			sx_screen_dimensions(size_t *width, size_t *height);

/*
** Set the cursor visibility
** if FALSE, on SX_EVENT_MOUSE_MOVE the cursor is recentered on the
** listened window
** use delta_x and delta_y to get move direction and speed
*/
void			sx_display_cursor(int boolean);

/*
** You can set the cursor position yourself
** (0:0 is the left bottom corner)
*/
void			sx_set_cursor_position(size_t x, size_t y);

/*
** -------------------- SxWindow
*/

/*
** Create a new SX window.
** window is centered at creation
** flags are window styles mask defines ex:
** SX_WINDOW_TITLED | SX_WINDOW_CLOSABLE | ...
** the window is not visible by default use sx_display_window() funtion
*/
void			*sx_new_window(size_t x, size_t y, char *title, uint32_t flags);

/*
** detroy and free window datas
*/
void			sx_destroy_window(void *win_ptr);

/*
** Clear the window context
*/
void			sx_clear_window(void *win_ptr);

/*
** Set the window position on screen(0:0 is the left bottom corner)
*/
void			sx_set_window_position(void *win_ptr, size_t x, size_t y);

/*
** Set the window transparancy (ex: fade in/out)
*/
void			sx_set_window_alpha(void *win_ptr, float alpha);

/*
** Set the window content size (title bar not include)
*/
void			sx_set_window_size(void *win_ptr, size_t x, size_t y);

/*
** Set the window visibility
*/
void			sx_display_window(void *win_ptr, int boolean);

/*
** Get the window position on screen
*/
void			sx_window_position(void *win_ptr, size_t *x, size_t *y);

/*
** Get the current window size
*/
void			sx_window_size(void *win_ptr, size_t *width, size_t *height);

/*
** Set the key repetition is enabled/disabled on a listened window
*/
void			sx_set_key_repeat(void *win_ptr, int boolean);

/*
** Update the window context
*/
void			sx_update_window(void *win_ptr);

/*
** --------------------- Main running loop functions
*/

/*
** Launch the event listener and launch your own running loop with
** given parameters
*/
void			sx_loop(void (*loop_func)(void *datas), void *datas);

/*
** break the running loop
*/
void			sx_break_loop(void);

/*
** Return the first event in pool, 1 if has an event, 0 if pool is empty
*/
int				sx_pool_event(void *win_ptr, struct s_sx_event *event);

/*
** --------------------- Draw
*/

/*
** Put a pixel on a window context.
** (slow function, must use surfaces to fast drawing)
*/
void			sx_put_pixel(void *win_ptr, size_t x, size_t y, int32_t rgb);

/*
** --------------------- Surfaces
*/

/*
** Create a new surface buffer
*/
void			*sx_new_surface(size_t width, size_t height);

/*
** free the surface
*/
void			sx_destroy_surface(void *surface);

/*
** Return pixel array and surface infos
** - 32 Bits per pixel
** - 1 Byte per component
** - Byte order: little endian [BGRA], casted in uint32_t order is [0xAARRGGBB])
** 0xFF = 100% opacity
*/
uint32_t		*sx_surface_data(void *surface, size_t *width, size_t *height);

/*
** draw the surface on the window's context
*/
void			sx_blit_surface(void *win, void *surface, size_t x, size_t y);

/*
** Clear the surface content. all to 0x00000000
*/
void			sx_clear_surface(void *surface);

/*
** --------------------- Images
*/

/*
** Create an sx surface from JPEG or PNG file
*/
void			*sx_surface_from_image(const char *file);

/*
** --------------------- Fonts
*/

/*
** open a ttf font and return a pointer on it
*/
void			*sx_open_font(const char *file_ttf, size_t police_size);

/*
** Close font
*/
void			sx_close_font(void *font_ptr);

/*
** Create an surface from text with font, string, forground and background
*/
void			*sx_str_to_surface(void *font, char *s, uint32_t f, uint32_t b);


/*
** ---------------------- Audio
*/

/*
** Open .wav .mp3 and maybe others audio file types
*/
void			*sx_open_sound(char *audio_file);

/*
** Set volume for a sound
** Range between 0.0 and 1.0 
*/
void			sx_set_sound_volume(void *sound_ptr, float volume);

/*
** play a sound. if loop = 1 the sound will be repeated
*/
void			sx_play_sound(void *sound_ptr, int loop);

/*
** Stop a sound
*/
void			sx_stop_sound(void *sound_ptr);

/*
** Pause sound
*/
void			sx_pause_sound(void *sound_ptr);

/*
** Resume sound
*/
void			sx_resume_sound(void *sound_ptr);

/*
** Close a sound
*/
void			sx_close_sound(void *sound_ptr);

#endif
