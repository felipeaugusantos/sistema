unit untRelFatVendasItensF9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, DB,
  EditFocus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmRelFatVendasItensF9 = class(TfrmPai)
    pnlTopo: TPanel;                              
    lblProduto: TLabel;
    dtsRelVenCli: TDataSource;
    dbgItens: TcxGrid;
    dbgItensDBTableView1: TcxGridDBTableView;
    DTAENT: TcxGridDBColumn;
    NOMCLI: TcxGridDBColumn;
    NUMDOC: TcxGridDBColumn;
    QTDITE: TcxGridDBColumn;
    UNITAR: TcxGridDBColumn;
    TOTITE: TcxGridDBColumn;
    TOTGER: TcxGridDBColumn;
    TOTIPI: TcxGridDBColumn;
    TOTCUS: TcxGridDBColumn;
    MARGEM: TcxGridDBColumn;
    dbgItensLevel1: TcxGridLevel;
    btnDocCom: TBitBtnLocked;
    CODVEN: TcxGridDBColumn;
    NOMVEN: TcxGridDBColumn;
    CODCLI: TcxGridDBColumn;
    DOCORI: TcxGridDBColumn;
    NUMFAT: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dbgItensDBTableView1DataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure btnDocComClick(Sender: TObject);
  private
    strTotalMargem: String;
    FOpcaoImpressao: Boolean;

    procedure pAtulizaTotalMargem;
    { Private declarations }
  public
    { Public declarations }
    blnSelDocumentos: Boolean;
    pMostraDocumentoReimpressao: TMostraDocumentoReimpressao;

    property blnOpcaoImpressao: Boolean read FOpcaoImpressao write FOpcaoImpressao;
  end;


implementation

uses
 untIFuncoes, untRelFatVendasCliente, untFuncoesSimples, StrUtils;

{$R *.dfm}

