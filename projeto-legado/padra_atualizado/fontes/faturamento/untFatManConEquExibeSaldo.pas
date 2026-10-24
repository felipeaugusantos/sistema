unit untFatManConEquExibeSaldo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit, cxTextEdit,
  cxButtonEdit, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxVGrid, cxInplaceContainer, Vcl.ComCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untConsertoEquipamento, cxClasses;

type
  TfrmFatManConEquExibeSaldo = class(TfrmPaiConfirma)
    pgcSaldos: TPageControl;
    tbsSaldos: TTabSheet;
    tbsSaldosML: TTabSheet;
    cxsGrid: TcxStyleRepository;
    cxsSaldos: TcxStyle;
    cxsSaldosDisponivel: TcxStyle;
    cxsSaldosML: TcxStyle;
    cxsSaldosCD: TcxStyle;
    cxsSaldosCDML: TcxStyle;
    cxsSaldosMLDisponivel: TcxStyle;
    cxsSaldosCDDisponivel: TcxStyle;
    cxsSaldosCDMLDisponivel: TcxStyle;
    cxsValorDisponivel: TcxStyle;
    cxvSaldos: TcxVerticalGrid;
    cxvEstFisico: TcxEditorRow;
    cxvGarantia: TcxEditorRow;
    cxvPedidoVenda: TcxEditorRow;
    cxvEnderecamento: TcxEditorRow;
    cxvExterno: TcxEditorRow;
    cxvOrdemProducao: TcxEditorRow;
    cxvEntFutPrevisao: TcxEditorRow;
    cxvEntFutFalta: TcxEditorRow;
    cxvEntFutAguarda: TcxEditorRow;
    cxvDisponivel: TcxEditorRow;
    cxvPedidoCompra: TcxEditorRow;
    cxvTransfEstAndamento: TcxEditorRow;
    cxvPedidoBaixaEntregaFutura: TcxEditorRow;
    cxvSaldosML: TcxVerticalGrid;
    cxvEstFisicoML: TcxEditorRow;
    cxvGarantiaML: TcxEditorRow;
    cxvPedidoVendaML: TcxEditorRow;
    cxvEnderecamentoML: TcxEditorRow;
    cxvExternoML: TcxEditorRow;
    cxvEntFutPrevisaoML: TcxEditorRow;
    cxvEntFutFaltaML: TcxEditorRow;
    cxvEntFutAguardaML: TcxEditorRow;
    cxvDisponivelML: TcxEditorRow;
    cxvPedidoCompraML: TcxEditorRow;
    cxvTransfEstAndamentoML: TcxEditorRow;
    cxvOrdemProducaoML: TcxEditorRow;
    cxvPedidoBaixaEntregaFuturaML: TcxEditorRow;
    procedure cxvGarantiaEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxvSaldosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    intDecUni,
    intIdxCol,
    intCalSal: Integer;
    blnPDCPRO,
    blnUsaPDV,
    blnOrdPro,
    blnEntFut,
    blnEstExt: Boolean;
    procedure pChamaRelatorio(Sender: TObject);
    procedure pCarregaSaldos;
    procedure pOrdemInicial;
    procedure pSetVisible(cxg: TcxEditorRow; bln: Boolean);
    procedure pSetIndex(cxg: TcxEditorRow); overload;
    procedure pSetIndex(cxg: TcxEditorRow; const intIdx : Integer); overload;
    function fAjustarPosicaoEstoqueExterno : Boolean;
    procedure pAjustarPosicaoEstoqueExterno;
  public
    { Public declarations }
    objConEqu: TConEqu;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untFuncoesRel;

procedure TfrmFatManConEquExibeSaldo.cxvGarantiaEditPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  pChamaRelatorio(Sender);
end;

procedure TfrmFatManConEquExibeSaldo.cxvSaldosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key Of
    VK_ESCAPE: Close;
  end;
end;

function TfrmFatManConEquExibeSaldo.fAjustarPosicaoEstoqueExterno: Boolean;
begin
  Result := False;

  If (fCfgSis('MOVFUL', varString) <> '2') Then
    Exit;

  Result := cxvExternoML.Index < cxvDisponivelML.Index;
