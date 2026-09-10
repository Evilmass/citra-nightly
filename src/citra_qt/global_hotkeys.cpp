// Copyright 2026 Citra Emulator Project
// Licensed under GPLv2 or any later version
// Refer to the license.txt file included.

#include "citra_qt/global_hotkeys.h"

#include <QKeySequence>
#include "common/logging/log.h"

#ifdef _WIN32
#include <windows.h>

namespace {
// Only one GlobalHotkeys instance exists per process.
GlobalHotkeys* g_instance = nullptr;
} // namespace
#endif

namespace {

#ifdef _WIN32

/// Maps a Qt key to its Windows virtual key code. Returns false for unsupported keys.
bool ConvertKeyToVirtualKey(Qt::Key key, uint& virtual_key) {
    // Letters and digits map directly onto their virtual key codes.
    if (key >= Qt::Key_A && key <= Qt::Key_Z) {
        virtual_key = 'A' + (key - Qt::Key_A);
        return true;
    }
    if (key >= Qt::Key_0 && key <= Qt::Key_9) {
        virtual_key = '0' + (key - Qt::Key_0);
        return true;
    }
    if (key >= Qt::Key_F1 && key <= Qt::Key_F24) {
        virtual_key = VK_F1 + (key - Qt::Key_F1);
        return true;
    }

    switch (key) {
    case Qt::Key_Space:
        virtual_key = VK_SPACE;
        return true;
    case Qt::Key_Escape:
        virtual_key = VK_ESCAPE;
        return true;
    case Qt::Key_Return:
    case Qt::Key_Enter:
        virtual_key = VK_RETURN;
        return true;
    case Qt::Key_Tab:
        virtual_key = VK_TAB;
        return true;
    case Qt::Key_Backspace:
        virtual_key = VK_BACK;
        return true;
    case Qt::Key_Insert:
        virtual_key = VK_INSERT;
        return true;
    case Qt::Key_Delete:
        virtual_key = VK_DELETE;
        return true;
    case Qt::Key_Home:
        virtual_key = VK_HOME;
        return true;
    case Qt::Key_End:
        virtual_key = VK_END;
        return true;
    case Qt::Key_PageUp:
        virtual_key = VK_PRIOR;
        return true;
    case Qt::Key_PageDown:
        virtual_key = VK_NEXT;
        return true;
    case Qt::Key_Left:
        virtual_key = VK_LEFT;
        return true;
    case Qt::Key_Right:
        virtual_key = VK_RIGHT;
        return true;
    case Qt::Key_Up:
        virtual_key = VK_UP;
        return true;
    case Qt::Key_Down:
        virtual_key = VK_DOWN;
        return true;
    case Qt::Key_Plus:
    case Qt::Key_Equal:
        virtual_key = VK_OEM_PLUS;
        return true;
    case Qt::Key_Minus:
        virtual_key = VK_OEM_MINUS;
        return true;
    case Qt::Key_Comma:
        virtual_key = VK_OEM_COMMA;
        return true;
    case Qt::Key_Period:
        virtual_key = VK_OEM_PERIOD;
        return true;
    case Qt::Key_Slash:
    case Qt::Key_Question:
        virtual_key = VK_OEM_2;
        return true;
    case Qt::Key_Semicolon:
    case Qt::Key_Colon:
        virtual_key = VK_OEM_1;
        return true;
    case Qt::Key_Apostrophe:
        virtual_key = VK_OEM_7;
        return true;
    case Qt::Key_QuoteLeft:
        virtual_key = VK_OEM_3;
        return true;
    case Qt::Key_BracketLeft:
        virtual_key = VK_OEM_4;
        return true;
    case Qt::Key_BracketRight:
        virtual_key = VK_OEM_6;
        return true;
    case Qt::Key_Backslash:
    case Qt::Key_Bar:
        virtual_key = VK_OEM_5;
        return true;
    default:
        return false;
    }
}

/// Reads the currently held-down modifier keys.
uint GetPressedModifiers() {
    uint mods = 0;
    if (GetAsyncKeyState(VK_SHIFT) & 0x8000) {
        mods |= MOD_SHIFT;
    }
    if (GetAsyncKeyState(VK_CONTROL) & 0x8000) {
        mods |= MOD_CONTROL;
    }
    if (GetAsyncKeyState(VK_MENU) & 0x8000) {
        mods |= MOD_ALT;
    }
    if (GetAsyncKeyState(VK_LWIN) & 0x8000) {
        mods |= MOD_WIN;
    }
    if (GetAsyncKeyState(VK_RWIN) & 0x8000) {
        mods |= MOD_WIN;
    }
    return mods;
}

#endif // _WIN32

} // namespace

GlobalHotkeys::GlobalHotkeys(QObject* parent) : QObject(parent) {
#ifdef _WIN32
    g_instance = this;
#else
    Q_UNUSED(parent);
#endif
}

GlobalHotkeys::~GlobalHotkeys() {
    UnregisterAll();
#ifdef _WIN32
    g_instance = nullptr;
#endif
}

