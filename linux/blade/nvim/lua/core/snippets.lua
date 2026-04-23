local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node

-- Helper: wrap an insert node to use visual selection if present
local function vs(i_index, default)
    return d(i_index, function(_, parent)
        return sn(nil, i(1, parent.snippet.env.SELECT_RAW or default or ""))
    end, {})
end

ls.add_snippets("go", {
    -- sub test function
    s("trun", {
        t('t.Run("'), i(1), t('", func(t *testing.T) {'), t({"", "\t"}),
        vs(2),
        t({"", "})"}),
    }),

    -- sub benchmark function
    s("brun", {
        t('b.Run("'), i(1), t('", func(b *testing.B) {'), t({"", "\t"}),
        vs(2),
        t({"", "})"}),
    }),

    -- fuzz function
    s("fuzz", {
        t("func Fuzz"), i(1, "Function"), t("(f *testing.F) {"),
        t({"", "\tf.Fuzz(func(t *testing.T, "}), i(2, "args"), t(") {"),
        t({"", "\t\t"}), vs(0),
        t({"", "\t})", "}"}),
    }),
})
