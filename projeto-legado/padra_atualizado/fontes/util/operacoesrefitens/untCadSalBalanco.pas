{***********************}
{* qryConIte -> CADITE *}
{********************JB*}
unit untCadSalBalanco;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni,
  Mask, MaskEditFocus, EditFocus, Menus, AppEvnts, untCadLote,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  untILiberacao, untMsgLiberacao, untLiberacaoFactory, Data.DB;

type
  TfrmCadSalBalanco = class(TfrmPaiSimples)
    pnlProduto: TPanel;
    pnlValor: TPanel;
    Label2: TLabel;
    edtCodIte: TEditFocus;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    edtLinGru: TEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtDesMar: TEditFocus;
    edtNomFor: TEditFocus;
    edtDesUni: TEditFocus;
    pnlSaldos: TPanel;
    lblSldBal: TLabel;
    edtSldBal: TEditFocus;
    lblSldMl: TLabel;
    edtSldMl: TEditFocus;
    pnlSalLot: TPanel;
    lblDtaIni: TLabel;
    mskDtaIni: TMaskEditFocus;
    edtSldMlA: TEditFocus;
    lblSldMlA: TLabel;
    edtSldAtu: TEditFocus;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodIteEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    objCadLot: TCadLot;
    qryConIte: TUniQuery;

    intpnlSalLotHeight: Integer;
    strCTLEST: String;

    function fValidaEdits: Boolean;

    procedure pCarregaProduto;
    procedure pLimpaEdits;
    procedure pedtCodIteOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    procedure pedtSldBalOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    function fItemComEstoqueExterno(AstrCodItem: String; out ACurSaldoExterno: Currency): Boolean;
    function fLoteComSaldoBloqueados(AstrCodItem: String; out AstrMensagem: String): Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    Function fValidaData: Boolean;
    Function fSalvaSaldos(fltSalBal, fltSalMl: Double; dtaDtaBal: TDateTime;
                           blnOpcLot: Boolean = False): Boolean;

    procedure pMostraLote(blnMostrar: Boolean);
  end;

var
  frmCadSalBalanco: TfrmCadSalBalanco;

implementation

uses untfuncoesSimples,
     untPai,
     untCadSalBalancoLote, untMovSba, untCadIte, untConsultas, untTypesSistema,
     untIFatEntregaFutura, untTFatEntregaFutura, untMensagemExplicativa;

{$R *.dfm}

{ TfrmCadSalBalanco }

Function TfrmCadSalBalanco.fSalvaSaldos(fltSalBal, fltSalMl: Double;
  dtaDtaBal: TDateTime; blnOpcLot: Boolean = False): Boolean;
Begin
  Result := False;

  {*******************************************}
  {* CASO TODOS OS EDITS ESTEJAM PREENCHIDOS *}
  {****************************************MV*}
  If fValidaEdits Then
  Begin
     If blnOpcLot Or (fMensagem('AVISO', 'Confirma Informações Digitadas?', ['&Sim', '&Não'],2) = 1) Then
     Begin

        {*****************************************}
        {* GRAVA O LOG NO MOVSBA                 *}
        {**************************************MV*}
        fGravaMovSba(VS_strCodEmp,
                     qryConIte.FieldByName('ITE_CODITE').AsString,
                     strLoginUsuarioLogado,
                     qryConIte.FieldByName('ITE_SALDOS').AsFloat,
                     qryConIte.FieldByName('ITE_SAL_ML').AsFloat,
                     dtaDtaBal,
                     fltSalBal,
                     fltSaLML,
                     VS_Date,
                     fTime(),
                     qryConIte.FieldByName('ITE_DTABAL').AsDateTime,
                     qryConIte.FieldByName('ITE_SALBAL').AsFloat,
                     qryConIte.FieldByName('ITE_ML_BAL').AsFloat);

        {*****************************************}
        {* ATUALIZA O SALDO DO ITEM              *}
        {**************************************MV*}
        pAtualizaSaldo(qryConIte.FieldByName('ITE_CODITE').AsString,
                       fltSalBal,
                       dtaDtaBal,
                       fltSalMl,
                       TRUE);

        if not objCadLot.fExisteLote(edtCodIte.Text, VS_strCodEmp) then
        begin
          fGravaLogContEst(strLoginUsuarioLogado,
                            qryConIte.FieldByName('ITE_CODITE').AsString,
                            '',
                            StrToFloat(edtSldBal.Text),
                            0,
                            '',
                            StrToFloat(edtSldaTU.Text));
        end;

        Result := True;

        pLimpaEdits;
        blnMudarFoco := False;

        pSetFocus(edtCodIte);

     End
     Else
     Begin
        pLimpaEdits;
        blnMudarFoco := False;

        If (Not blnOpcLot) Then
          pSetFocus(edtCodIte);
     End;
    End;

