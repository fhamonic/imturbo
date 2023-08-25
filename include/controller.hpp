#ifndef IMTURBO_CONTROLLER_HPP
#define IMTURBO_CONTROLLER_HPP

#include <math.h>
#include <string.h>

#include <iostream>

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
    ScrollingBuffer turbine_inlet_temperature_data;
    float history = 30.0;

public:
    Controller()
        : oil_pressure_data("Oil pressure")
        , boost_pressure_data("Boost pressure")
        , turbine_inlet_temperature_data("Turbine Inlet temp.") {}

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
        turbine_inlet_temperature_data.add(t, (mouse.x + mouse.y) * 0.50f / 400.0f);

        static ImPlotAxisFlags xflags =
            ImPlotAxisFlags_Opposite | ImPlotAxisFlags_NoSideSwitch |
            ImPlotAxisFlags_NoTickLabels | ImPlotAxisFlags_NoLabel;
        static ImPlotAxisFlags yflags = ImPlotAxisFlags_Opposite |
                                        ImPlotAxisFlags_NoSideSwitch |
                                        ImPlotAxisFlags_LockMin;
        ImGui::SetNextWindowPos(pos);
        ImGui::SetNextWindowSize(size);
        ImGui::Begin("Sensors", nullptr,
                     ImGuiWindowFlags_NoDecoration | ImGuiWindowFlags_NoResize |
                         ImGuiWindowFlags_NoCollapse);

        if(ImPlot::BeginPlot("##Scrolling", ImVec2(-1, 140),
                             ImPlotFlags_NoFrame | ImPlotFlags_NoInputs)) {
            ImPlot::SetupAxes("time (s)", "pressure (bar)", xflags, yflags);
            ImPlot::SetupAxisLimits(ImAxis_X1, t - history, t,
                                    ImGuiCond_Always);
            ImPlot::SetupAxisLimits(ImAxis_Y1, 0, 3);

            ImPlot::SetupAxis(ImAxis_Y2, "temperature (°C)");
            ImPlot::SetupAxisLimits(ImAxis_Y2, 0, 1200);

            ImPlot::SetNextFillStyle(ImVec4{0.33f,0.66f,1.0f,0.5f});
            boost_pressure_data.PlotShaded();
            ImPlot::SetNextLineStyle(ImVec4{1.0f,1.0f,0.25f,0.75f}, 2.0f);
            oil_pressure_data.PlotLine();
            ImPlot::SetNextLineStyle(ImVec4{1.0f, 0.0f, 0.0f,0.75f}, 2.0f);
            turbine_inlet_temperature_data.PlotLine();

            ImPlot::EndPlot();
        }

        ImGui::End();
    }
};

}  // namespace ImTurbo

#endif  // IMTURBO_CONTROLLER_HPP