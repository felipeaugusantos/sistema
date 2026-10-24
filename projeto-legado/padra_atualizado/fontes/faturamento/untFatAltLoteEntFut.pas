unit untFatAltLoteEntFut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  MaskEditFocus, ComboBoxFocus, untFuncoesSimples, EditFocus, Math,
  BitBtnLockedIncrem, untCadLote, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, System.StrUtils;

type
  TfrmFatAltLoteEntFut = class(TfrmPaiConfirma)
    pnlMotivo: TPanel;
    edtProduto: TEditFocus;
    lbl1: TLabel;
    Label1: TLabel;
    edtRefere: TEditFocus;
    Label2: TLabel;
    edtUnidad: TEditFocus;
    lbl2: TLabel;
    edtQuanti: TEditFocus;
    lbl3: TLabel;
    edtSituac: TEditFocus;
    lbl4: TLabel;
    edtDtaPrev: TEditFocus;
    bvl1: TBevel;
    bvl2: TBevel;
    lblAtual: TLabel;
    edtLotAtu: TEditFocus;
    lblNovo: TLabel;
    edtLotNov: TEditFocus;
    bvl3: TBevel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtLotNovKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    objCadLot: TCadLot;
    strCodIte: String;
    strCodEmp: String;
    fltQtdIte: Double;
    strTabela: String;
    strAutInc: String;
    strTitulo: String;
    strMotFut: String;
    strDesLot: String;
    function fPesquisaLote(Sender: TObject; Var Key: Char; arrNumLot: TStringArray = Nil): Boolean;
    function fValidaObrigaLoteADefinirEntregaFutura: Boolean;
  public
    procedure pSetProduto(const strValue: string);
    procedure pSetReferencia(const strValue: string);
    procedure pSetUnidade(const strValue: string);
    procedure pSetQuantidade(const fltValue: Double);
    procedure pSetSituacao(const strValue: string);
    procedure pSetDtaPrevisao(const strValue: string);
    procedure pSetLoteAtual(const strValue: string);
    procedure pSetEmpresa(const strValue: string);
    procedure pSetTabela(const strValue: string);
    procedure pSetAutInc(const strValue: string);
    procedure pSetMotFut(const strValue: string);
    function fGravar: Boolean;
    function fGetTitulo: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmFatAltLoteEntFut: TfrmFatAltLoteEntFut;

implementation

uses untPanelCxCadLote, untPnlDadosCadLote, untFuncFat, untMsgLiberacao;

{$R *.dfm}

procedure TfrmFatAltLoteEntFut.btnConfirmaClick(Sender: TObject);
  Var
    fltQtdEst : Double;
    strNTrava : String;
    strTipTra : String;
    objMsg    : TMensagemLiberacao;
begin
  If (fVerificaCampos) Then
  Begin
    If (edtLotNov.Text <> 'A DEFINIR') Then
    Begin
      If fValidaObrigaLoteADefinirEntregaFutura Then
      Begin
        fMensagem('ATENÇÃO',strDesLot + ' informado é inválido quando se trata de Entrega Futura' + IIF((strMotFut = 'F'), ' - Falta Produto', '') + ', utilizar "A DEFINIR"!',['&OK']);
        ModalResult := MrNone;
        Exit;
      End;

      fltQtdEst := objCadLot.fSaldoLote(strCodIte, strCodEmp, edtLotNov.Text);

      If (fltQtdIte > fltQtdEst) Then
      Begin
        strTipTra := fTravaSaldoVN(False, True, strMotFut);

        If Pos(strTipTra, 'A_T_') > 0 Then
        Begin
          If (strTipTra = 'T') Then
          Begin
            objMsg := TMensagemLiberacao.Create(Self);
            try
              objMsg.pAddTexto('Liberação de produto com '+strDesLot+' sem saldo - Venda Normal (Alteração de Lote)!');
              objMsg.pAddTextoCaption('Produto'            , edtProduto.Text                                                , 16);
              objMsg.pAddTextoCaption('Marca'              , fRetNomMarcaItem(strCodIte)                                    , 16);
              objMsg.pAddTextoCaption(strDesLot            , edtLotNov.Text                                                 , 16);
              objMsg.pAddTextoCaption('Qtde. Produto'      , FloatToStrF(fltQtdIte, ffNumber, 12, 4)                        , 16);
              objMsg.pAddTextoCaption('Saldo ' + strDesLot , FloatToStrF(fltQtdEst, ffNumber, 12, 4)                        , 16);
              objMsg.pAddTextoCaption('Empresa'            , strCodEmp +' - '+ Copy(fRetNomeEmpresaSelec(strCodEmp), 1, 50) , 16);

              If Not fSenhaLiberacaoSemSaldoVN(strLoginUsuarioLogado,
                                               strLoginUsuarioLogado,
                                               strNTrava,
                                               Nil,
                                               objMsg,
                                               edtProduto.Text,
                                               True,
                                               '',
                                               False,
                                               False,
                                               '',
                                               True,
                                               False) Then
              Begin
                ModalResult := MrNone;
                Exit;
              End;
            finally
              FreeAndNil(objMsg);
            end;
          End
          Else
          Begin
            fMensagem('ATENÇÃO!', 'Produto ' + edtProduto.Text + ' não possui saldo suficiente no ' +
                                   strDesLot + ' informado!', ['&OK']);
          End;
        End;

      End;
    End;
  End
  Else
  Begin
    ModalResult := MrNone;
    Exit;
  End;

  inherited;
