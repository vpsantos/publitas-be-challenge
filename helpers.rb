def get_node_value(item, node_xpath)
  node = item.at_xpath(node_xpath)

  if !node
    warn "Missing node with path '#{node_xpath}' into the following item: #{item}"
    return ''
  end

  return node.text
end