unit untCtpAtribConf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, QColorLabel, Uni, BitBtnLockedIncrem, frxClass, UniClientDataSet,
  frxExportCSVTestabilidade, Vcl.Mask, MaskEditFocus, Data.DB, Datasnap.DBClient,
  untFrameCentroCustoEditFocus,cxProgressBar,untCadCta,untGravando,
  untFramePlanoDeContasMaskEdit,untFechamentoFinanceiro, untConstantes,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, MemoFocus;

type
  TfrmCtpAtribConf = class(TfrmPaiEdit)
    Label5: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    btnGravar: TBitBtnLocked;
    ColorLabel2: TColorLabel;
    Label11: TLabel;
    Label4: TLabel;
    ColorLabel1: TColorLabel;
    Label1: TLabel;
    ColorLabel3: TColorLabel;
    Label6: TLabel;
    ColorLabel4: TColorLabel;
    Label7: TLabel;
    ColorLabel5: TColorLabel;
    edtCheque: TEditFocus;
    edtVeioNF: TEditFocus;
    edtDeposito: TEditFocus;
    edtPrevisao: TEditFocus;
    edtVeiobo: TEditFocus;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    edtValDup: TEditFocus;
    lblPlaContas: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    MskCompet: TMaskEditFocus;
    MskDtaVen: TcxDateEdit;
    MskDtaCad: TcxDateEdit;
    mmHist: TMemoFocus;
    Label9: TLabel;
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodPorExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fraCentro(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaExit(Sender: TObject);
    procedure MskDtaCadExit(Sender: TObject);
    procedure MskDtaVenExit(Sender: TObject);
    procedure edtValDupExit(Sender: TObject);
    procedure MskCompetExit(Sender: TObject);
  private
    FstrCodPor,
    FstrCodEve,
    FstrVeiobo,
    FstrVeioNF,
    FstrUsaChq,
    FstrDeposi,
    FstrPrevis,
    FstrPlanoContas,
    FstrDtaCad,
    FstrDtaVen,
    FstrValDup,
    FstrCompet,
    FstrHistor,
    FstrAltComp: String;
    ATemCtpDet: Boolean;
    FTravaCamposNota:Boolean;
    AQryDupMarcada: TUniQuery;
    cdsCtpDet: TUniClientDataSet;
    strCtaAnt: String;
    qryConCta: TUniQuery;
    blnResultPlaCta : Boolean;
    strSenhaDtaCadOld,
    strSenhaDtaVenOld,
    strSenhaValDupOld: String;
    objFechamento: TFechamentoFinanceiro;
    function fValidaChqBolDep(Sender: TWinControl): Boolean;
    procedure pCarregaPlanoDeConta; Overload;
    procedure pCarregaPlanoDeConta(strCodFor : String); Overload;
    function fValidaPlanoDeConta(pgbProgresso: TcxProgressBar): Boolean;
    procedure pStepStatusSelecao(pgbStatus: TcxProgressBar);
    procedure pCarregaEventos;
    procedure HabilitaCamposAlteraveis(blnUsouFiltroBaixadas: boolean);
    { Private declarations }
  public
    blnConfirma: Boolean;
    ADuplicataMarcada: String;
    blnBaixadas: Boolean;
    property strCodPor: String read FstrCodPor;
    property strCodEve: String read FstrCodEve;
    property strVeiobo: String read FstrVeiobo;
    property strVeioNF: String read FstrVeioNF;
    property strUsaChq: String read FstrUsaChq;
    property strDeposi: String read FstrDeposi;
    property strPrevis: String read FstrPrevis;
    property strPlanoContas: String read FstrPlanoContas;
    property FcdsCtpDet: TUniClientDataSet read cdsCtpDet;
    property strDtaCad: String read FstrDtaCad;
    property strDtaVen: String read FstrDtaVen;
    property TravaCamposNota: Boolean read FTravaCamposNota write FTravaCamposNota;
    property strValDup: String read FstrValDup;
    property strCompet: String read FstrCompet;
    property strHistor: String read FstrHistor;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCtpAtribConf: TfrmCtpAtribConf;

implementation

{$R *.dfm}

Uses untFuncoesSimples, untPai, untConsultas, untTypesSistema, untCadPag,untPesqAux;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}  
procedure TfrmCtpAtribConf.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    if fPesqPortador(conSimples,
                     Self,
                     edtCodPor,
                     edtNomPor,
                     nil,
                     Key,
                     arrSel)  then
    Begin
      If fValidaCampos(edtCodPor, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmCtpAtribConf.edtValDupExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtValDup.Text) Then
    edtValDup.EditFormat := '###,###,##0.00'
  Else
    edtValDup.EditFormat := '';

  fValidaCampos(edtValDup, True);
