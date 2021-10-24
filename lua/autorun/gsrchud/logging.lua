--[[------------------------------------------------------------------
  Custom addon logging.
]]--------------------------------------------------------------------

local PRINT_FORMAT = '[%s] <%s> %s'

GSRCHUD.log = {
  INFO = 'INFO',
  FINE = 'FINE',
  WARN = 'WARN',
  CRITICAL = 'ERROR'
}

--[[------------------------------------------------------------------
  Prints a custom message on the console.
  @param {string} message
  @param {LOG_} log message type
]]--------------------------------------------------------------------
function GSRCHUD.print(message, log)
  if not GSRCHUD.config.getConsoleWarn() and log == GSRCHUD.log.WARN then return end
  log = log or GSRCHUD.log.INFO
  print(string.format(PRINT_FORMAT, GSRCHUD.name, log, message))
end
