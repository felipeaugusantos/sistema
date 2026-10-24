unit Contabilidade.ModuloLog;

interface

uses
  SysUtils, Classes, Uni, StrUtils, DBAccess, DBMonitorClient,
  DASQLMonitor, UniSQLMonitor;

type
  TdmContabilidadeModuloLog = class(TDataModule)
    sqlMonitor: TUniSQLMonitor;
    procedure sqlMonitorSQL(Sender: TObject; Text: string; Flag: TDATraceFlag);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmContabilidadeModuloLog: TdmContabilidadeModuloLog;

implementation

uses Contabilidade.Funcoes ;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmContabilidadeModuloLog.sqlMonitorSQL(Sender: TObject; Text: string;
  Flag: TDATraceFlag);
Var
  LstrString     : String;
  LstrTabela     : String;
Begin
  try
    LstrString := fTiraEnter(Text);
    LstrTabela := fRetornaNomeTabela(LstrString);

    if (fEhTabelaDeContabilidade(LstrTabela)) then
      pGravaLogContabil(LstrString, LstrTabela);
  except
    /// se tiver algum erro ignora e não loga
  end ;
end;

end.
