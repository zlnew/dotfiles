package main

import (
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"

	"gopkg.in/yaml.v3"
)

type PaletteFile struct {
	Palette map[string]string `yaml:"palette"`
}

type SemanticFile struct {
	Semantic map[string]any `yaml:"semantic"`
}

func must(err error) {
	if err != nil {
		panic(err)
	}
}

func readYAML[T any](path string, out *T) {
	b, err := os.ReadFile(path)
	must(err)
	must(yaml.Unmarshal(b, out))
}

func resolve(node any, palette map[string]string, path string) any {
	switch v := node.(type) {
	case map[string]any:
		out := map[string]any{}
		for k, val := range v {
			out[k] = resolve(val, palette, path+"."+k)
		}
		return out
	case string:
		hex, ok := palette[v]
		if !ok {
			panic(fmt.Sprintf("unknown palette key '%s' at %s", v, path))
		}
		return hex
	default:
		panic("invalid semantic value at " + path)
	}
}

func write(path, content string) {
	must(os.MkdirAll(filepath.Dir(path), 0o755))
	must(os.WriteFile(path, []byte(strings.TrimSpace(content)+"\n"), 0o644))
}

/* =========================
   GENERATORS
   ========================= */

func genNvim(c map[string]any) {
	n := c["nvim"].(map[string]any)
	bg := n["background"].(map[string]any)
	fg := n["foreground"].(map[string]any)
	t := n["text"].(map[string]any)
	s := n["state"].(map[string]any)
	a := n["accent"].(map[string]any)

	write(
		os.ExpandEnv("../.config/nvim/lua/config/colors.lua"),
		fmt.Sprintf(`
local colors = {
  bg_primary       = "%s",
  bg_secondary     = "%s",
  bg_tertiary      = "%s",

  fg_primary       = "%s",
  fg_secondary     = "%s",

  text_muted       = "%s",
  text_faint       = "%s",

  error            = "%s",
  warning          = "%s",
  info             = "%s",
  hint             = "%s",

  accent_primary   = "%s",
  accent_secondary = "%s",
  accent_tertiary  = "%s",
}

return colors
`,
			bg["primary"],
			bg["secondary"],
			bg["tertiary"],

			fg["primary"],
			fg["secondary"],

			t["muted"],
			t["faint"],

			s["error"],
			s["warning"],
			s["info"],
			s["hint"],

			a["primary"],
			a["secondary"],
			a["tertiary"],
		),
	)
}

func genAlacritty(c map[string]any) {
	bg := c["background"].(map[string]any)
	fg := c["foreground"].(map[string]any)
	s := c["syntax"].(map[string]any)

	write(
		os.ExpandEnv("../.config/alacritty/colors.toml"),
		fmt.Sprintf(`
[colors.primary]
background = "%s"
foreground = "%s"

[colors.normal]
black   = "%s"
red     = "%s"
green   = "%s"
yellow  = "%s"
blue    = "%s"
magenta = "%s"
cyan    = "%s"
white   = "%s"

[colors.bright]
black   = "%s"
red     = "%s"
green   = "%s"
yellow  = "%s"
blue    = "%s"
magenta = "%s"
cyan    = "%s"
white   = "%s"
`,
			// primary
			bg["primary"],
			fg["primary"],

			// normal
			bg["secondary"],
			s["keyword"],
			s["string"],
			s["type"],
			s["function"],
			s["constant"],
			c["diagnostic"].(map[string]any)["hint"],
			fg["primary"],

			// bright
			bg["secondary"],
			s["keyword"],
			s["string"],
			s["type"],
			s["function"],
			s["constant"],
			c["diagnostic"].(map[string]any)["hint"],
			fg["primary"],
		),
	)
}

func genFish(c map[string]any) {
	bg := c["background"].(map[string]any)
	fg := c["foreground"].(map[string]any)
	s := c["syntax"].(map[string]any)
	d := c["diagnostic"].(map[string]any)

	write(
		os.ExpandEnv("../.config/fish/conf.d/colors.fish"),
		fmt.Sprintf(`
# =========================
# Pure prompt colors
# =========================
set -U pure_color_primary '%s'
set -U pure_color_success '%s'
set -U pure_color_warning '%s'
set -U pure_color_danger '%s'

set -U pure_color_prompt_on_success '%s'
set -U pure_color_prompt_on_error '%s'

set -U pure_color_current_directory '%s'

set -U pure_color_git_branch '%s'
set -U pure_color_git_dirty '%s'
set -U pure_color_git_unpulled_commits '%s'
set -U pure_color_git_unpushed_commits '%s'
set -U pure_color_git_stash '%s'

set -U pure_color_virtualenv '%s'

set -U pure_color_dark '%s'
set -U pure_color_info '%s'
set -U pure_color_mute '%s'
set -U pure_color_light '%s'
set -U pure_color_normal '%s'

set -U pure_color_at_sign '%s'
set -U pure_color_hostname '%s'
set -U pure_color_username_normal '%s'
set -U pure_color_username_root '%s'


# =========================
# Fish syntax highlighting
# =========================
set -U fish_color_normal '%s'
set -U fish_color_command '%s'
set -U fish_color_param '%s'
set -U fish_color_quote '%s'
set -U fish_color_redirection '%s'
set -U fish_color_end '%s'
set -U fish_color_error '%s'
set -U fish_color_operator '%s'
set -U fish_color_comment '%s'
set -U fish_color_autosuggestion '%s'

set -U fish_color_selection '--background=%s'
set -U fish_color_search_match '--background=%s'


# =========================
# Fish pager
# =========================
set -U fish_pager_color_prefix '%s'
set -U fish_pager_color_progress '%s'
set -U fish_pager_color_completion '%s'
set -U fish_pager_color_description '%s'
`,
			// ---- Pure prompt ----
			s["function"], // primary
			d["hint"],     // success
			d["warning"],  // warning
			d["error"],    // danger

			fg["primary"], // prompt success
			d["error"],    // prompt error

			s["function"], // cwd

			s["number"],   // git branch
			d["warning"],  // git dirty
			s["constant"], // git unpulled
			s["constant"], // git unpushed
			d["hint"],     // git stash

			d["hint"], // virtualenv

			bg["primary"],   // dark
			fg["secondary"], // info
			fg["muted"],     // mute
			fg["secondary"], // light
			fg["primary"],   // normal

			fg["muted"],     // @
			fg["muted"],     // hostname
			fg["secondary"], // username normal
			d["error"],      // username root

			// ---- Fish syntax ----
			fg["primary"], // normal
			s["function"], // command
			s["number"],   // param
			s["string"],   // quote
			s["constant"], // redirection
			d["hint"],     // end
			d["error"],    // error
			s["constant"], // operator
			s["comment"],  // comment
			fg["muted"],   // autosuggestion

			bg["elevated"],  // selection
			bg["secondary"], // search match

			// ---- Pager ----
			d["hint"],       // prefix
			d["warning"],    // progress
			fg["secondary"], // completion
			fg["muted"],     // description
		),
	)
}

