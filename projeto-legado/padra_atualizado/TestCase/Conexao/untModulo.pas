unit untModulo;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, Uni, UniProvider,
  MySQLUniProvider, Dialogs, untConexao, untFuncoes, Vcl.StdCtrls;

type
  TfrmModulo = class(TDataModule)
    Database: TUniConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    FRegistros                        : Integer;
    FRegistrosProcessados             : Integer;
    FRegistrosProcessadosAcerto       : Integer;
    FRegistrosProcessadosErro         : Integer;
    FRegistrosProcessadosIgnorados    : Integer;
    FRegistrosProcessadosDuplicados   : Integer;
    FProcessamentoAtual               : String;
    FExecutandoPeloJenkins            : Boolean;

    FlblRegistros                     : TLabel;
    FlblRegistrosProcessados          : TLabel;
    FlblRegistrosProcessadosErros     : TLabel;
    FlblRegistrosProcessadosAcertos   : TLabel;
    FlblRegistrosProcessadosIgnorados : TLabel;
    FlblRegistrosProcessadosDuplicados: TLabel;
    FlblProcessamentoAtual            : TLabel;

    function ValidarExecucaoPeloJenkins: boolean;
  public
    { Public declarations }

    FCodEmp : String;
    FNomeEmpresa : String;
    FChaveLogLigada: Boolean;

    FDataInicio : TDate;
    FHoraInicio : TTime;
    FHoraFim    : TTime;
    FPeriodoInicial: TDate;
    FPeriodoFinal  : TDate;

    FResumo                        : TStringList;
    FPararProcessamento            : Boolean;

    Procedure Registros(const ARegistros: integer); overload;
    function  Registros: integer; overload;

    Procedure RegistrosProcessados(const ARegistrosProcessados: integer); overload;
    function  RegistrosProcessados: integer; overload;

    Procedure RegistrosProcessadosAcerto(const ARegistrosProcessadosAcerto: integer); overload;
    function  RegistrosProcessadosAcerto: integer; overload;

    Procedure RegistrosProcessadosErro(const ARegistrosProcessadosErro: integer); overload;
    function  RegistrosProcessadosErro: integer; overload;

    Procedure RegistrosProcessadosIgnorados(const ARegistrosProcessadosIgnorados: integer); overload;
    function  RegistrosProcessadosIgnorados: integer; overload;

    Procedure RegistrosProcessadosDuplicados(const ARegistrosProcessadosDuplicados: integer); overload;
    function  RegistrosProcessadosDuplicados: integer; overload;

    procedure IncrementarRegistrosProcessados;
    procedure IncrementarRegistrosProcessadosDuplicados;
    procedure IncrementarRegistrosProcessadosIgnorados;
    procedure IncrementarRegistrosProcessadosAcertos;
    procedure IncrementarRegistrosProcessadosErros;

    procedure LabelRegistros(const AlblRegistros: TLabel);
    procedure LabelRegistrosProcessados(const AlblRegistrosProcessados: TLabel);
    procedure LabelRegistrosProcessadosErros(const AlblRegistrosProcessadosErro: TLabel);
    procedure LabelRegistrosProcessadosAcertos(const AlblRegistrosProcessadosAcertos: TLabel);
    procedure LabelRegistrosProcessadosIgnorados(const AlblRegistrosProcessadosIgnorados: TLabel);
    procedure LabelRegistrosProcessadosDuplicados(const AlblRegistrosProcessadosDuplicados: TLabel);
    procedure LabelProcessamentoAtual(const AlblProcessamentoAtual: TLabel);

    procedure PreencherLabelRegistros;
    procedure PreencherLabelRegistrosProcessados;
    procedure PreencherLabelRegistrosProcessadosErro;
    procedure PreencherLabelRegistrosProcessadosAcertos;
    procedure PreencherLabelRegistrosProcessadosDuplicados;
    procedure PreencherLabelRegistrosProcessadosIgnorados;

    procedure ProcessamentoAtual(const ALocal: string);
    procedure PreencherLabelProcessamentoAtual;

    procedure ExecutandoPeloJenkins(const AValue: boolean); overload;
    function ExecutandoPeloJenkins: boolean; overload;
  end;