End;

function TfrmCadSalBalanco.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  objLiberacao : ILiberacao;
  strMensagem: String;
  frmMensagemExplicativa: TfrmMensagemExplicativa;
  curSaldoExterno: Currency;
  strCodIteBloq, strDesIteBloq: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) And mskDtaIni.Enabled Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais( mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do Balanço deve ser preenchida!', ['&O k']);
        Result := False;
      End

      Else If pnlSalLot.Visible Then
      Begin
        If DateToStr(VS_Date) <> mskDtaIni.Text Then
        Begin
          fMensagem('', 'Este produto possui '+ IIf((strCTLEST = '1'),'lote','armazém') +
                        '. É obrigatório que a data de balanço seja a data de hoje!',['O K']);
          mskDtaIni.Text := DateToStr(VS_Date);
        End;
        blnMudarFoco := False;
        pSetFocus(frmCadSalBalancoLote.dbgConsulta);
      End

      Else If (StrToDate(mskDtaIni.Text) <= (VS_Date-2)) Then
      Begin
        If not (fVerificaAcessoSistema('PDDRBA')) then
        Begin
          objLiberacao := TLiberacaoFactory.fGetLiberacao;
          objLiberacao.Clear;
          objLiberacao.strDirAce    := 'PDDRBA';
          objLiberacao.strCodOpe    := strLoginUsuarioLogado;
          objLiberacao.strCodDig    := strLoginUsuarioLogado;
          objLiberacao.strMsgSen    := 'Digitação de Data de Balanço com Data Retroativa';
          objLiberacao.objMsgLibera.pAddTexto('----------------------------------------------------------------------------------------------------------------');
          objLiberacao.objMsgLibera.pAddTexto('                               Digitação de data de balanço com data retroativa                                 ');
          objLiberacao.objMsgLibera.pAddTexto('----------------------------------------------------------------------------------------------------------------');
          objLiberacao.objMsgLibera.pAddTexto('O operador '+strLoginUsuarioLogado+'-'+fRetNomeOperador(strLoginUsuarioLogado)+' está tentando digitar a data de balanço para ');
          objLiberacao.objMsgLibera.pAddTexto('o produto '+edtCodIte.Text+'-'+edtDesIte.Text+ ', informando data a '+ mskDtaIni.Text+'.');
          objLiberacao.objMsgLibera.pAddTexto('');
          objLiberacao.objMsgLibera.pAddTexto('Isso fará poderá mudar o saldo do produto, por causa da movimentação de estoque existente deste a data informada.');
          objLiberacao.objMsgLibera.pAddTexto('');
          objLiberacao.objMsgLibera.pAddTexto('Será necessário liberação com senha para autorizar.');
          objLiberacao.objMsgLibera.pAddTexto('----------------------------------------------------------------------------------------------------------------');
          Result := objLiberacao.fLibera;
        End
        Else
          Result := True;
      End;

    End

    Else If (Sender = edtCodIte) Then
    Begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Item deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaProduto;
        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
          Result := False;
        End;

        If qryConIte.FieldByName('ITE_QTPD_E').AsInteger > 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Não possível carregar esse item, pois existe endereçamento pendente!', ['&O k']);
          Result := False;
          qryConIte.Close;
          pLimpaEdits;
          mskDtaIni.Clear;
          pMostraLote(False);
          pSetFocus(edtCodIte);
        End;

        If fItemComEstoqueExterno(edtCodIte.Text, curSaldoExterno) Then
        Begin
          Result := False;

          {Captura cod./descricao antes do pLimpaEdits, que zera os edits usados na mensagem}
          strCodIteBloq := edtCodIte.Text;
          strDesIteBloq := edtDesIte.Text;

          qryConIte.Close;
          pLimpaEdits;
          mskDtaIni.Clear;
          pMostraLote(False);

          fMensagem('Ação Bloqueada',
                    'Não foi possível adicionar o item selecionado.' + #13#10 +
                    'Motivo: o item ' + strCodIteBloq + ' - ' + strDesIteBloq +
                    ' possui um saldo pendente (saldo externo: ' + FormatFloat('0.0000', curSaldoExterno) +
                    '), o que impede esta operação.' + #13#10 +
                    'Solução: Acesse a rotina de ' + QuotedStr('Ajuste de Estoque') + ' para ajuste de saldo desse produto.',
                    ['&OK'], 1, False, 1, 0, False, 0, False, False, False, 0, 550);

          pSetFocus(edtCodIte);
        End;

        If fLoteComSaldoBloqueados(edtCodIte.Text, strMensagem) Then
        Begin
          Result := False;
          qryConIte.Close;
          pLimpaEdits;
          mskDtaIni.Clear;
          pMostraLote(False);

          Try
            // Criando o formulário de mensagem explicativa
            pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);

            // Ajustando as propriedades do formulário
            frmMensagemExplicativa.Caption := 'Lotes com saldo bloqueado';
            frmMensagemExplicativa.Width := 800;
            frmMensagemExplicativa.Height := 450;

            // Centralizando o formulário na tela
            frmMensagemExplicativa.Position := poScreenCenter;  // Propriedade que centraliza automaticamente

            // Configurando o RichEdit para exibir a mensagem
            frmMensagemExplicativa.RitchObservacao.Visible := True;
            frmMensagemExplicativa.RitchObservacao.BringToFront;
            frmMensagemExplicativa.RitchObservacao.Lines.Clear;  // Limpar o texto anterior
            frmMensagemExplicativa.RitchObservacao.Lines.Add(strMensagem);

            // Exibindo o formulário como modal
            frmMensagemExplicativa.ShowModal;

            // Movendo o RichEdit para o fundo após o show
            frmMensagemExplicativa.RitchObservacao.SendToBack;
          Finally
            // Liberando recursos usados
            pFreeAndNil(frmMensagemExplicativa);
          End;

          pSetFocus(edtCodIte);
        End;


        If Result Then
        Begin
          blnMudarFoco := False;
          pSetFocus(mskDtaIni);
        End;
      End;

    End

    Else If (Sender = edtSldBal) And pnlSaldos.Visible Then
    Begin

      If (Not edtSldMl.Visible) Then
        fSalvaSaldos(fStrToFloat(edtSldBal.Text),fStrToFloat(edtSldMl.Text),
                     StrToDateTime(mskDtaIni.Text));

    End

    Else If (Sender = edtSldMl) And pnlSaldos.Visible Then
    Begin

      If edtSldMl.Visible Then
        fSalvaSaldos(fStrToFloat(edtSldBal.Text), fStrToFloat(edtSldMl.Text),
                     StrToDateTime(mskDtaIni.Text));

    End
  End;
