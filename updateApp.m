function updateApp(varargin)
    % No need to search for these every call
    %persistent all_tag_objects
    %persistent all_tags
    %persistent last_call_time
    %if isempty(all_tag_objects)
    %    %get a handle to the GUI's 'current state' window
    %    all_tag_objects = findall(0, '-property', 'tag');
    %    all_tags = get(all_tag_objects, 'tag');
    %    last_call_time = tic;
    %end
    
    %disp(toc(last_call_time))
    %last_call_time = tic;
    
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
                      "Vehicle1_C3"];

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
