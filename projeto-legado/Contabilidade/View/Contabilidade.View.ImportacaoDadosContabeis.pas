unit Contabilidade.View.ImportacaoDadosContabeis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiConfirmaContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Contabilidade.Interfaces, untExcel,
  Contabilidade.Classes.TImportacaoDadosContabeis, Data.DB, MemDS, DBAccess,
  Uni, UniClientDataset, cxProgressBar, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, cxTextEdit, cxMaskEdit,
  cxDropDownEdit;

type
  TfrmImportacoesContabeis = class(TfrmPaiConfirmaContabilidade)
    btnGerarModelo: TBitBtnLocked;
    ckbIgnorarErrosImportacao: TCheckBox;
    cbEcf: TcxComboBox;
    lbEcf: TcxLabel;
    rgOpcoes: TRadioGroup;
    btnHelp: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnGerarModeloClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    FobjExcel   : TExcel;
    FImportacaoDadosContabeis: TImportacaoDadosContabeis;
    FCdsTotPlanco: TUniClientDataSet;
    function fConfirmar(pgbProgresso: TcxProgressBar): Boolean;
    function fTravouImportacao: boolean;
    procedure pDestravaImportacao;
    function fgetDescrImportacao:string ;
    procedure pCarregaRegistrosECF(const ATipo:string) ;
    procedure pCarregaRegistrosTotPlanco;
    procedure pLimpaCbECF ;
    procedure pMostraCbECF(const AMostrar:boolean) ;
    procedure pMostraOpcoesLancon ;
    function fRetornaRegistro:string ;
    function fRetornaBloco:string ;
    function fRetornaTipLan: String ;
    function fCreateImportacaoDadosContabeis(ApgbProgresso: TcxProgressBar = Nil): IImportacaoDadosContabeis ;
    procedure pMostraTotPlanco;
    function fMoverArquivoParaIportados(const ACaminhoArquivo: String): String ;
    function fPodeMoverArquivo: Boolean ;
    { Private declarations }
  public
    { Public declarations }
    property ImportacaoDadosContabeis : TImportacaoDadosContabeis  read FImportacaoDadosContabeis write FImportacaoDadosContabeis;
    property CdsTotPlanco: TUniClientDataSet read FCdsTotPlanco write FCdsTotPlanco;
  end;

implementation

uses untFuncoesSimples, Contabilidade.Classes.TImportacaoDadosContabeisFactory,
Contabilidade.Funcoes, Contabilidade.Classes.TEcf, Contabilidade.Classes.TControleContabilidade,
Contabilidade.View.TotalPlanco, IOUtils, Contabilidade.View.MemoInfo;

{$R *.dfm}

procedure TfrmImportacoesContabeis.btnHelpClick(Sender: TObject);
var
  LfrmMemoInfo: TfrmMemoInfo;
