#ifndef IMTURBO_FFPROBE_HELPER_HPP
#define IMTURBO_FFPROBE_HELPER_HPP

#include <filesystem>

#include "boost/process.hpp"
namespace bp = boost::process;

#include "nlohmann/json.hpp"

namespace ImTurbo {

nlohmann::json ffprobe(const std::filesystem::path & file_path) {
    nlohmann::json json;
    bp::ipstream out;

    bp::child c(
        "ffprobe -show_format -show_streams -print_format json "
        "-loglevel quiet \"" +
            file_path.string() + "\"",
        bp::std_out > out);

    out >> json;
    c.terminate();
    return json;
}

}  // namespace ImTurbo

#endif  // IMTURBO_FFPROBE_HELPER_HPP
