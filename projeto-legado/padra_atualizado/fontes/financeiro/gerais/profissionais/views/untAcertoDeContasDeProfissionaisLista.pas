unit untAcertoDeContasDeProfissionaisLista;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, untPai, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCurrencyEdit, cxImageComboBox, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid, untTAcertoDeContasDeProfissionais, UniClientDataset, EditFocus;

type
  TfrmAcertoDeContasDeProfissionaisLista = class(TfrmPai)
    pnlFundo: TPanel;
    grdListaComissoes: TcxGridCitel;
    grdListaComissoesDados: TcxGridDBTableViewCitel;
    grdListaComissoesNivel: TcxGridLevel;
    dtsListaComissoes: TDataSource;
    grdListaComissoesDadosCOM_CODCOM: TcxGridDBColumn;
    grdListaComissoesDadosCONTASARECEBER: TcxGridDBColumn;
    grdListaComissoesDadosCOM_VRVEND: TcxGridDBColumn;
    grdListaComissoesDadosCOM_VRCOMI: TcxGridDBColumn;
    grdListaComissoesDadosCOM_DTACAD: TcxGridDBColumn;
    grdListaComissoesDadosCOM_CREDEB: TcxGridDBColumn;
    grdListaComissoesDadosCLI_NOMCLI: TcxGridDBColumn;
    grdListaComissoesDadosVENDEDOR: TcxGridDBColumn;
    pnlTotais: TPanel;
    Label21: TLabel;
    Label6: TLabel;
    edtQtdComissoes: TEditFocus;
    edtValorTotal: TEditFocus;
    procedure FormShow(Sender: TObject);
  private
    FDatasetLista: TUniClientDataset;

    FObjetoFiltros: TCamposFiltroTela;

    FCodigoProfissional: String;

    procedure CriaTemporaria;
    { Private declarations }
  public
    property ObjetoFiltros: TCamposFiltroTela read FObjetoFiltros write FObjetoFiltros;
    property CodigoProfissional: String read FCodigoProfissional write FCodigoProfissional;
    { Public declarations }
  end;

var
  frmAcertoDeContasDeProfissionaisLista: TfrmAcertoDeContasDeProfissionaisLista;

implementation
Uses untGravando, untFuncoesSimples;
{$R *.dfm}

procedure TfrmAcertoDeContasDeProfissionaisLista.CriaTemporaria;
begin
  FDatasetLista := TAcertoDeContasDeProfissionais.Create.RetornaDadosComissoesEmAberto(FObjetoFiltros,
                                                                                       FCodigoProfissional);

  dtsListaComissoes.Dataset := FDatasetLista;

  edtQtdComissoes.Text := VarToStr(grdListaComissoesDados.DataController.Summary.FooterSummaryValues[1]);
  edtValorTotal.Text := FormatFloat(',0.00;-0.00', fStrToFloat(VarToStr(grdListaComissoesDados.DataController.Summary.FooterSummaryValues[0])));
end;

procedure TfrmAcertoDeContasDeProfissionaisLista.FormShow(Sender: TObject);
begin
  inherited;

  TfrmGravando.fExecutarModal(CriaTemporaria,'Aguarde... Carregando Comissões em Aberto.','');
end;

end.
