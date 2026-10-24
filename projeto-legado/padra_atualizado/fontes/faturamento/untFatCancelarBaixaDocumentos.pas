unit untFatCancelarBaixaDocumentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus,
  EditFocus, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel, untConfDocs, untFuncFat;

type
  TfrmFatCancelarBaixaDocumentos = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label15: TLabel;
    Label20: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    dbgDocumentos: TDBGridCitel;
    FlowPanel1: TFlowPanel;
    btnDesmarca: TBitBtnLocked;
    btnMarca: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnSairConf: TBitBtnLocked;
    prbProgresso: TProgressBar;
    procedure FormShow(Sender: TObject);
    procedure dbgDocumentosDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgDocumentosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnSairConfClick(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    { Private declarations }
    FConfirmacaoDocumentos : TConfirmacaoDocumentos;
    FdtsQryTmp             : TDataSource;
    procedure pCriaTemporaria;
    procedure pMarcarDesmarcarTudo(AOpcao : String);
  public
    { Public declarations }
    property ConfirmacaoDocumentos : TConfirmacaoDocumentos read FConfirmacaoDocumentos write FConfirmacaoDocumentos;
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatCancelarBaixaDocumentos.btnConfirmaClick(Sender: TObject);
begin
  If fMensagem('', 'Confirma o cancelamento da baixa dos documentos?', ['&Sim', '&Não']) = 1 Then
  Begin
    FConfirmacaoDocumentos.pDeletaDocDesmarcados;
    FConfirmacaoDocumentos.pAtualizaTemporariaConfirmacao(True);
    FConfirmacaoDocumentos.pCancelarBaixaDocumentosMarcados;
    Close;
  End;
end;

procedure TfrmFatCancelarBaixaDocumentos.btnDesmarcaClick(Sender: TObject);
begin
  pMarcarDesmarcarTudo('D');
end;

procedure TfrmFatCancelarBaixaDocumentos.btnMarcaClick(Sender: TObject);
begin
  pMarcarDesmarcarTudo('M');
end;

procedure TfrmFatCancelarBaixaDocumentos.btnSairConfClick(Sender: TObject);
begin
  inherited;
  If fMensagem('', 'Realmente deseja sair?', ['&Sim', '&Não']) = 1 Then
    Close;
end;

procedure TfrmFatCancelarBaixaDocumentos.dbgDocumentosDblClick(Sender: TObject);
var LMensagegem : String;
begin
  inherited;
  If not (FConfirmacaoDocumentos.qryConfirmacao.IsEmpty) Then
    if not FConfirmacaoDocumentos.fMarcaDocumento(
      FConfirmacaoDocumentos.qryConfirmacao.FieldByName('TMP_MARDES').AsString <> 'M', LMensagegem) then
        pMensagemOk(LMensagegem);
end;

procedure TfrmFatCancelarBaixaDocumentos.dbgDocumentosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If FConfirmacaoDocumentos.qryConfirmacao.FieldByName('TMP_MARDES').AsString = 'M' Then
    dbgDocumentos.Canvas.Font.Color := clBlue;

  dbgDocumentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatCancelarBaixaDocumentos.dbgDocumentosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var LMensagegem : String;
begin
  If (Key = VK_Return) Then
    If Not FConfirmacaoDocumentos.qryConfirmacao.IsEmpty Then
        FConfirmacaoDocumentos.fMarcaDocumento(FConfirmacaoDocumentos.qryConfirmacao.FieldByName('TMP_MARDES').AsString <> 'M', LMensagegem);
end;

procedure TfrmFatCancelarBaixaDocumentos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FConfirmacaoDocumentos.pDeletaTemporariaConfirmacao;
  FConfirmacaoDocumentos.objFatVenda.objLock.pDestravarTodos;
end;

procedure TfrmFatCancelarBaixaDocumentos.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_F7) Then
    btnMarca.Click

  Else If (Key = VK_F8) Then
    btnDesmarca.Click

  Else If (Key = VK_F10) Then
    btnConfirma.Click

  Else If (Key = VK_Escape) Then
    If fMensagem('', 'Realmente deseja sair?', ['&Sim', '&Não']) = 1 Then
      Close;
end;

procedure TfrmFatCancelarBaixaDocumentos.FormShow(Sender: TObject);
begin
  FdtsQryTmp := fCriaDataSource(FConfirmacaoDocumentos.qryConfirmacao);

  FConfirmacaoDocumentos.prbProgresso := prbProgresso;

  edtCodCli.Text := FConfirmacaoDocumentos.strCodCli;
  edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

  pSetFocus(mskDtaIni);
end;

function TfrmFatCancelarBaixaDocumentos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A Data Inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End
            Else
              pCriaTemporaria;
          End;
        End
      End
      Else
        pCriaTemporaria;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;


procedure TfrmFatCancelarBaixaDocumentos.pCriaTemporaria;
begin
  if StrToIntDef(FConfirmacaoDocumentos.strQtdDocSel, 0) > 0 then
    FConfirmacaoDocumentos.objFatVenda.objLock.pDestravarTodos;

  FConfirmacaoDocumentos.strCodCli              := edtCodCli.Text;
  FConfirmacaoDocumentos.dtaDtaIni              := StrToDateDef(mskDtaIni.Text, 0);
  FConfirmacaoDocumentos.dtaDtaFim              := StrToDateDef(mskDtaFin.Text, 0);
  FConfirmacaoDocumentos.CarregaItensJaFaturado := True;
  FConfirmacaoDocumentos.pCriaTemporariaConfirmacao;

  dbgDocumentos.DataSource := FdtsQryTmp;
end;

procedure TfrmFatCancelarBaixaDocumentos.pMarcarDesmarcarTudo(AOpcao: String);
begin
  If (AOpcao = 'M') Then
    FConfirmacaoDocumentos.pMarcarTodosDocumentos(True, '')
  Else
    FConfirmacaoDocumentos.pMarcarTodosDocumentos(False, '');
end;

end.
