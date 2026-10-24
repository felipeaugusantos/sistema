unit untItensSemPro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, DB,
  UniClientDataSet, Grids, DBGridCitel, DBGrids, BitBtnLockedIncrem,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade;

type
  TfrmItensSemPro = class(TfrmPai)
    dbgDados: TDBGridCitel;
    dtsDados: TDataSource;
    cdsDados: TUniClientDataSet;
    cdsDadosCODITE: TStringField;
    cdsDadosDESCRI: TStringField;
    cdsDadosVALPRO: TFloatField;
    cdsDadosVALSPR: TFloatField;
    cdsDadosQTDLIM: TFloatField;
    cdsDadosUNIDAD: TStringField;
    cdsDadosQTDEXC: TFloatField;
    cdsDadosQTDITE: TFloatField;
    cdsDadosAUTINC: TStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmItensSemPro.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte( cdsDadosCODITE );
  cdsDados.CreateDataSet;
end;

end.
