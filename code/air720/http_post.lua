
module(...,package.seeall)

require"modbus"
require"http"

local function get_body_string(body)
	return '{"Temperature":16}'
end

local function post_data(url, head, body)
	http.request("POST", url, nil, head, get_body_string(body), nil, nil)
end

-- http.request("POST","http://api.heclouds.com/devices/34742121/datapoints?type=3",nil,
-- {["api-key"]="5QrUOwB01WBot22Nl=hhlp7K9XE=",["Host"]="api.heclouds.com",["Content-Type"]="application/json"},
-- '{"Temperature":16}',nil,cbFnc)
pm.wake("http_post")
uart.setup(UART_ID, 115200, 8, uart.PAR_NONE, uart.STOP_1)

sys.timerLoopStart(post_data, 1000*60*60, "http://api.heclouds.com/devices/34742121/datapoints?type=3", 
	{["api-key"]="5QrUOwB01WBot22Nl=hhlp7K9XE=",["Host"]="api.heclouds.com",["Content-Type"]="application/json"}, modbus.read_input_reg(100, 1))
