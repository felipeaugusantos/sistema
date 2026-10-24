unit untRelCtpTitContas;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils, ComObj,
  QColorLabel, Menus, RLReport, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, cxProgressBar,
  Uni, untfuncoesFactory, AppEvnts, BitBtnLockedIncrem, untExcel, untGravando,
  untGeraExcel, DB, frxExportCSVTestabilidade, untTypesSistema, untIFuncoes;

type
  TfrmRelCtpTitContas = class(TfrmPaiRelatorio)
    gpbContas: TGroupBox;
    edtContas: TEditFocus;
    gpbBoleto: TGroupBox;
    edtBoleto: TEditFocus;
    gpbRelatorio: TGroupBox;
    edtRelatorio: TEditFocus;
    Label27: TLabel;
    mskContaIni: TMaskEditFocus;
    Label28: TLabel;
    mskContaFin: TMaskEditFocus;
    edtCodEmpresa: TEditFocus;
    lblEmpresa: TLabel;                 
    ColorLabel2: TColorLabel;
    ColorLabel3: TColorLabel;
    ColorLabel5: TColorLabel;
    edtDesContaIni: TEditFocus;
    edtDesContaFin: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label1: TLabel;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    gpbForHis: TGroupBox;
    ColorLabel6: TColorLabel;
    edtForHis: TEditFocus;
    gpbOrdem: TGroupBox;
    ColorLabel7: TColorLabel;
    ColorLabel8: TColorLabel;
    ColorLabel9: TColorLabel;
    edtOrdem: TEditFocus;
    GroupBox1: TGroupBox;
    Label25: TLabel;
    mskDtaIniC: TMaskEditFocus;
    Label26: TLabel;
    mskDtaFinC: TMaskEditFocus;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    mskDtaIniP: TMaskEditFocus;
    mskDtaFinP: TMaskEditFocus;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    mskDtaIniV: TMaskEditFocus;
    mskDtaFinV: TMaskEditFocus;
    chkBaiCarCredito: TCheckBox;
    svdExcel: TSaveDialog;
    Label6: TLabel;
    edtFimCta: TEditFocus;
    gpbIncPrevis: TGroupBox;
    lbl1: TColorLabel;
    lbl2: TColorLabel;
    lbl3: TColorLabel;
    edtIncPrevis: TEditFocus;
    ColorLabel4: TColorLabel;
    Label12: TLabel;
    edtCodFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    lblData: TColorLabel;
    chkQuePagEve: TCheckBox;
    chkQuePagFor: TCheckBox;
    ColorLabel10: TColorLabel;
    gpbValorExibido: TGroupBox;
    ColorLabel11: TColorLabel;
    edtValorExibido: TEditFocus;
    Label7: TLabel;
    edtCodPorBai: TEditFocus;
    edtDesPorBai: TEditFocus;
    Label8: TLabel;
    mskCompet: TMaskEditFocus;
    Label9: TLabel;
    edtCodPor: TEditFocus;
    lblPortador: TLabel;
    edtDesPortador: TEditFocus;
    procedure pCarregaGrupo(Var qryCadCta: TUniQuery);
    procedure mskContaIniExit(Sender: TObject);
    procedure mskContaIniKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaGrupo2(Var qryCadCta: TUniQuery);
    procedure mskContaFinExit(Sender: TObject);
    procedure mskContaFinKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEveExit(Sender: TObject);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaEventos(Var qryCadEve: TUniQuery);
    procedure edtCodFornecedorExit(Sender: TObject);
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorBaiKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
  private
    { Private declarations }
    strTitEmp: String;
    strTitEve: String;
    strTitCon: String;
    strTitPorBai: String;
    strUltimaLinha  : String;
    strUltimoGrupo  : String;
    strUltimoSubGru : String;
    strGrpCCusto    : String;
    strGrpCResult   : String;
    strGrpTipCta    : String;
    strPortador     : String;
    intRecNo        : Integer;

    fltSubOri: Double;
    fltSubPag: Double;
    fltSubJur: Double;
    fltSubDes: Double;

    fltGruOri: Double;
    fltGruPag: Double;
    fltGruJur: Double;
    fltGruDes: Double;

    fltLinOri: Double;
    fltLinPag: Double;
    fltLinJur: Double;
    fltLinDes: Double;

    fltTotOri: Double;
    fltTotPag: Double;
    fltTotJur: Double;
    fltTotDes: Double;

    qryRelatorio: TUniQuery;

    procedure pGeraExcelSin;
    procedure pGeraExcelAna;
    procedure pGeraGrupos(Var strLinha: String; Var strGrupo: String; Var strSubGrupo: String; Var strGruCC: String; Var strGruCR: String; Var strTipCta: String; blnPlus: Boolean = False);
    procedure pFiltroCentroCusto(Var strSql: String);

    procedure pMontaResumoAna(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pImpDetalhesAna(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);

    procedure pMontaResumoSin(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pImpDetalhesSin(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);

    procedure pCriaQryRelatorio;

    procedure pGeraCSV;
    function fGeraCSV(cxProgress : TcxProgressBar): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }

    arrContaIni : TConsultasArray;
    arrEmpresa  : TConsultasArray;
    arrEvento   : TConsultasArray;
    arrFornec   : TConsultasArray;
    arrPorBai   : TConsultasArray;
    arrPortador : TConsultasArray;

  end;

var
  frmRelCtpTitContas: TfrmRelCtpTitContas;

implementation

uses untQckCtpTitContas, untQckCtpTitContasSint,untMemo;

{$R *.dfm}

procedure TfrmRelCtpTitContas.mskContaIniExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskContaIni, edtDesContaIni,
                    arrContaIni, fRetNomeConta, nil, 'do Custo Inicial');

  If Length(arrContaIni) = 1 Then
  Begin
    mskContaFin.Enabled    := True;
    pSetFocus(mskContaFin);
  End
  Else
  Begin
    mskContaFin.Clear;
    edtDesContaFin.Clear;
    mskContaFinExit(Sender);

    mskContaFin.Enabled    := False;
//    edtDesContaFin.Enabled := False;
    pSetFocus(edtCodEve);
  End;
end;

procedure TfrmRelCtpTitContas.mskContaIniKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, mskContaIni, edtDesContaIni, Nil, Key, arrContaIni, False) Then
  Begin
    fvalidaCampos(mskContaIni,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpTitContas.pCarregaGrupo(Var qryCadCta: TUniQuery);
Begin
  If Not (fEmptyStr(mskContaIni.Text)) Then
    edtDesContaIni.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString
  Else
    edtDesContaIni.Text := '';
End;

procedure TfrmRelCtpTitContas.mskContaFinExit(Sender: TObject);
begin
  inherited;
  
  If fEmptyStr(mskContaFin.Text) Then
    edtDesContaFin.Text := 'TODOS'
  Else
    edtDesContaFin.Text := fRetNomeConta(mskContaFin.Text);

  If fEmptyStr(edtDesContaFin.Text) And (Not fEmptyStr(mskContaFin.Text))  Then
  Begin
    fMensagem('AVISO','Código da Conta não encontrado.', ['&O K']);
    mskContaFin.Clear;
    pSetFocus(mskContaFin);
  End;
end;

procedure TfrmRelCtpTitContas.mskContaFinKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCentroCusto: TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, mskContaFin, edtDesContaFin, Nil, Key, arrCentroCusto, False) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelCtpTitContas.pCarregaGrupo2(Var qryCadCta: TUniQuery);
Begin
  If Not (fEmptyStr(mskContaFin.Text)) Then
    edtDesContaFin.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString
  Else
    edtDesContaFin.Text := '';
End;

procedure TfrmRelCtpTitContas.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelCtpTitContas.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, fRetNomeEmpresa, Nil, 'da empresa');

end;

