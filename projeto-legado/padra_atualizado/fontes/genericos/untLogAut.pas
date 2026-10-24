unit untLogAut;

interface

type
  ILogAut = interface
  ['{89D44045-6980-4D65-BB25-B91DFD0F5F21}']
    procedure pLogin;
    procedure pLogout;
    procedure pUpdate;
  end;

  TLogAut = class sealed(TInterfacedObject, ILogAut)
  const
    sqlLogout      = 'UPDATE LOGACE SET                                       '+
                     '  LOG_DTASAI = :DTASAI,                                 '+
                     '  LOG_HRASAI = :HRASAI                                  '+
                     ' WHERE AUTOINCREM = :AUTINC                             ';

    sqlUpdate      = 'UPDATE LOGACE SET                                       '+
                     '  LOG_CON_ID = :CON_ID,                                 '+
                     '  LOG_CODOPE = :CODOPE,                                 '+
                     '  LOG_CODEMP = :CODEMP,                                 '+
                     '  LOG_DTAENT = :DTAENT,                                 '+
                     '  LOG_HRAENT = :HRAENT                                  '+
                     ' WHERE AUTOINCREM = :AUTINC                             ';

  private
    class var FAutInc: String;

    FCodOpe: String;
    FCodEmp: String;
    FCon_ID: String;
    FNum_Ip: String;
    FMacAdd: String;
    FNomMaq: String;
    FNomUsu: String;
    FDtaExe: TDateTime;
    FVerExe: String;
    FPatExe: String;
    FNomExe: String;
    FVerPro: String;
    FWtsMaq: String;
    FWts_Ip: String;
    FParams: String;
    FProcId: String;

    blnCampoProcIdExiste : Boolean;
    blnCampoSvnRevExiste : Boolean;
    blnCampoUrlSvnExiste : Boolean;

    function fInsert : String;
    procedure pRegistraVerRec(AAutInc: String);
    procedure pRegistraVerCNPJAlfa(AAutInc: String);
  protected
    constructor Create;

  public
    procedure pLogin;
    procedure pLogout;
    procedure pUpdate;

    class function New: ILogAut;
  end;

implementation

uses
  Uni,
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  Vcl.Forms,
  untWorkStationInfo,
  untVersaoProg,
  untFuncoesSimples,
  untConstantes,
{$ENDIF}
  System.SysUtils,
  strUtils;

{ TLogAut }

constructor TLogAut.Create;
  Var
    intIdx: Integer;
begin
  If Not fConexaoAtiva() Then
    Exit;

  FCodEmp := VS_strCodEmp;

  If FCodEmp = '' Then
    FCodEmp := fRetEmpresaFisica;

  FCodOpe := strLoginUsuarioLogado;
  FCon_ID := fGetConnectionID();
  FNum_Ip := VS_IPAddressAsString;
  FMacAdd := VS_MacAddress;
  FNomMaq := VS_ComputerNetName;
  FNomUsu := VS_UserFromWindows;

  blnCampoProcIdExiste := fCampoExiste('LOGACE', 'LOG_PROCID', True);
  blnCampoSvnRevExiste := fCampoExiste('LOGACE', 'LOG_SVNREV', True);
  blnCampoUrlSvnExiste := fCampoExiste('LOGACE', 'LOG_URLSVN', True);
  FProcId := ifThen(blnCampoProcIdExiste, VS_ProcessId, '');

  FileAge(Application.ExeName, FDtaExe);
{$IFNDEF LINUX}
  FVerExe := TVersaoExecutavel.GetVersaoArquivo;
  FVerPro := TVersaoExecutavel.GetVersaoProduto;
  FWtsMaq := TWorkStationInfo.fGetWorkstationID;
  FWts_Ip := TWorkStationInfo.fGetWorkStationIP;
{$ELSE}
  FWtsMaq := GetComputerNetName;
  FWts_Ip := GetIPAddress;
{$ENDIF}
  FPatExe := ExtractFilePath(Application.ExeName);
  FNomExe := ExtractFileName(Application.ExeName);

  FParams := '';
  If (ParamCount > 0) Then
  Begin
    For intIdx := 1 To ParamCount Do
    Begin
      FParams := FParams + IIF(FParams.IsEmpty, '', ' ') + ParamStr(intIdx);
    End;
  End;
end;

