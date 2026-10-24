unit untBaixaDigValores;

interface

uses
  Classes, Windows, Controls, StdCtrls, untPaiSimples, Mask, MaskEditFocus,
  EditFocus, Math,ComCtrls, Buttons, ExtCtrls, Menus, QColorLabel, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, untTypesSistema,
  UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels, untFechamentoFinanceiro,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, untLiberacao,untMsgLiberacao, Uni, untTlogLibRec, untLogLibCtp;

type
  TTipoBaixa = (tbCtaPagar,tbCtaReceber);

  TfrmBaixaDigValores = class(TfrmPaiSimples)
    Label1: TLabel;
    edtTipBai: TEditFocus;
    Label2: TLabel;
    edtValPag: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    pnlConfirma: TPanel;
    ColorLabel2: TColorLabel;
    edtValJur: TEditFocus;
    edtValDes: TEditFocus;
    pnlFundo: TPanel;
    rgpTipDes: TRadioGroup;
    lblVendor: TLabel;
    edtVendor: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlJuros: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtTotalizaValOri: TEditFocus;
    edtTotalizaJurSuj: TEditFocus;
    edtTotalizaDesSuj: TEditFocus;
    edtTotalizaValJur: TEditFocus;
    edtTotalizaValDes: TEditFocus;
    edtTotalizaValFin: TEditFocus;
    mskDtaPag: TcxDateEdit;
    edtValCob: TEditFocus;
    Label12: TLabel;
    Label13: TLabel;
    edtOutrasEntidades: TEditFocus;
    {Edit só será visual quando disponilizado o campo Multa na manutenção do contas a receber}
    edtTotalizaMulSuj: TEditFocus;
    lblMultaCad: TLabel;
    edtValMul: TEditFocus;
    lblMulta: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtValDesChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtTipBaiChange(Sender: TObject);
    procedure edtValPagEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaDadosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    strDtaAnt: String;
    arrMenSag: TStringArray;
    fltValDupInicial: Double;
    blnLibRet: Boolean;
    blnParcial: Boolean;
    blnCalculado : Boolean;  //Boolean que verifica se já fez o calculo.
    fltValRecAnt: Double; //Valor Anterior
    fltValCobAnt: Double;
    fltValRecOri : Double; // Valor Original
    fltValDespon : Double;  // Desconto de Pontualidade CFG_DESPON
    objLiberacao : TLiberacao;
    objFechamento: TFechamentoFinanceiro;
    objLogLibRec : TLogLibRec;

    FValorNovaDuplicata,
    FJurosNovaDuplicata,
    FDescontoNovaDuplicata,
    FDespesasNovaDuplicata,
    FValorBaixaDuplicata,
    FJurosBaixaDuplicata,
    FDescontoBaixaDuplicata,
    FDespesasBaixaDuplicata,
    FFatorBaixaDuplicata,
    FFatorJurosDuplicata,
    FFatorDescontoDuplicata,
    FFatorDespesasDuplicata,
    FValorCorrigidoSemPontualidade: Double;

    FCalculoBaixaParcial: Double;
    blnFLiberouDataRetroativa: Boolean;
    FLiberouLiberacaoPendente : Boolean;
    FBaixaCTPZerado:Boolean;

    blnDupTemDespCob : Boolean;

    fltPercJurAplInicial : Double;
    fltValCobCtr         : Double;
    FCreditoGeradoPorDevolucao: Boolean;

    procedure pCalculaJurosFuturo(fltPerJur: Double; strDtaPag: String; fltPerMul : Double = 9999);
    function fValorCalculado(fltValSuj, fltJuros, fltPerDPo, fltDesCob : Double): Double;
    function fCalcJurosDesconto: Boolean;
    function fChamaSenhaVariavel(strMsg : String = '';  strDirAce : String = '';
                                 strCfgSis : String = ''; strMsgSen : String = '';
                                 strOperador : String = ''; strNTrava : String = '';
                                 strDirAceNv2: String = ''; strSenLibNv2: String = '';
                                 blnNivel2: Boolean = False): Boolean;
    //function fVerificaDescontoMaximo: Boolean;
    procedure pDescontoPontualidade;  //Verifica desconto pontualidade CFG_DESPON
    procedure pJurosMinimo;
    function fGetPercentual(fltValBase,fltValOri: Double):Double;
    function fLiberaBaixaRetroativaComJuros: Boolean;
    function fLiberacaoBaixaTotalComDesconto(flTotDup,
      flTotPago: Real): Boolean;
    function fLibBxRetroativaAcimaPermitido: Boolean;
    function fLibBxRetroativaAcimaPermitidoCTR: Boolean;
    function LiberacaoBaixaDuplicataComLiberacaoPedente: Boolean;
    function fValidaLogLibCtp: Boolean;
    procedure pAlteraValorDespCob;
    function fCalculaJurosDupAlt(fltValDuplic: Double; VarPercenJur: Double = 9999): Double;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    tibTipBai: TTipoBaixa;
    blnConfirma: Boolean;
    blnJurosMinimo,
    blnSenhaJuros : Boolean;
    blnVemCtr: Boolean;
    fltValJur: Double;
    fltValMul: Double;
    fltVendor: Double;
    fltOutEnt: Double;
    fltValDes: Double;
    dtaDtaCad: TDate;
    dtaDtaVen: TDate;
    dtaDtaPag: TDate;
    blnBolAdt : Boolean; //Boleto de pedido adiantamento
    fltPerDpo: Double;
    intQtdDav: Integer;
    FLogLibRec : TLogLibRec;
    fltValOri: Double;
    FLiberacaoPendente : Boolean;
    blnDupAnt : Boolean;

    cdsDupSel: TUniClientDataSet;

    sNumDup : String;
    sEspDup : String;
    sCodEmp : String;
    blnChmCaixa : Boolean;


    {*****************************************}
    {* VALORES RETORNADOS                    *}
    {**************************************MV*}
    strNumDup: String;
    strSerie: String;
    strCodEmp: String;
    strNomFor: String;
    strTipDes: String;
    strTipBai: String;
    strDtaRec: String;
    fltValPag: Double;
    fltValCal: Double;

    fltJurSuj: Double;
    fltMulSuj: Double;
    fltDesSuj: Double;

    fltValDup: Double; // Alimentado pelo form que chamar....
    fltJurDup: Double; // Alimentado pelo form que chamar....
    fltPerMul: Double; // Alimentado pelo form que chamar....
    fltDesCob: Double; // Alimentado pelo form que chamar....

    fltValDupComDescFinan: Double; // Alimentado pelo form que chamar....
    blnDescFinanSomenteAteVenc: Boolean; // Alimentado pelo form que chamar....
    strAutoIncrem: String; // Alimentado pelo form que chamar....
    strCodOpe: String;
    sNomCli: String;
    fltValAnt: Double;

    fltPercJuroAplic : Double;

    objLogLibCtp : TLogLibCtp;
    property LibRet: Boolean read blnLibRet;
    property CalculoBaixaParcial: Double read FCalculoBaixaParcial;
    property Liberacao: TLiberacao read objLiberacao;

    property ValorNovaDuplicata    : Double read FValorNovaDuplicata;
    property JurosNovaDuplicata    : Double read FJurosNovaDuplicata;
    property DescontoNovaDuplicata : Double read FDescontoNovaDuplicata;
    property DespesasNovaDuplicata : Double read FDespesasNovaDuplicata;
    property ValorBaixaDuplicata   : Double read FValorBaixaDuplicata;
    property JurosBaixaDuplicata   : Double read FJurosBaixaDuplicata;
    property DescontoBaixaDuplicata: Double read FDescontoBaixaDuplicata;
    property DespesasBaixaDuplicata: Double read FDespesasBaixaDuplicata;
    property FatorBaixaDuplicata   : Double read FFatorBaixaDuplicata;
    property FatorJurosDuplicata   : Double read FFatorJurosDuplicata;
    property ValorCorrigidoSemPontualidade : Double read FValorCorrigidoSemPontualidade write FValorCorrigidoSemPontualidade;
    property BaixaCTPZerado: Boolean Write FBaixaCTPZerado;
    property CreditoGeradoPorDevolucao: Boolean read FCreditoGeradoPorDevolucao write FCreditoGeradoPorDevolucao;
  end;


implementation

uses SysUtils, Forms, untFuncoes, untFuncFat, untFuncoesSimples, untFuncoesGenerica,
     untConstantes;

{$R *.dfm}