end;

procedure TfrmCtpAtribConf.fraCentro(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
  Begin
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);
  End;
end;

procedure TfrmCtpAtribConf.fraPlanoDeContasMskCodCtaExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
  Begin
    pCarregaPlanoDeConta;
  End;

  fraPlanoDeContas.MskCodCtaExit(Sender);
end;

procedure TfrmCtpAtribConf.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrPlanoContas: TConsultasArray;
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE PLANO DE CONTAS *}
  {************************************}
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrPlanoContas) Then
  Begin
    If fValidaCampos(fraPlanoDeContas.MskCodCta, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCtpAtribConf.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = fraCentroCusto.edtCodEve) Then
    Begin

      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);

        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text) = 'R') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente no contas a receber!',['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodPor) Then
    Begin

      If Not fEmptyStr(edtCodPor.Text) Then
      Begin

        edtNomPor.Text := fRetNomPortador(edtCodPor.Text);

        If fEmptyStr(edtNomPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;

        If Result Then
        Begin
          If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Você não permissão para utilizar este portador!', ['&O k']);
              Result := False;
            End;
          End;
        End;
      End;

    End
    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin
        pCarregaPlanoDeConta;

        If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
          Result := False;
        End
        {************************************************}
        {* NÃO DEIXA INFORMAR CENTRO DE CUSTO DE RATEIO *}
        {*********************************************RV*}
        Else If (fraPlanoDeContas.MskCodCta.Text = fCfgSis('CTAPRI')) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas de Rateio não é permitido!', ['&O k']);
          Result := False;
        End
        Else If (strCtaAnt <> fraPlanoDeContas.MskCodCta.Text) Then
        Begin
          if PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True) then
          Begin
            Try
              pCriarFormularios(TfrmGravando,frmGravando);
              frmGravando.fExecutarAcao := fValidaPlanoDeConta;
              frmGravando.lblGravando.Caption := 'Aguarde... Validando Plano de Conta.';
              frmGravando.ShowModal;
            Finally
              pFreeAndNil(frmGravando);
              Result := blnResultPlaCta;
            End;
          End
          Else
            Result := False;
        End;

        If Result Then
        Begin
           If Not fVerificaAcessoSistema('CTPALTCTA',strLoginUsuarioLogado) Then
           Begin
             fMensagem('ATENÇÃO!', 'Usuário sem permissão para alterar o plano de contas!', ['&O k']);
             Result := False;
           End;
        End;

        If Result Then
          strCtaAnt := fraPlanoDeContas.MskCodCta.Text;

      End
      Else
      Begin
        fraPlanoDeContas.edtDesCta.Clear;
      End;
    End
    Else If (Sender = edtVeiobo) Or (Sender = edtVeioNF) Or
            (Sender = edtCheque) Or (Sender = edtPrevisao) Or
            (Sender = edtDeposito) Then
    Begin
      Result := fValidaChqBolDep(Sender);
      Exit;
    End

    Else If (Sender = MskDtaCad) Then
    Begin
      if not fEmptyStr(fTiraCaracEspeciais(MskDtaCad.Text)) then
      begin
        If not fValidaDataStr(MskDtaCad.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Cadastro não é válida!', ['&O k']);
          Result := False;
        end

        Else If (StrToDateDef(MskDtaCad.Text, 0) <= 0) Then
        Begin
          fMensagem('', 'Data de Cadastro informada é inválida! Necessário correção.', ['&O k']);
          Result := False;
        End

        Else If (fCfgSis('CTPCAD', varBoolean)) Then
        Begin
          If (Not fEmptyStr(fCfgSis('CTPSDC'))) And fEmptyStr(strSenhaDtaCadOld) Then
          Begin
            If ffrmSenha(strSenha, 'Digite a Senha da Data Cadastro') Then
            Begin
              If strSenha <> fCfgSis('CTPSDC') Then
                Result := False
              Else
                strSenhaDtaCadOld := strSenha;
            End
            Else
              Result := False;
          End;

          AQryDupMarcada.First;
          while not AQryDupMarcada.eof do
          begin
            If (Not fEmptyStr(AQryDupMarcada.FieldByName('CTP_SEQBAI').AsString)) Then
            Begin

              If fEmptyStr(fTiraCaracEspeciais(MskDtaVen.Text)) then
              begin
                If (StrToDate(MskDtaCad.Text) > StrToDate(AQryDupMarcada.FieldByName('CTP_DTAVEN').AsString)) Then
                Begin
                  fMensagem('ATENÇÃO!'
                             ,'A Data de Cadastro deve ser menor'
                             +' ou igual a Data de Vencimento '
                             +' para todas as duplicatas selecionadas!'
                              , ['&O k']);
                  Result := False;
                  Break;
                End
              end else
              begin
                If (StrToDate(MskDtaCad.Text) > StrToDate(MskDtaVen.Text)) Then
                Begin
                  fMensagem('ATENÇÃO!'
                             ,'A Data de Cadastro deve ser menor'
                             +' ou igual a Data de Vencimento '
                             +' para todas as duplicatas selecionadas!'
                              , ['&O k']);
                  Result := False;
                  Break;
                End
              end;
            
            End;
            AQryDupMarcada.Next;
          end;
        End;

        AQryDupMarcada.First;
        while not AQryDupMarcada.Eof do
        begin
          if objFechamento.FechamentoFinanceiroJaRealizado(AQryDupMarcada.FieldByName('CTP_CODEMP').AsString,StrToDate(MskDtaCad.Text) ) then
          begin
            Result := False;
            Break;
          end;

          AQryDupMarcada.Next;
        end;
      end;
    End

    Else If (Sender = MskDtaVen) Then
    Begin
      if not fEmptyStr(fTiraCaracEspeciais(MskDtaVen.Text)) then
      begin
        If not fValidaDataStr(MskDtaVen.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Vencimento não é válida!', ['&O k']);
          Result := False;
        end

        Else If (StrToDateDef(MskDtaVen.Text, 0) <= 0) Then
        Begin
          fMensagem('', 'Data do Vencimento informada é inválida! Necessário correção.', ['&O k']);
          Result := False;
        End

        Else If (fCfgSis('CTPDTA', varBoolean))Then
        Begin
          If (Not fEmptyStr(fCfgSis('CTPSDV'))) Then
          Begin
            If ffrmSenha(strSenha, 'Digite a Senha da Data Vencimento') Then
            Begin
              If strSenha <> fCfgSis('CTPSDV') Then
                Result := False
              Else
                strSenhaDtaVenOld := strSenha;
            End
            Else
              Result := False;
          End;
          AQryDupMarcada.First;
          while not AQryDupMarcada.eof do
          begin
            if fEmptyStr(fTiraCaracEspeciais(MskDtaCad.Text)) then
            begin

              If (StrToDate(MskDtaVen.Text) <  StrToDateDef(AQryDupMarcada.FieldByName('CTP_DTACAD').AsString, 0)) Then
              Begin
                fMensagem('ATENÇÃO!'
                          , 'A Data de Vencimento deve ser maior'
                          + ' ou igual a Data de Cadastro'
                          + ' para todas as duplicatas selecionadas!'
                            , ['&O k']);
                Result := False;
                break;
              End;
            end
            Else
            Begin
              If (StrToDate(MskDtaVen.Text) <  StrToDate(MskDtaCad.Text)) Then
              Begin
                fMensagem('ATENÇÃO!'
                          , 'A Data de Vencimento deve ser maior'
                          + ' ou igual a Data de Cadastro'
                          + ' para todas as duplicatas selecionadas!'
                            , ['&O k']);
                Result := False;
                break;
              End;
            End;
            AQryDupMarcada.Next;
          end;
        end;
      end;
    End

    Else If (Sender = edtValDup) Then
    Begin
      If not fEmptyStr(fTiraCaracEspeciais(edtValDup.Text)) Then
      Begin
        If fStrToFloat(edtValDup.Text) = 0.0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor do Documento deve ser diferente de Zero!', ['&O k']);
          Result := False;
        End;

        (* FECHAMENTO FINANCEIRO *)

        AQryDupMarcada.First;
        while not AQryDupMarcada.Eof do
        begin
          if fEmptyStr(fTiraCaracEspeciais(MskDtaCad.Text)) then
          begin
            if objFechamento
                .FechamentoFinanceiroJaRealizado(AQryDupMarcada.FieldByName('CTP_CODEMP').AsString
                                                  ,StrToDateDef(AQryDupMarcada.FieldByName('CTP_DTACAD').AsString, VS_Date))then
            begin
              Result := False;
              Break;
            end;
          end
          Else
          begin
            if objFechamento
                .FechamentoFinanceiroJaRealizado(AQryDupMarcada.FieldByName('CTP_CODEMP').AsString
                                                  ,StrToDate(MskDtaCad.Text)) then
            begin
              Result := False;
              Break;
            end;
          end;

          AQryDupMarcada.Next;
        end;


        If fVerificaAcessoSistema('CTPALTVLR') Then
        Begin
          If fStrToFloat(edtValDup.Text) > MAX_VALMON Then
          Begin
            edtValDup.Text := FloatToStr(MAX_VALMON);
          End;
          Exit;
        End;

        If (fCfgSis('CTPVAL', varBoolean)) And fEmptyStr(strSenhaValDupOld) Then
        Begin
          If (Not fEmptyStr(fCfgSis('CTPSVD'))) Then
          Begin
            If ffrmSenha(strSenha, 'Digite a Senha do Valor Duplicata') Then
            Begin
              If strSenha <> fCfgSis('CTPSVD') Then
                Result := False
              Else
                strSenhaValDupOld := strSenha;
            End
            Else
              Result := False;
          End;
        End;
      End;
    End

    Else if (Sender = MskCompet) then
    Begin
      If not fEmptyStr(fTiraCaracEspeciais(MskCompet.Text)) then
      Begin
        If not fValidaDataStr('01/'+ MskCompet.Text) Then
        Begin
          pMensagemOk('Data informada na Competência não é válida!');
          Result := False;
        end

        Else If Length(fTiraCaracEspeciais(Trim(MskCompet.Text))) < 6 Then
        Begin
          pMensagemOk('O ano da Competência deve ser preenchido com 4 dígitos!');
          Result := False;
        End

        Else If fVerificaAcessoSistema('CTPALTCOMP', strLoginUsuarioLogado) Then
        Begin
          AQryDupMarcada.First;
          while not AQryDupMarcada.Eof do
          begin
            If fEmptyStr(fTiraCaracEspeciais(MskDtaCad.Text)) Then
            Begin
               If Not femptyStr(AQryDupMarcada.FieldByName('CTP_DTAPAG').AsString) Then
                  FstrAltComp := FormatDateTime('mm/yyyy',StrToDateTime(AQryDupMarcada.FieldByName('CTP_DTAPAG').AsString))
            End
            Else
              FstrAltComp := FormatDateTime('mm/yyyy',StrToDateTime(MskDtaCad.Text));

            If Not fEmptyStr(fTiraCaracEspeciais(FstrAltComp)) Then
            Begin
              If (StrToDateTimeDef('01/'+ MskCompet.Text, 0) > StrToDateTimeDef('01/'+FstrAltComp,0))
                And (MskCompet.Text <> AQryDupMarcada.FieldByName('CTP_COMPET').AsString) Then
              Begin
                pMensagemOk('A Data da Competência deve ser menor ou igual a Data de Baixa!');
                Result := False;
                Break;
              End;
            End;
            AQryDupMarcada.Next;
          end;
        End
        Else
        Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para alterar a competência!', ['&O k']);
            Result := False;
        End;

      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmCtpAtribConf.fValidaChqBolDep(Sender: TWinControl): Boolean;
begin
  Result := True;

  If (Not fEmptyStr(TEditFocus(Sender).Text)) And (Pos(TEditFocus(Sender).Text, 'SN') <= 0) Then
  Begin
    Result := False;
    fMensagem('','O campo deve ser informado com (S)im ou (N)ão!', ['&Ok']);
  End
  Else If TEditFocus(Sender).Text = 'S' Then
  Begin
    If (Sender = edtCheque) Then
    Begin
      If ((edtVeiobo.Text = 'S') Or (fEmptyStr(edtVeiobo.Text))) Or
      ((edtDeposito.Text = 'S') Or (fEmptyStr(edtDeposito.Text))) Then
      Begin
        Result := False;
        fMensagem('','Para informar Cheque como (S)im, os campos Depósito e Veio Boleto devem estar iguais à (N)ão!', ['&Ok']);
        pSetFocus(Sender);
        PostMessage(Handle, WM_KEYDOWN, VK_Tab, 0);
      End;
    End;

    If (Sender = edtVeiobo) Then
    Begin
      If ((edtCheque.Text = 'S') Or (fEmptyStr(edtCheque.Text))) Or
      ((edtDeposito.Text = 'S') Or (fEmptyStr(edtDeposito.Text))) Then
      Begin
        Result := False;
        fMensagem('','Para informar Veio Boleto como (S)im, os campos Depósito e Cheque devem estar iguais à (N)ão!', ['&Ok']);
        pSetFocus(Sender);
        PostMessage(Handle, WM_KEYDOWN, VK_Tab, 0);
      End;
    End;

    If (Sender = edtDeposito) Then
    Begin
      If ((edtCheque.Text = 'S') Or (fEmptyStr(edtCheque.Text))) Or
      ((edtVeiobo.Text = 'S') Or (fEmptyStr(edtVeiobo.Text))) Then
      Begin
        Result := False;
        fMensagem('','Para informar deposito como (S)im, os campos veio boleto e cheque devem estar iguais à (N)ão!', ['&Ok']);
        pSetFocus(Sender);
        PostMessage(Handle, WM_KEYDOWN, VK_Tab, 0);
      End;
    End;

  End;
end;

function TfrmCtpAtribConf.fValidaPlanoDeConta(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strNomFor : String;
    AEventoRateio : Boolean;
    blnRateia : Boolean;
    oParametros : TParametrosDesmembraValores;
begin
  blnRateia := True;
  strNomFor := '';

  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := AQryDupMarcada.RecordCount;

  Result := True;
  blnResultPlaCta := True;

  AQryDupMarcada.First;
  oParametros := TParametrosDesmembraValores.Create;
  while not AQryDupMarcada.Eof Do
  begin
   // Se alguma duplicata possuir desmembramento não ira alterar o plano de conta
    ATemCtpDet := fVerificaCtpDet(AQryDupMarcada.FieldByName('CTP_NUMDUP').AsString,
                                  AQryDupMarcada.FieldByName('CTP_PARCEL').AsString,
                                  AQryDupMarcada.FieldByName('CTP_SERIE_').AsString,
                                  AQryDupMarcada.FieldByName('CTP_CODEMP').AsString,
                                  AQryDupMarcada.FieldByName('CTP_CODFOR').AsString,
                                  AEventoRateio);
    if ATemCtpDet Then
    begin
      fMensagem('ATENÇÃO!', 'Existe(m) duplicata(s) selecionada(s) que possuem desmembramento de valores.' + #13#10 +
                            'Portanto não será possível alterar o Plano de Contas! ', ['&O k']);
      Result := False;
      blnResultPlaCta := False;
    end;

    // valida configuração CFG_USACTF, quando está igual a sim só pode alterar o plano de contas para um que esteja vinculado ao fornecedor na manutenção
    If fCfgSis('USACTF', varBoolean) And (Result) Then
    Begin
      pCarregaPlanoDeConta(AQryDupMarcada.FieldByName('CTP_CODFOR').AsString);
      If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
      Begin
        strNomFor := AQryDupMarcada.FieldByName('CTP_CODFOR').AsString +' - '+ fRetNomFornecedor(AQryDupMarcada.FieldByName('CTP_CODFOR').AsString);
        fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está está vinculado ao fornecedor '+strNomFor+' !', ['&O k']);
        Result := False;
        blnResultPlaCta := False;
      End;
    End;

    // aqui cria um client com o desmembramento de todas as duplicatas
    If (Result) And (strCtaAnt <> fraPlanoDeContas.MskCodCta.Text) And blnRateia Then
    Begin
      oParametros.strNumCta := fraPlanoDeContas.MskCodCta.Text;
      oParametros.strCodEve := fraCentroCusto.edtCodEve.Text;
      oParametros.fltValDup := fstrToFloat(AQryDupMarcada.FieldByName('CTP_VALDUP').AsString);
      oParametros.blnDireto :=  Not AQryDupMarcada.Bof;
      oParametros.strAutoin := AQryDupMarcada.FieldByName('AUTOINCREM').AsString;

      If fDesmembraValoresCtaDet(oParametros) Then
      Begin
        fraPlanoDeContas.MskCodCta.Enabled := False;

        If fEmptyStr(oParametros.strCodCta) Then
          fraPlanoDeContas.MskCodCta.Text := fCfgSis('CTAPRI')
        Else
          fraPlanoDeContas.MskCodCta.Text := oParametros.strCodCta;

        fraCentroCusto.edtCodEve.Text := fCfgSis('EVEPRI');

        cdsCtpDet.Data := oParametros.cdsTemp.Data;

        pCarregaEventos;
        pCarregaPlanoDeConta;
        pSetFocus(Self);
        If fraCentroCusto.edtCodEve.CanFocus Then
          pSetFocus(fraCentroCusto.edtCodEve)
        Else
          pSetFocus(edtCodPor);
      End
      Else
      Begin
        blnRateia := False;
        strCtaAnt := fraPlanoDeContas.MskCodCta.Text;
      End;

    End;

    pStepStatusSelecao(pgbProgresso);
    AQryDupMarcada.Next;

    If Not blnResultPlaCta Then
      Break;
  end;

  If Not blnResultPlaCta Then
  Begin
    fraPlanoDeContas.MskCodCta.Clear;
    fraCentroCusto.edtCodEve.Clear;
    fraPlanoDeContas.MskCodCta.Enabled := True;
    fraCentroCusto.edtCodEve.Enabled := True;
    pCarregaEventos;
    pCarregaPlanoDeConta;
  End;
  oParametros.Free;
end;

procedure TfrmCtpAtribConf.MskCompetExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(MskCompet, True);
end;

procedure TfrmCtpAtribConf.MskDtaCadExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(MskDtaCad, True);
end;

procedure TfrmCtpAtribConf.MskDtaVenExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(MskDtaVen, True);
end;

procedure TfrmCtpAtribConf.pCarregaEventos;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve.Text)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmCtpAtribConf.pCarregaPlanoDeConta(strCodFor: String);
begin
  pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text, True, strCodFor);

  if not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) then
    fraPlanoDeContas.edtDesCta.Text := qryConCta.FieldByName('CTA_DESCTA').AsString
  else
    fraPlanoDeContas.edtDesCta.Text := '';