function TLogAut.fInsert: String;
begin
  Result := '';

  Result := Result + 'INSERT INTO LOGACE (                                    ';
  Result := Result + '  AUTOINCREM,                                           ';
  Result := Result + '  LOG_CODEMP,                                           ';
  Result := Result + '  LOG_CODOPE,                                           ';
  Result := Result + '  LOG_CON_ID,                                           ';
  Result := Result + '  LOG_NUM_IP,                                           ';
  Result := Result + '  LOG_MACADD,                                           ';
  Result := Result + '  LOG_NOMMAQ,                                           ';
  Result := Result + '  LOG_NOMUSU,                                           ';
  Result := Result + '  LOG_DTAEXE,                                           ';
  Result := Result + '  LOG_VEREXE,                                           ';
  Result := Result + '  LOG_PATEXE,                                           ';
  Result := Result + '  LOG_NOMEXE,                                           ';
  Result := Result + '  LOG_DTAENT,                                           ';
  Result := Result + '  LOG_HRAENT,                                           ';
  Result := Result + '  LOG_VERPRO,                                           ';
  Result := Result + '  LOG_WTSMAQ,                                           ';
  Result := Result + '  LOG_WTS_IP,                                           ';

  if blnCampoProcIdExiste then
    Result := Result + '  LOG_PROCID,                                         ';

  if blnCampoSvnRevExiste then
    Result := Result + '  LOG_SVNREV,                                         ';

  if blnCampoUrlSvnExiste then
  begin
    Result := Result + '  LOG_URLSVN,                                         ';
    Result := Result + '  LOG_VERSVN,                                         ';
  end;

  Result := Result + '  LOG_PARAMS                                            ';
  Result := Result + ') VALUES (                                              ';
  Result := Result + '  :AUTINC,                                              ';
  Result := Result + '  :CODEMP,                                              ';
  Result := Result + '  :CODOPE,                                              ';
  Result := Result + '  :CON_ID,                                              ';
  Result := Result + '  :NUM_IP,                                              ';
  Result := Result + '  :MACADD,                                              ';
  Result := Result + '  :NOMMAQ,                                              ';
  Result := Result + '  :NOMUSU,                                              ';
  Result := Result + '  :DTAEXE,                                              ';
  Result := Result + '  :VEREXE,                                              ';
  Result := Result + '  :PATEXE,                                              ';
  Result := Result + '  :NOMEXE,                                              ';
  Result := Result + '  :DTAENT,                                              ';
  Result := Result + '  :HRAENT,                                              ';
  Result := Result + '  :VERPRO,                                              ';
  Result := Result + '  :WTSMAQ,                                              ';
  Result := Result + '  :WTS_IP,                                              ';

  if blnCampoProcIdExiste then
    Result := Result + '  :PROCID,                                            ';

  if blnCampoSvnRevExiste then
    Result := Result + '  :SVNREV,                                            ';

  if blnCampoUrlSvnExiste then
  begin
    Result := Result + '  :URLSVN,                                            ';
    Result := Result + '  :VERSVN,                                            ';
  end;

  Result := Result + '  IF(:PARAMS="",NULL,:PARAMS))                          ';
end;

class function TLogAut.New: ILogAut;
begin
  Result := TLogAut.Create();
end;

procedure TLogAut.pLogin;
{$IFDEF LINUX}
  const SVN_REPOSITORY = 'svn://srvprg1.citelsoftware.com.br';
 {$I '..\..\..\bin\svn_rev.inc'}
{$ELSE}
 {$I rev.inc}
{$ENDIF}
var
  LQry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
  LUrlSvn: string;
  LVerSvn: TArray<string>;