function TfrmBaixaDigValores.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtTipBai) Then
    Begin
      If (edtTipBai.Text <> 'T') And (edtTipBai.Text <> 'P') Then
      Begin
        Result := False;
      End

      Else If (Not (blnParcial) and (edtTipBai.Text = 'P')) And
        ((edtTipBai.Text = 'P') And {blnBuscaPorChave And} (tibTipBai = tbCtaReceber)) Then
      Begin

        If Assigned(objLogLibRec) Then
        Begin
          objLogLibRec.FNumDoc := sNumDup;
          objLogLibRec.FEspDoc := sEspDup;
          objLogLibRec.FCodEmp := sCodEmp;
        End;

        Result := fValidaBaixaParcial(strCodOpe, strLoginUsuarioLogado, objLogLibRec);
        blnParcial := Result;
      End;

      If Result And (edtTipBai.Text = 'P') And blnBolAdt Then
      Begin
        fMensagem('ATENÇÃO!','Não é possível realizar baixa parcial de duplicatas de espécie PD cujos boletos foram emitidos!', ['&Ok']);
        Result := False;
        Exit;
      End;

      If (Result) Then
      Begin
        If (edtTipBai.Text = 'P') And (blnDupAnt) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é possivel realizar baixa parcial de duplicatas com pagamento antecipado', ['&Ok']);
          Exit(False);
        End;
      End;
    End

    Else If (Sender = edtValCob) Then
    Begin
      If Not fEmptyStr(edtValCob.Text) Then
      Begin

         If (fltDesCob <> fStrToFloat(edtValCob.Text)) Then
            pAlteraValorDespCob;

         Result := fCalcJurosDesconto;

      End;
    End

    Else If (Sender = edtValPag) Then
    Begin
      If Not fEmptyStr(edtValPag.Text) Then
      Begin
        edtValPag.Text := FloatToStr(fFormataFloat(fStrToFloat(edtValPag.Text), 2));

        //If fStrToFloat(edtValPag.Text) <> fltVlrPagamentoInicial Then
        //   blnVlrPagamentoAlterado := True;

        if (fStrToFloat(edtValPag.Text) = 0) and (edtTipBai.Text = 'P') then
        begin
          fMensagem('', 'Para baixa parcial o valor pago deve ser diferente de zero!', ['&Ok']);
          Result := False;
        end
        Else
          Result    := fCalcJurosDesconto;
      End
      Else
      Begin
        fMensagem('', 'O valor pago deve ser preenchido!', ['&Ok']);
        Result := False;
      End;

      If Result And (blnBuscaPorChave) And (tibTipBai = tbCtaPagar) And
        (fStrToFloat(edtValJur.Text) > 0) And (Not fEmptyStr(fCfgSis('CTPJUR'))) Then
      Begin

        If ffrmSenha(strSenha,'Baixa com Juros') Then
        Begin

          If strSenha <> fCfgSis('CTPJUR') Then
          Begin
            fMensagem('','Senha Incorreta!',['&OK']);
            Result := False;
          End;

        End
        Else
          Result := False;

      End;

      If (StrToDate(mskDtaPag.Text) <> dtaDtaVen) Then
      Begin
        If Result And (blnBuscaPorChave) And (tibTipBai = tbCtaReceber) And
          (fStrToFloat(edtValJur.Text) > 0) Then
        Begin
          If Not blnSenhaJuros  Then
            pJurosMinimo
          Else
            blnJurosMinimo := True;

          Result := blnJurosMinimo;
        End;
      End;

      If (tibTipBai = tbCtaPagar)  Then
      Begin
        If FLiberacaoPendente Then
        Begin
          Result := LiberacaoBaixaDuplicataComLiberacaoPedente;
          blnLibRet := Result;
          FLiberouLiberacaoPendente := Result;
          FLiberacaoPendente := IIF(Result,False,True);
        End;
      End;

    End {Else If (Sender = edtValPag) Then}

    Else If (Sender = mskDtaPag) Then
    Begin
      If fEmptyStr(Trim(fTiraCaracEspeciais(mskDtaPag.Text))) Then
      Begin
        fMensagem('', 'A Data do Pagamento deve ser preenchida!', ['&Ok']);
        Result := False;
      End

      Else If blnVemCtr And (StrToDateDef(mskDtaPag.Text,0) < dtaDtaCad) Then
      Begin

        fMensagem('','A data do pagamento não pode ser menor que a data de cadastro!', ['&OK']);
        Result := False;

      End

      Else If blnVemCtr And (StrToDateDef(mskDtaPag.Text,0) < (VS_Date - fCfgSis('BAIATR', varInteger))) Then
      Begin

        fMensagem('','A data do pagamento não pode ser anterior ao número de dias configurado na "Qtd de dias para baixa atrasada"! [CFG_BAIATR]', ['&OK']);
        Result := False;

      End

      Else If blnVemCtr And (StrToDateDef(mskDtaPag.Text,0) > VS_Date) And (Not fCfgSis('BAIDAT', varBoolean)) Then
      Begin

        fMensagem('','A data do pagamento não pode ser maior que Hoje!', ['&OK']);
        Result := False;

      End

      Else If Not blnVemCtr And (StrToDateDef(mskDtaPag.Text,0) > VS_Date) And (Not fCfgSis('DTABAI', varBoolean)) Then
      Begin

        fMensagem('','A data do pagamento não pode ser maior que Hoje!', ['&OK']);
        Result := False;

      End

      Else if (tibTipBai = tbCtaPagar) And (StrToDateDef(mskDtaPag.Text,0) < dtaDtaCad) Then
      Begin
        fMensagem('','A data do pagamento não pode ser menor que a data de cadastro!', ['&OK']);
        Result := False;
        Exit;
      End

      Else If (tibTipBai = tbCtaPagar) And (StrToDateDef(mskDtaPag.Text,0) < VS_Date) Then
      Begin

        If (blnChmCaixa) Then
        Begin
           fMensagem('','A data do pagamento não pode ser retroativa quando '+#13+
                        'estiver sendo efetuada pelo resumo de caixa!' , ['&OK']);
           Result := False;
           Exit;
        End;

        {****************************************************}
        {* CONFIGURAÇÃO PARA VERIFICAR DIAS DE TOLERÂNCIA   *}
        {* PARA BAIXA DE CONTAS A PAGAR COM DATA RETROATIVA *}
        {* CASO UTILIZE ESSA CONFIGURAÇÃO O SISTEMA NÃO     *}
        {* CONSIDERA A CONFIGURAÇÃO DE SENHA PARA LIBERAR   *}
        {* BAIXA COM DATA RETROATIVA, DENTRO DO PERÍODO     *}
        {* INFORMADO SEMPRE PASSA E FORA DO PERÍODO SEMPRE  *}
        {* TRAVA                                            *}
        {*REQ-30691-13/02/2015****************************JU*}
        If (Not fEmptyStr(fCfgSis('BAIATP')))  And
           (fCfgSis('BAIATP', VarInteger) > 0) And
           (StrToDateDef(mskDtaPag.Text,0) < (VS_Date - fCfgSis('BAIATP', varInteger))) Then
        Begin
          If  StrToDateDef(mskDtaPag.Text,0) <> StrToDateDef(strDtaAnt,0) Then
            blnLibRet := False;

          If (Not blnLibRet) Then
          Begin
            Result := fLibBxRetroativaAcimaPermitido;
            blnLibRet := Result;
            strDtaAnt := mskDtaPag.Text;
          End;
        End;
        If (Result) and
           (Not fEmptyStr(fCfgSis('CTPRET'))) And
           (StrToDateDef(mskDtaPag.Text,0) <> StrToDateDef(strDtaRec,0)) Then
        Begin
          If  StrToDateDef(mskDtaPag.Text,0) <> StrToDateDef(strDtaAnt,0) Then
            blnLibRet := False;

          If Not blnLibRet Then
          Begin
            Result := (TPermissoesAcesso.GetInstance.fVerificaAcesso('CTPDTARET', strLoginUsuarioLogado)) Or
                      (fLiberaBaixaRetroativaComJuros);
            blnLibRet := Result;
            strDtaAnt := mskDtaPag.Text;
          End;
        End;

      End

      Else If (tibTipBai = tbCtaReceber) And ((StrToDateDef(mskDtaPag.Text,0) < VS_Date) Or (mskDtaPag.Text <> strDtaAnt)) Then
      Begin
        {******************************************************}
        {* CONFIGURAÇÃO PARA VERIFICAR DIAS DE TOLERÂNCIA     *}
        {* PARA BAIXA DE CONTAS A RECEBER COM DATA RETROATIVA *}
        {* CASO UTILIZE ESSA CONFIGURAÇÃO O SISTEMA NÃO       *}
        {* CONSIDERA A CONFIGURAÇÃO DE SENHA PARA LIBERAR     *}
        {* BAIXA COM DATA RETROATIVA, DENTRO DO PERÍODO       *}
        {* INFORMADO SEMPRE PASSA E FORA DO PERÍODO SEMPRE    *}
        {* TRAVA                                              *}
        {******************************************************}
        if (StrToDateDef(mskDtaPag.Text,0) < (VS_Date - fCfgSis('BAIATR', varInteger))) then
        begin
          fMensagem('','A data do pagamento não pode ser anterior ao número de dias configurado na "Qtd de dias para baixa atrasada"! [CFG_BAIATR]', ['&OK']);
          Result := False;
        end
        Else If (Not fEmptyStr(fCfgSis('BAICRR')))  And
           (fCfgSis('BAICRR', VarInteger) > 0) And
           (StrToDateDef(mskDtaPag.Text,0) < (VS_Date - fCfgSis('BAICRR', varInteger))) Then
        Begin
          If  StrToDateDef(mskDtaPag.Text,0) <> StrToDateDef(strDtaAnt,0) Then
            blnLibRet := False;

          If (Not blnLibRet) Then
          Begin
            if blnFLiberouDataRetroativa Then
              FLogLibRec.pRemoveTmpLogLib(cdsDupSel.FieldByName('NRODUP').AsString
                                         ,cdsDupSel.FieldByName('CTR_ESPDOC').AsString
                                         ,cdsDupSel.FieldByName('CTR_CODEMP').AsString);

            Result := fLibBxRetroativaAcimaPermitidoCTR;
            blnLibRet := Result;
            strDtaAnt := mskDtaPag.Text;
            blnFLiberouDataRetroativa := blnLibRet;
          End;
        End;

        If (Result) and (StrToDateDef(mskDtaPag.Text,0) <> StrToDateDef(strDtaRec,0)) And
              (StrToDateDef(mskDtaPag.Text,0) < VS_Date) And
              (Not fVerificaAcessoSistema('CTRDTARET', strLoginUsuarioLogado)) Then
        Begin
          If  StrToDateDef(mskDtaPag.Text,0) <> StrToDateDef(strDtaAnt,0) Then
            blnLibRet := False;

          If Not blnLibRet Then
          Begin
             if blnFLiberouDataRetroativa Then
              FLogLibRec.pRemoveTmpLogLib(cdsDupSel.FieldByName('NRODUP').AsString
                                         ,cdsDupSel.FieldByName('CTR_ESPDOC').AsString
                                         ,cdsDupSel.FieldByName('CTR_CODEMP').AsString);

            Result := fLibBxRetroativaAcimaPermitidoCTR;
            blnLibRet := Result;
            strDtaAnt := mskDtaPag.Text;
            blnFLiberouDataRetroativa := blnLibRet;
          End;
        End;

        If (Result) Or (blnLibRet) then
        begin
          If fltValRecOri = 0 Then
          Begin
            If tibTipBai = tbCtaPagar Then
              fltValRecOri := fltValDup + (fltValJur + fltValMul) - fltValDes
            Else
              fltValRecOri := fltValDup;
          End;

          //Se a data for diferente da anterior, ele vai calcular
          If (mskDtaPag.Text <>  strDtaAnt) And (blnCalculado) Then
          Begin
           blnCalculado := False;
           fltValDup := fltValRecOri;
          End;

          //Se for contas a receber e não for validado o calculado ainda
          If (blnVemCtr) And Not (blnCalculado) Then
          Begin

            If fltJur < 0 Then
              fltJur := fCfgSis('JURATR', varDouble);

            pCalculaJurosFuturo(fltJur,mskDtaPag.Text,fltPerMul);

            If (edtTipBai.Text = 'P') Then
              FCalculoBaixaParcial := fltValDup;

            blnCalculado := True;
          End;

          strDtaAnt := FormatDateTime('dd/mm/yyyy', (StrToDateDef(mskDtaPag.Text,0)));
        end;
      End;

      //FECHAMENTO FINANCEIRO
      if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, StrToDate(mskDtaPag.Text)) then
        Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmBaixaDigValores.fChamaSenhaVariavel(strMsg : String = '';
  strDirAce : String = ''; strCfgSis : String = ''; strMsgSen : String = '';
  strOperador : String = ''; strNTrava : String = ''; strDirAceNv2: String = '';
  strSenLibNv2: String = ''; blnNivel2: Boolean = False): Boolean;
  var
  IntCont : Integer;

