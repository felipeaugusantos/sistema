{************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta ColorPro *}
{*********************************************************************************AC*}
unit untAbstractGravandoExecucaoColorPro;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untTipoCadastro, Classes, StrUtils, untAutcomTintaFactory,
  UniClientDataSet, untFloatUtils, untIConfTinta, untIDataSet,
  Variants, untStatusGravando, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.Forms, Uni;

type
  TAbstractGravandoExecucaoColorPro = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    procedure pPreparaConexaoFireDac();
  protected
    conf: IConfTinta;
    qryLayer: TFDQuery;
    FDatabase : String;
    FUser_Name: String;
    FPassword : String;
    FPort     : String;
    FServer   : String;
    FDriverID : String;
    qryConf: TUniQuery;
    FDDatabase  : TFDConnection;
    FDDriverLink: TFDPhysMySQLDriverLink;
    FDCursor    : TFDGUIxWaitCursor;

    function fFormataAutInc(const intAutInc: Integer): String;
    function fValidaPath(strArquivo: String): Boolean;
    function GetPath(strArquivo: String): String;
    function GetConfig(strConfig: String): String;



    function fCfgTin(strNome: String): String;

    function fFormataFloatColorPro(strValor: Variant): Double;

    function fTamArq(strNomArq: String; const gravando: IGravando): Integer;
    function fMensagemLinhasDiluentes(strLinWan: String): String;
    procedure pCarregaFormulacoes(const gravando: IGravando);
    procedure pApagaTemporaria;
    procedure pRetornaInfoLinha(strLinha: String; Var strLinDil, strBasDil: String; Var fltFatBas, fltPerDil: Double);
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untStrUtils;

{ TGravandoExecucaoColorProCores }

constructor TAbstractGravandoExecucaoColorPro.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('WCP');
  pPreparaConexaoFireDac();
end;

destructor TAbstractGravandoExecucaoColorPro.Destroy;
begin
  pApagaTemporaria;
  inherited;
  FreeAndNil(FDDatabase);
  FreeAndNil(FDCursor);
  FreeAndNil(FDDriverLink);
  FreeAndNil(qryLayer);
end;

function TAbstractGravandoExecucaoColorPro.fCfgTin(strNome: String): String;
begin
  Result := conf.fGet(strNome);
end;

function TAbstractGravandoExecucaoColorPro.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoColorPro.fFormataFloatColorPro(strValor: Variant): Double;
begin
  If strValor = Null Then
    strValor := '0';

  strValor := AnsiReplaceStr(strValor, '.', ',');
  strValor := '0' + strValor;
  strValor := FloatToStr(TAutcomTintaFactory.Get.fStrToFloat(strValor));
  strValor := AnsiReplaceStr(strValor, '-', '');
  Result   := TAutcomTintaFactory.Get.fStrToFloat(strValor);
end;

function TAbstractGravandoExecucaoColorPro.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoColorPro.fMensagemLinhasDiluentes(
  strLinWan: String): String;
begin
  Result := '';

  If (Pos('004', strLinWan) > 0) And (TStrUtils.fEmptyStr(GetConfig('BD1WAN'))) Then
  Begin
    Result := Result + 'Linha (004): Wandabase HS,';
  End;

  If (Pos('001', strLinWan) > 0) And (TStrUtils.fEmptyStr(GetConfig('BD1ABS_100_50'))) Then
  Begin
    Result := Result + 'Linha (001): Autobase 100:50,';
  End;

  If (Pos('014', strLinWan) > 0) And (TStrUtils.fEmptyStr(GetConfig('BD1ABS_100_80'))) Then
  Begin
    Result := Result + 'Linha (014): Autobase 100:80,';
  End;

  If (Pos('008', strLinWan) > 0) And (TStrUtils.fEmptyStr(GetConfig('BD1PU_HS'))) Then
  Begin
    Result := Result + 'Linha (008): Wanda PU HS,';
  End;

  If (Pos('058', strLinWan) > 0) And (TStrUtils.fEmptyStr(GetConfig('BD1PU_MS'))) Then
  Begin
    Result := Result + 'Linha (058): Wanda PU MS,';
  End;

  If (Pos('019', strLinWan) > 0) And (TStrUtils.fEmptyStr(GetConfig('BD1ABS_BASELINE'))) Then
  Begin
    Result := Result + 'Linha (019): Autobase Plus Baseline 100:50,';
  End;

  If (Pos('016', strLinWan) > 0) And (TStrUtils.fEmptyStr(GetConfig('BD1BT120'))) Then
  Begin
    Result := Result + 'Linha (016): BT120,';
  End;

  If (Pos('059', strLinWan) > 0) And (TStrUtils.fEmptyStr(GetConfig('BD1BT90'))) Then
  Begin
    Result := Result + 'Linha (016): BT90,';
  End;

  If (Pos('013', strLinWan) > 0) And (TStrUtils.fEmptyStr(GetConfig('BD1BT100'))) Then
  Begin
    Result := Result + 'Linha (013): BT100,';
  End;

  If (Pos('037', strLinWan) > 0) And (TStrUtils.fEmptyStr(GetConfig('BD1BT80'))) Then
  Begin
    Result := Result + 'Linha (037): BT80,';
  End;

  If (Pos('072', strLinWan) > 0) And (TStrUtils.fEmptyStr(GetConfig('BD1BT362'))) Then
  Begin
    Result := Result + 'Linha (072): BT362,';
  End;
