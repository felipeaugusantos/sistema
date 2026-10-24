unit untItensSemLote;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,
  untCdsItensSemLote;

type
  TfrmItensSemLote = class(TfrmPaiConfirma)
    cxgItensSemLoteTBV: TcxGridDBTableViewCitel;
    cxgItensSemLoteLVL: TcxGridLevel;
    cxgItensSemLote: TcxGridCitel;
    btnCadastroRapidoLote: TBitBtnLocked;
    cxgItensSemLoteTBVCODIGO: TcxGridDBColumn;
    cxgItensSemLoteTBVDESCRICAO: TcxGridDBColumn;
    cxgItensSemLoteTBVNUMERO_LOTE: TcxGridDBColumn;
    dtsItensSemLote: TDataSource;
    pnlMensagem: TPanel;
    lblMensagem: TLabel;
    procedure btnCadastroRapidoLoteClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    cdsItens : TCdsItensSemLote;
    { Public declarations }
  end;

var
  frmItensSemLote: TfrmItensSemLote;

implementation

{$R *.dfm}

uses untCadLoteItens, untFuncoesSimples, untTypesSistema;

procedure TfrmItensSemLote.btnCadastroRapidoLoteClick(Sender: TObject);
var
  strLotCad : String;
  frmCadLoteItens : TfrmCadLoteItens;
begin
  inherited;
  if cdsItens.isEmpty then
    exit;


  pCriarFormularios(TfrmCadLoteItens, frmCadLoteItens);
  try
    frmCadLoteItens.strCodigoItemCadastroRapidoWMS   := cdsItens.FieldByName('CODIGO').AsString;
    frmCadLoteItens.strDataValidadeCadastroRapidoWMS := DateToStr(VS_Date);
    frmCadLoteItens.tipoCadastro := tclOrdemProducaoIndustrial;
    frmCadLoteItens.ShowModal;

    strLotCad := frmCadLoteItens.strNumeroLoteCadastroRapidoWMS;

    If Not fEmptyStr(strLotCad) Then
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('NUMERO_LOTE').AsString := strLotCad;
      cdsItens.Post;
    End;
  finally
    if Assigned(frmCadLoteItens) then
      pFreeAndNil(frmCadLoteItens);
  end;
end;

procedure TfrmItensSemLote.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_F1 then
    btnCadastroRapidoLote.Click();
end;

procedure TfrmItensSemLote.FormShow(Sender: TObject);
begin
  inherited;
  dtsItensSemLote.DataSet := cdsItens;
end;

end.