begin
  Result := True;
  Try
    objLiberacao.Clear;
    objLiberacao.strDirAce     := strDirAce;
    objLiberacao.strSenLib     := fCfgSis(strCfgSis);
    objLiberacao.strMsgSen     := strMsgSen;
    objLiberacao.blnMosMen     := True;
    objLiberacao.strCodOpe     := strOperador;
    objLiberacao.strCodDig     := strOperador;
    objLiberacao.strDirAceNv2  := strDirAceNv2;
    objLiberacao.strSenLibNv2  := strSenLibNv2;
    objLiberacao.blnNivel2     := blnNivel2;

    If Length(arrMenSag) = 0 Then
    Begin
      SetLength(arrMenSag, 1);
      arrMenSag[0] := strMsg;
    End;

    For IntCont:=0 to (length(arrMenSag)- 1) do
    Begin
      objLiberacao.objMsgLibera.pAddTexto(arrMenSag[IntCont]);
    End;

    While (True) Do
    Begin
      If objLiberacao.fLibera Then
      Begin

         objLogLibRec.pInsereLogLigTmp( objLiberacao, cdsDupSel.FieldByName('CTR_NUMDUP').AsString, cdsDupSel.FieldByName('CTR_ESPDOC').AsString, cdsDupSel.FieldByName('CTR_CODEMP').AsString );
         Break

      End
      else
        If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
        Begin
          Result := False;
          Exit;
        end;
    End;

  Finally

    {******************************************************}
    {* CHAMADA A ESSA UNIT VEM DO FORM untBaixaReceber    *}
    {***************************************************MA*}

    objLiberacao.Clear;
  End;

end;

{******************************************************}
{* AGORA CALCULANDO COM DESCONTO DE PONTUALIDADE      *}
{* E CALCULA JUROS FUTURO CORRETAMENTE TAMBEM         *}
{REQ 42920 - 42778**********************************LE*}
function TfrmBaixaDigValores.fCalcJurosDesconto: Boolean;
var
  strMensagem : String;
  intFatorMult: Integer;
  fltAlvo     : Double;   //Valor Calculado (Corrigido)
  fltValRec   : Double;   //Valor Recebido

  LValorBaixaParcial: Double;
  LTotalGeral : Double;
  LDiferencaArredondamento: Double;
begin
  Result       := True;
  intFatorMult := 1;
  strMensagem  := '';
  strMensagem  := strMensagem + 'A Baixa é Parcial, por esse motivo, o valor pago ';
  strMensagem  := strMensagem + 'deve ser menor que o valor corrigido do documento.';

  fltPercJurAplInicial := 0;

  If tibTipBai = tbCtaReceber Then
    fltValMul := 0.0;

  If (fltValDup < 0) And (fStrToFloat(edtValPag.Text) < fltValDup) Then
  Begin
    Result := False;
    fMensagem('', 'O valor pago em duplicata negativa deve ser maior ou igual ao valor da duplicata!', ['&Ok']);
    Exit;
  End;

  If fltValDup < 0 Then
    intFatorMult := -1
  Else If fStrToFloat(edtValPag.Text) < 0.0 Then
  Begin
    Result := False;
    Exit;
  End;

  If (intFatorMult < 0) And (fStrToFloat(edtValPag.Text) > 0) Then
  Begin
    Result := False;
    Exit;
  End;

  If edtTipBai.Text = 'T' Then
  Begin

    fltAlvo := fFormataFloat(fltValCal,2);

    fltValRec := fStrToFloat(edtValPag.Text);

    //Validação para o usuario não ficar apertando 'Enter'
    //If (fltValRecAnt = fltValRec) Then
    //  Exit;

    {If (fltValRecAnt = fltValRec) And
       (fFormataFloat(fStrToFloat(edtValCob.Text), 2) = fFormataFloat(fltValCobAnt, 2)) Then
       Exit;}

    //Desconto de Pontualidade
    If (fCfgSis('DESPON', varBoolean))  And (blnVemCtr)
    And  (fltPerDpo > 0) Then
    Begin
      If (fltValRecAnt > 0) And (fltValRecAnt <> fltValRec) Then
        pDescontoPontualidade;

      //Caso sejam iguais quer dizer que
      //não vai ter o desconto de pontualidade..
      If (fStrToFloat(edtTotalizaValOri.Text) = fltValRec)Then
      Begin
        fltAlvo      :=  fltAlvo + fltValDespon;
        fltValDespon := 0;
      End;
    End;


    //fltValDespon vai estar diferente de 0 se o desconto de pontualidade estar ativo
    //por isto a soma
    fltValDes := fltValDespon  + fStrToFloat(edtTotalizaDesSuj.Text);

    //Calculando o juros da duplicata
    fltValJur := (fStrToFloat(edtTotalizaJurSuj.Text) - fltMulSuj) +
                            (fltAlvo  - (fltValOri +
                            fStrToFloat(edtTotalizaJurSuj.Text) -
                            fltValDes + fltDesCob + fltOutEnt + fltVendor));
                                      {**Req. 86252**16/04/2018**WS**}


   //Calculando o Multa da duplicata
    If tibTipBai = tbCtaPagar Then
      fltValMul := (fltMulSuj - fStrToFloat(edtTotalizaJurSuj.Text))+
                              (fltAlvo  - (fltValOri +
                               fltMulSuj -
                              fltValDes + fltDesCob + fltOutEnt + fltVendor));

    //If (blnVemCtr) And (fltPercJurAplInicial = 0) Then
    //   fltPercJurAplInicial := fFormataFloat(( (100 * (fltValJur - (fStrToFloat(edtTotalizaJurSuj.Text) - fltMulSuj)) ) / (fltValOri + fStrToFloat(edtTotalizaJurSuj.Text) - fltValDes + fltDesCob)),2);

    //Para casos quando o valor recebido é menor que o
    //original
    If fltValJur < 0 Then
      fltValJur := (fStrToFloat(edtTotalizaJurSuj.Text) - fltMulSuj) +
                            (fltValRec  - (fltValOri +
                            fStrToFloat(edtTotalizaJurSuj.Text) -
                            fltValDes + fltDesCob + fltOutEnt + fltVendor));
                                      {**Req. 86252**16/04/2018**WS**}

    //Para casos quando o valor recebido é menor que o
    //original
    If fltValMul < 0 Then
      fltValMul := (fltMulSuj -fStrToFloat(edtTotalizaJurSuj.Text)) +
                            (fltValRec  - (fltValOri +
                            fltMulSuj -
                            fltValDes + fltDesCob + fltOutEnt + fltVendor));


    //Caso tenha desconto de pontualidade e o valor recebido é igual o original
    //tem que passar por aqui..
    If blnVemCtr Then
      If (fFormataFloat(fltValRec,2) = fFormataFloat(fltValOri,2)) And
      (fltValRec > 0) Then
        fltValDes := (fltValOri - fltValRec) + fFormataFloat((fltValJur + fltValMul) + fltDesCob,2);
                                                                         {**Req. 86252**16/04/2018**WS**}

    If tibTipBai = tbCtaPagar Then
      LTotalGeral := fltValOri + fltOutEnt + fltVendor + fltJurSuj + fltMulSuj
    Else
      LTotalGeral := fltValOri + fltOutEnt + fltVendor ;

    If fFormataFloat(fltValRec,2) < fFormataFloat(LTotalGeral,2)  Then   {**Req. 86252**16/04/2018**WS**}
      fltValDes :=  (fltValOri + fltOutEnt + fltVendor - fltValRec) + fFormataFloat((fltValJur + fltValMul) + fltDesCob,2)
    Else If fFormataFloat(fltValRec,2) > fFormataFloat(fltValOri + fltOutEnt + fltVendor,2)  Then
    Begin
      fltValJur :=  (fltValRec - fltValOri) + fFormataFloat(fltValDes,2) - fltVendor - fltOutEnt - fltDesCob - fltValMul;
      fltValMul :=  (fltValRec - fltValOri) + fFormataFloat(fltValDes,2) - fltVendor - fltOutEnt - fltDesCob - fltValJur;
    End;
                                                                                       {**Req. 86252**16/04/2018**WS**}
  End
  Else
  Begin
    If fltValRecOri = 0 Then
    Begin
      If tibTipBai = tbCtaPagar Then
        fltValRecOri := fltValDup + (fltValJur + fltValMul) - fltValDes
      Else
        fltValRecOri := fltValDup;
    End;

    If tibTipBai = tbCtaReceber Then
    Begin
      fltValRec := fStrToFloat(edtValPag.Text);

      // Desc. cob alterada
      If (fFormataFloat(fltDesCob,2) <> fStrToFloat(edtValCob.Text)) And (edtValCob.Text <> '') Then
      Begin
         FValorCorrigidoSemPontualidade := (FValorCorrigidoSemPontualidade-fltValCobAnt) + fStrToFloat(edtValCob.Text);
         fltDesCob := fStrToFloat(edtValCob.Text);
      End
      else if fltValCobAnt > 0 then
        fltDesCob := fltValCobAnt;

      fltValCobAnt := fltDesCob;

      fltValDes := fStrToFloat(edtTotalizaDesSuj.Text, 0);
      fltValJur := (FValorCorrigidoSemPontualidade + fltValDes - fltDesCob) - fltValOri;

      If fltValJur < 0 Then
        fltValJur := 0;

      FFatorBaixaDuplicata    := fltValOri / FValorCorrigidoSemPontualidade;
      FFatorJurosDuplicata    := fltValJur / FValorCorrigidoSemPontualidade;
      FFatorDescontoDuplicata := fltValDes / FValorCorrigidoSemPontualidade;
      FFatorDespesasDuplicata := fltDesCob / FValorCorrigidoSemPontualidade;

      FValorBaixaDuplicata    := fFormataFloat(fltValRec * FFatorBaixaDuplicata, 2);
      FJurosBaixaDuplicata    := fFormataFloat(fltValRec * FFatorJurosDuplicata, 2);
      FDescontoBaixaDuplicata := fFormataFloat(fltValRec * FFatorDescontoDuplicata, 2);
      FDespesasBaixaDuplicata := fFormataFloat(fltValRec * FFatorDespesasDuplicata, 2);

      LDiferencaArredondamento := fFormataFloat(fltValRec -
                                                (FValorBaixaDuplicata+FJurosBaixaDuplicata-FDescontoBaixaDuplicata+FDespesasBaixaDuplicata),2);

      FValorBaixaDuplicata := FValorBaixaDuplicata + (LDiferencaArredondamento);

      FValorNovaDuplicata    := fFormataFloat(fltValOri - FValorBaixaDuplicata,2);
      FJurosNovaDuplicata    := fFormataFloat(fltValJur - FJurosBaixaDuplicata,2);
      FDescontoNovaDuplicata := fFormataFloat(fltValDes - FDescontoBaixaDuplicata,2);
      FDespesasNovaDuplicata := fFormataFloat(fltDesCob - FDespesasBaixaDuplicata,2);

      fltValCal := FValorCorrigidoSemPontualidade;
      fltValDes := FDescontoBaixaDuplicata;
      fltValJur := FJurosBaixaDuplicata;
      fltDesCob := FDespesasBaixaDuplicata;
    End
    Else
     fltValJur := 0.0;

    fltValMul := 0.0;

    LValorBaixaParcial := (fltValRecOri + fltJurDup + fltOutEnt) * intFatorMult;
    If FCalculoBaixaParcial <> 0 Then
      LValorBaixaParcial := FCalculoBaixaParcial * intFatorMult;

    If (fFormataFloat((fStrToFloat(edtValPag.Text) * intFatorMult), 2)) >= fFormataFloat(LValorBaixaParcial, 2) Then
    Begin
      fMensagem('ATENÇÃO!', strMensagem, ['&O k']);
      Result := False;
    End;
  End;

  If tibTipBai = tbCtaReceber Then
    fltValMul := 0.0;

  edtValJur.Text := FloatToStrF(fltValJur, ffNumber, 12, 2);
  edtValMul.Text := FloatToStrF(fltValMul, ffNumber, 12, 2);
  edtValCob.Text := FloatToStrF(fltDesCob, ffNumber, 12, 2);
  edtVendor.Text := FloatToStrF(fltVendor, ffNumber, 12, 2);
  edtValDes.Text := FloatToStrF(fltValDes, ffNumber, 12, 2);
  fltValRecAnt   := fStrToFloat(edtValPag.Text);

  edtOutrasEntidades.Text := FloatToStrF(fltOutEnt, ffNumber, 12, 2);


  edtTotalizaValJur.Text := FloatToStrF(fStrToFloat(edtValJur.Text) - (fStrToFloat(edtTotalizaJurSuj.Text)+fltMulSuj), ffNumber, 12, 2);
  edtTotalizaValDes.Text := FloatToStrF(fStrToFloat(edtValDes.Text) - fStrToFloat(edtTotalizaDesSuj.Text), ffNumber, 12, 2);

  If fStrToFloat(edtTotalizaValJur.Text) < 0 Then edtTotalizaValJur.Text := '0,00';
  If fStrToFloat(edtTotalizaValDes.Text) < 0 Then edtTotalizaValDes.Text := '0,00';

  edtTotalizaValFin.Text := FloatToStrF(fStrToFloat(edtValPag.Text), ffNumber, 12, 2);