end;

function TAbstractGravandoExecucaoColorPro.fTamArq(strNomArq: String; const gravando: IGravando): Integer;
Var
  TxtArquivo: TextFile;
  strLinha: String;
begin
  Result := 0;
  AssignFile(TxtArquivo, strNomArq);
  Reset(TxtArquivo);

  While (Not Eof(TxtArquivo)) Do
  Begin
    if gravando.Status <> sgGravando then
    begin
      Result := 0;
      Exit;
    end;

    Result := Result + 1;
    ReadLn(TxtArquivo, strLinha);
  End;

  CloseFile(TxtArquivo);
end;

function TAbstractGravandoExecucaoColorPro.fValidaPath(strArquivo: String): Boolean;
begin
  Result := FileExists(GetPath(strArquivo));
end;

function TAbstractGravandoExecucaoColorPro.GetConfig(
  strConfig: String): String;
begin
  Result := conf.fGet(strConfig);
end;

function TAbstractGravandoExecucaoColorPro.GetPath(strArquivo: String): String;
begin
  Result := conf.fGet('PATWAN') + '\' + strArquivo + '.txt';
end;


procedure TAbstractGravandoExecucaoColorPro.pApagaTemporaria;
  Var
    qryTmp: IDataSet;
begin
  qryTmp := TAutcomTintaFactory.Get.fGetDataSet;

  qryTmp.Close;
  qryTmp.SQL := 'DROP TABLE IF EXISTS TMP_LAYER; ' +
                'DROP TABLE IF EXISTS WANPRO_CODUNI1; ';
  qryTmp.ExecSQL;
end;

procedure TAbstractGravandoExecucaoColorPro.pCarregaFormulacoes(const gravando: IGravando);
  Var
    txtLayer: TextFile;
    strLinha: String;
    intQtdAtual: Integer;
    intQtdRegistros: Integer;
    intQtd  : Integer;
    intContador: Integer;
begin
  pApagaTemporaria;
  intQtdAtual := 0;

  qryLayer := TFDQuery.Create(Nil);
  qryLayer.Connection := FDDatabase;

  qryLayer.Close;
  qryLayer.SQL.Clear();

  qryLayer.SQL.Text := 'CREATE TABLE TMP_LAYER (      ' +
         '  Linha       VARCHAR(10),    ' +
         '  CodAkazo    VARCHAR(30),    ' +
         '  NumCamadas  VARCHAR(1),     ' +
         '  CodPigmento VARCHAR(27),    ' +
         '  Percentual  NUMERIC(12, 4), ' +
         '  Versao      VARCHAR(5),     ' +
         '  Alternativa VARCHAR(5)) ENGINE=MyIsam ';
  qryLayer.ExecSQL;

  qryLayer.Close;
  qryLayer.SQL.Text := 'CREATE INDEX IDX_TMP_LAYER ON TMP_LAYER(Linha, CodAkazo, Alternativa, NumCamadas) ';
  qryLayer.ExecSQL;

  qryLayer.Close;
  qryLayer.SQL.Text := 'ALTER TABLE TMP_LAYER DISABLE KEYS';
  qryLayer.ExecSQL;

  qryLayer.Close;
  qryLayer.SQL.Text := 'INSERT INTO TMP_LAYER VALUES ' +
         ' (:Linha, :CodAkazo, :NumCamadas, :CodPigmento, :Percentual, :Versao, :Alternativa) ';

  intQtdRegistros := fTamArq(GetPath('Layer'), gravando);

  AssignFile(txtLayer, GetPath('Layer'));
  Reset(txtLayer);

  gravando.Texto := 'Carregando Formulação...';

  {*******************************************}
  {* CARREGA A ARQUIVO LAYER                 *}
  {****************************************MV*}
  While (Not Eof(txtLayer)) Do
  Begin
    if gravando.Status <> sgGravando then
      Exit;

    qryLayer.Params.ClearValues();
    qryLayer.Params.ArraySize := 30000;
    intQtd := 0;

    For intContador := 0 To Pred(30000) Do
    Begin
      Readln(txtLayer, strLinha);

      qryLayer.ParamByName('Linha').AsStrings[intContador]        := Trim(Copy(strLinha, 01, 10));
      qryLayer.ParamByName('CodAkazo').AsStrings[intContador]     := Trim(Copy(strLinha, 11, 30));
      qryLayer.ParamByName('NumCamadas').AsStrings[intContador]   := Trim(Copy(strLinha, 42, 01));
      qryLayer.ParamByName('CodPigmento').AsStrings[intContador]  := Trim(Copy(strLinha, 44, 27));
      qryLayer.ParamByName('Percentual').AsFloats[intContador]    := TAutcomTintaFactory.Get.fStrToFloat(Trim(Copy(strLinha, 71, 12)));
      qryLayer.ParamByName('Versao').AsStrings[intContador]       := Trim(Copy(strLinha, 83, 05));
      qryLayer.ParamByName('Alternativa').AsStrings[intContador]  := Trim(Copy(strLinha, 88, 05));

      gravando.RegistrarProgresso(0, intQtdAtual, intQtdRegistros);
      intQtdAtual := intQtdAtual + 1;
      Inc(intQtd);

      If Not Eof(txtLayer) Then
        Continue
      Else
        Break;
    End;

    qryLayer.Execute(intQtd, 0);
  End;

  With qryLayer Do
  Begin
    Close;
    SQL.Text := 'ALTER TABLE TMP_LAYER ENABLE KEYS';
    ExecSQL;
    Close;
  End;

  CloseFile(txtLayer);

  gravando.Texto := 'Formulação carregada com sucesso!';
