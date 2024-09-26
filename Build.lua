local function compile()
    print("Select the target OS for compilation:")
    print("1. Windows")
    print("2. Linux")
    
    local choice = io.read()

    local source_files = {
        "./App/app.cpp",
        "./Engine/src/Engine.cpp"
        -- Add other source files here
    }
    local include_dirs = "-I./Engine/include"
    local compiler_flags = "-std=c++17"
    local obj_dir = "Obj/"
    local output

    if choice == "1" then
        output = "Binaries/Windows/App"
        print("Compiling your C++ files for Windows...")
        os.execute("mkdir obj")
    elseif choice == "2" then
        output = "Binaries/Linux/App"
        print("Compiling your C++ files for Linux...")
        os.execute("mkdir -p obj")
    else
        print("Invalid choice. Please select 1 for Windows or 2 for Linux.")
        return
    end

    -- Compile each source file into an object file
    local obj_files = {}
    for _, src in ipairs(source_files) do
        local obj_file = obj_dir .. src:match("([^/]+)%.cpp$") .. ".o"
        local compile_command = "g++ -c " .. src .. " " .. include_dirs .. " " .. compiler_flags .. " -o " .. obj_file
        local result = os.execute(compile_command)
        if result ~= 0 then
            print("Compilation failed for " .. src)
            return
        end
        table.insert(obj_files, obj_file)
    end

    -- Link object files into the final executable
    local link_command = "g++ " .. table.concat(obj_files, " ") .. " -o " .. output
    local result = os.execute(link_command)

    if result == 0 then
        print("Compilation successful! Run ./" .. output .. " to execute your program.")
    else
        print("Compilation failed.")
    end
end

-- Call the compile function
compile()
