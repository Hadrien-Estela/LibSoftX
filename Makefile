#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hestela <hestela@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/05/09 01:21:34 by hestela           #+#    #+#              #
#    Updated: 2015/09/16 17:42:51 by hestela          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

#******************************************************************************#
#*								PROJECT SOURCES 			    			  *#
#******************************************************************************#

NAME		= libsoftx

SOURCES		= src/SxWindow.m \
			src/SxView.m \
			src/SxOpenGlView.m \
			src/sx_open.m \
			src/sx_close.m \
			src/sx_new_window.m \
			src/sx_destroy_window.m \
			src/sx_display_window.m \
			src/sx_loop.m \
			src/sx_pool_event.m \
			src/sx_put_pixel.m \
			src/sx_screen_dimensions.m \
			src/sx_window_size.m \
			src/sx_window_position.m \
			src/sx_set_window_alpha.m \
			src/sx_set_window_position.m \
			src/sx_set_window_size.m \
			src/sx_clear_window.m \
			src/sx_display_cursor.m \
			src/sx_set_key_repeat.m \
			src/sx_new_surface.m \
			src/sx_destroy_surface.m \
			src/sx_surface_data.m \
			src/sx_blit_surface.m \
			src/sx_surface_from_image.m \
			src/sx_open_font.m \
			src/sx_close_font.m \
			src/sx_str_to_surface.m \
			src/sx_open_sound.m \
			src/sx_play_sound.m \
			src/sx_close_sound.m \
			src/sx_stop_sound.m \
			src/sx_set_sound_volume.m \
			src/sx_pause_sound.m \
			src/sx_resume_sound.m \
			src/sx_update_window.m \
			src/sx_set_current_context.m

HEADERS		= inc/

LIBRARIES	=

FRAMEWORKS	= -framework AppKit -framework OpenGL

RESSOURCES	=

#******************************************************************************#
#*								GENERALS DEFINES 			    			  *#
#******************************************************************************#

CC		= gcc
CCFLAGS	= -Wextra -Wall -Werror
OBJECTS= $(subst src,obj,$(subst .c,.o,$(subst .m,.o,$(SOURCES))))

#******************************************************************************#
#*								PROJECT COMPILING 			    			  *#
#******************************************************************************#

.SILENT:

all: static

static: build/$(NAME).a

dynamic: build/$(NAME).dylib

build/$(NAME).a: directories $(OBJECTS)
	ar rc build/$(NAME).a $(OBJECTS)
	ranlib build/$(NAME).a
	cp ./inc/softx.h ./build/softx.h
	printf "\e[32m----------------------------------\e[36m\n"
	printf "\e[32m[✔]\e[36m $(NAME).a\n"
	printf "\e[32m----------------------------------\e[36m\n"

build/$(NAME).dylib: directories $(OBJECTS)
	gcc $(OBJECTS) -dynamiclib $(FRAMEWORKS) -o build/$(NAME).dylib
	cp ./inc/softx.h ./build/softx.h
	printf "\e[32m----------------------------------\e[36m\n"
	printf "\e[32m[✔]\e[36m $(NAME).dylib\n"
	printf "\e[32m----------------------------------\e[36m\n"

obj/%.o: src/%.c
	$(CC) $(CCFLAGS) -I $(HEADERS) -c $^ -o $@
	printf "\e[32m[✔]\e[36m $^ \n"

obj/%.o: src/%.m
	$(CC) $(CCFLAGS) -I $(HEADERS) -c $^ -o $@
	printf "\e[32m[✔]\e[36m $^ \n"

directories:
	mkdir -p obj build

#******************************************************************************#
#*								GENERALS RULES				    			  *#
#******************************************************************************#

clean:
	rm -rf obj
	printf "\e[31m----------------------------------\n"
	printf "[✔]\e[36m $(NAME): Objects deleted\n"
	printf "\e[31m----------------------------------\e[36m\n"

fclean: clean
	rm -rf build
	printf "\e[31m----------------------------------\n"
	printf "[✔]\e[36m $(NAME): All deleted\n"
	printf "\e[31m----------------------------------\e[36m\n"

mrproper: fclean

re: fclean all

mrtemp:
	find . -name "#*#" -print -delete
	find . -name "*~" -print -delete
	find . -name ".DS_*" -print -delete

#******************************************************************************#
#*									GIT RULES				    			  *#
#******************************************************************************#

init: mrtemp
	git add --all
	git commit -m "init repository"
	git push origin master

upgrade: mrproper mrtemp
	git add --all
	@read -p "commit message: " msg;\
	git commit -m "$$msg";
	git push

update: mrproper mrtemp
	git pull
	git submodule sync --recursive
	git submodule update --init --recursive
	git submodule update --remote --rebase --recursive

addsubmodule:
	@read -p "Enter repository URL: " url;\
	read -p "Enter submodule PATH: " path;\
	git submodule add $$url $$path;\
	git submodule init $$path

delsubmodule:
	@read -p "Enter submodule PATH: " path;\
	git submodule deinit -f $$path;\
	git rm -f $$path
