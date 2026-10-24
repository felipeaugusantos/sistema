{***************************************************************}
{* CLASSE QUE REGISTRA TODOS OS FORMS ACESSADOS PELO OPERADOR  *}
{* ATENÇÃO! ESSA UNIT É COMPARTILHADA ENTRE AS DLL'S           *}
{************************************************************RN*}

unit untLogForm;

interface

uses Vcl.Forms, Vcl.StdCtrls, System.Classes, System.SysUtils, Uni, WinApi.Windows;

type
  TfncCriaQuery = reference to function (AOwner: TComponent = Nil; Conexao: TUniConnection = nil): TUniQuery;
  TfncTime = reference to function (const AForceTime : Boolean = False): TDateTime;

type
  TRecLog = Record
    strNomFrm: String;
    strOperac: String;
    dtaDtaLog: TDate;
    hraHraLog: TTime;
    intProHwd: Integer;
    intGDIObj: Integer;
    intUseObj: Integer;
    intConnID: Integer;
  End;

type
  TArrRecLog = Array Of TRecLog;

type
  TLogForm = Class(TComponent)
  private
    class var ArrDadosLog: TArrRecLog;
    class var FblnLogFrm: Boolean;
    class procedure pGravaLog;
    class procedure pLimpar;
    class procedure SetblnLogFrm(const Value: Boolean); static;
    class function GetConnectionID(): Integer;
    class function fTime(): TDateTime;
  public
    class var strCodEmp : String;
    class var strCodOpe : String;
    class var dtaDtaLog : TDate;
    class var fncCriaQuery: TfncCriaQuery;
    class var fncTime : TfncTime;
    class property blnLogFrm : Boolean read FblnLogFrm write SetblnLogFrm;
    class procedure pAddLog(strNomFrm, strOperac: String; dtaDtaLog: TDate; hraHraLog: TTime; intProHwd, intGDIObj, intUseObj, intConnID: Integer);
    class procedure pOnFormChange(Form : TForm);
  End;

implementation

function GetProcessHandleCount(hProcess: THandle; var pdwHandleCount: DWORD): BOOL;  stdcall; external 'Kernel32.dll' name 'GetProcessHandleCount';

function GetOpenHandles : DWORD;
begin
 if not GetProcessHandleCount(GetCurrentProcess,Result) then
     RaiseLastOSError;
end;

{ TLogForm }

class procedure TLogForm.pGravaLog;
  Var
    intCnt : Integer;
    qryDados : TUniQuery;
begin
  If Not Assigned(fncCriaQuery) Then
    Exit;

  qryDados := fncCriaQuery(Nil);
  qryDados.SQL.Text := 'SELECT * FROM LOGFRM WHERE FALSE';
  qryDados.Open;

  For intCnt := Low(ArrDadosLog) To High(ArrDadosLog) Do
  Begin
    qryDados.Append;
    qryDados.FieldByName('LOG_DTALOG').AsDateTime := ArrDadosLog[intCnt].dtaDtaLog;
    qryDados.FieldByName('LOG_HRALOG').AsDateTime := ArrDadosLog[intCnt].hraHraLog;
    qryDados.FieldByName('LOG_NOMFRM').AsString := ArrDadosLog[intCnt].strNomFrm;
    qryDados.FieldByName('LOG_OPERAC').AsString := ArrDadosLog[intCnt].strOperac;
    qryDados.FieldByName('LOG_CODOPE').AsString := strCodOpe;
    qryDados.FieldByName('LOG_CODEMP').AsString := strCodEmp;

    If qryDados.FindField('LOG_PRHWDC') <> Nil Then
      qryDados.FindField('LOG_PRHWDC').AsInteger := ArrDadosLog[intCnt].intProHwd;

    If qryDados.FindField('LOG_GDIOBJ') <> Nil Then
      qryDados.FindField('LOG_GDIOBJ').AsInteger := ArrDadosLog[intCnt].intGDIObj;

    If qryDados.FindField('LOG_USEOBJ') <> Nil Then
      qryDados.FindField('LOG_USEOBJ').AsInteger := ArrDadosLog[intCnt].intUseObj;

    If qryDados.FindField('LOG_CON_ID') <> Nil Then
      qryDados.FindField('LOG_CON_ID').AsInteger := ArrDadosLog[intCnt].intConnID;

    qryDados.Post;
  End;

  qryDados.Close;
  FreeAndNil(qryDados);

  pLimpar;
end;

class function TLogForm.fTime: TDateTime;
begin
  If Not Assigned(fncTime) Then
    Result := System.SysUtils.Time()
  Else
    Result := fncTime;
end;

class function TLogForm.GetConnectionID: Integer;
Var
  LQuery: TUniQuery;
begin
  If Not Assigned(fncCriaQuery) Then Exit(0);
  LQuery := fncCriaQuery(Nil);
  Try
    LQuery.SQL.Text := 'SELECT CONNECTION_ID()';
    LQuery.Open;
    Result := LQuery.Fields[0].AsInteger;
  Finally
    FreeAndNil(LQuery);
  End;
end;

class procedure TLogForm.pAddLog(strNomFrm, strOperac: String; dtaDtaLog: TDate; hraHraLog: TTime; intProHwd, intGDIObj, intUseObj, intConnID: Integer);
begin
  SetLength(ArrDadosLog, Length(ArrDadosLog) + 1);

  FillChar(ArrDadosLog[ Length(ArrDadosLog)-1 ], SizeOf(ArrDadosLog[ Length(ArrDadosLog)-1 ]), #0);

  If (FormatDateTime('dd/mm/yyyy', dtaDtaLog) = '30/12/1899') Then
    dtaDtaLog := nOw();

  ArrDadosLog[ Length(ArrDadosLog)-1 ].dtaDtaLog := dtaDtaLog;
  ArrDadosLog[ Length(ArrDadosLog)-1 ].hraHraLog := hraHraLog;
  ArrDadosLog[ Length(ArrDadosLog)-1 ].strNomFrm := strNomFrm;
  ArrDadosLog[ Length(ArrDadosLog)-1 ].strOperac := strOperac;
  ArrDadosLog[ Length(ArrDadosLog)-1 ].intProHwd := intProHwd;
  ArrDadosLog[ Length(ArrDadosLog)-1 ].intGDIObj := intGDIObj;
  ArrDadosLog[ Length(ArrDadosLog)-1 ].intUseObj := intUseObj;
  ArrDadosLog[ Length(ArrDadosLog)-1 ].intConnID := intConnID;

  If (blnLogFrm) And (strCodEmp <> '') And (strCodOpe <> '') And (dtaDtaLog <> 0) Then
    pGravaLog;
end;

class procedure TLogForm.pLimpar;
begin
  SetLength(ArrDadosLog, 0);
  FillChar(ArrDadosLog, SizeOf(ArrDadosLog), #0);
end;

class procedure TLogForm.pOnFormChange(Form : TForm);
  Var
    LblMensagem : TComponent;
    strCaption : String;
begin
  if not FblnLogFrm then
    Exit;

  strCaption := Form.Caption;

  If (Form.Name = 'frmMensagem') And
     (strCaption = '') Then
  Begin
    LblMensagem := Form.FindComponent('lblMensagem');

    If (LblMensagem <> Nil) And
       (LblMensagem Is TLabel) Then
      strCaption := TLabel(LblMensagem).Caption;
  End;

  TLogForm.pAddLog(Form.Name,
                   strCaption,
                   dtaDtaLog,
                   fTime(),
                   GetOpenHandles,
                   GetGuiResources(GetCurrentProcess, GR_GDIOBJECTS),
                   GetGuiResources(GetCurrentProcess, GR_USEROBJECTS),
                   GetConnectionID);
end;

class procedure TLogForm.SetblnLogFrm(const Value: Boolean);
begin
  FblnLogFrm := Value;
end;

initialization
  TLogForm.fncCriaQuery := Nil;
  TLogForm.strCodEmp := '';
  TLogForm.strCodOpe := '';
  TLogForm.dtaDtaLog := 0;
  TLogForm.fncTime := Nil;

end.
