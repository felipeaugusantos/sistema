unit untCfgEfdSpedContribuicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Uni, Data.DB, MaskEditFocus,
  Vcl.Mask;

type
  TfrmCfgEfdSpedContribuicao = class(TfrmPaiCad)
    pnlConfiguracaoSpedContribuicao: TPanel;
    grpPisCofinsCumulativo: TGroupBox;
    lbl85: TLabel;
    Label81: TLabel;
    edtCodRecPisCumulativo: TEditFocus;
    edtCodRecCofinsCumulativo: TEditFocus;
    grpPisCofinsNCumulativo: TGroupBox;
    Label88: TLabel;
    Label89: TLabel;
    edtCodRecPis: TEditFocus;
    edtCodRecCofins: TEditFocus;
    gpCodigoServicoCampo11Reg0200: TGroupBox;
    Label147: TLabel;
    edtCodSerCampo11Reg0200: TEditFocus;
    grpReg0500: TGroupBox;
    GroupBox48: TGroupBox;
    Label205: TLabel;
    Label206: TLabel;
    chkReg0500ContasFixas: TCheckBox;
    edtContaAnaliticaReg0500Entrada: TEditFocus;
    edtContaAnaliticaReg0500Saida: TEditFocus;
    grpConAnaCont: TGroupBox;
    chkUtilizarRotinaAbreviacaoContabil: TCheckBox;
    pnlOutrasCOnfiguracao: TPanel;
    chkEnviarFixo1RegA100Campo13: TCheckBox;
    chkEnviaRegC180: TCheckBox;
    chkEnviarDadosEmpresaAnteriorSpedPisCof: TCheckBox;
    dtsSpedConfEfd: TDataSource;
    grpNaturezaCreditoFreteD101: TGroupBox;
    cmbNaturezaCreditoFreteD101: TComboBox;
    btnLinGruExcluir: TBitBtnLocked;
    grpRegf150: TGroupBox;
    Label1: TLabel;
    edtCodCtaF150: TEditFocus;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    edtCSTPISJur: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    mskCodConJur: TMaskEditFocus;
    edtDesConJur: TEditFocus;
    mskCodConDes: TMaskEditFocus;
    edtDesConDes: TEditFocus;
    edtALQPISJur: TEditFocus;
    edtCSTCOFJur: TEditFocus;
    edtALQCOFJur: TEditFocus;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtCSTPISDes: TEditFocus;
    edtALQPISDes: TEditFocus;
    edtCSTCOFDes: TEditFocus;
    edtALQCOFDes: TEditFocus;
    grpRegGAPCNT: TGroupBox;
    chkPIS_COFINS_LEI_224_2025: TCheckBox;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLinGruExcluirClick(Sender: TObject);
    procedure edtCodCtaF150KeyPress(Sender: TObject; var Key: Char);
    procedure mskCodConJurKeyPress(Sender: TObject; var Key: Char);
    procedure mskCodConDesKeyPress(Sender: TObject; var Key: Char);

  const
    VS_TAMAMNHO_COD_NATUREZA_CREDITO_FRETE = 2;
    VS_STR_NATUREZA_CREDITO_FRETE = '14';

  private
    { Private declarations }
    qryAux: TUniQuery;
    strMascara : String;
    procedure pCriaTabelaConfiguracoesBancoDeDados;
    procedure pCriaConfiguracoesBancoDeDadosDefault;
    procedure pGeraConfiguracoesBancoDeDados(strCodEmp, strCodCfg, strCdCfAb,
      strUtiBlc, strPriori, strDescri, strRegNeg, strValCfg, strGruCfg: string;
      intNumHlp: Integer; dtaUltAlt: TDate; hraUltAlt: TTime; strLayout: string);

    function fRetornaCodNaturezaCreditoFrete: String;
    function fRetornaPosicaoNaturezaCreditoFrete(strCodNaturezaCreditoFrete: String): integer;

    function fRetornaPlanco: Boolean;
    function fRetConfiguracao(strEmpresa, strConfiguracao: string): string;
    function fRetExisteConfiguracao(strEmpresa, strConfiguracao: string): Boolean;
    procedure pHabilitaDesabilitaObjetosEmTela;
    procedure pAlimentaObjetosEmTelaComBaseNoBancoDados;
    procedure pGravarNoBancoDadosComBaseEmObjetosDeTela;
    function fRetornaPlanoContabil(strPlaCon: string): string;
    procedure pCarregaPlanoContabilJur(const blnBuscaPorChave: Boolean=False);
    procedure pCarregaPlanoContabilDes(const blnBuscaPorChave: Boolean=False);
  public
    { Public declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  protected
    procedure pInicializaIndices; override;
  end;

var
  frmCfgEfdSpedContribuicao: TfrmCfgEfdSpedContribuicao;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema, untConfigLinhaGrupoSped,
  Contabilidade.Funcoes, Contabilidade.Consultas;


{ TfrmConfiguracoesSpedContribuicao }

procedure TfrmCfgEfdSpedContribuicao.btnGravarClick(Sender: TObject);
begin

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  inherited;
  try
    pGravarNoBancoDadosComBaseEmObjetosDeTela;
    fMensagem('', 'Configurações Salvas com sucesso!', ['&Ok']);
  except
    On E: Exception Do
    begin
      fMensagem('ATENÇÃO!', 'Ocorreu problemas na gravação das informações, ' + e.Message, ['&Ok']);
      pnlInfo.Caption := 'Ocorreu problemas na gravação das informações';
      Abort;
    end;
  end;

  pSetFocus(edtCodSerCampo11Reg0200);
  pnlInfo.Caption := '';
end;

function TfrmCfgEfdSpedContribuicao.fRetornaCodNaturezaCreditoFrete: String;
begin

  Result := VS_STR_NATUREZA_CREDITO_FRETE;

  if (not fEmptyStr(cmbNaturezaCreditoFreteD101.text)) then
  begin
    Result := Copy(cmbNaturezaCreditoFreteD101.text,1,VS_TAMAMNHO_COD_NATUREZA_CREDITO_FRETE);
  end;

end;

function TfrmCfgEfdSpedContribuicao.fRetornaPosicaoNaturezaCreditoFrete(strCodNaturezaCreditoFrete: String): integer;
var
  intContador: integer;
  strCodNaturezaAux: String;
begin

  Result := 0;

  strCodNaturezaAux := VS_STR_NATUREZA_CREDITO_FRETE;

  if not fEmptyStr(strCodNaturezaCreditoFrete) then
    strCodNaturezaAux := strCodNaturezaCreditoFrete;

  for intContador := 0 to (cmbNaturezaCreditoFreteD101.Items.Count - 1) do
  begin

    if (Copy(cmbNaturezaCreditoFreteD101.Items[intContador],1,VS_TAMAMNHO_COD_NATUREZA_CREDITO_FRETE) = strCodNaturezaAux) then
    begin
      Result := intContador;
      exit;
    end;

  end;

end;

procedure TfrmCfgEfdSpedContribuicao.btnLinGruExcluirClick(Sender: TObject);
var
  frmConfigLinhaGrupoSped: TfrmConfigLinhaGrupoSped;
begin
  inherited;
  if (fTabelaExiste('CONLGS', True)) then
  begin
    pVerificaProCod;
    pValidaProCod('CONLGS');
    frmConfigLinhaGrupoSped := TfrmConfigLinhaGrupoSped.Create(Nil);
    Try
      frmConfigLinhaGrupoSped.blnFiscal := False;
      frmConfigLinhaGrupoSped.ShowModal;
    Finally
      frmConfigLinhaGrupoSped.Free;
    End;
  end
  else
    fMensagem('ATENÇÃO','A tabela CONLGS não existe, favor entrar em contato com o suporte!', ['&Ok']);
end;

function TfrmCfgEfdSpedContribuicao.fRetornaPlanoContabil(strPlaCon: string): string;
begin
  Result := fCampoTabela('CON_CODCTA', 'PLACON', ['REPLACE(REPLACE(REPLACE(REPLACE(CON_CODCTA, " ", ""), ".", ""), ":", ""), "\t", "")'], [fSemMascaraPlaNco(strPlaCon)], False);
end;

procedure TfrmCfgEfdSpedContribuicao.pCarregaPlanoContabilJur(const blnBuscaPorChave: Boolean);
var
  strTplAco : string ;
begin
  if blnBuscaPorChave then
  begin
    edtDesConJur.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskCodConJur.Text)]);
  end
  else
  begin
    strTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False);
    edtDesConJur.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskCodConJur.Text), strTplAco]);
  end;