procedure TfrmRelCtpTitContas.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, True) Then
  Begin
    fValidaCampos(edtCodEmpresa,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelCtpTitContas.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaFinC) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFinC.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final (Cadastro) deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinC.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial (Cadastro) deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinC.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text))) Then
          Begin
            If StrToDate(mskDtaIniC.Text) > StrToDate(mskDtaFinC.Text) Then
            Begin
              fMensagem('','A data inicial (Cadastro) deve ser menor que a data final (Cadastro)!',['&O K']);
              Result := False;
            End;
          End;
        End;
      End;

    End
    {*********************************}
    {* VALIDA DATA FINAL - PAGAMENTO *}
    {******************************LU*}
    Else If (Sender = mskDtaFinP) Then
    Begin
      If (mskDtaFinP.Text = '  /  /    ') And (mskDtaIniP.Text <> '  /  /    ') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Data Final (Pagamento) deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (mskDtaFinP.Text <> '  /  /    ') And (mskDtaIniP.Text = '  /  /    ') Then
        Begin
          fMensagem('ATENÇÃO!','O campo Data Inicial (Pagamento) deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If (mskDtaFinP.Text <> '  /  /    ') And (mskDtaIniP.Text <> '  /  /    ') Then
          Begin
            If StrToDate(mskDtaIniP.Text) > StrToDate(mskDtaFinP.Text) Then
            Begin
              fMensagem('ATENÇÃO!','A data inicial (Pagamento) deve ser menor que a data final (Pagamento)!',['&O K']);
              Result := False;
            End;
          End;
        End;
      End;
    End
    {**********************************}
    {* VALIDA DATA FINAL - VENCIMENTO *}
    {*******************************LU*}
    Else If (Sender = mskDtaFinV) Then
    Begin
      If (mskDtaFinV.Text = '  /  /    ') And (mskDtaIniV.Text <> '  /  /    ') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Data Final (Vencimento) deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (mskDtaFinV.Text <> '  /  /    ') And (mskDtaIniV.Text = '  /  /    ') Then
        Begin
          fMensagem('ATENÇÃO!','O campo Data Inicial (Vencimento) deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If (mskDtaFinV.Text <> '  /  /    ') And (mskDtaIniV.Text <> '  /  /    ') Then
          Begin
            If StrToDate(mskDtaIniV.Text) > StrToDate(mskDtaFinV.Text) Then
            Begin
              fMensagem('ATENÇÃO!','A data inicial (Vencimento) deve ser menor que a data final (Vencimento)!',['&O K']);
              Result := False;
            End;
          End;
        End;
      End;
    End
    {****************************}
    {* VERIFICA CAMPO DO BOLETO *}
    {*************************AF*}
    Else If (Sender = edtBoleto) Then
    Begin
      If (edtBoleto.Text <> 'T') And (edtBoleto.Text <> 'N') And (edtBoleto.Text <> 'S') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Boleto deve ser T,N ou S.',['&O K']);
        Result := False;
      End;
    End
    {****************************}
    {* VERIFICA CAMPO DE CONTAS *}
    {*************************AF*}
    Else If (Sender = edtContas) Then
    Begin
      If (edtContas.Text <> 'T') And (edtContas.Text <> 'A') And (edtContas.Text <> 'Q') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Contas deve ser T,A ou Q.',['&O K']);
        Result := False;
      End
      Else If (edtContas.Text = 'Q') Then
        lblData.Caption := '(5) Data de Pagamento '
      Else
        lblData.Caption := '(5) Data de Vencimento';
    End
    {*******************************************}
    {* VALIDA FORHIS                           *}
    {****************************************AF*}
    Else If (Sender = edtForHis) Then
    Begin
      If (edtForHis.Text <> 'F') And (edtForHis.Text <> 'H') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Opção deve ser F ou H.',['&O K']);
        Result := False;
      End;
    End
    {****************************}
    {* VERIFICA CAMPO RELATÓRIO *}
    {*************************AF*}
    Else If (Sender = edtRelatorio) Then
    Begin
      If (edtRelatorio.Text <> 'A') And (edtRelatorio.Text <> 'S') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Relatório deve ser A ou S.',['&O K']);
        Result := False;
      End;
    End

    {******************************}
    {* VALIDA  FORNECEDOR         *}
    {***************************LA*}
    Else If (Sender = edtCodFornecedor) Then
    Begin
      pDesmarcaLista(edtCodFornecedor,arrFornec);
    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      pDesmarcaLista(edtCodEmpresa, arrEmpresa);

      If Not fEmptyStr(edtCodEmpresa.Text) And (edtCodEmpresa.Text <> '000') Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;

    End
    {****************************}
    {* VALIDA ORDEM             *}
    {*************************RL*}
    Else If (Sender = edtOrdem) Then
    Begin
      If Pos(edtOrdem.Text, '123456') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Ordem deve ser 1, 2, 3, 4, 5 ou 6.',['&O K']);
        Result := False;
      End
      Else If (edtOrdem.Text = '4') Then
      Begin
        chkQuePagEve.Enabled := True;
        chkQuePagFor.Enabled := False;
      End
      Else If (edtOrdem.Text = '6') Then
      Begin
        chkQuePagFor.Enabled := True;
        chkQuePagEve.Enabled := False;
      End
      Else
      Begin
        chkQuePagEve.Checked := False;
        chkQuePagEve.Enabled := False;
        chkQuePagFor.Checked := False;
        chkQuePagFor.Enabled := False;
      End;
    End

    Else If (Sender = edtIncPrevis) Then
    Begin
      If fEmptyStr(edtIncPrevis.Text) Then
      Begin
        fMensagem('ATEÇÃO','O Campo Gerar deve ser preenchido!',['&OK']);
        Result := False;
      End
      Else
      If Pos(edtIncPrevis.Text,'T_S_P_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO','O Campo Gerar deve conter somente T, S ou P!',['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDestino) Then
    Begin
      If fEmptyStr(edtDestino.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtDestino.Text, 'V_I_E_C_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser (V)ídeo, (I)mpressora, (E)xcel ou (C)sv!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtValorExibido) Then
    Begin
      If Pos(edtValorExibido.Text, '12') <= 0 Then
      Begin
        fMensagem('','O campo Valor a ser exibido deve ser 1 ou 2',['&OK']);
        Result := False;
      End;
    End

    Else If Sender = edtCodPorBai Then
    Begin
      If Not fEmptyStr(edtCodPorBai.Text) And (edtCodPorBai.Text <> '00000') Then
      Begin

        edtDesPorBai.Text := fRetNomPortador(edtCodPorBai.Text);

        If fEmptyStr(edtDesPorBai.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPorBai.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;

      End
      Else
        edtDesPorBai.Text := 'TODOS';
    End;

    if (Sender = mskCompet) then
    Begin

      if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
      begin

        If not fValidaDataStr('01/'+ mskCompet.Text) Then
        Begin
          pMensagemOk('Data informada na Competência não é válida!');
          Result := False;
        End;

      end;

    End;

    If Sender = edtCodPor Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) And (edtCodPor.Text <> '00000') Then
      Begin

        edtDesPortador.Text := fRetNomPortador(edtCodPor.Text);

        If fEmptyStr(edtDesPortador.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
        if (edtCodPor.Text = '00000') Then
          edtDesPortador.Text := '+1'
        else
          edtDesPortador.Text := 'TODOS';

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelCtpTitContas.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIniC.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  mskDtaFinC.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  inherited;
end;

procedure TfrmRelCtpTitContas.btnImprimirClick(Sender: TObject);
  Var
    strSQL      : String;
    strEvento   : String;
    strEmpresa  : String;
    strGroup    : String;
    strFornec   : String;
    strPorBai   : String;
    intCont     : Integer;
    strUnion    : String;
    qryAux      : TUniQuery;
    lstLista    : TStringList;
    strCodCta   : String;
begin
  If (fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text)) And fEmptyStr(fTiraCaracEspeciais(mskDtaIniP.Text)) And fEmptyStr(fTiraCaracEspeciais(mskDtaIniV.Text))) Or
     (fEmptyStr(fTiraCaracEspeciais(mskDtaFinC.Text)) And fEmptyStr(fTiraCaracEspeciais(mskDtaFinP.Text)) And fEmptyStr(fTiraCaracEspeciais(mskDtaFinV.Text))) Then
  Begin
    fMensagem('', 'Uma data deve ser selecionada!', ['&OK']);
    Exit;
  End;

  qryAux := fCriaQuery(Nil);

  If fRetornaCtaResDuplicado(qryAux) Then
  Begin
    lstLista := TStringList.Create;

    lstLista.Add('---------------------------------------------------------------------');
    lstLista.Add('     PLANOS DE CONTAS DUPLICADOS NO CADASTRO DE CONTAS RESULTADO     ');
    lstLista.Add('---------------------------------------------------------------------');
    lstLista.Add('CONTAS RESULTADO   PLANO DE CONTAS   DESCRICAO                       ');
    lstLista.Add('---------------------------------------------------------------------');

    With qryAux Do
    Begin
      First;

      strCodCta := FieldByName('CRE_CODCTA').AsString;

      While Not Eof Do
      Begin
        If FieldByName('CRE_CODCTA').AsString = strCodCta Then
          lstLista.Add(fPadC(FieldByName('CRE_CODCRE').AsString, 16) +
                       fPadC(Copy(FieldByName('CRE_CODCTA').AsString, 01, 02) + '.' +
                             Copy(FieldByName('CRE_CODCTA').AsString, 03, 02) + '.' +
                             Copy(FieldByName('CRE_CODCTA').AsString, 05, 03), 20) + ' ' +
                       fPadR(FieldByName('CTA_DESCTA').AsString, 40) )
        Else
        Begin
          lstLista.Add(' ');
          lstLista.Add(fPadC(FieldByName('CRE_CODCRE').AsString, 16) +
                       fPadC(Copy(FieldByName('CRE_CODCTA').AsString, 01, 02) + '.' +
                             Copy(FieldByName('CRE_CODCTA').AsString, 03, 02) + '.' +
                             Copy(FieldByName('CRE_CODCTA').AsString, 05, 03), 20) + ' ' +
                       fPadR(FieldByName('CTA_DESCTA').AsString, 40) );
          strCodCta := FieldByName('CRE_CODCTA').AsString;
        End;

        Next;
      End;

      lstLista.Add(' ');
      lstLista.Add('---------------------------------------------------------------------');
      lstLista.Add('SERA NECESSARIO ACESSAR O MENU DE CADASTROS, AUXILIARES, CONTAS DE   ');
      lstLista.Add('RESULTADO, E EXCLUIR OS REGISTROS DUPLICADOS, DEIXANDO APENAS O      ');
      lstLista.Add('PLANO DE CONTAS DENTRO DE UMA UNICA CONTA DE RESULTADO.              ');
      lstLista.Add('---------------------------------------------------------------------');

    End;

    Try
      pCriarFormularios(TfrmMemo, frmMemo);
      frmMemo.cxMemo.Lines := lstLista;
      frmMemo.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmRelCtpTitContas.btnImprimirClick]');
      End;
    End;

    pFreeAndNil(frmMemo);

    FreeAndNil(qryAux);
    FreeAndNil(lstLista);

    Exit;

  End
  Else
    FreeAndNil(qryAux);

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;
  If SameText(edtDestino.Text, 'E') Or SameText(edtDestino.Text, 'C') Then
  Begin
    btnImprimir.Enabled := False;
    blnImprime := fVerificaCampos;
  End
  Else
    inherited;

  If blnImprime Then
  Begin

    If edtRelatorio.Text = 'A' Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

      If edtOrdem.Text = '4' Then
        strSQL := strSQL + '  CONCAT(EVE_CODEVE, " - ", EVE_DESEVE)     AS DESCRE, '
      Else If edtOrdem.Text = '6' Then
        strSQL := strSQL + '  FOR_NOMFOR     AS DESCRE, '
      Else If edtOrdem.Text = '5' Then
      Begin
        If edtContas.Text = 'Q' Then
          strSQL := strSQL + '  P.CTP_DTAPAG AS DESCRE, '
        Else
          strSQL := strSQL + '  P.CTP_DTAVEN AS DESCRE, ';
      End
      Else
        strSQL := strSQL + '  CONCAT(G.CRE_CODCRE, " - ", G.CRE_DESCRE) AS DESCRE, ';

      strSQL := strSQL + '  CONCAT(C.CTA_CODCTA, "-", C.CTA_DESCTA) AS DESCTA,                                        ';
      strSQL := strSQL + '  C.CTA_DESCTA AS DESCR_CENTRO,                                                             ';
      strSQL := strSQL + '  CONCAT(                                                                                   ';
      strSQL := strSQL + '         C.CTA_TIPCTA, " - ",                                                               ';
      strSQL := strSQL + '         IF(                                                                                ';
      strSQL := strSQL + '            C.CTA_TIPCTA = 1,                                                               ';
      strSQL := strSQL + '            "VENDA BRUTA/RECEITAS",                                                         ';
      strSQL := strSQL + '             IF (                                                                           ';
      strSQL := strSQL + '                 C.CTA_TIPCTA = 2,                                                          ';
      strSQL := strSQL + '                 "CUSTO DO PRODUTO",                                                        ';
      strSQL := strSQL + '                  IF(                                                                       ';
      strSQL := strSQL + '                     C.CTA_TIPCTA = 3,                                                      ';
      strSQL := strSQL + '                     "DESPESAS",                                                            ';
      strSQL := strSQL + '                     IF(                                                                    ';
      strSQL := strSQL + '                        C.CTA_TIPCTA = 4,                                                   ';
      strSQL := strSQL + '                        "DESPESAS FINANCEIRAS",                                             ';
      strSQL := strSQL + '                        IF(C.CTA_TIPCTA = 5, "COMPRAS", "")                                 ';
      strSQL := strSQL + '            ))))) AS CTA_TIPCTA,                                                            ';
      strSQL := strSQL + '  IF(D.CTP_CODCTA IS NULL, P.CTP_CODEMP, D.CTP_CODEMP) AS CTP_CODEMP,                       ';
      strSQL := strSQL + '  F.FOR_NOMFOR,                                                                             ';
      strSQL := strSQL + '  P.CTP_PORBAI,                                                                             ';
      strSQL := strSQL + '  P.CTP_CODFOR,                                                                             ';
      strSQL := strSQL + '  P.CTP_NUMDUP,                                                                             ';
      strSQL := strSQL + '  P.CTP_PARCEL,                                                                             ';
      strSQL := strSQL + '  P.CTP_SERIE_,                                                                             ';
      strSQL := strSQL + '  P.CTP_DTACAD,                                                                             ';
      strSQL := strSQL + '  P.CTP_DTAVEN,                                                                             ';
      strSQL := strSQL + '  P.CTP_USACHQ,                                                                             ';
      strSQL := strSQL + '  P.CTP_VEIOBO,                                                                             ';
      strSQL := strSQL + '  P.CTP_DTAPAG,                                                                             ';
      strSQL := strSQL + '  EVE_RAT AS CTP_CODEVE,                                                                    ';
      strSQL := strSQL + '  P.CTP_HIST01,                                                                             ';
      strSQL := strSQL + '  P.CTP_HIST02,                                                                             ';
      strSQL := strSQL + '  P.CTP_HISBAI,                                                                             ';
      strSQL := strSQL + '  P.CTP_CODCTA,                                                                             ';
      strSQL := strSQL + '  ABRV,                                                                                     ';
      strSQL := strSQL + '  VAPG AS CTP_VALPAG,                                                                       ';
      strSQL := strSQL + '  IF(D.CTP_FATCAL IS NULL, P.CTP_VALORI, ROUND(P.CTP_VALORI*D.CTP_FATCAL,2)) AS CTP_VALORI, ';
      strSQL := strSQL + '  IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP, ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2)) AS CTP_VALDUP, ';
      strSQL := strSQL + '  IF(D.CTP_FATCAL IS NULL, P.CTP_VALDES, ROUND(P.CTP_VALDES*D.CTP_FATCAL,2)) AS CTP_VALDES, ';
      strSQL := strSQL + '  IF(D.CTP_FATCAL IS NULL, P.CTP_VALJUR, ROUND(P.CTP_VALJUR*D.CTP_FATCAL,2)) AS CTP_VALJUR, ';
      strSQL := strSQL + '  IF(D.CTP_FATCAL IS NULL, P.CTP_VENDOR, ROUND(P.CTP_VENDOR*D.CTP_FATCAL,2)) AS CTP_VENDOR, ';
      strSQL := strSQL + '  IF(D.CTP_FATCAL IS NULL, P.CTP_DESSUJ, ROUND(P.CTP_DESSUJ*D.CTP_FATCAL,2)) AS CTP_DESSUJ, ';
      strSQL := strSQL + '  IF(D.CTP_FATCAL IS NULL, P.CTP_JURSUJ, ROUND(P.CTP_JURSUJ*D.CTP_FATCAL,2)) AS CTP_JURSUJ  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADPAG P ';
      strSQL := strSQL + '  INNER JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
      strSQL := strSQL + '                         P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
      strSQL := strSQL + '                        ((P.CTP_SERIE_ = D.CTP_SERIE_) OR                                ';
      strSQL := strSQL + '                        (P.CTP_SERIE_ IS NULL OR D.CTP_SERIE_ IS NULL))                  ';
      strSQL := strSQL + '  JOIN CADFOR F ON P.CTP_CODFOR = F.FOR_CODFOR ';
      strSQL := strSQL + '  JOIN CADCTA C ON CONS = C.CTA_CODCTA ';
      strSQL := strSQL + '  LEFT JOIN CTARES R ON R.CRE_CODCTA = ABRV '; //AND R.CRE_CODEMP = P.CTP_CODEMP '; COMENTEI POIS CTARES NÃO É POR EMPRESA ASS ALEXANDRE
      strSQL := strSQL + '  LEFT JOIN CTAGER G ON TRIM(R.CRE_CODCRE) = TRIM(G.CRE_CODCRE) ';

      If edtOrdem.Text = '4' Then
        strSQL := strSQL + '  LEFT JOIN CADEVE ON EVE_CODEVE = EVE_RAT ';

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  TRUE ';

//      If (edtOrdem.Text = '3') Then
//        strSQL := strSQL + '  AND C.CTA_TIPCTA = "3" ';

      If edtContas.Text = 'A' Then
        strSQL := strSQL + '  AND P.CTP_DTAPAG IS NULL '

      Else If edtContas.Text = 'Q' Then
        strSQL := strSQL + '  AND P.CTP_DTAPAG IS NOT NULL ';

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text)) Then strSQL := strSQL + '  AND P.CTP_DTACAD BETWEEN :DTAINIC AND :DTAFINC ';
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniP.Text)) Then strSQL := strSQL + '  AND P.CTP_DTAPAG BETWEEN :DTAINIP AND :DTAFINP ';
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniV.Text)) Then strSQL := strSQL + '  AND P.CTP_DTAVEN BETWEEN :DTAINIV AND :DTAFINV ';

      {**************************}
      {* FILTRO POR COMPETÊNCIA *}
      {************************BB}
      if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
        strSQL := strSQL + '  AND CTP_COMPET = :COMPET ';

      {*******************************************}
      {* MONTA O FILTRO DO CENTRO DE CUSTO       *}
      {****************************************JC*}
      pFiltroCentroCusto(strSQL);

      strSql := strSQL + fStrLocate(edtCodEmpresa,  arrEmpresa,  'IF(D.CTP_CODCTA IS NULL, P.CTP_CODEMP, D.CTP_CODEMP)', 'CODEMP');
      strSql := strSQL + fStrLocate(edtCodEve,  arrEvento,  'IF(D.CTP_CODEVE IS NULL, P.CTP_CODEVE, D.CTP_CODEVE)', 'CODEVE');
      strSql := strSQL + fStrLocate(edtCodFornecedor,arrFornec,'P.CTP_CODFOR','CODFOR');

      If Not fEmptyStr(edtCodPorBai.Text) Then
        strSql := strSQL + fStrLocate(edtCodPorBai, arrPorBai, 'P.CTP_PORBAI', 'PORBAI')
      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        strSQL := strSQL + ' AND (IFNULL(P.CTP_PORBAI, "") = "" ';
        strSQL := strSQL + ' OR LOCATE(P.CTP_PORBAI, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      End;

      If Not fEmptyStr(edtCodPor.Text) Then
        strSQL  := strSQL + fStrLocate(edtCodPor,  arrPortador,  'P.CTP_CODPOR', 'CODPOR')
      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        strSQL := strSQL + ' AND (IFNULL(CTP_CODPOR, "") = "" ';
        strSQL := strSQL + ' OR LOCATE(CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      End;


      If Not fEmptyStr(edtFimCta.Text) Then
        strSQL := strSQL + ' AND RIGHT(P.CTP_CODCTA,3) = :FIMCTA ';

      If (edtBoleto.Text = 'S') Then
        strSQL := strSQL + '  AND P.CTP_VEIOBO = ' + QuotedStr('S')
      Else If (edtBoleto.Text = 'N') Then
        strSQL := strSQL + '  AND P.CTP_VEIOBO = ' + QuotedStr('N');

      If (Not chkBaiCarCredito.Checked) Then
      Begin
        strSQL := strSQL + ' AND (((P.CTP_SERIE_ <> "CRT") OR (P.CTP_SERIE_ IS NULL))';
        If (Not fEmptyStr(fCfgSis('CTACAR'))) Then
          strSQL := strSQL + '  AND (P.CTP_CODCTA <> ' + QuotedStr(fCfgSis('CTACAR')) + ')';
        strSQL := strSQL + ')';
      End;

      If (edtIncPrevis.Text = 'S') Then
        strSQL  := strSQL + '  AND P.CTP_PREVIS <> "S" '
      Else If (edtIncPrevis.Text = 'P') Then
        strSQL  := strSQL + '  AND P.CTP_PREVIS = "S"  ';

      {*******************************************}
      {* COMPLEMENTANDO                          *}
      {****************************************AF*}
      strSQL := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL,'VAPG','ROUND(P.CTP_VALPAG * D.CTP_FATCAL,2)'), 'ABRV', 'C.CTA_CODCTA'), 'CONS', 'D.CTP_CODCTA'), 'EVE_RAT', 'D.CTP_CODEVE')  +
                ' UNION ALL ' +
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'INNER', 'LEFT'),'VAPG','ROUND(P.CTP_VALPAG,2)'), 'ABRV', 'C.CTA_CODCTA'), 'CONS', 'P.CTP_CODCTA'), 'EVE_RAT', 'P.CTP_CODEVE') +
                ' AND D.CTP_CODCTA IS NULL ';

      If edtOrdem.Text = '1' Then
      Begin
        strSQL := strSQL + ' ORDER BY ';
        strSQL := strSQL + '  CTA_CODCTA, CTP_NUMDUP, ';
        strSQL := strSQL + '  CTP_PARCEL, CTP_CODEMP ';
      End;

      If edtOrdem.Text = '2' Then
      Begin
        strSQL := strSQL + ' ORDER BY ';
        strSQL := strSQL + '  CTA_CODCTA, DESCR_CENTRO, CTP_NUMDUP, ';
        strSQL := strSQL + '  CTP_PARCEL, CTP_CODEMP ';
      End;

      If edtOrdem.Text = '3' Then
      Begin
        strSQL := strSQL + ' ORDER BY ';
        strSQL := strSQL + '  CTA_TIPCTA, DESCRE, DESCTA, CTP_NUMDUP, ';
        strSQL := strSQL + '  CTP_PARCEL, CTP_CODEMP ';
      End;

      If Pos(edtOrdem.Text, '456') > 0 Then
      Begin
        strSQL := strSQL + ' ORDER BY ';
        strSQL := strSQL + '  DESCRE, DESCTA, CTP_NUMDUP, ';
        strSQL := strSQL + '  CTP_PARCEL, CTP_CODEMP ';
      End;

      With qryRelatorio Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text)) Then
        Begin
          ParamByName('DTAINIC').AsDate := StrToDate(mskDtaIniC.Text);
          ParamByName('DTAFINC').AsDate := StrToDate(mskDtaFinC.Text);
        End;

        If Not fEmptyStr(edtFimCta.Text) Then
          ParamByName('FIMCTA').AsString := edtFimCta.Text;

        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniP.Text)) Then
        Begin
          ParamByName('DTAINIP').AsDate := StrToDate(mskDtaIniP.Text);
          ParamByName('DTAFINP').AsDate := StrToDate(mskDtaFinP.Text);
        End;

        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniV.Text)) Then
        Begin
          ParamByName('DTAINIV').AsDate := StrToDate(mskDtaIniV.Text);
          ParamByName('DTAFINV').AsDate := StrToDate(mskDtaFinV.Text);
        End;

        If Not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
          ParamByName('COMPET').AsString := mskCompet.Text;

        pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryRelatorio);
        pSetaParam(edtCodEve.Text, arrEvento, strEvento, 'CODEVE', qryRelatorio);
        pSetaParam(edtCodFornecedor.Text,arrFornec,strFornec,'CODFOR',qryRelatorio);

        If Not fEmptyStr(edtCodPorBai.Text) Then
          pSetaParam(edtCodPorBai.Text, arrPorBai, strPorBai, 'PORBAI', qryRelatorio);

        If Not fEmptyStr(edtDesPortador.Text) Then
          pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryRelatorio);

        Open;
      End;

      If Not qryRelatorio.IsEmpty Then
      Begin
        Try
          pCriarFormularios(TfrmQckCtpTitContas,frmQckCtpTitContas);

          frmQckCtpTitContas.dtsRelatorio.DataSet := qryRelatorio;

          If strTipImp = 'M' Then
            frmQckCtpTitContas.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckCtpTitContas.qckPagina.DefaultFilter := Nil;

          frmQckCtpTitContas.strOrdem := 'PERIODO';
          frmQckCtpTitContas.strValExi := edtValorExibido.Text;

          If mskDtaIniC.Text <> '  /  /    ' Then
            frmQckCtpTitContas.strOrdem := frmQckCtpTitContas.strOrdem + ' - CADASTRO: ' + mskDtaIniC.Text + ' A ' + mskDtaFinC.Text ;

          If mskDtaIniV.Text <> '  /  /    ' Then
            frmQckCtpTitContas.strOrdem := frmQckCtpTitContas.strOrdem + ' - VENCIMENTO: ' + mskDtaIniV.Text + ' A ' + mskDtaFinV.Text ;

          If mskDtaIniP.Text <> '  /  /    ' Then
            frmQckCtpTitContas.strOrdem := frmQckCtpTitContas.strOrdem + ' - PAGAMENTO: ' + mskDtaIniP.Text + ' A ' + mskDtaFinP.Text ;

            frmQckCtpTitContas.rllNomeRelatorio.Caption := 'RELATORIO DE TITULOS POR PLANO DE CONTAS (ANALITICO) - ABERTOS';
          If edtContas.Text = 'Q' Then
            frmQckCtpTitContas.rllNomeRelatorio.Caption := 'RELATORIO DE TITULOS POR PLANO DE CONTAS (ANALITICO) - QUITADOS';
          If edtContas.Text = 'T' Then
            frmQckCtpTitContas.rllNomeRelatorio.Caption := 'RELATORIO DE TITULOS POR PLANO DE CONTAS (ANALITICO) - ABERTOS E QUITADOS';

          If Not fEmptyStr(edtFimCta.Text) Then
            frmQckCtpTitContas.rllFimCta.Caption := 'FINAL DA CONTA: ' + edtFimCta.Text
          Else
            frmQckCtpTitContas.rllFimCta.Caption := 'FINAL DA CONTA: TODOS';

          If edtCodPor.Text = '' Then
            frmQckCtpTitContas.rllPortador.Caption := 'PORTADOR: TODOS'
          Else
            frmQckCtpTitContas.rllPortador.Caption := fStrTitulo(edtCodPor.Text, edtDesPortador, arrPortador, strPortador, 'PORTADOR');


          strTitCon := '';

          If Length(arrContaIni) > 1 Then
          Begin
            strTitCon := 'CONTA INICIAL: ';
            For intCont := 0 To Length(arrContaIni) -1 Do
              strTitCon := strTitCon + arrContaIni[intCont].strCodigo + ifthen(intCont < (Length(arrContaIni) -1), ',','');
          End

          Else If (Not fEmptyStr(mskContaIni.Text)) And (Not fEmptyStr(mskContaFin.Text)) Then
          Begin
            strTitCon := 'CONTA INICIAL: ' + mskContaIni.Text + ' - ' + edtDesContaIni.Text + '     ' +
                         'CONTA FINAL: '   + mskContaFin.Text + ' - ' + edtDesContaFin.Text;
          End

          Else If (Not fEmptyStr(mskContaIni.Text)) Then
          Begin
            strTitCon := 'CONTA INICIAL: ' + mskContaIni.Text + ' - ' + edtDesContaIni.Text + '     ' +
                         'CONTA FINAL: TODAS';
          End

          Else
            strTitCon := 'CONTA INICIAL: TODAS     CONTA FINAL: TODAS';

          frmQckCtpTitContas.rllConta.Caption := strTitCon;

          frmQckCtpTitContas.rllFornecedor.Caption := fStrTitulo(edtCodFornecedor.Text,edtDesFornecedor,arrFornec,strFornec,'FORNECEDOR');
          frmQckCtpTitContas.rllEmpresa.Caption := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA');
          frmQckCtpTitContas.rllPorBai.Caption := fStrTitulo(edtCodPorBai.Text, edtDesPorBai, arrPorBai, strPorBai, 'PORTADOR BAIXA');

          If edtValorExibido.Text = '1' Then
            frmQckCtpTitContas.rllValorExibido.Caption := 'VALOR EXIBIDO: VLR. LIQUIDO'
          Else
            frmQckCtpTitContas.rllValorExibido.Caption := 'VALOR EXIBIDO: VLR. BRUTO';

          strTitEmp := frmQckCtpTitContas.rllEmpresa.Caption;
          strTitPorBai := frmQckCtpTitContas.rllPorBai.Caption;

          frmQckCtpTitContas.rllEventos.Caption := fStrTitulo(edtCodEve.Text, edtDesEve, arrEvento, strEvento, 'CENTRO DE CUSTOS');
          strTitEve := frmQckCtpTitContas.rllEventos.Caption;

          If edtOrdem.Text = '1' Then
            frmQckCtpTitContas.rllOrdenacao.Caption  := 'ORDERNADO POR: PLANO DE CONTAS - CODIGO';
          If edtOrdem.Text = '2' Then
            frmQckCtpTitContas.rllOrdenacao.Caption  := 'ORDERNADO POR: PLANO DE CONTAS - DESCRICAO';
          If edtOrdem.Text = '3' Then
          Begin
            frmQckCtpTitContas.rllOrdenacao.Caption  := 'ORDERNADO POR: CONTA DE RESULTADO';
            frmQckCtpTitContas.rllTitRes.Caption     := 'CONTA DE RESULTADO:';
            frmQckCtpTitContas.rllTotRes.Caption     := 'Total Conta de Resultado:';
          End;
          If edtOrdem.Text = '4' Then
          Begin
            frmQckCtpTitContas.rllOrdenacao.Caption  := 'ORDERNADO POR: CENTRO DE CUSTOS';
            frmQckCtpTitContas.rllTitRes.Caption     := 'CENTRO DE CUSTOS:';
            frmQckCtpTitContas.rllTotRes.Caption     := 'Total do Centro de Custos:';
            frmQckCtpTitContas.blnQueEve             := chkQuePagEve.Checked;
          End;
          If edtOrdem.Text = '5' Then
          Begin
            If (edtContas.Text = 'Q') Then
            Begin
              frmQckCtpTitContas.rllOrdenacao.Caption  := 'ORDERNADO POR: DATA DE PAGAMENTO';
              frmQckCtpTitContas.rllTitRes.Caption     := 'DATA DE PAGAMENTO:';
            End
            Else
            Begin
              frmQckCtpTitContas.rllOrdenacao.Caption  := 'ORDERNADO POR: DATA DE VENCIMENTO';
              frmQckCtpTitContas.rllTitRes.Caption     := 'DATA DE VENCIMENTO:';
            End;
            frmQckCtpTitContas.rllTotRes.Caption     := 'Total da Data:';
          End;
          If edtOrdem.Text = '6' Then
          Begin
            frmQckCtpTitContas.rllOrdenacao.Caption  := 'ORDERNADO POR: FORNECEDOR';
            frmQckCtpTitContas.rllTitRes.Caption     := 'FORNECEDOR:';
            frmQckCtpTitContas.rllTotRes.Caption     := 'Total do Fornecedor:';
            frmQckCtpTitContas.blnQueFor             := chkQuePagFor.Checked;
          End;

          frmQckCtpTitContas.strForHis := edtForHis.Text;
          If (edtForHis.Text = 'H') Then
          Begin
            frmQckCtpTitContas.rdbHistorico.Visible := False;
            frmQckCtpTitContas.rdbHitorico2.Visible := False;

            frmQckCtpTitContas.rlbDetalheGrupo.Height := 14;
            frmQckCtpTitContas.rlbDetalheSint.Height := 14;
          End;

          If edtBoleto.Text = 'S' Then
            frmQckCtpTitContas.rllBoleto.Caption := 'VEIO BOL?: SIM'
          Else If edtBoleto.Text = 'N' Then
            frmQckCtpTitContas.rllBoleto.Caption := 'VEIO BOL?: NAO'
          Else
            frmQckCtpTitContas.rllBoleto.Caption := 'VEIO BOL?: TODOS';

          If edtForHis.Text = 'F' Then
            frmQckCtpTitContas.rllForHis.Caption := 'OPÇÃO: FORNECEDOR'
          Else
            frmQckCtpTitContas.rllForHis.Caption := 'OPÇÃO: HISTORICO';

          If (edtIncPrevis.Text = 'S') Then
            frmQckCtpTitContas.rllIncPrevis.Caption := 'INCLUIDO PREVISAO: NAO'

          Else If (edtIncPrevis.Text = 'P') Then
            frmQckCtpTitContas.rllIncPrevis.Caption := 'APENAS PREVISAO'

          Else If (edtIncPrevis.Text = 'T') Then
            frmQckCtpTitContas.rllIncPrevis.Caption := 'INCLUIDO PREVISAO: SIM';

          If edtOrdem.Text = '2' Then
          Begin
            frmQckCtpTitContas.rlbGrupo.Visible        := False;
            frmQckCtpTitContas.rlbGrupo2.Visible       := True;
            frmQckCtpTitContas.rlbTituloGrupo2.Visible := False;
            frmQckCtpTitContas.rlbSumarioGrupo2.Visible:= False;
            frmQckCtpTitContas.rllTotalGeral.Alignment := taRightJustify;
          End;

          If Pos(edtOrdem.Text, '3456') > 0 Then
          Begin
            frmQckCtpTitContas.rlbGrupo.Visible        := False;
            frmQckCtpTitContas.rlbGrupo2.Visible       := True;
            frmQckCtpTitContas.rllTotalGeral.Alignment := taRightJustify;
          End;

          {*****************************************}
          {* VERIFICA SE UTILIZA O CAMPO VENDOR    *}
          {**************************************RV*}
          frmQckCtpTitContas.rllVendor.Visible       := fCfgSis('CTPVND', varBoolean);
          frmQckCtpTitContas.rllVendorPar.Visible    := fCfgSis('CTPVND', varBoolean);
          frmQckCtpTitContas.rllVendorTotGru.Visible := fCfgSis('CTPVND', varBoolean);
          frmQckCtpTitContas.rllVendorResGru.Visible := fCfgSis('CTPVND', varBoolean);
          frmQckCtpTitContas.rllVendorRod.Visible    := fCfgSis('CTPVND', varBoolean);
          frmQckCtpTitContas.rlbVendor.Visible       := fCfgSis('CTPVND', varBoolean);
          frmQckCtpTitContas.rlbVendorGru1.Visible   := fCfgSis('CTPVND', varBoolean);
          frmQckCtpTitContas.rlbVendorGru2.Visible   := fCfgSis('CTPVND', varBoolean);
          frmQckCtpTitContas.rlbVendorGru3.Visible   := fCfgSis('CTPVND', varBoolean);

          If edtDestino.Text = 'V' Then
            frmQckCtpTitContas.qckPagina.PreviewModal
          Else If edtDestino.Text = 'I' Then
            frmQckCtpTitContas.qckPagina.Print
          Else If edtDestino.Text = 'E' Then
            pGeraExcelAna
          Else If edtDestino.Text = 'C' Then
            pGeraCSV;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao - Analitico)]');
          End;
        End;

        pFreeAndNil(frmQckCtpTitContas);

      End
      Else
      Begin
        pTabelaVazia;
      End;

    End
    Else
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

      If edtOrdem.Text = '4' Then
      Begin
        strSQL := strSQL + '  CONCAT(EVE_CODEVE, " - ", EVE_DESEVE)     AS DESCRE, ';
        strSQL := strSQL + '  EVE_CODEVE AS CODCRE, ';
      End
      Else If edtOrdem.Text = '6' Then
      Begin
        strSQL := strSQL + '  FOR_NOMFOR     AS DESCRE, ';
        strSQL := strSQL + '  FOR_CODFOR AS CODCRE, ';
      End
      Else If edtOrdem.Text = '5' Then
      Begin

        If edtContas.Text = 'Q' Then
          strSQL := strSQL + '  P.CTP_DTAPAG AS DESCRE, '
        Else
          strSQL := strSQL + '  P.CTP_DTAVEN AS DESCRE, ';

      End

      Else
      Begin
        strSQL := strSQL + '  CONCAT(G.CRE_CODCRE, " - ", G.CRE_DESCRE) AS DESCRE, ';
        strSQL := strSQL + '  G.CRE_CODCRE AS CODCRE, ';
      End;

      strSQL := strSQL + '  CONCAT(C.CTA_CODCTA, "-", C.CTA_DESCTA) AS DESCTA, ';
      strSQL := strSQL + '  C.CTA_DESCTA AS DESCR_CENTRO, ';
      strSQL := strSQL + '  CONCAT(                                                  ';
      strSQL := strSQL + '         CTA_TIPCTA, " - ",                                ';
      strSQL := strSQL + '         IF(                                               ';
      strSQL := strSQL + '            CTA_TIPCTA = 1,                                ';
      strSQL := strSQL + '            "VENDA BRUTA/RECEITAS",                        ';
      strSQL := strSQL + '             IF (                                          ';
      strSQL := strSQL + '                 CTA_TIPCTA = 2,                           ';
      strSQL := strSQL + '                 "CUSTO DO PRODUTO",                       ';
      strSQL := strSQL + '                  IF(                                      ';
      strSQL := strSQL + '                     CTA_TIPCTA = 3,                       ';
      strSQL := strSQL + '                     "DESPESAS",                           ';
      strSQL := strSQL + '                     IF(                                   ';
      strSQL := strSQL + '                        CTA_TIPCTA = 4,                    ';
      strSQL := strSQL + '                        "DESPESAS FINANCEIRAS",            ';
      strSQL := strSQL + '                        IF(CTA_TIPCTA = 5, "COMPRAS", "")  ';
      strSQL := strSQL + '            ))))) AS CTA_TIPCTA,                           ';
      strSQL := strSQL + '  IF(D.CTP_CODCTA IS NULL, P.CTP_CODEMP, D.CTP_CODEMP) AS CTP_CODEMP, ';
      strSQL := strSQL + '  LEFT(IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA),4) AS GRUPO, ';
      strSQL := strSQL + '  IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA) AS CTP_CODCTA, ';
      strSQL := strSQL + '  C.CTA_DESCTA, ';
      strSQL := strSQL + '  EVE_RAT AS CTP_CODEVE, ';
      strSQL := strSQL + '  VAPG         AS VALPAG, ';

      If edtValorExibido.Text = '1' Then
      Begin
        strSQL := strSQL + '  SUM(IF(P.CTP_DTAPAG IS NULL, ';
        strSQL := strSQL + '         IF(D.CTP_FATCAL IS NULL, ';
        strSQL := strSQL + '                P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ, 0) + IFNULL(P.CTP_JURSUJ, 0) + IFNULL(P.CTP_VENDOR, 0), ';
        strSQL := strSQL + '                ROUND((P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ, 0) + IFNULL(P.CTP_JURSUJ, 0) + IFNULL(P.CTP_VENDOR, 0)) * D.CTP_FATCAL, 2) ';
        strSQL := strSQL + '               ), ';
        strSQL := strSQL + '         IF(D.CTP_FATCAL IS NULL, ';
        strSQL := strSQL + '                P.CTP_VALORI, ';
        strSQL := strSQL + '                ROUND(P.CTP_VALORI * D.CTP_FATCAL, 2) ';
        strSQL := strSQL + '               ))) AS VALOR,';
      End
      Else
      Begin
        strSQL := strSQL + '  SUM(IF(P.CTP_DTAPAG IS NULL, ';
        strSQL := strSQL + '         IF(D.CTP_FATCAL IS NULL, ';
        strSQL := strSQL + '                P.CTP_VALDUP, ';
        strSQL := strSQL + '                ROUND(P.CTP_VALDUP * D.CTP_FATCAL, 2) ';
        strSQL := strSQL + '               ) + IFNULL(P.CTP_VENDOR, 0), ';
        strSQL := strSQL + '         IF(D.CTP_FATCAL IS NULL, ';
        strSQL := strSQL + '                P.CTP_VALORI, ';
        strSQL := strSQL + '                ROUND(P.CTP_VALORI * D.CTP_FATCAL, 2) ';
        strSQL := strSQL + '               ))) AS VALOR,';
      End;

      strSQL := strSQL + '  SUM(IF(D.CTP_FATCAL IS NULL, P.CTP_VALJUR, ROUND(P.CTP_VALJUR*D.CTP_FATCAL,2))) AS VALJUR, ';
      strSQL := strSQL + '  SUM(IF(D.CTP_FATCAL IS NULL, P.CTP_VALDES, ROUND(P.CTP_VALDES*D.CTP_FATCAL,2))) AS VALDES ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADPAG P ';
      strSQL := strSQL + '  INNER JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
      strSQL := strSQL + '                         P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
      strSQL := strSQL + '                       ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
      strSQL := strSQL + '                       (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';
      strSQL := strSQL + '  JOIN CADFOR F ON P.CTP_CODFOR = F.FOR_CODFOR ';
      strSQL := strSQL + '  JOIN CADCTA C ON CONS = C.CTA_CODCTA ';
      strSQL := strSQL + '  LEFT JOIN CTARES R ON R.CRE_CODCTA = ABRV ';//AND R.CRE_CODEMP = P.CTP_CODEMP '; COMENTEI POIS CTARES NÃO É POR EMPRESA ASS ALEXANDRE
      strSQL := strSQL + '  LEFT JOIN CTAGER G ON TRIM(R.CRE_CODCRE) = TRIM(G.CRE_CODCRE) ';

      If edtOrdem.Text = '4' Then
        strSQL := strSQL + '  LEFT JOIN CADEVE ON EVE_CODEVE = EVE_RAT ';

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  TRUE ';