end;

procedure TfrmBaixaDigValores.FormCreate(Sender: TObject);
begin
  inherited;
  strDtaAnt      := '';
  strDtaRec      := '';
  fltValJur      := 0.0;
  fltValMul      := 0.0;
  fltVendor      := 0.0;
  fltValDes      := 0.0;
  fltOutEnt      := 0.0;
  fltJurDup      := fltValCal - fltValDup;
  blnConfirma    := False;
  blnVemCtr      := False;
  blnParcial     := False;

  fltJurSuj := 0.0;
  fltMulSuj := 0.0;
  fltDesSuj := 0.0;
  fltPerMul := 0.0;

  fltPerDpo      := 0.0;
  intQtdDav      := 0;
  {*******************************************}
  {* MOVI PARA O ONSHOW                      *}
  {****************************************AC*}
  //mskDtaPag.Text := DateToStr(VS_Date);
  tibTipBai      := tbCtaReceber;

  blnDescFinanSomenteAteVenc := False;
  blnLibRet := False;


  fltValRecOri := 0.0;
  fltValRecAnt := 0.0;
  blnCalculado := False;
  fltValDespon := 0.0;
  blnDupAnt    := False;

  FCalculoBaixaParcial := 0.00;

  objLiberacao := TLiberacao.create;
  objLogLibRec := TLogLibRec.create;

  blnFLiberouDataRetroativa := False;

  FValorNovaDuplicata     := 0.00;
  FJurosNovaDuplicata     := 0.00;
  FDescontoNovaDuplicata  := 0.00;
  FDespesasNovaDuplicata  := 0.00;
  FValorBaixaDuplicata    := 0.00;
  FJurosBaixaDuplicata    := 0.00;
  FDescontoBaixaDuplicata := 0.00;
  FDespesasBaixaDuplicata := 0.00;
  FFatorBaixaDuplicata    := 0.000000;
  FFatorJurosDuplicata    := 0.000000;
  FFatorDescontoDuplicata := 0.000000;
  FFatorDespesasDuplicata := 0.000000;
  FBaixaCTPZerado := False;
end;

procedure TfrmBaixaDigValores.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objLiberacao);
  FreeAndNil(objLogLibRec);
  inherited;
end;

procedure TfrmBaixaDigValores.FormShow(Sender: TObject);
  Var
    intFatorMult: Integer;
    fltVDesSuj: Double;
begin
  inherited;
  strCodOpe := strLoginUsuarioLogado;
  fltValDupInicial := fltValDup;
  fltValCobAnt := 0.0;

  If fltValOri = 0 Then
    fltValOri:= fltValDup;

  edtValPag.Text := FloatToStrF(fltValCal, ffFixed, 12, 2);
  {*********************************************}
  {* ESSE VALOR VEM DO FORM untBaixaReceber    *}
  {******************************************AC*}
  mskDtaPag.Text := DateToStr(dtaDtaPag);
  rgpTipDes.Visible := False;
  Self.Height := Self.Height - rgpTipDes.Height;

  edtTipBai.ReadOnly := Not fHabilitaBaixaParcial(strCodOpe);
  edtTipBai.TabStop := Not edtTipBai.ReadOnly;

  {*****************************************}
  {* VERIFICA SE UTILIZA O CAMPO VENDOR    *}
  {**************************************RV*}
  lblVendor.Visible := fCfgSis('CTPVND', varBoolean) and (tibTipBai = tbCtaPagar);
  edtVendor.Visible := fCfgSis('CTPVND', varBoolean) and (tibTipBai = tbCtaPagar);
  edtVendor.Text := FloatToStrF(fltVendor, ffFixed, 12, 2);

  edtOutrasEntidades.Text := FloatToStrF(fltOutEnt, ffFixed, 12, 2);

  If tibTipBai <> tbCtaReceber Then
  Begin
    Self.Height := Self.Height - pnlJuros.Height;
    pnlJuros.Visible := False;

    edtTotalizaJurSuj.Text := FloatToStrF(fltJurSuj, ffFixed, 12, 2);
    edtTotalizaDesSuj.Text := FloatToStrF(fltDesSuj, ffFixed, 12, 2);
  End
  Else
  Begin

    blnDupTemDespCob   := False;

    If fltDesCob > 0 Then
       blnDupTemDespCob := True;

    //fltValCal_Inicial := fltValCal;
    //fltValEdtPagInicial := fltValCal;

    //fltVlrPagamentoInicial  := fltValCal;
    //fltVlrPagamentoAnterior := 0;

    //fltVlrDespCobrancaInicial := fltDesCob;
    //fltVlrDespCobrancaAnterior := 0;

    fltValCobCtr := fltDesCob;

    edtTotalizaValOri.Text := FloatToStrF(fltValOri, ffFixed, 12, 2);
    edtTotalizaJurSuj.Text := FloatToStrF(fltJurSuj, ffFixed, 12, 2);

    fltVDesSuj := fltDesSuj;
    If blnDescFinanSomenteAteVenc Then
    Begin
      If (StrToDateDef(mskDtaPag.Text,0) <= dtaDtaVen + intQtdDav) Then
      Begin
        fltVDesSuj := fltDesSuj;
        edtTotalizaDesSuj.Text := FloatToStrF(fltDesSuj, ffFixed, 12, 2);
      End
      Else
      Begin
        fltVDesSuj := 0;
        edtTotalizaDesSuj.Text := '0,00';
      End;
    End
    Else
      edtTotalizaDesSuj.Text := FloatToStrF(fltDesSuj, ffFixed, 12, 2);

    {*******************}
    {* CALCULA O JUROS *}
    {****************AF*}
    intFatorMult := 1;
    If fltValDup < 0 Then
      intFatorMult := -1;

    If (fStrToFloat(edtValPag.Text) * intFatorMult) > ((fltValCal) * intFatorMult) Then
    Begin
      edtTotalizaValJur.Text := FloatToStrF(((fStrToFloat(edtValPag.Text) - fltVendor - fltOutEnt) * intFatorMult) - (fltValOri * intFatorMult) - (fltJurSuj + fltMulSuj), ffFixed, 12, 2);
      edtTotalizaValDes.Text := '0,00';
    End
    Else If ((fStrToFloat(edtValPag.Text) * intFatorMult) <= (fltValCal * intFatorMult)) And
            ((fltValCal * intFatorMult) >= (fltValOri * intFatorMult)) Then
    Begin
      edtTotalizaValJur.Text := FloatToStrF((fltValCal * intFatorMult) - (fltValOri * intFatorMult) - ((fltJurSuj + fltMulSuj) * intFatorMult), ffFixed, 12, 2);
      edtTotalizaValDes.Text := FloatToStrF((fltValCal * intFatorMult) - ((fStrToFloat(edtValPag.Text) - fltVendor - fltOutEnt) * intFatorMult) - fltVDesSuj, ffFixed, 12, 2);
    End
    Else If ((fStrToFloat(edtValPag.Text) * intFatorMult) <= (fltValCal * intFatorMult)) And
            ((fltValCal * intFatorMult) < (fltValOri * intFatorMult)) Then
    Begin
      edtTotalizaValJur.Text := FloatToStrF((fltValCal * intFatorMult) - ((fltValOri * intFatorMult) - fltVDesSuj) - (fltJurSuj + fltMulSuj) , ffFixed, 12, 2);
      edtTotalizaValDes.Text := FloatToStrF((fltValOri * intFatorMult) - ((fStrToFloat(edtValPag.Text) - fltVendor - fltOutEnt) * intFatorMult) + (fStrToFloat(edtTotalizaValJur.Text) + (fltJurSuj + fltMulSuj)) - fltVDesSuj, ffFixed, 12, 2);
    End;

    {* Ajust *}
    If fStrToFloat(edtTotalizaValJur.Text) < 0 Then edtTotalizaValJur.Text := '0,00';
    If fStrToFloat(edtTotalizaValDes.Text) < 0 Then edtTotalizaValDes.Text := '0,00';

    edtTotalizaValFin.Text := edtValPag.Text;

    edtValCob.enabled  := True;
    edtValCob.Readonly := False;
    edtValCob.TabStop  := True;

  End;

  If Not (tibTipBai = tbCtaPagar) Then
  Begin
    lblMulta.Visible := False;
    edtValMul.Visible := False;
  End;
end;

procedure TfrmBaixaDigValores.btnCancelaDadosClick(Sender: TObject);
begin
  Close;