end;

function TfrmCadSalBalanco.fValidaData: Boolean;
begin
  Result := True;
  If pnlSalLot.Visible Then
  Begin
    If DateToStr(VS_Date) <> mskDtaIni.Text Then
    Begin
      fMensagem('', 'Este produto possui '+ IIf((strCTLEST = '1'),'lote','armazém') +
                    '. É obrigatório que a data de balanço seja a data de hoje!',['O K']);
      mskDtaIni.Text := DateToStr(VS_Date);
      Result := False;
    End;
  End;
end;

{*****************************************}
{* CADRREGA UM PRODUTO NA TELA           *}
{**************************************MV*}
procedure TfrmCadSalBalanco.pCarregaProduto;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_CODITE AS "ITE_CODITE", ';
  strSQL := strSQL + '  I.ITE_CODGRU AS "ITE_CODGRU", ';
  strSQL := strSQL + '  P.GRU_DESGRU AS "GRU_DESGRU", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "ITE_DESITE", ';
  strSQL := strSQL + '  I.ITE_REFERE AS "ITE_REFERE", ';
  strSQL := strSQL + '  I.ITE_CODUNI AS "ITE_CODUNI", ';
  strSQL := strSQL + '  U.UNI_DESUNI AS "UNI_DESUNI", ';
  strSQL := strSQL + '  I.ITE_CODMAR AS "ITE_CODMAR", ';
  strSQL := strSQL + '  M.MAR_DESMAR AS "MAR_DESMAR", ';
  strSQL := strSQL + '  I.ITE_CODFOR AS "ITE_CODFOR", ';
  strSQL := strSQL + '  F.FOR_NOMFOR AS "FOR_NOMFOR", ';
  strSQL := strSQL + '  G.ITE_SALDOS AS "ITE_SALDOS", ';
  strSQL := strSQL + '  G.ITE_SALBAL AS "ITE_SALBAL", ';
  strSQL := strSQL + '  G.ITE_ML_BAL AS "ITE_ML_BAL", ';
  strSQL := strSQL + '  G.ITE_DTABAL AS "ITE_DTABAL", ';
  strSQL := strSQL + '  G.ITE_SAL_ML AS "ITE_SAL_ML", ';
  strSQL := strSQL + '  I.ITE_CNV_ML AS "ITE_CNV_ML", ';
  strSQL := strSQL + '  G.ITE_QTPD_E AS "ITE_QTPD_E"  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I, ';
  strSQL := strSQL + '  CADUNI U, ';
  strSQL := strSQL + '  CADMAR M, ';
  strSQL := strSQL + '  CADFOR F, ';
  strSQL := strSQL + '  CADGRU P, ';
  strSQL := strSQL + '  ITEGER G ';
  strSQL := strSQL + 'WHERE ';

  If Length(edtCodIte.Text) <= fTamCodIte Then
  Begin
    strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
    edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);
  End
  Else
  Begin
    strSQL := strSQL + '  I.ITE_CODBAR = :CODITE AND '
  End;

  strSQL := strSQL + '  G.ITE_CODITE = I.ITE_CODITE AND ';
  strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';      //Empresa Atual
  strSQL := strSQL + '  I.ITE_CODUNI = U.UNI_CODUNI AND ';
  strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
  strSQL := strSQL + '  I.ITE_CODGRU = P.GRU_CODGRU AND ';
  strSQL := strSQL + '  I.ITE_CODFOR = F.FOR_CODFOR ';

  With qryConIte Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := edtCodIte.Text;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    edtCodIte.Text    := FieldByName('ITE_CODITE').AsString;

    edtLinGru.Text    := FieldByName('ITE_CODGRU').AsString + ' - ' +
                         FieldByName('GRU_DESGRU').AsString;

    edtDesIte.Text    := FieldByName('ITE_DESITE').AsString;
    edtRefere.Text    := FieldByName('ITE_REFERE').AsString;

    edtDesUni.Text    := FieldByName('ITE_CODUNI').AsString;

    edtDesMar.Text    := FieldByName('ITE_CODMAR').AsString + ' - ' +
                         FieldByName('MAR_DESMAR').AsString;

    edtNomFor.Text    := FieldByName('ITE_CODFOR').AsString + ' - ' +
                         FieldByName('FOR_NOMFOR').AsString;

    edtSldAtu.Text    :=  FloatToStrF(FieldByName('ITE_SALDOS').AsFloat +
                          TEntregaFutura.New(
                            TParamEF.New()
                              .CodIte(FieldByName('ITE_CODITE').AsString)
                              .CodEmp(VS_strCodEmp)
                              .TipoTE(tteTodas)
                            ).Total(), ffNumber, 12, 3);
    edtSldMlA.Text    :=  FloatToStrF(FieldByName('ITE_SAL_ML').AsFloat, ffFixed, 12, 4);
    edtSldMl.Text     :=  FloatToStrF(FieldByName('ITE_SAL_ML').AsFloat, ffFixed, 12, 4);

    lblSldMlA.Visible := FieldByName('ITE_CNV_ML').AsFloat > 0;
    edtSldMlA.Visible := FieldByName('ITE_CNV_ML').AsFloat > 0;

    lblSldMl.Visible  := FieldByName('ITE_CNV_ML').AsFloat > 0;
    edtSldMl.Visible  := FieldByName('ITE_CNV_ML').AsFloat > 0;
  End;

  pMostraLote(objCadLot.fExisteLote(edtCodIte.Text, VS_strCodEmp));