//      If (edtOrdem.Text = '3') Then
//        strSQL := strSQL + '  AND C.CTA_TIPCTA = "3" ';

      If edtContas.Text = 'A' Then
        strSQL := strSQL + '  AND P.CTP_DTAPAG IS NULL '
      Else If edtContas.Text = 'Q' Then
        strSQL := strSQL + '  AND P.CTP_DTAPAG IS NOT NULL ';

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text)) Then strSQL := strSQL + '  AND P.CTP_DTACAD BETWEEN :DTAINIC AND :DTAFINC ';
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniP.Text)) Then strSQL := strSQL + '  AND P.CTP_DTAPAG BETWEEN :DTAINIP AND :DTAFINP ';
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniV.Text)) Then strSQL := strSQL + '  AND P.CTP_DTAVEN BETWEEN :DTAINIV AND :DTAFINV ';

      pFiltroCentroCusto(strSQL);

      If Not fEmptyStr(edtFimCta.Text) Then
        strSQL := strSQL + ' AND RIGHT(P.CTP_CODCTA,3) = :FIMCTA ';

      strSql := strSQL + fStrLocate(edtCodEmpresa,  arrEmpresa,  'IF(D.CTP_CODCTA IS NULL, P.CTP_CODEMP, D.CTP_CODEMP)', 'CODEMP');
      strSql := strSQL + fStrLocate(edtCodEve,  arrEvento,  'IF(D.CTP_CODEVE IS NULL, P.CTP_CODEVE, D.CTP_CODEVE)', 'CODEVE');
      strSql := strSQL + fStrLocate(edtCodFornecedor,arrFornec,'P.CTP_CODFOR','CODFOR');

      If Not fEmptyStr(edtCodPorBai.Text) Then
        strSql := strSQL + fStrLocate(edtCodPorBai, arrPorBai, 'P.CTP_PORBAI', 'PORBAI')
      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        strSQL := strSQL + ' AND (IFNULL(P.CTP_PORBAI, "") = "" ';
        strSQL := strSQL + ' OR LOCATE(P.CTP_PORBAI, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      End;

      If Not fEmptyStr(edtCodPor.Text) Then
        strSQL  := strSQL + fStrLocate(edtCodPor,  arrPortador,  'P.CTP_CODPOR', 'CODPOR')
      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        strSQL := strSQL + ' AND (IFNULL(CTP_CODPOR, "") = "" ';
        strSQL := strSQL + ' OR LOCATE(CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      End;



      If (edtBoleto.Text = 'S') Then
        strSQL := strSQL + '  AND P.CTP_VEIOBO = ' + QuotedStr('S')
      Else If (edtBoleto.Text = 'N') Then
        strSQL := strSQL + '  AND P.CTP_VEIOBO = ' + QuotedStr('N');

      If (Not chkBaiCarCredito.Checked) Then
      Begin
        strSQL := strSQL + ' AND ((P.CTP_SERIE_ <> "CRT") ';
        If (Not fEmptyStr(fCfgSis('CTACAR'))) Then
          strSQL := strSQL + '  AND (P.CTP_CODCTA <> ' + QuotedStr(fCfgSis('CTACAR')) + ')';
        strSQL := strSQL + ')';
      End;

      If (edtIncPrevis.Text = 'S') Then
        strSQL  := strSQL + '  AND P.CTP_PREVIS <> "S" '
      Else If (edtIncPrevis.Text = 'P') Then
        strSQL  := strSQL + '  AND P.CTP_PREVIS = "S"  ';

      If edtOrdem.Text = '1' Then strGroup := '  CTP_CODCTA ';
      If edtOrdem.Text = '2' Then strGroup := '  CTP_CODCTA ';
      If edtOrdem.Text = '3' Then strGroup := '  CTA_TIPCTA, DESCRE, DESCTA  ';

      If Pos(edtOrdem.Text, '456') > 0 Then
        strGroup := '  DESCRE, DESCTA ';//'  CTP_CODCTA, DESCRE ';

      strSQL := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL,'VAPG','SUM(ROUND(P.CTP_VALPAG * D.CTP_FATCAL,2))'), 'ABRV', 'C.CTA_CODCTA'), 'CONS', 'D.CTP_CODCTA'), 'EVE_RAT', 'D.CTP_CODEVE') + '  GROUP BY ' + strGroup +
          ' UNION ALL ' +
          AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'INNER', 'LEFT'),'VAPG','SUM(ROUND(P.CTP_VALPAG,2))'), 'ABRV', 'C.CTA_CODCTA'), 'CONS', 'P.CTP_CODCTA'), 'EVE_RAT', 'P.CTP_CODEVE') +
          ' AND D.CTP_CODCTA IS NULL GROUP BY ' + strGroup;

      strSQL := strSQL + ' ORDER BY ';

      If edtOrdem.Text = '1' Then strSQL := strSQL + '  CTP_CODCTA ';
      If edtOrdem.Text = '2' Then strSQL := strSQL + '  DESCR_CENTRO ';
      If edtOrdem.Text = '3' Then strSQL := strSQL + '  CTA_TIPCTA, DESCRE, DESCTA ';
      If Pos(edtOrdem.Text, '456') > 0 Then
        strSQL := strSQL + '  DESCRE, DESCTA ';

      strUnion := strSQL;

      With qryRelatorio Do
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
        strSQL := strSQL + '  DESCRE, ';
        strSQL := strSQL + '  DESCTA, ';
        strSQL := strSQL + '  DESCR_CENTRO, ';
        strSQL := strSQL + '  CTA_TIPCTA, ';
        strSQL := strSQL + '  GRUPO, ';
        strSQL := strSQL + '  CTP_CODCTA, ';
        strSQL := strSQL + '  CTA_DESCTA, ';
        strSQL := strSQL + '  CTP_CODEVE, ';
        strSQL := strSQL + '  SUM(VALOR) AS VALOR, ';
        strSQL := strSQL + '  SUM(VALPAG) AS VALPAG, ';
        strSQL := strSQL + '  SUM(VALJUR) AS VALJUR, ';
        strSQL := strSQL + '  SUM(VALDES) AS VALDES ';
        strSQL := strSQL + 'FROM (';
        strSQL := strSQL + strUnion +  ') AS TAB ' ;
        strSQL := strSQL + 'GROUP BY ';

        If (edtOrdem.Text = '1') Or (edtOrdem.Text = '2') Then
          strSQL := strSQL + ' CTP_CODCTA '
        Else
          strSQL := strSQL + ' DESCRE, DESCTA ';

        strSQL := strSQL + ' ORDER BY ';

        If edtOrdem.Text = '1' Then strSQL := strSQL + '  CTP_CODCTA ';
        If edtOrdem.Text = '2' Then strSQL := strSQL + '  DESCR_CENTRO ';
        If edtOrdem.Text = '3' Then strSQL := strSQL + '  CTA_TIPCTA, DESCRE, DESCTA ';
        If Pos(edtOrdem.Text, '456') > 0 Then
          strSQL := strSQL + '  DESCRE, DESCTA ';

        With qryRelatorio Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);  

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text)) Then
          Begin
            ParamByName('DTAINIC').AsDate := StrToDate(mskDtaIniC.Text);
            ParamByName('DTAFINC').AsDate := StrToDate(mskDtaFinC.Text);
          End;

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniP.Text)) Then
          Begin
            ParamByName('DTAINIP').AsDate := StrToDate(mskDtaIniP.Text);
            ParamByName('DTAFINP').AsDate := StrToDate(mskDtaFinP.Text);
          End;

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniV.Text)) Then
          Begin
            ParamByName('DTAINIV').AsDate := StrToDate(mskDtaIniV.Text);
            ParamByName('DTAFINV').AsDate := StrToDate(mskDtaFinV.Text);
          End;

          If Not fEmptyStr(edtCodEmpresa.Text) Then
            ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

          If Not fEmptyStr(edtFimCta.Text) Then
            ParamByName('FIMCTA').AsString := edtFimCta.Text;

          pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryRelatorio);
          pSetaParam(edtCodEve.Text, arrEvento, strEvento, 'CODEVE', qryRelatorio);
          pSetaParam(edtCodFornecedor.Text,arrFornec,strFornec,'CODFOR',qryRelatorio);

          If Not fEmptyStr(edtCodPorBai.Text) Then
            pSetaParam(edtCodPorBai.Text, arrPorBai, strPorBai, 'PORBAI', qryRelatorio);

          If Not fEmptyStr(edtDesPortador.Text) Then
            pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryRelatorio);
          
          Open;
        End;
      End;

      If Not qryRelatorio.IsEmpty Then
      Begin
        Try
          pCriarFormularios(TfrmQckCtpTitContasSint,frmQckCtpTitContasSint);

          frmQckCtpTitContasSint.dtsRelatorio.DataSet := qryRelatorio;

          If strTipImp = 'M' Then
            frmQckCtpTitContasSint.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckCtpTitContasSint.qckPagina.DefaultFilter := Nil;

          frmQckCtpTitContasSint.strOrdem := 'PERIODO';
          frmQckCtpTitContasSint.strValExi := edtValorExibido.Text;

          If mskDtaIniC.Text <> '  /  /    ' Then
            frmQckCtpTitContasSint.strOrdem := frmQckCtpTitContasSint.strOrdem + ' - CADASTRO: ' + mskDtaIniC.Text + ' A ' + mskDtaFinC.Text ;

          If mskDtaIniV.Text <> '  /  /    ' Then
            frmQckCtpTitContasSint.strOrdem := frmQckCtpTitContasSint.strOrdem + ' - VENCIMENTO: ' + mskDtaIniV.Text + ' A ' + mskDtaFinV.Text ;

          If mskDtaIniP.Text <> '  /  /    ' Then
            frmQckCtpTitContasSint.strOrdem := frmQckCtpTitContasSint.strOrdem + ' - PAGAMENTO: ' + mskDtaIniP.Text + ' A ' + mskDtaFinP.Text ;

          If edtContas.Text = 'A' Then
            frmQckCtpTitContasSint.rllNomeRelatorio.Caption := 'RELATORIO DE TITULOS POR PLANO DE CONTAS (SINTETICO) - ABERTOS';
          If edtContas.Text = 'Q' Then
            frmQckCtpTitContasSint.rllNomeRelatorio.Caption := 'RELATORIO DE TITULOS POR PLANO DE CONTAS (SINTETICO) - QUITADOS';
          If edtContas.Text = 'T' Then
            frmQckCtpTitContasSint.rllNomeRelatorio.Caption := 'RELATORIO DE TITULOS POR PLANO DE CONTAS (SINTETICO) - ABERTOS E QUITADOS';

          strTitCon := '';

          If Not fEmptyStr(edtFimCta.Text) Then
            frmQckCtpTitContasSint.rllFimCta.Caption := 'FINAL DA CONTA: ' + edtFimCta.Text
          Else
            frmQckCtpTitContasSint.rllFimCta.Caption := 'FINAL DA CONTA: TODOS';

          If Length(arrContaIni) > 1 Then
          Begin
            strTitCon := 'CONTA INICIAL: ';
            For intCont := 0 To Length(arrContaIni) -1 Do
              strTitCon := strTitCon + arrContaIni[intCont].strCodigo + ifthen(intCont < (Length(arrContaIni) -1), ',','');
          End

          Else If (Not fEmptyStr(mskContaIni.Text)) And (Not fEmptyStr(mskContaFin.Text)) Then
          Begin
            strTitCon := 'CONTA INICIAL: ' + mskContaIni.Text + ' - ' + edtDesContaIni.Text + '     ' +
                         'CONTA FINAL: '   + mskContaFin.Text + ' - ' + edtDesContaFin.Text;
          End

          Else If (Not fEmptyStr(mskContaIni.Text)) Then
          Begin
            strTitCon := 'CONTA INICIAL: ' + mskContaIni.Text + ' - ' + edtDesContaIni.Text + '     ' +
                         'CONTA FINAL: TODAS';
          End

          Else
            strTitCon := 'CONTA INICIAL: TODAS     CONTA FINAL: TODAS';

          frmQckCtpTitContasSint.rllConta.Caption := strTitCon;

          If edtCodEmpresa.Text = '' Then
            frmQckCtpTitContasSint.rllEmpresa.Caption := 'EMPRESA: TODAS'
          Else
            frmQckCtpTitContasSint.rllEmpresa.Caption := 'EMPRESA: ' + edtDesEmpresa.Text;
          strTitEmp := frmQckCtpTitContasSint.rllEmpresa.Caption;

          frmQckCtpTitContasSint.rllEventos.Caption      := fStrTitulo(edtCodEve.Text, edtDesEve, arrEvento, strEvento, 'CENTRO DE CUSTO');
          frmQckCtpTitContasSint.rllFornecedor.Caption   := fStrTitulo(edtCodFornecedor.Text,edtDesFornecedor,arrFornec,strFornec,'FORNECEDOR');
          frmQckCtpTitContasSint.rllPorBai.Caption       := fStrTitulo(edtCodPorBai.Text, edtDesPorBai, arrPorBai, strPorBai, 'PORTADOR BAIXA');

          If edtCodPor.Text = '' Then
            frmQckCtpTitContasSint.rllPortador.Caption := 'PORTADOR: TODOS'
          Else
            frmQckCtpTitContasSint.rllPortador.Caption := fStrTitulo(edtCodPor.Text, edtDesPortador, arrPortador, strPortador, 'PORTADOR');

          If edtValorExibido.Text = '1' Then
            frmQckCtpTitContasSint.rllValorExibido.Caption := 'VALOR EXIBIDO: VLR. LIQUIDO'
          Else
            frmQckCtpTitContasSint.rllValorExibido.Caption := 'VALOR EXIBIDO: VLR. BRUTO';  

          strTitEve := frmQckCtpTitContasSint.rllEventos.Caption;

          If edtOrdem.Text = '1' Then
            frmQckCtpTitContasSint.rllOrdenacao.Caption  := 'ORDERNADO POR: PLANO DE CONTAS - CODIGO';
          If edtOrdem.Text = '2' Then
            frmQckCtpTitContasSint.rllOrdenacao.Caption  := 'ORDERNADO POR: PLANO DE CONTAS - DESCRICAO';
            
          If edtOrdem.Text = '3' Then
          Begin
            frmQckCtpTitContasSint.rllOrdenacao.Caption  := 'ORDERNADO POR: CONTA DE RESULTADO';
            frmQckCtpTitContasSint.rllTitRes.Caption  := 'CONTA DE RESULTADO:';
            frmQckCtpTitContasSint.rllTotRes.Caption  := 'Total Conta de Resultado:';
          End;
          If edtOrdem.Text = '4' Then
          Begin
            frmQckCtpTitContasSint.rllOrdenacao.Caption  := 'ORDERNADO POR: CENTRO DE CUSTOS';
            frmQckCtpTitContasSint.rllTitRes.Caption  := 'CENTRO DE CUSTOS:';
            frmQckCtpTitContasSint.rllTotRes.Caption  := 'Total do Centro de Custos:';
          End;
          If edtOrdem.Text = '5' Then
          Begin
            frmQckCtpTitContasSint.rllOrdenacao.Caption  := 'ORDERNADO POR: DATA';
            frmQckCtpTitContasSint.rllTitRes.Caption  := 'DATA:';
            frmQckCtpTitContasSint.rllTotRes.Caption  := 'Total da Data:';
          End;
          If edtOrdem.Text = '6' Then
          Begin
            frmQckCtpTitContasSint.rllOrdenacao.Caption  := 'ORDERNADO POR: FORNECEDOR';
            frmQckCtpTitContasSint.rllTitRes.Caption  := 'FORNECEDOR:';
            frmQckCtpTitContasSint.rllTotRes.Caption  := 'Total do Fornecedor:';
          End;

          If (edtIncPrevis.Text = 'S') Then
            frmQckCtpTitContasSint.rllIncPrevis.Caption := 'INCLUIDO PREVISAO: NAO'

          Else If (edtIncPrevis.Text = 'P') Then
            frmQckCtpTitContasSint.rllIncPrevis.Caption := 'APENAS PREVISAO'

          Else If (edtIncPrevis.Text = 'T') Then
            frmQckCtpTitContasSint.rllIncPrevis.Caption := 'INCLUIDO PREVISAO: SIM';

          If (edtOrdem.Text = '2') Then
          Begin
            frmQckCtpTitContasSint.rlbGrupo.Visible        := False;
            frmQckCtpTitContasSint.rlbGrupo2.Visible       := True;
            frmQckCtpTitContasSint.rlbTituloGrupo2.Visible := False;
            frmQckCtpTitContasSint.rlbSumarioGrupo2.Visible:= False;
            frmQckCtpTitContasSint.rllTotalGeral.Alignment := taRightJustify;
          End;

          If Pos(edtOrdem.Text, '3456') > 0 Then
          Begin
            frmQckCtpTitContasSint.rlbGrupo.Visible        := False;
            frmQckCtpTitContasSint.rlbGrupo2.Visible       := True;
            frmQckCtpTitContasSint.rllTotalGeral.Alignment := taRightJustify;
          End;

          If edtDestino.Text = 'V' Then
            frmQckCtpTitContasSint.qckPagina.PreviewModal
          Else If edtDestino.Text = 'I' Then
            frmQckCtpTitContasSint.qckPagina.Print
          Else If edtDestino.Text = 'E' Then
            pGeraExcelSin
          Else If edtDestino.Text = 'C' Then
            pGeraCSV;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;

        pFreeAndNil(frmQckCtpTitContasSint);

      End
      Else
      Begin
        pTabelaVazia;
      End;
    End;

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
  pnlInfo.Repaint;
