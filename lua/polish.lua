-- polish.luaif true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This file runs last in the setup process. Put machine/user specific

-- customizations here (autocmds, mappings, small helper functions, etc).-- This will run last in the setup process.

---- This is just pure lua so anything that doesn't

-- Best practice:-- fit in the normal config locations above can go here

-- - Keep repo-wide defaults in other modules under `lua/plugins/*` or
--   `lua/lazy_setup.lua`.
-- - Put per-machine or per-user overrides under `lua/user/*` and optionally
--   require them from here.
-- The file is intentionally small: we try to safely load `lua/user` if it exists.

-- Try to require `user` module if present. This lets users create
-- `lua/user/init.lua` (or other modules under `lua/user/`) to store their
-- private customizations without modifying the public config.
pcall(require, "user")

-- Example: to load a specific user file instead of `lua/user/init.lua`,
-- you can use `pcall(require, 'user.my_custom')` here.
