unit untTraducaoCxCompsAutBan;

interface

procedure pGeraTraducaoAutBan;

implementation

uses
  System.Classes, System.SysUtils, Forms;

procedure pGeraTraducaoAutBan;
  Var
    stl: TStringList;
Begin
  stl := TStringList.Create;
  stl.Add('[1046]');
  stl.Add('cxSBlobButtonCancel="&Cancelar"');
  stl.Add('cxSBlobButtonOk="&Gravar"');
  stl.SaveToFile(ExtractFilePath(Application.ExeName) + '\PortuguesBrAutban.ini');
  FreeAndNil(stl);
End;

end.
