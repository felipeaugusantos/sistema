unit untRelComissaoProfissionais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, strUtils,
  RLFilters, RLDraftFilter, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, Buttons, Mask, MaskEditFocus, untComissaoProfissional, Uni,
  AppEvnts, untFuncoesSimples, BitBtnLockedIncrem, ComCtrls, untTypesSistema,
  frxExportCSVTestabilidade;

type
  TfrmRelComissaoProfissionais = class(TfrmPaiRelatorio)
    frxPaginaM: TfrxReport;
    Label3: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpbTipRel: TGroupBox;
    ColorLabel2: TColorLabel;
    edtTipRel: TEditFocus;
    rdgOpcao: TRadioGroup;
    frxPaginaJ: TfrxReport;
    frxSaldo: TfrxDBDataset;
    Label5: TLabel;
    edtDesAtividade: TEditFocus;
    edtCodAtividade: TEditFocus;
    Label16: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    gpbFiltro: TGroupBox;
    ColorLabel3: TColorLabel;
    edtFiltro: TEditFocus;
    pgbGerArq: TProgressBar;
    chkSaldoInicial: TCheckBox;
    ColorLabel4: TColorLabel;
    rdgQuebra: TRadioGroup;
    rdgTipCom: TRadioGroup;
    rdgSitPro: TRadioGroup;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    Label11: TLabel;
    Panel1: TPanel;
    pnlVendedor2: TPanel;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    lblDtaIni: TLabel;
    Label8: TLabel;
    mskDtaBai: TMaskEditFocus;
    Label6: TLabel;
    Label1: TLabel;
    mskDtaFin: TMaskEditFocus;
    lblDtaFin: TLabel;
    Label9: TLabel;
    mskDtaBaf: TMaskEditFocus;
    Label7: TLabel;
    Label4: TLabel;
    edtCodProfissional: TEditFocus;
    edtNomProfissional: TEditFocus;
    Label10: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    Label12: TLabel;
    edtCodVe2: TEditFocus;
    edtDesVe2: TEditFocus;
    chkExcelSimples: TCheckBox;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodProfissionalKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodProfissionalExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodAtividadeKeyPress(Sender: TObject; var Key: Char);
    function frxPaginaMUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure edtCodAtividadeExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure rdgQuebraClick(Sender: TObject);
    procedure edtTipRelExit(Sender: TObject);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVe2Exit(Sender: TObject);
    procedure edtCodVe2KeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
  private
    { Private declarations }
    objComPro: TComPro;

    fltSalVen: Double;
    fltSalCom: Double;

    blnBuscaPorChave: Boolean;

    arrProfissional : TConsultasArray;
    strProfissional : String;

    arrVendedor     : TConsultasArray;
    strVendedor     : String;

    arrVendedor2    : TConsultasArray;
    strVendedor2    : String;

    arrAtiv         : TConsultasArray;
    strAtiv         : String;

    arrClientes     : TConsultasArray;
    strClientes     : String;

    arrRede         : TConsultasArray;
    strRede         : String;

    arrEmp          : TConsultasArray;
    strEmp          : String;

    arrFor          : TConsultasArray;
    strFor          : String;
  private
    function fFormataFoneInterna(strFone: String): String;
  public
    { Public declarations }
    intOpCalc  : Integer;


    procedure pCarregaSaldoInicial(strCodPro: String);
    function fRetSalCom: Double;
    function fRetSalVen: Double;


  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

const
  Q_PROFISSIONAL      = 0;
  Q_DATA_FATURAMENTO  = 1;
  Q_VENDEDOR          = 2;
  Q_PROFISSIONAL_EMP  = 3;
  Q_PROFISSIONAL_NOME = 4;

implementation

uses untFuncoes, untFuncoesConsulta, untConsultas,
     untFuncoesGenerica;

{$R *.dfm}