end;

procedure TfrmCfgEfdSpedContribuicao.pCarregaPlanoContabilDes(const blnBuscaPorChave: Boolean);
var
  strTplAco : string ;
begin
  if blnBuscaPorChave then
  begin
    edtDesConDes.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskCodConDes.Text)]);
  end
  else
  begin
    strTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False);
    edtDesConDes.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskCodConDes.Text), strTplAco]);
  end;
end;

procedure TfrmCfgEfdSpedContribuicao.edtCodCtaF150KeyPress(Sender: TObject;
  var Key: Char);
var
  arrPlaCon: TConsultasArray;
  qryConsulta: TUniQuery;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    try
      qryConsulta := fCriaQuery;
      try
        if fPesqPlanoContasContabil(Self, nil, nil, qryConsulta, Key, arrPlaCon) then
        begin
          edtCodCtaF150.Text := qryConsulta.FieldByName('CON_CODCTA').AsString;
          if fValidaCampos(edtCodCtaF150, True) then
            SelectNext(ActiveControl, True, True);
          Key := Char(0);
        end;
      except
        on E: Exception do
          pMensagensErro(E.Message,'');
      end;
    finally
      FreeAndNil(qryConsulta);
    end;
  end;
end;

procedure TfrmCfgEfdSpedContribuicao.FormCreate(Sender: TObject);
begin
  inherited;
  qryAux := fCriaQuery(Self);
  pCriaTabelaConfiguracoesBancoDeDados;

  blnVerificaProCod        := False;
  strNomeTabela            := 'CFGSPD';
  strNomeCampo             := 'SPD_CODCFG';

  qryTabela                := fCriaQuery(Self);
  dtsSpedConfEfd.DataSet   := qryTabela;

  SetLength(arrCamposChave, 1);

  strMascara := fMskCon;
  mskCodConJur.EditMask := strMascara;
  mskCodConDes.EditMask := strMascara;
end;

procedure TfrmCfgEfdSpedContribuicao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryAux);
end;

