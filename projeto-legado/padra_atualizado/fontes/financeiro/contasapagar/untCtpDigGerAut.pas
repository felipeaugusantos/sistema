unit untCtpDigGerAut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, MaskEditFocus,
  AppEvnts, BitBtnLockedIncrem, untFuncFat, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, Data.DB, Datasnap.DBClient, UniClientDataSet,
  EditFocus, Vcl.DBCtrls, DBEditFocus, Uni, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  QColorLabel, untLiberacao, untFrameCentroCustoEditFocus, untFechamentoFinanceiro,
  untFramePlanoDeContasMaskEdit;

type
  TfrmCtpDigGerAut = class(TfrmPai)
    pnlCabecalho: TPanel;
    btnConfirma: TBitBtnLocked;
    Label30: TLabel;
    edtNomPor: TEditFocus;
    Label9: TLabel;
    edtValDup: TEditFocus;
    edtDesSuj: TEditFocus;
    Label12: TLabel;
    edtJurSuj: TEditFocus;
    Label16: TLabel;
    Label34: TLabel;
    edtCompet: TMaskEditFocus;
    edtCodPor: TEditFocus;
    Label8: TLabel;
    edtDtaVen: TcxDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtNumDup: TEditFocus;
    edtSerie: TEditFocus;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    Label4: TLabel;
    ColorLabel1: TColorLabel;
    lbl1: TLabel;
    ColorLabel8: TColorLabel;
    Label33: TLabel;
    ColorLabel7: TColorLabel;
    Label32: TLabel;
    ColorLabel6: TColorLabel;
    edtPrevis: TEditFocus;
    edtVeioNF: TEditFocus;
    edtUsoCon: TEditFocus;
    edtPagAnt: TEditFocus;
    lblMulta: TLabel;
    edtMulSuj: TEditFocus;
    edtDtaCad: TcxDateEdit;
    lclDtaCad: TLabel;
    btnDesmembr: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtValDupEnter(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure btnDesmembrClick(Sender: TObject);
  private
    qryConCta: TUniQuery;
    qryCtaBai: TUniQuery;
    qryConEmp: TUniQuery;
    qryConFor: TUniQuery;
    qryConPor: TUniQuery;



    fltMaiorValorMonetario: Double;
    fltValorAnterior: Double;
    fltValOriAnt: Double;

    strCtaAnt: String;
    strCtaFor: String;
    strCtaAut: String;
    objLiberacao : TLiberacao;
    strSenhaDtaVenOld,
    strSenhaValorOld : String;
    objFechamento: TFechamentoFinanceiro;

    strSenhaDtaCadOld : String;


    procedure pCarregaCentroCusto;
    procedure pCarregaEventos;
    procedure pCarregaPortador;
    function fValidaCamposSN(Sender: TWinControl): Boolean;
    procedure pDesmembraValores;
    procedure pHabilitaBotoes;
    function fEntradaDeMercadorias: Boolean;
    function fTemDesmembramento: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodFor,
    strCodPor,
    strCodEve,
    strCodCta,
    strNumDup,
    strParcel,
    strSerie,
    strCompet,
    strCodEmp,
    strNomFor,
    strAutInc,
    strDtaVen,
    strDtaCad,
    strValDup,
    strDesSuj,
    strJurSuj,
    strMulSuj,
    strPrevis,
    strVeioNF,
    strUsoCon,
    strPagAnt,
    srtDtaPag : String;

    Old_strCompet,
    Old_strDtaVen,
    Old_strDtaCad,
    Old_strValDup,
    Old_strDesSuj,
    Old_strJurSuj,
    Old_strMulSuj,
    Old_strCodPor,
    Old_strCodEve,
    Old_strCodCta,
    Old_strPrevis,
    Old_strVeioNF,
    Old_strUsoCon,
    Old_strPagAnt : String;

    blnConfirma: Boolean;
    blnHabilitaPrevis, blnGravaApenasPrevisao : Boolean;

    intOpcLan : Integer;

    cdsCtpDet,
    cdsCtpDetClone: TUniClientDataSet;//MF: 281423 - 26/04/2023  - DESMEMBRAMENTO
  end;

var
  frmCtpDigGerAut: TfrmCtpDigGerAut;

implementation

uses untfuncoesSimples, untConsultas, untFuncoes, untConstantes, untCadCta, StrUtils,
  untCadPor, untPesqAux, untFuncoesConsulta,
  untCadPag, untDesmembrValores;//MF: 281423 - 26/04/2023  - DESMEMBRAMENTO

{$R *.dfm}

{ TfrmCtpDigData }

procedure TfrmCtpDigGerAut.btnDesmembrClick(Sender: TObject);
begin
  inherited;
  pDesmembraValores;//MF: 281423 - 26/04/2023  - DESMEMBRAMENTO
end;

procedure TfrmCtpDigGerAut.pDesmembraValores; //MF: 281423 - 26/04/2023  - DESMEMBRAMENTO
  Var
    frmDesmembrValores : TfrmDesmembrValores;
    I : Integer;
Begin
  {*****************************************************************************}
  {* SÓ PERMITI ENTRAR NA TELA DE DESMEMBRAMENTO SE O VALOR FOR MAIOR QUE ZERO *}
  {**************************************************************************LU*}
  {***************************************************************************}
  {* SOLICITAÇÃO DA MACHADO PARA LIBERAR DESMEMBRAMENTO DE VALORES NEGATIVOS *}
  {************************************************************09/01/2012**JU*}
  If (fStrToFloat(edtValDup.Text) = 0)Then
  Begin
    fMensagem('', 'Digite o Valor da Duplicata antes de realizar o desmembramento!', ['&Ok']);
    Exit;
  End;

  Try

    {*****************************************}
    {* CHAMA O FORM DE DESMEMBRAMENTO        *}
    {**************************************MV*}
    pCriarFormularios(TfrmDesmembrValores, frmDesmembrValores);
    frmDesmembrValores.DatasetCtpDet  := cdsCtpDet;
    frmDesmembrValores.strNumDup  := strNumDup;
    frmDesmembrValores.strParcel  := strParcel;
    frmDesmembrValores.strSerie   := strSerie;
    frmDesmembrValores.strCodEmp  := strCodEmp;
    frmDesmembrValores.strCodFor  := strCodFor;
    frmDesmembrValores.blnBaixada := False;
    frmDesmembrValores.edtNumDup.Text  := strNumDup;
    frmDesmembrValores.edtParcel.Text  := strParcel;

    frmDesmembrValores.pnlInfo.Caption := '';
    frmDesmembrValores.pnlInfo.Font.Color := clBlack;

    frmDesmembrValores.fltValTot  := fStrToFloat(edtValDup.Text);

    frmDesmembrValores.pnlInfo.Caption := '';
    frmDesmembrValores.pnlInfo.Font.Color := clBlack;

    If fCfgSis('UTICON', varBoolean) And fEntradaDeMercadorias Then
    Begin

      If fTemDesmembramento Then
      Begin

        With frmDesmembrValores Do
        Begin
          For I := 0 To Pred(ComponentCount) Do
          Begin
            If (Components[I] Is TPanel) Then
            Begin
              If (TPanel(Components[I]).Name <> 'pnlBotoesDesm') Then
                  TPanel(Components[I]).Enabled := False;
            End;
          End;

          frmDesmembrValores.DesabilitaTodosBotoes();

          pnlInfo.Caption := AnsiQuotedStr('Título oriundo de Entrada de Mercadorias. '
                                          +'Já contabilizado. Não será permitido alterar '
                                          +'a distribuição do Desmembramento.','"');
          pnlInfo.Font.Color := clRed;

        End;

      End;

    End;

    frmDesmembrValores.showModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmGerAutCtaPagar.pDesmembraValores]');
    End;
  End;
  pFreeAndNil(frmDesmembrValores);