begin
  inherited;
  pCriarFormularios(TfrmMemoInfo, LfrmMemoInfo) ;
  try
    LfrmMemoInfo.NomeRelExport := 'Rel_Inst_Imp_PlanoContas.pdf';
    LfrmMemoInfo.Width := 1300;
    LfrmMemoInfo.Height := 550;
    LfrmMemoInfo.edtInfo.Lines.Add('Instruções para preenchimento da Planilha para Importação do Plano de Contas Contábil:');
    LfrmMemoInfo.edtInfo.Lines.Add('======================================================================================');
    LfrmMemoInfo.edtInfo.Lines.Add(' ');
    LfrmMemoInfo.edtInfo.Lines.Add('- A planilha deverá ser preenchida em sua totalidade pelo Formato "Texto".');
    LfrmMemoInfo.edtInfo.Lines.Add('- Não poderá haver linhas em "branco" na Planilha. ');
    LfrmMemoInfo.edtInfo.Lines.Add('- Os Títulos das Colunas da Planilha não poderão ser alterados. ');
    LfrmMemoInfo.edtInfo.Lines.Add(' ');
    LfrmMemoInfo.edtInfo.Lines.Add('Observação: Pontos que não estiverem de acordo com os descritos acima, impossibilitarão a importação da Planilha. ');
    LfrmMemoInfo.edtInfo.Lines.Add(' ');
    LfrmMemoInfo.edtInfo.Lines.Add(' ');
    LfrmMemoInfo.edtInfo.Lines.Add('Estrutura das Colunas a serem preenchidas: ');
    LfrmMemoInfo.edtInfo.Lines.Add('========================================== ');
    LfrmMemoInfo.edtInfo.Lines.Add(' ');
    LfrmMemoInfo.edtInfo.Lines.Add('- CLASSIFICAÇÃO CONTÁBIL: Código da Conta Contábil, separada por pontos, de acordo com a estrutura em número de graus desejada pela empresa (Ex: 1.01.01.01.001). ');
    LfrmMemoInfo.edtInfo.Lines.Add('- DESCRIÇÃO DA CONTA: Descrição da Conta Contábil. ');
    LfrmMemoInfo.edtInfo.Lines.Add('- CONTA REDUZIDA: Código da Conta Reduzida da Conta Contábil. ');
    LfrmMemoInfo.edtInfo.Lines.Add('- TIPO DO PLANO DE CONTAS: Deverá ser preenchido de acordo com o código/número do Tipo de Plano de Contas (dúvidas, consultar o Suporte da Citel). ');
    LfrmMemoInfo.edtInfo.Lines.Add('- APURAÇÃO: Essa coluna poderá ficar em branco. ');
    LfrmMemoInfo.edtInfo.Lines.Add('- NATUREZA: Deverá ser preenchido de acordo com a Natureza da Conta Contábil. Para contas de Natureza Sintética (S), para contas de Natureza Analítica (A). ');
    LfrmMemoInfo.edtInfo.Lines.Add('- FINALIDADE: Deverá ser preenchido de acordo com a Finalidade da Conta Contábil. Para contas Devedoras (D), para contas Credoras (C). ');
    LfrmMemoInfo.edtInfo.Lines.Add('- CONTA REFERENCIAL: Vinculação da Classificação da Conta Contábil de acordo com o Plano de Contas Referencial da Receita Federal (Dispensado para Empresas do Simples Nacional). ');
    LfrmMemoInfo.edtInfo.Lines.Add('- REDUTORA: Se a Conta Contábil é uma Conta Redutora (Exemplo: Depreciação, é uma conta Redutora do Ativo) (S), se não for uma Conta Redutora (N). ');
    LfrmMemoInfo.edtInfo.Lines.Add('- PATRIMONIAL: Se a Conta Contábil for uma Conta Patrimonial (Ativo/Passivo) (S), se for uma Conta de Resultados (N). ');
    LfrmMemoInfo.edtInfo.Lines.Add(' ');

    LfrmMemoInfo.btnSair.Visible := False;
    LfrmMemoInfo.btnExportar.Visible := True;
    LfrmMemoInfo.ShowModal ;
   finally
    pFreeAndNil(LfrmMemoInfo) ;
  end ;

end;

procedure TfrmImportacoesContabeis.btnConfirmaClick(Sender: TObject);
Var
  dlgOpen    : TOpenDialog;
  LCaminho : String;
  LSucesso : Boolean;
  LMsgMovimentoArquivo : String;
begin
  //inherited;
  LSucesso := False ;

  if FImportacaoDadosContabeis in [tidcDemonstrativoECF, tidcPlanoReferencial] then
  begin
    if cbEcf.ItemIndex = -1 then
    begin
      fMensagem('ATENÇÃO','Registro ECF não selecionado!',['&OK']);
      pSetFocus(cbEcf);
      exit ;
    end;
  end;

  if not fTravouImportacao then
  begin
    pDestravaImportacao;
    Exit;
  end;

  if FImportacaoDadosContabeis = tidcSaldosIniciaisSubconta then
    pMostraTotPlanco;

  try
    dlgOpen     := TOpenDialog.Create(Self);
    dlgOpen.Filter := 'Arquivos do Excel|*.xls;*.xlsx';

    If dlgOpen.Execute Then
    Begin
      LCaminho := dlgOpen.FileName ;
      if FobjExcel.AbrirArquivo(LCaminho) then
      begin
        LSucesso := fChamaTelaGravando(fConfirmar) ;
        FobjExcel.FecharArquivo;
      end ;
    End;
  Finally
    pDestravaImportacao;
    FreeAndNil(dlgOpen);
  End;

  if LSucesso and fPodeMoverArquivo then
  begin
    LMsgMovimentoArquivo := fMoverArquivoParaIportados(LCaminho) ;
    if not fEmptyStr(LMsgMovimentoArquivo) then
      fMensagem('ATENÇÃO',LMsgMovimentoArquivo,['&OK']);
  end ;

