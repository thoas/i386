format 66

classcanvas 128002 class_ref 128002 // User
  draw_all_relations default hide_attributes no hide_operations default show_members_full_definition default show_members_visibility default show_members_stereotype default show_members_multiplicity default show_members_initialization default show_attribute_modifiers default member_max_width 0 show_parameter_dir default show_parameter_name default package_name_in_tab default class_drawing_mode default drawing_language default show_context_mode default auto_label_position default show_relation_modifiers default show_infonote default shadow default show_stereotype_properties yes
  xyz 258 122 2000
end
classcanvas 128130 class_ref 128130 // Profile
  draw_all_relations default hide_attributes default hide_operations default show_members_full_definition default show_members_visibility default show_members_stereotype default show_members_multiplicity default show_members_initialization default show_attribute_modifiers default member_max_width 0 show_parameter_dir default show_parameter_name default package_name_in_tab default class_drawing_mode default drawing_language default show_context_mode default auto_label_position default show_relation_modifiers default show_infonote default shadow default show_stereotype_properties default
  xyz 34 223 2000
end
classcanvas 128258 class_ref 128258 // Chapter
  draw_all_relations default hide_attributes default hide_operations default show_members_full_definition default show_members_visibility default show_members_stereotype default show_members_multiplicity default show_members_initialization default show_attribute_modifiers default member_max_width 0 show_parameter_dir default show_parameter_name default package_name_in_tab default class_drawing_mode default drawing_language default show_context_mode default auto_label_position default show_relation_modifiers default show_infonote default shadow default show_stereotype_properties default
  xyz 433 570 2000
end
classcanvas 128386 class_ref 128386 // Case
  draw_all_relations default hide_attributes default hide_operations default show_members_full_definition default show_members_visibility default show_members_stereotype default show_members_multiplicity default show_members_initialization default show_attribute_modifiers default member_max_width 0 show_parameter_dir default show_parameter_name default package_name_in_tab default class_drawing_mode default drawing_language default show_context_mode default auto_label_position default show_relation_modifiers default show_infonote default shadow default show_stereotype_properties default
  xyz 97 735 2000
end
classcanvas 128514 class_ref 128514 // Invitation
  draw_all_relations default hide_attributes default hide_operations default show_members_full_definition default show_members_visibility default show_members_stereotype default show_members_multiplicity default show_members_initialization default show_attribute_modifiers default member_max_width 0 show_parameter_dir default show_parameter_name default package_name_in_tab default class_drawing_mode default drawing_language default show_context_mode default auto_label_position default show_relation_modifiers default show_infonote default shadow default show_stereotype_properties default
  xyz 58 14 2005
end
classcanvas 128642 class_ref 128642 // Contact
  draw_all_relations default hide_attributes default hide_operations default show_members_full_definition default show_members_visibility default show_members_stereotype default show_members_multiplicity default show_members_initialization default show_attribute_modifiers default member_max_width 0 show_parameter_dir default show_parameter_name default package_name_in_tab default class_drawing_mode default drawing_language default show_context_mode default auto_label_position default show_relation_modifiers default show_infonote default shadow default show_stereotype_properties default
  xyz 720 697 2000
end
classcanvas 128770 class_ref 128770 // ExchangeTopic
  draw_all_relations default hide_attributes default hide_operations default show_members_full_definition default show_members_visibility default show_members_stereotype default show_members_multiplicity default show_members_initialization default show_attribute_modifiers default member_max_width 0 show_parameter_dir default show_parameter_name default package_name_in_tab default class_drawing_mode default drawing_language default show_context_mode default auto_label_position default show_relation_modifiers default show_infonote default shadow default show_stereotype_properties default
  xyz 696 511 2000
end
classcanvas 128898 class_ref 128898 // ExchangePost
  draw_all_relations default hide_attributes default hide_operations default show_members_full_definition default show_members_visibility default show_members_stereotype default show_members_multiplicity default show_members_initialization default show_attribute_modifiers default member_max_width 0 show_parameter_dir default show_parameter_name default package_name_in_tab default class_drawing_mode default drawing_language default show_context_mode default auto_label_position default show_relation_modifiers default show_infonote default shadow default show_stereotype_properties default
  xyz 679 103 2000