end;

procedure TfrmFatAltLoteEntFut.edtLotNovKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesquisaLote(Sender, Key) Then
  Begin
    If fValidaCampos(edtLotNov, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatAltLoteEntFut.fGetTitulo: String;
begin
  Result := strTitulo;
end;

function TfrmFatAltLoteEntFut.fGravar: Boolean;
begin
  Result := objCadLot.fTrocarLote(strTabela, strAutInc, edtLotAtu.Text, edtLotNov.Text, strCodIte, fltQtdIte, strCodEmp);
end;

procedure TfrmFatAltLoteEntFut.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtLotNov);
end;

procedure TfrmFatAltLoteEntFut.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If ModalResult = mrok Then
  Begin
    If (Not fVerificaCampos) Then
      Action := caNone;
  End;
end;

procedure TfrmFatAltLoteEntFut.FormCreate(Sender: TObject);
begin
  inherited;
  objCadLot := TCadLot.Create(Self);
  strTitulo := ARR_TITLAB[objCadLot.tplTipLot];
  lblAtual.Caption := strTitulo + ' Atual';
  lblNovo.Caption := 'Novo ' + strTitulo;
  strDesLot := objCadLot.strDescri;
  strMotFut := '';
  Self.Caption := AnsiReplaceStr(Self.Caption, '<DESLOT>', strDesLot);
end;

procedure TfrmFatAltLoteEntFut.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(objCadLot) Then
    FreeAndNil(objCadLot);
end;

procedure TfrmFatAltLoteEntFut.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtLotNov);
end;

function TfrmFatAltLoteEntFut.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
Begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtLotNov Then
    Begin
      If fEmptyStr(edtLotNov.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o número do ' + strTitulo + '!', ['&Ok']);
        Result := False;
      End
      Else If (edtLotNov.Text = edtLotAtu.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário escolher um novo ' + strTitulo + ' para a alteração!', ['&OK']);
        Result := False;
      End
      Else If Not objCadLot.fExisteLote(strCodIte, strCodEmp, edtLotNov.Text) Then
      Begin
        fMensagem('ATENÇÃO!', strTitulo + ' não encontrado!', ['&Ok']);
        Result := False;
      End
      Else If (RoundTo(objCadLot.qryCadLot.FieldByName('LOT_SALDOS').AsFloat, -2) <= 0) And
              (SameText(objCadLot.qryCadLot.FieldByName('LOT_SALDOS').AsString,'A DEFINIR')) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse ' + strTitulo + ' está sem saldo!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
End;

function TfrmFatAltLoteEntFut.fValidaObrigaLoteADefinirEntregaFutura: Boolean;
var
  LEntDef: String;
begin
  Result := False;

  LEntDef := fCfgSis('ENTDEF', varString);

  if (LEntDef = 'N') then
    Exit;

  if (LEntDef = 'F') and (strMotFut <> 'F') then
    Exit;

  Result := True;
end;

procedure TfrmFatAltLoteEntFut.pSetAutInc(const strValue: string);
begin
  strAutInc := strValue;
end;

procedure TfrmFatAltLoteEntFut.pSetDtaPrevisao(const strValue: string);
begin
  edtDtaPrev.Text := strValue;
end;

procedure TfrmFatAltLoteEntFut.pSetEmpresa(const strValue: string);
begin
  strCodEmp := strValue;
end;

procedure TfrmFatAltLoteEntFut.pSetLoteAtual(const strValue: string);
begin
  edtLotAtu.Text := strValue;
end;

procedure TfrmFatAltLoteEntFut.pSetMotFut(const strValue: string);
begin
  strMotFut := strValue;
end;

procedure TfrmFatAltLoteEntFut.pSetProduto(const strValue: string);
begin
  strCodIte := Copy(strValue, 1, fTamCodIte);
  edtProduto.Text := strValue;
end;

procedure TfrmFatAltLoteEntFut.pSetQuantidade(const fltValue: Double);
begin
  fltQtdIte := fltValue;
  edtQuanti.Text := FloatToStrF(fltValue, ffFixed, 12, 2);
end;

procedure TfrmFatAltLoteEntFut.pSetReferencia(const strValue: string);
begin
  edtRefere.Text := strValue;
end;

procedure TfrmFatAltLoteEntFut.pSetSituacao(const strValue: string);
begin
  edtSituac.Text := strValue;
end;

procedure TfrmFatAltLoteEntFut.pSetTabela(const strValue: string);
begin
  strTabela := strValue;
end;

procedure TfrmFatAltLoteEntFut.pSetUnidade(const strValue: string);
begin
  edtUnidad.Text := strValue;
end;

function TfrmFatAltLoteEntFut.fPesquisaLote(Sender: TObject; Var Key: Char; arrNumLot: TStringArray = Nil): Boolean;
  var
    objfrmPnl: TPanelCxCadLote;
begin
  inherited;
  Try
    objfrmPnl := TPanelCxCadLote.Create(TfrmPnlDadosCadLote);
    objfrmPnl.strCodIte := strCodIte;
    Result := objCadLot.fedtNumLotKeyPress(strCodIte,
                                           Sender,
                                           Key,
                                           edtLotNov,
                                           Self,
                                           False,
                                           False,
                                           objfrmPnl,
                                           Nil,
                                           strCodEmp);
  Finally
    FreeAndNil(objfrmPnl);
  End;
end;

end.
