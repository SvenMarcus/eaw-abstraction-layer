if #arg < 1 then
    local usage_str = [[
        eaw_test_runner usage:
        --project-setup     launches project setup
        <path>              locates and runs all tests in the given folder, including sub folders
    ]]
    print(usage_str)
    os.exit(1)
end

if arg[1] == "--project-setup" then
    require "eaw-abstraction-layer.cli.create_test_env"
    os.exit(0)
end

require "eaw-abstraction-layer.cli.test_runner"