procedure TfrmCfgEfdSpedContribuicao.FormShow(Sender: TObject);
begin
  inherited;
  pHabilitaDesabilitaObjetosEmTela;
  pAlimentaObjetosEmTelaComBaseNoBancoDados;
  pSetFocus(edtCodSerCampo11Reg0200);

  pCarregaPlanoContabilJur(True);
  pCarregaPlanoContabilDes(True);
end;

function TfrmCfgEfdSpedContribuicao.fRetConfiguracao(strEmpresa,
  strConfiguracao: string): string;
begin
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT ');
    qryAux.SQL.Add('   SUBSTRING(SPD_VALCFG, 1, 1200) AS SPD_VALCFG ');
    qryAux.SQL.Add(' FROM ');
    qryAux.SQL.Add('   CFGSPD ');
    qryAux.SQL.Add(' WHERE SPD_CODCFG = :CODCFG ');
    qryAux.SQL.Add('   AND SPD_CODEMP = :CODEMP ');
    qryAux.SQL.Add(' LIMIT 1 ');

    qryAux.ParamByName('CODCFG').AsString  := strConfiguracao;
    qryAux.ParamByName('CODEMP').AsString  := strEmpresa;
    qryAux.Open;

    if not(qryAux.IsEmpty) then
      Result := qryAux.FieldByName('SPD_VALCFG').AsString
    else Result := '';
  finally
  end;
end;

function TfrmCfgEfdSpedContribuicao.fRetExisteConfiguracao(strEmpresa,
  strConfiguracao: string): Boolean;
begin
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT ');
    qryAux.SQL.Add('   SUBSTRING(SPD_VALCFG, 1, 1200) AS SPD_VALCFG ');
    qryAux.SQL.Add(' FROM ');
    qryAux.SQL.Add('   CFGSPD ');
    qryAux.SQL.Add(' WHERE SPD_CODCFG = :CODCFG ');
    qryAux.SQL.Add('   AND SPD_CODEMP = :CODEMP ');
    qryAux.SQL.Add(' LIMIT 1 ');

    qryAux.ParamByName('CODCFG').AsString  := strConfiguracao;
    qryAux.ParamByName('CODEMP').AsString  := strEmpresa;
    qryAux.Open;

    Result := not qryAux.IsEmpty;
  finally
  end;
end;

function TfrmCfgEfdSpedContribuicao.fRetornaPlanco: Boolean;
  Var
    qryAuxPlanco: TUniQuery;
begin
  if fTabelaExiste('PLANCO', True) then
  begin
    qryAuxPlanco := fCriaQuery(Self);

    qryAuxPlanco.SQL.Add('SELECT ');
    qryAuxPlanco.SQL.Add('  PLANCO.AUTOINCREM ');
    qryAuxPlanco.SQL.Add('FROM ');
    qryAuxPlanco.SQL.Add('  PLANCO ');
    qryAuxPlanco.SQL.Add('  INNER JOIN CADEMP ');
    qryAuxPlanco.SQL.Add('    ON EMP_TPLACO = NCO_TPLACO ');
    qryAuxPlanco.SQL.Add('WHERE EMP_CODEMP = :CODEMP ');
    qryAuxPlanco.SQL.add('LIMIT 1 ');

    qryAuxPlanco.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAuxPlanco.Open;

    Result := (qryAuxPlanco.RecordCount > 0);
    FreeAndNil(qryAuxPlanco);
  end else
    Result:= False;
end;

