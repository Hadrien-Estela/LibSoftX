# LibSoftX
C Simple Graphic library for OSX 10.8 an highter using Cocoa

compile with framework AppKit

- Create and manage windows
- Catch events on event pool for each window
- draw on 2D graphic context (Quartz)
- Create a surface from JPEG or PNG
- Create surface from text and .ttf font file
- Open and play sounds
- Use an OpenGL3 or OpenGL4 context

Maj log:
  -v1.1b: - fix mouse move event speed detection
          - sx_update_window (flush the context, call after context modifications)
          - sx_blit_surface use now the Alpha Byte
  
  -v2.0: - create an OPENGL context.