end;

procedure TfrmCtpAtribConf.pStepStatusSelecao(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmCtpAtribConf.pCarregaPlanoDeConta;
begin

  pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text);
  if not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) then
    fraPlanoDeContas.edtDesCta.Text := qryConCta.FieldByName('CTA_DESCTA').AsString
  else
    fraPlanoDeContas.edtDesCta.Text := '';
end;

procedure TfrmCtpAtribConf.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodPor);
end;

procedure TfrmCtpAtribConf.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrOk) Then
  Begin

    If ( Not fEmptyStr(edtCodPor.Text) ) Or
       ( Not fEmptyStr(fraCentroCusto.edtCodEve.Text) ) Or
       ( Not fEmptyStr(edtVeiobo.Text) ) Or
       ( Not fEmptyStr(edtVeioNF.Text) ) Or
       ( Not fEmptyStr(edtCheque.Text) ) Or
       ( Not fEmptyStr(edtDeposito.Text) ) Or
       ( Not fEmptyStr(edtPrevisao.Text) ) Or
       ( Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text)) Then
    Begin
      If (Not fVerificaCampos) Or
         (fMensagem('', 'Confirma a alteração das duplicatas?',[' &Sim ', ' &Não ']) = 2) Then
       Action := caNone;
    End;

  End;

end;

