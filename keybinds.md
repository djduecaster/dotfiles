# Shared Keybind Conventions

## Principles

- Use `h/j/k/l` for directional actions where possible.
- Keep modifier meanings stable:
  - `cmd` for focus/navigation.
  - `cmd+shift` for create/new.
  - `cmd+option` for resize/manage.

## Ghostty (Current)

- Focus split:
  - `cmd+h` -> left
  - `cmd+j` -> down
  - `cmd+k` -> up
  - `cmd+l` -> right
- Create split:
  - `cmd+shift+h` -> left
  - `cmd+shift+j` -> down
  - `cmd+shift+k` -> up
  - `cmd+shift+l` -> right
- Resize split:
  - `cmd+option+h` -> left
  - `cmd+option+j` -> down
  - `cmd+option+k` -> up
  - `cmd+option+l` -> right
- Split management:
  - `cmd+option+equal` -> equalize splits
  - `cmd+option+enter` -> toggle split zoom
  - `option+w` -> close current surface
- Scroll:
  - `option+j` -> page down
  - `option+k` -> page up

## Notes

- Avoid overriding common macOS/global shortcuts unless there is clear value.
- Keep this file in sync with `ghostty/config` after keybind changes.
