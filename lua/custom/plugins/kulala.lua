-- kulala.nvim — HTTP/gRPC/GraphQL client untuk file .http (kompatibel REST Client)
-- https://github.com/mistweaverco/kulala.nvim
--
-- Pin v5: mulai v6 kulala-core closed-source dan semua tool-nya butuh license
-- token. Alternatif rest.nvim butuh deps luarocks (nio, mimetypes, xml2lua),
-- sedangkan config ini pakai vim.pack tanpa luarocks.
--
-- Keys (ft http/rest): <CR> atau <leader>Rs kirim request di bawah kursor,
-- <leader>Rr replay, <leader>Ra kirim semua, <leader>Rb scratchpad,
-- <leader>Re pilih environment (.env / http-client.env.json).

vim.pack.add {
  { src = 'https://github.com/dont-be-evil-company/kulala.nvim', version = vim.version.range '5.*' },
}

require('kulala').setup { global_keymaps = true }
