#ifndef IMTURBO_CONTROLLER_GUI_HPP
#define IMTURBO_CONTROLLER_GUI_HPP

#include <string.h>
#include <cmath>

#include <imgui.h>
#include <implot.h>
#include <wiringPi.h>

#include "imgui_toggle/imgui_toggle.h"
#include "imgui_toggle/imgui_toggle_presets.h"

#include "utils/app_log.hpp"
#include "utils/imvec_operators.hpp"
#include "utils/scrolling_plot_buffer.hpp"

#include "oil_pump_controller.hpp"

namespace ImTurbo {

class ControllerGUI {
private:
    ScrollingPlotBuffer oil_pressure_data;
    ScrollingPlotBuffer boost_pressure_data;
    ScrollingPlotBuffer turbine_inlet_temperature_data;
    ScrollingPlotBuffer oil_pump_speed_data;
    ScrollingPlotBuffer gas_valve_position_data;
    float history = 30.0;
    AppLog app_log;

    OilPumpController oil_pump_controller;

public:
    ControllerGUI()
        : oil_pressure_data("Oil pressure")
        , boost_pressure_data("Boost pressure")
        , turbine_inlet_temperature_data("Turbine inlet temp.")
        , oil_pump_speed_data("Oil pump speed")
        , gas_valve_position_data("Gas valve pos.")
        , oil_pump_controller(app_log) {}

    void show_settings() {
        ImGui::SliderFloat("Scrolling plot history", &history, 1, 30, "%.1f s");
    }

    void show(ImVec2 pos, ImVec2 size) {

oil_pump_controller.log();

        static float t = 0;
        t += ImGui::GetIO().DeltaTime;

        ImVec2 mouse = ImGui::GetMousePos();
        oil_pressure_data.add(t, mouse.x * 0.002f);
        boost_pressure_data.add(t, mouse.y * 0.002f);
        turbine_inlet_temperature_data.add(t, (mouse.x + mouse.y) * 0.50f);
        oil_pump_speed_data.add(t, mouse.x * 0.006f);
        gas_valve_position_data.add(t, mouse.y * 0.0005f);

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

        if(ImPlot::BeginPlot("##sensors_plot", ImVec2(-1, 160),
                             ImPlotFlags_NoFrame | ImPlotFlags_NoInputs)) {
            ImPlot::SetupAxes("time (s)", "pressure (bar)", xflags, yflags);
            ImPlot::SetupAxisLimits(ImAxis_X1, t - history, t,
                                    ImGuiCond_Always);
            ImPlot::SetupAxisLimits(ImAxis_Y1, 0, 3.5);

            ImPlot::SetupAxis(ImAxis_Y2, "temperature (°C)");
            ImPlot::SetupAxisLimits(ImAxis_Y2, 0, 1400);

            ImPlot::SetAxis(ImAxis_Y1);
            ImPlot::SetNextFillStyle(ImVec4{0.33f, 0.66f, 1.0f, 0.5f});
            boost_pressure_data.PlotShaded();
            ImPlot::SetNextLineStyle(ImVec4{1.0f, 1.0f, 0.25f, 0.75f}, 2.50f);
            oil_pressure_data.PlotLine();

            ImPlot::SetAxis(ImAxis_Y2);
            ImPlot::SetNextLineStyle(ImVec4{1.0f, 0.0f, 0.0f, 0.75f}, 2.50f);
            turbine_inlet_temperature_data.PlotLine();

            ImDrawList * draw_list = ImPlot::GetPlotDrawList();
            draw_list->AddLine(
                ImPlot::PlotToPixels(t - history, 1000.0f, IMPLOT_AUTO,
                                     ImAxis_Y2),
                ImPlot::PlotToPixels(t, 1000.0f, IMPLOT_AUTO, ImAxis_Y2),
                ImGui::GetColorU32(ImVec4{1.0f, 0.0f, 0.0f, 0.25f}), 2.0f);
            draw_list->AddLine(
                ImPlot::PlotToPixels(t - history, 2.0f, IMPLOT_AUTO, ImAxis_Y1),
                ImPlot::PlotToPixels(t, 2.0f, IMPLOT_AUTO, ImAxis_Y1),
                ImGui::GetColorU32(ImVec4{0.33f, 0.66f, 1.0f, 0.25f}), 2.0f);

            ImPlot::EndPlot();
        }
        // static ImGuiToggleConfig config =
        // ImGuiTogglePresets::MaterialStyle(3.0f);
        static ImGuiToggleConfig config = ImGuiTogglePresets::iOSStyle(0.9f);
        static bool b;
        ImGui::SetCursorPos(ImVec2{20.0f, 207.0f});

        ImFont * headerFont = ImGui::GetIO().Fonts->Fonts[1];
        ImGui::PushFont(headerFont);
        ImGui::LabelText("##start_label", "Start Engine:");
        ImGui::PopFont();

        ImGui::SetCursorPos(
            ImVec2{200.0f, 170.0f + 120.0F / 2 - config.Size.y / 2});
        if(ImGui::Toggle("##toggle_oil_pump", &b, config))
            ;
        ImGui::SetCursorPos(ImVec2{size.x / 2 - config.Size.x + 80, 170.0F});
        if(ImPlot::BeginPlot("##actuators_plot", ImVec2(-1, 120),
                             ImPlotFlags_NoFrame | ImPlotFlags_NoInputs)) {
            ImPlot::SetupAxes("time (s)", "speed (rev/s)", xflags, yflags);
            ImPlot::SetupAxisLimits(ImAxis_X1, t - history / 1.95f, t,
                                    ImGuiCond_Always);
            ImPlot::SetupAxisLimits(ImAxis_Y1, 0, 20);

            ImPlot::SetupAxis(ImAxis_Y2, "position (revs)");
            ImPlot::SetupAxisLimits(ImAxis_Y2, 0, 1);

            ImPlot::SetAxis(ImAxis_Y1);
            ImPlot::SetNextLineStyle(ImVec4{0.5f, 1.0f, 0.5f, 0.75f}, 2.50f);
            oil_pump_speed_data.PlotLine();

            ImPlot::SetAxis(ImAxis_Y2);
            ImPlot::SetNextLineStyle(ImVec4{0.75f, 0.25f, 0.25f, 0.75f}, 2.50f);
            gas_valve_position_data.PlotLine();

            ImPlot::EndPlot();
        }

        app_log.Draw();

        ImGui::End();
    }
};

}  // namespace ImTurbo

#endif  // IMTURBO_CONTROLLER_GUI_HPP