var
  frmModulo: TfrmModulo;

Const
  PATH = 'Log\';

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TfrmModulo.DataModuleCreate(Sender: TObject);
begin
  Try
    FExecutandoPeloJenkins := ValidarExecucaoPeloJenkins;
    untConexao.FExecutandoPeloJenkins := FExecutandoPeloJenkins;

    FRegistros                      := 0;
    FRegistrosProcessados           := 0;
    FRegistrosProcessadosAcerto     := 0;
    FRegistrosProcessadosErro       := 0;
    FRegistrosProcessadosIgnorados  := 0;
    FRegistrosProcessadosDuplicados := 0;

    pAbrirBanco(Database);

    FCodEmp := fArqIni(0,'GERAL','CODEMP','');
    FChaveLogLigada := fArqIni(0,'GERAL','EXEC_LOG_TESTE_UNITARIO_BPL','N') = 'S';

    EnableUniSQL := False;
  Except
    On E : Exception Do
      ShowMessage('Erro ao tentar realizar conexão.' + #13 + e.message);
  End;
end;

procedure TfrmModulo.Registros(const ARegistros: integer);
begin
  FRegistros := ARegistros;
  PreencherLabelRegistros;
end;

function TfrmModulo.Registros: integer;
begin
  result := FRegistros;
end;

function TfrmModulo.RegistrosProcessados: integer;
begin
  result := FRegistrosProcessados;
end;

procedure TfrmModulo.RegistrosProcessados(const ARegistrosProcessados: integer);
begin
  FRegistrosProcessados := ARegistrosProcessados;
  PreencherLabelRegistrosProcessados;
end;

function TfrmModulo.RegistrosProcessadosAcerto: integer;
begin
  result := FRegistrosProcessadosAcerto;
end;

procedure TfrmModulo.RegistrosProcessadosAcerto(const ARegistrosProcessadosAcerto: integer);
begin
  FRegistrosProcessadosAcerto := ARegistrosProcessadosAcerto;
  PreencherLabelRegistrosProcessadosAcertos;
end;

procedure TfrmModulo.RegistrosProcessadosDuplicados(const ARegistrosProcessadosDuplicados: integer);
begin
  FRegistrosProcessadosDuplicados := ARegistrosProcessadosDuplicados;
  PreencherLabelRegistrosProcessadosDuplicados;
end;

function TfrmModulo.RegistrosProcessadosDuplicados: integer;
begin
  result := FRegistrosProcessadosDuplicados;
end;

function TfrmModulo.RegistrosProcessadosErro: integer;
begin
  result := FRegistrosProcessadosErro;
end;

procedure TfrmModulo.RegistrosProcessadosErro(const ARegistrosProcessadosErro: integer);
begin
  FRegistrosProcessadosErro := ARegistrosProcessadosErro;
  PreencherLabelRegistrosProcessadosErro;
end;

function TfrmModulo.RegistrosProcessadosIgnorados: integer;
begin
  result := FRegistrosProcessadosIgnorados;
end;

function TfrmModulo.ValidarExecucaoPeloJenkins: boolean;
begin
  result := False;

  if ParamCount < 1 then
    Exit;

  result := SameText(ParamStr(1), 'JENKINS');
end;

procedure TfrmModulo.RegistrosProcessadosIgnorados(const ARegistrosProcessadosIgnorados: integer);
begin
  FRegistrosProcessadosIgnorados := ARegistrosProcessadosIgnorados;
  PreencherLabelRegistrosProcessadosIgnorados;
end;

procedure TfrmModulo.ExecutandoPeloJenkins(const AValue: boolean);
begin
  FExecutandoPeloJenkins := AValue;
end;

function TfrmModulo.ExecutandoPeloJenkins: boolean;
begin
  result := FExecutandoPeloJenkins;
end;

procedure TfrmModulo.IncrementarRegistrosProcessados;
begin
  Inc(FRegistrosProcessados);
  PreencherLabelRegistrosProcessados;
end;

procedure TfrmModulo.IncrementarRegistrosProcessadosAcertos;
begin
  Inc(FRegistrosProcessadosAcerto);
  PreencherLabelRegistrosProcessadosAcertos;
end;

procedure TfrmModulo.IncrementarRegistrosProcessadosDuplicados;
begin
  Inc(FRegistrosProcessadosDuplicados);
  PreencherLabelRegistrosProcessadosDuplicados;
end;

procedure TfrmModulo.IncrementarRegistrosProcessadosErros;
begin
  Inc(FRegistrosProcessadosErro);
  PreencherLabelRegistrosProcessadosErro;
end;

procedure TfrmModulo.IncrementarRegistrosProcessadosIgnorados;
begin
  Inc(FRegistrosProcessadosIgnorados);
  PreencherLabelRegistrosProcessadosIgnorados;
end;

procedure TfrmModulo.LabelProcessamentoAtual(
  const AlblProcessamentoAtual: TLabel);
begin
  FlblProcessamentoAtual := AlblProcessamentoAtual;
end;

procedure TfrmModulo.LabelRegistros(const AlblRegistros: TLabel);
begin
  FlblRegistros := AlblRegistros;
end;

procedure TfrmModulo.LabelRegistrosProcessados(
  const AlblRegistrosProcessados: TLabel);
begin
  FlblRegistrosProcessados := AlblRegistrosProcessados;
end;

procedure TfrmModulo.LabelRegistrosProcessadosAcertos(
  const AlblRegistrosProcessadosAcertos: TLabel);
begin
  FlblRegistrosProcessadosAcertos := AlblRegistrosProcessadosAcertos;
end;

procedure TfrmModulo.LabelRegistrosProcessadosErros(
  const AlblRegistrosProcessadosErro: TLabel);
begin
  FlblRegistrosProcessadosErros := AlblRegistrosProcessadosErro;
end;

procedure TfrmModulo.LabelRegistrosProcessadosIgnorados(
  const AlblRegistrosProcessadosIgnorados: TLabel);
begin
  FlblRegistrosProcessadosIgnorados := AlblRegistrosProcessadosIgnorados;
end;

procedure TfrmModulo.LabelRegistrosProcessadosDuplicados(
  const AlblRegistrosProcessadosDuplicados: TLabel);
begin
  FlblRegistrosProcessadosDuplicados := AlblRegistrosProcessadosDuplicados;
end;

procedure TfrmModulo.PreencherLabelProcessamentoAtual;
begin
  FlblProcessamentoAtual.Caption := FProcessamentoAtual;
end;

procedure TfrmModulo.PreencherLabelRegistros;
begin
  FlblRegistros.Caption := IntToStr(FRegistros);
end;

procedure TfrmModulo.PreencherLabelRegistrosProcessados;
begin
  FlblRegistrosProcessados.Caption := IntToStr(FRegistrosProcessados);
end;

procedure TfrmModulo.PreencherLabelRegistrosProcessadosAcertos;
begin
  FlblRegistrosProcessadosAcertos.Caption := IntToStr(FRegistrosProcessadosAcerto);
end;

procedure TfrmModulo.PreencherLabelRegistrosProcessadosDuplicados;
begin
  FlblRegistrosProcessadosDuplicados.Caption := IntToStr(FRegistrosProcessadosDuplicados);
end;

procedure TfrmModulo.PreencherLabelRegistrosProcessadosErro;
begin
  FlblRegistrosProcessadosErros.Caption := IntToStr(FRegistrosProcessadosErro);
end;

procedure TfrmModulo.PreencherLabelRegistrosProcessadosIgnorados;
begin
  FlblRegistrosProcessadosIgnorados.Caption := IntToStr(FRegistrosProcessadosIgnorados);
end;

procedure TfrmModulo.ProcessamentoAtual(const ALocal: string);
begin
  FProcessamentoAtual := ALocal;
  PreencherLabelProcessamentoAtual;
end;

end.
