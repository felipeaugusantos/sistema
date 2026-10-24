unit untDemostrativoBaseCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxEdit, cxTextEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxVGrid,
  cxInplaceContainer, cxClasses, DB,
  untFuncoesPedidoSimples, cxCurrencyEdit, EditFocus;

type
  TfrmDemostrativoBaseCompra = class(TfrmPaiConfirma)
    cxsGrid: TcxStyleRepository;
    cxsSaldosBas: TcxStyle;
    cxsSaldosBasCompra: TcxStyle;
    cxsSaldosDisp: TcxStyle;
    cxsValorDisponivel: TcxStyle;
    cxvSaldos: TcxVerticalGrid;
    cxvEstFisico: TcxEditorRow;
    cxvGarantia: TcxEditorRow;
    cxvPedidoVenda: TcxEditorRow;
    cxvEnderecamento: TcxEditorRow;
    cxvOrdemProducao: TcxEditorRow;
    cxvEntFutPrevisao: TcxEditorRow;
    cxvEntFutFalta: TcxEditorRow;
    cxvEntFutAguarda: TcxEditorRow;
    cxvDisponivel: TcxEditorRow;
    cxvPedidoCompra: TcxEditorRow;
    cxvVendasPerdidas: TcxEditorRow;
    cxvTransferencias: TcxEditorRow;
    cxvCotacao: TcxEditorRow;
    cxvSaldosTitulo: TcxCategoryRow;
    cxvSaldosDisp: TcxVerticalGrid;
    cxCategoryRow1: TcxCategoryRow;
    cxvEstFisicoDisp: TcxEditorRow;
    cxvGarantiaDisp: TcxEditorRow;
    cxvPedidoVendaDisp: TcxEditorRow;
    cxvOrdemProducaoDisp: TcxEditorRow;
    cxvEntFutPrevisaoDisp: TcxEditorRow;
    cxvEntFutFaltaDisp: TcxEditorRow;
    cxvEntFutAguardaDisp: TcxEditorRow;
    cxvSaldoExternoDisp: TcxEditorRow;
    cxvDisponivelDisp: TcxEditorRow;
    cxvEnderecamentoDisp: TcxEditorRow;
    cxvPedidoCompraDisp: TcxEditorRow;
    cxsSaldosDispCompra: TcxStyle;
    Panel1: TPanel;
    Label5: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    cxvSaldosSaldoRequisicao: TcxEditorRow;
    cxvSaldoExterno: TcxEditorRow;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    intCalSal: Integer;
    blnOrdPro,
    blnSalExt,
    blnEntFut: Boolean;

    Procedure pAjustaSaldoDisponivel;

  public
    { Public declarations }
    cdsItens: TDataSet;
    recOpcGir: TRecOpcoesGiro;
    blnComGiro: Boolean;

    Class Procedure pDesmonstra(cdsItens: TDataSet; recOpcGir: TRecOpcoesGiro; blnComGiro: Boolean);
  end;

implementation

{$R *.dfm}

Uses
  StrUtils,
  untFuncoesSimples;

procedure TfrmDemostrativoBaseCompra.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
end;