end;

procedure TAbstractGravandoExecucaoColorPro.pPreparaConexaoFireDac;
begin
  qryConf := TAutcomTintaFactory.Get.fCriaQuery();
  FDriverID  := 'DriverID=MySQL';
  FDatabase  := 'Database=' + qryConf.Connection.Database;
  FUser_Name := 'User_Name=' + qryConf.Connection.Username;
  FPassword  := 'Password=' + qryConf.Connection.Password;
  FPort      := 'Port=' + IntToStr(qryConf.Connection.Port);
  FServer    := 'Server=' + qryConf.Connection.Server;
  FreeAndNil(qryConf);

  FDDatabase   := TFDConnection.Create(Nil);
  FDDriverLink := TFDPhysMySQLDriverLink.Create(Nil);
  FDCursor     := TFDGUIxWaitCursor.Create(Nil);

  FDDatabase.Params.Add(FDatabase);
  FDDatabase.Params.Add(FUser_Name);
  FDDatabase.Params.Add(FPassword);
  FDDatabase.Params.Add(FPort);
  FDDatabase.Params.Add(FServer);
  FDDatabase.Params.Add(FDriverID);

  if FileExists(ExtractFilePath(Application.ExeName) + 'libmysql57.dll') then
    FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql57.dll'
  else
    FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql41.dll';

  FDDatabase.Connected := True;
end;

procedure TAbstractGravandoExecucaoColorPro.pRetornaInfoLinha(strLinha: String;
  Var strLinDil, strBasDil: String; Var fltFatBas, fltPerDil: Double);
begin
  strLinDil := '';
  strBasDil := '';
  fltFatBas := 0.0;
  fltPerDil := 0.0;

  If (strLinha = '4') Then
  Begin
    strLinDil := conf.fGet('LD1WAN');
    strBasDil := conf.fGet('BD1WAN');

    fltPerDil := 33.33;
  End
  Else If (strLinha = '1') Then
  Begin
    strLinDil := conf.fGet('LD1ABS_100_50');
    strBasDil := conf.fGet('BD1ABS_100_50');
    fltPerDil := 33.33;
  End
  Else If (strLinha = '14') Then
  Begin
    strLinDil := conf.fGet('LD1ABS_100_80');
    strBasDil := conf.fGet('BD1ABS_100_80');
    fltPerDil := 44.4;
  End
  Else If (strLinha = '8') Then
  Begin
    strLinDil := conf.fGet('LD1PU_HS');
    strBasDil := conf.fGet('BD1PU_HS');
  End
  Else If (strLinha = '58') Then
  Begin
    strLinDil := conf.fGet('LD1PU_MS');
    strBasDil := conf.fGet('BD1PU_MS');
  End
  Else If (strLinha = '16') Then
  Begin
    strLinDil := conf.fGet('LD1BT120');
    strBasDil := conf.fGet('BD1BT120');
    fltPerDil := 30;
  End
  Else If (strLinha = '59') Then
  Begin
    strLinDil := conf.fGet('LD1BT90');
    strBasDil := conf.fGet('BD1BT90');
  End
  Else If (strLinha = '37') Then
  Begin
    strLinDil := conf.fGet('LD1BT80');
    strBasDil := conf.fGet('BD1BT80');
    fltPerDil := 15;
  End
  Else If (strLinha = '13') Then
  Begin
    strLinDil := conf.fGet('LD1BT100');
    strBasDil := conf.fGet('BD1BT100');
  End
  Else If (strLinha = '12') Then
  Begin
    strLinDil := conf.fGet('LPAPB_10080');
    strBasDil := conf.fGet('BPAPB_10080');
    fltPerDil := 44.40;
  End
  Else If (strLinha = '19') Then
  Begin
    strLinDil := conf.fGet('LD1ABS_BASELINE');
    strBasDil := conf.fGet('BD1ABS_BASELINE');
    fltPerDil := 33.33;
  End
  Else If (strLinha = '72') Then
  Begin
    strLinDil := Conf.fGet('LD1BT362');
    strBasDil := Conf.fGet('BD1BT362');
    fltPerDil := 11.111;
  End;

  If (fltPerDil > 0.0) Then
    fltFatBas := (100 - fltPerDil) / 100;
end;

end.
