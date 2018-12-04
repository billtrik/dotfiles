IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:LOAD_MODULES] = [] unless IRB.conf.key?(:LOAD_MODULES)
unless IRB.conf[:LOAD_MODULES].include?('irb/completion')
  IRB.conf[:LOAD_MODULES] << 'irb/completion'
end

IRB.conf[:PROMPT][:SHORT] = {
  :PROMPT_C=>"%03n:%i* ",
  :RETURN=>"%s\n",
  :PROMPT_I=>"%03n:%i> ",
  :PROMPT_N=>"%03n:%i> ",
  :PROMPT_S=>"%03n:%i%l "
}

IRB.conf[:PROMPT_MODE] = :SHORT
