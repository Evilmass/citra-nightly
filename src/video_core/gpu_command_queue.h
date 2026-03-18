// Copyright 2026 Citra Emulator Project
// Licensed under GPLv2 or any later version
// Refer to the license.txt file included.

#pragma once

#include <condition_variable>
#include <memory>
#include <mutex>
#include <queue>
#include <thread>

#include "core/hle/service/gsp/gsp_command.h"

namespace Frontend {
class GraphicsContext;
}

namespace VideoCore {

class GPU;

class GPUCommandQueue {
public:
    GPUCommandQueue(GPU& gpu, std::unique_ptr<Frontend::GraphicsContext> context);
    ~GPUCommandQueue();

    void QueueCommand(const Service::GSP::Command& command);
    void WaitForIdle();

    [[nodiscard]] bool IsProcessorThread() const;

private:
    void ProcessCommands();

    GPU& gpu;
    std::unique_ptr<Frontend::GraphicsContext> graphics_context;
    mutable std::mutex mutex;
    std::condition_variable command_cv;
    std::condition_variable idle_cv;
    std::queue<Service::GSP::Command> commands;
    std::thread worker_thread;
    std::thread::id worker_thread_id;
    bool stop_requested = false;
    bool processing = false;
};

} // namespace VideoCore
