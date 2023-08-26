#ifndef IMTURBO_SCROLLING_PLOT_BUFFER_HPP
#define IMTURBO_SCROLLING_PLOT_BUFFER_HPP

#include <cmath>
#include <string>

#include <imgui.h>
#include <implot.h>

namespace ImTurbo {

// utility structure for realtime plot
class ScrollingPlotBuffer {
private:
    std::string _name;
    int _offset;
    ImVector<ImVec2> _data;

public:
    ScrollingPlotBuffer(std::string name, int max_size = 2000)
        : _name(name), _offset(0) {
        _data.resize(max_size, ImVec2{0, 0});
    }
    void add(ImVec2 p) {
        _data[_offset++] = p;
        if(_offset == _data.size()) _offset = 0;
    }
    void add(float x, float y) { add(ImVec2{x, y}); }

    void PlotShaded() {
        ImPlot::PlotShaded(_name.c_str(), &_data[0].x, &_data[0].y,
                           _data.size(), -INFINITY, 0, _offset, sizeof(ImVec2));
    }
    void PlotLine() {
        ImPlot::PlotLine(_name.c_str(), &_data[0].x, &_data[0].y, _data.size(),
                         0, _offset, sizeof(ImVec2));
    }
};

}  // namespace ImTurbo

#endif  // IMTURBO_SCROLLING_PLOT_BUFFER_HPP