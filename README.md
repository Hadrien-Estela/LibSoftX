# LibSoftX
C Simple Graphic library for OSX 10.7 an highter using Cocoa

compile with framework AppKit

- Create and manage windows
- draw in window context
- Create a surface from JPEG or PNG
- Create surface from text and .ttf font file
- Open and play sounds

comming soon: OpenGL Context

Maj log:
  -v1.1b: - fix mouse move event speed detection
          - sx_update_window (flush the context, call after context modifications)
          - sx_blit_surface use now the Alpha Byte