end;
 {
function TfrmBaixaDigValores.fVerificaDescontoMaximo: Boolean;
  Var
    fltPerDes  : Double;
    fltPerMax  : Double;
    strNTrava  : String;
    strOperador: String;

    fltTotSel: Double;
    fltTotGer: Double;
    fltTotDes: Double;
begin

  Result := True;

  //fltTotSel := fStrToFloat(edtTotGer.Text);
  //fltTotGer := fStrToFloat(edtTotLiq.Text);
  fltTotDes := fStrToFloat(edtValDes.Text);
  fltPerMax := fCfgSis('CTRDES', varDouble);

  fltPerDes := fFormataFloat( ( 100 * ( 1 - ( fltTotGer / fltTotSel ) ) ), 2);

  If (fFormataFloat(fltPerDes, 2) > fFormataFloat(fltPerMax, 2)) Then
  Begin

    Result := False;
    pAddDados(arrMenSag, '  * DESCONTO MAXIMO DE RECEBIMENTO NO RESUMO DE CAIXA                      ');
    pAddDados(arrMenSag, '---------------------------------------------------------------------------------');
    pAddDados(arrMenSag, '  Valor total dos documentos selecionados: ' + fPadR(FormatFloat('#,##0.00',fltTotSel),32));
    pAddDados(arrMenSag, '  Valor total de recebimento.............: ' + fPadR(FormatFloat('#,##0.00',fltTotGer),32));
    pAddDados(arrMenSag, '  Valor total de desconto................: ' + fPadR(FormatFloat('#,##0.00',fltTotDes),32));
    pAddDados(arrMenSag, '  Percentual de desconto concedido.......: ' + fPadR(FormatFloat('#,##0.00',fltPerDes) + '%',32) );
    pAddDados(arrMenSag, '  Desconto máximo permitido..............: ' + fPadR(FormatFloat('#,##0.00',fltPerMax) + '%',32));

    While (True) Do
    Begin

      If (fDig1SenVar(arrMenSag, 'RCXDESMAX', True, fCfgSis('SENDES'), 'Desconto Máximo',
          True, strCodOpe, strCodOpe, strNTrava, strOperador)) Then
      Begin
        Result := True;
        Break;
      End;

      If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
        Break;

    End;

  End;

end;
}

function TfrmBaixaDigValores.fLiberacaoBaixaTotalComDesconto( flTotDup, flTotPago : Real): Boolean;
begin

    objLiberacao.Clear;
    objLiberacao.strDirAce := 'CTRBXTOTCDESC';
    objLiberacao.objMsgLibera.pAddTexto('***  PERMITE BAIXA TOTAL COM DESCONTO  ***', alCentro, teAmbos, '', 124);
    objLiberacao.objMsgLibera.pAddSeparador(124);
    objLiberacao.objMsgLibera.pAddTexto('Atenção! Valores divergentes informados na baixa.');
                                    //            1         2         3         4         5         6         7         8         9        10        11        12
                                    //   1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234
    objLiberacao.objMsgLibera.pAddTexto('|--------------------------------------------------------------------------------------------------------------------------|');
    objLiberacao.objMsgLibera.pAddTexto('|                                                  RESUMO DOS TÍTULOS SELECIONADOS                                         |');
    objLiberacao.objMsgLibera.pAddTexto('|--------------------------------------------------------------------------------------------------------------------------|');
    objLiberacao.objMsgLibera.pAddTexto('| DOCUMENTO        | EMP | CLIENTE                             | DT.VENC.   | DT.CAD.    |   VR.DUPLICATA | VR.CORRIGIDO(*)|');
    objLiberacao.objMsgLibera.pAddTexto('|--------------------------------------------------------------------------------------------------------------------------|');
    With cdsDupSel Do
      objLiberacao.objMsgLibera.pAddTexto( '| ' + fPadR(FieldByName('NRODUP').AsString,12) +
                                                        FieldByName('PARDUP').AsString + '-' +
                                                        FieldByName('CTR_ESPDOC').AsString + ' | ' +
                                                        FieldByName('CTR_CODEMP').AsString + ' | ' +
                                                  fPadR(FieldByName('CTR_NOMCLI').AsString, 35) + ' | ' +
                                                  FormatDateTime('dd/mm/yyyy',FieldByName('CTR_DTAVEN').AsDateTime) + ' | ' +
                                                  FormatDateTime('dd/mm/yyyy',FieldByName('CTR_DTACAD').AsDateTime) + ' | ' +
                                                  fPadL(FloatToStrF(FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2),14) + ' | ' +
                                                  fPadL(FloatToStrF(FieldByName('CTR_VALCAL').AsFloat, ffNumber, 9, 2),14) + ' |');

    objLiberacao.objMsgLibera.pAddSeparador(124);
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Total Selecionado'  , 'R$'+FormatFloat('#,###,##0.00',  flTotDup )  , 19);
    objLiberacao.objMsgLibera.pAddTextoCaption('Total Informado'    , 'R$'+FormatFloat('#,###,##0.00',  flTotPago)  , 19);
    objLiberacao.objMsgLibera.pAddQuebra;

    objLiberacao.strMsgSen := 'Baixa total com desconto.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
    If Result Then
       objLogLibRec.pInsereLogLigTMP( objLiberacao, cdsDupSel.FieldByName('CTR_NUMDUP').AsString, cdsDupSel.FieldByName('CTR_ESPDOC').AsString, cdsDupSel.FieldByName('CTR_CODEMP').AsString );

    objLiberacao.Clear;
end;

procedure TfrmBaixaDigValores.btnConfirmaDadosClick(Sender: TObject);
  Var
    fltValLiq,
    fltCtrDes,
    fltCtrDe2: Double;
    strSCtrDe: String;

    blnNivel2: Boolean;
    strSenNv2: String;

    {*****************************************************************}
    {* VARIÁVEIS USADAS PARA INSERIR DADOS NA MENSAGEM DE LIBERAÇÃO. *}
    {**************************************************************MA*}

    arrMenTit: TStringArray;
    intIndex : Integer;
    fltPerMax,
    fltTotPag: Double;

    intFatorMult: Integer;

    {********************************************************}
    {* PROCEDURE QUE INSERE DADOS NA MENSAGEM DE LIBERAÇÃO. *}
    {*****************************************************MA*}

    procedure pMontaMensagem(strDuplicata : String; fltValOri, fltDescon, fltPerDes, fltValRec : Double; strCodCli : String);
      Var
        intIndex : Integer;
    Begin
      If Length(arrMenSag) <> 9 Then
      Begin
        SetLength(arrMenSag, 9);
        For intIndex := 0 To High(arrMenSag) Do
          arrMenSag[intIndex] := '';
      End;

      If fltDescon > 0 Then
      Begin
        arrMenSag[0] := 'O valor do desconto é maior que o permitido.';
        arrMenSag[1] := 'Duplicata                : ' + strDuplicata;
        arrMenSag[2] := 'Valor original           : ' + FormatFloat('#,##0.00', fltValOri);
        arrMenSag[3] := 'Valor desconto concedido : ' + FormatFloat('#,##0.00', fltDescon);
        arrMenSag[4] := 'Valor recebido           : ' + FormatFloat('#,##0.00', fltValRec);
        arrMenSag[5] := 'Cliente                  : ' + strCodCli + ' - ' + fRetNomCliente(strCodCli);
        arrMenSag[6] := 'CPF/CNPJ                 : ' + fFormataCpfCgc(fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli]), fSetaPais);
        arrMenSag[7] := 'CONTROLE FINANCEIRO.';
      End
      Else
      Begin
        arrMenSag[0] := 'Recebendo valor menor que o permitido.';
        arrMenSag[1] := 'Duplicata                : ' + strDuplicata;
        arrMenSag[2] := 'Valor original           : ' + FormatFloat('#,##0.00', fltValOri);
        arrMenSag[3] := 'Valor recebido           : ' + FormatFloat('#,##0.00', fltValRec);
        arrMenSag[4] := 'Cliente                  : ' + strCodCli + ' - ' + fRetNomCliente(strCodCli);
        arrMenSag[5] := 'CPF/CNPJ                 : ' + fFormataCpfCgc(fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli]), fSetaPais);
      End;

      if Length(arrMenTit) = 0 Then
      Begin              //            1         2         3         4         5         6         7         8         9        10        11        12
                         //   1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234
        pAddDados(arrMenTit, '|--------------------------------------------------------------------------------------------------------------------------|');
        pAddDados(arrMenTit, '|                                                  RESUMO DOS TÍTULOS SELECIONADOS                                         |');
        pAddDados(arrMenTit, '|--------------------------------------------------------------------------------------------------------------------------|');
        pAddDados(arrMenTit, '| DOCUMENTO        | EMP | CLIENTE                             | DT.VENC.   | DT.CAD.    |   VR.DUPLICATA | VR.CORRIGIDO(*)|');
        pAddDados(arrMenTit, '|--------------------------------------------------------------------------------------------------------------------------|');
      End;
      With cdsDupSel Do
        pAddDados(arrMenTit, '| ' + fPadR(FieldByName('NRODUP').AsString,12) +
                                   FieldByName('PARDUP').AsString + '-' +
                                   FieldByName('CTR_ESPDOC').AsString + ' | ' +
                                   FieldByName('CTR_CODEMP').AsString + ' | ' +
                                   fPadR(FieldByName('CTR_NOMCLI').AsString, 35) + ' | ' +
                                   FormatDateTime('dd/mm/yyyy',FieldByName('CTR_DTAVEN').AsDateTime) + ' | ' +
                                   FormatDateTime('dd/mm/yyyy',FieldByName('CTR_DTACAD').AsDateTime) + ' | ' +
                                   fPadL(FloatToStrF(FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2),14) + ' | ' +
                                   fPadL(FloatToStrF(FieldByName('CTR_VALCAL').AsFloat, ffNumber, 9, 2),14) + ' |');

    End;