procedure TfrmCtpAtribConf.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma       := False;
  FstrCodPor        := '';
  FstrCodEve        := '';
  FstrVeiobo        := '';
  FstrVeioNF        := '';
  FstrUsaChq        := '';
  FstrDeposi        := '';
  FstrPrevis        := '';
  FstrPlanoContas   := '';
  ATemCtpDet        := False;
  FstrDtaCad        := '';
  FstrDtaVen        := '';
  FstrValDup        := '';
  FstrCompet        := '';
  strSenhaDtaCadOld := '';
  FTravaCamposNota := False;
  {*****************************}
  {* CLIENT RESPONSAVEL PELO   *}
  {* DESMEMBRAMENTO DE VALORES *}
  {**************************AN*}
  cdsCtpDet := TUniClientDataSet.Create(Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCriaClientTemporariaCtpDet('', '', '', '', '', cdsCtpDet);
  objFechamento := TFechamentoFinanceiro.Create(Self, Self.Name);
end;

procedure TfrmCtpAtribConf.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(qryConCta) Then
    FreeAndNil(qryConCta);
end;

procedure TfrmCtpAtribConf.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnGravar.Click;
  End;

end;

procedure TfrmCtpAtribConf.FormShow(Sender: TObject);
begin
  inherited;
  AQryDupMarcada  := fCriaQuery(Self);

  AQryDupMarcada.Close;
  AQryDupMarcada.SQL.Clear;
  AQryDupMarcada.SQL.Add('SELECT AUTOINCREM, CTP_NUMDUP, CTP_PARCEL, CTP_SEQBAI, ');
  AQryDupMarcada.SQL.Add('       CTP_CODEMP, CTP_CODFOR, CTP_SERIE_, CTP_VALDUP, ');
  AQryDupMarcada.SQL.Add('       CTP_DTACAD, CTP_DTAVEN, CTP_COMPET, CTP_DTAPAG  ');
  AQryDupMarcada.SQL.Add('FROM CADPAG ');
  AQryDupMarcada.SQL.Add('WHERE AUTOINCREM IN ('+ ADuplicataMarcada + ') ');
  AQryDupMarcada.Open;
  mskDtaCad.Enabled := fCfgSis('CTPCAD', varBoolean);
  mskDtaVen.Enabled := fCfgSis('CTPDTA', varBoolean);

  HabilitaCamposAlteraveis(blnBaixadas);


  If FTravaCamposNota Then
  Begin
    fraPlanoDeContas.mskCodCta.Enabled := False;
    edtValDup.Enabled := False;
    MskDtaCad.Enabled := False;
  End;
end;

procedure TfrmCtpAtribConf.HabilitaCamposAlteraveis(blnUsouFiltroBaixadas : boolean);
Begin

  If blnUsouFiltroBaixadas Then
  Begin
     edtCodPor.enabled   := False;
     mskDtaCad.enabled   := False;
     mskDtaVen.enabled   := False;
     edtValDup.enabled   := False;
     edtVeioBo.enabled   := False;
     edtCheque.enabled   := False;
     edtVeioNf.enabled   := False;
     edtPrevisao.enabled := False;
     edtDeposito.enabled := False;

     fracentrocusto.edtCodEve.enabled   := True;
     fraPlanoDeContas.mskCodCta.enabled := True;
     mskCompet.enabled                  := True;
     mmHist.enabled                     := True;
  End
  Else
  Begin
     edtCodPor.enabled   := True;
     mskDtaCad.enabled   := True;
     mskDtaVen.enabled   := True;
     edtValDup.enabled   := True;
     edtVeioBo.enabled   := True;
     edtCheque.enabled   := True;
     edtVeioNf.enabled   := True;
     edtPrevisao.enabled := True;
     edtDeposito.enabled := True;
  End;

End;

procedure TfrmCtpAtribConf.edtCodPorExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodPor.Text) Then
  Begin
    edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
  End;