begin
  If Not fConexaoAtiva() Then
    Exit;

  If (Not fEmptyStr(FAutInc)) Then
  Begin
    Self.pUpdate;
    Exit;
  End;

  LQry := fCriaQuery();

  Try
    FAutInc := fRetAutoIncrem('LOGACE', FCodEmp);

    LQry.SQL.Add(fInsert);
    LQry.ParamByName('AUTINC').AsString   := FAutInc;
    LQry.ParamByName('CON_ID').AsString   := FCon_ID;
    LQry.ParamByName('CODOPE').AsString   := FCodOpe;
    LQry.ParamByName('CODEMP').AsString   := FCodEmp;
    LQry.ParamByName('NUM_IP').AsString   := FNum_Ip;
    LQry.ParamByName('MACADD').AsString   := FMacAdd;
    LQry.ParamByName('NOMMAQ').AsString   := FNomMaq;
    LQry.ParamByName('NOMUSU').AsString   := FNomUsu;
    LQry.ParamByName('DTAEXE').AsDateTime := FDtaExe;
    LQry.ParamByName('WTSMAQ').AsString   := FWtsMaq;
    LQry.ParamByName('WTS_IP').AsString   := FWts_IP;
    LQry.ParamByName('PATEXE').AsString   := FPatExe;
    LQry.ParamByName('NOMEXE').AsString   := FNomExe;
    LQry.ParamByName('DTAENT').AsDate     := Date;
    LQry.ParamByName('HRAENT').AsTime     := fTime();
    LQry.ParamByName('PARAMS').AsString   := FParams;

    if blnCampoProcIdExiste then
      LQry.ParamByName('PROCID').AsString   := FProcId;

    if blnCampoSvnRevExiste then
      LQry.ParamByName('SVNREV').AsInteger  := StrToIntDef(SVN_REVISION, 0);

    if blnCampoUrlSvnExiste then
    begin
      LUrlSvn := SVN_URL;
      LUrlSvn := LUrlSvn.Replace(SVN_REPOSITORY, '..');

      if LUrlSvn.EndsWith('/padra_atualizado') then
      begin
        LUrlSvn := LUrlSvn.Replace('/padra_atualizado', '');
        LVerSvn := LUrlSvn.Split(['/']);
        LQry.ParamByName('VERSVN').AsString  := LVerSvn[High(LVerSvn)];
      end
      else if LUrlSvn.EndsWith('/padra_atualizado/Services/bin') then
      begin
        LUrlSvn := LUrlSvn.Replace('/padra_atualizado/Services/bin', '');
        LVerSvn := LUrlSvn.Split(['/']);
        LQry.ParamByName('VERSVN').AsString  := LVerSvn[High(LVerSvn)];

        if FVerExe.IsEmpty then
          FVerExe := LVerSvn[High(LVerSvn)];

        if FVerPro.IsEmpty then
          FVerPro := LVerSvn[High(LVerSvn)];
      end;

      LQry.ParamByName('URLSVN').AsString  := LUrlSvn + '/Services';
    end;

    LQry.ParamByName('VEREXE').AsString := FVerExe;
    LQry.ParamByName('VERPRO').AsString := FVerPro;

    LQry.ExecSQL();

    pRegistraVerRec(FAutInc);
    pRegistraVerCNPJAlfa(FAutInc);
  Finally
   {$IFNDEF LINUX}
    FreeAndNil(LQry);
   {$ENDIF}
  End;
end;

procedure TLogAut.pLogout;
var
  LQry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
begin
  If Not fConexaoAtiva() Then
    Exit;

  If fEmptyStr(FAutInc) Then
    Exit;

  LQry := fCriaQuery();

  Try
    LQry.SQL.Add(sqlLogout);
    LQry.ParamByName('DTASAI').AsDate   := Date;
    LQry.ParamByName('HRASAI').AsTime   := fTime();
    LQry.ParamByName('AUTINC').AsString := FAutInc;

    LQry.ExecSQL();
  Finally
    FAutInc := '';
   {$IFNDEF LINUX}
    FreeAndNil(LQry);
   {$ENDIF}
  End;
end;

procedure TLogAut.pRegistraVerCNPJAlfa(AAutInc: String);
{$IFDEF LINUX}
begin
  //do nothing
end;
{$ELSE}
const
  SQL_VERREC =
  ' INSERT INTO VERREC '+
  ' (AUTOINCREM, VER_SEQACE, VER_RECURS, VER_VERSAO) '+
  ' VALUES '+
  ' (:AUTOINCREM, :VER_SEQACE, :VER_RECURS, :VER_VERSAO) ';

  ARR_RECURSOS: array[0..0] of array[0..1] of string = (
    ('CNPJ ALFANUMERICO', '1')
  );

var
  LQry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
  intCount: Integer;