function TfrmCfgEfdSpedContribuicao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodCtaF150) Then
  Begin
    If fEmptyStr(edtCodCtaF150.Text) Then
    Begin
      edtCodCtaF150.Clear;
    End
    Else
    Begin
      If fEmptyStr(fRetornaPlanoContabil(edtCodCtaF150.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Plano contábil inexistente!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = mskCodConJur) Then
  Begin
    if Not fEmptyStr(fSemMascaraPlaNco(mskCodConJur.Text)) then
    begin
      pCarregaPlanoContabilJur(blnBuscaPorChave) ;
      If (Not fEmptyStr(fSemMascaraPlaNco(mskCodConJur.Text))) And (fEmptyStr(edtDesConJur.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Conta Inválida de Plano Contábil sobre Juros Recebidos!',['&OK']);
        Result := False;
      End;
    end;
  End
  Else If (Sender = mskCodConDes) Then
  Begin
    if Not fEmptyStr(fSemMascaraPlaNco(mskCodConDes.Text)) then
    begin
      pCarregaPlanoContabilDes(blnBuscaPorChave) ;
      If (Not fEmptyStr(fSemMascaraPlaNco(mskCodConDes.Text))) And (fEmptyStr(edtDesConDes.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Conta Inválida de Plano Contábil sobre Descontos Obtidos!',['&OK']);
        Result := False;
      End;
    end;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCfgEfdSpedContribuicao.mskCodConJurKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrPlan: TConsultasArray;
  qryTplAco : TUniQuery;
begin
  Try
    qryTplAco := fCriaQuery(Self);
    qryTplAco.SQL.Add('SELECT EMP_TPLACO FROM CADEMP WHERE EMP_CODEMP = ' + VS_strCodEmp);
    qryTplAco.Open;
    If fPesqPlanoContabil(Self, mskCodConJur, edtDesConJur, Nil, Key, arrPlan, True, qryTplAco.FieldByName('EMP_TPLACO').asString) Then
      SelectNext(ActiveControl, True, True);
  Finally
    qryTplAco.Close;
    FreeAndNil(qryTplAco);
  End;
end;

procedure TfrmCfgEfdSpedContribuicao.mskCodConDesKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrPlan: TConsultasArray;
  qryTplAco : TUniQuery;
begin
  Try
    qryTplAco := fCriaQuery(Self);
    qryTplAco.SQL.Add('SELECT EMP_TPLACO FROM CADEMP WHERE EMP_CODEMP = ' + VS_strCodEmp);
    qryTplAco.Open;
    If fPesqPlanoContabil(Self, mskCodConDes, edtDesConDes, Nil, Key, arrPlan, True, qryTplAco.FieldByName('EMP_TPLACO').asString) Then
      SelectNext(ActiveControl, True, True);
  Finally
    qryTplAco.Close;
    FreeAndNil(qryTplAco);
  End;
end;

procedure TfrmCfgEfdSpedContribuicao.pAlimentaObjetosEmTelaComBaseNoBancoDados;
begin

  cmbNaturezaCreditoFreteD101.Items.Append('01-Aquisição de bens para revenda');
  cmbNaturezaCreditoFreteD101.Items.Append('02-Aquisição de bens como insumo');
  cmbNaturezaCreditoFreteD101.Items.Append('03-Aquisição de serviços para insumo');
  cmbNaturezaCreditoFreteD101.Items.Append('04-Energia elétrica');
  cmbNaturezaCreditoFreteD101.Items.Append('05-Aluguéis de prédios');
  cmbNaturezaCreditoFreteD101.Items.Append('06-Aluguéis de máquinas e equipamentos');
  cmbNaturezaCreditoFreteD101.Items.Append('07-Armazenagem de mercadoria e frete na operação de venda');
  cmbNaturezaCreditoFreteD101.Items.Append('12-Devolução de vendas');
  cmbNaturezaCreditoFreteD101.Items.Append('13-Outras operações');
  cmbNaturezaCreditoFreteD101.Items.Append('14-Atividade de transporte de cargas');

  chkEnviarDadosEmpresaAnteriorSpedPisCof.Checked   := IIF(fRetConfiguracao(VS_strCodEmp, 'ENVIAR_DADOS_EMPANT') = '1', True, False);
  chkEnviarFixo1RegA100Campo13.Checked              := IIF(fRetConfiguracao(VS_strCodEmp, 'ENVIAR_FIXO_1_REGA100_CAMPO13') = 'S', True, False);
  chkEnviaRegC180.Checked                           := IIF(fRetConfiguracao(VS_strCodEmp, 'REG_C180') = '1', True, False);
  chkReg0500ContasFixas.Checked                     := IIF(fRetConfiguracao(VS_strCodEmp, 'UTILIZAR_CONTA_FIXA_REG0500') = 'S', True, False);
  chkUtilizarRotinaAbreviacaoContabil.Checked       := IIF(fRetConfiguracao(VS_strCodEmp, 'USAR_ABREVIACAO_CONTABIL_REG_0500') = 'S', True, False);

  edtCodSerCampo11Reg0200.Text                      := fRetConfiguracao(VS_strCodEmp, 'CODSERV_CAMPO11_REG0200');
  edtCodRecPisCumulativo.Text                       := fRetConfiguracao(VS_strCodEmp, 'CODIGO_RECEITA_PIS_CUMULATIVO');
  edtCodRecCofinsCumulativo.Text                    := fRetConfiguracao(VS_strCodEmp, 'CODIGO_RECEITA_COFINS_CUMULATIVO');
  edtCodRecPis.Text                                 := fRetConfiguracao(VS_strCodEmp, 'CODIGO_RECEITA_PIS');
  edtCodRecCofins.Text                              := fRetConfiguracao(VS_strCodEmp, 'CODIGO_RECEITA_COFINS');
  edtContaAnaliticaReg0500Entrada.Text              := fRetConfiguracao(VS_strCodEmp, 'CONTA_ANALITICA_REG0500_ENTRADA');
  edtContaAnaliticaReg0500Saida.Text                := fRetConfiguracao(VS_strCodEmp, 'CONTA_ANALITICA_REG0500_SAIDA');
  edtCodCtaF150.Text                                := fRetConfiguracao(VS_strCodEmp, 'COD_CTA_REGF150');
  chkPIS_COFINS_LEI_224_2025.Checked                := IIF(fRetConfiguracao(VS_strCodEmp, 'PIS_COFINS_LEI_224_2025') = 'S', True, False);

  chkUtilizarRotinaAbreviacaoContabil.Enabled       := False;
  if (fRetornaPlanco) and (Trim(fCfgSis('UTICON')) = 'S') then
    chkUtilizarRotinaAbreviacaoContabil.Enabled     := True;

  cmbNaturezaCreditoFreteD101.ItemIndex := fRetornaPosicaoNaturezaCreditoFrete(fRetConfiguracao(VS_strCodEmp, 'NATUREZA_CREDITO_FRETE'));

  edtCSTPISJur.Text := fRetConfiguracao(VS_strCodEmp, 'CSTPIS_JUROS_RECEBIDOS');
  edtALQPISJur.Text := fRetConfiguracao(VS_strCodEmp, 'ALQPIS_JUROS_RECEBIDOS');
  edtCSTCOFJur.Text := fRetConfiguracao(VS_strCodEmp, 'CSTCOF_JUROS_RECEBIDOS');
  edtALQCOFJur.Text := fRetConfiguracao(VS_strCodEmp, 'ALQCOF_JUROS_RECEBIDOS');
  mskCodConJur.Text := fRetConfiguracao(VS_strCodEmp, 'PLANCO_JUROS_RECEBIDOS');

  edtCSTPISDes.Text := fRetConfiguracao(VS_strCodEmp, 'CSTPIS_DESCONTOS_OBTIDOS');
  edtALQPISDes.Text := fRetConfiguracao(VS_strCodEmp, 'ALQPIS_DESCONTOS_OBTIDOS');
  edtCSTCOFDes.Text := fRetConfiguracao(VS_strCodEmp, 'CSTCOF_DESCONTOS_OBTIDOS');
  edtALQCOFDes.Text := fRetConfiguracao(VS_strCodEmp, 'ALQCOF_DESCONTOS_OBTIDOS');
  mskCodConDes.Text := fRetConfiguracao(VS_strCodEmp, 'PLANCO_DESCONTOS_OBTIDOS');

end;

procedure TfrmCfgEfdSpedContribuicao.pGeraConfiguracoesBancoDeDados(strCodEmp,
  strCodCfg, strCdCfAb, strUtiBlc, strPriori, strDescri, strRegNeg, strValCfg,
  strGruCfg: string; intNumHlp: Integer; dtaUltAlt: TDate; hraUltAlt: TTime;
  strLayout: string);
  var
    Hora, Min, Sec, MSec : Word;
    strHraUltAlt: string;
begin
  DecodeTime(fNow, Hora, Min, Sec, MSec);
  strHraUltAlt := FormatDateTime('hh:mm:ss', hraUltAlt) + ':' + FormatFloat('000', MSec);

  qryAux.Close;
  qryAux.SQL.Clear;
  qryAux.SQL.Add( ' INSERT INTO CFGSPD ( ');
  qryAux.SQL.Add( '   SPD_CODEMP, ');
  qryAux.SQL.Add( '   SPD_CODCFG, ');
  qryAux.SQL.Add( '   SPD_CDCFAB, ');
  qryAux.SQL.Add( '   SPD_UTIBLC, ');
  qryAux.SQL.Add( '   SPD_PRIORI, ');
  qryAux.SQL.Add( '   SPD_DESCRI, ');
  qryAux.SQL.Add( '   SPD_REGNEG, ');
  qryAux.SQL.Add( '   SPD_VALCFG, ');
  qryAux.SQL.Add( '   SPD_GRUCFG, ');
  qryAux.SQL.Add( '   SPD_NUMHLP, ');
  qryAux.SQL.Add( '   SPD_ULTALT, ');
  qryAux.SQL.Add( '   SPD_CODGEN, ');
  qryAux.SQL.Add( '   SPD_LAYOUT ');
  qryAux.SQL.Add( ' ) ');
  qryAux.SQL.Add( ' VALUES ');
  qryAux.SQL.Add( '   ( ');
  qryAux.SQL.Add( '     :CODEMP, ');
  qryAux.SQL.Add( '     :CODCFG, ');
  qryAux.SQL.Add( '     :CDCFAB, ');
  qryAux.SQL.Add( '     :UTIBLC, ');
  qryAux.SQL.Add( '     :PRIORI, ');
  qryAux.SQL.Add( '     :DESCRI, ');
  qryAux.SQL.Add( '     :REGNEG, ');
  qryAux.SQL.Add( '     :VALCFG, ');
  qryAux.SQL.Add( '     :GRUCFG, ');
  qryAux.SQL.Add( '     :NUMHLP, ');
  qryAux.SQL.Add( '     :ULTALT, ');
  qryAux.SQL.Add( '     :CODGEN, ');
  qryAux.SQL.Add( '     :LAYOUT ');
  qryAux.SQL.Add( '   ) ');

  qryAux.ParamByName('CODEMP').AsString  := strCodEmp;
  qryAux.ParamByName('CODCFG').AsString  := strCodCfg;
  qryAux.ParamByName('CDCFAB').AsString  := strCdCfAb;
  qryAux.ParamByName('UTIBLC').AsString  := strUtiBlc;
  qryAux.ParamByName('PRIORI').AsString  := strPriori;
  qryAux.ParamByName('DESCRI').AsString  := strDescri;
  qryAux.ParamByName('REGNEG').AsString  := strRegNeg;
  qryAux.ParamByName('VALCFG').AsString  := strValCfg;
  qryAux.ParamByName('GRUCFG').AsString  := strGruCfg;
  qryAux.ParamByName('NUMHLP').AsInteger := intNumHlp;
  qryAux.ParamByName('ULTALT').AsDate    := dtaUltAlt;
  qryAux.ParamByName('CODGEN').AsString  := strHraUltAlt;
  qryAux.ParamByName('LAYOUT').AsString  := strLayout;
  qryAux.ExecSQL;

end;

procedure TfrmCfgEfdSpedContribuicao.pGravarNoBancoDadosComBaseEmObjetosDeTela;
begin
  fStartTransaction;
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarDadosEmpresaAnteriorSpedPisCof.Checked, '1', '0')  + '" WHERE SPD_CODCFG = "ENVIAR_DADOS_EMPANT" AND SPD_CODEMP = "'                + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarFixo1RegA100Campo13.Checked, 'S', 'N')             + '" WHERE SPD_CODCFG = "ENVIAR_FIXO_1_REGA100_CAMPO13" AND SPD_CODEMP = "'      + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviaRegC180.Checked, '1', '0')                          + '" WHERE SPD_CODCFG = "REG_C180" AND SPD_CODEMP = "'                           + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodSerCampo11Reg0200.Text                                    + '" WHERE SPD_CODCFG = "CODSERV_CAMPO11_REG0200" AND SPD_CODEMP = "'            + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodRecPisCumulativo.Text                                     + '" WHERE SPD_CODCFG = "CODIGO_RECEITA_PIS_CUMULATIVO" AND SPD_CODEMP = "'      + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodRecCofinsCumulativo.Text                                  + '" WHERE SPD_CODCFG = "CODIGO_RECEITA_COFINS_CUMULATIVO" AND SPD_CODEMP = "'   + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodRecPis.Text                                               + '" WHERE SPD_CODCFG = "CODIGO_RECEITA_PIS" AND SPD_CODEMP = "'                 + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodRecCofins.Text                                            + '" WHERE SPD_CODCFG = "CODIGO_RECEITA_COFINS" AND SPD_CODEMP = "'              + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkReg0500ContasFixas.Checked, 'S', 'N')                    + '" WHERE SPD_CODCFG = "UTILIZAR_CONTA_FIXA_REG0500" AND SPD_CODEMP = "'        + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtContaAnaliticaReg0500Entrada.Text                            + '" WHERE SPD_CODCFG = "CONTA_ANALITICA_REG0500_ENTRADA" AND SPD_CODEMP = "'    + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtContaAnaliticaReg0500Saida.Text                              + '" WHERE SPD_CODCFG = "CONTA_ANALITICA_REG0500_SAIDA" AND SPD_CODEMP = "'      + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkUtilizarRotinaAbreviacaoContabil.Checked, 'S', 'N')      + '" WHERE SPD_CODCFG = "USAR_ABREVIACAO_CONTABIL_REG_0500" AND SPD_CODEMP = "'  + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + fRetornaCodNaturezaCreditoFrete                                 + '" WHERE SPD_CODCFG = "NATUREZA_CREDITO_FRETE" AND SPD_CODEMP = "'             + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodCtaF150.Text                                              + '" WHERE SPD_CODCFG = "COD_CTA_REGF150" AND SPD_CODEMP = "'                    + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkPIS_COFINS_LEI_224_2025.Checked, 'S', 'N')               + '" WHERE SPD_CODCFG = "PIS_COFINS_LEI_224_2025" AND SPD_CODEMP = "'            + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCSTPISJur.Text                                               + '" WHERE SPD_CODCFG = "CSTPIS_JUROS_RECEBIDOS" AND SPD_CODEMP = "'             + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtALQPISJur.Text                                               + '" WHERE SPD_CODCFG = "ALQPIS_JUROS_RECEBIDOS" AND SPD_CODEMP = "'             + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCSTCOFJur.Text                                               + '" WHERE SPD_CODCFG = "CSTCOF_JUROS_RECEBIDOS" AND SPD_CODEMP = "'             + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtALQCOFJur.Text                                               + '" WHERE SPD_CODCFG = "ALQCOF_JUROS_RECEBIDOS" AND SPD_CODEMP = "'             + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + fSemMascaraPlaNco(mskCodConJur.Text)                            + '" WHERE SPD_CODCFG = "PLANCO_JUROS_RECEBIDOS" AND SPD_CODEMP = "'             + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCSTPISDes.Text                                               + '" WHERE SPD_CODCFG = "CSTPIS_DESCONTOS_OBTIDOS" AND SPD_CODEMP = "'           + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtALQPISDes.Text                                               + '" WHERE SPD_CODCFG = "ALQPIS_DESCONTOS_OBTIDOS" AND SPD_CODEMP = "'           + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCSTCOFDes.Text                                               + '" WHERE SPD_CODCFG = "CSTCOF_DESCONTOS_OBTIDOS" AND SPD_CODEMP = "'           + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtALQCOFDes.Text                                               + '" WHERE SPD_CODCFG = "ALQCOF_DESCONTOS_OBTIDOS" AND SPD_CODEMP = "'           + VS_strCodEmp + '";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + fSemMascaraPlaNco(mskCodConDes.Text)                            + '" WHERE SPD_CODCFG = "PLANCO_DESCONTOS_OBTIDOS" AND SPD_CODEMP = "'           + VS_strCodEmp + '";');
    qryAux.ExecSQL;
    fCommit;
  except
    fRollBack;
    raise;
  end;