begin
  If fVerificaCampos Then
  Begin

    If (tibTipBai = tbCtaReceber) Then
    Begin
      If Not fValidaCampos(edtValPag) Then
        Exit;
      intFatorMult := 1;
      If fltValDup < 0 Then
        intFatorMult := -1;

      {***************************************************}
      {* COMENTADA FORMULA ANTIGA ONDE O VALOR DOS JUROS *}
      {* ERA SOMADO AO VALOR DA DUPLICATA AQUI PORQUE NO *}
      {* REQUISITO 42920 O LEONARDO JÁ FAZ O CÁLCULO NA  *}
      {* PROCEDURE  pCalculaJurosFuturo QUE CHAMADA ANTES*}
      {* DE ENTRAR NESSA ROTINA (CLICK DO CONFIRMA)      *}
      {*REQ. 46097 27/12/2015**************************JU*}
      fltValLiq := (fltValDup * intFatorMult);
      //fltValLiq := (fltValDup * intFatorMult) + fltJurDup;

      fltCtrDes := 1 - (fCfgSis('CTRDES', varDouble) / 100);
      fltCtrDe2 := 1 - (fCfgSis('CTRDE2', varDouble) / 100);
      strSCtrDe := fCfgSis('SCTRDE');

      fltPerMax := fCfgSis('CTRDES', varDouble);
      fltTotPag := fStrToFloat(edtValPag.Text);

      If blnBolAdt And (fStrToFloat(edtValDes.Text) > 0)  Then
      Begin
        fMensagem('ATENÇÃO!','Não é permitido dar desconto para duplicatas de espécie PD cujos boletos foram emitidos!', ['&Ok']);
        Exit;
      End;

      If (edtTipBai.Text = 'T') And
         ( RoundTo(fStrToFloat(edtValPag.Text) * intFatorMult, -2) < RoundTo(fltValLiq * fltCtrDes, -2)) Then
      Begin

        cdsDupSel.First;
        pMontaMensagem(cdsDupSel.FieldByName('CTR_NUMDUP').AsString + '-' +
                       cdsDupSel.FieldByName('CTR_ESPDOC').AsString + '-' +
                       cdsDupSel.FieldByName('CTR_CODEMP').AsString,
                       fltValLiq,
                       fStrToFloat(edtValDes.Text),
                       0,
                       fltTotPag,
                       cdsDupSel.FieldByName('CTR_CODCLI').AsString);

        If fStrToFloat(edtValDes.Text) > 0 Then
          pAddDados(arrMenSag, 'Desconto máximo permitido: ' + FormatFloat('#,##0.00',fltPerMax) + '%');

        pAddDados(arrMenSag, '');
        For intIndex := 0 to High(arrMenTit) Do
        Begin
          pAddDados(arrMenSag, arrMenTit[intIndex]);
        End;
        pAddDados(arrMenSag, '|--------------------------------------------------------------------------------------------------------------------------|');

        blnNivel2 := RoundTo(fltValLiq * fltCtrDe2, -2) > RoundTo(fStrToFloat(edtValPag.Text) * intFatorMult, -2);
        strSenNv2 := fCfgSis('SCTRD2');

        If (Not fChamaSenhaVariavel(arrMenSag[0], 'CTRDESMAX','SCTRDE', 'Desconto Máximo', strLoginUsuarioLogado, '',
                                    'CTRDESMA2', strSenNv2, blnNivel2)) Then
          Exit;
      End;

      If (edtTipBai.Text = 'T') And
         (RoundTo(fltTotPag,-2) < RoundTo(fltValCal,-2)) Then
      Begin

        If cdsDupSel.IsEmpty Then
        Begin
          fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
          Exit;
        End;

        If Not fLiberacaoBaixaTotalComDesconto( fltValCal, fltTotPag ) Then
           Exit;

      End;

    End;

    If Not fValidaLogLibCtp And Not FLiberouLiberacaoPendente Then
     ObjLogLibCtp.pRemoveLogLib(strAutoIncrem);

    If rgpTipDes.Visible Then
    Begin
      Case rgpTipDes.ItemIndex Of
        0: strTipDes := 'D';
        1: strTipDes := 'B';
        2: strTipDes := 'O';
      End;
    End
    Else
      strTipDes := '';

    If (rgpTipDes.Visible)                                                      And
       (fStrToFloat(edtValPag.Text) = 0.0)                                      And
       Not FBaixaCTPZerado And
       (fMensagem('','Baixa total com desconto de 100%.' + #13#10 +
                     'Esta operação não gravará movimento bancário.' + #13#10 +
                     'Confirma?', ['&Sim', '&Não']) = 2)                        Then
      pSetFocus(edtValPag)
    Else
    Begin
      strTipBai := edtTipBai.Text;
      fltValPag := fStrToFloat(edtValPag.Text);
      fltValJur := fStrToFloat(edtValJur.Text);
      fltValMul := fStrToFloat(edtValMul.Text);
      fltDesCob := fStrToFloat(edtValCob.Text);
      fltVendor := fStrToFloat(edtVendor.Text);
      fltOutEnt := fStrToFloat(edtOutrasEntidades.Text);
      fltValDes := fStrToFloat(edtValDes.Text);
      strDtaRec := mskDtaPag.Text;
      blnConfirma := True;
      Close;
    End;

  End;
end;

procedure TfrmBaixaDigValores.btnConfirmaDadosKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key in [9] then
    fValidaCampos(edtValPag);
end;

procedure TfrmBaixaDigValores.edtTipBaiChange(Sender: TObject);
begin
  inherited;

  blnParcial := False;

  If (tibTipBai = tbCtaReceber) Then
  Begin

    If (edtTipBai.Text = 'T') Then
    Begin
      If Not pnlJuros.Visible Then
      Begin
        pnlJuros.Visible := True;
        Self.Height := Self.Height + pnlJuros.Height;
      End;
    End
    Else
    Begin

      If pnlJuros.Visible Then
      Begin
        Self.Height := Self.Height - pnlJuros.Height;
        pnlJuros.Visible := False;
      End;

    End;

  End;

end;

procedure TfrmBaixaDigValores.edtValDesChange(Sender: TObject);
begin
  inherited;

  If (tibTipBai = tbCtaPagar) Then
  Begin

    If (fStrToFloat(edtValDes.Text) > 0) Then
    Begin
      If Not rgpTipDes.Visible Then
      Begin
        rgpTipDes.Visible := True;
        Self.Height := Self.Height + rgpTipDes.Height;
      End;
    End
    Else
    Begin

      If rgpTipDes.Visible Then
      Begin
        rgpTipDes.Visible := False;
        Self.Height := Self.Height - rgpTipDes.Height;
      End;

    End;

  End;

end;

{*************************************}
{* Verifica aqui pois ele tem que    *}
{* passar por este campo (mskDtaPag) *}
{***********************************LE}
procedure TfrmBaixaDigValores.edtValPagEnter(Sender: TObject);
begin
  If (blnVemCtr)  And  Not (blnCalculado) Then
    fValidaCampos(mskDtaPag,True);
end;

procedure TfrmBaixaDigValores.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Return) And (ActiveControl Is TRadioButton) Then
    SelectNext(ActiveControl, True, True);

end;


{****************************************}
{* CFG_DESPON DESCONTO DE PONTUALIDADE  *}
{**************************************LE}
procedure TfrmBaixaDigValores.pDescontoPontualidade;
  Var
  fltValRec : Double;
begin
  fltValRec := fStrToFloat(edtValPag.Text);
  If (fCfgSis('DESPON', varBoolean)) And
  (StrToDate(mskDtaPag.Text) <= (dtaDtaVen + intQtdDav)) Then
  Begin
    If (fltValRecAnt > 0) And (fltValRecAnt <> fltValRec) And (blnVemCtr)Then
      fltValDup := fltValRecOri;

    fltValDespon := fFormataFloat(fltValDup * ( fltPerDpo / 100.00 ),2);
    if FCreditoGeradoPorDevolucao then
      fltValDup := fltValDup + fltValDespon
    else
      fltValDup := fltValDup - fltValDespon;
  End
  Else
    fltValDespon := 0;

end;

procedure TfrmBaixaDigValores.pJurosMinimo;
  Var
    fltPerJur    :Double;
    blnNivel2,
    blnNivel3    : Boolean;
    strSenJM2,
    strSenJM3    : String;
    sumValDup,
    sumValCor  : Double;
    objTabela  : TRegistroMsgLiberaTabela;
    objLinha   : TLinhaMsgLibera;
    cdsCtaRec  : TUniClientDataSet;