end;

procedure TfrmFatManConEquExibeSaldo.FormCreate(Sender: TObject);
Begin
  inherited;
  intDecUni := fCfgSis('DECUNI', varInteger);
  blnPDCPRO := fCfgSis('PDCPRO', VarBoolean);
  intCalSal := fCfgSis('CALSAL', varInteger);
  blnUsaPDV := fCfgSis('USAPDV', varBoolean);
  blnOrdPro := fCfgSis('ORDPRO', varBoolean);
  blnEntFut := fCfgSis('ENTFUT', varBoolean);
  blnEstExt := fCfgSis('ESTEXT', varBoolean);
end;

procedure TfrmFatManConEquExibeSaldo.FormShow(Sender: TObject);
begin
  inherited;
  Self.Caption := 'Estoque do Item ' + objConEqu.cdsIteEqu.FieldByName('CODITE').AsString + ' - ' +
    objConEqu.cdsIteEqu.FieldByName('DESITE').AsString;

  pOrdemInicial;

//  pSetVisible(cxvPedidoCompra, blnPDCPRO);

  pSetVisible(cxvEntFutPrevisao,           blnEntFut);
  pSetVisible(cxvEntFutFalta,              blnEntFut);
  pSetVisible(cxvEntFutAguarda,            blnEntFut);

  pSetVisible(cxvPedidoVenda,   blnUsaPDV);
  pSetVisible(cxvEnderecamento, blnUsaPDV);
  pSetVisible(cxvOrdemProducao, blnUsaPDV And blnOrdPro);

  pSetVisible(cxvPedidoBaixaEntregaFutura, blnEntFut And fReservaSaldoPedidosBaixaEntregaFutura);

  if blnEstExt then
    pgcSaldos.Height := pgcSaldos.Height + cxvSaldos.OptionsView.RowHeight;

  If Not blnPDCPRO Then
    pgcSaldos.Height := pgcSaldos.Height - cxvSaldos.OptionsView.RowHeight;

  If Not blnEntFut Then
    pgcSaldos.Height := pgcSaldos.Height - (3 * cxvSaldos.OptionsView.RowHeight);

  If Not cxvPedidoBaixaEntregaFutura.Visible Then
    pgcSaldos.Height := pgcSaldos.Height - cxvSaldos.OptionsView.RowHeight;

  If Not blnUsaPDV Then
    pgcSaldos.Height := pgcSaldos.Height - (3 * cxvSaldos.OptionsView.RowHeight)

  Else If Not blnOrdPro Then
    pgcSaldos.Height := pgcSaldos.Height - cxvSaldos.OptionsView.RowHeight;

  tbsSaldosML.TabVisible   := False;

  pCarregaSaldos;
end;

procedure TfrmFatManConEquExibeSaldo.pAjustarPosicaoEstoqueExterno;
begin
  If (Not fAjustarPosicaoEstoqueExterno) Then
    Exit;

  cxvExternoML.Index := cxvDisponivelML.Index + 1;
  cxvExternoML.Properties.Caption := 'Estoque Externo';
end;

procedure TfrmFatManConEquExibeSaldo.pCarregaSaldos;
var
  fltSaldoDisp,
  fltSalResTot: Double;
Begin
  objConEqu.fRetornaSaldoDisponivel(objConEqu.cdsIteEqu.FieldByName('CODITE').AsString,
    IIF(objConEqu.blnMulLoj, objConEqu.cdsIteEqu.FieldByName('EMPITE').AsString, VS_strCodEmp), fltSaldoDisp, fltSalResTot);

  cxvEntFutPrevisao.Properties.Value := FormatFloat('#,##0.000', objConEqu.recSaldos.fltEntPre);
  cxvEntFutFalta.Properties.Value    := FormatFloat('#,##0.000', objConEqu.recSaldos.fltEntFal);
  cxvEntFutAguarda.Properties.Value  := FormatFloat('#,##0.000', objConEqu.recSaldos.fltEntAgu);
  cxvEstFisico.Properties.Value      := FormatFloat('#,##0.000', objConEqu.recSaldos.fltEstFis);
  cxvPedidoVenda.Properties.Value    := FormatFloat('#,##0.000', objConEqu.recSaldos.fltSalPed);
  cxvEnderecamento.Properties.Value  := FormatFloat('#,##0.000', objConEqu.recSaldos.fltSalEnd);
  cxvOrdemProducao.Properties.Value  := FormatFloat('#,##0.000', objConEqu.recSaldos.fltSalOrd);
  cxvGarantia.Properties.Value       := FormatFloat('#,##0.000', objConEqu.recSaldos.fltSalGar);
  cxvDisponivel.Properties.Value     := FormatFloat('#,##0.000', objConEqu.recSaldos.fltSalDis);