end;

procedure TfrmCadSalBalanco.pLimpaEdits;
begin
  edtLinGru.Clear;
  edtDesIte.Clear;
  edtRefere.Clear;
  edtDesUni.Clear;
  edtDesMar.Clear;
  edtNomFor.Clear;
  edtCodIte.Clear;
  edtSldAtu.Text := '0,000';
  edtSldMlA.Text := '0,000';
  edtSldBal.Text := '0,000';
  edtSldMl.Text  := '0,000';
end;

{*****************************************}
{* SOBRESCREVE O COMPORTAMENTO NORMAL DO *}
{* EVENTO ONKEYDOWN DO EDIT edtCodIte    *}
{**************************************MV*}
procedure TfrmCadSalBalanco.pedtCodIteOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Return) Then
  Begin
    pProximoControle(Sender);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pLimpaEdits;
    mskDtaIni.Clear;
    pSetFocus(edtCodIte);
    Close;
  End;
end;

procedure TfrmCadSalBalanco.FormShow(Sender: TObject);
begin
  inherited;

  pSetaCodIte( edtCodIte );

  edtCodIte.OnKeyDown := pedtCodIteOnKeyDown;
  edtSldBal.OnKeyDown := pedtSldBalOnKeyDown;
  edtSldMl.OnKeyDown  := pedtSldBalOnKeyDown;
  pLimpaEdits;
  mskDtaIni.Text      := DateToStr(VS_Date);

  {***************************************************************************}
  {* MENSAGEM UTILIZADA PARA INFORMAR AO USUARIO SOBRE O NOVO MODULO ROTINA  *}
  {* DE BALANCO POR AJUSTE ONDE O ESTOQUE E' ACERTADO CONFORME CONTAGEM      *}
  {* SENDO QUE NAO MUDA A DATA DE BALANCO, ASSIM PRESERVA MOVIMENTACAO       *}
  {************************************************************************JC*}
  fMensagem('', 'Na digitação de saldo de balanço, data e saldo de balanço que são ' +
                'informados pelo usuário, farão com que o produto tenha um novo ciclo ' +
                'de movimentacao de estoque. Para fazer ajuste de estoque, utilize a rotina '+
                'de balanço por ajuste.',['O K']);

  //pMostraLote(False);
  pSetFocus(edtCodIte);
  ClientHeight := pnlProduto.Height + pnlSaldos.Height + pnlInfo.Height + 5;
end;

procedure TfrmCadSalBalanco.pMostraLote(blnMostrar: Boolean);
Begin
  If blnMostrar Then
  Begin
    mskDtaIni.Enabled := True;
    pnlSaldos.Visible := False;
    pnlSalLot.Visible := True;

    ClientHeight := pnlProduto.Height + intpnlSalLotHeight + pnlInfo.Height;

    frmCadSalBalancoLote.strCodIte := edtCodIte.Text;
    frmCadSalBalancoLote.blnItemTintaMaquina := edtSldMlA.Visible;
    frmCadSalBalancoLote.pAjustaTela;

    mskDtaIni.Text                 := DateToStr(VS_Date);

    frmCadSalBalancoLote.frmCadSalBalanco := Self;
    frmCadSalBalancoLote.Dock(pnlSalLot,pnlSalLot.BoundsRect);
    frmCadSalBalancoLote.Show;
    frmCadSalBalancoLote.pAbreConsulta;

    self.Top := (Screen.Height - self.Height) Div 2;

  End Else
  Begin
    mskDtaIni.Enabled := True;
    pnlSaldos.Visible := True;
    pnlSalLot.Visible := False;
    ClientHeight := pnlProduto.Height + pnlSaldos.Height + pnlInfo.Height;

    If frmCadSalBalancoLote.cdsConsulta.Active Then
    Begin
      frmCadSalBalancoLote.cdsConsulta.CancelUpdates;
      frmCadSalBalancoLote.cdsConsulta.Close;
    End;

  End;

  edtSldBal.Text     := '0,000';

End;

{*****************************************}
{* SOBRESCREVE O COMPORTAMENTO NORMAL DO *}
{* EVENTO ONKEYDOWN DO EDIT edtSldBal    *}
{**************************************MV*}
procedure TfrmCadSalBalanco.pedtSldBalOnKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_Return) Then
  Begin
    pProximoControle(Sender);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pLimpaEdits;
    edtCodIte.Clear;
    pSetFocus(edtCodIte);
  End;