end;

procedure TfrmCfgEfdSpedContribuicao.pHabilitaDesabilitaObjetosEmTela;
begin
  btnIncluir.Visible  := False;
  btnAlterar.Visible  := False;
  btnExcluir.Visible  := False;
  btnCancela.Visible  := False;
  btnPesquisa.Visible := False;
  btnGravar.Enabled   := True;

  chkEnviarDadosEmpresaAnteriorSpedPisCof.Enabled      := btnGravar.Enabled;
  chkEnviarFixo1RegA100Campo13.Enabled                 := btnGravar.Enabled;
  chkEnviaRegC180.Enabled                              := btnGravar.Enabled;
  chkReg0500ContasFixas.Enabled                        := btnGravar.Enabled;

  edtCodSerCampo11Reg0200.Enabled                      := btnGravar.Enabled;
  edtCodRecPisCumulativo.Enabled                       := btnGravar.Enabled;
  edtCodRecCofinsCumulativo.Enabled                    := btnGravar.Enabled;
  edtCodRecPis.Enabled                                 := btnGravar.Enabled;
  edtCodRecCofins.Enabled                              := btnGravar.Enabled;
  edtContaAnaliticaReg0500Entrada.Enabled              := btnGravar.Enabled;
  edtContaAnaliticaReg0500Saida.Enabled                := btnGravar.Enabled;
  edtCodCtaF150.Enabled                                := btnGravar.Enabled;
  chkPIS_COFINS_LEI_224_2025.Enabled                   := btnGravar.Enabled;

  edtCSTPISJur.Enabled                                 := btnGravar.Enabled;
  edtALQPISJur.Enabled                                 := btnGravar.Enabled;
  edtCSTCOFJur.Enabled                                 := btnGravar.Enabled;
  edtALQCOFJur.Enabled                                 := btnGravar.Enabled;
  mskCodConJur.Enabled                                 := btnGravar.Enabled;
  edtCSTPISDes.Enabled                                 := btnGravar.Enabled;
  edtALQPISDes.Enabled                                 := btnGravar.Enabled;
  edtCSTCOFDes.Enabled                                 := btnGravar.Enabled;
  edtALQCOFDes.Enabled                                 := btnGravar.Enabled;
  mskCodConDes.Enabled                                 := btnGravar.Enabled;
