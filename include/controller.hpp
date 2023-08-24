#ifndef IMTURBO_CONTROLLER_HPP
#define IMTURBO_CONTROLLER_HPP

#include <math.h>

#include <imgui.h>
#include <implot.h>
#include <wiringPi.h>

#include "utils/imvec_operators.hpp"

namespace ImTurbo {
// utility structure for realtime plot

class ScrollingBuffer {
private:
    std::string _name;
    int _offset;
    ImVector<ImVec2> _data;

public:
    ScrollingBuffer(std::string name, int max_size = 2000)
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

class Controller {
private:
    ScrollingBuffer oil_pressure_data;
    ScrollingBuffer boost_pressure_data;
    float history = 30.0;

public:
    Controller() : oil_pressure_data("Oil"), boost_pressure_data("Boost") {}

    void init() {}
    void show_settings() {
        ImGui::SliderFloat("Scrolling plot history", &history, 1, 30, "%.1f s");
    }

    void show(ImVec2 pos, ImVec2 size) {
        static float t = 0;
        t += ImGui::GetIO().DeltaTime;

        ImVec2 mouse = ImGui::GetMousePos();
        oil_pressure_data.add(t, mouse.x * 0.002f);
        boost_pressure_data.add(t, mouse.y * 0.002f);

        static ImPlotAxisFlags xflags =
            ImPlotAxisFlags_Opposite | ImPlotAxisFlags_NoSideSwitch | ImPlotAxisFlags_NoTickLabels;
        static ImPlotAxisFlags yflags = ImPlotAxisFlags_Opposite |
                                        ImPlotAxisFlags_NoSideSwitch |
                                        ImPlotAxisFlags_LockMin;

        ImGui::SetNextWindowPos(pos);
        ImGui::SetNextWindowSize(size);
        ImGui::Begin("Sensors", nullptr,
                     ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoCollapse);

        if(ImPlot::BeginPlot("##Scrolling", ImVec2(-1, 150))) {
            ImPlot::SetupAxes("time (s)", "pressure (bar)", xflags, yflags);
            ImPlot::SetupAxisLimits(ImAxis_X1, t - history, t,
                                    ImGuiCond_Always);
            ImPlot::SetupAxisLimits(ImAxis_Y1, 0, 5);
            ImPlot::SetNextFillStyle(IMPLOT_AUTO_COL, 0.5f);
            boost_pressure_data.PlotShaded();
            oil_pressure_data.PlotLine();
            ImPlot::EndPlot();
        }

        ImGui::End();
    }
};

}  // namespace ImTurbo

#endif  // IMTURBO_CONTROLLER_HPP