procedure TfrmRelFatVendasItensF9.FormShow(Sender: TObject);
begin
  inherited;

  (dtsRelVenCli.DataSet.FieldByName('TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
  (dtsRelVenCli.DataSet.FieldByName('UNITAR') As TFloatField).DisplayFormat := '#,##0.00';
  (dtsRelVenCli.DataSet.FieldByName('QTDITE') As TFloatField).DisplayFormat := '#,##0.00';
  (dtsRelVenCli.DataSet.FieldByName('TOTCUS') As TFloatField).DisplayFormat := '#,##0.00';
  (dtsRelVenCli.DataSet.FieldByName('MARGEM') As TFloatField).DisplayFormat := '#,##0.00';
  (dtsRelVenCli.DataSet.FieldByName('TOTIPI') As TFloatField).DisplayFormat := '#,##0.00';
  (dtsRelVenCli.DataSet.FieldByName('TOTGER') As TFloatField).DisplayFormat := '#,##0.00';

  If frmRelFatVendasCliente.blnConsultaItem Then
  Begin
    If Not blnSelDocumentos Then
      lblProduto.Caption := 'Produto: ' + dtsRelVenCli.DataSet.FieldByName('CODITE').AsString + '-' + dtsRelVenCli.DataSet.FieldByName('DESCRI').AsString;

    {******************************************************}
    {* CONFIGURA AS COLUNAS Q SÃO VARIÁVEIS DE ACORDO COM *}
    {* A CHAMADA QUE FOI FEITA                            *}
    {**************************************************ER**}
    dbgItensDBTableView1.GetColumnByFieldName('NOMCLI').Caption := 'Nome Cliente';
    dbgItensDBTableView1.GetColumnByFieldName('NOMCLI').DataBinding.FieldName := 'NOMCLI';
    dbgItensDBTableView1.GetColumnByFieldName('CODCLI').Visible := True;
  End
  Else
  Begin
    dbgItensDBTableView1.GetColumnByFieldName('CODCLI').Visible := False;
  End;

  dbgItensDBTableView1.GetColumnByFieldName('NUMFAT').Visible := fCfgSis('MOSMCL') <> '3';

  If (Not fCfgSis('MARFAT', varBoolean)) Or (blnSelDocumentos)Then
  Begin
    dbgItensDBTableView1.GetColumnByFieldName('TOTCUS').Visible := False;
    dbgItensDBTableView1.GetColumnByFieldName('MARGEM').Visible := False;
  End
  Else
  Begin
    pAtulizaTotalMargem;
  End;

  If fVerificaAcessoSistema('VERTOTITENSVEND', strLoginUsuarioLogado) Then
  Begin
    dbgItensDBTableView1.GetColumnByFieldName('TOTITE').Visible := True;
    dbgItensDBTableView1.GetColumnByFieldName('TOTIPI').Visible := True;
    dbgItensDBTableView1.GetColumnByFieldName('TOTGER').Visible := True;
  End
  Else
  Begin
    dbgItensDBTableView1.GetColumnByFieldName('TOTITE').Visible := False;
    dbgItensDBTableView1.GetColumnByFieldName('TOTIPI').Visible := False;
    dbgItensDBTableView1.GetColumnByFieldName('TOTGER').Visible := False;
  End;

  dbgItensDBTableView1.ApplyBestFit;

  btnDocCom.Visible := Assigned(pMostraDocumentoReimpressao);

end;

{************************************}
{* ATUALIZA O TOTAL DO DESCONTO,    *}
{* MARGEM CUSTO E GERAL             *}
{*********************************AF*}
procedure TfrmRelFatVendasItensF9.pAtulizaTotalMargem;
  Var
    fltValIte,
    fltValMkp,
    fltTotCus: Double;
Begin
  fltValIte := 0;
  fltTotCus := 0;
  fltValMkp := 0;

  With dtsRelVenCli.DataSet Do
  Begin
    While Not Eof Do
    Begin
      fltValIte := fltValIte + FieldByName('TOTITE').AsFloat;
      fltTotCus := fltTotCus + FieldByName('TOTCUS').AsFloat;
      fltValMkp := fltValMkp + FieldByName('MAMKP4').AsFloat;

      Edit;
      If fCfgSis('MARMKP') = '4' Then
        FieldByName('MARGEM').AsFloat  := fCalculaPrecoVenda(2,FieldByName('TOTCUS').AsFloat,(FieldByName('MAMKP4').AsFloat),0,0,0,0,0)
      Else
        FieldByName('MARGEM').AsFloat  := fCalculaPrecoVenda(2,FieldByName('TOTCUS').AsFloat,(FieldByName('TOTITE').AsFloat),0,0,0,0,0);
      Post;

      Next;
    End;
  End;

  If fCfgSis('MARMKP') = '4' Then
    strTotalMargem := FloatToStrF(fCalculaPrecoVenda(2, fltTotCus, fltValMkp, 0,0,0,0,0), ffFixed,12,2)
  Else
    strTotalMargem := FloatToStrF(fCalculaPrecoVenda(2, fltTotCus, fltValIte, 0,0,0,0,0), ffFixed,12,2);

  dbgItensDBTableView1.DataController.Summary.Recalculate;
End;

procedure TfrmRelFatVendasItensF9.btnDocComClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaAcessoSistema('ITENVEND', strLoginUsuarioLogado) Then
  Begin
    pMensagemOk('Operador não tem direito de acesso para visualizar documento!');
    Exit;
  End;

  If Not btnDocCom.Visible Then
    Exit;

  If Not Assigned(pMostraDocumentoReimpressao) Then
    Exit;

  With dtsRelVenCli.DataSet Do
  Begin
    If fDevolucaoNaoFoiEmitidaPeloAutcom(LeftStr(FieldByName('NUMDOC').AsString, 12),
                                         FieldByName('ESPDOC').AsString,
                                         FieldByName('CODEMP').AsString,
                                         FieldByName('CODCLI').AsString) Then
    Begin
      pMensagemOk('O documento '+ LeftStr(FieldByName('NUMDOC').AsString, 12) +'-'+ FieldByName('ESPDOC').AsString +'-'+ FieldByName('CODEMP').AsString +
                  ' é uma devolução que não foi emitida pelo Autcom. '+
                  'Esta entrada foi feita através da rotina "Entrada de Mercadorias - Devolução". '+
                  'Portanto, para ver o documento, acesse: "Relatórios > Relatórios de Estoque > Espelho de Nota de Devolução (Entrada).');
      Exit;
    End;

    pMostraDocumentoReimpressao(LeftStr(FieldByName('NUMDOC').AsString, 12),
                                FieldByName('ESPDOC').AsString,
                                FieldByName('CODEMP').AsString,
                                '',
                                FieldByName('CODCLI').AsString,
                                '',
                                True,
                                FOpcaoImpressao);
  End;

end;

procedure TfrmRelFatVendasItensF9.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_Escape Then
    btnSair.Click
  Else
  If (Key = VK_F5) Then
    btnDocCom.Click;

end;

procedure TfrmRelFatVendasItensF9.dbgItensDBTableView1DataControllerSummaryAfterSummary(
  ASender: TcxDataSummary);
var
  SummFooterIdx: Integer;
begin
  inherited;

  If Not fEmptyStr(strTotalMargem) Then
  Begin
    SummFooterIdx := ASender.FooterSummaryItems.IndexOfItemLink(dbgItensDBTableView1.GetColumnByFieldName('MARGEM'));
     If (SummFooterIdx > -1) Then
    ASender.FooterSummaryValues[SummFooterIdx] := strTotalMargem;
  End;
end;

procedure TfrmRelFatVendasItensF9.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If dtsRelVenCli.DataSet.Active Then
    dtsRelVenCli.DataSet.Close;
end;

procedure TfrmRelFatVendasItensF9.FormCreate(Sender: TObject);
begin
  inherited;

  blnSelDocumentos := False;
  strTotalMargem   := '';
end;

end.

