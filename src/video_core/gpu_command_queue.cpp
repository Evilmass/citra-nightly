// Copyright 2026 Citra Emulator Project
// Licensed under GPLv2 or any later version
// Refer to the license.txt file included.

#include "core/frontend/emu_window.h"
#include "video_core/gpu.h"
#include "video_core/gpu_command_queue.h"

namespace VideoCore {

GPUCommandQueue::GPUCommandQueue(GPU& gpu_, std::unique_ptr<Frontend::GraphicsContext> context)
    : gpu(gpu_), graphics_context(std::move(context)),
      worker_thread([this] { ProcessCommands(); }) {}

GPUCommandQueue::~GPUCommandQueue() {
    {
        std::lock_guard lock(mutex);
        stop_requested = true;
    }
    command_cv.notify_one();

    if (worker_thread.joinable()) {
        worker_thread.join();
    }
}

void GPUCommandQueue::QueueCommand(const Service::GSP::Command& command) {
    {
        std::lock_guard lock(mutex);
        commands.push(command);
    }
    command_cv.notify_one();
}

void GPUCommandQueue::WaitForIdle() {
    std::unique_lock lock(mutex);
    idle_cv.wait(lock, [this] { return commands.empty() && !processing; });
}

bool GPUCommandQueue::IsProcessorThread() const {
    return std::this_thread::get_id() == worker_thread_id;
}

void GPUCommandQueue::ProcessCommands() {
    worker_thread_id = std::this_thread::get_id();
    const auto context_guard = graphics_context->Acquire();

    while (true) {
        Service::GSP::Command command{};
        {
            std::unique_lock lock(mutex);
            command_cv.wait(lock, [this] { return stop_requested || !commands.empty(); });
            if (stop_requested && commands.empty()) {
                break;
            }

            command = commands.front();
            commands.pop();
            processing = true;
        }

        gpu.ExecuteCommand(command);

        {
            std::lock_guard lock(mutex);
            processing = false;
            if (commands.empty()) {
                idle_cv.notify_all();
            }
        }
    }
}

} // namespace VideoCore
