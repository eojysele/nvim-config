-- Run Spring App
local P = {}

function  get_spring_boot_runner(profile, debug)
    local debug_param = ""
    if debug then
        debug_param = ' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
    end

    local profile_param = ""
    if profile then
        profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
    end

    return 'mvn spring-boot:run ' .. profile_param .. debug_param
end

function P.run_spring_boot(debug)
    vim.cmd('term ' .. get_spring_boot_runner(method_name, debug))
end

return P
