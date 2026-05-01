--[[ bootstrap configuration modules ]]

-- initialize utilities
_G.CONSTS = require("183.utils.constants")
_G.CONF = require("183.config.merged")
_G.LOG = require("183.utils.logging")

LOG.setup_log_file()

_G.LOG.info("loaded utilities and config options")
_G.LOG.debug(
	{ consts = _G.CONSTS },
	{ config = _G.CONF },
	{ log = _G.LOG },
)
