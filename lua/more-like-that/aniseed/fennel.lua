local _0_0 = nil
do
  local name_0_ = "more-like-that.aniseed.fennel"
  local loaded_0_ = package.loaded[name_0_]
  local module_0_ = nil
  if ("table" == type(loaded_0_)) then
    module_0_ = loaded_0_
  else
    module_0_ = require("more-like-that.aniseed.deps.fennel")
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = (module_0_["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = (module_0_["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local function _2_(...)
  _0_0["aniseed/local-fns"] = {require = {fennel = "more-like-that.aniseed.deps.fennel", nvim = "more-like-that.aniseed.nvim"}}
  return {require("more-like-that.aniseed.deps.fennel"), require("more-like-that.aniseed.nvim")}
end
local _1_ = _2_(...)
local fennel = _1_[1]
local nvim = _1_[2]
do local _ = ({nil, _0_0, {{}, nil}})[2] end
nvim.ex.let("&runtimepath = &runtimepath")
fennel["path"] = string.gsub(string.gsub(string.gsub(package.path, "/lua/", "/fnl/"), ".lua;", ".fnl;"), ".lua$", ".fnl")
return nil