end;

procedure TfrmImportacoesContabeis.btnGerarModeloClick(Sender: TObject);
var
  objExcel : TExcel;
  intCnt : integer ;
  LListaInfoColunas : TListInfoColunaDadosContabeis;
begin
  inherited;
  if FImportacaoDadosContabeis = tidcDemonstrativoECF then
  begin
    if cbEcf.ItemIndex = -1 then
    begin
      fMensagem('ATENÇÃO','Registro ECF não selecionado!',['&OK']);
      pSetFocus(cbEcf);
      exit ;
    end;
  end;

  objExcel := TExcel.fCriarExcel(Self);
  try
    If Not objExcel.CriarArquivo Then
    begin
      Exit;
    End;

    objExcel.ProximaLinha;
    LListaInfoColunas := fCreateImportacaoDadosContabeis.fColunas ;
    for intCnt := 0 to LListaInfoColunas.Count-1 do
    begin
      objExcel.Escrever(objExcel.LinhaAtual, intCnt+1, LListaInfoColunas.Items[intCnt].Descricao);
    end;

    objExcel.AutoAjuste;
    objExcel.SalvarArquivo;
    objExcel.FecharArquivo;
  finally
    FreeAndNil(objExcel);
  end;

  fMensagem('ATENÇÃO','Arquivo gerado com sucesso!',['&OK']);

end;

function TfrmImportacoesContabeis.fConfirmar(
  pgbProgresso: TcxProgressBar): Boolean;
var
  objImportacaoDados : IImportacaoDadosContabeis;
begin
  objImportacaoDados := fCreateImportacaoDadosContabeis(pgbProgresso) ;
  result := objImportacaoDados.fCarregaDadosPlanilha(TMostraMensagemErroValidacao.pMostra) ;
  if result then
  begin
    result := objImportacaoDados.fPersisteDados ;
  end;
end;

function TfrmImportacoesContabeis.fCreateImportacaoDadosContabeis(ApgbProgresso: TcxProgressBar = Nil): IImportacaoDadosContabeis;
begin
  result := TImportacaoDadosContabeisFactory.New.fImportacao(FImportacaoDadosContabeis,
                                                             ApgbProgresso,
                                                             FobjExcel,
                                                             ckbIgnorarErrosImportacao.Checked,
                                                             fRetornaRegistro,
                                                             fRetornaBloco,
                                                             fRetornaTipLan,
                                                             FCdsTotPlanco) ;
end;

function TfrmImportacoesContabeis.fgetDescrImportacao: string;
begin
  result := DES_IMPORTACAODADOSCONTABEIS[FImportacaoDadosContabeis] ;
end;

procedure TfrmImportacoesContabeis.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pLimpaCbECF ;
end;

procedure TfrmImportacoesContabeis.FormCreate(Sender: TObject);
begin
  inherited;
  FobjExcel := TExcel.fCriarExcel(Self);
  FobjExcel.blnShowOnTerminate := False ;
end;

procedure TfrmImportacoesContabeis.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FobjExcel) ;
  if Assigned(FCdsTotPlanco) then
    FreeAndNil(FCdsTotPlanco);
end;

