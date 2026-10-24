unit untPedeEmpOrigem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, cxCurrencyEdit, untPreparaTEPedidoCompra,
  Uni, UniClientDataSet, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmPedeEmpOrigem = class(TfrmPaiConfirma)
    Label7: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    pnlItem: TPanel;
    cxgEmpresasLevel1: TcxGridLevel;
    cxvEmpresas: TcxGridDBTableViewCitel;
    cxgEmpresas: TcxGridCitel;
    cxvEmpresasCODEMP: TcxGridDBColumn;
    cxvEmpresasNOMEMP: TcxGridDBColumn;
    cxvEmpresasSALDIS: TcxGridDBColumn;
    cxvEmpresasQTDITE: TcxGridDBColumn;
    cxvEmpresasESTMIN: TcxGridDBColumn;
    cxvEmpresasSALUSU: TcxGridDBColumn;
    Label2: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    pnlRodape: TPanel;
    lblQtdSug: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtQtdSug: TEditFocus;
    edtQtdReq: TEditFocus;
    edtQtdTot: TEditFocus;
    Label5: TLabel;
    edtQtdTra: TEditFocus;
    Label6: TLabel;
    edtQtdIte: TEditFocus;
    Shape1: TShape;
    Shape2: TShape;
    rdgAtendida: TRadioGroup;
    Label8: TLabel;
    Label1: TLabel;
    lblEmbalagem: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    Procedure pAtualizaTotais;

    Function fTotalTransferencia: Double;

  public
    { Public declarations }
    intDecTpc: Integer;
    objTransfere  : TPreparaTEPedidoCompra;
    cdsItensPedido: TUniClientDataSet;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmPedeEmpOrigem: TfrmPedeEmpOrigem;

implementation

Uses
  Math,
  untConsultas,
  untPanelCxCadLote, untFuncoesConsulta, untPnlDadosCadLote,
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmPedeEmpOrigem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If objTransfere.cdsItens.State = dsEdit Then
    objTransfere.cdsItens.Post;

  If ModalResult = mrOk Then
  Begin

    If Not objTransfere.fValidaQuantidades(fStrToFloat(edtQtdIte.Text) * cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat,
                                           fStrToFloat(edtQtdTra.Text),
                                           fStrToFloat(edtQtdReq.Text),
                                           rdgAtendida.ItemIndex = 0) Then
    Begin

      Action := caNone;

    End;

  End

  Else objTransfere.pVoltaQuantidades;

end;

procedure TfrmPedeEmpOrigem.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  rdgAtendida.ItemIndex := -1;
end;

procedure TfrmPedeEmpOrigem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    strCodEmp: String;
begin
  inherited;

  Case Key Of
    VK_F10   : btnConfirma.Click;

    VK_RETURN: If fCheckParent(ActiveControl, cxgEmpresas) And (cxvEmpresasQTDITE.Focused) Then
               Begin
                 If objTransfere.cdsItens.IsEmpty Then
                   Exit;

                 strCodEmp := objTransfere.cdsItens.FieldByName('CODEMP').AsString;

                 cxvEmpresas.NavigatorButtons.Next.Click;

                 pAtualizaTotais;

                 If strCodEmp = objTransfere.cdsItens.FieldByName('CODEMP').AsString Then
                   pSetFocus(edtQtdIte);

               End;
  End;

end;

procedure TfrmPedeEmpOrigem.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(cxgEmpresas);
  cxvEmpresas.NavigatorButtons.First.Click;
  cxvEmpresasQTDITE.Focused := True;

  edtQtdIte.EditFormat := fMskDigitos(intDecTpc);

  If objTransfere.cdsItensMult.FieldByName('ITE_ATEREQ').AsString = 'T' Then
    rdgAtendida.ItemIndex := 0
  Else
    rdgAtendida.ItemIndex := 1;

  pAtualizaTotais;
end;

Function TfrmPedeEmpOrigem.fTotalTransferencia: Double;
Begin
  If Assigned(cxvEmpresas) And
     (cxvEmpresas.DataController.Summary.FooterSummaryItems.Count > 0) And
     (cxvEmpresas.DataController.Summary.FooterSummaryValues[0] <> Null) Then
    Result := cxvEmpresas.DataController.Summary.FooterSummaryValues[0]

  Else
    Result := 0;
End;

Procedure TfrmPedeEmpOrigem.pAtualizaTotais;
Begin
  edtQtdTra.Text := FormatFloat(edtQtdIte.EditFormat, fTotalTransferencia);
  edtQtdTot.Text := FormatFloat(edtQtdIte.EditFormat, fStrToFloat(edtQtdIte.Text) * cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat  + fTotalTransferencia);

  If (fStrToFloat(edtQtdTra.Text) >= fStrToFloat(edtQtdReq.Text)) Then
  Begin

    If (fStrToFloat(edtQtdIte.Text) < fStrToFloat(edtQtdReq.Text)) Then
    Begin

      rdgAtendida.ItemIndex := 0;
      rdgAtendida.Enabled := False;

    End Else
    Begin
      rdgAtendida.Enabled := True;

      If rdgAtendida.ItemIndex = -1 Then
        rdgAtendida.ItemIndex := 0;

    End;

  End;

  If (fStrToFloat(edtQtdIte.Text) >= fStrToFloat(edtQtdReq.Text)) Then
  Begin

    If (fStrToFloat(edtQtdTra.Text) < fStrToFloat(edtQtdReq.Text)) Then
    Begin

      rdgAtendida.ItemIndex := 1;
      rdgAtendida.Enabled := False;

    End Else
    Begin
      rdgAtendida.Enabled := True;

      If rdgAtendida.ItemIndex = -1 Then
        rdgAtendida.ItemIndex := 1;

    End;

  End;

  If (fStrToFloat(edtQtdReq.Text) = 0) Or
     ( (fStrToFloat(edtQtdIte.Text) < fStrToFloat(edtQtdReq.Text))  And
       (fStrToFloat(edtQtdTra.Text) < fStrToFloat(edtQtdReq.Text)))  Then
  Begin
    rdgAtendida.Enabled   := False;
    rdgAtendida.ItemIndex := -1;
  End;

End;

function TfrmPedeEmpOrigem.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtQtdIte) Then
    Begin

      If fEmptyStr(edtQtdIte.Text) Then
        edtQtdIte.Text :=  FormatFloat(edtQtdIte.EditFormat, 0);

      If fStrToFloat(edtQtdIte.Text) < 0 Then
      Begin

        pMensagemOk('A quantidade a comprar deve ser maior ou igual a zero!');
        Result := False;

      End Else
      Begin
        pAtualizaTotais;
      End;

    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