func genFuzzel(c map[string]any) {
	bg := c["background"].(map[string]any)
	fg := c["foreground"].(map[string]any)
	s := c["syntax"].(map[string]any)
	d := c["diagnostic"].(map[string]any)

	write(
		os.ExpandEnv("../.config/fuzzel/fuzzel.ini"),
		fmt.Sprintf(`
[main]
font=monospace:size=11
use-bold=yes
dpi-aware=no
placeholder="..."
prompt="> "
icon-theme=Gruvbox-Material-Dark
icons-enabled=no
fields=name,generic,exec,categories,filename
terminal=alacritty
lines=10
width=40
horizontal-pad=10
vertical-pad=6
inner-pad=8
layer=overlay
exit-on-keyboard-focus-loss=yes

[border]
width=2
radius=8

[dmenu]
exit-immediately-if-empty=yes

[colors]
background=%sff
text=%sff
prompt=%sff
placeholder=%sff
input=%sff
match=%sff
selection=%sff
selection-text=%sff
selection-match=%sff
border=%sff
`,
			bg["primary"],
			fg["primary"],
			s["function"],
			bg["elevated"],
			fg["primary"],
			d["warning"],
			bg["elevated"],
			fg["secondary"],
			d["warning"],
			d["hint"],
		),
	)
}

func genMako(c map[string]any) {
	bg := c["background"].(map[string]any)
	fg := c["foreground"].(map[string]any)
	d := c["diagnostic"].(map[string]any)

	write(
		os.ExpandEnv("../.config/mako/config"),
		fmt.Sprintf(`
max-visible=10
layer=top
max-icon-size=48
default-timeout=10000

font=monospace 10
anchor=bottom-right
margin=8
outer-margin=8
padding=8
width=300
height=300
border-size=2
border-radius=8

[urgency=low]
background-color=%s
text-color=%s
border-color=%s
progress-color=%s

[urgency=normal]
background-color=%s
text-color=%s
border-color=%s
progress-color=%s

[urgency=critical]
background-color=%s
text-color=#000000
border-color=%s
progress-color=%s
`,
			// low
			bg["secondary"],
			fg["secondary"],
			d["info"],
			bg["secondary"],

			// normal
			bg["primary"],
			fg["primary"],
			d["hint"],
			bg["secondary"],

			// critical
			d["error"],
			d["error"],
			bg["secondary"],
		),
	)
}

func genWaybar(c map[string]any) {
	bg := c["background"].(map[string]any)
	fg := c["foreground"].(map[string]any)
	s := c["syntax"].(map[string]any)

	write(
		os.ExpandEnv("../.config/waybar/colors.css"),
		fmt.Sprintf(`
@define-color bg-primary %s;
@define-color bg-secondary %s;

@define-color fg-primary %s;
@define-color fg-muted %s;

@define-color accent-blue %s;
@define-color accent-red %s;
@define-color accent-green %s;
@define-color accent-yellow %s;
@define-color accent-purple %s;
`,
			bg["primary"],
			bg["secondary"],

			fg["primary"],
			fg["muted"],

			s["function"],
			s["keyword"],
			s["string"],
			s["type"],
			s["constant"],
		),
	)
}

/* =========================
   MAIN
   ========================= */

func main() {
	dir := os.ExpandEnv("./")

	var palette PaletteFile
	var semantic SemanticFile

	readYAML(filepath.Join(dir, "palette.yaml"), &palette)
	readYAML(filepath.Join(dir, "semantic.yaml"), &semantic)

	resolved := resolve(semantic.Semantic, palette.Palette, "semantic").(map[string]any)

	// Optional: dump resolved.json (debugging / inspection)
	b, _ := json.MarshalIndent(resolved, "", "  ")
	_ = os.WriteFile(filepath.Join(dir, "resolved.json"), b, 0o644)

	genNvim(resolved)
	genAlacritty(resolved)
	genFish(resolved)
	genFuzzel(resolved)
	genMako(resolved)
	genWaybar(resolved)

	// Reload
	exec.Command("makoctl", "reload").Run()
	exec.Command("pkill", "waybar").Run()
	exec.Command("waybar").Start()

	fmt.Println("✔ colors generated & applied")
}
