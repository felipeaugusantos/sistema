unit untEntSelPagtoAntecipado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, untFechamentoFinanceiro,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, Math,
  untEntPagtoAntecipado, BitBtnLockedIncrem, MemDS, DBAccess, Provider,
  frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmEntSelPagtoAntecipado = class(TfrmPaiOrdena)
    lblTotNot: TLabel;
    edtVlrCon: TEditFocus;
    Label1: TLabel;
    edtTotSel: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure dbgConsultaDblClick(Sender: TObject);
  private
    { Private declarations }
    fltTotSel: Double;
  public
    { Public declarations }
    objPgoAnt: TEntPagtoAntecipado;
    fltTotNot: Double;
    blnEhLivroFiscal: Boolean;
    objFechamento: TFechamentoFinanceiro;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    procedure pAcaoAdd; Override;
    procedure pAcaoDel; Override;
    procedure pAddListaQuery; Override;
  end;

var
  frmEntSelPagtoAntecipado: TfrmEntSelPagtoAntecipado;

implementation

uses untFuncoesSimples, untFuncoesGenerica, untMsgPagtoAntecipado;

{$R *.dfm}

procedure TfrmEntSelPagtoAntecipado.btnConfirmaClick(Sender: TObject);
begin
  objPgoAnt.pSetaListaSelecao(stlListSelecao);
  if Not objPgoAnt.fSenhaLiberarGrupoFornecedor then
  Begin
    ModalResult := mrAbort;
    stlListSelecao.Clear;
    fltTotSel := 0;
    edtTotSel.Text := '0,00';
    Exit;
  End;

  inherited;
  objPgoAnt.fltTotSel := fltTotSel;
end;

procedure TfrmEntSelPagtoAntecipado.btnMarcaTodosClick(Sender: TObject);
begin
  //FECHAMENTO FINANCEIRO
  If (cdsConsulta.Active) And (Not cdsConsulta.IsEmpty) Then
  Begin
    if objFechamento.FechamentoFinanceiroJaRealizado(cdsConsulta.FieldByName('CTP_CODEMP').AsString, cdsConsulta.FieldByName('CTP_DTACAD').AsDateTime) then
      blnTemSelecao := False
    else
      blnTemSelecao := True;
  End;

  pAddListaQuery;
  dbgConsulta.Refresh;
  inherited;
end;

procedure TfrmEntSelPagtoAntecipado.cdsConsultaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  If cdsConsulta.FieldByName('FOR_CGCCPF').AsInteger = 1 Then
    cdsConsulta.FieldByName('FOR_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  Else
    cdsConsulta.FieldByName('FOR_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);

end;

procedure TfrmEntSelPagtoAntecipado.dbgConsultaDblClick(Sender: TObject);
begin
  //FECHAMENTO FINANCEIRO
  if objFechamento.FechamentoFinanceiroJaRealizado(cdsConsulta.FieldByName('CTP_CODEMP').AsString, cdsConsulta.FieldByName('CTP_DTACAD').AsDateTime) then
    blnTemSelecao := False
  else
    blnTemSelecao := True;

  inherited;
end;

function TfrmEntSelPagtoAntecipado.fGetSql(blnLike: Boolean): String;
Begin
  Result := objPgoAnt.fSQLConsulta(blnEhLivroFiscal);
End;

procedure TfrmEntSelPagtoAntecipado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If ModalResult = mrAbort Then
    Action := caNone
  Else If ModalResult = mrOk Then
    objPgoAnt.pSetaListaSelecao(stlListSelecao)
  Else
    objPgoAnt.pSetaListaSelecao(Nil);
  inherited;
end;

procedure TfrmEntSelPagtoAntecipado.FormCreate(Sender: TObject);
begin
  inherited;
  blnEhLivroFiscal := False;
end;

procedure TfrmEntSelPagtoAntecipado.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If ((Key = VK_SPACE) Or (Key = VK_RETURN)) And (cdsConsulta.Active) And (Not cdsConsulta.IsEmpty) Then
  begin
    //FECHAMENTO FINANCEIRO
    if objFechamento.FechamentoFinanceiroJaRealizado(cdsConsulta.FieldByName('CTP_CODEMP').AsString, cdsConsulta.FieldByName('CTP_DTACAD').AsDateTime) then
      blnTemSelecao := False
    else
      blnTemSelecao := True;
  end;

  inherited;

  Case Key Of
    VK_F10: Begin
              If btnConfirma.Enabled Then
                btnConfirma.Click;
              Key := 0;
            End;
  End;

end;

procedure TfrmEntSelPagtoAntecipado.FormShow(Sender: TObject);
begin
  inherited;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftWideString;

  blnSelecionaComEspaco := True;
  blnQuoteLista         := False;

  edtVlrCon.Text := FormatFloat('#,##0.00', fltTotNot);

  fAbreConsulta(True);

  objPgoAnt.pRetornaListaSelecao(stlListSelecao, fltTotSel);

  edtTotSel.Text := FormatFloat('#,##0.00', fltTotSel);

  btnConfirma.Enabled := RoundTo(fltTotSel, -2) > 0;

  cdsConsulta.FieldByName('CTP_CODEMP').Alignment := taCenter;
end;

function TfrmEntSelPagtoAntecipado.fSetParametros: Boolean;
Begin
  objPgoAnt.pSetaParametrosConsulta(qryConsulta);
  Result := True;
End;

procedure TfrmEntSelPagtoAntecipado.pAcaoAdd;
Begin
  fltTotSel := fltTotSel + cdsConsulta.FieldByName('CTP_VALPAG').AsFloat;
  edtTotSel.Text := FormatFloat('#,##0.00', fltTotSel);
  btnConfirma.Enabled := RoundTo(fltTotSel, -2) > 0;
End;

procedure TfrmEntSelPagtoAntecipado.pAcaoDel;
Begin
  fltTotSel := fltTotSel - cdsConsulta.FieldByName('CTP_VALPAG').AsFloat;
  edtTotSel.Text := FormatFloat('#,##0.00', fltTotSel);
  btnConfirma.Enabled := RoundTo(fltTotSel, -2) > 0;
End;

procedure TfrmEntSelPagtoAntecipado.pAddListaQuery;
Begin
  If (Not fInLista) And (stlListSelecao.Count >= 24) Then
    pMensagemOk('É permitido selecionar até 24 parcelas!')
  Else inherited;
End;

end.