//  If blnPDCPRO And fValidaCampos(['QTD_PEDCOM']) Then
//    cxvPedidoCompra.Properties.Value := FormatFloat('#,##0.000', GetCampoItem('QTD_PEDCOM').AsFloat)
//  Else
//    cxvPedidoCompra.Properties.Value := '';

  cxvTransfEstAndamento.Properties.Value  := FormatFloat('#,##0.000', objConEqu.recSaldos.fltTraEst);
  cxvExterno.Properties.Value             := FormatFloat('#,##0.000', objConEqu.recSaldos.fltSalExt);
  cxvPedidoBaixaEntregaFutura.Properties.Value := FormatFloat('#,##0.000', objConEqu.recSaldos.fltSdPdBf);

  cxvEntFutPrevisaoML.Properties.Value := FormatFloat('#,##0.000', objConEqu.recSaldosML.fltEntPre);
  cxvEntFutFaltaML.Properties.Value    := FormatFloat('#,##0.000', objConEqu.recSaldosML.fltEntFal);
  cxvEntFutAguardaML.Properties.Value  := FormatFloat('#,##0.000', objConEqu.recSaldosML.fltEntAgu);
  cxvEstFisicoML.Properties.Value      := FormatFloat('#,##0.000', objConEqu.recSaldosML.fltEstFis);
  cxvPedidoVendaML.Properties.Value    := FormatFloat('#,##0.000', objConEqu.recSaldosML.fltSalPed);
  cxvEnderecamentoML.Properties.Value  := FormatFloat('#,##0.000', objConEqu.recSaldosML.fltSalEnd);
  cxvOrdemProducaoML.Properties.Value  := FormatFloat('#,##0.000', objConEqu.recSaldosML.fltSalOrd);
  cxvGarantiaML.Properties.Value       := FormatFloat('#,##0.000', objConEqu.recSaldosML.fltSalGar);
  cxvDisponivelML.Properties.Value     := FormatFloat('#,##0.000', objConEqu.recSaldosML.fltSalDis);

//  If blnPDCPRO And fValidaCampos(['QTD_PEDCOM']) Then
//    cxvPedidoCompraML.Properties.Value := FormatFloat('#,##0.000', GetCampoItem('QTD_PEDCOM').AsFloat *
//                IIF(fValidaCampos(['ITE_CNV_ML']), GetCampoItem('ITE_CNV_ML').asFloat, 1))
//  Else
//     cxvPedidoCompraML.Properties.Value := '';

  cxvTransfEstAndamentoML.Properties.Value  := FormatFloat('#,##0.000', objConEqu.recSaldosML.fltTraEst);
  cxvExternoML.Properties.Value             := FormatFloat('#,##0.000', objConEqu.recSaldosML.fltSalExt);
end;

procedure TfrmFatManConEquExibeSaldo.pChamaRelatorio(Sender: TObject);
var
  strCodIte,
  strCodEmp: String;
  intCodAta: Integer;