end;

procedure TfrmCadSalBalanco.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
  Begin
    edtCodIte.Text := qryConIte.FieldByName('ITE_CODITE').AsString;
    Self.SelectNext(ActiveControl, True, True);
    pCarregaProduto;
  End;


end;

function TfrmCadSalBalanco.fItemComEstoqueExterno(AstrCodItem: String; out ACurSaldoExterno: Currency): Boolean;
Var
  qryAux: TUniQuery;
begin
  Result := False;
  ACurSaldoExterno := 0;

  If Not fCfgSis('ESTEXT', varBoolean) Then
    Exit;

  If fEmptyStr(AstrCodItem) Then
    Exit;

  {Considera apenas saldo externo pendente de fato (EXT_SALDO_ <> 0).
   Verificar Nota 1 - Req. 463239}
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.Sql.Clear;
    qryAux.Sql.Add(' SELECT COALESCE(SUM(EXT_SALDO_), 0) AS SALEXT ');
    qryAux.Sql.Add('   FROM ESTEXT ');
    qryAux.Sql.Add('  WHERE EXT_CODITE = :CODITE ');
    qryAux.Sql.Add('    AND EXT_CODEMP = :CODEMP ');
    qryAux.Sql.Add('    AND EXT_SALDO_ <> 0 ');

    qryAux.ParamByName('CODITE').AsString := AstrCodItem;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryAux.Open;

    ACurSaldoExterno := qryAux.FieldByName('SALEXT').AsCurrency;
    Result := ACurSaldoExterno <> 0;
  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmCadSalBalanco.fLoteComSaldoBloqueados(AstrCodItem: String;
  out AstrMensagem: String): Boolean;