bool GlobalHotkeys::Register(const QString& name, const QKeySequence& key_sequence) {
#ifdef _WIN32
    if (key_sequence.isEmpty()) {
        return false;
    }

    // Replace an existing registration under the same name, if any.
    Unregister(name);

    const QKeyCombination combination = key_sequence[0];
    const Qt::KeyboardModifiers modifiers = combination.keyboardModifiers();
    const Qt::Key key = combination.key();

    uint mods = 0;
    if (modifiers & Qt::ControlModifier) {
        mods |= MOD_CONTROL;
    }
    if (modifiers & Qt::AltModifier) {
        mods |= MOD_ALT;
    }
    if (modifiers & Qt::ShiftModifier) {
        mods |= MOD_SHIFT;
    }
    if (modifiers & Qt::MetaModifier) {
        mods |= MOD_WIN;
    }

    const int SupportedModifiers = Qt::ControlModifier | Qt::AltModifier | Qt::ShiftModifier |
                                   Qt::MetaModifier | Qt::KeypadModifier |
                                   Qt::GroupSwitchModifier;
    if (modifiers.toInt() & ~SupportedModifiers) {
        LOG_WARNING(Frontend, "Global hotkey '{}' uses unsupported modifiers",
                    name.toStdString());
        return false;
    }

    uint virtual_key = 0;
    if (!ConvertKeyToVirtualKey(key, virtual_key)) {
        LOG_WARNING(Frontend, "Global hotkey '{}' uses unsupported key '{}'",
                    name.toStdString(), QKeySequence(QKeyCombination(key)).toString().toStdString());
        return false;
    }

    // Install the hook before adding the entry so that hotkeys can fire immediately.
    if (!keyboard_hook) {
        InstallHook();
    }
    if (!keyboard_hook) {
        LOG_WARNING(Frontend, "Failed to install the keyboard hook for global hotkey '{}'",
                    name.toStdString());
        return false;
    }

    hotkeys[virtual_key].push_back({mods, name});
    return true;
#else
    Q_UNUSED(name);
    Q_UNUSED(key_sequence);
    return false;
#endif
}

void GlobalHotkeys::Unregister(const QString& name) {
#ifdef _WIN32
    for (auto it = hotkeys.begin(); it != hotkeys.end();) {
        auto& entries = it->second;
        entries.erase(std::remove_if(entries.begin(), entries.end(),
                                     [&name](const HotkeyEntry& entry) {
                                         return entry.name == name;
                                     }),
                      entries.end());
        if (entries.empty()) {
            it = hotkeys.erase(it);
        } else {
            ++it;
        }
    }
    if (hotkeys.empty()) {
        RemoveHook();
    }
#else
    Q_UNUSED(name);
#endif
}

void GlobalHotkeys::UnregisterAll() {
#ifdef _WIN32
    hotkeys.clear();
    held_keys.clear();
    RemoveHook();
#endif
}

#ifdef _WIN32

void GlobalHotkeys::InstallHook() {
    if (keyboard_hook) {
        return;
    }
    keyboard_hook = SetWindowsHookExW(WH_KEYBOARD_LL, KeyboardHookProc, GetModuleHandle(nullptr),
                                      0);
}

void GlobalHotkeys::RemoveHook() {
    if (keyboard_hook) {
        UnhookWindowsHookEx(keyboard_hook);
        keyboard_hook = nullptr;
    }
}

LRESULT CALLBACK GlobalHotkeys::KeyboardHookProc(int nCode, WPARAM wParam, LPARAM lParam) {
    if (nCode == HC_ACTION && g_instance) {
        const bool key_down = (wParam == WM_KEYDOWN || wParam == WM_SYSKEYDOWN);
        const bool key_up = (wParam == WM_KEYUP || wParam == WM_SYSKEYUP);
        if (key_down || key_up) {
            const KBDLLHOOKSTRUCT* kb = reinterpret_cast<const KBDLLHOOKSTRUCT*>(lParam);
            if (key_up) {
                g_instance->held_keys.erase(kb->vkCode);
            } else if (g_instance->held_keys.count(kb->vkCode) == 0) {
                const auto it = g_instance->hotkeys.find(kb->vkCode);
                if (it != g_instance->hotkeys.end()) {
                    const uint pressed_mods = GetPressedModifiers();
                    for (const auto& entry : it->second) {
                        if (entry.mods == pressed_mods) {
                            // Suppress auto-repeat until the key is released again.
                            g_instance->held_keys.insert(kb->vkCode);
                            // Defer the activation so that handler code doesn't run inside the
                            // hook callback (which would block keyboard processing).
                            const QString name = entry.name;
                            QMetaObject::invokeMethod(
                                g_instance,
                                [name] { emit g_instance->Activated(name); },
                                Qt::QueuedConnection);
                            break;
                        }
                    }
                }
            }
        }
    }

    // Never swallow the event: all running instances have their own hook and must see the key
    // press. The focused application therefore also receives the key.
    return CallNextHookEx(nullptr, nCode, wParam, lParam);
}

#endif // _WIN32
