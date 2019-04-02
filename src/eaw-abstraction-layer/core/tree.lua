local Tree = {}

function Tree:add_child(value)
    table.insert(self.children, Tree(value))
end