function TfrmRelComissaoProfissionais.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    intCorre : Integer;
begin
  Result := True;

  {*********************}
  {* VALIDA DATAS      *}
  {******************LU*}
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
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End;
        End;
      End;

    End
    Else
    Begin
      mskDtaFin.Clear;
    End;

  End

  Else If (Sender = mskDtaBai) Or (Sender = mskDtaBaf) Then
  Begin

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaBai.Text)) Then
    Begin
      If (Sender = mskDtaBaf) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaBaf.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaBai.Text) > StrToDate(mskDtaBaf.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End;
        End;
      End;
    End Else mskDtaBaf.Clear;

  End
  Else If (Sender = edtCodProfissional ) Then
  Begin
    pDesmarcaLista(edtCodProfissional, arrProfissional);

  End

  Else If (Sender = edtCodVen) Then
    pDesmarcaLista(edtCodVen, arrVendedor)

  Else If (Sender = edtCodVe2) Then
    pDesmarcaLista(edtCodVe2, arrVendedor2)

  {*****************************************}
  {* VALIDA O CÓDIGO DA ATIVIDADE          *}
  {**************************************MV*}
  Else If (Sender = edtCodAtividade) Then
  Begin
    pDesmarcaLista(edtCodAtividade, arrAtiv);
    
  End

  Else If (Sender = edtCodCliente ) Then
  Begin
    pDesmarcaLista(edtCodCliente, arrClientes);

  End

  {**************************************}
  {* VALIDA TIPO DO RELATORIO           *}
  {***********************************AF*}
  Else If (Sender = edtTipRel) Then
  Begin

    If Pos(edtTipRel.Text,'A_S_') <= 0 Then
    Begin
      fMensagem('','O campo tipo do relatorio deve ser A ou S!', ['&OK']);
      Result := False;
    End;

  End

  Else If (Sender = edtCodEmpresa) Then
  Begin
    If (Not fEmptyStr(edtCodEmpresa.Text)) or (High(arrEmp) >= 0 ) Then
    Begin
      if (High(arrEmp) >= 0 ) Then
        For intCorre := 0 To High(arrEmp) Do
        Begin
          If Pos(arrEmp[intCorre].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
            Result := False;
            Break;
          End;
        End
      Else
      If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
      Begin
        fMensagem('', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
        Result := False;
      End;

    End
    Else
      edtDesEmpresa.Text := 'TODAS';
    
  End

  Else If (Sender = edtFornecedor ) Then
  Begin
    pDesmarcaLista(edtFornecedor, arrFor, 'FORNECEDOR');
  End

  Else If (Sender = edtFiltro) Then
  Begin

    If Pos(edtFiltro.Text,'B_P_T_') <= 0 Then
    Begin
      fMensagem('','O campo Filtro deve ser P, B ou T!', ['&OK']);
      Result := False;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelComissaoProfissionais.edtCodClienteKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelComissaoProfissionais.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCliente, edtDesCliente, arrClientes, Nil, fRetNomCliente, 'do cliente', 8);

  If Not fEmptyStr(edtCodCliente.Text) Then
  Begin
    edtCodRede.Enabled := False;
    edtCodRede.Clear;
    pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede',5);
    pSetFocus(edtFornecedor);
  End Else
  Begin
    edtCodRede.Enabled := True;
    pSetFocus(edtCodRede);
  End;
end;

procedure TfrmRelComissaoProfissionais.edtCodEmpresaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelComissaoProfissionais.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa', 3);

end;

procedure TfrmRelComissaoProfissionais.edtCodProfissionalKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE DIVERSOS *}
  {**************************DP*}
  If fPesqDiversos(Self, edtCodProfissional, edtNomProfissional, Nil, Key, arrProfissional, False) Then
  Begin
    If fValidaCampos(edtCodProfissional, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelComissaoProfissionais.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede', 5);

end;

procedure TfrmRelComissaoProfissionais.edtCodRedeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRede, edtDesRede, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRede, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelComissaoProfissionais.edtCodVe2Exit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVe2, edtDesVe2, arrVendedor2, fRetNomVendRep, nil, 'do vendedor', 3);
end;

procedure TfrmRelComissaoProfissionais.edtCodVe2KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVe2, edtDesVe2, Nil, Key, arrVendedor2, False) Then
  Begin
    If fValidaCampos(edtCodVe2, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelComissaoProfissionais.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtDesVen, arrVendedor, fRetNomVendRep, nil, 'do vendedor', 3);
end;

procedure TfrmRelComissaoProfissionais.edtCodVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtDesVen, Nil, Key, arrVendedor, False) Then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelComissaoProfissionais.edtDestinoExit(Sender: TObject);
begin
  inherited;
  chkExcelSimples.Enabled := (edtDestino.Text = 'E') and (edtTipRel.Text = 'S');
end;