end;

procedure TfrmCtpAtribConf.btnGravarClick(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(edtCodPor.Text)) And (fEmptyStr(fraCentroCusto.edtCodEve.Text)) And
     (fEmptyStr(edtVeiobo.Text)) And (fEmptyStr(edtVeioNF.Text)) And
     (fEmptyStr(edtCheque.Text)) And (fEmptyStr(edtDeposito.Text)) And
     (fEmptyStr(edtPrevisao.Text)) And (fEmptyStr(fraPlanoDeContas.MskCodCta.Text)) And
     (fEmptyStr(fTiraCaracEspeciais(MskDtaCad.Text))) And (fEmptyStr(fTiraCaracEspeciais(MskDtaVen.Text))) And
     (fEmptyStr(fTiraCaracEspeciais(edtValDup.Text))) And (fEmptyStr(fTiraCaracEspeciais(MskCompet.Text))) And
     (fEmptyStr(mmHist.Text)) Then
  Begin
    pMensagemOk('É necessário alterar alguma informação para confirmar!');
    pSetFocus(edtCodPor);
    Exit;
  End;

  If Not fVerificaCampos Then
    Exit;

  If not fEmptyStr(edtCodPor.Text) Then
  Begin
    FstrCodPor := edtCodPor.Text;
    blnConfirma := True;
   End
  Else FstrCodPor := '';

  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
  Begin
    FstrCodEve := fraCentroCusto.edtCodEve.Text;
    blnConfirma := True;
   End
  Else FstrCodEve:='';

  If Not fEmptyStr(edtVeiobo.Text) Then
  Begin
    FstrVeiobo := edtVeiobo.Text;
    blnConfirma := True;
   End
  Else FstrVeiobo:='';

  If Not fEmptyStr(edtVeioNF.Text) Then
  Begin
    FstrVeioNF := edtVeioNF.Text;
    blnConfirma := True;
   End
  Else FstrVeioNF:='';

  If Not fEmptyStr(edtCheque.Text) Then
  Begin
    FstrUsaChq := edtCheque.Text;
    blnConfirma := True;
   End
  Else FstrUsaChq:='';

  If Not fEmptyStr(edtDeposito.Text) Then
  Begin
    FstrDeposi := edtDeposito.Text;
    blnConfirma := True;
   End
  Else FstrDeposi:='';

  If Not fEmptyStr(edtPrevisao.Text) Then
  Begin
    FstrPrevis := edtPrevisao.Text;
    blnConfirma := True;
   End
  Else FstrPrevis:='';

  If Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
  Begin
    FstrPlanoContas := fraPlanoDeContas.MskCodCta.Text;
    blnConfirma := True;
   End
  Else FstrPlanoContas := '';

  If Not fEmptyStr(fTiraCaracEspeciais(MskDtaCad.Text)) Then
  Begin
    FstrDtaCad := MskDtaCad.Text;
    blnConfirma := True;
   End
  Else FstrDtaCad := '';

  If Not fEmptyStr(fTiraCaracEspeciais(MskDtaVen.Text)) Then
  Begin
    FstrDtaVen := MskDtaVen.Text;
    blnConfirma := True;
   End
  Else FstrDtaVen := '';

  If Not fEmptyStr(edtValDup.Text) Then
  Begin
    FstrValDup := edtValDup.Text;
    blnConfirma := True;
   End
  Else FstrValDup := '';

  If Not fEmptyStr(fTiraCaracEspeciais(MskCompet.Text)) Then
  Begin
    FstrCompet := MskCompet.Text;
    blnConfirma := True;
   End
  Else FstrCompet := '';

  If Not fEmptyStr(fTiraCaracEspeciais(mmHist.Text)) Then
  Begin
    FstrHistor  := mmHist.Text;
    blnConfirma := True;
   End
  Else FstrHistor := '';

  Close;
end;

procedure TfrmCtpAtribConf.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

End.