procedure TfrmDemostrativoBaseCompra.FormShow(Sender: TObject);
begin
  inherited;

  intCalSal := fCfgSis('CALSAL', varInteger);
  blnOrdPro := fCfgSis('ORDPRO', varBoolean);
  blnEntFut := fCfgSis('ENTFUT', varBoolean);
  blnSalExt := fCfgSis('ESTEXT', varBoolean);
  cxvSaldoExternoDisp.VIsible   := blnSalExt;
  cxvSaldoExterno.Visible := blnSalExt;

  cxvOrdemProducao.Visible  := blnOrdPro;
  cxvEntFutPrevisao.Visible := blnEntFut;
  cxvEntFutFalta.Visible    := blnEntFut;
  cxvEntFutAguarda.Visible  := blnEntFut;

  With cdsItens Do
  Begin
    edtCodIte.Text := FieldByName('ITE_CODITE').AsString;
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;

    edtCodEmp.Text := FieldByName('ITE_CODEMP').AsString;
    edtNomEmp.Text := FieldByName('ITE_DESEMP').AsString;

    lblEmpresa.Visible := recOpcGir.strPedMlj = 'S';
    edtCodEmp.Visible  := recOpcGir.strPedMlj = 'S';
    edtNomEmp.Visible  := recOpcGir.strPedMlj = 'S';

    cxvEstFisico.Properties.Value      := FormatFloat('#,##0.000', FieldByName('ITE_SALFIS').AsFloat);
    cxvGarantia.Properties.Value       := FormatFloat('#,##0.000', FieldByName('ITE_SALGAR').AsFloat);
    cxvPedidoVenda.Properties.Value    := FormatFloat('#,##0.000', FieldByName('ITE_SALRES').AsFloat);
    cxvEnderecamento.Properties.Value  := FormatFloat('#,##0.000', FieldByName('ITE_SALEND').AsFloat);
    cxvOrdemProducao.Properties.Value  := FormatFloat('#,##0.000', FieldByName('ITE_QTPD_P').AsFloat);
    cxvEntFutPrevisao.Properties.Value := FormatFloat('#,##0.000', FieldByName('ITE_QTEF_P').AsFloat);
    cxvEntFutFalta.Properties.Value    := FormatFloat('#,##0.000', FieldByName('ITE_QTEF_F').AsFloat);
    cxvEntFutAguarda.Properties.Value  := FormatFloat('#,##0.000', FieldByName('ITE_QTEF_A').AsFloat);
    cxvDisponivel.Properties.Value     := FormatFloat('#,##0.000', FieldByName('ITE_SALBAS').AsFloat);
    cxvPedidoCompra.Properties.Value   := FormatFloat('#,##0.000', FieldByName('ITE_QTDPEN').AsFloat);
    cxvSaldoExterno.Properties.Value   := FormatFloat('#,##0.000', FieldByName('ITE_SALEXT').AsFloat);

    cxvSaldosSaldoRequisicao.Properties.Value   := FormatFloat('#,##0.000', FieldByName('ITE_SALREQ').AsFloat);

    cxvVendasPerdidas.Properties.Value := FormatFloat('#,##0.000', FieldByName('ITE_VENPER').AsFloat);
    cxvTransferencias.Properties.Value := FormatFloat('#,##0.000', FieldByName('ITE_SALTRA').AsFloat);
    cxvCotacao.Properties.Value        := FormatFloat('#,##0.000', FieldByName('ITE_SALCOT').AsFloat);
  End;

  If Not recOpcGir.blnConsCot Then
  Begin
    cxvCotacao.Index := (cxvEnderecamento.Index);
    cxvCotacao.Properties.Caption := Copy(cxvCotacao.Properties.Caption, 1, Length(cxvCotacao.Properties.Caption) - 3);
  End;

  If Not recOpcGir.blnConsTransf Then
  Begin
    cxvTransferencias.Index := (cxvEnderecamento.Index);
    cxvTransferencias.Properties.Caption := Copy(cxvTransferencias.Properties.Caption, 1, Length(cxvTransferencias.Properties.Caption) - 3);
  End;

  If Not recOpcGir.blnVenPer Then
  Begin
    cxvVendasPerdidas.Index := (cxvEnderecamento.Index);
    cxvVendasPerdidas.Properties.Caption := Copy(cxvVendasPerdidas.Properties.Caption, 1, Length(cxvVendasPerdidas.Properties.Caption) - 3);
  End;

 // If intCalSal In [1, 4, 5] Then
  If (Not recOpcGir.blnEntFutAguarda) Then
  Begin
    cxvEntFutAguarda.Index := (cxvEnderecamento.Index);
    cxvEntFutAguarda.Properties.Caption := Copy(cxvEntFutAguarda.Properties.Caption, 1, Length(cxvEntFutAguarda.Properties.Caption) - 3);
  End;

//  If intCalSal In [1, 3, 5] Then
  If (Not recOpcGir.blnEntFutFalta) Then
  Begin
    cxvEntFutFalta.Index := (cxvEnderecamento.Index);
    cxvEntFutFalta.Properties.Caption := Copy(cxvEntFutFalta.Properties.Caption, 1, Length(cxvEntFutFalta.Properties.Caption) - 3);
  End;

