local M = {}

-- Find project root by searching upwards for project markers
local function find_project_root()
    local current_file = vim.fn.expand "%:p:h"
    local markers = {
        "Cargo.toml",
        "go.mod",
        "package.json",
        "Makefile",
        "CMakeLists.txt",
        ".git",
    }

    local path = current_file
    while path ~= "/" do
        for _, marker in ipairs(markers) do
            if vim.fn.glob(path .. "/" .. marker) ~= "" then
                return path
            end
        end
        path = vim.fn.fnamemodify(path, ":h")
    end

    return vim.fn.getcwd()
end

-- Detect project type and return appropriate build/run command
local function get_project_command()
    local root = find_project_root()

    -- Rust
    if vim.fn.filereadable(root .. "/Cargo.toml") == 1 then
        return "cd " .. root .. " && cargo run"
    end

    -- Go
    if vim.fn.filereadable(root .. "/go.mod") == 1 then
        return "cd " .. root .. " && go run ."
    end

    -- Makefile
    if vim.fn.filereadable(root .. "/Makefile") == 1 then
        return "cd " .. root .. " && make run"
    end

    -- CMake
    if vim.fn.filereadable(root .. "/CMakeLists.txt") == 1 then
        return "cd " .. root .. " && cmake -B build && cmake --build build && ./build/main"
    end

    -- Python
    if vim.fn.filereadable(root .. "/main.py") == 1 then
        return "cd " .. root .. " && python3 main.py"
    end

    -- Node/JS
    if vim.fn.filereadable(root .. "/package.json") == 1 then
        return "cd " .. root .. " && npm run dev"
    end

    -- Single file fallbacks
    local ft = vim.bo.filetype
    local file = vim.fn.expand "%:p"

    if ft == "python" then
        return "python3 " .. file
    elseif ft == "javascript" then
        return "node " .. file
    elseif ft == "typescript" then
        return "npx ts-node " .. file
    elseif ft == "go" then
        return "go run " .. file
    elseif ft == "rust" then
        return "rustc " .. file .. " -o /tmp/rustout && /tmp/rustout"
    elseif ft == "c" then
        return "gcc " .. file .. " -o /tmp/a.out && /tmp/a.out"
    elseif ft == "cpp" then
        return "g++ " .. file .. " -o /tmp/a.out && /tmp/a.out"
    end

    return nil
end

function M.build_and_run()
    local cmd = get_project_command()

    if not cmd then
        vim.notify("No build command detected for this project/filetype", vim.log.levels.WARN)
        return
    end

    -- Vertical split (terminal on the right), run command
    vim.cmd "vsplit"
    vim.cmd("term " .. cmd)
    vim.cmd "startinsert"
end

return M
