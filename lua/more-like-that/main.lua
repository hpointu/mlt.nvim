local _0_0 = nil
do
  local name_0_ = "more-like-that.main"
  local loaded_0_ = package.loaded[name_0_]
  local module_0_ = nil
  if ("table" == type(loaded_0_)) then
    module_0_ = loaded_0_
  else
    module_0_ = {}
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = (module_0_["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = (module_0_["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local function _2_(...)
  _0_0["aniseed/local-fns"] = {require = {a = "more-like-that.aniseed.core", nvim = "more-like-that.aniseed.nvim", str = "more-like-that.aniseed.string"}}
  return {require("more-like-that.aniseed.core"), require("more-like-that.aniseed.nvim"), require("more-like-that.aniseed.string")}
end
local _1_ = _2_(...)
local a = _1_[1]
local nvim = _1_[2]
local str = _1_[3]
do local _ = ({nil, _0_0, {{}, nil}})[2] end
local this = nil
do
  local v_0_ = nil
  do
    local v_0_0 = "more-like-that.main"
    _0_0["this"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["this"] = v_0_
  this = v_0_
end
local http_get = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function http_get0(url)
      nvim.ex.sview(url)
      local content = nvim.fn.getline(1, "$")
      nvim.ex.bd()
      return nvim.fn.json_decode(content)
    end
    v_0_0 = http_get0
    _0_0["http-get"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["http-get"] = v_0_
  http_get = v_0_
end
local get_synonyms = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function get_synonyms0(w)
      local url = ("https://api.datamuse.com/words?rel_syn=" .. w)
      local res = nil
      local function _3_(e)
        return e.word
      end
      res = a.map(_3_, http_get(url))
      table.insert(res, 1, w)
      return res
    end
    v_0_0 = get_synonyms0
    _0_0["get-synonyms"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["get-synonyms"] = v_0_
  get_synonyms = v_0_
end
local create_suggestion_buffer = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function create_suggestion_buffer0()
      local buf = nvim.create_buf(false, true)
      nvim.buf_set_option(buf, "bufhidden", "wipe")
      return buf
    end
    v_0_0 = create_suggestion_buffer0
    _0_0["create-suggestion-buffer"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["create-suggestion-buffer"] = v_0_
  create_suggestion_buffer = v_0_
end
local make_window = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function make_window0(buf, width, height)
      local opts = {col = -1, height = height, relative = "cursor", row = 1, style = "minimal", width = width}
      local win = nvim.open_win(buf, true, opts)
      nvim.buf_set_option(buf, "modifiable", false)
      return nvim.win_set_option(win, "cursorline", true)
    end
    v_0_0 = make_window0
    _0_0["make-window"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["make-window"] = v_0_
  make_window = v_0_
end
local max_len = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function max_len0(entries)
      return nvim.fn.max(a.map(a.count, entries))
    end
    v_0_0 = max_len0
    _0_0["max-len"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["max-len"] = v_0_
  max_len = v_0_
end
local prefix_space = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function prefix_space0(word)
      return (" " .. word)
    end
    v_0_0 = prefix_space0
    _0_0["prefix-space"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["prefix-space"] = v_0_
  prefix_space = v_0_
end
local populate_buffer = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function populate_buffer0(buf, suggestions)
      nvim.buf_set_lines(buf, 0, 0, false, a.map(prefix_space, suggestions))
      return buf
    end
    v_0_0 = populate_buffer0
    _0_0["populate-buffer"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["populate-buffer"] = v_0_
  populate_buffer = v_0_
end
local read_word = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function read_word0()
      return nvim.fn.expand("<cword>")
    end
    v_0_0 = read_word0
    _0_0["read-word"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["read-word"] = v_0_
  read_word = v_0_
end
local replace_word = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function replace_word0(replacement)
      return nvim.command(("normal ciw" .. replacement))
    end
    v_0_0 = replace_word0
    _0_0["replace-word"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["replace-word"] = v_0_
  replace_word = v_0_
end
local lua_call = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function lua_call0(mod, _function, ...)
      local astr = str.join(", ", {...})
      return ("lua require('" .. mod .. "')['" .. _function .. "'](" .. astr .. ")")
    end
    v_0_0 = lua_call0
    _0_0["lua-call"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["lua-call"] = v_0_
  lua_call = v_0_
end
local cancel_suggestion = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function cancel_suggestion0()
      return nvim.ex.q()
    end
    v_0_0 = cancel_suggestion0
    _0_0["cancel-suggestion"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["cancel-suggestion"] = v_0_
  cancel_suggestion = v_0_
end
local confirm_selection = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function confirm_selection0()
      local line = nvim.fn.getline(".")
      local word = str.trim(line)
      nvim.ex.q()
      return replace_word(word)
    end
    v_0_0 = confirm_selection0
    _0_0["confirm-selection"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["confirm-selection"] = v_0_
  confirm_selection = v_0_
end
local move_selection = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function move_selection0(offset)
      local _3_ = nvim.win_get_cursor(0)
      local row = _3_[1]
      local col = _3_[2]
      local row0 = nil
      if (offset > 0) then
        row0 = math.min((offset + row), (nvim.fn.line("$") - 1))
      else
        row0 = math.max((offset + row), 1)
      end
      return nvim.win_set_cursor(0, {row0, col})
    end
    v_0_0 = move_selection0
    _0_0["move-selection"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["move-selection"] = v_0_
  move_selection = v_0_
end
local disable_keys = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function disable_keys0(buf)
      for _, c in ipairs({"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}) do
        nvim.buf_set_keymap(buf, "n", ("<C-" .. c .. ">"), "<Nop>", {silent = true})
        nvim.buf_set_keymap(buf, "n", c:upper(), "<Nop>", {silent = true})
        nvim.buf_set_keymap(buf, "n", c, "<Nop>", {silent = true})
      end
      return buf
    end
    v_0_0 = disable_keys0
    _0_0["disable-keys"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["disable-keys"] = v_0_
  disable_keys = v_0_
end
local install_popup_mappings = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function install_popup_mappings0(buf)
      do
        local mapping = {["<C-n>"] = {"move-selection", 1}, ["<C-p>"] = {"move-selection", -1}, ["<CR>"] = {"confirm-selection"}, ["<Esc>"] = {"cancel-suggestion"}, j = {"move-selection", 1}, k = {"move-selection", -1}, q = {"cancel-suggestion"}}
        for key, args in pairs(mapping) do
          nvim.buf_set_keymap(buf, "n", key, (":" .. lua_call(this, unpack(args)) .. "<CR>"), {noremap = true, silent = true})
        end
      end
      return buf
    end
    v_0_0 = install_popup_mappings0
    _0_0["install-popup-mappings"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["install-popup-mappings"] = v_0_
  install_popup_mappings = v_0_
end
local activate = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function activate0()
      local suggestions = get_synonyms(read_word())
      local width = (2 + max_len(suggestions))
      local height = #suggestions
      return make_window(install_popup_mappings(disable_keys(populate_buffer(create_suggestion_buffer(), suggestions))), width, height)
    end
    v_0_0 = activate0
    _0_0["activate"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["activate"] = v_0_
  activate = v_0_
end
local init = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function init0()
      return nvim.ex.command_("MLTSynonyms", lua_call(this, "activate"))
    end
    v_0_0 = init0
    _0_0["init"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["init"] = v_0_
  init = v_0_
end
return nil