//  If intCalSal In [1, 4] Then
  If (Not recOpcGir.blnEntFutPrevisao) Then
  Begin
    cxvEntFutPrevisao.Index := (cxvEnderecamento.Index);
    cxvEntFutPrevisao.Properties.Caption := Copy(cxvEntFutPrevisao.Properties.Caption, 1, Length(cxvEntFutPrevisao.Properties.Caption) - 3);
  End;

  If (Not recOpcGir.blnConsRequisicao) Then
  Begin
    cxvSaldosSaldoRequisicao.Index := (cxvEnderecamento.Index);
    cxvSaldosSaldoRequisicao.Properties.Caption := Copy(cxvSaldosSaldoRequisicao.Properties.Caption, 1, Length(cxvSaldosSaldoRequisicao.Properties.Caption) - 3);
  End
  Else
    cxvSaldosSaldoRequisicao.Index := (cxvDisponivel.Index);

  If (Not recOpcGir.blnConsOrdPro) And blnComGiro Then
  Begin
    cxvOrdemProducao.Index := (cxvEnderecamento.Index);
    cxvOrdemProducao.Properties.Caption := Copy(cxvOrdemProducao.Properties.Caption, 1, Length(cxvOrdemProducao.Properties.Caption) - 3);
  End;

  If (Not recOpcGir.blnConsPedVen) And blnComGiro  Then
  Begin
    cxvPedidoVenda.Index := (cxvDisponivel.Index);
    cxvPedidoVenda.Properties.Caption := Copy(cxvPedidoVenda.Properties.Caption, 1, Length(cxvPedidoVenda.Properties.Caption) - 3);
  End;

  If (recOpcGir.blnDescSalExt) Then
  begin
    cxvSaldoExterno.Index := (cxvDisponivel.Index);
    cxvPedidoVenda.Properties.Caption := cxvPedidoVenda.Properties.Caption+'(-)';
  End;

  If (Not recOpcGir.blnConsGarPen) And blnComGiro  Then
  Begin
    cxvGarantia.Index := (cxvDisponivel.Index);
    cxvGarantia.Properties.Caption := Copy(cxvGarantia.Properties.Caption, 1, Length(cxvGarantia.Properties.Caption) - 3);
  End;

  If (Not recOpcGir.blnConsPedPen) Or (Not blnComGiro) Then
  Begin
    cxvPedidoCompra.Index := (cxvDisponivel.Index);
    cxvPedidoCompra.Properties.Caption := Copy(cxvPedidoCompra.Properties.Caption, 1, Length(cxvPedidoCompra.Properties.Caption) - 3);
  End;

  pAjustaSaldoDisponivel;

  With cdsItens Do
  Begin
    cxvEstFisicoDisp.Properties.Value      := FormatFloat('#,##0.000', FieldByName('ITE_SALFIS').AsFloat);
    cxvGarantiaDisp.Properties.Value       := FormatFloat('#,##0.000', FieldByName('ITE_SALGAR').AsFloat);
    cxvPedidoVendaDisp.Properties.Value    := FormatFloat('#,##0.000', FieldByName('ITE_SALRES').AsFloat);
    cxvEnderecamentoDisp.Properties.Value  := FormatFloat('#,##0.000', FieldByName('ITE_SALEND').AsFloat);
    cxvOrdemProducaoDisp.Properties.Value  := FormatFloat('#,##0.000', FieldByName('ITE_QTPD_P').AsFloat);
    cxvEntFutPrevisaoDisp.Properties.Value := FormatFloat('#,##0.000', FieldByName('ITE_QTEF_P').AsFloat);
    cxvEntFutFaltaDisp.Properties.Value    := FormatFloat('#,##0.000', FieldByName('ITE_QTEF_F').AsFloat);
    cxvEntFutAguardaDisp.Properties.Value  := FormatFloat('#,##0.000', FieldByName('ITE_QTEF_A').AsFloat);
    cxvSaldoExternoDisp.Properties.Value   := FormatFloat('#,##0.000', FieldByName('ITE_SALEXT').AsFloat);
    cxvDisponivelDisp.Properties.Value     := FormatFloat('#,##0.000', FieldByName('ITE_SALDIS').AsFloat);
    cxvPedidoCompraDisp.Properties.Value   := FormatFloat('#,##0.000', FieldByName('ITE_QTDPEN').AsFloat);
//    cxvSaldosSaldoRequisicao.Properties.Value   := FormatFloat('#,##0.000', FieldByName('ITE_SALREQ').AsFloat);
  End;

end;

Procedure TfrmDemostrativoBaseCompra.pAjustaSaldoDisponivel;
Begin
  cxvOrdemProducaoDisp.Visible  := blnOrdPro;
  cxvEntFutPrevisaoDisp.Visible := blnEntFut;
  cxvEntFutFaltaDisp.Visible    := blnEntFut;
  cxvEntFutAguardaDisp.Visible  := blnEntFut;
  cxvVendasPerdidas.Visible     := blnComGiro;
  cxvSaldoExternoDisp.VIsible   := blnSalExt;

  If intCalSal In [1, 4, 5] Then
  Begin
    cxvEntFutAguardaDisp.Index := (cxvDisponivelDisp.Index);
    cxvEntFutAguardaDisp.Properties.Caption := Copy(cxvEntFutAguardaDisp.Properties.Caption, 1, Length(cxvEntFutAguardaDisp.Properties.Caption) - 3);
  End;

  If intCalSal In [1, 3, 5] Then
  Begin
    cxvEntFutFaltaDisp.Index := (cxvDisponivelDisp.Index);
    cxvEntFutFaltaDisp.Properties.Caption := Copy(cxvEntFutFaltaDisp.Properties.Caption, 1, Length(cxvEntFutFaltaDisp.Properties.Caption) - 3);
  End;

  If intCalSal In [1, 4] Then
  Begin
    cxvEntFutPrevisaoDisp.Index := (cxvDisponivelDisp.Index);
    cxvEntFutPrevisaoDisp.Properties.Caption := Copy(cxvEntFutPrevisaoDisp.Properties.Caption, 1, Length(cxvEntFutPrevisaoDisp.Properties.Caption) - 3);
  End;
End;

Class Procedure TfrmDemostrativoBaseCompra.pDesmonstra(cdsItens: TDataSet; recOpcGir: TRecOpcoesGiro; blnComGiro: Boolean);
  Var
    frmDemostrativoBaseCompra: TfrmDemostrativoBaseCompra;
Begin
  pCriarFormularios(TfrmDemostrativoBaseCompra, frmDemostrativoBaseCompra);
  frmDemostrativoBaseCompra.cdsItens   := cdsItens;
  frmDemostrativoBaseCompra.recOpcGir  := recOpcGir;
  frmDemostrativoBaseCompra.blnComGiro := blnComGiro;
  frmDemostrativoBaseCompra.ShowModal;
  pFreeAndNil(frmDemostrativoBaseCompra);
End;

end.
