#ifndef IMTURBO_CONTROLLER_GUI_HPP
#define IMTURBO_CONTROLLER_GUI_HPP

#include <atomic>
#include <cmath>
#include <string>

#include <imgui.h>
// #include <implot.h> pragma once fails

#include "imgui_toggle/imgui_toggle.h"
#include "imgui_toggle/imgui_toggle_presets.h"

#include "utils/app_log.hpp"
#include "utils/scrolling_plot_buffer.hpp"

#include "components/arduino.hpp"
#include "components/odrive.hpp"
#include "components/oil_pump.hpp"

namespace ImTurbo {

class ControllerGUI {
private:
    ScrollingPlotBuffer oil_pressure_data;
    ScrollingPlotBuffer boost_pressure_data;
    ScrollingPlotBuffer turbine_inlet_temperature_data;
    ScrollingPlotBuffer oil_pump_speed_data;
    ScrollingPlotBuffer gas_valve_position_data;
    ScrollingPlotBuffer spark_plug_state_data;
    float history = 30.0;
    AppLog app_log;

    std::atomic<float> voltage = 0.0f;

    Odrive odrive;
    Arduino arduino;
    OilPump oil_pump;

public:
    ControllerGUI()
        : oil_pressure_data("Oil pressure")
        , boost_pressure_data("Boost pressure")
        , turbine_inlet_temperature_data("Turbine inlet temp.")
        , oil_pump_speed_data("Oil pump speed")
        , gas_valve_position_data("Gas valve pos.")
        , spark_plug_state_data("Spark plug state")
        , odrive(app_log)
        , arduino("/dev/ttyUSB0", app_log)
        , oil_pump(app_log, odrive) {}

    void show_settings() {
        ImGui::SliderFloat("Scrolling plot history", &history, 1, 30, "%.1f s");
    }

    void show(ImVec2 pos, ImVec2 size) {
        odrive.send_command(
            "v", [this](const std::string & s) { voltage = std::stof(s); });

        static float t = 0;
        t += ImGui::GetIO().DeltaTime;

        ImVec2 mouse = ImGui::GetMousePos();
        oil_pressure_data.add(t, mouse.x * 0.002f);
        boost_pressure_data.add(t, mouse.y * 0.002f);
        turbine_inlet_temperature_data.add(t, (mouse.x + mouse.y) * 0.50f);
        // oil_pump_speed_data.add(t, mouse.x * 0.006f);
        gas_valve_position_data.add(t, mouse.y * 0.0005f);
        spark_plug_state_data.add(t, mouse.x < mouse.y);

        // oil_pressure_data.add(t, oil_pressure_sensor.get_pressure());
        // boost_pressure_data.add(t, boost_pressure_sensor.get_pressure());
        // turbine_inlet_temperature_data.add(t, tit_sensor.get_temperature());
        oil_pump_speed_data.add(t, oil_pump.get_speed());
        // gas_valve_position_data.add(t, mouse.y * 0.0005f);
        // spark_plug_state_data.add(t, mouse.x < mouse.y);

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
            ImPlot::SetupAxisLimits(ImAxis_Y1, 0, 4);

            ImPlot::SetupAxis(ImAxis_Y2, "temperature (°C)");
            ImPlot::SetupAxisLimits(ImAxis_Y2, 0, 1200);
            static double tit_ticks[]{0, 300, 600, 900, 1200};
            ImPlot::SetupAxisTicks(ImAxis_Y2, tit_ticks, 5);

            ImPlot::SetAxis(ImAxis_Y1);
            ImPlot::SetNextFillStyle(ImVec4{0.33f, 0.66f, 1.0f, 0.5f});
            boost_pressure_data.PlotShaded();
            ImPlot::SetNextLineStyle(ImVec4{1.0f, 1.0f, 0.25f, 1.0f}, 3.0f);
            oil_pressure_data.PlotLine();

            ImPlot::SetAxis(ImAxis_Y2);
            ImPlot::SetNextLineStyle(ImVec4{1.0f, 0.0f, 0.0f, 1.0f}, 3.0f);
            turbine_inlet_temperature_data.PlotLine();

            ImDrawList * draw_list = ImPlot::GetPlotDrawList();
            draw_list->AddLine(
                ImPlot::PlotToPixels(t - history, 900.0f, IMPLOT_AUTO,
                                     ImAxis_Y2),
                ImPlot::PlotToPixels(t, 900.0f, IMPLOT_AUTO, ImAxis_Y2),
                ImGui::GetColorU32(ImVec4{1.0f, 0.0f, 0.0f, 0.25f}), 3.0f);
            draw_list->AddLine(
                ImPlot::PlotToPixels(t - history, 2.0f, IMPLOT_AUTO, ImAxis_Y1),
                ImPlot::PlotToPixels(t, 2.0f, IMPLOT_AUTO, ImAxis_Y1),
                ImGui::GetColorU32(ImVec4{0.33f, 0.66f, 1.0f, 0.25f}), 3.0f);

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
        if(ImGui::Toggle("##toggle_oil_pump", &b, config)) {
            arduino.send_command("hello!", [this](const std::string & s) {
                app_log.AddLog("[Arduino] '%s'\n", s.c_str());
            });
        }
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
            ImPlot::SetNextLineStyle(ImVec4{0.5f, 1.0f, 0.5f, 1.0f}, 3.0f);
            oil_pump_speed_data.PlotLine();

            ImPlot::SetAxis(ImAxis_Y2);
            ImPlot::SetNextFillStyle(ImVec4{0.5f, 1.0f, 1.0f, 0.5f});
            spark_plug_state_data.PlotShaded();
            ImPlot::SetNextLineStyle(ImVec4{0.75f, 0.33f, 0.33f, 1.0f}, 3.0f);
            gas_valve_position_data.PlotLine();

            ImPlot::EndPlot();
        }

        app_log.Draw();

        ImGui::End();
    }
};

}  // namespace ImTurbo

#endif  // IMTURBO_CONTROLLER_GUI_HPP