procedure TfrmImportacoesContabeis.FormShow(Sender: TObject);
begin
  inherited;
  ckbIgnorarErrosImportacao.Visible := FImportacaoDadosContabeis <> tidcLancamentosContabeis ;
  if FImportacaoDadosContabeis = tidcPlanoReferencial then
  begin
    pCarregaRegistrosECF('P');
    pMostraCbECF(True);
  end
  else if FImportacaoDadosContabeis = tidcDemonstrativoECF then
  begin
    pCarregaRegistrosECF('D');
    pMostraCbECF(true);
  end
  else if FImportacaoDadosContabeis = tidcSaldosIniciaisSubconta then
  begin
    pCarregaRegistrosTotPlanco;
    pMostraCbECF(False);
  end
  else
  begin
    pMostraCbECF(False);
    if FImportacaoDadosContabeis = tidcLancamentosContabeis then
      pMostraOpcoesLancon ;
  end;
end;

function TfrmImportacoesContabeis.fPodeMoverArquivo: Boolean;
begin
  Result := FImportacaoDadosContabeis = tidcLancamentosContabeis ;
end;

function TfrmImportacoesContabeis.fRetornaBloco: string;
begin
  result := '' ;
  if FImportacaoDadosContabeis in [tidcDemonstrativoECF, tidcPlanoReferencial] then
  begin
    result := TInfoECF(cbEcf.Properties.Items.Objects[cbEcf.ItemIndex]).blc ;
  end;
end;

function TfrmImportacoesContabeis.fRetornaRegistro: string;
begin
  result := '' ;
  if FImportacaoDadosContabeis in [tidcDemonstrativoECF, tidcPlanoReferencial] then
  begin
    result := TInfoECF(cbEcf.Properties.Items.Objects[cbEcf.ItemIndex]).reg ;
  end;
end;

function TfrmImportacoesContabeis.fRetornaTipLan: String;
begin
  result := COD_TIPO_LANCAMENTO_LANCON[TTipoLancamentoImportacaoLancon(rgOpcoes.ItemIndex)] ;
end;

function TfrmImportacoesContabeis.fTravouImportacao: boolean;
var
  strTip : string ;
begin
  Result := True;
  strTip := fgetDescrImportacao ;
  if not fLock_Unlock('IMPORTACAO_'+strTip, True, False) then
  begin
    fMensagem('ATENÇÃO!', 'A rotina "Importação de Dados Contábeis - ' + strTip +
                          '" já está sendo utilizada por outra estação: ' +
                          fGetHostLock('IMPORTACAO_'+strTip), ['&Ok']);
    Result := False;
  end;
end;

procedure TfrmImportacoesContabeis.pCarregaRegistrosECF(const ATipo: string);
var
  qryEcf : TUniQuery ;
  info : TInfoECF ;
begin
  qryEcf := fCriaQuery() ;
  try
    qryEcf.Close ;
    qryEcf.SQL.Clear ;
    qryEcf.SQL.Add('SELECT REG_BLCECF, REG_REGECF FROM ECFREG WHERE REG_TIPREG = :TIPREG ORDER BY REG_BLCECF, REG_REGECF ') ;
    qryEcf.ParamByName('TIPREG').AsString := ATipo ;
    qryEcf.Open ;
    cbEcf.Properties.Items.Clear ;
    qryEcf.First ;
    while not qryEcf.Eof do
    begin
      info := TInfoECF.Create ;
      info.blc := qryEcf.FieldByName('REG_BLCECF').AsString ;
      info.reg := qryEcf.FieldByName('REG_REGECF').AsString ;

      cbEcf.Properties.Items.AddObject(qryEcf.FieldByName('REG_BLCECF').AsString+qryEcf.FieldByName('REG_REGECF').AsString, info);

      qryEcf.Next ;
    end;

  finally
    FreeAndNil(qryEcf) ;
  end;
end;

procedure TfrmImportacoesContabeis.pCarregaRegistrosTotPlanco;
var
  qryPlanco: TUniQuery;
