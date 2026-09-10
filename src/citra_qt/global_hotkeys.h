// Copyright 2026 Citra Emulator Project
// Licensed under GPLv2 or any later version
// Refer to the license.txt file included.

#pragma once

#include <map>
#include <set>
#include <vector>
#include <QObject>
#include <QString>

#ifdef _WIN32
#include <windows.h>
#endif

class QKeySequence;

/**
 * Manages system-wide (global) hotkeys that trigger even when the application is not in the
 * foreground. On Windows this is backed by a low-level keyboard hook (WH_KEYBOARD_LL), which,
 * unlike RegisterHotKey, is not exclusive: several running instances of the application can all
 * react to the same hotkey. On other platforms registrations are currently not supported and
 * always fail; callers should fall back to regular in-window shortcuts in that case.
 */
class GlobalHotkeys final : public QObject {
    Q_OBJECT

public:
    explicit GlobalHotkeys(QObject* parent = nullptr);
    ~GlobalHotkeys() override;

    /**
     * Registers a system-wide hotkey under the given name.
     *
     * @returns true if the hotkey was successfully registered. Returns false if the platform
     *          doesn't support global hotkeys or the key sequence is unsupported.
     */
    bool Register(const QString& name, const QKeySequence& key_sequence);

    /// Unregisters the hotkey registered under the given name, if any.
    void Unregister(const QString& name);

    /// Unregisters all hotkeys.
    void UnregisterAll();

signals:
    /// Emitted when a registered global hotkey is pressed.
    void Activated(const QString& name);

private:
#ifdef _WIN32
    struct HotkeyEntry {
        uint mods;
        QString name;
    };

    void InstallHook();
    void RemoveHook();
    static LRESULT CALLBACK KeyboardHookProc(int nCode, WPARAM wParam, LPARAM lParam);

    // Primary virtual key code -> hotkeys registered for that key.
    std::map<uint, std::vector<HotkeyEntry>> hotkeys;
    // Virtual key codes currently held down, used to suppress key auto-repeat.
    std::set<uint> held_keys;
    HHOOK keyboard_hook = nullptr;
#endif
};
