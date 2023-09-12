permissionset 60000 BCPermissionTest
{
    Assignable = true;
    Permissions = tabledata "Interest Calc. Scheme"=RIMD,
        tabledata "Interest Calc. Scheme Line"=RIMD,
        tabledata "Interest Calc. Setup"=RIMD,
        table "Interest Calc. Scheme"=X,
        table "Interest Calc. Scheme Line"=X,
        table "Interest Calc. Setup"=X,
        codeunit "Interest Mgt"=X,
        page "Int.Calc. Scheme Lines Subform"=X,
        page "Interest Calc. Scheme Card"=X,
        page "Interest Calc. Scheme Lines"=X,
        page "Interest Calc. Scheme List"=X,
        page "Interest Calc. Setup"=X,
        page "Interest Calculator"=X;
}