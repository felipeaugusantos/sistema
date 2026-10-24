{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Dupont  *}
{********************************************************************************AC*}
unit untAbstractGravandoExecucaoDupont;

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
  TAbstractGravandoExecucaoDupont = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    procedure pPreparaConexaoFireDac();
  protected
    conf: IConfTinta;
    strCampos: string;
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
    function fValidaPath(Tipo: TTipoCadastro; intGeral: Integer = 0): Boolean;
    function GetPath(Tipo: TTipoCadastro; intGeral: Integer): String;


    function fCfgTin(strNome: String): String;

    function fFormataFloatDupont(strValor: Variant): Double;
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

{ TGravandoExecucaoDupontCores }

constructor TAbstractGravandoExecucaoDupont.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('DUP');
  pPreparaConexaoFireDac();
end;

destructor TAbstractGravandoExecucaoDupont.Destroy;
begin
  inherited;
  FreeAndNil(FDDatabase);
  FreeAndNil(FDCursor);
  FreeAndNil(FDDriverLink);
end;

function TAbstractGravandoExecucaoDupont.fCfgTin(strNome: String): String;
begin
  Result := conf.fGet(strNome);
end;

function TAbstractGravandoExecucaoDupont.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoDupont.fFormataFloatDupont(strValor: Variant): Double;
begin
  If strValor = Null Then
    strValor := '0';

  strValor := AnsiReplaceStr(strValor, '.', ',');
  strValor := '0' + strValor;
  strValor := FloatToStr(TAutcomTintaFactory.Get.fStrToFloat(strValor));
  strValor := AnsiReplaceStr(strValor, '-', '');
  Result   := TAutcomTintaFactory.Get.fStrToFloat(strValor);
end;

function TAbstractGravandoExecucaoDupont.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoDupont.fValidaPath(Tipo: TTipoCadastro; intGeral: Integer = 0): Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath(Tipo, intGeral))) Then
    Result := False;
end;

function TAbstractGravandoExecucaoDupont.GetPath(Tipo: TTipoCadastro; intGeral: Integer): String;
begin
  Result := '';

  If Tipo = ttBases Then
    Result := conf.fGet('PATDUP') + '\compqualidade.xml'
  Else If Tipo = ttGeral Then
  Begin
    If intGeral = 1 Then
      Result := conf.fGet('PATDUP') + '\Formulas.xml'
    Else If intGeral = 2 Then
      Result := conf.fGet('PATDUP') + '\PadraoRelMistQld.xml';
  End;
end;


procedure TAbstractGravandoExecucaoDupont.pPreparaConexaoFireDac;
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

end.