Var
  qryAux: TUniQuery;
begin
  Result := False; // Inicializando como False
  AstrMensagem := '';
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.Close;
    qryAux.Sql.Clear;
    qryAux.Sql.Add(' SELECT LOT_CODITE, LOT_NUMLOT, LOT_SALDOS ');
    qryAux.Sql.Add('   FROM CADLOT ');
    qryAux.Sql.Add('  WHERE TRUE ');
    qryAux.Sql.Add('    AND LOT_CODITE = :CODITE ');
    qryAux.Sql.Add('    AND LOT_SALDOS <> 0 '     );
    qryAux.Sql.Add('    AND LOT_CODEMP = :CODEMP ');
    qryAux.Sql.Add('    AND LOT_STATUS = :STATUS ');

    // Definindo parâmetros
    qryAux.ParamByName('CODITE').AsString := AstrCodItem;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.ParamByName('STATUS').AsString := 'B';

    qryAux.Open;

    If qryAux.IsEmpty Then
      Exit; // Se não houver dados, retorna False

    Result := True; // Sucesso, encontrou registros bloqueados

    // Montando a mensagem com os lotes bloqueados
    AstrMensagem := 'Os lotes abaixo estão com o saldo bloqueado. ' + sLineBreak;
    AstrMensagem := AstrMensagem + 'Antes de prosseguir, é necessário ajustar o status deles.' + sLineBreak ;
    AstrMensagem := AstrMensagem + '--------------------------------------------------------------------------------------------------' + sLineBreak;

    qryAux.First;
    While Not qryAux.Eof do
    Begin
      AstrMensagem := AstrMensagem + Format('%-10s %-10s %-15s ', [
                                             'Item: '     + qryAux.FieldByName('LOT_CODITE').AsString,
                                             'Lote: '     + qryAux.FieldByName('LOT_NUMLOT').AsString,
                                             'Saldo: '    + FormatFloat('0.0000', qryAux.FieldByName('LOT_SALDOS').AsFloat)]) + sLineBreak;
      qryAux.Next;
    End;

  Finally
    FreeAndNil(qryAux); // Liberando recursos
  End;