procedure TfrmRelComissaoProfissionais.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor,arrFor,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmRelComissaoProfissionais.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFor, False) Then
  Begin
    fValidaCampos(edtFornecedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelComissaoProfissionais.edtTipRelExit(Sender: TObject);
begin
  inherited;
  rdgQuebra.Enabled := edtTipRel.Text = 'A';
  If Not rdgQuebra.Enabled Then
  Begin
    rdgQuebra.ItemIndex := 0;
    chkSaldoInicial.Enabled := True;
  End;
  chkExcelSimples.Enabled := (edtDestino.Text = 'E') and (edtTipRel.Text = 'S');

end;

function TfrmRelComissaoProfissionais.fFormataFoneInterna(
  strFone: String): String;
begin
  Result := fFormataFone(strFone);
end;

procedure TfrmRelComissaoProfissionais.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmRelComissaoProfissionais.FormCreate(Sender: TObject);
begin
  inherited;

  blnExcel := True;

  blnBuscaPorChave := True;
  
  pnlVendedor2.Visible := fCfgSis('REPVEN', varBoolean);
  If Not pnlVendedor2.Visible Then
    Self.Height := Self.Height - pnlVendedor2.Height;

  If fCfgSis('TCOPRO') <> '4' Then
    rdgTipCom.Visible := False;

  objComPro := TComPro.Create(Self);

  frxRelatorio.DataSet := objComPro.qryComPro;
  frxSaldo.DataSet     := objComPro.qryComSal;

  frxPaginaM.AddFunction('procedure pCarregaSaldoInicial(strCodPro: String)');
  frxPaginaM.AddFunction('function fRetSalCom: Double');
  frxPaginaM.AddFunction('function fRetSalVen: Double');
  frxPaginaM.AddFunction('function fFormataFoneInterna(strFone: String): String');

  frxPaginaJ.AddFunction('procedure pCarregaSaldoInicial(strCodPro: String)');
  frxPaginaJ.AddFunction('function fRetSalCom: Double');
  frxPaginaJ.AddFunction('function fRetSalVen: Double');
  frxPaginaJ.AddFunction('function fFormataFoneInterna(strFone: String): String');
end;

procedure TfrmRelComissaoProfissionais.btnImprimirClick(Sender: TObject);
  Function fcmsCodPro : TConsultaMultSelecao;
  Begin
    Result.arrSelecao := arrProfissional;
    Result.strSelecao := @strProfissional;
    Result.edtCodigo  := edtCodProfissional;
    Result.edtDescri  := edtNomProfissional;
  End;

  Function fcmsCodVen : TConsultaMultSelecao;
  Begin
    Result.arrSelecao := arrVendedor;
    Result.strSelecao := @strVendedor;
    Result.edtCodigo  := edtCodVen;
    Result.edtDescri  := edtDesVen;
  End;

  Function fcmsCodVe2 : TConsultaMultSelecao;
  Begin
    Result.arrSelecao := arrVendedor2;
    Result.strSelecao := @strVendedor2;
    Result.edtCodigo  := edtCodVe2;
    Result.edtDescri  := edtDesVe2;
  End;

  Function fcmsCodAti : TConsultaMultSelecao;
  Begin
    Result.arrSelecao := arrAtiv;
    Result.strSelecao := @strAtiv;
    Result.edtCodigo  := edtCodAtividade;
    Result.edtDescri  := edtDesAtividade;
  End;

  Function fcmsCodCli : TConsultaMultSelecao;
  Begin
    Result.arrSelecao := arrClientes;
    Result.strSelecao := @strClientes;
    Result.edtCodigo  := edtCodCliente;
    Result.edtDescri  := edtDesCliente;
  End;

  Function fcmsCodRed : TConsultaMultSelecao;
  Begin
    Result.arrSelecao := arrRede;
    Result.strSelecao := @strRede;
    Result.edtCodigo  := edtCodRede;
    Result.edtDescri  := edtDesRede;
  End;

  Function fcmsCodEmp : TConsultaMultSelecao;
  Begin
    Result.arrSelecao := arrEmp;
    Result.strSelecao := @strEmp;
    Result.edtCodigo  := edtCodEmpresa;
    Result.edtDescri  := edtDesEmpresa;
  End;

  Function fcmsCodFor : TConsultaMultSelecao;
  Begin
    Result.arrSelecao := arrFor;
    Result.strSelecao := @strFor;
    Result.edtCodigo  := edtFornecedor;
    Result.edtDescri  := edtDesFornecedor;
  End;

Var
  qckRelatorio: TfrxReport;
begin
  blnBuscaPorChave := False;
  inherited;
  Try

    If blnImprime Then
    Begin
      pnlInfo.Caption := 'Gerando Relatório...';
      pnlInfo.Repaint;
      Application.ProcessMessages;

      Try
        If rdgTipCom.Visible Then
        Begin
          Case rdgTipCom.ItemIndex Of
            0: objComPro.VS_strTCoProInterna := '1';//Valor
            1: objComPro.VS_strTCoProInterna := '3';//Pontos
          End;
        End;

        objComPro.blnMulSel := True;
        objComPro.strDtaIni := mskDtaIni.Text;
        objComPro.strDtaFin := mskDtaFin.Text;
        objComPro.strDtaBai := mskDtaBai.Text;
        objComPro.strDtaBaf := mskDtaBaf.Text;
        objComPro.intStatus := rdgSitPro.ItemIndex;

        objComPro.intOrdem := rdgQuebra.ItemIndex;

        objComPro.cmsCodPro := fcmsCodPro;
        objComPro.cmsCodVen := fcmsCodVen;
        objComPro.cmsCodVe2 := fcmsCodVe2;
        objComPro.cmsCodAti := fcmsCodAti;
        objComPro.cmsCodCli := fcmsCodCli;
        objComPro.cmsCodRed := fcmsCodRed;
        objComPro.cmsCodEmp := fcmsCodEmp;
        objComPro.cmsCodFor := fcmsCodFor;

        objComPro.strTipFil := edtFiltro.Text;

        If rdgOpcao.ItemIndex = 0 Then
          intOpCalc := 1
        Else
          intOpCalc := 2;

        {**************************************}
        {* CARREGA DADOS DO RELATÓRIO CASO    *}
        {* ESTEJA VAZIO ENTÃO CRIA UM EXCEPT  *}
        {********************************AF,JB*}
        Try
          objComPro.pGeraRelatorioComissao(edtTipRel.Text,intOpCalc);
        Except
          On E: Exception Do
          Begin
            fMensagem('', E.Message, ['&Ok']);
            Exit;
          End;
        End;

        If edtDestino.Text = 'E' Then
        Begin
          objComPro.pMontaExcel(Self, chkExcelSimples.Checked);
        End Else
        Begin
          {******************************************************}
          {* DEFINE SE O RELATORIO É MATRICIAL OU JATO DE TINTA *}
          {***************************************************LU*}
          If strTipImp = 'M' Then
            qckRelatorio := frxPaginaM
          Else
          Begin
            qckRelatorio := frxPaginaJ;
            TfrxMemoView(qckRelatorio.FindObject('rllZebra')).Highlight.Color := StrToIntDef(fCfgSis('CORZEB'), clWhite);
            TfrxMemoView(qckRelatorio.FindObject('rllZebra1')).Highlight.Color := StrToIntDef(fCfgSis('CORZEB'), clWhite);
            TfrxMemoView(qckRelatorio.FindObject('rllZebra2')).Highlight.Color := StrToIntDef(fCfgSis('CORZEB'), clWhite);
            TfrxMemoView(qckRelatorio.FindObject('rllZebra3')).Highlight.Color := StrToIntDef(fCfgSis('CORZEB'), clWhite);
          End;

          If objComPro.VS_strTCoProInterna = '3' Then
          Begin
            TFrxMemoView(qckRelatorio.FindObject('rllComiss1')).Text := 'QTD.PONTOS';
            TFrxMemoView(qckRelatorio.FindObject('rllComiss2')).Text := 'QTD.PONTOS';
            TFrxMemoView(qckRelatorio.FindObject('rllComiss3')).Text := 'QTD.PONTOS';
            TFrxMemoView(qckRelatorio.FindObject('rllValCom')).Text  := 'QTD.PONTOS';
            TFrxMemoView(qckRelatorio.FindObject('rllSalIni')).Text  := 'SAL.INI.PONT.';
          End
          Else
          Begin
            TFrxMemoView(qckRelatorio.FindObject('rllComiss1')).Text := 'VR.COMISSAO';
            TFrxMemoView(qckRelatorio.FindObject('rllComiss2')).Text := 'VR.COMISSAO';
            TFrxMemoView(qckRelatorio.FindObject('rllComiss3')).Text := 'VR.COMISSAO';
            TFrxMemoView(qckRelatorio.FindObject('rllValCom')).Text  := 'VR.COMISSAO';
            TFrxMemoView(qckRelatorio.FindObject('rllSalIni')).Text  := 'SAL.INI.COM.';
          End;

          TFrxMemoView(qckRelatorio.FindObject('rllPerComSint'   )).Visible := objComPro.VS_strTCoProInterna <> '3';
          TFrxMemoView(qckRelatorio.FindObject('rdbPerComSint'   )).Visible := objComPro.VS_strTCoProInterna <> '3';
          TFrxMemoView(qckRelatorio.FindObject('rdbPerComGerSint')).Visible := objComPro.VS_strTCoProInterna <> '3';

          TFrxMemoView(qckRelatorio.FindObject('rllPerCom1')).Visible := objComPro.VS_strTCoProInterna <> '3';
          TFrxMemoView(qckRelatorio.FindObject('rllPerCom2')).Visible := objComPro.VS_strTCoProInterna <> '3';
          TFrxMemoView(qckRelatorio.FindObject('rllPerCom3')).Visible := objComPro.VS_strTCoProInterna <> '3';

          TFrxMemoView(qckRelatorio.FindObject('rdbPerCom1')).Visible := objComPro.VS_strTCoProInterna <> '3';
          TFrxMemoView(qckRelatorio.FindObject('rdbPerCom2')).Visible := objComPro.VS_strTCoProInterna <> '3';
          TFrxMemoView(qckRelatorio.FindObject('rdbPerCom3')).Visible := objComPro.VS_strTCoProInterna <> '3';

          TFrxMemoView(qckRelatorio.FindObject('rdbTotPerCom1')).Visible := objComPro.VS_strTCoProInterna <> '3';
          TFrxMemoView(qckRelatorio.FindObject('rdbTotPerCom2')).Visible := objComPro.VS_strTCoProInterna <> '3';
          TFrxMemoView(qckRelatorio.FindObject('rdbTotPerCom3')).Visible := objComPro.VS_strTCoProInterna <> '3';

          TFrxMemoView(qckRelatorio.FindObject('rllFilFor')).Visible := (Length(arrFor) > 0);

          qckRelatorio.Script.Variables['CODPRO'] := fStrTitulo(edtCodProfissional.Text, edtNomProfissional, arrProfissional, strProfissional, 'PROFISSIONAL');
          qckRelatorio.Script.Variables['VENDED'] := fStrTitulo(edtCodVen.Text, edtDesVen, arrVendedor, strVendedor, 'VENDEDOR');
          qckRelatorio.Script.Variables['VENDED2'] := IIF(pnlVendedor2.Visible, fStrTitulo(edtCodVe2.Text, edtDesVe2, arrVendedor2, strVendedor2, 'VENDEDOR 2'), '');
          qckRelatorio.Script.Variables['CODATI'] := fStrTitulo(edtCodAtividade.Text, edtDesAtividade, arrAtiv, strAtiv, 'ATIVIDADE', True);
          qckRelatorio.Script.Variables['CODCLI'] := fStrTitulo(edtCodCliente.Text, edtDesCliente, arrClientes, strClientes, 'CLIENTE');
          qckRelatorio.Script.Variables['CODEMP'] := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA', True);
          qckRelatorio.Script.Variables['REDLOJ'] := fStrTitulo(edtCodRede.Text, edtDesRede, arrRede, strRede, 'REDE DE LOJAS', True);
          qckRelatorio.Script.Variables['TIPFIL'] := 'FILTRO: ' + IIF((edtFiltro.Text = 'T'), 'TODOS', IIF((edtFiltro.Text = 'P'), 'PENDENTES', 'BAIXADOS'));
          qckRelatorio.Script.Variables['STATUS'] := IIF(strTipImp = 'M', 'SITUACAO', 'SITUAÇÃO') + ' DO PROFISSIONAL: ' + IIF(rdgSitPro.ItemIndex = 0,'ATIVO',IIF(rdgSitPro.ItemIndex = 1, 'INATIVO', 'TODOS'));
          qckRelatorio.Script.Variables['CODFOR'] := fStrTitulo(edtFornecedor.Text, edtDesFornecedor, arrFor, strFor, 'FORNECEDOR');

          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaBai.Text))) Then
            qckRelatorio.Script.Variables['REFERENTE'] := IIF(strTipImp = 'M', 'PERIODO', 'PERÍODO') + ' DE ENTRADA: ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text + ' ' + IIF(strTipImp = 'M', 'PERIODO', 'PERÍODO') + ' DA BAIXA: ' + mskDtaBai.Text + ' A ' + mskDtaBaf.Text
          Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
            qckRelatorio.Script.Variables['REFERENTE'] := IIF(strTipImp = 'M', 'PERIODO', 'PERÍODO') + ' DE ENTRADA: ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text
          Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaBai.Text))) Then
            qckRelatorio.Script.Variables['REFERENTE'] := IIF(strTipImp = 'M', 'PERIODO', 'PERÍODO') + ' DA BAIXA: ' + mskDtaBai.Text + ' A ' + mskDtaBaf.Text
          Else
            qckRelatorio.Script.Variables['REFERENTE'] := '';


          If edtTipRel.Text = 'A' Then
          Begin
            If strTipImp = 'M' Then
              qckRelatorio.Script.Variables['NOMREL'] := 'RELATORIO DE COMISSAO DE PROFISSIONAIS - ANALITICO '
            Else
              qckRelatorio.Script.Variables['NOMREL'] := 'RELATÓRIO DE COMISSÃO DE PROFISSIONAIS - ANALÍTICO ';

            TfrxComponent(qckRelatorio.FindObject('rllMsgSaldoPro')).Visible := True;

            With qckRelatorio Do
            Begin
              Case rdgQuebra.ItemIndex Of
                Q_PROFISSIONAL,
                Q_PROFISSIONAL_EMP,
                Q_PROFISSIONAL_NOME:
                  Begin
                    Script.Variables['NOMREL'] := Script.Variables['NOMREL'] + ' - POR PROFISSIONAL ';
                    Script.Variables['QUEBRA'] := 'Profissional';

                    TfrxGroupHeader(FindObject('rlbTituloGrupo')).Height := TfrxComponent(FindObject('rllSalTit')).Top + TfrxComponent(FindObject('rllSalTit')).Height;
                    TfrxGroupHeader(FindObject('rlbTituloGrupo')).Condition := 'frxRelatorio."COM_CODPRO"';

                    If (rdgQuebra.ItemIndex = Q_PROFISSIONAL) or (rdgQuebra.ItemIndex = Q_PROFISSIONAL_NOME) Then
                      TfrxGroupHeader(FindObject('rlbTituloEmpresa')).Condition := 'frxRelatorio."COM_CODPRO"';

                    TfrxMemoView(FindObject('rllTitGrupo')).Text := 'PROFISSIONAL:';
                    TfrxMemoView(FindObject('rllDesGrupo')).Text := '[frxRelatorio."COM_CODPRO"]  [frxRelatorio."DIV_NOMDIV"] - [frxRelatorio."ATI_DESATI"]';
                    TfrxMemoView(FindObject('rllTotalGrupoTit')).Text := 'TOTAL DO PROFISSIONAL:';
                  End;
                Q_DATA_FATURAMENTO:
                  Begin
                    Script.Variables['NOMREL'] := Script.Variables['NOMREL'] + ' - POR DATA DE FATURAMENTO ';
                    Script.Variables['QUEBRA'] := 'Data Faturamento';

                    TfrxGroupHeader(FindObject('rlbTituloGrupo')).Height := TfrxComponent(FindObject('rllTitGrupo')).Top + TfrxComponent(FindObject('rllTitGrupo')).Height;
                    TfrxGroupHeader(FindObject('rlbTituloGrupo')).Condition := 'frxRelatorio."COM_DTACAD"';

                    TfrxMemoView(FindObject('rllTitGrupo')).Text := 'DATA FATURAMENTO:';
                    TfrxMemoView(FindObject('rllDesGrupo')).Text := '[FormatDateTime('+QuotedStr('dd/mm/yyyy')+', <frxRelatorio."COM_DTACAD">)]';
                    TfrxMemoView(FindObject('rllTotalGrupoTit')).Text := 'TOTAL EM [FormatDateTime('+QuotedStr('dd/mm/yyyy')+', <frxRelatorio."COM_DTACAD">)]:';
                  End;
                Q_VENDEDOR:
                  Begin
                    Script.Variables['NOMREL'] := Script.Variables['NOMREL'] + ' - POR VENDEDOR ';
                    Script.Variables['QUEBRA'] := 'Vendedor';

                    TfrxGroupHeader(FindObject('rlbTituloGrupo')).Height := TfrxComponent(FindObject('rllTitGrupo')).Top + TfrxComponent(FindObject('rllTitGrupo')).Height;
                    TfrxGroupHeader(FindObject('rlbTituloGrupo')).Condition := 'frxRelatorio."VENDED"';

                    TfrxMemoView(FindObject('rllTitGrupo')).Text := 'VENDEDOR:';
                    TfrxMemoView(FindObject('rllDesGrupo')).Text := '[frxRelatorio."VENDED"]';
                    TfrxMemoView(FindObject('rllTotalGrupoTit')).Text := 'TOTAL DO VENDEDOR:';
                  End;
              End;

              If rdgTipCom.Visible Then
              Begin
                Case rdgTipCom.ItemIndex Of
                  0: Script.Variables['NOMREL'] := Script.Variables['NOMREL'] + ' - VALOR  ';//Valor
                  1: Script.Variables['NOMREL'] := Script.Variables['NOMREL'] + ' - PONTOS ';//Pontos
                End;
              End;

              Script.Variables['NOMREL'] := Script.Variables['NOMREL'];
            End;

            (qckRelatorio.FindObject('rlbTituloSint')  As TfrxHeader).Visible     := False;
            (qckRelatorio.FindObject('rlbDetalheSint') As TfrxMasterData).Visible := False;
            (qckRelatorio.FindObject('rlbSumarioSint') As TfrxFooter).Visible     := False;

            TfrxComponent(qckRelatorio.FindObject('rlbTituloGrupo')).Visible    := True;
            TfrxComponent(qckRelatorio.FindObject('rlbSumarioGrupo')).Visible   := True;
            TfrxComponent(qckRelatorio.FindObject('rlbSumario')).Visible        := True;
            TfrxComponent(qckRelatorio.FindObject('rlbTitulo')).Visible         := True;
            TfrxComponent(qckRelatorio.FindObject('rlbDetalhes')).Visible       := True;

            TfrxComponent(qckRelatorio.FindObject('rlbTituloEmpresa')).Visible  := rdgQuebra.ItemIndex = Q_PROFISSIONAL_EMP;
            TfrxComponent(qckRelatorio.FindObject('rlbSumarioEmpresa')).Visible := rdgQuebra.ItemIndex = Q_PROFISSIONAL_EMP;

            TfrxComponent(qckRelatorio.FindObject('rllSalTit')).Visible   := (rdgQuebra.ItemIndex = Q_PROFISSIONAL) OR (rdgQuebra.ItemIndex = Q_PROFISSIONAL_NOME) OR (rdgQuebra.ItemIndex = Q_PROFISSIONAL_EMP);
            TfrxComponent(qckRelatorio.FindObject('rllSalVen')).Visible   := (rdgQuebra.ItemIndex = Q_PROFISSIONAL) OR (rdgQuebra.ItemIndex = Q_PROFISSIONAL_NOME) OR (rdgQuebra.ItemIndex = Q_PROFISSIONAL_EMP);
            TfrxComponent(qckRelatorio.FindObject('rllSalCom')).Visible   := (rdgQuebra.ItemIndex = Q_PROFISSIONAL) OR (rdgQuebra.ItemIndex = Q_PROFISSIONAL_NOME) OR (rdgQuebra.ItemIndex = Q_PROFISSIONAL_EMP);
            TfrxComponent(qckRelatorio.FindObject('rllCreDebSI')).Visible := (rdgQuebra.ItemIndex = Q_PROFISSIONAL) OR (rdgQuebra.ItemIndex = Q_PROFISSIONAL_NOME) OR (rdgQuebra.ItemIndex = Q_PROFISSIONAL_EMP);

            TfrxComponent(qckRelatorio.FindObject('ChildTituloProfissional')).Visible := (rdgQuebra.ItemIndex = Q_PROFISSIONAL) OR (rdgQuebra.ItemIndex = Q_PROFISSIONAL_NOME) OR (rdgQuebra.ItemIndex = Q_PROFISSIONAL_EMP);
            TfrxComponent(qckRelatorio.FindObject('ChildDetProfissional')).Visible    := (rdgQuebra.ItemIndex = Q_PROFISSIONAL) OR (rdgQuebra.ItemIndex = Q_PROFISSIONAL_NOME) OR (rdgQuebra.ItemIndex = Q_PROFISSIONAL_EMP);
            TfrxComponent(qckRelatorio.FindObject('ChildTituloVend')).Visible         := rdgQuebra.ItemIndex = Q_VENDEDOR;
            TfrxComponent(qckRelatorio.FindObject('ChildDetVend')).Visible            := rdgQuebra.ItemIndex = Q_VENDEDOR;
            TfrxComponent(qckRelatorio.FindObject('ChildTituloDtaCad')).Visible       := rdgQuebra.ItemIndex = Q_DATA_FATURAMENTO;
            TfrxComponent(qckRelatorio.FindObject('ChildDetDtaCad')).Visible          := rdgQuebra.ItemIndex = Q_DATA_FATURAMENTO;

          End
          Else
          Begin
            If strTipImp = 'M' Then
              qckRelatorio.Script.Variables['NOMREL'] := 'RELATORIO DE COMISSAO DE PROFISSIONAIS - SINTETICO '
            Else
              qckRelatorio.Script.Variables['NOMREL'] := 'RELATÓRIO DE COMISSÃO DE PROFISSIONAIS - SINTÉTICO ';

            If rdgTipCom.Visible Then
            Begin
              Case rdgTipCom.ItemIndex Of
                0: qckRelatorio.Script.Variables['NOMREL'] := qckRelatorio.Script.Variables['NOMREL'] + ' - VALOR  ';//Valor
                1: qckRelatorio.Script.Variables['NOMREL'] := qckRelatorio.Script.Variables['NOMREL'] + ' - PONTOS ';//Pontos
              End;
            End;

            qckRelatorio.Script.Variables['NOMREL'] := qckRelatorio.Script.Variables['NOMREL'];

            TfrxGroupHeader(qckRelatorio.FindObject('rlbTituloGrupo')).Condition := 'frxRelatorio."COM_CODPRO"';
            TfrxComponent(qckRelatorio.FindObject('rllMsgSaldoPro')).Visible := False;

            TfrxComponent(qckRelatorio.FindObject('ChildTituloProfissional')).Visible := False;
            TfrxComponent(qckRelatorio.FindObject('ChildDetProfissional')).Visible    := False;
            TfrxComponent(qckRelatorio.FindObject('ChildTituloVend')).Visible         := False;
            TfrxComponent(qckRelatorio.FindObject('ChildDetVend')).Visible            := False;
            TfrxComponent(qckRelatorio.FindObject('ChildTituloDtaCad')).Visible       := False;
            TfrxComponent(qckRelatorio.FindObject('ChildDetDtaCad')).Visible          := False;

            TfrxComponent(qckRelatorio.FindObject('rlbTituloEmpresa')).Visible    := False;
            TfrxComponent(qckRelatorio.FindObject('rlbSumarioEmpresa')).Visible   := False;

            (qckRelatorio.FindObject('rlbTituloSint')  As TfrxHeader).Visible     := True;
            (qckRelatorio.FindObject('rlbDetalheSint') As TfrxMasterData).Visible := True;
            (qckRelatorio.FindObject('rlbSumarioSint') As TfrxFooter).Visible     := True;

            (qckRelatorio.FindObject('rlbTitulo')       As TfrxHeader).Visible      := False;
            (qckRelatorio.FindObject('rlbTituloGrupo')  As TfrxGroupHeader).Visible := False;
            (qckRelatorio.FindObject('rlbDetalhes')     As TfrxMasterData).Visible  := False;
            (qckRelatorio.FindObject('rlbSumarioGrupo') As TfrxGroupFooter).Visible := False;
            (qckRelatorio.FindObject('rlbSumario')      As TfrxFooter).Visible      := False;

          End;

          If edtDestino.Text = 'V' Then
            pPreviewReport(Self.Name, Self.Caption, qckRelatorio)
          Else
            If qckRelatorio.PrepareReport Then
              pPrintReport(Self.Name, Self.Caption, strNomImp, qckRelatorio);
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message,'[TfrmRelComissaoProfissionais.btnImprimirClick]');
        End;
      End;

    End;

  Finally
    btnImprimir.Enabled := True;
    pnlInfo.Caption := '';
    pSetFocus(mskDtaIni);
  End;
