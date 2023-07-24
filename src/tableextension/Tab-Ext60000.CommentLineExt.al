tableextension 60000 "Comment Line Ext." extends "Comment Line"
{
    fields
    {
        modify("No.")
        {
            TableRelation = if ("Table Name" = const("Interest Calc. Scheme")) "Interest Calc. Scheme";
        }
    }
}