#![allow(deprecated)]
use std::process::Command;
use std::sync::LazyLock;

const TAG_KEYS: [char; 11] = ['N', 'R', 'T', 'S', 'Q', 'M', 'W', 'L', 'D', 'C', 'G'];
const DIRECTIONS: [(&str, char); 4] = [("left", 'Y'), ("down", 'H'), ("up", 'A'), ("right", 'E')];
const HOME_DIR: LazyLock<String> =
    LazyLock::new(|| std::env::home_dir().unwrap().to_str().unwrap().to_string());

fn riverctl(cmd: &str) {
    exec(&format!("riverctl {}", cmd), false);
}

fn read_stylix() -> Vec<String> {
    std::fs::read_to_string(format!("{}/.config/river/silex-colors.txt", &*HOME_DIR))
        .expect("failed to read file: ~/.config/river/silex-colors.txt")
        .lines()
        .map(|l| l.split_whitespace().nth(1).unwrap().to_string())
        .collect()
}

fn exec(cmd: &str, disown: bool) {
    if disown {
        Command::new("bash")
            .arg("-c")
            .arg(&format!("nohup {cmd} > /dev/null &"))
            .spawn()
            .expect("failed to execute command");
    } else {
        let words = shell_words::split(cmd).expect(&format!("failed to parse cmd {cmd}"));
        let output = Command::new(&words[0])
            .args(words.iter().skip(1))
            .output()
            .expect(&format!("failed to exec cmd: {}", cmd));

        if !output.status.success() {
            eprintln!(
                "riverctl failed: {}",
                String::from_utf8_lossy(&output.stderr)
            );
        }
    }
}

fn main() {
    riverctl("keyboard-layout us");
    riverctl("default-layout wideriver");
    riverctl("focus-follows-cursor always");
    riverctl("hide-cursor timeout 10000");
    riverctl("hide-cursor when-typing enabled");
    riverctl("set-cursor-warp on-focus-change");
    let colors = read_stylix();
    riverctl(&format!("background-color 0x{}", colors[0]));

    riverctl("map normal Super Q close");
    riverctl("map normal Super V toggle-float");
    riverctl("map normal Super M toggle-fullscreen");

    riverctl("map normal None XF86MonBrightnessUp spawn 'brightnessctl set +10%'");
    riverctl("map normal None XF86MonBrightnessDown spawn 'brightnessctl set 10%-'");
    riverctl("map normal None XF86AudioMute spawn 'amixer set Master toggle'");
    riverctl(
        "map normal None XF86AudioRaiseVolume spawn 'amixer set Master 5%+ | amixer set Master on'",
    );
    riverctl(
        "map normal None XF86AudioLowerVolume spawn 'amixer set Master 5%- | amixer set Master on'",
    );

    riverctl("map normal Alt P spawn 'playerctl play-pause'");
    riverctl("map normal Super T spawn foot");
    riverctl("map normal Super B spawn librewolf");
    riverctl("map normal Super F spawn 'foot yazi'");
    riverctl("map normal Super+Shift E spawn wlogout");
    riverctl("map normal None Print spawn 'grim -g \"$(slurp)\" $HOME/media/screenshots/$(date +'%s_grim.png')'");
    // BEMENU_OPTS set by hm doesn't work with riverctl spawn
    riverctl(&format!(
        "map normal Super Return spawn \"bemenu-run \
        --tb '#{}' --nb '#{}' --fb '#{}' --hb '#{}' --sb '#{}' --scb '#{}' --hf '#{}' --sf '#{}' --tf '#{}' --ff '#{}' --nf '#{}' --scf '#{}' --ab '#{}' --af '#{}' \
        --fn 'JetBrainsMono NFM Thin 7' \
        -i -w -l 15 -p 'open'\"",
        colors[1],
        colors[1],
        colors[1],
        colors[3],
        colors[3],
        colors[1],
        colors[10],
        colors[11],
        colors[5],
        colors[5],
        colors[5],
        colors[3],
        colors[1],
        colors[5]
    ));

    for (direction, key) in DIRECTIONS {
        riverctl(&format!("map normal Alt {key} focus-view {direction}"));
    }
    riverctl("map normal Super Y send-layout-cmd wideriver '--ratio -0.07'");
    riverctl("map normal Super E send-layout-cmd wideriver '--ratio +0.07'");
    riverctl("map normal Super H send-layout-cmd wideriver '--count -1'");
    riverctl("map normal Super A send-layout-cmd wideriver '--count +1'");
    riverctl("map normal Alt Return send-layout-cmd wideriver '--layout-toggle'");
    riverctl("map normal Alt Tab focus-previous-tags");
    riverctl("map normal Super Z zoom");
    riverctl(&format!("map normal Super P set-view-tags {}", u32::MAX));

    for i in 0..10 {
        riverctl(&format!(
            "map normal Alt {} toggle-focused-tags {}",
            TAG_KEYS[i],
            1_u32 << i
        ));
        riverctl(&format!(
            "map normal Alt+Control {} set-focused-tags {}",
            TAG_KEYS[i],
            1_u32 << i,
        ));
        riverctl(&format!(
            "map normal Super+Alt {} toggle-view-tags {}",
            TAG_KEYS[i],
            1_u32 << i
        ));
        riverctl(&format!(
            "map normal Super+Shift {} set-view-tags {}",
            TAG_KEYS[i],
            1_u32 << i
        ));
    }

    riverctl("map normal Alt Space focus-output next");
    riverctl("map normal Super Space send-to-output next");

    riverctl("rule-add ssd");
    riverctl("rule-add -app-id waybar csd");
    riverctl(&format!("rule-add -app-id discord tags {}", 1_u32 << 6));
    riverctl("input touch-1267-16773-ELAN9004:00_04F3:4185 map-to-output eDP-1");

    exec("discord", true);
}