end;

procedure TfrmRelCtpTitContas.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtRelatorio);
end;

procedure TfrmRelCtpTitContas.FormCreate(Sender: TObject);
begin
  inherited;

  blnExcel := True;

  shpMultSel.Visible := True;

end;

procedure TfrmRelCtpTitContas.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelCtpTitContas.edtCodEveExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEve, edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Centro de Custos');

end;

procedure TfrmRelCtpTitContas.edtCodEveKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EVENTOS    *}
  {****************************RV*}
  If fPesqEventos(Self, edtCodEve, edtDesEve, Nil, Key, arrEvento, False) Then
  Begin
    If fValidaCampos(edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpTitContas.edtCodFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFornecedor, edtDesFornecedor, arrFornec, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmRelCtpTitContas.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtDesFornecedor, Nil, Key, arrFornec, False) Then
  Begin
    fValidaCampos(edtCodFornecedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpTitContas.edtCodPorBaiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPorBai, edtDesPorBai, nil, Key, arrPorBai, False) Then
  Begin
    If (fValidaCampos(edtCodPorBai, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpTitContas.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If Not edtCodPor.ReadOnly Then
    pEdtCodSelectExit(edtCodPor, edtDesPortador, arrPortador, Nil, fRetNomPortador, 'do portador');
end;

procedure TfrmRelCtpTitContas.edtCodPorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPortador, nil, Key, arrPortador, False) Then
  Begin
    If fValidaCampos(edtCodPor,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpTitContas.edtDestinoExit(Sender: TObject);
begin
  //inherited;

end;

function TfrmRelCtpTitContas.fGeraCSV(cxProgress: TcxProgressBar): Boolean;
  Var
    svdCsv: TSaveDialog;
    strLinha,
    strNomArq: String;
    stlCsv: TStringList;

    procedure pStepStatusGravacao;
    Begin
      If Assigned(cxProgress) Then
      Begin
        cxProgress.Position := cxProgress.Position + 1;
        Application.ProcessMessages;
      End;
    End;

    procedure pInfoStatusGravacao(strInformacao: String);
    Begin
      If Assigned(cxProgress) And (GetParentForm(cxProgress).FindComponent('lblGravando') <> Nil) Then
      Begin
        TLabel(GetParentForm(cxProgress).FindComponent('lblGravando')).Caption := strInformacao;
        Application.ProcessMessages;
      End;
    End;
begin
  Result := True;

  pInfoStatusGravacao('Gerando arquivo CSV. Aguarde...');

  cxProgress.Position := 0;
  cxProgress.Properties.Max := qryRelatorio.RecordCount;

  svdCsv := TSaveDialog.Create(Nil);
  svdCsv.Filter := 'Arquivo CSV|*.csv';
  svdCsv.DefaultExt := 'csv';

  If svdCsv.Execute Then
  Begin
    strNomArq := svdCsv.FileName;

    If Not fEmptyStr(strNomArq) Then
    Begin
      stlCsv := TStringList.Create;

      stlCsv.Clear;

      With qryRelatorio Do
      Begin
        First;

        If SameText(edtRelatorio.Text, 'A') Then
        Begin
          strLinha := 'FAVORECIDO;CENTRO DE CUSTO;';

          If edtOrdem.Text = '3' Then
            strLinha := strLinha + 'CONTA DE RESULTADO;';

          If edtOrdem.Text = '4' Then
            strLinha := strLinha + 'EVENTO;';

          strLinha := strLinha + 'DUPLI;EMP;CHEQUE;BOL?;CADASTRO;VENCTO;PAGTO;VL DUP;VL PAG;HISTÓRICO;';
        End
        Else
        Begin
          strLinha := 'CONTA;';

          If edtOrdem.Text = '3' Then
            strLinha := strLinha + 'CONTA DE RESULTADO;';

          If edtOrdem.Text = '4' Then
            strLinha := strLinha + 'EVENTO;';

          strLinha := strLinha + 'VL ORI; VL PAG;';
        End;

        If edtValorExibido.Text = '1' Then
         strLinha := strLinha + 'VL JUR;VL DES';

        stlCsv.Add(strLinha);

        While Not Eof Do
        Begin
          If SameText(edtRelatorio.Text, 'A') Then
          Begin
            strLinha := FieldByName('CTP_CODFOR').AsString + '-' + AnsiReplaceStr(fRetNomFornecedor(FieldByName('CTP_CODFOR').AsString), ';', '') + ';' +
                        AnsiReplaceStr(FieldByName('DESCTA').AsString, ';', '') + ';';

            If edtOrdem.Text = '3' Then
              strLinha := strLinha + AnsiReplaceStr(FieldByName('CTA_TIPCTA').AsString, ';', '') + ';';

            If edtOrdem.Text = '4' Then
              strLinha := strLinha + AnsiReplaceStr(FieldByName('DESCRE').AsString, ';', '') + ';';

            strLinha := strLinha +
                        FieldByName('CTP_NUMDUP').AsString +
                        FieldByName('CTP_PARCEL').AsString +
                        IfThen(fEmptyStr(FieldByName('CTP_SERIE_').AsString), '', '-') +
                        FieldByName('CTP_SERIE_').AsString + ';' +
                        fFrtStrExcel(FieldByName('CTP_CODEMP').AsString) + ';' +
                        IfThen(SameText(FieldByName('CTP_USACHQ').AsString, 'S'), 'SIM', 'NÃO') + ';' +
                        IfThen(SameText(FieldByName('CTP_VEIOBO').AsString, 'S'), 'SIM', 'NÃO') + ';' +
                        FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTACAD').AsDateTime) + ';' +
                        FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTAVEN').AsDateTime) + ';' +
                        FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTAPAG').AsDateTime) + ';' +
                        FormatFloat('#,##0.00', FieldByName('CTP_VALORI').AsFloat) + ';' +
                        FormatFloat('#,##0.00', FieldByName('CTP_VALPAG').AsFloat) + ';' +
                        fFrtStrExcel(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(FieldByName('CTP_HIST01').AsString,'<<csq>>',' '), ';', ''), #$D#$A, ' '), #$D, ' ') + ' ' +
                                     AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(FieldByName('CTP_HIST02').AsString,'<<csq>>',' '), ';', ''), #$D#$A, ' '), #$D, ' '));

            If edtValorExibido.Text = '1' Then
            Begin
              strLinha := strLinha + ';' +
                          FormatFloat('#,##0.00', FieldByName('CTP_VALJUR').AsFloat) + ';' +
                          FormatFloat('#,##0.00', FieldByName('CTP_VALDES').AsFloat);
            End;
          End
          Else
          Begin
            strLinha := AnsiReplaceStr(FieldByName('DESCTA').AsString, ';', '') + ';';

            If edtOrdem.Text = '3' Then
              strLinha := strLinha + AnsiReplaceStr(FieldByName('CTA_TIPCTA').AsString, ';', '') + ';';

            If edtOrdem.Text = '4' Then
              strLinha := strLinha + AnsiReplaceStr(FieldByName('DESCRE').AsString, ';', '') + ';';

            strLinha := strLinha +
                        FormatFloat('#,##0.00', FieldByName('VALOR').AsFloat) + ';' +
                        FormatFloat('#,##0.00', FieldByName('VALPAG').AsFloat);

            If edtValorExibido.Text = '1' Then
            Begin
              strLinha := strLinha + ';' +
                          FormatFloat('#,##0.00', FieldByName('VALJUR').AsFloat) + ';' +
                          FormatFloat('#,##0.00', FieldByName('VALDES').AsFloat);
            End;
          End;

          stlCsv.Add(strLinha);
          pStepStatusGravacao;

          Next;
        End;
      End;

      stlCsv.SaveToFile(strNomArq);
      FreeAndNil(stlCsv);

      fMensagem('','Arquivo CSV gerado com sucesso!!', ['&O K']);
    End;
  End;

  FreeAndNil(svdCsv);
end;

procedure TfrmRelCtpTitContas.pCarregaEventos(Var qryCadEve: TUniQuery);
begin

  If Not (fEmptyStr(edtCodEve.Text)) Then
     edtDesEve.Text := qryCadEve.FieldByName('EVE_DESEVE').AsString
  Else
    edtDesEve.Text := '';

end;

procedure TfrmRelCtpTitContas.pGeraCSV;
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.lblGravando.Caption := 'Gerando Arquivo...';
      frmAguarde.fExecutarAcao := fGeraCSV;
      frmAguarde.ShowModal;
    Finally
      FreeAndNil(frmAguarde);
    End;
  Except
    On E : Exception Do
      pMensagensErro(E.Message, 'TGeraExcel.fGerarRelatorio');
  End;
End;

procedure TfrmRelCtpTitContas.pGeraExcelAna;
  Var
    strUltLet: String;
    strPeriodo: String;
    objGeraExcel: TGeraExcel;
begin

  objGeraExcel := TGeraExcel.Create(qryRelatorio, Nil);

  If edtValorExibido.Text = '1' Then
    strUltLet := 'L'
  Else
    strUltLet := 'J';

  If objGeraExcel <> Nil Then
  Begin

    With objGeraExcel Do
    Begin
      If edtContas.Text = 'A' Then
        strNomRel := 'RELATORIO DE TITULOS POR PLANO DE CONTAS (ANALITICO) - ABERTOS'
      Else If edtContas.Text = 'Q' Then
        strNomRel := 'RELATORIO DE TITULOS POR PLANO DE CONTAS (ANALITICO) - QUITADOS'
      Else If edtContas.Text = 'T' Then
        strNomRel := 'RELATORIO DE TITULOS POR PLANO DE CONTAS (ANALITICO) - ABERTOS E QUITADOS';

      If Not fEmptyStr(edtFimCta.Text) Then
        AddFiltro('FINAL DA CONTA: ' + edtFimCta.Text)
      Else
        AddFiltro('FINAL DA CONTA: TODOS');

      AddFiltro(strTitCon);
      AddFiltro(strTitEmp);
      AddFiltro(strTitEve);
      AddFiltro(strTitPorBai);

      If edtOrdem.Text = '1' Then
        AddFiltro('ORDERNADO POR: PLANO DE CONTAS - CODIGO')
      Else If edtOrdem.Text = '2' Then
        AddFiltro('ORDERNADO POR: PLANO DE CONTAS - DESCRICAO')
      Else If edtOrdem.Text = '3' Then
        AddFiltro('ORDERNADO POR: CONTA DE RESULTADO')
      Else If edtOrdem.Text = '4' Then
        AddFiltro('ORDERNADO POR: CENTRO DE CUSTOS')
      Else If edtOrdem.Text = '5' Then
        AddFiltro('ORDERNADO POR: DATA');

      If (edtIncPrevis.Text = 'S') Then
        AddFiltro('INCLUIDO PREVISAO: NAO')
      Else If (edtIncPrevis.Text = 'P') Then
        AddFiltro('APENAS PREVISAO')
      Else If (edtIncPrevis.Text = 'T') Then
        AddFiltro('INCLUIDO PREVISAO: SIM');

      strPeriodo := 'PERIODO - CADASTRO: ' + mskDtaIniC.Text + ' A ' + mskDtaFinC.Text ;

      If mskDtaIniV.Text <> '  /  /    ' Then
        strPeriodo := strPeriodo + ' - VENCIMENTO: ' + mskDtaIniV.Text + ' A ' + mskDtaFinV.Text;
      If mskDtaIniP.Text <> '  /  /    ' Then
        strPeriodo := strPeriodo + ' - PAGAMENTO: ' + mskDtaIniP.Text + ' A ' + mskDtaFinP.Text;

      AddFiltro(strPeriodo);

      AddCampo('DESCRE'    , 'FAVORECIDO');
      AddCampo('CTP_NUMDUP', 'DUPLI');
      AddCampo('CTP_CODEMP', 'EMP');
      AddCampo('CTP_USACHQ', 'CHEQUE');
      AddCampo('CTP_VEIOBO', 'BOL?');
      AddCampo('CTP_DTACAD', 'CADASTRO');
      AddCampo('CTP_DTAVEN', 'VENCTO');
      AddCampo('CTP_DTAPAG', 'PAGTO');
      AddCampo('CTP_VALORI', 'VL DUP');
      AddCampo('CTP_VALPAG', 'VL PAG');

      If edtValorExibido.Text = '1' Then
      Begin
        AddCampo('CTP_VALJUR', 'VL JUR');
        AddCampo('CTP_VALDES', 'VL DES');
      End;

      strUltimaLinha  := '-VAZIO-';
      strUltimoGrupo  := '-VAZIO-';
      strUltimoSubGru := '-VAZIO-';
      strGrpCCusto    := '-VAZIO-';
      strGrpCResult   := '-VAZIO-';
      strGrpTipCta    := '-VAZIO-';

      fltLinOri := 0;
      fltLinPag := 0;
      fltLinJur := 0;
      fltLinDes := 0;

      fltGruOri := 0;
      fltGruPag := 0;
      fltGruJur := 0;
      fltGruDes := 0;

      fltSubOri := 0;
      fltSubPag := 0;
      fltSubJur := 0;
      fltSubDes := 0;

      fltTotOri := 0;
      fltTotPag := 0;
      fltTotJur := 0;
      fltTotDes := 0;

      OnMontaResumo := pMontaResumoAna;
      OnImpDetalhes := pImpDetalhesAna;

      qryRelatorio.Last;
      intRecNo := qryRelatorio.RecNo;
      qryRelatorio.First;

      If objGeraExcel.fGerarRelatorio Then
        fMensagem('','Arquivo gerado com sucesso!', ['&OK']);

      FreeAndNil(objGeraExcel);

    End;
  End
  Else
    pMensagemOK('Aplicativo não encontrado [Oficce até 2007 ou BROffice]');

end;

procedure TfrmRelCtpTitContas.pGeraExcelSin;
  Var
    strUltLet    : String;
    strPeriodo   : String;
    objGeraExcel : TGeraExcel;
begin

  objGeraExcel := TGeraExcel.Create(qryRelatorio, Nil);

  strUltLet := 'E';

  If objGeraExcel <> Nil Then
  Begin

    With objGeraExcel Do
    Begin
      If edtContas.Text = 'A' Then
        strNomRel := 'RELATORIO DE TITULOS POR PLANO DE CONTAS (SINTETICO) - ABERTOS'
      Else If edtContas.Text = 'Q' Then
        strNomRel := 'RELATORIO DE TITULOS POR PLANO DE CONTAS (SINTETICO) - QUITADOS'
      Else If edtContas.Text = 'T' Then
        strNomRel := 'RELATORIO DE TITULOS POR PLANO DE CONTAS (SINTETICO) - ABERTOS E QUITADOS';

      If Not fEmptyStr(edtFimCta.Text) Then
        AddFiltro('FINAL DA CONTA: ' + edtFimCta.Text)
      Else
        AddFiltro('FINAL DA CONTA: TODOS');

      AddFiltro(strTitCon);
      AddFiltro(strTitEmp);
      AddFiltro(strTitEve);
      AddFiltro(strTitPorBai);

      If edtOrdem.Text = '1' Then
        AddFiltro('ORDERNADO POR: PLANO DE CONTAS - CODIGO')
      Else If edtOrdem.Text = '2' Then
        AddFiltro('ORDERNADO POR: PLANO DE CONTAS - DESCRICAO')
      Else If edtOrdem.Text = '3' Then
        AddFiltro('ORDERNADO POR: CONTA DE RESULTADO')
      Else If edtOrdem.Text = '4' Then
        AddFiltro('ORDERNADO POR: CENTRO DE CUSTOS')
      Else If edtOrdem.Text = '5' Then
        AddFiltro('ORDERNADO POR: DATA');

      If (edtIncPrevis.Text = 'S') Then
        AddFiltro('INCLUIDO PREVISAO: NAO')
      Else If (edtIncPrevis.Text = 'P') Then
        AddFiltro('APENAS PREVISAO')
      Else If (edtIncPrevis.Text = 'T') Then
        AddFiltro('INCLUIDO PREVISAO: SIM');

      strPeriodo := 'PERIODO - CADASTRO: ' + mskDtaIniC.Text + ' A ' + mskDtaFinC.Text ;

      If mskDtaIniV.Text <> '  /  /    ' Then
        strPeriodo := strPeriodo + ' - VENCIMENTO: ' + mskDtaIniV.Text + ' A ' + mskDtaFinV.Text;
      If mskDtaIniP.Text <> '  /  /    ' Then
        strPeriodo := strPeriodo + ' - PAGAMENTO: ' + mskDtaIniP.Text + ' A ' + mskDtaFinP.Text;

      AddFiltro(strPeriodo);

      If SameText(edtOrdem.Text, '2') Then
        AddCampo('DESCRE',     'CONTA')
      Else
        AddCampo('DESCRE',     'FAVORECIDO');

      AddCampo('VALOR', 'VL DUP');
      AddCampo('VALPAG', 'VL PAG');

      If edtValorExibido.Text = '1' Then
      Begin
        AddCampo('VALJUR', 'VL JUR');
        AddCampo('VALDES', 'VL DES');
      End;

      strUltimaLinha  := '-VAZIO-';
      strUltimoGrupo  := '-VAZIO-';
      strUltimoSubGru := '-VAZIO-';
      strGrpCCusto    := '-VAZIO-';
      strGrpCResult   := '-VAZIO-';
      strGrpTipCta    := '-VAZIO-';

      fltLinOri := 0;
      fltLinPag := 0;
      fltLinJur := 0;
      fltLinDes := 0;

      fltGruOri := 0;
      fltGruPag := 0;
      fltGruJur := 0;
      fltGruDes := 0;

      fltSubOri := 0;
      fltSubPag := 0;
      fltSubJur := 0;
      fltSubDes := 0;

      fltTotOri := 0;
      fltTotPag := 0;
      fltTotJur := 0;
      fltTotDes := 0;

      OnMontaResumo := pMontaResumoSin;
      OnImpDetalhes := pImpDetalhesSin;

      qryRelatorio.Last;
      intRecNo := qryRelatorio.RecNo;
      qryRelatorio.First;

      If objGeraExcel.fGerarRelatorio Then
        fMensagem('','Arquivo gerado com sucesso!', ['&OK']);

      FreeAndNil(objGeraExcel);

    End;
  End
  Else
    pMensagemOK('Aplicativo não encontrado [Oficce até 2007 ou BROffice]');
end;


procedure TfrmRelCtpTitContas.pGeraGrupos(Var strLinha: String; Var strGrupo: String; Var strSubGrupo: String; Var strGruCC: String; Var strGruCR: String; Var strTipCta: String; blnPlus: Boolean);
  Var
    strCodCta: String;
    intRecNo : Integer;
begin
  intRecNo := qryRelatorio.RecNo;

  If blnPlus = True Then
    qryRelatorio.RecNo := qryRelatorio.RecNo + 1;

  strCodCta := qryRelatorio.FieldByName('CTP_CODCTA').AsString;
  strGruCC  := qryRelatorio.FieldByName('DESCTA').AsString;
  strGruCR  := qryRelatorio.FieldByName('DESCRE').AsString;
  strTipCta := qryRelatorio.FieldByName('CTA_TIPCTA').AsString;

  If (strLinha = '') And (strGrupo = '') And (strSubGrupo = '') Then
  Begin
    Insert('.',strCodCta,3);
    Insert('.',strCodCta,6);
    strLinha                := LeftStr(strCodCta,2) + '.00.000';
    strGrupo                := LeftStr(strCodCta,5) + '.000';
    strSubGrupo             := strCodCta;
  End
  Else
  Begin

    If LeftStr(strCodCta,2) <> LeftStr(strLinha,2) Then
    Begin
      Insert('.',strCodCta,3);
      Insert('.',strCodCta,6);
      strLinha                := LeftStr(strCodCta,2) + '.00.000';
      strGrupo                := LeftStr(strCodCta,5) + '.000';
      strSubGrupo             := strCodCta;
    End
    Else
    If LeftStr(strCodCta,4) <> LeftStr(AnsiReplaceStr(strGrupo,'.',''),4) Then
    Begin
      Insert('.',strCodCta,3);
      Insert('.',strCodCta,6);
      strLinha                := LeftStr(strCodCta,2) + '.00.000';
      strGrupo                := LeftStr(strCodCta,5) + '.000';
      strSubGrupo             := strCodCta;
    End
    Else
    If strCodCta <> AnsiReplaceStr(strSubGrupo,'.','') Then
    Begin
      Insert('.',strCodCta,3);
      Insert('.',strCodCta,6);
      strLinha                := LeftStr(strCodCta,2) + '.00.000';
      strGrupo                := LeftStr(strCodCta,5) + '.000';
      strSubGrupo             := strCodCta;
    End;

  End;

  If blnPlus = True Then
    qryRelatorio.RecNo := intRecNo;

end;

procedure TfrmRelCtpTitContas.pImpDetalhesAna(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; CorFundo: TCorExcel);
  Var
    strLinha    : String;
    strGrupo    : String;
    strSubGru   : String;
    strGruCC    : String;
    strGruCR    : String;
    strTipCta   : String;
    strUltLet   : String;
begin

  If edtValorExibido.Text = '1' Then
    strUltLet := 'L'
  Else
    strUltLet := 'J';

  With Excel Do
  Begin
    pGeraGrupos(strLinha, strGrupo, strSubGru, strGruCC, strGruCR, strTipCta);

    If SameText(edtOrdem.Text, '1') Then
    Begin

      If Not SameText(strUltimaLinha, strLinha) Then
      Begin
        strUltimaLinha := strLinha;
        Mesclar('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'LINHA: ' + strLinha + ' - ' + fRetNomeConta(AnsiReplaceStr(strLinha,'.','')));

        ProximaLinha;
        ProximaLinha;
      End;

      If Not SameText(strUltimoGrupo, strGrupo) Then
      Begin
        strUltimoGrupo := strGrupo;
        Mesclar('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, fFrtStrExcel('GRUPO: ' + strGrupo + ' - ' + fRetNomeConta(AnsiReplaceStr(strGrupo,'.',''))));

        ProximaLinha;
        ProximaLinha;
      End;

      If Not SameText(strUltimoSubGru, strSubGru) Then
      Begin
        strUltimoSubGru := strSubGru;
        Mesclar('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, (strSubGru + ' - ' + fRetNomeConta(AnsiReplaceStr(strSubGru,'.',''))));

        ProximaLinha;
        ProximaLinha;
      End;

    End
    Else If SameText(edtOrdem.Text, '2') Then
    Begin
      If Not SameText(strGrpCCusto, Dados.FieldByName('DESCTA').AsString) Then
      Begin
        strGrpCCusto := Dados.FieldByName('DESCTA').AsString;

        Mesclar('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, fFrtStrExcel('PLANO DE CONTAS: ' + Dados.FieldByName('DESCTA').AsString));

        ProximaLinha;
        ProximaLinha;
      End;
    End
    Else If Pos(edtOrdem.Text, '3456') > 0 Then
    Begin

      If Not SameText(strGrpCResult, Dados.FieldByName('DESCRE').AsString) Then
      Begin
        strGrpCResult := Dados.FieldByName('DESCRE').AsString;

        Mesclar('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);

        If SameText(edtOrdem.Text, '3') Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, fFrtStrExcel('CONTA DE RESULTADO: ' + Dados.FieldByName('DESCRE').AsString))
        Else If SameText(edtOrdem.Text, '5') Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, fFrtStrExcel('DATA: ' + Dados.FieldByName('DESCRE').AsString))
        Else If SameText(edtOrdem.Text, '6') Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, fFrtStrExcel('FORNECEDOR: ' + Dados.FieldByName('DESCRE').AsString))
        Else
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, fFrtStrExcel('CENTRO DE CUSTOS: ' + Dados.FieldByName('DESCRE').AsString));

        ProximaLinha;
        ProximaLinha;
      End;

      If Not SameText(strGrpCCusto, Dados.FieldByName('DESCTA').AsString) Then
      Begin
        strGrpCCusto := Dados.FieldByName('DESCTA').AsString;
        strGrpTipCta := Dados.FieldByName('CTA_TIPCTA').AsString;

        Mesclar('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));

        If edtOrdem.Text = '3' Then
        Begin
          Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, '  TIPO DE CONTA: ' + Dados.FieldByName('CTA_TIPCTA').AsString);
          ProximaLinha;
        End;

        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, '  PLANO DE CONTAS: ' + Dados.FieldByName('DESCTA').AsString);

        ProximaLinha;
        ProximaLinha;
      End;
    End;

    Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Esquerda);

    If Pos(edtOrdem.Text, '123456') > 0 Then
      Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, fFrtStrExcel(ifthen(SameText(edtForHis.Text, 'F'),
                                                                  Dados.FieldByName('CTP_CODFOR').AsString + ' - ' +
                                                                  Dados.FieldByName('FOR_NOMFOR').AsString,
                                                                  Dados.FieldByName('CTP_HIST01').AsString)))
    Else
      Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, '');

    Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_NUMDUP'].Coluna, fFrtStrExcel(Dados.FieldByName('CTP_NUMDUP').AsString +
                                                                    Dados.FieldByName('CTP_PARCEL').AsString));

    Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_CODEMP'].Coluna, fFrtStrExcel(Dados.FieldByName('CTP_CODEMP').AsString));

    Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_USACHQ'].Coluna, fFrtStrExcel(ifthen(Dados.FieldByName('CTP_USACHQ').AsString = 'S', 'SIM', 'NAO')));

    Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VEIOBO'].Coluna, fFrtStrExcel(ifthen(Dados.FieldByName('CTP_VEIOBO').AsString = 'S', 'SIM', 'NAO')));

    Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_DTACAD'].Coluna, fFrtStrExcel(Dados.FieldByName('CTP_DTACAD').AsString));

    Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_DTAVEN'].Coluna, fFrtStrExcel(Dados.FieldByName('CTP_DTAVEN').AsString));

    Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_DTAPAG'].Coluna, ifthen(Dados.FieldByName('CTP_DTAPAG').IsNull, '', fFrtStrExcel(Dados.FieldByName('CTP_DTAPAG').AsString)));

    Alinhamento('I' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

    If Dados.FieldByName('CTP_DTAPAG').IsNull Then
    Begin
      If edtValorExibido.Text = '1' Then
      Begin
        fltSubOri := fltSubOri + (Dados.FieldByName('CTP_VALDUP').AsCurrency -
                                  Dados.FieldByName('CTP_DESSUJ').AsCurrency +
                                  Dados.FieldByName('CTP_JURSUJ').AsCurrency +
                                  Dados.FieldByName('CTP_VENDOR').AsCurrency);

        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALORI'].Coluna, FloatToStrF((Dados.FieldByName('CTP_VALDUP').AsCurrency -
                                                                         Dados.FieldByName('CTP_DESSUJ').AsCurrency +
                                                                         Dados.FieldByName('CTP_JURSUJ').AsCurrency +
                                                                         Dados.FieldByName('CTP_VENDOR').AsCurrency), ffNumber, 15, 2));
      End
      Else
      Begin
        fltSubOri := fltSubOri + (Dados.FieldByName('CTP_VALDUP').AsCurrency +
                                  Dados.FieldByName('CTP_VENDOR').AsCurrency);

        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALORI'].Coluna, FloatToStrF((Dados.FieldByName('CTP_VALDUP').AsCurrency +
                                                                        Dados.FieldByName('CTP_VENDOR').AsCurrency), ffNumber, 15, 2));
      End;
    End
    Else
    Begin
      If edtValorExibido.Text = '1' Then
      Begin
        fltSubOri := fltSubOri + (Dados.FieldByName('CTP_VALORI').AsCurrency -
                                  Dados.FieldByName('CTP_VALDES').AsCurrency +
                                  Dados.FieldByName('CTP_VALJUR').AsCurrency +
                                  Dados.FieldByName('CTP_VENDOR').AsCurrency);

        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALORI'].Coluna, FloatToStrF(Dados.FieldByName('CTP_VALORI').AsFloat -
                                                                        Dados.FieldByName('CTP_VALDES').AsFloat +
                                                                        Dados.FieldByName('CTP_VALJUR').AsFloat +
                                                                        Dados.FieldByName('CTP_VENDOR').AsCurrency, ffNumber, 15, 2));
      End
      Else
      Begin
        fltSubOri := fltSubOri + (Dados.FieldByName('CTP_VALORI').AsCurrency +
                                  Dados.FieldByName('CTP_VENDOR').AsCurrency);

        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALORI'].Coluna, FloatToStrF(Dados.FieldByName('CTP_VALORI').AsFloat +
                                                                        Dados.FieldByName('CTP_VENDOR').AsCurrency, ffNumber, 15, 2));
      End;
    End;

    If Dados.FieldByName('CTP_VALPAG').AsFloat <> 0 Then
    Begin
      fltSubPag := fltSubPag + Dados.FieldByName('CTP_VALPAG').AsFloat;
      Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALPAG'].Coluna, FloatToStrF(Dados.FieldByName('CTP_VALPAG').AsFloat, ffNumber, 15, 2));
    End
    Else Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALPAG'].Coluna, '0,00');

    If edtValorExibido.Text = '1' Then
    Begin

      If Dados.FieldByName('CTP_VALJUR').AsFloat <> 0 Then
      Begin
        fltSubJur := fltSubJur + (Dados.FieldByName('CTP_VALJUR').AsFloat);
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALJUR'].Coluna, FloatToStrF(Dados.FieldByName('CTP_VALJUR').AsFloat, ffNumber, 15, 2));
      End
      Else
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALJUR'].Coluna, '0,00');

      If Dados.FieldByName('CTP_VALDES').AsFloat <> 0 Then
      Begin
        fltSubDes := fltSubDes + (Dados.FieldByName('CTP_VALDES').AsFloat);
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALDES'].Coluna, FloatToStrF(Dados.FieldByName('CTP_VALDES').AsFloat, ffNumber, 15, 2));
      End
      Else
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALDES'].Coluna, '0,00');

    End;

    //  totais de grupos e linhas;

    pGeraGrupos(strLinha, strGrupo, strSubGru, strGruCC, strGruCR, strTipCta, True);

    If SameText(edtOrdem.Text, '1') Then
    Begin

      If (Not SameText(strUltimoSubGru, strSubGru)) Or (Dados.RecNo = intRecNo) Then
      Begin
        ProximaLinha;
        Mesclar('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'Total Parcial: ');
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALORI'].Coluna, FloatToStrF(fltSubOri, ffNumber, 15, 2));
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALPAG'].Coluna, FloatToStrF(fltSubPag, ffNumber, 15, 2));

        If edtValorExibido.Text = '1' Then
        Begin
          Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALJUR'].Coluna, FloatToStrF(fltSubJur, ffFixed, 12, 2));
          Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALDES'].Coluna, FloatToStrF(fltSubDes, ffFixed, 12, 2));
        End;
        Alinhamento('I' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

        fltGruOri := fltGruOri + fltSubOri;
        fltGruPag := fltGruPag + fltSubPag;
        fltGruJur := fltGruJur + fltSubJur;
        fltGruDes := fltGruDes + fltSubDes;

        fltSubOri := 0;
        fltSubPag := 0;
        fltSubJur := 0;
        fltSubDes := 0;

      End;

      If Not SameText(strUltimoGrupo, strGrupo)  Or (Dados.RecNo = intRecNo) Then
      Begin
        ProximaLinha;
        Mesclar('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'Total Grupo: ');
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALORI'].Coluna, FloatToStrF(fltGruOri, ffNumber, 15, 2));
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALPAG'].Coluna, FloatToStrF(fltGruPag, ffNumber, 15, 2));

        If edtValorExibido.Text = '1' Then
        Begin
          Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALJUR'].Coluna, FloatToStrF(fltGruJur, ffFixed, 12, 2));
          Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALDES'].Coluna, FloatToStrF(fltGruDes, ffFixed, 12, 2));
        End;
        Alinhamento('I' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

        fltLinOri := fltLinOri + fltGruOri;
        fltLinPag := fltLinPag + fltGruPag;
        fltLinJur := fltLinJur + fltGruJur;
        fltLinDes := fltLinDes + fltGruDes;

        fltGruOri := 0;
        fltGruPag := 0;
        fltGruJur := 0;
        fltGruDes := 0;
      End;

      If Not SameText(strUltimaLinha, strLinha)  Or (Dados.RecNo = intRecNo) Then
      Begin
        ProximaLinha;
        Mesclar('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'Total Linha: ');
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALORI'].Coluna, FloatToStrF(fltLinOri, ffNumber, 15, 2));
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALPAG'].Coluna, FloatToStrF(fltLinPag, ffNumber, 15, 2));

        If edtValorExibido.Text = '1' Then
        Begin
          Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALJUR'].Coluna, FloatToStrF(fltLinJur, ffFixed, 12, 2));
          Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALDES'].Coluna, FloatToStrF(fltLinDes, ffFixed, 12, 2));
        End;
        Alinhamento('I' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

        fltTotOri := fltTotOri + fltLinOri;
        fltTotPag := fltTotPag + fltLinPag;
        fltTotJur := fltTotJur + fltLinJur;
        fltTotDes := fltTotDes + fltLinDes;

        fltLinOri := 0;
        fltLinPag := 0;
        fltLinJur := 0;
        fltLinDes := 0;
      End;

    End
    Else If SameText(edtOrdem.Text, '2') Then
    Begin

      If Not SameText(strGrpCCusto, strGruCC) Or (Dados.RecNo = intRecNo) Then
      Begin
        ProximaLinha;
        Mesclar('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'Total Plano de Contas: ');
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALORI'].Coluna, FloatToStrF(fltSubOri, ffNumber, 15, 2));
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALPAG'].Coluna, FloatToStrF(fltSubPag, ffNumber, 15, 2));

        If edtValorExibido.Text = '1' Then
        Begin
          Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALJUR'].Coluna, FloatToStrF(fltSubJur, ffFixed, 12, 2));
          Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALDES'].Coluna, FloatToStrF(fltSubDes, ffFixed, 12, 2));
        End;
        Alinhamento('I' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

        fltTotOri := fltTotOri + fltSubOri;
        fltTotPag := fltTotPag + fltSubPag;
        fltTotJur := fltTotJur + fltSubJur;
        fltTotDes := fltTotDes + fltSubDes;

        fltSubOri := 0;
        fltSubPag := 0;
        fltSubJur := 0;
        fltSubDes := 0;
      End;

    End
    Else If Pos(edtOrdem.Text, '3456') > 0 Then
    Begin

      If Not SameText(strGrpCCusto, strGruCC) Or (Dados.RecNo = intRecNo) Then
      Begin
        ProximaLinha;
        Mesclar('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'Total Plano de Contas: ');
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALORI'].Coluna, FloatToStrF(fltSubOri, ffNumber, 15, 2));
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALPAG'].Coluna, FloatToStrF(fltSubPag, ffNumber, 15, 2));

        If edtValorExibido.Text = '1' Then
        Begin
          Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALJUR'].Coluna, FloatToStrF(fltSubJur, ffFixed, 12, 2));
          Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALDES'].Coluna, FloatToStrF(fltSubDes, ffFixed, 12, 2));
        End;
        Alinhamento('I' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

        fltGruOri := fltGruOri + fltSubOri;
        fltGruPag := fltGruPag + fltSubPag;
        fltGruJur := fltGruJur + fltSubJur;
        fltGruDes := fltGruDes + fltSubDes;

        fltSubOri := 0;
        fltSubPag := 0;
        fltSubJur := 0;
        fltSubDes := 0;
      End;

      If Not SameText(strGrpCResult, strGruCR) Or (Dados.RecNo = intRecNo) Then
      Begin
        ProximaLinha;
        Mesclar('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);

        If edtOrdem.Text = '3' Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'Total Conta Resultado: ')
        Else If edtOrdem.Text = '4' Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'Total Evento: ')
        Else If edtOrdem.Text = '5' Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'Total Data Vencimento: ')
        Else If edtOrdem.Text = '6' Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'Total do Fornecedor: ');

        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALORI'].Coluna, FloatToStrF(fltGruOri, ffNumber, 15, 2));
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALPAG'].Coluna, FloatToStrF(fltGruPag, ffNumber, 15, 2));

        If edtValorExibido.Text = '1' Then
        Begin
          Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALJUR'].Coluna, FloatToStrF(fltGruJur, ffFixed, 12, 2));
          Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALDES'].Coluna, FloatToStrF(fltGruDes, ffFixed, 12, 2));
        End;
        Alinhamento('I' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

        fltTotOri := fltTotOri + fltGruOri;
        fltTotPag := fltTotPag + fltGruPag;
        fltTotJur := fltTotJur + fltGruJur;
        fltTotDes := fltTotDes + fltGruDes; 

        fltGruOri := 0;
        fltGruPag := 0;
        fltGruJur := 0;
        fltGruDes := 0;
      End;
    End;

  End;
end;

procedure TfrmRelCtpTitContas.pImpDetalhesSin(Excel: TExcel; Dados: TDataSet; 
  Campos: TCampos; CorFundo: TCorExcel);
  Var
    strLinha    : String; 
    strGrupo    : String;
    strSubGru   : String;
    strGruCC    : String;
    strGruCR    : String;
    strTipCta   : String;
    strUltLet   : String;  
begin

  If edtValorExibido.Text = '1' Then
    strUltLet := 'E'
  Else
    strUltLet := 'C';

  With Excel Do
  Begin
    pGeraGrupos(strLinha, strGrupo, strSubGru, strGruCC, strGruCR, strTipCta);

    If SameText(edtOrdem.Text, '1') Then
    Begin

      If Not SameText(strUltimaLinha, strLinha) Then
      Begin
        strUltimaLinha := strLinha;
        Mesclar('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'LINHA: ' + strLinha + ' - ' + fRetNomeConta(AnsiReplaceStr(strLinha,'.','')));

        ProximaLinha;
        ProximaLinha;
      End;

      If Not SameText(strUltimoGrupo, strGrupo) Then
      Begin
        strUltimoGrupo := strGrupo;
        Mesclar('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, fFrtStrExcel('GRUPO: ' + strGrupo + ' - ' + fRetNomeConta(AnsiReplaceStr(strGrupo,'.',''))));

        ProximaLinha;
        ProximaLinha;
      End;

    End
    Else If Pos(edtOrdem.Text, '3456') > 0 Then
    Begin

      If Not SameText(strGrpCResult, Dados.FieldByName('DESCRE').AsString) Then
      Begin
        strGrpCResult := Dados.FieldByName('DESCRE').AsString;

        Mesclar('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);

        If SameText(edtOrdem.Text, '3') Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, fFrtStrExcel('CONTA DE RESULTADO: ' + Dados.FieldByName('DESCRE').AsString))
        Else If SameText(edtOrdem.Text, '5') Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, fFrtStrExcel('DATA: ' + Dados.FieldByName('DESCRE').AsString))
        Else If SameText(edtOrdem.Text, '6') Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, fFrtStrExcel('FORNECEDOR: ' + Dados.FieldByName('DESCRE').AsString))
        Else
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, fFrtStrExcel('CENTRO DE CUSTOS: ' + Dados.FieldByName('DESCRE').AsString));

        ProximaLinha;

        If edtOrdem.Text = '3' Then
        Begin
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, '  TIPO DE CONTA: ' + Dados.FieldByName('CTA_TIPCTA').AsString);
          ProximaLinha;
        End;

        ProximaLinha;
      End;
      
    End;

    Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Esquerda);

    If Pos(edtOrdem.Text, '23456') > 0 Then
      Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, Dados.FieldByName('DESCTA').AsString)
    Else
      Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, '  ' + (strSubGru + ' - ' + fRetNomeConta(AnsiReplaceStr(strSubGru,'.',''))));

    If Dados.FieldByName('VALOR').AsFloat <> 0 Then
    Begin
      fltSubOri := fltSubOri + (Dados.FieldByName('VALOR').AsFloat);

      Escrever(LinhaAtual, Campos.ColunaPorNome['VALOR'].Coluna, FloatToStrF(Dados.FieldByName('VALOR').AsCurrency, ffNumber, 15, 2));
    End
    Else
      Escrever(LinhaAtual, Campos.ColunaPorNome['VALOR'].Coluna, '0,00');

    If Dados.FieldByName('VALPAG').AsFloat <> 0 Then
    Begin
      fltSubPag := fltSubPag + (Dados.FieldByName('VALPAG').AsFloat);
      Escrever(LinhaAtual, Campos.ColunaPorNome['VALPAG'].Coluna, FloatToStrF(Dados.FieldByName('VALPAG').AsFloat, ffNumber, 15, 2));
    End
    Else
      Escrever(LinhaAtual, Campos.ColunaPorNome['VALPAG'].Coluna, '0,00');

    If edtValorExibido.Text = '1' Then
    Begin

      If Dados.FieldByName('VALJUR').AsFloat <> 0 Then
      Begin
        fltSubJur := fltSubJur + (Dados.FieldByName('VALJUR').AsFloat);
        Escrever(LinhaAtual, Campos.ColunaPorNome['VALJUR'].Coluna, FloatToStrF(Dados.FieldByName('VALJUR').AsFloat, ffNumber, 15, 2));
      End
      Else
        Escrever(LinhaAtual, Campos.ColunaPorNome['VALJUR'].Coluna, '0,00');

      If Dados.FieldByName('VALDES').AsFloat <> 0 Then
      Begin
        fltSubDes := fltSubDes + (Dados.FieldByName('VALDES').AsFloat);
        Escrever(LinhaAtual, Campos.ColunaPorNome['VALDES'].Coluna, FloatToStrF(Dados.FieldByName('VALDES').AsFloat, ffNumber, 15, 2));
      End
      Else
        Escrever(LinhaAtual, Campos.ColunaPorNome['VALDES'].Coluna, '0,00');

    End;

    Alinhamento('B' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

    //  totais de grupos e linhas;

    pGeraGrupos(strLinha, strGrupo, strSubGru, strGruCC, strGruCR, strTipCta, True);

    If SameText(edtOrdem.Text, '1') Then
    Begin

      If Not SameText(strUltimoGrupo, strGrupo)  Or (Dados.RecNo = intRecNo) Then
      Begin
        ProximaLinha;
        Mesclar('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'Total Grupo: ');
        Escrever(LinhaAtual, Campos.ColunaPorNome['VALOR'].Coluna, FloatToStrF(fltSubOri, ffNumber, 15, 2));
        Escrever(LinhaAtual, Campos.ColunaPorNome['VALPAG'].Coluna, FloatToStrF(fltSubPag, ffNumber, 15, 2));

        If edtValorExibido.Text = '1' Then
        Begin
          Escrever(LinhaAtual, Campos.ColunaPorNome['VALJUR'].Coluna, FloatToStrF(fltSubJur, ffFixed, 12, 2));
          Escrever(LinhaAtual, Campos.ColunaPorNome['VALDES'].Coluna, FloatToStrF(fltSubDes, ffFixed, 12, 2));
        End;
        Alinhamento('B' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

        fltLinOri := fltLinOri + fltSubOri;
        fltLinPag := fltLinPag + fltSubPag;
        fltLinJur := fltLinJur + fltSubJur;
        fltLinDes := fltLinDes + fltSubDes;

        fltSubOri := 0;
        fltSubPag := 0;
        fltSubJur := 0;
        fltSubDes := 0;
      End;

      If Not SameText(strUltimaLinha, strLinha)  Or (Dados.RecNo = intRecNo) Then
      Begin
        ProximaLinha;
        Mesclar('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'Total Linha: ');
        Escrever(LinhaAtual, Campos.ColunaPorNome['VALOR'].Coluna, FloatToStrF(fltLinOri, ffNumber, 15, 2));
        Escrever(LinhaAtual, Campos.ColunaPorNome['VALPAG'].Coluna, FloatToStrF(fltLinPag, ffNumber, 15, 2));

        If edtValorExibido.Text = '1' Then
        Begin
          Escrever(LinhaAtual, Campos.ColunaPorNome['VALJUR'].Coluna, FloatToStrF(fltLinJur, ffFixed, 12, 2));
          Escrever(LinhaAtual, Campos.ColunaPorNome['VALDES'].Coluna, FloatToStrF(fltLinDes, ffFixed, 12, 2));
        End;
        Alinhamento('B' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

        fltTotOri := fltTotOri + fltLinOri;
        fltTotPag := fltTotPag + fltLinPag;
        fltTotJur := fltTotJur + fltLinJur;
        fltTotDes := fltTotDes + fltLinDes;

        fltLinOri := 0;
        fltLinPag := 0;
        fltLinJur := 0;
        fltLinDes := 0;
      End;

    End
    Else If SameText(edtOrdem.Text, '2') Then
    Begin

      If Not SameText(strGrpCCusto, strGruCC) Or (Dados.RecNo = intRecNo) Then
      Begin
        fltTotOri := fltTotOri + fltSubOri;
        fltTotPag := fltTotPag + fltSubPag;
        fltTotJur := fltTotJur + fltSubJur;
        fltTotDes := fltTotDes + fltSubDes;

        fltSubOri := 0;
        fltSubPag := 0;
        fltSubJur := 0;
        fltSubDes := 0;
      End;

    End
    Else If Pos(edtOrdem.Text, '3456') > 0 Then
    Begin
      If Not SameText(strGrpCResult, strGruCR) Or (Dados.RecNo = intRecNo) Then
      Begin
        ProximaLinha;
        Mesclar('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual) );
        Bordas('A'  + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
        Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);

        If edtOrdem.Text = '3' Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'Total Conta Resultado: ')
        Else If edtOrdem.Text = '4' Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'Total Evento: ')
        Else If edtOrdem.Text = '5' Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'Total Data Vencimento: ')
        Else If edtOrdem.Text = '6' Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'Total do Fornecedor: ');

        Escrever(LinhaAtual, Campos.ColunaPorNome['VALOR'].Coluna, FloatToStrF(fltSubOri, ffNumber, 15, 2));
        Escrever(LinhaAtual, Campos.ColunaPorNome['VALPAG'].Coluna, FloatToStrF(fltSubPag, ffNumber, 15, 2));

        If edtValorExibido.Text = '1' Then
        Begin
          Escrever(LinhaAtual, Campos.ColunaPorNome['VALJUR'].Coluna, FloatToStrF(fltSubJur, ffFixed, 12, 2));
          Escrever(LinhaAtual, Campos.ColunaPorNome['VALDES'].Coluna, FloatToStrF(fltSubDes, ffFixed, 12, 2));
        End;
        Alinhamento('B' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

        fltTotOri := fltTotOri + fltSubOri;
        fltTotPag := fltTotPag + fltSubPag;
        fltTotJur := fltTotJur + fltSubJur;
        fltTotDes := fltTotDes + fltSubDes;

        fltSubOri := 0;
        fltSubPag := 0;
        fltSubJur := 0;
        fltSubDes := 0;
      End;
    End;
  End;
end;

procedure TfrmRelCtpTitContas.pMontaResumoAna(Excel: TExcel; Campos: TCampos;
  Quebra: TRecQuebras);
begin
  With Excel Do
  Begin
    If (Quebra.NomeCampo = '[GERAL]') Then
    Begin
      ProximaLinha;
      Mesclar ('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual) );
      Bordas('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
      Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'TOTAL GERAL: ');
      
      Negrito(LinhaAtual,  Campos.ColunaPorNome['CTP_VALORI'].Coluna, True);   
      Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALORI'].Coluna, FloatToStrF(fltTotOri, ffFixed, 12, 2));
      Alinhamento(LinhaAtual, Campos.ColunaPorNome['CTP_VALORI'].Coluna, Direita);

      Negrito(LinhaAtual,  Campos.ColunaPorNome['CTP_VALPAG'].Coluna, True);
      Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALPAG'].Coluna, FloatToStrF(fltTotPag, ffFixed, 12, 2));
      Alinhamento(LinhaAtual, Campos.ColunaPorNome['CTP_VALPAG'].Coluna, Direita);

      If edtValorExibido.Text = '1' Then
      Begin
        Negrito(LinhaAtual,  Campos.ColunaPorNome['CTP_VALJUR'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALJUR'].Coluna, FloatToStrF(fltTotJur, ffFixed, 12, 2));
        Alinhamento(LinhaAtual, Campos.ColunaPorNome['CTP_VALJUR'].Coluna, Direita);

        Negrito(LinhaAtual,  Campos.ColunaPorNome['CTP_VALDES'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALDES'].Coluna, FloatToStrF(fltTotDes, ffFixed, 12, 2));
        Alinhamento(LinhaAtual, Campos.ColunaPorNome['CTP_VALDES'].Coluna, Direita);        
      End;      
    End;
  End;
end;

procedure TfrmRelCtpTitContas.pMontaResumoSin(Excel: TExcel; Campos: TCampos;
  Quebra: TRecQuebras);
begin
  With Excel Do
  Begin
    If (Quebra.NomeCampo = '[GERAL]') Then
    Begin
      ProximaLinha;
      Mesclar ('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual) );
      Bordas('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Negrito(LinhaAtual,  Campos.ColunaPorNome['DESCRE'].Coluna, True);
      Escrever(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, 'TOTAL GERAL: ');
      Alinhamento(LinhaAtual, Campos.ColunaPorNome['DESCRE'].Coluna, Esquerda);

      Negrito(LinhaAtual,  Campos.ColunaPorNome['VALOR'].Coluna, True);
      Escrever(LinhaAtual, Campos.ColunaPorNome['VALOR'].Coluna, FloatToStrF(fltTotOri, ffFixed, 12, 2));
      Alinhamento(LinhaAtual, Campos.ColunaPorNome['VALOR'].Coluna, Direita);

      Negrito(LinhaAtual,  Campos.ColunaPorNome['VALPAG'].Coluna, True);
      Escrever(LinhaAtual, Campos.ColunaPorNome['VALPAG'].Coluna, FloatToStrF(fltTotPag, ffFixed, 12, 2));
      Alinhamento(LinhaAtual, Campos.ColunaPorNome['VALPAG'].Coluna, Direita);

      If edtValorExibido.Text = '1' Then
      Begin
        Negrito(LinhaAtual,  Campos.ColunaPorNome['VALJUR'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['VALJUR'].Coluna, FloatToStrF(fltTotJur, ffFixed, 12, 2));
        Alinhamento(LinhaAtual, Campos.ColunaPorNome['VALJUR'].Coluna, Direita);

        Negrito(LinhaAtual,  Campos.ColunaPorNome['VALDES'].Coluna, True);
        Escrever(LinhaAtual, Campos.ColunaPorNome['VALDES'].Coluna, FloatToStrF(fltTotDes, ffFixed, 12, 2));
        Alinhamento(LinhaAtual, Campos.ColunaPorNome['VALDES'].Coluna, Direita);        
      End;      
    End;
  End;
end;

procedure TfrmRelCtpTitContas.pFiltroCentroCusto(Var strSql: String);
  Var
    intCont: Integer;
    strLeft: String;

    {******************************************************************************}
    {* VERIFICA SE VAI COMPARAR AS CONTAS DENTRO DA LINHA E GRUPO.                *}
    {* EX: A CONTA 01.01.012 ESTA CONTIDA NA LINHA 01.00.000 E NO GRUPO 01.01.000 *}
    {***************************************************************************JC*}
    procedure pSetaLeft(strCodCta: String);
    begin
      strLeft := '7'; //COMPARA TODA A CONTA
      If RightStr(strCodCta, 3) = '000'   Then strLeft := '4'; //COMPARA SOMENTE O GRUPO
      If RightStr(strCodCta, 5) = '00000' Then strLeft := '2'; //COMPARA SOMENTE A LINHA
    end;

    {*****************************************************************************}
    {* MONTA A STRING DO FILTRO USANDO AS COMPARACOES IGUAL, MAIOR, MENOR ETC... *}
    {**************************************************************************JC*}
    function fstrLeft(strCodCta, strComp: String): String;
    begin
      Result := '(LEFT(IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA),' + strLeft +
                ') ' + strComp + ' "' + LeftStr(strCodCta, StrToInt(strLeft)) + '")';
    end;

begin

  {*******************************************}
  {* CASO TENHA SELECIONADO VARIAS CONTAS EN-*}
  {* TAO MONTA FILTRO USANDO A CONDICAO "OR" *}
  {* EX: CONTA IGUAL XX OU CONTA IGUAL A YY  *}
  {****************************************JC*}
  If Length(arrContaIni) > 1 Then
  Begin
    strSql := strSql + ' AND ( ';

    For intCont := 0 To Length(arrContaIni) -1 Do
    Begin
      pSetaLeft(arrContaIni[intCont].strCodigo);
      strSql := strSql + fstrLeft(arrContaIni[intCont].strCodigo, '=') + ifthen(intCont < (Length(arrContaIni) -1), ' OR ', '');
    End;

    strSql := strSql + ' )';
  End

  Else If (Not fEmptyStr(fTiraCaracEspeciais(mskContaIni.Text))) Then
  Begin
    {*************************************************************}
    {* CONTA(LEFT) DEVE SER MAIOR OU IGUAL A CONTA INICIAL(LEFT) *}
    {**********************************************************JC*}
    pSetaLeft(fTiraCaracEspeciais(mskContaIni.Text));
    strSql := strSql + ' AND ' + fstrLeft(fTiraCaracEspeciais(mskContaIni.Text), '>=');

    If (Not fEmptyStr(fTiraCaracEspeciais(mskContaFin.Text))) Then
    Begin
      {*************************************************************}
      {* CONTA(LEFT) DEVE SER MENOR OU IGUAL A CONTA FINAL(LEFT)   *}
      {**********************************************************JC*}
      pSetaLeft(fTiraCaracEspeciais(mskContaFin.Text));
      strSql := strSql + ' AND ' + fstrLeft(fTiraCaracEspeciais(mskContaFin.Text), '<=');
    End;
  End;

end;

end.