end;

procedure TfrmRelComissaoProfissionais.edtCodProfissionalExit(
  Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodProfissional, edtNomProfissional, arrProfissional, nil, fRetNomProfissional, 'do profissional', 8);
  
end;

procedure TfrmRelComissaoProfissionais.FormShow(Sender: TObject);
begin
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);
  
  SetLength(arrEmp, 1);
  arrEmp[0].strCodigo := edtCodEmpresa.Text;
  arrEmp[0].strDescri := edtDesEmpresa.Text;

  inherited;
end;

procedure TfrmRelComissaoProfissionais.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    If (Assigned(ActiveControl)) And (ActiveControl Is TRadioButton) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelComissaoProfissionais.edtCodAtividadeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAtividade, edtDesAtividade, arrAtiv, nil, fRetNomAtividade, 'da atividade', 3);
  
end;

procedure TfrmRelComissaoProfissionais.edtCodAtividadeKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAtividade, edtDesAtividade, Nil, Key, arrAtiv, False) Then
  Begin
    if fValidaCampos(edtCodAtividade, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelComissaoProfissionais.fRetSalCom: Double;
begin
  Result := fltSalCom;
end;

function TfrmRelComissaoProfissionais.fRetSalVen: Double;
begin
  Result := fltSalVen;
end;

procedure TfrmRelComissaoProfissionais.pCarregaSaldoInicial(
  strCodPro: String);
begin
  fltSalCom := 0;
  fltSalVen := 0;

  If chkSaldoInicial.Checked Then
  Begin
    objComPro.pRetornaSaldoInicial(strCodPro, intOpCalc, StrToDateDef(mskDtaIni.Text,0), fltSalVen, fltSalCom);
  End;
end;

procedure TfrmRelComissaoProfissionais.rdgQuebraClick(Sender: TObject);
begin
  inherited;
  chkSaldoInicial.Enabled := (rdgQuebra.ItemIndex = 0) or (rdgQuebra.ItemIndex = 4);
  If Not chkSaldoInicial.Enabled Then
    chkSaldoInicial.Checked := False;
end;

function TfrmRelComissaoProfissionais.frxPaginaMUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  inherited;
  If SameText(MethodName, 'pCarregaSaldoInicial') Then
    pCarregaSaldoInicial(Params[0])

  Else If SameText(MethodName, 'fRetSalCom') Then
    Result := fRetSalCom

  Else If SameText(MethodName, 'fRetSalVen') Then
    Result := fRetSalVen

  Else If SameText(MethodName, 'fFormataFoneInterna') Then
    Result := fFormataFoneInterna(Params[0]);
end;

end.