begin
  If Not Assigned(prcExecutaRelatorio) Then
    Exit;

  strCodEmp := VS_strCodEmp;
  strCodIte := objConEqu.cdsIteEqu.FieldByName('CODITE').AsString;

  If pgcSaldos.ActivePage = tbsSaldos Then
  Begin

    If Not Assigned(cxvSaldos.FocusedRow) Then
      cxvEstFisico.Focused := True;

    intCodAta := cxvSaldos.FocusedRow.Tag;
  End
  Else
  Begin
    If Not Assigned(cxvSaldosML.FocusedRow) Then
      cxvEstFisicoML.Focused := True;

    intCodAta := cxvSaldosML.FocusedRow.Tag;
  End;

  If intCodAta = 0 Then
    Exit;

  prcExecutaRelatorio(intCodAta, 0,
                     [],
                     ['CODITE', 'CODEMP'],
                     [strCodIte, strCodEmp],
                      Sender,
                     ['CODITE', 'CODEMP'],
                     True);
end;

procedure TfrmFatManConEquExibeSaldo.pOrdemInicial;
begin
  intIdxCol := -1;

  pSetIndex(cxvEstFisico);
  pSetIndex(cxvGarantia);
  pSetIndex(cxvPedidoVenda);

  pSetIndex(cxvPedidoBaixaEntregaFutura);

  pSetIndex(cxvEnderecamento);

  If (fCfgSis('MOVFUL', varString) = '1') Then
    pSetIndex(cxvExterno);

  pSetIndex(cxvOrdemProducao);

  Case intCalSal Of
    1: Begin
         pSetIndex(cxvDisponivel);

         pSetIndex(cxvEntFutPrevisao);
         pSetIndex(cxvEntFutFalta);
         pSetIndex(cxvEntFutAguarda);
       End;
    2: Begin
         If fCfgSis('BEFTRG', VarBoolean) Then
         Begin
           pSetIndex(cxvDisponivel);

           pSetIndex(cxvEntFutPrevisao);
           pSetIndex(cxvEntFutFalta);
           pSetIndex(cxvEntFutAguarda);
         End
         Else
         Begin
           pSetIndex(cxvEntFutPrevisao);
           pSetIndex(cxvEntFutFalta);
           pSetIndex(cxvEntFutAguarda);

           pSetIndex(cxvDisponivel);
         End;
       End;
    3: Begin
         pSetIndex(cxvEntFutPrevisao);
         pSetIndex(cxvEntFutAguarda);

         pSetIndex(cxvDisponivel);

         pSetIndex(cxvEntFutFalta);
       End;
    4: Begin
         pSetIndex(cxvEntFutFalta);

         pSetIndex(cxvDisponivel);

         pSetIndex(cxvEntFutPrevisao);
         pSetIndex(cxvEntFutAguarda);
       End;
    5: Begin
         pSetIndex(cxvEntFutPrevisao);

         pSetIndex(cxvDisponivel);

         pSetIndex(cxvEntFutAguarda);
         pSetIndex(cxvEntFutFalta);
       End;
  End;

  If (fCfgSis('MOVFUL', varString) = '2') Then
  Begin
    cxvExterno.Properties.Caption := 'Estoque Externo';
    cxvExternoML.Properties.Caption := 'Estoque Externo';
    pSetIndex(cxvExterno, cxvDisponivel.Index + 1);
    pAjustarPosicaoEstoqueExterno;
  End;

  pSetIndex(cxvPedidoCompra);
  pSetIndex(cxvTransfEstAndamento);
end;

procedure TfrmFatManConEquExibeSaldo.pSetIndex(cxg: TcxEditorRow);
begin
  Inc(intIdxCol);

  cxg.Index := intIdxCol;
  TcxEditorRow(Self.FindComponent(cxg.Name+'ML')).Index := intIdxCol;
end;

procedure TfrmFatManConEquExibeSaldo.pSetIndex(cxg: TcxEditorRow; const intIdx: Integer);
begin
  Inc(intIdxCol);

  cxg.Index := intIdx;
  TcxEditorRow(Self.FindComponent(cxg.Name+'ML')).Index := intIdx;
end;

procedure TfrmFatManConEquExibeSaldo.pSetVisible(cxg: TcxEditorRow; bln: Boolean);
begin
  cxg.Visible := bln;
  TcxEditorRow(Self.FindComponent(cxg.Name+'ML')).Visible := bln
end;

end.