end
classcanvas 130050 class_ref 129026 // Compose
  draw_all_relations default hide_attributes default hide_operations default show_members_full_definition default show_members_visibility default show_members_stereotype default show_members_multiplicity default show_members_initialization default show_attribute_modifiers default member_max_width 0 show_parameter_dir default show_parameter_name default package_name_in_tab default class_drawing_mode default drawing_language default show_context_mode default auto_label_position default show_relation_modifiers default show_infonote default shadow default show_stereotype_properties default
  xyz 408 806 2000
end
classcanvas 130818 class_ref 129154 // ParticipateChapter
  draw_all_relations default hide_attributes default hide_operations default show_members_full_definition default show_members_visibility default show_members_stereotype default show_members_multiplicity default show_members_initialization default show_attribute_modifiers default member_max_width 0 show_parameter_dir default show_parameter_name default package_name_in_tab default class_drawing_mode default drawing_language default show_context_mode default auto_label_position default show_relation_modifiers default show_infonote default shadow default show_stereotype_properties default
  xyz 516 352 2000
end
classcanvas 132738 class_ref 129282 // ParticipateCase
  draw_all_relations default hide_attributes default hide_operations default show_members_full_definition default show_members_visibility default show_members_stereotype default show_members_multiplicity default show_members_initialization default show_attribute_modifiers default member_max_width 0 show_parameter_dir default show_parameter_name default package_name_in_tab default class_drawing_mode default drawing_language default show_context_mode default auto_label_position default show_relation_modifiers default show_infonote default shadow default show_stereotype_properties default
  xyz 29 404 2004
end
relationcanvas 129026 relation_ref 128002 // <association>
  from ref 128002 z 1999 stereotype "<<have>>" xyz 194 259 3000 to ref 128130
  no_role_a no_role_b
  multiplicity_a_pos 140 264 3000 multiplicity_b_pos 241 239 3000
end
relationcanvas 129410 relation_ref 128386 // <association>
  from ref 128002 z 1999 stereotype "<<write>>" xyz 482 200 3000 to ref 128898
  no_role_a no_role_b
  multiplicity_a_pos 664 187 3000 no_multiplicity_b
end
relationcanvas 131330 relation_ref 128642 // <association>
  from ref 128898 z 1999 stereotype "<<answer>>" xyz 650 64 3000 to point 649 25
  line 131458 z 1999 to point 621 66
  line 131586 z 1999 to ref 128898
  no_role_a no_role_b
  no_multiplicity_a no_multiplicity_b
end
relationcanvas 131714 relation_ref 128770 // <association>
  from ref 128258 z 1999 stereotype "<<correspond with>>" xyz 559 601 3000 to ref 128770
  no_role_a no_role_b
  multiplicity_a_pos 679 577 3000 multiplicity_b_pos 539 635 3000
end
relationcanvas 131842 relation_ref 128898 // <association>
  from ref 128002 z 1999 to ref 128258
  no_role_a no_role_b
  no_multiplicity_a no_multiplicity_b
end
relationcanvas 132610 relation_ref 129410 // <association>
  from ref 128002 z 1999 to ref 128386
  no_role_a no_role_b
  no_multiplicity_a no_multiplicity_b
end
relationcanvas 133506 relation_ref 129922 // <directional composition>
  from ref 128258 z 1999 to ref 128386
  no_role_a no_role_b
  no_multiplicity_a no_multiplicity_b
end
relationcanvas 133890 relation_ref 130178 // <directional composition>
  from ref 128770 z 1999 to ref 128898
  no_role_a no_role_b
  no_multiplicity_a no_multiplicity_b
end
relationcanvas 134018 relation_ref 130306 // <association>
  from ref 128002 z 1999 to ref 128514
  no_role_a no_role_b
  multiplicity_a_pos 140 137 3000 no_multiplicity_b
end
line 132226 -_-_
  from ref 130818 z 1998 to ref 131842
line 132866 -_-_
  from ref 132610 z 1998 to ref 132738
line 133634 -_-_
  from ref 130050 z 1998 to ref 133506
end
