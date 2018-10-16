
module(...,package.seeall)

require"utils"

UART_ID = 2

local function read_block(timeout)
    local cacheData = ""
    while true do
        local s = uart.read(UART_ID,"*l")
        if s == "" then
            uart.on(UART_ID,"receive",function() sys.publish("UART_RECEIVE") end)
            if not sys.waitUntil("UART_RECEIVE", timeout) then
                if cacheData:len() > 0 then
					return cacheData
				else 
					return nil
                end
            end
            uart.on(UART_ID,"receive")
        else
            cacheData = cacheData..s            
        end
    end
end

function read_input_reg(reg_addr, reg_num)
    uart.write(UART_ID, {0x01, 0x04, reg_addr, reg_num})	-- let's see what will be received by slave MCU
	return read_block(200)
end