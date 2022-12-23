# hotpot x lazy

(when wanting to use fennel modules to describe plugins)

Run
---

```
podman run -it -v $(pwd):/root/.config/nvim $(podman build -q -f Containerfile .)
```

(`docker` should swap in for podman)

Layout
--

1) install lazy as normal into init.lua, specify a plugin module location (in this case "plugins").
2) create `lua/plugins/hotpot.lua` (see file)
3) create `fnl/plugins/x.fnl`

Guide
--

- Run nvim
- Install lazy + hotpot
  - Hotpot will compile `fnl/plugins` -> `lua/plugins` (see hotpot.lua#init function)
- Restart nvim, lazy will now see the created `lua/plugins` files
- :Lazy and install new plugins