end;

procedure TfrmCfgEfdSpedContribuicao.pInicializaIndices;
begin
  inherited;
end;

procedure TfrmCfgEfdSpedContribuicao.pCriaConfiguracoesBancoDeDadosDefault;
begin
  {CONFIGURAÇÕES REFERENTE A GERAÇÃO DO ARQUIVO DO PIS E DA COFINS}
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'CONTA_ANALITICA_REG0500_ENTRADA')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CONTA_ANALITICA_REG0500_ENTRADA',   'CFG_CARENT', '', '', 'Conta Analitica Registros 0500 Movimentação de Entrada',                      '', '', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'CONTA_ANALITICA_REG0500_SAIDA')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CONTA_ANALITICA_REG0500_SAIDA',     'CFG_CARSAI', '', '', 'Conta Analitica Registros 0500 Movimentação de Saida',                        '', '', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'CODSERV_CAMPO11_REG0200')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CODSERV_CAMPO11_REG0200',           'CFG_CSCPRG', '', '', 'Enviar Código de Serviço Registro 0200 Campo 11',                             '', '', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'CODIGO_RECEITA_PIS_CUMULATIVO')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CODIGO_RECEITA_PIS_CUMULATIVO',     'CFG_CDRPIC', '', '', 'Código da Receita Cumulativo Pis',                                            '', '', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'CODIGO_RECEITA_COFINS_CUMULATIVO')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CODIGO_RECEITA_COFINS_CUMULATIVO',  'CFG_CDRCOC', '', '', 'Código da Receita Cumulativo Cofins',                                         '', '', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'CODIGO_RECEITA_PIS')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CODIGO_RECEITA_PIS',                'CFG_CDRPIS', '', '', 'Código da Receita Não-Cumulativo Pis',                                        '', '', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'CODIGO_RECEITA_COFINS')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CODIGO_RECEITA_COFINS',             'CFG_CDRCOF', '', '', 'Código da Receita Não-Cumulativo Cofins',                                     '', '', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'USAR_ABREVIACAO_CONTABIL_REG_0500')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'USAR_ABREVIACAO_CONTABIL_REG_0500', 'CFG_UACTRG', '', '', 'Usar Abreviação Contabil nos Registros 0500',                                 '','N', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'UTILIZAR_CONTA_FIXA_REG0500')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'UTILIZAR_CONTA_FIXA_REG0500',       'CFG_UTCTFX', '', '', 'Utilizar Conta Fixa dos Registro 0500',                                       '','N', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'ENVIAR_DADOS_EMPANT')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_DADOS_EMPANT',               'CFG_EDEMPA', '', '', 'Enviar dados de Empresas Anteriores 1=Sim 0=Não',                             '','0', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'REG_C180')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'REG_C180',                          'CFG_RG0180', '', '', 'Enviar Registro C180 e Filhos 1=Sim 0=Não',                                   '','0', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'ENVIAR_FIXO_1_REGA100_CAMPO13')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_FIXO_1_REGA100_CAMPO13',     'CFG_EF1CP1', '', '', 'Enviar 1 como valor fixo no Registro A100 Campo 13 Movimentação de Entradas', '','N', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'NATUREZA_CREDITO_FRETE')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'NATUREZA_CREDITO_FRETE',            'CFG_NATFRE', '', '', 'Natureza Crédito (Frete)',                                                    '',VS_STR_NATUREZA_CREDITO_FRETE, 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'COD_CTA_REGF150')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'COD_CTA_REGF150',                   'CFG_CCACDC', '', '', 'Código da conta analítica contábil debitada/creditada',                       '', '', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'PIS_COFINS_LEI_224_2025')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'PIS_COFINS_LEI_224_2025',           'CFG_GAPCNT', '', '', 'Gerar Apuração de PIS e COFINS conforme Nota Técnica 12/2026 referente à Lei Complementar Nº 224/2025', '', 'N', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'CSTPIS_JUROS_RECEBIDOS')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CSTPIS_JUROS_RECEBIDOS',            'CFG_CPJURE', '', '', 'Despesas Finaceiras - CST PIS sobre Juros Recebidos',                         '', '01', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'ALQPIS_JUROS_RECEBIDOS')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ALQPIS_JUROS_RECEBIDOS',            'CFG_APJURE', '', '', 'Despesas Finaceiras - ALQ PIS sobre Juros Recebidos',                         '', '0.65', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'CSTCOF_JUROS_RECEBIDOS')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CSTCOF_JUROS_RECEBIDOS',            'CFG_CCJURE', '', '', 'Despesas Finaceiras - CST COFINS sobre Juros Recebidos',                      '', '01', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'ALQCOF_JUROS_RECEBIDOS')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ALQCOF_JUROS_RECEBIDOS',            'CFG_ACJURE', '', '', 'Despesas Finaceiras - ALQ COFINS sobre Juros Recebidos',                      '', '3.00', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'PLANCO_JUROS_RECEBIDOS')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'PLANCO_JUROS_RECEBIDOS',            'CFG_PCJURE', '', '', 'Despesas Finaceiras - Plano Contábil sobre Juros Recebidos',                  '', '', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'CSTPIS_DESCONTOS_OBTIDOS')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CSTPIS_DESCONTOS_OBTIDOS',          'CFG_CPDEOB', '', '', 'Despesas Finaceiras - CST PIS sobre Descontos Obtidos',                       '', '01', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'ALQPIS_DESCONTOS_OBTIDOS')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ALQPIS_DESCONTOS_OBTIDOS',          'CFG_APDEOB', '', '', 'Despesas Finaceiras - ALQ PIS sobre Descontos Obtidos',                       '', '0.65', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'CSTCOF_DESCONTOS_OBTIDOS')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CSTCOF_DESCONTOS_OBTIDOS',          'CFG_CCDEOB', '', '', 'Despesas Finaceiras - CST COFINS sobre Descontos Obtidos',                    '', '01', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'ALQCOF_DESCONTOS_OBTIDOS')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ALQCOF_DESCONTOS_OBTIDOS',          'CFG_ACDEOB', '', '', 'Despesas Finaceiras - ALQ COFINS sobre Descontos Obtidos',                    '', '3.00', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');
  if (not fRetExisteConfiguracao(VS_strCodEmp, 'PLANCO_DESCONTOS_OBTIDOS')) then
    pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'PLANCO_DESCONTOS_OBTIDOS',          'CFG_PCDEOB', '', '', 'Despesas Finaceiras - Plano Contábil sobre Descontos Obtidos',                '', '', 'CONFIGURACOES-PIS_COFINS', 0, Date, fTime(), 'S');

