return {
    data = {
        animations = {
            {
                animation_id = "on_hover",
                animation_keys = {
                    {
                        duration = 0.1,
                        easing = "outsine",
                        end_value = 0.65,
                        key_type = "tween",
                        node_id = "background",
                        property_id = "color_r",
                        start_value = 1,
                    },
                    {
                        duration = 0.1,
                        easing = "outsine",
                        end_value = 0.85,
                        key_type = "tween",
                        node_id = "background",
                        property_id = "color_g",
                        start_value = 1,
                    },
                },
                duration = 0.1,
            },
            {
                animation_id = "off_hover",
                animation_keys = {
                    {
                        duration = 0.1,
                        easing = "outsine",
                        end_value = 1,
                        key_type = "tween",
                        node_id = "background",
                        property_id = "color_g",
                        start_value = 0.85,
                    },
                    {
                        duration = 0.1,
                        easing = "outsine",
                        end_value = 1,
                        key_type = "tween",
                        node_id = "background",
                        property_id = "color_r",
                        start_value = 0.65,
                    },
                },
                duration = 0.1,
                initial_state = "on_hover",
            },
            {
                animation_id = "on_select",
                animation_keys = {
                    {
                        duration = 0.2,
                        easing = "outsine",
                        end_value = 0.35,
                        key_type = "tween",
                        node_id = "background",
                        property_id = "color_r",
                        start_value = 0.65,
                    },
                    {
                        duration = 0.2,
                        easing = "outsine",
                        end_value = 0.73,
                        key_type = "tween",
                        node_id = "background",
                        property_id = "color_g",
                        start_value = 0.85,
                    },
                },
                duration = 0.2,
                initial_state = "on_hover",
            },
            {
                animation_id = "off_select",
                animation_keys = {
                    {
                        duration = 0.2,
                        easing = "outsine",
                        end_value = 1,
                        key_type = "tween",
                        node_id = "background",
                        property_id = "color_g",
                        start_value = 0.73,
                    },
                    {
                        duration = 0.2,
                        easing = "outsine",
                        end_value = 1,
                        key_type = "tween",
                        node_id = "background",
                        property_id = "color_r",
                        start_value = 0.35,
                    },
                },
                duration = 0.2,
                initial_state = "on_select",
            },
        },
        metadata = {
            fps = 60,
            gizmo_steps = {
            },
            gui_path = "gui/widgets/buttons/text_button_radio/text_button_radio.gui",
            layers = {
            },
            settings = {
                font_size = 40,
            },
            template_animation_paths = {
            },
        },
        nodes = {
        },
    },
    format = "json",
    type = "animation_editor",
    version = 1,
}