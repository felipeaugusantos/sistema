{***************************}
{* qryConTr2 -> CADTRA     *}
{* qryConFgo -> FATGOR     *}
{************************JB*}

unit untDigObservacoes;

interface

uses
  SysUtils, Types, Classes, Variants, untPaiSimples, StdCtrls, EditFocus,
  Controls, Menus, ComCtrls, Buttons, ExtCtrls, Graphics, Forms, StrUtils,
  Dialogs, QColorLabel, Uni, AppEvnts, Mask, MaskEditFocus,
  Windows, BitBtnLockedIncrem, ComboBoxFocus, frxClass,
  UniClientDataSet, untFuncoesConsulta, untTypesSistema,
  frxExportCSVTestabilidade, untMetaCentroCustoPedido,
  untDuplicatasPedidoCompra, untFrameCentroCustoEditFocus, DateUtils,untZClient,
  untFramePlanoDeContasMaskEdit, MemoFocus ;

type
  procRateiaFreteDesAce = Procedure(blnRecalcular: Boolean; fltValFreRat, fltDesAceRat: Double; strBStFrete, strBStDesAce, strBSIpiFrete: String) Of Object;


  TRecDigObservacoes = record
      blnEndLoj,
      blnOrcamento: Boolean;
      fltDesAce,
      fltValFre: Double;

      strCodTra,
      strNomEmp,
      strEndEmp,
      strCidEmp,
      strTipFre,

      strObsPd1,
      strObsPd2,
      strObsPd3,

      strObs001,
      strObs002,
      strObs003,
      strObs004,
      strObs005,
      strPedVen,

      strAtenca,
      strCodEve,
      strCodCta,

      strDtaEnt,
      strDtaFat,

      strFinPed,
      strCndPag,

      strCodTraRedespacho,
      strNomTraRedespacho,
      strEndereRedespacho,
      strCidadeRedespacho,
      strTipFreRedespacho,

      strEspDoc : String;
  end;

  TfrmDigObservacoes = class(TfrmPaiSimples)
    Panel2: TPanel;
    gpbTransportador: TGroupBox;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    edtEndere: TEditFocus;
    edtCidade: TEditFocus;
    gpbEntrega: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtNomEmp: TEditFocus;
    edtEndEmp: TEditFocus;
    edtCidEmp: TEditFocus;
    gpbDadAdc: TGroupBox;
    pnlDireita: TPanel;
    gpbObservacao: TGroupBox;
    pnlPedidoVenda: TPanel;
    Label2: TLabel;
    edtPedVen: TEditFocus;
    pnlDados: TPanel;
    memObserv: TMemo;
    gpbAtencao: TGroupBox;
    pnlFundo: TPanel;
    edtAtenca: TEditFocus;
    gpbFinalPed: TGroupBox;
    rdgEndEnt: TRadioGroup;
    btnConfirma: TBitBtnLocked;
    rdgOpcMultiLojas: TRadioGroup;
    pnlFrete: TPanel;
    Label6: TLabel;
    cmbTipFre: TComboBoxFocus;
    Label8: TLabel;
    lbl1: TLabel;
    edtDesAce: TEditFocus;
    edtValFre: TEditFocus;
    pnlDadosIniciais: TPanel;
    Label7: TLabel;
    Label9: TLabel;
    Label28: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    mskDtaPed: TMaskEditFocus;
    edtCodCmp: TEditFocus;
    mskDtaFat: TMaskEditFocus;
    chkPgAVis: TCheckBox;
    mskCndPag: TMaskEditFocus;
    edtNomCmp: TEditFocus;
    edtCodOco: TEditFocus;
    edtDesOco: TEditFocus;
    btnCodCta: TBitBtnLocked;
    btnParcel: TBitBtnLocked;
    cmbEmpresas: TComboBoxFocus;
    Label12: TLabel;
    chkCalStFrete: TCheckBox;
    chkCalStDesAce: TCheckBox;
    rgbTransRedespacho: TGroupBox;
    Panel3: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edtCodTraRedespacho: TEditFocus;
    edtNomTraRedespacho: TEditFocus;
    edtEndereRedespacho: TEditFocus;
    edtCidadeRedespacho: TEditFocus;
    Panel4: TPanel;
    Label17: TLabel;
    cmbTipFreRedespacho: TComboBoxFocus;
    fraCentroCusto: TfraCentroCustoEditFocus;
    lblPerFre: TLabel;
    lblPerAce: TLabel;
    lblPerFreVlr: TLabel;
    lblPerAceVlr: TLabel;
    lblPerFre_: TLabel;
    lblPerAce_: TLabel;
    rdgTipoGravacao: TRadioGroup;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    gpbOrdemCompra: TGroupBox;
    Panel5: TPanel;
    edtOrdemCompra: TEditFocus;
    chkEnvEmailAutomatico: TCheckBox;
    chkCalIpiFrete: TCheckBox;
    cbxEnviarWhatsapp: TCheckBox;
    pnlMultLojaPasta: TPanel;
    pnlAvisoEmpresas: TPanel;
    chkReplicarDados: TCheckBox;
    MemoFocus1: TMemoFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtPedVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rdgOpcMultiLojasClick(Sender: TObject);
    procedure chkPgAVisClick(Sender: TObject);
    procedure edtCodOcoExit(Sender: TObject);
    procedure edtCodOcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnCodCtaClick(Sender: TObject);
    procedure btnParcelClick(Sender: TObject);
    procedure cmbEmpresasChange(Sender: TObject);
    procedure edtCodTraRedespachoKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure cmbTipFreChange(Sender: TObject);
    procedure cmbTipFreRedespachoChange(Sender: TObject);
  private
    arrOcor: TConsultasArray;
    qryConTr2: TUniQuery;
    qryConFgo: TUniQuery;

    fltFreAntOri,
    fltDesAntOri: Double;

    fltFreAnt,
    fltDesAnt: Double;
    blnBStFreAnt,
    blnBIPIFreAnt,
    blnBStAceAnt: Boolean;
    ListaPedido: TStringList;

    objMetaCusto: TMetaCentroCustoPedido;
    blnConfirmando: Boolean;

    Function fValidaArrCodCta: Boolean;

    function fEncontraPedidoVenda(strNumDoc: String): Boolean;
    procedure pCarregaTransportadora(blnRedespacho: Boolean = False);
    procedure pHabilitaEndEnt;

    Procedure pVeSeRateiaFreteDesAce(fltValFre, fltDesAce: Double);

    function fValidaMeta(dtaDtaEnt: TDateTime; strCodCta, strCodFor, strNumPed, strCodEmp, strCodCmp: String; fltTotPed: Double; strCodEve: String): Boolean;

    function fValidaCondPagamento(blnBuscaPorChave: Boolean): Boolean;

    Function fValidaParcelas: Boolean;
    procedure pTransformaAutoincremEmNumPed(var PedVen: String);


    procedure pCalculaDuplicatasPedido(blnMostrarTela: Boolean);

    Procedure pCarregaEmpresas;

    procedure pCarregaPercFreteTotItem;

    procedure pCarregaPercDesAceTotItem;

    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnPastaDeCompra: Boolean;
    cdsTotalEmpresas: TZClient;

    pRateiaFreteDesAce: procRateiaFreteDesAce;

    objDuplicatasPedido: TDuplicatasPedidoCompra;

    arrCodCta: TarrCodCtaFornec;

    intCarPag: Integer;  // Carência p/ Pagto A Vista

    blnVariasEmpresasDestino: Boolean;

    fltTotPed,
    fltTotIte: Double;

    strObserv1: String;
    strObserv2: String;
    strObserv3: String;
    strObserv4: String;
    strObserv5: String;
    strObserv6: String;

    strCodTra: String;
    strNomTra: String;
    strEndere: String;
    strCidade: String;
    strTipFre: String;

    strCodTraRedespacho: String;
    strNomTraRedespacho: String;
    strEndereRedespacho: String;
    strCidadeRedespacho: String;
    strTipFreRedespacho: String;

    fltValFre: Double;
    fltDesAce: Double;

    strAtenca: String;

    strFinPed: String;
    strCodEve: String;
    strCodCta: String;
    strCodFor: String;
    strConPag: String;

    dtaDtaEnt: TDateTime;
    strNumPed: String;
    strEmpPed: String;
    fltTotGer: Double;

    cdsItensPedido,
    cdsItensMultiLojas: TUniClientDataSet;

    strEspDoc,
    strPedMlj: String;

    blnCotacao: Boolean;

    blnConfirma: Boolean;

    strCodComprador: String;
    blnEnviarWhatsapp: Boolean;
    intDiaDif: integer	;
  end;