end;

procedure TfrmCfgEfdSpedContribuicao.pCriaTabelaConfiguracoesBancoDeDados;
begin

  if not fTabelaExiste('CFGSPD', True) then
  begin

    try

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('CREATE TABLE IF NOT EXISTS CFGSPD (');
      qryAux.SQL.Add('  SPD_CODEMP CHAR(3) NOT NULL DEFAULT "",');
      qryAux.SQL.Add('  SPD_CODCFG VARCHAR (140) CHARACTER SET utf8 NOT NULL DEFAULT "",');
      qryAux.SQL.Add('  SPD_CDCFAB VARCHAR (20) CHARACTER SET utf8 DEFAULT NULL,');
      qryAux.SQL.Add('  SPD_UTIBLC VARCHAR (20) CHARACTER SET utf8 DEFAULT NULL,');
      qryAux.SQL.Add('  SPD_PRIORI VARCHAR (20) CHARACTER SET utf8 DEFAULT NULL,');
      qryAux.SQL.Add('  SPD_DESCRI VARCHAR (355) CHARACTER SET utf8 DEFAULT NULL,');
      qryAux.SQL.Add('  SPD_REGNEG TEXT CHARACTER SET utf8 DEFAULT NULL,');
      qryAux.SQL.Add('  SPD_VALCFG TEXT CHARACTER SET utf8 DEFAULT NULL,');
      qryAux.SQL.Add('  SPD_GRUCFG VARCHAR (255) CHARACTER SET utf8 DEFAULT NULL,');
      qryAux.SQL.Add('  SPD_NUMHLP INT (11) DEFAULT NULL,');
      qryAux.SQL.Add('  SPD_ULTALT DATE DEFAULT NULL,');
      qryAux.SQL.Add('  SPD_CODGEN VARCHAR (20) DEFAULT NULL,');
      qryAux.SQL.Add('  SPD_LAYOUT CHAR(1) DEFAULT NULL,');
      qryAux.SQL.Add('  SPD_EXICFG CHAR(1) DEFAULT NULL,');
      qryAux.SQL.Add('  PRIMARY KEY (SPD_CODEMP, SPD_CODCFG),');
      qryAux.SQL.Add('  KEY IDX_CFGSPD_ULTALT (SPD_ULTALT)');
      qryAux.SQL.Add('  ) ENGINE = INNODB DEFAULT CHARSET = latin1');
      qryAux.ExecSQL;

      pCriaConfiguracoesBancoDeDadosDefault;

    except

      On E: Exception Do
      Begin
        fMensagem('ATENÇÃO!', 'Ocorreu problemas na criação das configurações em seu banco de dados, ' + e.Message, ['&Ok']);
        pnlConfiguracaoSpedContribuicao.Enabled := False;
      End;

    end;

  end
  else
  begin

    pCriaConfiguracoesBancoDeDadosDefault;

  end;

end;

end.
