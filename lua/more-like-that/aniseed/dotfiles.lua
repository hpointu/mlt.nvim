local _0_0 = nil
do
  local name_0_ = "more-like-that.aniseed.dotfiles"
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
  _0_0["aniseed/local-fns"] = {require = {compile = "more-like-that.aniseed.compile", nvim = "more-like-that.aniseed.nvim"}}
  return {require("more-like-that.aniseed.compile"), require("more-like-that.aniseed.nvim")}
end
local _1_ = _2_(...)
local compile = _1_[1]
local nvim = _1_[2]
do local _ = ({nil, _0_0, {{}, nil}})[2] end
local config_dir = nil
do
  local v_0_ = nvim.fn.stdpath("config")
  _0_0["aniseed/locals"]["config-dir"] = v_0_
  config_dir = v_0_
end
compile["add-path"]((config_dir .. "/?.fnl"))
compile.glob("**/*.fnl", (config_dir .. "/fnl"), (config_dir .. "/lua"))
return require("dotfiles.init")