var
  frmDigObservacoes: TfrmDigObservacoes;

implementation

uses untfuncoesSimples, DB, untConsultas, untTipoFreteAtc, untCadCta,
  untConstantes, untFuncoesPedidoSimples,
  untDigCtaFornecedores, untDuplicatas, Math;

{$R *.dfm}

function TfrmDigObservacoes.fValidaMeta(dtaDtaEnt: TDateTime; strCodCta, strCodFor, strNumPed, strCodEmp, strCodCmp: String; fltTotPed: Double; strCodEve: String): Boolean;
  Var
    qryCadEmp: TUniQuery;
    strItensPed: String;
    blnPedeSenha: Boolean;
    arrParcelasDesmen: TarrDuplicata;
    intContador: Integer;

    fltValFreRes,
    fltValFreGer,
    fltTotFre,
    fltTotIteGer: Double;

    arrEmpresas: Array Of Record
                   strCodEmp: String;
                   fltTotIte,
                   fltTotGer: Double;
                 End;
Begin
  Result := True;
  blnPedeSenha := False;

  If Not Assigned(objDuplicatasPedido) Then
    Exit;

  SetLength(arrLogLib, 0);

  If blnCotacao Then
    Exit;

  If Not SameText(strEspDoc, 'PD') Then
    Exit;

  If (fCfgSis('METPED') <> '1') And (fCfgSis('METPED') <> '2') and
     (fCfgSis('METPED') <> '4') and (fCfgSis('METPED') <> '5') and
     (fCfgSis('METPED') <> '6') Then
    Exit;

  If Pos(strCodFor, fRetForFilialTodos) > 0 Then
    Exit;

  objMetaCusto.pInicializa;

  objMetaCusto.strCodFor := strCodFor;
  objMetaCusto.cdsTotalEmpresas := cdsTotalEmpresas;

  // Vai finalizar o pedido multi-loja - deve ser testado no desmenbramento
  If SameText(strPedMlj, 'S') And (rdgOpcMultiLojas.ItemIndex = 1) Then
  Begin
    If Not Assigned(cdsItensPedido) Then
      Exit;

    If Not Assigned(cdsItensMultiLojas) Then
      Exit;


    If Not objMetaCusto.fExisteMeta(strCodCmp, strCodFor, FormatDateTime('MMYYYY', fNow)) Then
      Exit;

    pAjustaMultiLoja(cdsItensPedido, cdsItensMultiLojas);

    strItensPed := fRetItensPed(cdsItensPedido);

    qryCadEmp := fCriaQuery(Self);
    pAbreEmpresas(qryCadEmp);

    SetLength(arrEmpresas, 0);

    fltTotIteGer := 0;
    fltValFreGer := fStrToFloat(edtValFre.Text) + fStrToFloat(edtDesAce.Text);

    While Not qryCadEmp.Eof do
    Begin

      If fTemPedidoEmpresa(cdsItensMultiLojas, qryCadEmp, strItensPed) Then
      Begin

        SetLength(arrEmpresas, Succ(Length(arrEmpresas)));

        With arrEmpresas[High(arrEmpresas)] Do
        Begin
          strCodEmp := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
          fltTotIte := fDoubleAggregate(cdsItensMultiLojas, 'TOT_TOTITE');
          fltTotGer := fDoubleAggregate(cdsItensMultiLojas, 'TOT_TOTGER');

          fltTotIteGer := fltTotIteGer + fltTotIte;
        End;

      End;

      qryCadEmp.Next;
    End;

    FreeAndNil(qryCadEmp);

    fltValFreRes := fltValFreGer;

    // RATEIA FRETE E DESPESAS
    For intContador := Low(arrEmpresas) To High(arrEmpresas) Do
    With arrEmpresas[intContador] Do
    Begin

      If intContador = High(arrEmpresas) Then
      Begin

        fltTotFre := fltValFreRes

      End Else
      Begin

        If RoundTo((fltTotIte / fltTotIteGer) * fltValFreGer, -2) < fltValFreRes Then
          fltTotFre := RoundTo((fltTotIte / fltTotIteGer) * fltValFreGer, -2)
        Else
          fltTotFre := fltValFreRes;

      End;

      objDuplicatasPedido.pCalculaDuplicatasProporcional(strConPag, strCodFor, fltTotGer + fltTotFre, fltTotIte, dtaDtaEnt, arrParcelasDesmen);

      blnPedeSenha := (Not objMetaCusto.fCarregaMetas(dtaDtaEnt,
                                             strCodEmp,
                                             strCodCta,
                                             strNumPed,
                                             strConPag,
                                             fltTotGer + fltTotFre,
                                             False {blnRecalcularDuplictas},
                                             arrParcelasDesmen, strCodCmp, strCodEve))
                         Or (blnPedeSenha);

      fltValFreRes := fltValFreRes - fltTotFre;
    End;

  End

  Else blnPedeSenha := (Not objMetaCusto.fCarregaMetas(dtaDtaEnt, strCodEmp, strCodCta, strNumPed, strConPag,
                                            fltTotPed + fStrToFloat(edtValFre.Text) + fStrToFloat(edtDesAce.Text),
                                            False {blnRecalcularDuplictas}, objDuplicatasPedido.arrParcelas, strCodCmp, strCodEve));

  Result := IIF(blnPedeSenha, objMetaCusto.fPedeSenha, True);
