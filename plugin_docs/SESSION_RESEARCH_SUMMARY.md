# Session Plugin Research - Executive Summary

## Quick Answer

**Recommended: resession.nvim** 🏆

**Why:** It's the ONLY plugin with:
- ✅ Native project-root storage (exactly what you need)
- ✅ Built-in scope.nvim extension (perfect for your setup)
- ✅ Works with bufferline.nvim

## Key Findings

### Your Requirements vs Plugins

| Requirement | resession.nvim | auto-session | persistence.nvim (folke) |
|-------------|----------------|-------------|--------------------------|
| Project root storage | ✅ Native | ⚠️ Configurable | ❌ Requires workaround |
| Scope.nvim support | ✅ Built-in extension | ❌ No | ❌ No |
| Bufferline compatible | ✅ Yes | ✅ Yes | ✅ Yes |
| By folke | ❌ No | ❌ No | ✅ Yes |
| Snacks picker | ❌ No | ✅ Yes | ❌ No |

### Top 3 Candidates

1. **resession.nvim** (292 stars)
   - Best fit for your requirements
   - Native project-root + scope.nvim support
   - Trade-off: Not by folke, no Snacks picker

2. **auto-session** (1,752 stars)
   - Most popular, Snacks picker support
   - Trade-off: No scope.nvim support, requires config for project-root

3. **persistence.nvim** (935 stars)
   - By folke (you like his plugins)
   - Trade-off: Not designed for project-root, no scope.nvim

## Detailed Research

See `SESSION_PLUGINS_RESEARCH.md` for comprehensive analysis.

## Documentation Saved

- ✅ `resession.nvim.md` - Full README
- ✅ `auto-session.md` - Full README  
- ✅ `persistence.nvim.md` - Full README
- ✅ `SESSION_PLUGINS_RESEARCH.md` - Complete comparison

## Next Steps

1. Review `SESSION_PLUGINS_RESEARCH.md` for detailed analysis
2. Check plugin READMEs in `plugin_docs/`
3. Decide based on:
   - How important is scope.nvim integration?
   - How important is folke's authorship?
   - How important is Snacks picker?

## Recommendation

**Choose resession.nvim** because:
- It's the only one that natively supports project-root storage
- It's the only one with built-in scope.nvim extension
- Your requirements are very specific, and it matches them perfectly

The fact that it's not by folke is a trade-off, but stevearc is also a respected Neovim plugin developer.

---

*Research completed with deep analysis of 5 major session plugins*