begin
  if Assigned(FCdsTotPlanco) then
    FreeAndNil(FCdsTotPlanco);

  qryPlanco := fCriaQuery();
  try
    qryPlanco.Close;
    qryPlanco.SQL.Clear;
    qryPlanco.SQL.Add('SELECT EMP_CODEMP AS CODEMP, "" AS EXERCI, ');
    qryPlanco.SQL.Add('NCO_CODCON AS CODCON, 0.00 AS SALINI, "D" AS DEBCRE ');
    qryPlanco.SQL.Add('FROM PLANCO CROSS JOIN CADEMP ');
    qryPlanco.SQL.Add('WHERE NCO_SUBCNT = "S" AND NCO_NATURE = "A" ');
    qryPlanco.SQL.Add('ORDER BY NCO_CODCON, EMP_CODEMP ');

    qryPlanco.Open;

    FCdsTotPlanco := fCriaClientDatset(qryPlanco);
    FCdsTotPlanco.IndexFieldNames := 'CODCON;CODEMP';

  finally
    FreeAndNil(qryPlanco);
  end;
end;

procedure TfrmImportacoesContabeis.pDestravaImportacao;
var
  strTip : string;
begin
  strTip := fgetDescrImportacao;
  fLock_Unlock('IMPORTACAO_'+strTip, False);
end;

procedure TfrmImportacoesContabeis.pLimpaCbECF;
var
  intCnt : integer ;
begin
  for intCnt := 0 to cbEcf.Properties.Items.Count-1 do
  begin
    TInfoECF(cbEcf.Properties.Items.Objects[intCnt]).Free ;
  end;
end;

procedure TfrmImportacoesContabeis.pMostraCbECF(const AMostrar:boolean);
begin
  lbEcf.Visible := AMostrar ;
  cbEcf.Visible := AMostrar ;
end;

procedure TfrmImportacoesContabeis.pMostraOpcoesLancon;
begin
  rgOpcoes.Visible := True ;
end;

procedure TfrmImportacoesContabeis.pMostraTotPlanco;
var
  cdsAux: TUniClientDataset;
  frmTotalPlanco: TfrmTotalPlanco;
begin
  if not Assigned(FCdsTotPlanco) then
    Exit;

  cdsAux := TUniClientDataSet.Create(Nil);
  pCriarFormularios(TfrmTotalPlanco, frmTotalPlanco);
  try
    cdsAux.Data := FCdsTotPlanco.Data;
    cdsAux.IndexFieldNames := 'CODCON;CODEMP';
    frmTotalPlanco.CdsTot := cdsAux;
    frmTotalPlanco.ShowModal;

    if frmTotalPlanco.Confirmou then
      FCdsTotPlanco.Data := cdsAux.Data;

    FCdsTotPlanco.First;

  finally
    FreeAndNil(cdsAux);
    FreeAndNil(frmTotalPlanco);
  end;
end;

function TfrmImportacoesContabeis.fMoverArquivoParaIportados(
  const ACaminhoArquivo: String): String;
var
  LDir, LDestDir, LDestPath, LNovoNome: string;
  LDataHora: string;
begin
  Result := '';

  try
    if not FileExists(ACaminhoArquivo) then
    begin
      Result := 'O arquivo [' + ACaminhoArquivo + '] não existe.';
      Exit;
    end;

    LDir := ExtractFileDir(ACaminhoArquivo);
    LDestDir := TPath.Combine(LDir, 'Importados');

    if not DirectoryExists(LDestDir) then
      CreateDir(LDestDir);

    LDestPath := TPath.Combine(LDestDir, ExtractFileName(ACaminhoArquivo));

    if FileExists(LDestPath) then
    begin
      LDataHora := FormatDateTime('yyyyMMdd_HHmmss', Now);
      LNovoNome := TPath.Combine(LDestDir,
                  Format('%s_%s%s', [ChangeFileExt(ExtractFileName(ACaminhoArquivo), ''), LDataHora, ExtractFileExt(ACaminhoArquivo)]));
      LDestPath := LNovoNome;
    end;

    try
      TFile.Move(ACaminhoArquivo, LDestPath);
    except
      on E: Exception do
      begin
        Result := 'Arquivo importado com sucesso, porém não foi movido para a pasta "Importados".' + #13#10;
        Result := Result + 'Erro: ' + E.Message;
      end;
    end;

  except
    on E: Exception do
    begin
      Result := 'Ocorreu um erro inesperado: ' + E.Message;
    end;
  end;
end;

end.
