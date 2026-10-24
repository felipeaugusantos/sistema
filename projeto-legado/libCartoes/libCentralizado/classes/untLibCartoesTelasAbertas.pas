unit untLibCartoesTelasAbertas;

interface

Uses
  Windows, System.Generics.Collections, Vcl.Forms, Vcl.Controls,
  System.SysUtils, System.StrUtils, System.Classes,

  untLibCartoesInterfacesTipos;

type
  TTelasAbertas = class(TInterfacedObject, ITelasAbertas)
  strict private
    class var FInstance : TTelasAbertas;
    class var FForms : TList<TForm>;
    class var FLastFormOpened : TForm;
    procedure DefineLastFormOpened;
  private
    class procedure ReleaseInstance;
  public
    class function GetInstance: TTelasAbertas;
    function Forms : TList<TForm>;
    function LastFormOpened : TForm;
    procedure AddFormAndSetPopupMode(FormOpened: TForm);
    procedure RemoveFormParent(FormClosing: TForm);

    function FindLastVisibleForm : TForm;
//    procedure pLog(strValor: String);
  end;

var
  objTelasAbertas : ITelasAbertas = Nil;

implementation

{ TTelasAbertas }

procedure TTelasAbertas.AddFormAndSetPopupMode(FormOpened: TForm);
begin
  Try
    If (Fforms.Count > 0) Then
    Begin
      FormOpened.PopupMode   := pmExplicit;
      FormOpened.PopupParent := FindLastVisibleForm;
    End;

    FForms.Add(FormOpened);

    DefineLastFormOpened;

//    If Assigned(FormOpened.PopupParent) Then
//      pLog('Tela em 1º Plano : ' + FormOpened.ToString() + #13 +
//           'Tela em 2º Plano : ' + FormOpened.PopupParent.ToString())
//    Else
//      pLog('Tela em 1º Plano : ' + FormOpened.ToString() + #13 +
//           'Tela em 2º Plano : Nil');
  except
    // Do nothing
  end;
end;

procedure TTelasAbertas.DefineLastFormOpened;
begin
  Self.FLastFormOpened := FindLastVisibleForm;
end;

function TTelasAbertas.FindLastVisibleForm: TForm;
Var
  intForm : Integer;
begin
  Result := Nil;

  for intForm := FForms.Count-1 downto 0 do
  begin
    If Not Assigned(FForms.Items[intForm]) Then
      Continue;

    If (FForms.Items[intForm].Visible) Or
       (FForms.Items[intForm].Name = 'frmGridRelatResult') Then
    begin
      Result := FForms.Items[intForm];
      Break;
    end;
  end;
end;

function TTelasAbertas.Forms: TList<TForm>;
begin
  Result := FForms;
end;

class function TTelasAbertas.GetInstance: TTelasAbertas;
begin
  if Not Assigned(Self.FInstance) then
  Begin
    Self.FInstance       := TTelasAbertas.Create;
    Self.FForms          := TList<TForm>.Create;
    Self.FLastFormOpened := Nil;
  End;

  Result := Self.FInstance;
end;

function TTelasAbertas.LastFormOpened: TForm;
begin
  Result := Self.FLastFormOpened;
end;

//procedure TTelasAbertas.pLog(strValor: String);
//const
//  _FILE_LOG : String = '.\LogAut.txt';
//Var
//  stlLog : TStringList;
//  intForm: Integer;
//  LFrmForm : TForm;
//begin
//  stlLog := TStringList.Create;
//  Try
//    Try
//      If FileExists(_FILE_LOG) Then
//        DeleteFile(_FILE_LOG);
//
//      stlLog.Add(strValor);
//      stlLog.Add('');
//
//      for intForm := FForms.Count-1 downto 0 do
//      begin
//        LFrmForm := FForms.Items[intForm];
//        If Assigned(LFrmForm) Then
//          stlLog.Add(FormatFloat('00', intForm) + ' : ' + LFrmForm.ToString() + ' - ' + LFrmForm.Name)
//        else
//          stlLog.Add(FormatFloat('00', intForm) + ' : ' + LFrmForm.ToString());
//      End;
//
//      stlLog.SaveToFile(_FILE_LOG);
//    Finally
//      FreeAndNil(stlLog);
//    End;
//  Except
//    //
//  End;
//end;

class procedure TTelasAbertas.ReleaseInstance;
begin
  Try
    if Assigned(FInstance) then
      FreeAndNil(FInstance);
  Except
    //
  End;
end;

procedure TTelasAbertas.RemoveFormParent(FormClosing: TForm);
Var
  intForm : Integer;
begin
  If (FForms.Count > 1) Then
  Begin
    If Not Assigned(FormClosing) Then
      FForms.Remove(FForms.Last)

    Else
    Begin
      For intForm := FForms.Count-1 DownTo 0 Do
      begin
        If Not Assigned(FForms.Items[intForm]) Then
          Continue;

        If (FForms.Items[intForm] = FormClosing) Then
        begin
          FForms.Remove(FForms.Items[intForm]);
          Break;
        end;
      end;
    End;

    DefineLastFormOpened;

//    If Assigned(Self.FLastFormOpened) Then
//    Begin
//      If Assigned(Self.FLastFormOpened.PopupParent) Then
//        pLog('Tela em 1º Plano : ' + Self.FLastFormOpened.ToString() + #13 +
//             'Tela em 2º Plano : ' + Self.FLastFormOpened.PopupParent.ToString())
//      Else
//        pLog('Tela em 1º Plano : ' + Self.FLastFormOpened.ToString() + #13 +
//             'Tela em 2º Plano : Nil ');
//    End
//    Else
//      pLog('Tela em 1º Plano : Nil');
  End
  Else
  Begin
    Self.FLastFormOpened := Nil;
//    pLog('Tela em 1º Plano : Nil');
  End;
end;

initialization

finalization
  TTelasAbertas.ReleaseInstance();

end.
