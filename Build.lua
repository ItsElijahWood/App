local function compile()
    print("Select the target OS for compilation:")
    print("1. Windows")
    print("2. Linux")
    
    local choice = io.read()

    local source_files = "./App/*.cpp ./Engine/src/*.cpp"
    local include_dirs = "-I./Engine/include"
    local compiler_flags = "-std=c++17"
    local output

    if choice == "1" then
        output = "Binaries/Windows/Game"
        print("Compiling your C++ files for Windows...")
    elseif choice == "2" then
        output = "Binaries/Linux/Game"
        print("Compiling your C++ files for Linux...")
    else
        print("Invalid choice. Please select 1 for Windows or 2 for Linux.")
        return
    end

    local compile_command = "g++ " .. source_files .. " " .. include_dirs .. " " .. compiler_flags .. " -o " .. output

    local result = os.execute(compile_command)

    if result == 0 then
        print("Compilation successful! Run ./" .. output .. " to execute your program.")
    else
        print("Compilation failed.")
    end
end

-- Call the compile function
compile()
