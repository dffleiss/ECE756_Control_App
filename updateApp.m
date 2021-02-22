function updateApp(varargin)
    all_tag_objects = findall(0, '-property', 'tag');
    all_tags = get(all_tag_objects, 'tag');
    % These correspond to the output names from Simulink
    variable_names = ["Vehicle1_X",
                      "Vehicle1_Y",
                      "Vehicle1_TH",
                      "Vehicle1_LeftRLI",
                      "Vehicle1_RightRLI",
                      "Vehicle1_Ultrasound",
                      "Vehicle1_Battery",
                      "Vehicle1_C1",
                      "Vehicle1_C2",
                      "Vehicle1_C3",
                      "Vehicle2_X",
                      "Vehicle2_Y",
                      "Vehicle2_TH",
                      "Vehicle2_LeftRLI",
                      "Vehicle2_RightRLI",
                      "Vehicle2_Ultrasound",
                      "Vehicle2_Battery",
                      "Vehicle2_C1",
                      "Vehicle2_C2",
                      "Vehicle2_C3",
                      "Vehicle3_X",
                      "Vehicle3_Y",
                      "Vehicle3_TH",
                      "Vehicle3_LeftRLI",
                      "Vehicle3_RightRLI",
                      "Vehicle3_Ultrasound",
                      "Vehicle3_Battery",
                      "Vehicle3_C1",
                      "Vehicle3_C2",
                      "Vehicle3_C3"];

    %create run time objects that return position data from the simulation
    %values = zeros(length(variable_names), 1);
    for i = 1:length(variable_names)
        [tf, idx] = ismember(variable_names(i), all_tags);
        st = all_tag_objects(idx);
        str = 'full_sim/' + variable_names(i);
        param = get_param(str, 'RuntimeObject');
        value = param.InputPort(1).Data;
        set(st, 'Value', value)
    end
end