End;

procedure TfrmCtpDigGerAut.edtCodPorKeyPress(Sender: TObject; var Key: Char);
Var
  arrPortador: TConsultasArray;
begin
  inherited;
  if fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtNomPor,
                   nil,
                   Key,
                   arrPortador,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   strCodEmp) Then
  Begin
    If (fValidaCampos(edtCodPor, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtpDigGerAut.edtValDupEnter(Sender: TObject);
begin
  inherited;
  edtValDup.Text := AnsiReplaceStr(edtValDup.Text,'.','');
end;

procedure TfrmCtpDigGerAut.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCompet);
end;

procedure TfrmCtpDigGerAut.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := false;
  qryConPor   := fCriaQuery(Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryCtaBai := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  objLiberacao := TLiberacao.Create;
end;

procedure TfrmCtpDigGerAut.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited;

end;

procedure TfrmCtpDigGerAut.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
    btnConfirma.Click;

  If (Key = VK_F8) Then
    btnDesmembr.Click;

end;

procedure TfrmCtpDigGerAut.FormShow(Sender: TObject);
begin
  inherited;
  edtCompet.Text := strCompet;
  edtDtaVen.Text := strDtaVen;
  edtDtaCad.Text := strDtaCad;
  edtValDup.Text := strValDup;
  edtDesSuj.Text := strDesSuj;
  edtJurSuj.Text := strJurSuj;
  edtMulSuj.Text := strMulSuj;
  edtCodPor.Text := strCodPor;
  edtPrevis.Text := strPrevis;
  edtVeioNF.Text := strVeioNF;
  edtUsoCon.Text := strUsoCon;
  edtPagAnt.Text := strPagAnt;
  fraCentroCusto.edtCodEve.Text := strCodEve;
  fraPlanoDeContas.MskCodCta.Text := strCodCta;

  edtPrevis.Enabled :=  blnHabilitaPrevis;

  Old_strCompet := strCompet;
  Old_strDtaVen := strDtaVen;
  Old_strDtaCad := strDtaCad;
  Old_strValDup := strValDup;
  Old_strDesSuj := strDesSuj;
  Old_strJurSuj := strJurSuj;
  Old_strMulSuj := strMulSuj;
  Old_strCodPor := strCodPor;
  Old_strCodEve := strCodEve;
  Old_strCodCta := strCodCta;
  Old_strPrevis := strPrevis;
  Old_strVeioNF := strVeioNF;
  Old_strUsoCon := strUsoCon;
  Old_strPagAnt := strPagAnt;

  fltValorAnterior := fStrToFloat(edtValDup.Text);
  strSenhaValorOld  := '';
  strSenhaDtaVenOld := '';
  strSenhaDtaCadOld := '';

  pCriaClientTemporariaCtpDet(strNumDup, strParcel, edtSerie.Text, strCodEmp, strCodFor, cdsCtpDet, cdsCtpDetClone); //MF: 281423 - 26/04/2023  - DESMEMBRAMENTO
  pHabilitaBotoes; //MF: 281423 - 26/04/2023  - DESMEMBRAMENTO
end;

procedure TfrmCtpDigGerAut.pHabilitaBotoes;//MF: 281423 - 26/04/2023  - DESMEMBRAMENTO
 Var
    blnEhEntradaMercadorias,
    blnTemDesmebramento : Boolean;
begin
  btnDesmembr.Enabled  := False;

  blnEhEntradaMercadorias := fEntradaDeMercadorias;
  blnTemDesmebramento  := fTemDesmembramento;

  btnDesmembr.Enabled  := (fVerificaAcessoSistema('CTPALTVLR')) And
                            //(Not blnTravarDes) And
                            (
                             ((blnEhEntradaMercadorias) And (blnTemDesmebramento))
                             Or (Not blnEhEntradaMercadorias)
                            );
end;

function TfrmCtpDigGerAut.fEntradaDeMercadorias: Boolean;//MF: 281423 - 26/04/2023  - DESMEMBRAMENTO
var
  qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    Result := False;

    If (fCfgSis('UTICON', varBoolean)) And
       (fCfgSis('TRVCON', varBoolean)) And
       (Not fEmptyStr(strNumDup)) Then
    Begin
      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT       ');
        SQL.Add('  FIS_NUMDOC ');
        SQL.Add('FROM         ');
        SQL.Add('  CADFIS     ');
        SQL.Add('  INNER JOIN CADPAG ON ');
        SQL.Add('	(FIS_NUMDOC = CTP_NUMDUP AND ');
        SQL.Add('  FIS_FORCLI = CTP_CODFOR	AND ');
        SQL.Add('  FIS_CODEMP = CTP_CODEMP) ');
        SQL.Add('WHERE        ');
        SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
        SQL.Add('  FIS_CODEMP = :CODEMP AND ');
        SQL.Add('  FIS_FORCLI = :CODFOR AND ');
        SQL.Add('  IFNULL( FIS_SERIE_, '' ) = IFNULL( CTP_SERIE_, '' ) AND ');
        SQL.Add('  FIS_TIP_FC = '+QuotedStr('F'));

        ParamByName('NUMDOC').AsString := strNumDup;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODFOR').AsString := strCodFor;
        Open;

        Result := Not IsEmpty;

        Close;
      End;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

function TfrmCtpDigGerAut.fTemDesmembramento: Boolean;//MF: 281423 - 26/04/2023  - DESMEMBRAMENTO
var
  qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    Result := False;

    If (Not fEmptyStr(strNumDup)) Then
    Begin
      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT       ');
        SQL.Add(' CTP_NUMDUP  ');
        SQL.Add('FROM         ');
        SQL.Add('  CTPDET     ');
        SQL.Add('WHERE        ');
        SQL.Add('     CTP_NUMDUP = :NUMDUP ');
        SQL.Add(' AND CTP_CODFOR = :CODFOR ');
        SQL.Add(' AND CTP_PARCEL = :PARCEL ');
        SQL.Add(' AND CTP_CODEMP = :CODEMP ');
        SQL.Add(' AND CTP_SERIE_ = :SERIE_ ');

        ParamByName('NUMDUP').AsString := strNumDup
        ;
        ParamByName('CODFOR').AsString := strCodFor;
        ParamByName('PARCEL').AsString := strParcel;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('SERIE_').AsString := edtSerie.Text;

        Open;

        Result := Not IsEmpty;

        Close;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCtpDigGerAut.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentCusto: TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentCusto, False) Then
  Begin
    If fValidaCampos(fraPlanoDeContas.MskCodCta, False) Then
      SelectNext(ActiveControl, True, True);

  End;
end;

function TfrmCtpDigGerAut.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    fltValDup: Double;
    blnPedeSenha: Boolean;
begin
  Result := True;


  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {*****************************************}
    {* VALIDA COMPETENCIA                    *}
    {**************************************BB*}
    if (Sender = edtCompet) then
    Begin
      If not fValidaDataStr('01/'+ edtCompet.Text) Then
      Begin
        pMensagemOk('Data informada na Competência não é válida!');
        Result := False;
      end

      Else If fEmptyStr(fTiraCaracEspeciais(edtCompet.Text)) Then
      Begin
        pMensagemOk('A Competência deve ser preenchida!');
        Result := False;
      End

      Else If Length(fTiraCaracEspeciais(Trim(edtCompet.Text))) < 6 Then
      Begin
        pMensagemOk('O ano da Competência deve ser preenchido com 4 dígitos!');
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO EVENTO             *}
    {**************************************LB*}
    Else If Sender = fraCentroCusto.edtCodEve  Then
    Begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        pCarregaEventos;
        If (fEmptyStr(fraCentroCusto.edtDesEve.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='R') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        If fCfgSis('CTPOBE', varBoolean) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Centro de Custos deve ser preenchido!', ['&O k']);
          Result := False;
        End;

        fraCentroCusto.edtDesEve.Clear;
      End;
    End

    {*****************************************}
    {* VALIDA A DATA DO VENCIMENTO           *}
    {**************************************MV*}
    Else If (Sender = edtDtaVen) And edtDtaVen.Enabled Then
    Begin
      If not fValidaDataStr(edtDtaVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Vencimento não é válida!', ['&O k']);
        Result := False;
      end

      Else If fEmptyStr(fTiraCaracEspeciais(edtDtaVen.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser preenchida!', ['&O k']);
        Result := False;
      End

      Else If (StrToDateDef(edtDtaVen.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'Data do Vencimento informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End

      Else If (StrToDate(edtDtaVen.Text) < StrToDate(edtDtaCad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser maior ou igual a Data de Cadastro!', ['&O k']);
        Result := False;
      End
      Else If (fCfgSis('CTPDTA', varBoolean)) And (StrToDate(strDtaVen) <> StrToDate(edtDtaVen.Text))And fEmptyStr(strSenhaDtaVenOld)Then
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
      End;

    End


    {*****************************************}
    {* VALIDA A DATA DO CADASTRO             *}
    {**************************************MV*}
    Else If (Sender = edtDtaCad) And edtDtaCad.Enabled Then
    Begin

      If not fValidaDataStr(edtDtaCad.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Cadastro não é válida!', ['&O k']);
        Result := False;
      end

      Else If fEmptyStr(fTiraCaracEspeciais(edtDtaCad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToDateDef(edtDtaCad.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'Data de Cadastro informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else If (fCfgSis('CTPCAD', varBoolean)) And (StrToDateDef(Old_strDtaCad, 0) <> StrToDateDef(edtDtaCad.Text, 0)) And fEmptyStr(strSenhaDtaCadOld) Then
      Begin
        If (Not fEmptyStr(fCfgSis('CTPSDC'))) Then
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
      End
      Else If  (not fCfgSis('CTPINF', varBoolean)) And (not fVerificaAcessoSistema('DTCADINF', strLoginUsuarioLogado))And
               (StrToDate(edtDtaCad.Text) <> VS_Date) And (StrToDateDef(Old_strDtaCad, 0) <> StrToDateDef(edtDtaCad.Text, 0)) Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Data de cadastro de duplicata inferior a data atual!');
        objLiberacao.objMsgLibera.pAddQuebra;
        objLiberacao.objMsgLibera.pAddTextoCaption('Data de cadastro', edtDtaCad.Text);
        objLiberacao.objMsgLibera.pAddTextoCaption('Duplicata' , strNumDup                          , 10);
        objLiberacao.objMsgLibera.pAddTextoCaption('Parcela'   , strParcel                          , 10);
        objLiberacao.objMsgLibera.pAddTextoCaption('Série'     , strSerie                           , 10);
        objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'   , strCodEmp                          , 10);
        objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor', strCodFor + ' - ' + strNomFor      , 10);

        objLiberacao.strDirAce := 'DTCADINF';
        objLiberacao.strSenLib := fCfgSis('SENFVU');
        objLiberacao.strMsgSen := 'Alterar Data de Cadastro';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCodDig := strLoginUsuarioLogado;
        objLiberacao.tipCliFor := cfFornecedor;

        If (Not objLiberacao.fLibera) Then
        Begin
          fMensagem('ATENÇÃO!','Não é permitido alterar a data do cadastro!', ['&O K']);
          Result := False;
        End
      End
      Else
      Begin

        If (StrToDate(edtDtaCad.Text) > StrToDate(edtDtaVen.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser menor ou igual a Data de Vencimento!', ['&O k']);
          Result := False;
        End;

      End;

      //FECHAMENTO FINANCEIRO
      //VERIFICA SE É INSERÇÃO OU UMA ALTERAÇÃO DE DATA DE CADASTRO

      if (StrToDate(Old_strDtaCad) <> StrToDate(edtDtaCad.Text)) then
      begin
        if objFechamento.FechamentoFinanceiroJaRealizado(strCodEmp, StrToDate(edtDtaCad.Text)) then
          Result := False;
      end;
    End

    Else If Sender = edtDesSuj Then
    Begin
      //FECHAMENTO FINANCEIRO
      If (fStrToFloat(strDesSuj) <> fStrToFloat(edtDesSuj.Text) ) Then
      begin
        if objFechamento.FechamentoFinanceiroJaRealizado(strCodEmp, StrToDate(edtDtaCad.Text)) then
          Result := False;
      end;
    end

    Else If Sender = edtJurSuj Then
    Begin
      //FECHAMENTO FINANCEIRO
      If (fStrToFloat(strJurSuj) <> fStrToFloat(edtJurSuj.Text) ) Then
      begin
        if objFechamento.FechamentoFinanceiroJaRealizado(strCodEmp, StrToDate(edtDtaCad.Text)) then
          Result := False;
      end;
    end

    Else If Sender = edtMulSuj Then
    Begin
      //FECHAMENTO FINANCEIRO
      If (fStrToFloat(strMulSuj) <> fStrToFloat(edtMulSuj.Text) ) Then
      begin
        if objFechamento.FechamentoFinanceiroJaRealizado(strCodEmp, StrToDate(edtDtaCad.Text)) then
          Result := False;
      end;
    end

    {*****************************************}
    {* VALIDA O VALOR DA DUPLICATA           *}
    {**************************************MV*}
    Else If Sender = edtValDup  Then
    Begin
      fltValDup := fStrToFloat(edtValDup.Text);

      If fEmptyStr(fTiraCaracEspeciais(edtValDup.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do Documento deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtValDup.Text) = 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do Documento deve ser diferente de Zero!', ['&O k']);
        Result := False;
      End;

      //FECHAMENTO FINANCEIRO
      If (fltValorAnterior <> fltValDup) Then
      begin
        if objFechamento.FechamentoFinanceiroJaRealizado(strCodEmp, StrToDate(edtDtaCad.Text)) then
          Result := False;
      end;

      If fVerificaAcessoSistema('CTPALTVLR') Then
      Begin
        If (FloatToStrF(fltMaiorValorMonetario, ffNumber, 12, 2) <> edtValDup.Text) Then
        Begin
          If fltValDup > MAX_VALMON Then
          Begin
            fltMaiorValorMonetario   := MAX_VALMON;
            edtValDup.Text := FloatToStr(fltMaiorValorMonetario);
          End;
          fltValOriAnt := fltValOriAnt + (fStrToFloat(edtValDup.Text) - fltMaiorValorMonetario);
          fltMaiorValorMonetario := fStrToFloat(edtValDup.Text);
        End;
          Exit;
      End
      Else
      Begin
        If fltValDup > MAX_VALMON Then
        Begin
          fltMaiorValorMonetario   := MAX_VALMON;
          edtValDup.Text := FloatToStr(fltMaiorValorMonetario);
        End;

        fltValOriAnt := fltValOriAnt + (fStrToFloat(edtValDup.Text) - fltMaiorValorMonetario);
        fltMaiorValorMonetario := fStrToFloat(edtValDup.Text);
      End;


      If (fCfgSis('CTPVAL', varBoolean)) And (fltValDup <> fltValorAnterior ) Then
      Begin
        If (Not fEmptyStr(fCfgSis('CTPSVD')) And fEmptyStr(strSenhaValorOld)) Then
        Begin
          If ffrmSenha(strSenha, 'Digite a Senha do Valor Duplicata') Then
          Begin
            If strSenha <> fCfgSis('CTPSVD') Then
              Result := False
            Else
              strSenhaValorOld := strSenha;
          End
          Else
            Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO PORTADOR           *}
    {**************************************JB*}
    Else If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        pCarregaPortador;
        If qryConPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End

        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, strCodEmp) Then
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
              fMensagem('ATENÇÃO!', 'Você não tem permissão para utilizar este portador!', ['&O k']);
              Result := False;
            End;
          End;
        End;

        If (Result) And (fCfgSis('CTPPOR', varBoolean)) And (strCodPor <> edtCodPor.Text) And (not fEmptyStr(strCodPor)) Then
        Begin
          If (Not fEmptyStr(fCfgSis('CTPSPO'))) Then
          Begin
            If ffrmSenha(strSenha, 'Digite a Senha do Portador da Duplicata') Then
            Begin
              If strSenha <> fCfgSis('CTPSPO') Then
                Result := False;
            End
            Else
              Result := False;
          End;
        End;

      End
      Else
      Begin
        If fCfgSis('CTPOBP', varBoolean) Then
        Begin
          fMensagem('ATENÇÃO!', 'O portador deve ser preenchido!', ['&O k']);
          Result := False;
        End;

        edtNomPor.Clear;
      End;
    End

    {*****************************************}
    {* VALIDA VALIDA O CENTRO DE CUSTO       *}
    {**************************************MV*}
    Else If (Sender = fraPlanoDeContas.MskCodCta) And fraPlanoDeContas.MskCodCta.Enabled Then
    Begin

      If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser preenchido!', ['&O k']);
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
      Else
      Begin
        pCarregaCentroCusto;
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          If Not fCfgSis('USACTF', varBoolean) Then
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k'])
          Else
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&O k']);

          Result := False;
        End
        Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
          Result := False;

        If (Result) And (strCtaAnt <> fraPlanoDeContas.MskCodCta.Text) Then
        Begin
            strCtaAnt := fraPlanoDeContas.MskCodCta.Text;
        End;

        If (Result) Then
        Begin
          blnPedeSenha := Not (fEmptyStr(strCtaFor) And fEmptyStr(strCtaAut));
          If Not fEmptyStr(strCtaFor) Then
            blnPedeSenha := blnPedeSenha And (strCtaFor <> fraPlanoDeContas.MskCodCta.Text);
          If Not fEmptyStr(strCtaAut) Then
            blnPedeSenha := blnPedeSenha And (strCtaAut <> fraPlanoDeContas.MskCodCta.Text);

          If blnPedeSenha And (Not fCfgSis('USACTF', varBoolean)) Then
          Begin
            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddTexto('ALTERAR PLANO DE CONTAS');
            objLiberacao.objMsgLibera.pAddQuebra;
            objLiberacao.objMsgLibera.pAddTextoCaption('Plano de contas anterior', strCtaAut + '-' + fRetNomeConta(strCtaAut));

            objLiberacao.objMsgLibera.pAddTextoCaption('Documento'           , IfThen(fEmptyStr(strNumDup), '',
                                                                                   strNumDup + '-' +
                                                                                   strParcel +
                                                                                   IfThen(fEmptyStr(strSerie), '',
                                                                                          '-' + strSerie) +
                                                                                   IfThen(fEmptyStr(strCodEmp), '',
                                                                                          '-' + strCodEmp))           , 20);
            objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor'          , strCodFor + '-' + strNomFor               , 20);
            objLiberacao.objMsgLibera.pAddTextoCaption('Data de cadastro'    , edtDtaCad.Text                            , 20);
            objLiberacao.objMsgLibera.pAddTextoCaption('Data de vencimento'  , edtDtaVen.Text                            , 20);
            objLiberacao.objMsgLibera.pAddTextoCaption('Valor'               , edtValDup.Text                            , 20);
            objLiberacao.objMsgLibera.pAddTextoCaption('Alterando para o plano de contas', fraPlanoDeContas.MskCodCta.Text + '-' + fraPlanoDeContas.edtDesCta.Text);

            objLiberacao.strDirAce := 'CTPALTCTA';
            objLiberacao.strMsgSen := 'Senha para alteração do plano de contas da conta a pagar';
            objLiberacao.strCodOpe := strLoginUsuarioLogado;

            If objLiberacao.fLibera Then
            Begin
              strCtaAut := fraPlanoDeContas.MskCodCta.Text;
            End
            Else
            Begin
              fraPlanoDeContas.MskCodCta.Text := strCtaAut;
              pCarregaCentroCusto;
              Result := False;
            End;
          End;
        End;
      End;
    End
    {************************************}
    {* VALIDA CAMPOS S/N *}
    {*********************************LB*}
    Else If ((Sender = edtPrevis) And edtPrevis.Enabled) Or
            ((Sender = edtVeioNF) And edtVeioNF.Enabled) Or
            ((Sender = edtUsoCon) And edtUsoCon.Enabled) Or
            ((Sender = edtPagAnt) And edtPagAnt.Enabled) then
    Begin
      Result := fValidaCamposSN(Sender);
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCtpDigGerAut.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If not fVerificaCampos Then
    Exit;

  blnConfirma := true;
  Close;
end;

procedure TfrmCtpDigGerAut.pCarregaCentroCusto;
begin

  If Not fCfgSis('USACTF', varBoolean) Then
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text)
  Else
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text, True, strCodFor);

  With qryConCta Do
  Begin
    if not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) then
      fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString
    else
      fraPlanoDeContas.edtDesCta.Text := '';
  End;
end;

procedure TfrmCtpDigGerAut.pCarregaEventos;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmCtpDigGerAut.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtNomPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

function TfrmCtpDigGerAut.fValidaCamposSN(Sender: TWinControl): Boolean;
begin
  Result := True;

  If Pos(TEditFocus(Sender).Text, 'SN') <= 0 Then
  Begin
    Result := False;
    fMensagem('','O campo deve ser informado com (S)im ou (N)ão!', ['&Ok']);
  End
  Else If TEditFocus(Sender).Text = 'N' Then
  Begin
    If (Sender = edtPrevis) Then
    Begin
      If (blnGravaApenasPrevisao) And (edtPrevis.Text = 'N') Then
      Begin
        If (Old_strPrevis <> edtPrevis.Text) And (fEmptyStr(srtDtaPag)) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO','Essa conta deve possuir o campo Previsão igual a (S)im!', ['&Ok']);
        End;
      End;
    End;
  End;
end;


end.