end;

function TfrmCadSalBalanco.fValidaEdits: Boolean;
begin
  Result := True;

  If mskDtaIni.Enabled And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    pSetFocus(mskDtaIni);
    Result := False;
  End
  Else If fEmptyStr(edtCodIte.Text) Then
  Begin
    pSetFocus(edtCodIte);
    Result := False;
  End;

  If fEmptyStr(edtSldBal.Text) Then
  Begin
    edtSldBal.Text := '0,000';
  End;

  If fEmptyStr(edtSldMl.Text) Then
  Begin
    edtSldMl.Text := '0,000';
  End;

  If Not Result Then
    blnMudarFoco := False;
end;

procedure TfrmCadSalBalanco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(frmCadSalBalancoLote);
end;

procedure TfrmCadSalBalanco.FormCreate(Sender: TObject);
begin
  inherited;

  intpnlSalLotHeight := pnlSalLot.Height;

  qryConIte := fCriaQuery(Self);

  objCadLot := TCadLot.Create(Nil);
  //objCadLot.frmCadSalBalanco := Self;

  pCriarFormularios(TfrmCadSalBalancoLote, frmCadSalBalancoLote);
  frmCadSalBalancoLote.objCadLot := objCadLot;

  strCTLEST := fCfgSis('CTLEST', varString);
end;

procedure TfrmCadSalBalanco.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If pnlSalLot.Visible Then
  Begin
    If (Key = VK_Escape) And (Not frmCadSalBalancoLote.pnlPesquisa.Visible) Then
    Begin
      pLimpaEdits;
      pMostraLote(False);
      edtCodIte.Clear;
      pSetFocus(edtCodIte);
    End

    Else frmCadSalBalancoLote.FormKeyDown(Sender,Key,Shift)
  End

  Else inherited;

end;

procedure TfrmCadSalBalanco.edtCodIteEnter(Sender: TObject);
begin
  inherited;

  pLimpaEdits;
  pMostraLote(False);
  edtCodIte.Clear;
end;

end.