begin
  cdsCtaRec := TUniClientDataSet.Create(Self);
  cdsCtaRec.Data := cdsDupSel.Data;
  fltPerJur :=  fGetPercentual((fStrToFloat(edtValJur.Text) - fStrToFloat(edtValDes.Text)),
                                fStrToFloat(edtTotalizaValOri.Text));
  Try
    With cdsCtaRec Do
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddSeparador(125);
      objLiberacao.objMsgLibera.pAddTexto('JUROS MENOR QUE O PERMITIDO', alCentro, teAmbos, '',125);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'DOCUMENTO'       , 17 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'EMP'             , 4  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'CLIENTE'         , 42 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'DT.VENC.'        , 9  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'DT.CAD.'         , 9  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'VR.DUPLICATA'    , 13 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'VR.CORRIGIDO(*)' , 16 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      sumValDup := 0;
      sumValCor := 0;

      While Not Eof Do
      Begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DOCUMENTO'       ,  fPadR(FieldByName('NRODUP').AsString,12)
                                               + FieldByName('PARDUP').AsString + '-'
                                               + FieldByName('CTR_ESPDOC').AsString                              , 17 , alEsquerda );
        objLinha.pAddColuna('EMP'             ,  FieldByName('CTR_CODEMP').AsString                              , 4  , alCentro   );
        objLinha.pAddColuna('CLIENTE'         ,  FieldByName('CTR_NOMCLI').AsString                              , 42 , alEsquerda );
        objLinha.pAddColuna('DT.VENC.'        ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTAVEN').AsDateTime) , 9  , alCentro   );
        objLinha.pAddColuna('DT.CAD.'         ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTACAD').AsDateTime) , 9  , alCentro   );
        objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
        objLinha.pAddColuna('VR.CORRIGIDO(*)' ,  FloatToStrF(FieldByName('CTR_VALCAL').AsFloat, ffNumber, 9, 2)  , 16 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

        sumValDup := sumValDup + FieldByName('CTR_VALDUP').AsFloat;
        sumValCor := sumValCor + FieldByName('CTR_VALCAL').AsFloat;

        Break;
      End;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlTotal;
      objLinha.pAddColuna(''                , 'TOTAIS'                                , 89 , alDireita, teAutcom );
      objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(sumValDup, ffNumber, 9, 2) , 13 , alDireita  );
      objLinha.pAddColuna('VR.CORRIGIDO(*)' ,  FloatToStrF(sumValCor, ffNumber, 9, 2) , 16 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);


      objLiberacao.objMsgLibera.pAddTextoCaption('(*)Taxa de Juros aplicada', FloatToStrF(fltPerJur, ffNumber, 3, 2) + '%', 25 , alDireita, teAmbos, '', 6);
      objLiberacao.objMsgLibera.pAddSeparador(125);
    End;

    blnNivel2 := (fltPerJur < fCfgSis('JURMN1', varDouble)) And (fltPerJur >= fCfgSis('JURMN2', varDouble));
    strSenJM2 := fCfgSis('SENJM2');

    blnNivel3 := fltPerJur < fCfgSis('JURMN2', varDouble);
    strSenJM3 := fCfgSis('SENJM3');

    If (fCfgSis('SENJM1') <> '') And (fltPerJur < fCfgSis('JURMN1', varDouble)) Then
    begin
      objLiberacao.strDirAce := 'SENJM1';
      objLiberacao.strSenLib := fCfgSis('SENJM1');
      objLiberacao.strMsgSen := 'Recalcular Juros';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strDirAceNv2 := 'SENJM2';
      objLiberacao.strSenLibNv2 := strSenJM2;
      objLiberacao.blnNivel2 := blnNivel2;
      objLiberacao.strDirAceNv3 := 'SENJM3';
      objLiberacao.strSenLibNv3 := strSenJM3;
      objLiberacao.blnNivel3 := blnNivel3;
      objLiberacao.objMsgLibera.strTitulo := 'O valor de juros é menor que o permitido.';

      blnJurosMinimo := objLiberacao.fLibera;
      blnSenhaJuros  := blnJurosMinimo;
    end
    Else
      blnJurosMinimo := True;
  Except
    On E: Exception Do
    Begin
      blnJurosMinimo := False;
      pMensagensErro(E.message, '');
    End;
  End;
end;

function TfrmBaixaDigValores.fGetPercentual(fltValBase,fltValOri: Double):Double;
Begin
  Result := 0;
  If (fltValBase <> 0) And (fltValOri <> 0) Then
  Begin
   Result := (fltValBase * 100);
   Result := (Result /fltValOri);
  End;
End;

{*********************************************}
{* VALOR CALCULADO                           *}
{********************************************LE}
function  TfrmBaixaDigValores.fValorCalculado(fltValSuj, fltJuros, fltPerDPo, fltDesCob : Double): Double;
begin
  If (fCfgSis('DESPON', varBoolean)) And (fltPerDpo > 0) Then
    fltValDespon := fFormataFloat((fltValSuj * (fltPerDpo/100.00)), 2)
  Else
    fltValDespon := 0;

  Result :=(fltJuros + fltValSuj + fltDesCob) - fltValDespon
end;


function TfrmBaixaDigValores.LiberacaoBaixaDuplicataComLiberacaoPedente: Boolean;
  Var
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    LDuplicata : String;
begin
  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddSeparador(124);
    objLiberacao.objMsgLibera.pAddTexto('BAIXA DE DUPLICATA COM LIBERAÇÃO PENDENTE', alCentro, teAmbos, '',125);

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'DUPLICATA'    , 17 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'FORNECEDOR'   , 27 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'VR.DOCUMENTO' , 15 , alCentro  , teAutcom);
    objLinha.pAddColuna(''  , 'DESCONTOS'    , 15 , alCentro  , teAutcom);
    objLinha.pAddColuna(''  , 'DT.CAD.'      , 10 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DT.VENC.'     , 10 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'VR. PAGO'     , 15 , alCentro  , teAutcom);

    objTabela := TRegistroMsgLiberaTabela.Create;
    objTabela.lstLinhas.Add(objLinha);

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;

    If Not fEmptyStr(strSerie) Then
      LDuplicata := strNumDup + '-' + strSerie + '-' + strCodEmp
    Else LDuplicata := strNumDup + '-' + strCodEmp;

    objLinha.pAddColuna('DUPLICATA',LDuplicata, 17, alEsquerda );
    objLinha.pAddColuna('FORNECEDOR', strNomFor, 27 , alEsquerda);
    objLinha.pAddColuna('VR.DOCUMENTO', FloatToStrF(fltValDup, ffNumber, 9, 2), 15 , alDireita);
    objLinha.pAddColuna('DESCONTOS', FloatToStrF(fltValDes, ffNumber, 12, 2), 15, alDireita);
    objLinha.pAddColuna('DT.CAD.', FormatDateTime('dd/mm/yyyy', dtaDtaCad), 10, alCentro);
    objLinha.pAddColuna('DT.VENC.', FormatDateTime('dd/mm/yyyy', dtaDtaVen), 10 , alCentro);
    objLinha.pAddColuna('VR. PAGO', FloatToStrF((fStrToFloat(edtValPag.Text)), ffNumber, 12, 2), 15, alDireita);

    objTabela.lstLinhas.Add(objLinha);

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'frmCtpLiberacaoBaixa';
    objLiberacao.strSenLib := fCfgSis('BAICTP');
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.strCodIte := strAutoIncrem;
    objLiberacao.strMsgSen := 'BAIXA DE DUPLICATA COM LIBERAÇÃO PENDENTE';
    objLiberacao.objMsgLibera.strTitulo := 'BAIXA DE DUPLICATA COM LIBERAÇÃO PENDENTE';


    Result := objLiberacao.fLibera;

    If Result Then
      objLogLibCtp.AddLogLib(strAutoIncrem
                            ,strNumDup
                            ,strSerie
                            ,strCodEmp
                            ,objLiberacao);
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

{*********************************************}
{* DEPENDENDO DA DATA DE PGTO QUE O USUARIO  *}
{* COLOCAR ELE RECALCULA OS VALORES          *}
{* VERIFICANDO TAMBEM A CONFIGURAÇÃO  DE     *}
{* DESCONTO ATE O VENCIMENTO OU NÃO   UTDFN  *}
{********************************************LE}
procedure TfrmBaixaDigValores.pCalculaJurosFuturo(fltPerJur: Double; strDtaPag: String; fltPerMul : Double = 9999);
  Var
    fltValCor :  Double;  //Valor Corrigido
    fltValJur : Double;  //Juros Corrigido
    fltValSuj : Double; //Valor Sujerido Somente com fltJurSuj
begin
  fltValJur := 0;
  With cdsDupSel Do
  Begin

    If blnDescFinanSomenteAteVenc Then
    Begin
      If (StrToDateDef(mskDtaPag.Text,0) <= dtaDtaVen + intQtdDav) Then
        fltValSuj :=  (FieldByName('CTR_VALDUP').AsFloat + (fltJurSuj + fltMulSuj) + fltDesCob) - fltDesSuj
      Else
        fltValSuj :=  (FieldByName('CTR_VALDUP').AsFloat + (fltJurSuj + fltMulSuj) + fltDesCob)
    End
    Else
      fltValSuj :=  (FieldByName('CTR_VALDUP').AsFloat + (fltJurSuj + fltMulSuj) + fltDesCob) - fltDesSuj;

    If FieldByName('CTR_ESPDOC').AsString <> 'CC' Then
    Begin
      fltValJur := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                           mskDtaPag.Text,
                                           fltValSuj,
                                           fltPerJur, fltPerMul);

      If blnDescFinanSomenteAteVenc Then
      Begin
        If (StrToDateDef(mskDtaPag.Text,0) <= dtaDtaVen + intQtdDav) Then
        Begin
          fltValCor := fltValSuj + fltValJur;
        End
        Else
        Begin
          fltValCor := fltValSuj + fltValJur;
        End;
        If Not (fltValJur > 0) Then
          If ( StrToDateTime(mskDtaPag.Text)<= ( FieldByName('CTR_DTAVEN').AsDateTime + FieldByName('CTR_QTDDAV').AsInteger ) ) Then
            fltValCor := fValorCalculado(fltValCor,0,FieldByName('CTR_PERDPO').AsFloat,0);
      End
      Else
      Begin
        fltValCor := fltValSuj + fltValJur;
        If Not (fltValJur > 0) Then
          If ( StrToDateTime(mskDtaPag.Text)<= ( FieldByName('CTR_DTAVEN').AsDateTime - FieldByName('CTR_QTDDAV').AsInteger ) ) Then
            fltValCor := fValorCalculado(fltValCor,0,FieldByName('CTR_PERDPO').AsFloat,0);
      End;

      fltValDup := fltValCor;
    End
    Else
      fltValDup := fltValSuj;

    FValorCorrigidoSemPontualidade :=  fFormataFloat((fltValSuj + fltValJur),2);
    edtValPag.Text := FloatToStr(fFormataFloat(fltValDup,2));
  End;

end;

function TfrmBaixaDigValores.fLibBxRetroativaAcimaPermitido: Boolean;
var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddSeparador(143);
  objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE BAIXA RETROATIVA DE DUPLICATA DO CONTAS A PAGAR', alCentro, teAmbos, '',144);

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA'    , 21 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'FORNECEDOR'   , 27 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'VR.DOCUMENTO' , 15 , alCentro  , teAutcom);
  objLinha.pAddColuna(''  , 'JUROS'        , 15 , alCentro  , teAutcom);
  objLinha.pAddColuna(''  , 'MULTA'        , 15 , alCentro  , teAutcom);
  objLinha.pAddColuna(''  , 'DESCONTOS'    , 15 , alCentro  , teAutcom);
  objLinha.pAddColuna(''  , 'DT.CAD.'      , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT.VENC.'     , 10 , alCentro   , teAutcom);

  objTabela := TRegistroMsgLiberaTabela.Create;
  objTabela.lstLinhas.Add(objLinha);

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlValor;

  objLinha.pAddColuna('DUPLICATA', strNumDup + '-' + strSerie + '-' + strCodEmp, 21, alEsquerda );
  objLinha.pAddColuna('FORNECEDOR', strNomFor, 27 , alEsquerda);
  objLinha.pAddColuna('VR.DOCUMENTO', FloatToStrF(fltValDup, ffNumber, 9, 2), 15 , alDireita);
  objLinha.pAddColuna('JUROS', FloatToStrF(fltJurSuj, ffNumber, 12, 2), 15, alDireita);
  objLinha.pAddColuna('MULTA', FloatToStrF(fltMulSuj, ffNumber, 12, 2), 15, alDireita);
  objLinha.pAddColuna('DESCONTOS', FloatToStrF(fltValDes, ffNumber, 12, 2), 15, alDireita);
  objLinha.pAddColuna('DT.CAD.', FormatDateTime('dd/mm/yyyy', dtaDtaCad), 10, alCentro);
  objLinha.pAddColuna('DT.VENC.', FormatDateTime('dd/mm/yyyy', dtaDtaVen), 10 , alCentro);

  objTabela.lstLinhas.Add(objLinha);

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := 'CTPDTARET';
  objLiberacao.strSenLib := 'CTPRET';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.strCodIte := strAutoIncrem;
  objLiberacao.strMsgSen := 'LIBERAÇÃO DE BAIXA RETROATIVA DE DUPLICATA DO CONTAS A PAGAR';
  objLiberacao.objMsgLibera.strTitulo := 'LIBERAÇÃO DE BAIXA RETROATIVA DE DUPLICATA DO CONTAS A PAGAR COM JUROS';

  Result := objLiberacao.fLibera;

 If Result Then
  objLogLibCtp.AddLogLib(strAutoIncrem
                        ,strNumDup
                        ,strSerie
                        ,strCodEmp
                        ,objLiberacao);
end;

function TfrmBaixaDigValores.fLiberaBaixaRetroativaComJuros: Boolean;
	var
	  objTabela : TRegistroMsgLiberaTabela;
	  objLinha  : TLinhaMsgLibera;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddSeparador(143);
  objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE BAIXA RETROATIVA DE DUPLICATA DO CONTAS A PAGAR', alCentro, teAmbos, '',144);

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA'    , 21 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'FORNECEDOR'   , 27 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'VR.DOCUMENTO' , 15 , alCentro  , teAutcom);
  objLinha.pAddColuna(''  , 'JUROS'        , 15 , alCentro  , teAutcom);
  objLinha.pAddColuna(''  , 'MULTA'        , 15 , alCentro  , teAutcom);
  objLinha.pAddColuna(''  , 'DESCONTOS'    , 15 , alCentro  , teAutcom);
  objLinha.pAddColuna(''  , 'DT.CAD.'      , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT.VENC.'     , 10 , alCentro   , teAutcom);

  objTabela := TRegistroMsgLiberaTabela.Create;
  objTabela.lstLinhas.Add(objLinha);

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlValor;

  objLinha.pAddColuna('DUPLICATA', strNumDup + '-' + strSerie + '-' + strCodEmp, 21, alEsquerda);
  objLinha.pAddColuna('FORNECEDOR', strNomFor, 27 , alEsquerda);
  objLinha.pAddColuna('VR.DOCUMENTO', FloatToStrF(fltValDup, ffNumber, 9, 2), 15 , alDireita);
  objLinha.pAddColuna('JUROS', FloatToStrF(fltJurSuj, ffNumber, 12, 2), 15, alDireita);
  objLinha.pAddColuna('MULTA', FloatToStrF(fltMulSuj, ffNumber, 12, 2), 15, alDireita);
  objLinha.pAddColuna('DESCONTOS', FloatToStrF(fltValDes, ffNumber, 12, 2), 15, alDireita);
  objLinha.pAddColuna('DT.CAD.', FormatDateTime('dd/mm/yyyy', dtaDtaCad), 10, alCentro);
  objLinha.pAddColuna('DT.VENC.', FormatDateTime('dd/mm/yyyy', dtaDtaVen), 10 , alCentro);

  objTabela.lstLinhas.Add(objLinha);

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := 'CTPDTARET';
  objLiberacao.strSenLib := 'CTPRET';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.strMsgSen := 'LIBERAÇÃO DE BAIXA RETROATIVA DE DUPLICATA DO CONTAS A PAGAR COM JUROS';
  objLiberacao.objMsgLibera.strTitulo := 'LIBERAÇÃO DE BAIXA RETROATIVA DE DUPLICATA DO CONTAS A PAGAR COM JUROS';

	Result := objLiberacao.fLibera;

  If Result Then
  objLogLibCtp.AddLogLib(strAutoIncrem
                        ,strNumDup
                        ,strSerie
                        ,strCodEmp
                        ,objLiberacao);

end;

function TfrmBaixaDigValores.fLibBxRetroativaAcimaPermitidoCTR: Boolean;
begin

   objLiberacao.Clear;
   objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE BAIXA RETROATIVA DE DUPLICATA DO CONTAS A RECEBER', alCentro, teAmbos, '', 124);
   objLiberacao.objMsgLibera.pAddSeparador(124);


    objLiberacao.objMsgLibera.pAddTexto('|--------------------------------------------------------------------------------------------------------------------------|');
    objLiberacao.objMsgLibera.pAddTexto('|                                                  RESUMO DOS TÍTULOS SELECIONADOS                                         |');
    objLiberacao.objMsgLibera.pAddTexto('|--------------------------------------------------------------------------------------------------------------------------|');
    objLiberacao.objMsgLibera.pAddTexto('| DOCUMENTO        | EMP | CLIENTE                             | DT.VENC.   | DT.CAD.    |   VR.DUPLICATA | VR.CORRIGIDO(*)|');
    objLiberacao.objMsgLibera.pAddTexto('|--------------------------------------------------------------------------------------------------------------------------|');
    With cdsDupSel Do
      objLiberacao.objMsgLibera.pAddTexto( '| ' + fPadR(FieldByName('NRODUP').AsString,12) +
                                                        FieldByName('PARDUP').AsString + '-' +
                                                        FieldByName('CTR_ESPDOC').AsString + ' | ' +
                                                        FieldByName('CTR_CODEMP').AsString + ' | ' +
                                                  fPadR(FieldByName('CTR_NOMCLI').AsString, 35) + ' | ' +
                                                  FormatDateTime('dd/mm/yyyy',FieldByName('CTR_DTAVEN').AsDateTime) + ' | ' +
                                                  FormatDateTime('dd/mm/yyyy',FieldByName('CTR_DTACAD').AsDateTime) + ' | ' +
                                                  fPadL(FloatToStrF(FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2),14) + ' | ' +
                                                  fPadL(FloatToStrF(FieldByName('CTR_VALCAL').AsFloat, ffNumber, 9, 2),14) + ' |');

  objLiberacao.objMsgLibera.pAddSeparador(124);
  objLiberacao.objMsgLibera.pAddQuebra;

  objLiberacao.strDirAce := 'CTRDTARET';
  objLiberacao.strSenLib := '';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.strCodIte := strAutoIncrem;
  objLiberacao.strMsgSen := 'LIBERAÇÃO DE BAIXA RETROATIVA DE DUPLICATA DO CONTAS A RECEBER';
  objLiberacao.objMsgLibera.strTitulo := 'LIBERAÇÃO DE BAIXA RETROATIVA DE DUPLICATA DO CONTAS A RECEBER';

  Result := objLiberacao.fLibera;

  If Result Then
   FLogLibRec.pInsereLogLigTMP(objLiberacao,
                               cdsDupSel.FieldByName('NRODUP').AsString,
                               cdsDupSel.FieldByName('CTR_ESPDOC').AsString,
                               cdsDupSel.FieldByName('CTR_CODEMP').AsString);

end;

function TfrmBaixaDigValores.fValidaLogLibCtp: Boolean;
var
  LAbaixoPermitido: Boolean;
  LDatRetLimite: Boolean;
begin

  If (tibTipBai = tbCtaPagar) Then
  Begin
    { Verifica o inverso do fValidaCampos que gera a LogLib }

    If Not (StrToDateDef(mskDtaPag.Text,0) < VS_Date) Then Exit(False);

    LAbaixoPermitido := (Not ((Not fEmptyStr(fCfgSis('BAIATP')))  And
                          (fCfgSis('BAIATP', VarInteger) > 0)  And
                          (StrToDateDef(mskDtaPag.Text,0) < (VS_Date - fCfgSis('BAIATP', varInteger)))));

    LDatRetLimite :=    (Not ((Not fEmptyStr(fCfgSis('CTPRET'))) And
                             (StrToDateDef(mskDtaPag.Text,0) <> StrToDateDef(strDtaRec,0))));

    If LAbaixoPermitido And LDatRetLimite Then
      Exit(False)
    Else If LAbaixoPermitido Or LDatRetLimite Then
      If Not blnLibRet Then
        Exit(False);
  End;

  Result := True;
end;

Procedure TfrmBaixaDigValores.pAlteraValorDespCob();
 Var
     LDifDesCob    : Double;
     LNovoDesCob   : Double;
     vlrJuros      : Double;
     varVlrMulta   : Double;

     varjur : Double;
Begin

    If (blnVemCtr) And (edtTipBai.Text = 'T') Then
    Begin

       LNovoDesCob   := 0;
       varVlrMulta   := 0;

       If (blnDupTemDespCob) Then
       Begin

          If fltDesCob > fStrToFloat(edtValCob.Text) Then
          Begin
             LDifDesCob  := fltDesCob - fStrToFloat(edtValCob.Text);
             LNovoDesCob := fltDesCob - LDifDesCob;
          End
          Else
          If fltDesCob < fStrToFloat(edtValCob.Text) Then
          Begin
             LDifDesCob := fStrToFloat(edtValCob.Text) - fltDesCob;
             LNovoDesCob := fltDesCob + LDifDesCob;
          End;

       End
       Else
          LNovoDesCob := fStrToFloat(edtValCob.Text);

       fltDesCob := LNovoDesCob;

       // Verifica se tem juros;
       If fltJurDup > 0 Then
       Begin

          If fltValCobCtr > 0 Then
          Begin

            varjur := fCalculaJurosDupAlt( (fltValOri + LNovoDesCob - fltdessuj + fltJurSuj), fltPercJuroAplic );

            // Calcula multa;
            If fltPerMul > 0 Then
               varVlrMulta := (( (fltValOri + fltValCobCtr) * fltPerMul) / 100);

            vlrJuros := varjur + fltJurSuj;

            edtValPag.Text := FormatFloat('#,##0.00', fltValOri + LNovoDesCob - fltValDes {- fltJurDup} + vlrJuros + varVlrMulta);

            fltValCal := fltValOri + LNovoDesCob - fltValDes{- fltJurDup} + vlrJuros + varVlrMulta;

          End
          Else
          Begin

            varjur := fCalculaJurosDupAlt( (fltValOri + LNovoDesCob - fltdessuj + fltJurSuj), fltPercJuroAplic );

            // Calcula multa;
            If fltPerMul > 0 Then
               varVlrMulta := ((fltValOri * fltPerMul) / 100);

            vlrJuros := varjur + fltJurSuj;

            edtValPag.Text := FormatFloat('#,##0.00', (fltValOri - fltValCobCtr) + LNovoDesCob - fltValDes{- fltJurDup} + vlrJuros + varVlrMulta);

            fltValCal := (fltValOri - fltValCobCtr) + LNovoDesCob - fltValDes{- fltJurDup} + vlrJuros + varVlrMulta;

          End;


       End
       Else
       Begin
         edtValPag.Text := FormatFloat('#,##0.00', (fltValOri + fltJurSuj + LNovoDesCob - fltValDes));
         fltValCal := (fltValCal - fltValCobCtr) + LNovoDesCob;// + fltDesSuj - fltValDes;
       End;

    End;

End;

function TfrmBaixaDigValores.fCalculaJurosDupAlt(fltValDuplic: Double; VarPercenJur: Double = 9999): Double;
  Var
    fltDiaAtraso: Double;
    dtaDtaPag : TDateTime;

    VarintTolerancia : Integer;

begin

  Result := 0.0;

  dtaDtaPag := StrToDateDef(mskDtaPag.Text,0);

  If fltValDuplic > 0 Then
  Begin

      VarintTolerancia := fCfgSis('TOLATR', varInteger);

    If VarPercenJur = 9999 Then
       VarPercenJur := fCfgSis('JURATR', varDouble);

    fltDiaAtraso := dtaDtaPag - dtaDtaVen;

    If (dtaDtaVen < dtaDtaPag) And (fltDiaAtraso > VarintTolerancia) Then
    Begin
      Result := fltValDuplic * (((VarPercenJur / 30) * fltDiaAtraso) / 100);

      Result := fFormataFloat(Result, 2);
    End;

  End;

End;

end.

