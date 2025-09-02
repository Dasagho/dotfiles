local M = {}

local templates = {
  python = {
    version = '0.2.0',
    configurations = {
      { name = 'Python: Current File', type = 'python', request = 'launch', program = '${file}', console = 'integratedTerminal' },
      {
        name = 'Python: pytest (cwd)',
        type = 'python',
        request = 'launch',
        module = 'pytest',
        args = { '${file}' },
        justMyCode = false,
        console = 'integratedTerminal',
      },
    },
  },

  node = {
    version = '0.2.0',
    configurations = {
      {
        name = 'Launch Node: Current File',
        type = 'pwa-node',
        request = 'launch',
        program = '${file}',
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
      },
      { name = 'Attach to Node', type = 'pwa-node', request = 'attach', processId = '${command:PickProcess}', cwd = '${workspaceFolder}' },
    },
  },

  go = {
    version = '0.2.0',
    configurations = {
      { name = 'Launch Go (file)', type = 'go', request = 'launch', program = '${fileDirname}', mode = 'auto' },
    },
  },

  codelldb = {
    version = '0.2.0',
    configurations = {
      {
        name = 'Launch (codelldb)',
        type = 'codelldb',
        request = 'launch',
        program = '${workspaceFolder}/bin/<your_binary>',
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    },
  },
}

local function pretty_json(s)
  -- small pretty-printer for vim.fn.json_encode result
  local indent = 0
  local out = {}
  local i = 1
  while i <= #s do
    local c = s:sub(i, i)
    if c == '{' or c == '[' then
      table.insert(out, c)
      indent = indent + 2
      table.insert(out, '\n' .. string.rep(' ', indent))
    elseif c == '}' or c == ']' then
      indent = math.max(indent - 2, 0)
      table.insert(out, '\n' .. string.rep(' ', indent) .. c)
    elseif c == ',' then
      table.insert(out, c .. '\n' .. string.rep(' ', indent))
    else
      table.insert(out, c)
    end
    i = i + 1
  end
  return table.concat(out)
end

local function write_launch(lang)
  local tpl = templates[lang]
  if not tpl then
    vim.notify('No template for ' .. lang, vim.log.levels.ERROR)
    return
  end
  local json = vim.fn.json_encode(tpl)
  json = pretty_json(json)
  local cwd = vim.fn.getcwd()
  local vscode_dir = cwd .. '/.vscode'
  if vim.fn.isdirectory(vscode_dir) == 0 then
    vim.fn.mkdir(vscode_dir, 'p')
  end
  local path = vscode_dir .. '/launch.json'
  local ok = vim.fn.writefile(vim.split(json, '\n'), path)
  if ok == 0 then
    vim.notify('Wrote ' .. path, vim.log.levels.INFO)
  else
    vim.notify('Failed writing ' .. path, vim.log.levels.ERROR)
  end
end

function M.setup()
  vim.api.nvim_create_user_command('DapGenerateLaunch', function()
    local choices =
      { { label = 'Python', id = 'python' }, { label = 'Node (pwa-node)', id = 'node' }, { label = 'Go (delve)', id = 'go' }, {
        label = 'C/C++ (codelldb)',
        id = 'codelldb',
      } }
    if vim.ui and vim.ui.select then
      local items = {}
      for _, c in ipairs(choices) do
        table.insert(items, c.label)
      end
      vim.ui.select(items, { prompt = 'Choose launch.json template:' }, function(choice)
        if not choice then
          return
        end
        for _, c in ipairs(choices) do
          if c.label == choice then
            write_launch(c.id)
            break
          end
        end
      end)
    else
      local opts = { '1) Python', '2) Node', '3) Go', '4) C/C++' }
      local sel = vim.fn.inputlist(opts)
      if sel >= 1 and sel <= #choices then
        write_launch(choices[sel].id)
      end
    end
  end, { desc = 'Generate .vscode/launch.json from template' })
end

return M