begin
  If Not fConexaoAtiva() Then
    Exit;

  If fEmptyStr(FAutInc) Then
    Exit;

  If fEmptyStr(fCampoTabela('AUTOINCREM', 'LOGACE', ['AUTOINCREM'], [FAutInc])) then
    Exit;

  SetLength(arrProCod, Length(arrProCod)+1);
  arrProCod[Length(arrProCod)-1].strNomArq := 'VERREC';
  arrProCod[Length(arrProCod)-1].strCodSeq := '0000000000001';
  arrProCod[Length(arrProCod)-1].intTamCod := 12;
  arrProCod[Length(arrProCod)-1].strCodAut := 'S';
  arrProCod[Length(arrProCod)-1].intAutInc := 1;

  pValidaProCod('VERREC');

  LQry := fCriaQuery();
  Try
    for intCount := 0 to High(ARR_RECURSOS) do
    begin
      LQry.Close;
      LQry.SQL.Text := SQL_VERREC;
      LQry.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('VERREC', FCodEmp);
      LQry.ParamByName('VER_SEQACE').AsString := AAutInc;
      LQry.ParamByName('VER_RECURS').AsString := ARR_RECURSOS[intCount][0];
      LQry.ParamByName('VER_VERSAO').AsString := ARR_RECURSOS[intCount][1];
      LQry.ExecSQL;
    end;
  Finally
   {$IFNDEF LINUX}
    FreeAndNil(LQry);
   {$ENDIF}
  End;

end;
{$ENDIF}

procedure TLogAut.pRegistraVerRec(AAutInc: String);
const
  SQL_VERREC =
  ' INSERT INTO VERREC '+
  ' (AUTOINCREM, VER_SEQACE, VER_RECURS, VER_VERSAO) '+
  ' VALUES '+
  ' (:AUTOINCREM, :VER_SEQACE, :VER_RECURS, :VER_VERSAO) ';

  ARR_RECURSOS: array[0..0] of array[0..1] of string = (
    ('REFORMA_TRIBUTARIA', '1')
  );

var
  LQry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
  intCount: Integer;
begin
  If Not fConexaoAtiva() Then
    Exit;

  If fEmptyStr(FAutInc) Then
    Exit;

  If fEmptyStr(fCampoTabela('AUTOINCREM', 'LOGACE', ['AUTOINCREM'], [FAutInc])) then
    Exit;

  SetLength(arrProCod, Length(arrProCod)+1);
  arrProCod[Length(arrProCod)-1].strNomArq := 'VERREC';
  arrProCod[Length(arrProCod)-1].strCodSeq := '0000000000001';
  arrProCod[Length(arrProCod)-1].intTamCod := 12;
  arrProCod[Length(arrProCod)-1].strCodAut := 'S';
  arrProCod[Length(arrProCod)-1].intAutInc := 1;

  pValidaProCod('VERREC');

  LQry := fCriaQuery();
  Try
    for intCount := 0 to High(ARR_RECURSOS) do
    begin
      LQry.Close;
      LQry.SQL.Text := SQL_VERREC;
      LQry.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('VERREC', FCodEmp);
      LQry.ParamByName('VER_SEQACE').AsString := AAutInc;
      LQry.ParamByName('VER_RECURS').AsString := ARR_RECURSOS[intCount][0];
      LQry.ParamByName('VER_VERSAO').AsString := ARR_RECURSOS[intCount][1];
      LQry.ExecSQL;
    end;
  Finally
   {$IFNDEF LINUX}
    FreeAndNil(LQry);
   {$ENDIF}
  End;

end;

procedure TLogAut.pUpdate;
var
  LQry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
begin
  If Not fConexaoAtiva() Then
    Exit;

  If fEmptyStr(FAutInc) Then
    Exit;

  LQry := fCriaQuery();

  Try
    LQry.SQL.Add(sqlUpdate);
    LQry.ParamByName('CON_ID').AsString := fGetConnectionID();
    LQry.ParamByName('CODEMP').AsString := FCodEmp;
    LQry.ParamByName('CODOPE').AsString := FCodOpe;
    LQry.ParamByName('AUTINC').AsString := FAutInc;
    LQry.ParamByName('DTAENT').AsDate   := Date;
    LQry.ParamByName('HRAENT').AsTime   := fTime();
    LQry.ExecSQL();
  Finally
   {$IFNDEF LINUX}
    FreeAndNil(LQry);
   {$ENDIF}
  End;
end;

initialization
  TLogAut.FAutInc := '';

end.