End;

function TfrmDigObservacoes.fValidaCondPagamento(
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If fEmptyStrEspeciais(mskCndPag.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
    Result := False;
  End
  Else If fEmptyStr(Copy(mskCndPag.Text, 1, 2)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Condição de pagamento inválida!', ['&O k']);
    Result := False;
  End
  Else If StrToInt(Copy(mskCndPag.Text, 1, 2)) > 24 Then
  Begin
    fMensagem('', 'Não é permitido mais que 24 parcelas!', ['&O k']);
    Result := False;
  End
  Else If Not fValidaCndPag(mskCndPag.Text, strConPag, StrToDateDef(mskDtaPed.Text, 0)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
    Result := False;
  End Else
  Begin
    mskCndPag.Text := strConPag;

    If fEmptyStr(strConPag) Then
      Result := False;

  End;

  If Not chkPgAVis.Checked And (fStatusCndPag(fTiraCaracEspeciais(mskCndPag.Text)) = A_VISTA) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é permitida!', ['&O k']);
    Result := False;
  End;

end;

function TfrmDigObservacoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  var
    cmbTipFreLoc: TComboBoxFocus;
    strMensagem: String;
    i: integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaPed) Then
    Begin

      If pnlDadosIniciais.Visible Then
      Begin

        If fEmptyDate(mskDtaPed.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data de entrega deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          mskDtaPed.Text := FormatDateTime('DD/MM/YYYY', StrToDate(mskDtaPed.Text));

          // Validação: Impede que a entrega seja menor que o faturamento
          // O "blnConfirmando" garante que isso só será testado ao clicar em "Confirma"
          If blnConfirmando And (Not fEmptyDate(mskDtaFat.Text)) Then
          Begin
            If StrToDate(mskDtaPed.Text) < StrToDate(mskDtaFat.Text) Then
            Begin
              fMensagem('ATENÇÃO!', 'A data de entrega não pode ser menor que a data de faturamento!', ['&O k']);
              Result := False;
            End;
          End;
        End;
      End;

    End

    Else If (Sender = mskDtaFat) Then
    Begin

      If pnlDadosIniciais.Visible Then
      Begin

        If fEmptyDate(mskDtaFat.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data do faturamento deve ser preenchida!', ['&O k']);
          Result := False;
        End

        Else
        Begin
          mskDtaFat.Text := FormatDateTime('DD/MM/YYYY', StrToDate(mskDtaFat.Text));

          // Nova Lógica: Só faz a pergunta se NÃO estiver clicando no botão Confirma
          If blnPastaDeCompra And (Not blnConfirmando) And (intDiaDif > 0) Then
          Begin
            If  fMensagem('Atenção', 'Deseja recalcular a data de entrega somando o prazo de ' + IntToStr(intDiaDif) + ' dias?', ['&Sim', '&Não']) = 1 Then
            Begin
              mskDtaPed.Text := DateToStr(StrToDate(mskDtaFat.Text) + intDiaDif);
            End;
          End;
        End;
      End;

    End

    Else If (Sender = edtCodCmp) Then
    Begin

      If pnlDadosIniciais.Visible And (Not blnPastaDeCompra) Then
      Begin

        edtNomCmp.Text := fRetNomVendRep(fRetCodVendedor(edtCodCmp.Text));
        Result := Not fEmptyStr(edtNomCmp.Text);

        If Result Then
        Begin
         // If blnBuscaPorChave And fTemItensDeOutroResponsavel Then
         //   Result := fLiberaAlteracaoOutroResponsavel('PEDIDO COM ITENS DE OUTRO RESPONSÁVEL PELO GRUPO DE COMPRAS!', '');
        End
        Else pMensagemOk('Senha do comprador inválida!');

      End;

    End

    Else If (Sender = mskCndPag) Then
    Begin

      If pnlDadosIniciais.Visible And (Not blnPastaDeCompra) Then
      Begin
        Result := fValidaCondPagamento(blnBuscaPorChave);
      End;

    End

    Else If (Sender = edtCodOco) And (Not blnPastaDeCompra) Then
    Begin

      If pnlDadosIniciais.Visible Then
      Begin

        If fEmptyStr(edtCodOco.Text) Then
        Begin
          Result := False;
          pMensagemOk('Informe a ocorrência para baixa dos pedidos que serão unificados!');
        End;

      End;

    End

    Else If (Sender = memObserv) Then
    Begin
      strObserv1  := Copy(memObserv.Lines.Text, 1, 240);
      strObserv2  := Copy(memObserv.Lines.Text, 241, 240);
      strObserv3  := Copy(memObserv.Lines.Text, 481, 240);
      strObserv4  := Copy(memObserv.Lines.Text, 721, 240);
      strObserv5  := Copy(memObserv.Lines.Text, 961, 240);
      strObserv6  := Copy(memObserv.Lines.Text, 1201, 240);
    End

    Else  If (Sender = edtCodTra) Then
    Begin
      If Not fEmptyStr(edtCodTra.Text) Then
      Begin
        pCarregaTransportadora(False);
        If qryConTr2.FieldByName('TRA_CODTRA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse transportador não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else  If (Sender = edtCodTraRedespacho) Then
    Begin
      If Not fEmptyStr(edtCodTraRedespacho.Text) Then
      Begin
        pCarregaTransportadora(True);
        If qryConTr2.FieldByName('TRA_CODTRA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse transportador não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    {Validar o tipo do frete apenas se o código da transportadora estiver preenchida}
    Else If ((Sender = cmbTipFre) And (Not fEmptyStr(edtCodTra.Text))) Or
            ((Sender = cmbTipFreRedespacho) And (Not fEmptyStr(edtCodTraRedespacho.Text)))  Then
    Begin
      If Sender = cmbTipFre Then
        cmbTipFreLoc := cmbTipFre
      Else
        cmbTipFreLoc := cmbTipFreRedespacho;

      If pnlFrete.Visible Then
      Begin

        If fEmptyStr(cmbTipFreLoc.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Tipo de Frete deve ser preenchido',['&O K']);
          Result := False;
        End
        Else
        If (Not fFreteValido(fTipoFrete(cmbTipFreLoc.Text))) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Tipo de Frete deve conter somente 1, 2, 3 ou 9!',['&O K']);
          Result := False;
        End
        Else If (Not fPermiteFreteProprio(fTipoFrete(cmbTipFreLoc.Text))) Then
          Result := False
        Else
        Begin
          If Sender = cmbTipFre Then
          begin
            strCodTra   := edtCodTra.Text;
            strNomTra   := edtNomTra.Text;
            strEndere   := edtEndere.Text;
            strCidade   := edtCidade.Text;
            strTipFre   := fTipoFrete(cmbTipFreLoc.Text);
          End
          Else
          begin
            strCodTraRedespacho   := edtCodTraRedespacho.Text;
            strNomTraRedespacho   := edtNomTraRedespacho.Text;
            strEndereRedespacho   := edtEndereRedespacho.Text;
            strCidadeRedespacho   := edtCidadeRedespacho.Text;
            strTipFreRedespacho   := fTipoFrete(cmbTipFreLoc.Text);
          End;
        End;
      End
      Else
      Begin
        If Sender = cmbTipFre Then
          strTipFre   := '9'
        Else
          strTipFreRedespacho   := '9'
      End;

    End

    Else If (Sender = edtValFre) Then
    Begin

      If pnlFrete.Visible Then
      Begin
        If fEmptyStr(edtValFre.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Valor do Frete deve ser preenchido',['&O K']);
          Result := False;
        End
        Else
        Begin
          If (fStrToFloat(edtValFre.Text) < 0) Then
          Begin
            fMensagem('ATENÇÃO','O Campo Valor do Frete deve ser maior ou igual a zero!',['&O K']);
            Result := False;
          End
          Else
          Begin
            fltValFre := fStrToFloat(edtValFre.Text);
            pCarregaPercFreteTotItem;
          End;
        End;

      End;

    End

    Else If (Sender = edtDesAce) Then
    Begin

      If pnlFrete.Visible Then
      Begin

        If fEmptyStr(edtDesAce.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Despesas Acessórias deve ser preenchido',['&O K']);
          Result := False;
        End
        Else
        Begin
          If (fStrToFloat(edtDesAce.Text) < 0) Then
          Begin
            fMensagem('ATENÇÃO','O Campo Despesas Acessórias deve ser maior ou igual a zero!',['&O K']);
            Result := False;
          End
          Else
          Begin
            fltDesAce := fStrToFloat(edtDesAce.Text);
            pCarregaPercDesAceTotItem;
          End;
        End;

      End;

    End
    Else If (Sender = edtPedVen) Then
    Begin
      If Not fEmptyStr(edtPedVen.Text) Then
      Begin
        ListaPedido.Clear;
        ListaPedido.Delimiter := ',';
        ListaPedido.CommaText := edtPedVen.Text;
        strMensagem := '';
        For i := 0 To ListaPedido.Count -1 Do
        Begin
          If Length(ListaPedido[i]) < fTamDocCadRec Then
            ListaPedido[i] := fStrZero(ListaPedido[i], fTamDocCadRec);
          If Not fEncontraPedidoVenda(ListaPedido[i]) Then
            strMensagem := strMensagem + '[' + ListaPedido[i]+ ']'
        End;

        edtPedVen.Text := '';
        For i := 0 To ListaPedido.Count -1 Do
        Begin
          If i = ListaPedido.Count -1 Then
            edtPedVen.Text := edtPedVen.Text + ListaPedido[i]
          Else
            edtPedVen.Text := edtPedVen.Text + ListaPedido[i] + ',';
        End;

        If strMensagem <> '' Then
        Begin
          fMensagem('','Não foi encontrado o(s) pedido(s) digitado(s): '+strMensagem+'!',['&OK']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtAtenca) Then
    Begin
      strAtenca   := edtAtenca.Text;
    End

    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin

      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);

        If (fEmptyStr(fraCentroCusto.edtDesEve.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='R') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse evento pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End;

      End
      Else
      Begin

        If (fCfgSis('METPED', varString) = '5') Or
           (fCfgSis('METPED', varString) = '6') Then
        Begin
          If fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Centro de Custo deve ser preenchido!', ['&O k']);
            Result := False;
          End;
        End;

        fraCentroCusto.edtDesEve.Clear;

      End;

      strCodEve := fraCentroCusto.edtCodEve.Text;
    End

    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin

      If fraPlanoDeContas.MskCodCta.Visible Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas da Baixa deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          fraPlanoDeContas.edtDesCta.Text := fRetDescCentroCusto(fraPlanoDeContas.MskCodCta.Text, IIf(fCfgSis('USACTF', varBoolean), strCodFor, ''));

          If (fEmptyStr(fraPlanoDeContas.edtDesCta.Text)) Then
          Begin
            If Not fCfgSis('USACTF', varBoolean) Then
              fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k'])
            Else
              fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&O k']);

            Result := False;
          End
          Else If Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Plano de Contas não permitido!', ['&O k']);
            Result := False;
          End
          Else
            Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True);

        End;

        strCodCta := fraPlanoDeContas.MskCodCta.Text;

      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function fFormataFone(strFone: String): String;
Begin
  strFone := Trim(fTiraCaracEspeciaisParenteses(strFone));
  If Length(strFone) > 6 Then
  Begin
    Insert('-',strFone,Length(strFone)-3);

    If Length(strFone) > 8 Then
    Begin
      Insert(')',strFone,3);
      strFone := '('+ strFone;
    End;
  End;
  Result := strFone;
End;

procedure TfrmDigObservacoes.pCarregaTransportadora(blnRedespacho: Boolean = False);
  Var
    strSQL: String;
    edtCodTraLoc: TEditFocus;
    edtNomTraLoc: TEditFocus;
    edtEndereLoc: TEditFocus;
    edtCidadeLoc: TEditFocus;

begin
  If blnRedespacho Then
  Begin
    edtCodTraLoc := edtCodTraRedespacho;
    edtNomTraLoc := edtNomTraRedespacho;
    edtEndereLoc := edtEndereRedespacho;
    edtCidadeLoc := edtCidadeRedespacho;
  End
  Else
  Begin
    edtCodTraLoc := edtCodTra;
    edtNomTraLoc := edtNomTra;
    edtEndereLoc := edtEndere;
    edtCidadeLoc := edtCidade;
  End;



  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  TRA_CODTRA, ';
  strSQL := strSQL + '  TRA_NOMTRA, ';
  strSQL := strSQL + '  TRA_ENDERE, ';
  strSQL := strSQL + '  TRA_BAIRRO, ';
  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  CID_ESTADO, ';
  strSQL := strSQL + '  TRA_FONE01  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADTRA ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON (TRA_CODCID = CID_CODCID) ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRA_CODTRA = :CODTRA ';

  With qryConTr2 Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODTRA').AsString := edtCodTraLoc.Text;
    Open;

    edtNomTraLoc.Text := FieldByName('TRA_NOMTRA').AsString;
    edtEndereLoc.Text := FieldByName('TRA_ENDERE').AsString + ' - ' + FieldByName('TRA_BAIRRO').AsString;
    edtCidadeLoc.Text := FieldByName('CID_NOMCID').AsString + ' - ' + FieldByName('CID_ESTADO').AsString +
                      ' - Fone: ' + fFormataFone(FieldByName('TRA_FONE01').AsString);

  End;
end;

procedure TfrmDigObservacoes.FormCreate(Sender: TObject);
  Var
    intTipFre: Integer;
begin
  inherited;
  {Se resolução disponível for inferior ou igual à (1366 x 768), ajusta a tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  pRateiaFreteDesAce := Nil;

  fltFreAntOri := 0;
  fltDesAntOri := 0;

  fltFreAnt := 0;
  fltDesAnt := 0;

  blnBStFreAnt := True;
  blnBIPIFreAnt := False;
  blnBStAceAnt := True;

  SetLength(arrCodCta, 0);

  fltValFre := 0;
  fltDesAce := 0;

  blnCotacao         := False;
  cdsItensPedido     := Nil;
  cdsItensMultiLojas := Nil;

  objMetaCusto := TMetaCentroCustoPedido.Create(Self);

  cmbTipFre.Clear;
  cmbTipFreRedespacho.Clear;
  For intTipFre In TiposFrete Do
  Begin
    cmbTipFre.Items.Add(fDescricaoFrete(IntToStr(intTipFre)));
    cmbTipFreRedespacho.Items.Add(fDescricaoFrete(IntToStr(intTipFre)));
  End;

  blnVariasEmpresasDestino := False;

  blnConfirma := False;

  qryConTr2 := fCriaQuery(Self);
  qryConFgo := fCriaQuery(Self);

  {*****************************}
  {* SUGESTÃO DE TIPO DE FRETE *}
  {**************************RV*}
  cmbTipFre.ItemIndex := cmbTipFre.Items.IndexOf(fDescricaoFrete(fCfgSis('FREPDC')));
  cmbTipFreRedespacho.ItemIndex := cmbTipFreRedespacho.Items.IndexOf(fDescricaoFrete('9'));

  edtValFre.Text   := '0,00';
  edtDesAce.Text   := '0,00';

//  edtPedVen.MaxLength := fTamDocCadRec;
//  edtPedVen.TamCampo  := fTamDocCadRec;

  pCarregaEmpresas;
  mskCndPag.EditMask := MASK_CONPAG;

  cbxEnviarWhatsapp.Visible := fCfgSis('UTIWPP', varBoolean);
  cbxEnviarWhatsapp.Checked := cbxEnviarWhatsapp.Visible And fCfgSis('EMAWTS', varBoolean);

  If Not cbxEnviarWhatsapp.Visible Then
    gpbAtencao.Height := 42;

  ListaPedido := TStringList.Create;
end;

procedure TfrmDigObservacoes.pTransformaAutoincremEmNumPed(var PedVen: String);
  var
    qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery();
  Try
    qryConsulta.SQL.Add('SELECT FGO_NUMDOC FROM FATGOR ');
    qryConsulta.SQL.Add(' WHERE FATGOR.AUTOINCREM IN (' + PedVen + ')');
    qryConsulta.Open;


    PedVen := '';
    While not qryConsulta.EoF Do
    Begin
      if qryConsulta.RecNo = qryConsulta.RecordCount Then
        PedVen := PedVen + qryConsulta.FieldByName('FGO_NUMDOC').AsString
      ELse
        PedVen := PedVen + qryConsulta.FieldByName('FGO_NUMDOC').AsString + ',';
      qryConsulta.Next;
    End;


  Finally
    FreeAndNil(qryConsulta);
  End;

End;



Procedure TfrmDigObservacoes.pCarregaEmpresas;
  Var
    qryCadEmp: TUniQuery;
Begin
  qryCadEmp := fCriaQuery(Nil);

  With qryCadEmp, SQL Do
  Begin
    Add('SELECT');
    Add('CONCAT(EMP_CODEMP, " - ", EMP_NOMEMP, " - ",');
    Add('INSERT( INSERT( INSERT( INSERT( EMP_C_G_C_, 13, 0, ''-'' ), 9, 0, ''/'' ), 6, 0, ''.'' ), 3, 0, ''.'')) AS EMP, ');
    Add('EMP_C_G_C_ AS CGC');
    Add('FROM CADEMP');
    Open;

    While Not Eof Do
    Begin
      cmbEmpresas.Items.Add(FieldByName('EMP').AsString);
      Next;
    End;

    cmbEmpresas.ItemIndex := -1;
  End;

  FreeAndNil(qryCadEmp);
End;

procedure TfrmDigObservacoes.pCarregaPercDesAceTotItem;
begin
  lblPerAceVlr.Caption := '0,00';
  If fltTotIte > 0 Then
    lblPerAceVlr.Caption := FormatFloat('#0.00', ((StrToFloat(AnsiReplaceStr(edtDesAce.Text, '.', '' ))*100)/fltTotIte));
end;

procedure TfrmDigObservacoes.pCarregaPercFreteTotItem;
begin
  lblPerFreVlr.Caption := '0,00';
  If (fltTotIte > 0) Then
    lblPerFreVlr.Caption := FormatFloat('#0.00', ((StrToFloat(AnsiReplaceStr(edtValFre.Text, '.', '' ))*100)/fltTotIte));
end;

procedure TfrmDigObservacoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN : If ActiveControl Is TRadioButton Then
                  Self.SelectNext(ActiveControl, True, True);

  End;
end;

procedure TfrmDigObservacoes.FormShow(Sender: TObject);
begin
  inherited;
  If blnPastaDeCompra then
  Begin
    pnlDadosIniciais.Visible := blnPastaDeCompra;
    Label9.Visible := False;
    chkPgAVis.Visible := False;
    edtCodCmp.Visible := False;
    edtNomCmp.Visible := False;
    Label10.Visible := False;
    mskCndPag.Visible := False;
    Label11.Visible := False;
    edtCodOco.Visible := False;
    edtDesOco.Visible := False;
    rdgEndEnt.Visible := False;
    rdgTipoGravacao.Left := 16;
    pnlMultLojaPasta.Visible := blnVariasEmpresasDestino;
    lblPerFre.Visible := False;
    lblPerFre_.Visible := False;
    lblPerFreVlr.Visible := False;
    lblPerAce.Visible := False;
    lblPerAce_.Visible := False;
    lblPerAceVlr.Visible := False;
  End
  Else
    rdgTipoGravacao.Visible := False;

  btnParcel.Visible := Assigned(objDuplicatasPedido);

  If Not gpbFinalPed.Visible Then
  Begin
    gpbDadAdc.Parent    := pnlDireita;
    gpbDadAdc.Top       := 0;
    gpbDadAdc.TabOrder  := 0;
    gpbObservacao.Align := alClient;

    gpbAtencao.Align    := alBottom;

    Self.ClientHeight   := rgbTransRedespacho.Height + gpbTransportador.Height + gpbEntrega.Height +
                           pnlBotoes.Height + pnlStatus.Height + 6;

    If pnlDadosIniciais.Visible Then
      Self.ClientHeight := Self.ClientHeight + pnlDadosIniciais.Height;
  End

  Else If Not pnlDadosIniciais.Visible Then
          Self.ClientHeight := Self.ClientHeight - pnlDadosIniciais.Height;

  If Assigned(arrCodCta) And (Length(arrCodCta) > 1) Then
  Begin
    fraPlanoDeContas.MskCodCta.Visible := False;
    fraPlanoDeContas.edtDesCta.Visible := False;
    btnCodCta.Visible := True;
  End;

  btnParcel.Enabled := fStatusCndPag(strConPag) <> A_VISTA;

  fltFreAntOri := fStrToFloat(edtValFre.Text);
  fltDesAntOri := fStrToFloat(edtDesAce.Text);

  fltFreAnt := fStrToFloat(edtValFre.Text);
  fltDesAnt := fStrToFloat(edtDesAce.Text);

  blnBStFreAnt := chkCalStFrete.Checked;
  blnBIPIFreAnt := chkCalIPIFrete.Checked;
  blnBStAceAnt := chkCalStDesAce.Checked;

  pCarregaPercFreteTotItem;

  pCarregaPercDesAceTotItem;

  chkEnvEmailAutomatico.Visible := chkEnvEmailAutomatico.Visible;
  chkEnvEmailAutomatico.Checked := chkEnvEmailAutomatico.Visible And fCfgSis('EMAWTS', varBoolean);
end;

procedure TfrmDigObservacoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  blnEnviarWhatsapp := cbxEnviarWhatsapp.Checked;
  If Not blnConfirma  Then
    pVeSeRateiaFreteDesAce(fltFreAntOri, fltDesAntOri)
  Else If blnPastaDeCompra Then
    pVeSeRateiaFreteDesAce(fStrToFloat(edtValFre.Text), fStrToFloat(edtDesAce.Text));

  qryConTr2.Close;
  qryConFgo.Close;

  FreeAndNil(qryConTr2);
  FreeAndNil(qryConFgo);
  FreeAndNil(ListaPedido);
End;

{********************************}
{* PESQUISA NO FATGOR SE EXISTE *}
{* O DOCUMENTO DIGITADO         *}
{*****************************AF*}
function TfrmDigObservacoes.fEncontraPedidoVenda(strNumDoc: String): Boolean;
  Var
    strSQL   : String;
    qryGenGor: TUniQuery;

Begin
  Try

    Result := True;

    qryGenGor := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  FATGOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FGO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FGO_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  FGO_ESPDOC = "PD" ';

    With qryGenGor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If IsEmpty Then
        Result := False;

      Close;
    End;

  Finally
    FreeAndNil(qryGenGor);
  End;

End;


procedure TfrmDigObservacoes.edtPedVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrDoc: TConsultasArray;
    strVendas: String;
    I : Integer;

begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    {*******************************}
    {* NOVA CONSULTA DE DOCUMENTOS *}
    {****************************RV*}
    If fPesqPedOrc(conPedSimples, Self, 'PD', 'PD', VS_strCodEmp, edtPedVen, Nil, Nil, qryTabela, Key, arrDoc,
                   False, Nil, '','N', '', False, False, '', '', True) Then
    Begin
      edtPedVen.Text := '';
      For i := 0 To High(arrDoc) Do
      Begin
        If i = High(arrDoc) Then
          edtPedVen.Text := edtPedVen.Text + '"' + arrDoc[i].strCodigo + '"'
        Else
          edtPedVen.Text := edtPedVen.Text + '"' + arrDoc[i].strCodigo + '",'
      End;

      strVendas := edtPedVen.Text;
      pTransformaAutoincremEmNumPed(strVendas);

      edtPedVen.Text := strVendas;
      If fValidaCampos(edtPedVen, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmDigObservacoes.btnCodCtaClick(Sender: TObject);
begin
  inherited;

  pCriarFormularios(TfrmDigCtaFornecedores, frmDigCtaFornecedores);

  frmDigCtaFornecedores.pCopiaCta(arrCodCta, frmDigCtaFornecedores.arrCodCta);

  If frmDigCtaFornecedores.ShowModal = mrOk Then
    frmDigCtaFornecedores.pCopiaCta(frmDigCtaFornecedores.arrCodCta, arrCodCta);

  pFreeAndNil(frmDigCtaFornecedores);
end;


procedure TfrmDigObservacoes.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not fCfgSis('USACTF', varBoolean) Then
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    Begin
      If Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha / Grupo não permitido!', ['&O k']);
      End
      Else
      Begin
        If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    End;
  End
  Else
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, True, strCodFor) Then
    Begin
      If Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha / Grupo não permitido!', ['&O k']);
      End
      Else
      Begin
        If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    End;
  End;

end;

Function TfrmDigObservacoes.fValidaArrCodCta: Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  If Assigned(arrCodCta) And (Length(arrCodCta) > 1) Then
  Begin

    For intContador := Low(arrCodCta) To High(arrCodCta) Do
      If fEmptyStr(arrCodCta[intContador].strCodCta) Then
      Begin
        pMensagemOk('Informe o Plano de Contas para cada fornecedor!');
        Result := False;
        Break;
      End;

  End;

  If Not Result Then
    btnCodCta.Click;
End;

Function TfrmDigObservacoes.fValidaParcelas: Boolean;
Begin
  Result := True;

  If Not Assigned(objDuplicatasPedido) Then
    Exit;

  If (fStatusCndPag(strConPag) = A_VISTA) Then
    objDuplicatasPedido.pLimpaParcelas;

  pVeSeRateiaFreteDesAce(fStrToFloat(edtValFre.Text), fStrToFloat(edtDesAce.Text));

  If (fStatusCndPag(strConPag) <> A_VISTA) And
     ((RoundTo(fltTotPed + fStrToFloat(edtValFre.Text) + fStrToFloat(edtDesAce.Text), -2) <> RoundTo(objDuplicatasPedido.fGetTotalParcelas, -2)) Or
      (strConPag <> objDuplicatasPedido.fGetCondPagamento(dtaDtaEnt)) ) Then
  Begin

    If objDuplicatasPedido.blnManterValoresPadrao Then
    Begin

      pCalculaDuplicatasPedido(False);

    End Else
    Begin
      Result := False;
      btnParcel.Click;
    End;

  End

End;

procedure TfrmDigObservacoes.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  blnConfirmando := True; // Avisa o sistema que estamos no fluxo final
  try
    If fVerificaCampos And
       fValidaArrCodCta And
       fValidaParcelas And // SEMPRE ANTES DO VALIDA METAS, PARA CALCULAR AS PARCELAS
       fValidaMeta(dtaDtaEnt, fraPlanoDeContas.MskCodCta.Text, strCodFor, strNumPed, VS_strCodEmP, strCodComprador,
                   fltTotGer + fStrToFloat(edtValFre.Text) + fStrToFloat(edtDesAce.Text), strCodEve) Then
    Begin
      strEspDoc := IIf(rdgTipoGravacao.ItemIndex = 0, 'PD', 'OR');
      blnConfirma := True;
      Close;
    End Else
    Begin
      blnConfirma := False;
    End;
  finally
    blnConfirmando := False; // Desliga a flag independente do resultado
  end;
end;

procedure TfrmDigObservacoes.btnParcelClick(Sender: TObject);
begin
  inherited;

  If Not btnParcel.Visible Then
    Exit;

  If pnlDadosIniciais.Visible Then
  Begin
    If Not fValidaCampos(mskDtaPed, True) Then
      Exit;

    If Not fValidaCampos(mskCndPag, True) Then
      Exit;

    If fStatusCndPag(strConPag) = A_VISTA Then
      Exit;

    dtaDtaEnt := StrToDateDef(mskDtaPed.Text, 0);
  End;

  pVeSeRateiaFreteDesAce(fStrToFloat(edtValFre.Text), fStrToFloat(edtDesAce.Text));
  pCalculaDuplicatasPedido(True);
End;

Procedure TfrmDigObservacoes.pVeSeRateiaFreteDesAce(fltValFre, fltDesAce: Double);
Begin
  If ((fltFreAnt <> fltValFre) Or
      (fltDesAnt <> fltDesAce) Or
      (blnBStFreAnt <> chkCalStFrete.Checked)    Or
      (blnBIPIFreAnt <> chkCalIPIFrete.Checked)    Or
      (blnBStAceAnt <> chkCalStDesAce.Checked)) And
     Assigned(pRateiaFreteDesAce) And
     Assigned(cdsItensPedido) Then
  Begin
    pRateiaFreteDesAce(True, fltValFre, fltDesAce,
                       IIF(chkCalStFrete.Checked, 'S', 'N'),
                       IIF(chkCalStDesAce.Checked, 'S', 'N'),
                       IIF(chkCalIpiFrete.Checked, 'S', 'N'));

    if blnPastaDeCompra Then
      fltTotPed := fDoubleAggregate(cdsItensPedido, 'TOTITE')
    Else
      fltTotPed := fDoubleAggregate(cdsItensPedido, 'TOT_TOTGER');

    fltFreAnt := fltValFre;
    fltDesAnt := fltDesAce;
  End;
End;

procedure TfrmDigObservacoes.pCalculaDuplicatasPedido(blnMostrarTela: Boolean);
  Var
    fltTotPar: Double;
    arrNovasParcelas: TarrDuplicata;
    arrDuplicata: TarrDuplicata;
Begin
  pZeraDigDuplic(arrDuplicata);
  fltTotPar := RoundTo(fltTotPed + fStrToFloat(edtValFre.Text) + fStrToFloat(edtDesAce.Text), -2);

  If (Not objDuplicatasPedido.blnManterValoresPadrao) Then
  Begin

    // Mudou apenas o total do pedido =>  Recalcula as parcelas proporcionalmente e abre a tela de duplicatas
    If ( (RoundTo(fltTotPar, -2) <> RoundTo(objDuplicatasPedido.fGetTotalParcelas, -2)) Or
         (strConPag <> objDuplicatasPedido.fGetCondPagamento(dtaDtaEnt)) ) And
       (LeftStr(strConPag, 2) = LeftStr(objDuplicatasPedido.fGetCondPagamento(dtaDtaEnt), 2)) Then
    Begin
      objDuplicatasPedido.pCalculaDuplicatasProporcional(strConPag, strCodFor, fltTotPar, fltTotIte, dtaDtaEnt, arrNovasParcelas);

      arrNovasParcelas[0].blnManterValoresPadrao := objDuplicatasPedido.arrParcelas[0].blnManterValoresPadrao;

      objDuplicatasPedido.pCopiaDuplicatas(arrNovasParcelas, objDuplicatasPedido.arrParcelas, strConPag);
    End;

  End;

  If objDuplicatasPedido.fDigDuplicPedido(arrDuplicata, strConPag, strCodFor,
       fltTotPar, fltTotIte, dtaDtaEnt, blnMostrarTela, True {blnEditavel},
       (RoundTo(fltTotPar, -2) = RoundTo(objDuplicatasPedido.fGetTotalParcelas, -2)) And
       (strConPag = objDuplicatasPedido.fGetCondPagamento(dtaDtaEnt)) {blnManterValoesOriginais}) Then
  Begin
    objDuplicatasPedido.pSetaDuplicatas(arrDuplicata, strConPag);

    strConPag := objDuplicatasPedido.fGetCondPagamento(dtaDtaEnt);

    If pnlDadosIniciais.Visible Then
      mskCndPag.Text := strConPag;
  End;

end;

procedure TfrmDigObservacoes.chkPgAVisClick(Sender: TObject);
begin
  inherited;

  If chkPgAVis.Checked Then
  Begin
    If (intCarPag = 0) Then
      mskCndPag.Text := '01000'
    Else
      mskCndPag.Text := '01' + fStrZero(intCarPag, 3);
    mskCndPag.Enabled := False;
  End
  Else
    mskCndPag.Enabled := True;

  btnParcel.Enabled := Not chkPgAVis.Checked;
end;

procedure TfrmDigObservacoes.cmbEmpresasChange(Sender: TObject);
  var strNomEmp, strEndEmp, strCidEmp: String;
begin
  inherited;

  If Not fEmptyStr(cmbEmpresas.Text) Then
  Begin

    strNomEmp := '';
    strEndEmp := '';
    strCidEmp := '';

    pDadosEntregaPedido(strNomEmp, strEndEmp, strCidEmp, LeftStr(cmbEmpresas.Text, 3));

    edtNomEmp.Text := strNomEmp;
    edtEndEmp.Text := strEndEmp;
    edtCidEmp.Text := strCidEmp;

  End;
end;

procedure TfrmDigObservacoes.cmbTipFreChange(Sender: TObject);
begin
  inherited;
  If fTipoFrete(cmbTipFre.Text) <> '' Then
    strTipFre := fTipoFrete(cmbTipFre.Text);
end;

procedure TfrmDigObservacoes.cmbTipFreRedespachoChange(Sender: TObject);
begin
  inherited;
  if fTipoFrete(cmbTipFreRedespacho.Text) <> '' Then
    strTipFreRedespacho := fTipoFrete(cmbTipFreRedespacho.Text);
end;

procedure TfrmDigObservacoes.edtCodOcoExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodOco,
                    edtDesOco,
                    arrOcor,
                    Nil,
                    fRetDescOcorrencia,
                    'da Ocorrência');
end;

procedure TfrmDigObservacoes.edtCodOcoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqOcorrencia(Self, edtCodOco, edtDesOco, Nil, Key, arrOcor) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmDigObservacoes.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTransp: TConsultasArray;
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  If fPesqTransportadora(conTraSimples, Self, edtCodTra, edtNomTra, Nil, Key, arrTransp) Then
  Begin
    pCarregaTransportadora;
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(edtCodTra, True, True);
  End;
end;

procedure TfrmDigObservacoes.edtCodTraRedespachoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTransp: TConsultasArray;
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  If fPesqTransportadora(conTraSimples, Self, edtCodTraRedespacho, edtNomTraRedespacho, Nil, Key, arrTransp) Then
  Begin
    pCarregaTransportadora(True);
    If fValidaCampos(edtCodTraRedespacho, True) Then
      SelectNext(edtCodTraRedespacho, True, True);
  End;

end;

procedure TfrmDigObservacoes.pHabilitaEndEnt;
Begin
  If rdgOpcMultiLojas.ItemIndex = 0 Then
    rdgEndEnt.ItemIndex := 0;

  rdgEndEnt.Enabled := (rdgOpcMultiLojas.ItemIndex = 1);
End;

procedure TfrmDigObservacoes.rdgOpcMultiLojasClick(Sender: TObject);
begin
  inherited;
  If rdgOpcMultiLojas.ItemIndex = 1 Then
  Begin
    If fCfgSis('PDCGTR', varBoolean) Then
    Begin
      If fPedidoBaixadoPelaEntrada(strNumPed,strEmpPed,strEspDoc) Then
      Begin
        rdgOpcMultiLojas.ItemIndex := 0;
        pMensagemOk('O Pedido foi usado por uma entrada, não pode ser desmembrado.');
      End
      Else If fPedidoEstaEmPreNota(strNumPed,strEmpPed,strEspDoc) Then
      Begin
        rdgOpcMultiLojas.ItemIndex := 0;
        pMensagemOk('O Pedido esta em Pré-Nota, não pode ser desmembrado.');
      End;

    End;
  End;


  If rdgOpcMultiLojas.ItemIndex = 1 Then
    strFinPed := 'S'
  Else
    strFinPed := 'N';

  pHabilitaEndEnt;
end;

end.



