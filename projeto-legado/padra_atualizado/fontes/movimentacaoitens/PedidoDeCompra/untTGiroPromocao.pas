unit untTGiroPromocao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, Datasnap.DBClient,
  UniClientDataSet, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  cxCurrencyEdit, cxGridCitel, untPai;

type
  TGirPromocao = record
    Mes: string;
    QtdVenProm: Double;
    QtdVendida: Double;
    QtdSemProm: Double;
  End;

  TArrGirPromocao = Array of TGirPromocao;

  TfrmGiroPromocao = class(TfrmPai)
    cxGrid1DBTableView1: TcxGridDBTableViewCitel;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGridCitel;
    dtsDados: TDataSource;
    cdsDados: TUniClientDataSet;
    cdsDadosMES: TStringField;
    cdsDadosQTDPROC: TFloatField;
    cdsDadosQTDVEN: TFloatField;
    cdsDadosQTDSEMPROMOC: TFloatField;
    cxGrid1DBTableView1MES: TcxGridDBColumn;
    cxGrid1DBTableView1QTDPROC: TcxGridDBColumn;
    cxGrid1DBTableView1QTDVEN: TcxGridDBColumn;
    cxGrid1DBTableView1QTDSEMPROMOC: TcxGridDBColumn;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
  protected
    { Private declarations }
    FArrGirPromocao: TArrGirPromocao;
    procedure pAlimentaCDS;
  public
    class procedure pExecuta(ArrGirPromocao: TArrGirPromocao; strCodIte, strReferencia, strUnidade: String);
    { Public declarations }
  end;

var
  frmGiroPromocao: TfrmGiroPromocao;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmTGiroPromocao }

procedure TfrmGiroPromocao.pAlimentaCDS;
var GirPromocao: TGirPromocao;
begin
  for GirPromocao in FArrGirPromocao do
  Begin
    cdsDados.Insert;
    cdsDadosMES.AsString := GirPromocao.Mes;
    cdsDadosQTDPROC.AsFloat := GirPromocao.QtdVenProm;
    cdsDadosQTDVEN.AsFloat := GirPromocao.QtdVendida;
    cdsDadosQTDSEMPROMOC.AsFloat := GirPromocao.QtdSemProm;
    cdsDados.Post;
  End;
end;

class procedure TfrmGiroPromocao.pExecuta(ArrGirPromocao: TArrGirPromocao; strCodIte, strReferencia, strUnidade: String);
begin
  pCriarFormularios(TfrmGiroPromocao, frmGiroPromocao);
  Try
    frmGiroPromocao.FArrGirPromocao :=ArrGirPromocao;
    frmGiroPromocao.Label1.Caption := Format( frmGiroPromocao.Label1.Caption, [strReferencia, strUnidade]);
    frmGiroPromocao.Label2.Caption := Format( frmGiroPromocao.Label2.Caption, [strCodIte + ' - ' + fRetNomProduto(strCodIte)]);

    frmGiroPromocao.pAlimentaCDS;
    frmGiroPromocao.ShowModal;
  Finally
    FreeAndNil(frmGiroPromocao)
  End;

end;

end.
