unit untImportacaoAbreviacaoIcms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.CheckLst, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxCustomListBox, cxCheckListBox, untFrameAbreviacaoIcms, CxProgressBar,
  iMendes.TProcessoAutcom, Data.DB, iMendes.Types, untTypesSistema, StrUtils,
   untConsultas, EditFocus, untFuncoesSimples, untFuncoesConsulta, Uni,
   UniClientDataSet, untTValidaExcel, frxDBSet;

type
  TfrmImportacaoAbreviacaoIcms = class(TfrmPai)
    pnlFiltros: TPanel;
    pnlAbreviacoes: TPanel;
    btnExportar: TBitBtnLocked;
    btnImportar: TBitBtnLocked;
    clsFilterPerfil: TcxCheckListBox;
    pnlGridResultado: TPanel;
    Label10: TLabel;
    edtAbreviacaoCodigo: TEditFocus;
    edtAbreviacaoDescricao: TEditFocus;
    btnCarregar: TBitBtnLocked;
    dtsDados: TDataSource;
    btnGravar: TBitBtnLocked;
    btnModeloArquivoImportar: TBitBtnLocked;
    frxHelp: TfrxReport;
    frxRelatorioJ: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    procedure clsFilterPerfilClick(Sender: TObject);
    procedure clsFilterPerfilEditValueChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtAbreviacaoCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure btnCarregarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtAbreviacaoCodigoExit(Sender: TObject);
    procedure btnModeloArquivoImportarClick(Sender: TObject);
  private
    { Private declarations }
    frmAbreviacoesIcms: TframeAbreviacoesIcms;
    ProcessaImendesRetorno: TProcessaImendesRetorno;
    RecParametrosApiSaneamento: TRecParametrosApiSaneamento;

    cdsAbreviacoes: TUniClientDataSet;
    cdsLogABF: TUniClientDataSet;
    cdsErros: TUniClientDataSet;
    arrAbf: TConsultasArray;
    objValidaExcel: TValidadorExcel;
    blnArqCsv: Boolean;

    const
      cAbreviacao = 'A';
      cPERFIL = 'B';
      cUF = 'C';
      cCST = 'D';
      cBASEICMS = 'E';
      cALIQUOTAICMS = 'F';
      cBASEST = 'G';
      cALIQINTERNAST = 'H';
      cALIQREDUZIDAST = 'I';
      cIVAST = 'J';
      cALIQEFETIVAORIGEMDIFAL = 'K';
      cALIQINTERNAESTADODESTINODIFAL = 'L';
      cBASEDESTINODIFAL = 'M';
      cFCP = 'N';
      cMensagem01 = 'O';
      cMensagem02 = 'P';
      cCODBEN = 'Q';
      cQtdColunas = 17;

     const
      cDescAbreviacao = 'ABREVIAÇÃO';
      cDescPERFIL = 'PERFIL';
      cDescUF = 'UF';
      cDescCST = 'CST';
      cDescBASEICMS = '% BASE ICMS';
      cDescALIQUOTAICMS = '% ALIQUOTA ICMS';
      cDescBASEST = '% BASE ST';
      cDescALIQINTERNAST = '% ALIQ INTERNA ST';
      cDescALIQREDUZIDAST = '% ALIQ REDUZIDA ST';
      cDescIVAST = 'IVA ST';
      cDescALIQEFETIVAORIGEMDIFAL = '% ALIQ EFETIVA ORIGEM – DIFAL';
      cDescALIQINTERNAESTADODESTINODIFAL = '% ALIQ INTERNA ESTADO DESTINO – DIFAL';
      cDescBASEDESTINODIFAL = '% BASE DESTINO – DIFAL';
      cDescFCP = '% FCP';
      cDescMensagem01 = 'Mensagem 01';
      cDescMensagem02 = 'Mensagem 02';
      cDescCODBEN = 'CÓDIGO BENEFÍCIO FISCAL';

    function fMontaRecordParametros: TRecParametrosApiSaneamento;
    function fMontaRecordFiltros: TRecFiltrosApiSaneamento;
    function fSetEnumPerfisMarcados: TConjPerfis;
    function fCarregarAbreviacoes(cxProgresso: TcxProgressBar): Boolean;
    function fExportarCsv(cxProgresso: TcxProgressBar): Boolean;
    procedure pLiberarExportacao(blnLiberar: Boolean);
    procedure pAjustarBotaoSair;
    procedure pImportarPlanilha(cxProgresso: TcxProgressBar);
    procedure pCarregarAbreviacoesImportacao(strCaminhoArquivo: string);
    function fTemTitulo: boolean;
    procedure pPrepararPlanilha;
    function fRetornarComplementoPerfil(strPerfil: string): string;
    function fPrepararCamposDif: string;
    function fImportar(cxProgresso: TcxProgressBar): Boolean;
    function fPossuiAlteracao: Boolean;
    function fGravar(cxProgresso: TcxProgressBar): Boolean;
    function fGravarAlteracaoAbreviacao(cxProgresso: TcxProgressBar): Boolean;
    function fGravaLogChanges: Boolean;
    procedure pCriarCdsLog;
    procedure pLimparAcao;
    procedure pMarcaDesmarcaTodosPerfis(blnMarca: Boolean);
    procedure AdicionarCdsErros(const Alinha: Integer; const AColuna, Amensagem: String);
    procedure CriarcdsErros;
  public
    { Public declarations }
  end;

var
  frmImportacaoAbreviacaoIcms: TfrmImportacaoAbreviacaoIcms;

implementation

uses untGravando;

{$R *.dfm}

procedure TfrmImportacaoAbreviacaoIcms.AdicionarCdsErros(const Alinha: Integer;
  const AColuna, Amensagem: String);
begin
  cdsErros.Append;
  cdsErros.FieldByName('Coluna').AsString := AColuna;
  cdsErros.FieldByName('Linha').AsInteger := Alinha + 1;
  cdsErros.FieldByName('Mensagem').AsString := Amensagem;
  cdsErros.Post;
end;

procedure TfrmImportacaoAbreviacaoIcms.btnCarregarClick(Sender: TObject);
begin
  inherited;

  if fEmptyStr(edtAbreviacaoCodigo.Text) then
  begin
    pMensagemOk('Necessário escolher ao menos uma abreviação!');
    Exit;
  end;

  TfrmGravando.fExecuta(fCarregarAbreviacoes, frmGravando, 'Carregando informações, aguarde...');

  pLiberarExportacao(True);

  frmAbreviacoesIcms.pExibirLocal(False);
end;

procedure TfrmImportacaoAbreviacaoIcms.btnExportarClick(Sender: TObject);
begin
  TfrmGravando.fExecuta(fExportarCsv, frmGravando, 'Gerando arquivo, aguarde...');
end;

procedure TfrmImportacaoAbreviacaoIcms.btnGravarClick(Sender: TObject);
begin
  inherited;
  If fPergunta('Confirma gravação da Abreviação Fiscal?') Then
  Begin
    TfrmGravando.fExecuta(fGravar, frmGravando, 'Gravando alterações, aguarde...');
  End;
end;

procedure TfrmImportacaoAbreviacaoIcms.btnImportarClick(Sender: TObject);
begin
  inherited;
  pLiberarExportacao(False);
  frmAbreviacoesIcms.pExibirLocal(True);

  TfrmGravando.fExecuta(fImportar, frmGravando, 'Escolher arquivo', False);
end;

procedure TfrmImportacaoAbreviacaoIcms.btnModeloArquivoImportarClick(
  Sender: TObject);
begin
  inherited;

  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmImportacaoAbreviacaoIcms.clsFilterPerfilClick(Sender: TObject);
begin
  inherited;
  If clsFilterPerfil.ItemIndex > -1 Then
    TBandPerfil(clsFilterPerfil.Items.Objects[clsFilterPerfil.ItemIndex]).pChangeVisible(clsFilterPerfil.Items[clsFilterPerfil.ItemIndex].Checked);
end;

procedure TfrmImportacaoAbreviacaoIcms.clsFilterPerfilEditValueChanged(
  Sender: TObject);
begin
  inherited;
  If clsFilterPerfil.ItemIndex > -1 Then
    TBandPerfil(clsFilterPerfil.Items.Objects[clsFilterPerfil.ItemIndex]).pChangeVisible(clsFilterPerfil.Items[clsFilterPerfil.ItemIndex].Checked);
end;

procedure TfrmImportacaoAbreviacaoIcms.CriarcdsErros;
begin
  cdsErros := TUniClientDataSet.Create(Self);

  cdsErros.FieldDefs.Add('Coluna', ftString, 20);
  cdsErros.FieldDefs.Add('Linha', ftString, 20);
  cdsErros.FieldDefs.Add('Mensagem', ftString, 255);

  cdsErros.CreateDataSet;
  cdsErros.Open;

  pSetaClient(cdsErros);
end;

procedure TfrmImportacaoAbreviacaoIcms.edtAbreviacaoCodigoExit(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtAbreviacaoCodigo.Text) then
    edtAbreviacaoDescricao.Text := EmptyStr;
end;

procedure TfrmImportacaoAbreviacaoIcms.edtAbreviacaoCodigoKeyPress(
  Sender: TObject; var Key: Char);
begin
  {*****************************}
  {* CONSULTA DE ABREV. FISCAL *}
  {**************************RV*}
  If fPesqAbrevFiscal(Self, edtAbreviacaoCodigo, edtAbreviacaoDescricao, qryTabela, Key, arrAbf, False) Then
  Begin
    btnCarregar.Enabled := True;
  End;
end;

function TfrmImportacaoAbreviacaoIcms.fMontaRecordFiltros: TRecFiltrosApiSaneamento;
begin
  Result.FilterPerfis := fSetEnumPerfisMarcados;
end;

function TfrmImportacaoAbreviacaoIcms.fMontaRecordParametros: TRecParametrosApiSaneamento;
begin
  Result.Filtros := fMontaRecordFiltros;
end;

procedure TfrmImportacaoAbreviacaoIcms.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if not cdsAbreviacoes.Active then
    Exit;

  If cdsAbreviacoes.RecordCount > 0 Then
  Begin
    If fPergunta('Deseja cancelar a ação atual?') Then
    Begin
      Action := caNone;
      pLimparAcao;

      Exit;
    End;
  End;
end;

procedure TfrmImportacaoAbreviacaoIcms.FormCreate(Sender: TObject);
begin
  inherited;
  ProcessaImendesRetorno := TProcessaImendesRetorno.Create;
  frmAbreviacoesIcms := TframeAbreviacoesIcms.fCriaFrameResultado(Self, pnlGridResultado, ProcessaImendesRetorno, dtsDados);

  RecParametrosApiSaneamento := fMontaRecordParametros;
  clsFilterPerfil.Columns := 2;
  frmAbreviacoesIcms.GridDinamico.pAjustaArrBandPerfil(RecParametrosApiSaneamento.Filtros.FilterPerfis, clsFilterPerfil);

  cdsAbreviacoes := TUniClientDataSet.Create(Application);
  frmAbreviacoesIcms.dtsDados.DataSet := cdsAbreviacoes;

  pCriarCdsLog;

  CriarcdsErros;
end;

procedure TfrmImportacaoAbreviacaoIcms.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsAbreviacoes);
  FreeAndNil(cdsLogABF);
  FreeAndNil(cdsErros);
end;

procedure TfrmImportacaoAbreviacaoIcms.FormResize(Sender: TObject);
begin
  inherited;
  pAjustarBotaoSair;
end;

procedure TfrmImportacaoAbreviacaoIcms.FormShow(Sender: TObject);
begin
  inherited;
  pAjustarBotaoSair;
  pLiberarExportacao(False);
  frmAbreviacoesIcms.pExibirLocal(False);
end;

function TfrmImportacaoAbreviacaoIcms.fRetornarComplementoPerfil(
  strPerfil: string): string;
begin
  If Pos(strPerfil, 'PEF_PEJ_PER_PES_PSI_PII_') > 0 Then
    Result := 'ENT_' + strPerfil
  else
    Result := 'SAI_' + strPerfil;
end;

function TfrmImportacaoAbreviacaoIcms.fSetEnumPerfisMarcados: TConjPerfis;
begin
  Result := [cjpPEF, cjpPEJ, cjpPER, cjpPES, cjpPSI, cjpPII, cjpNCO, cjpCCO, cjpCNC, cjpSNA, cjpCTA, cjpPRU ,cjpIND, cjpTRS];
end;

function TfrmImportacaoAbreviacaoIcms.fTemTitulo: boolean;
begin
  If objValidaExcel.fGetValueCSV(0, cPERFIL) <> '' Then
    Result := (Pos(Trim(objValidaExcel.fGetValueCSV(0, cPERFIL)), 'PEF_PEJ_PER_PSI_PII_PES_CNC_SNA_IND_TRS_NCO_CCO_CTA_PRU') <= 0)
  Else
    Result := False;
end;

procedure TfrmImportacaoAbreviacaoIcms.pCarregarAbreviacoesImportacao(
  strCaminhoArquivo: string);
var
  intValIni, intContador: Integer;
  strlAbrCod: TStringList;
  qryConsulta: TUniQuery;
begin
  strlAbrCod := TStringList.Create;
  strlAbrCod.Delimiter := ',';
  strlAbrCod.StrictDelimiter := True;

  objValidaExcel := TValidadorExcel.Create(strCaminhoArquivo, cQtdColunas, '', '', 0);

  pPrepararPlanilha;

  blnArqCsv := UpperCase(ExtractFileExt(objValidaExcel.NomeArquivo)) = '.CSV';

  intValIni := IIf(fTemTitulo, 1 , 0);

  For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
  Begin
    If blnArqCsv Then
      If intContador > objValidaExcel.ArquivoCSV.Count Then
        Continue;

    If Pos(objValidaExcel.fGetValueCSV(intContador, cAbreviacao), strlAbrCod.DelimitedText) <= 0 Then
      strlAbrCod.Add(fStrZero(objValidaExcel.fGetValueCSV(intContador, cAbreviacao), 3));
  End;

  qryConsulta := fCriaQuery;

  If qryConsulta.Active Then
    qryConsulta.Close;

  qryConsulta.Options.SetFieldsReadOnly := False;

  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT "ANTERIOR" AS LOCAL, "N" as POSSUI_DIFERENCA, ABFICM.*, ');
  qryConsulta.SQL.Add(fPrepararCamposDif);
  qryConsulta.SQL.Add('FROM ABFICM WHERE ');
  qryConsulta.SQL.Add(' ABF_CODABF IN (' + fCommaTextToQuoted(strlAbrCod.CommaText) + ')');
  qryConsulta.SQL.Add('UNION ALL SELECT "NOVO" AS LOCAL, "N" as POSSUI_DIFERENCA, ABFICM.*, ');
  qryConsulta.SQL.Add(fPrepararCamposDif);
  qryConsulta.SQL.Add('FROM ABFICM WHERE ');
  qryConsulta.SQL.Add(' ABF_CODABF IN (' + fCommaTextToQuoted(strlAbrCod.CommaText) + ')');
  qryConsulta.SQL.Add(' ORDER BY abf_codabf, ABF_ESTADO, LOCAL');
  qryConsulta.Open;

  pSetaClientDataSet(qryConsulta, cdsAbreviacoes);
end;

procedure TfrmImportacaoAbreviacaoIcms.pCriarCdsLog;
begin
  cdsLogABF := TUniClientDataSet.Create(Self);

  cdsLogABF.FieldDefs.Add('LOG_ESTADO', ftString, 2);
  cdsLogABF.FieldDefs.Add('LOG_NOMCAM', ftString, 20);
  cdsLogABF.FieldDefs.Add('LOG_VALANT', ftString, 255);
  cdsLogABF.FieldDefs.Add('LOG_VALATU', ftString, 255);
  cdsLogABF.FieldDefs.Add('LOG_CODABF', ftString, 3);

  cdsLogABF.CreateDataSet;
  cdsLogABF.Open;

  pSetaClient(cdsLogABF);
end;

procedure TfrmImportacaoAbreviacaoIcms.pLimparAcao;
begin
  frmAbreviacoesIcms.cxgDados.BeginUpdate;
  try
    cdsAbreviacoes.Close;
  finally
    frmAbreviacoesIcms.cxgDados.EndUpdate;
  end;

  cdsLogABF.EmptyDataSet;
  cdsErros.EmptyDataSet;

  pLiberarExportacao(False);

  pMarcaDesmarcaTodosPerfis(True);
end;

procedure TfrmImportacaoAbreviacaoIcms.pMarcaDesmarcaTodosPerfis(
  blnMarca: Boolean);
var
  i: integer;
begin
  For i := 0 To clsFilterPerfil.Items.Count -1 do
  Begin
    clsFilterPerfil.Items[i].Checked := blnMarca;
    TBandPerfil(clsFilterPerfil.Items.Objects[i]).pChangeVisible(clsFilterPerfil.Items[i].Checked);
  end;
end;

procedure TfrmImportacaoAbreviacaoIcms.pAjustarBotaoSair;
begin
  btnSair.Left := pnlBotoes.Width - btnSair.Width - 2;
end;

procedure TfrmImportacaoAbreviacaoIcms.pImportarPlanilha(cxProgresso: TcxProgressBar);
var
  intValIni, intContador: Integer;

  function EhNumero(Const strNumber: String): Boolean;
  begin
    Result := False;

    If (fEmptyStr(strNumber)) Then
    Begin
      Exit;
    End;

    if not (StrToFloatDef(strNumber, -1) >= 0) then
    Begin
      Exit;
    End;

    Result := True;
  end;
begin
  frmGravando.lblGravando.Caption := 'Verificando alterações, aguarde...';
  frmGravando.pgbStatus.Visible := True;
  Application.ProcessMessages;

  intValIni := IIf(fTemTitulo, 1 , 0);

  frmAbreviacoesIcms.cxgDados.BeginUpdate();
  cdsAbreviacoes.DisableControls;

  try
    cxProgresso.Properties.Max := objValidaExcel.ArquivoCSV.Count -1;

    cdsAbreviacoes.AddIndex('indiceLocalizaABF', 'LOCAL;ABF_CODABF;ABF_ESTADO', [ixUnique]);
    cdsAbreviacoes.IndexName := 'indiceLocalizaABF';

    For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
    Begin
      if objValidaExcel.RetornaQuantdadeColunasLinha(intContador) <> cQtdColunas then
      begin
        AdicionarCdsErros(intContador, EmptyStr, 'Linha com a quantidade de colunas inválida.');
        Continue;
      end;

      if cdsAbreviacoes.FindKey(['NOVO', fStrZero(Trim(objValidaExcel.fGetValueCSV(intContador, cAbreviacao)), 3),
        Trim(objValidaExcel.fGetValueCSV(intContador, cUF))]) then
      begin
        cdsAbreviacoes.Edit;

        if cdsAbreviacoes.FindField('ABF_CODSIT_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))) <> nil then
        begin
          if not fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContador, cCST))) then
          begin
            if not EhNumero(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cCST), '.', ',')) then
            begin
              AdicionarCdsErros(intContador, cCST, 'Célula com valor inválido.');
              Continue;
            end;

            if cdsAbreviacoes.FieldByName('ABF_CODSIT_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString <>
                objValidaExcel.fGetValueCSV(intContador, cCST) then
            begin
              cdsLogABF.AppendRecord([cdsAbreviacoes.FieldByName('ABF_ESTADO').AsString,
                  'ABF_CODSIT_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL)),
                  cdsAbreviacoes.FieldByName('ABF_CODSIT_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString,
                  objValidaExcel.fGetValueCSV(intContador, cCST), cdsAbreviacoes.FieldByName('ABF_CODABF').AsString]);

              cdsAbreviacoes.FieldByName('ABF_CODSIT_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString :=
                objValidaExcel.fGetValueCSV(intContador, cCST);

              cdsAbreviacoes.FieldByName('DIF_CODSIT_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString := 'S';

              cdsAbreviacoes.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
            end;
          end;
        end;

        if cdsAbreviacoes.FindField('ABF_BASICM_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))) <> nil then
        begin
          if not fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContador, cBASEICMS))) then
          begin
            if not EhNumero(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cBASEICMS), '.', ',')) then
            begin
              AdicionarCdsErros(intContador, cBASEICMS, 'Célula com valor inválido.');
              Continue;
            end;

            if cdsAbreviacoes.FieldByName('ABF_BASICM_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString <>
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cBASEICMS), '.', ',') then
            begin
              cdsLogABF.AppendRecord([cdsAbreviacoes.FieldByName('ABF_ESTADO').AsString,
                  'ABF_BASICM_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL)),
                  cdsAbreviacoes.FieldByName('ABF_BASICM_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString,
                  AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cBASEICMS), '.', ','), cdsAbreviacoes.FieldByName('ABF_CODABF').AsString]);

              cdsAbreviacoes.FieldByName('ABF_BASICM_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString :=
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cBASEICMS), '.', ',');

              cdsAbreviacoes.FieldByName('DIF_BASICM_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString := 'S';

              cdsAbreviacoes.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
            end;
          end;
        end;

        if cdsAbreviacoes.FindField('ABF_ALQICM_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))) <> nil then
        begin
          if not fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContador, cALIQUOTAICMS))) then
          begin
            if not EhNumero(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQUOTAICMS), '.', ',')) then
            begin
              AdicionarCdsErros(intContador, cALIQUOTAICMS, 'Célula com valor inválido.');
              Continue;
            end;

            if cdsAbreviacoes.FieldByName('ABF_ALQICM_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString <>
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQUOTAICMS), '.', ',') then
            begin
              cdsLogABF.AppendRecord([cdsAbreviacoes.FieldByName('ABF_ESTADO').AsString,
                  'ABF_ALQICM_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL)),
                  cdsAbreviacoes.FieldByName('ABF_ALQICM_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString,
                  AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQUOTAICMS), '.', ','), cdsAbreviacoes.FieldByName('ABF_CODABF').AsString]);

              cdsAbreviacoes.FieldByName('ABF_ALQICM_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString :=
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQUOTAICMS), '.', ',');

              cdsAbreviacoes.FieldByName('DIF_ALQICM_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString := 'S';

              cdsAbreviacoes.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
            end;
          end;
        end;

        if cdsAbreviacoes.FindField('ABF_BASRET_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))) <> nil then
        begin
          if not fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContador, cBASEST))) then
          begin
            if not EhNumero(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cBASEST), '.', ',')) then
            begin
              AdicionarCdsErros(intContador, cBASEST, 'Célula com valor inválido.');
              Continue;
            end;

            if cdsAbreviacoes.FieldByName('ABF_BASRET_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString <>
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cBASEST), '.', ',') then
            begin
              cdsLogABF.AppendRecord([cdsAbreviacoes.FieldByName('ABF_ESTADO').AsString,
                  'ABF_BASRET_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL)),
                  cdsAbreviacoes.FieldByName('ABF_BASRET_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString,
                  AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cBASEST), '.', ','), cdsAbreviacoes.FieldByName('ABF_CODABF').AsString]);

              cdsAbreviacoes.FieldByName('ABF_BASRET_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString :=
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cBASEST), '.', ',');

              cdsAbreviacoes.FieldByName('DIF_BASRET_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString := 'S';

              cdsAbreviacoes.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
            end;
          end;
        end;

        if cdsAbreviacoes.FindField('ABF_ALQRET_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))) <> nil then
        begin
          if not fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContador, cALIQINTERNAST))) then
          begin
            if not EhNumero(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQINTERNAST), '.', ',')) then
            begin
              AdicionarCdsErros(intContador, cALIQINTERNAST, 'Célula com valor inválido.');
              Continue;
            end;

            if cdsAbreviacoes.FieldByName('ABF_ALQRET_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString <>
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQINTERNAST), '.', ',') then
            begin
              cdsLogABF.AppendRecord([cdsAbreviacoes.FieldByName('ABF_ESTADO').AsString,
                  'ABF_ALQRET_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL)),
                  cdsAbreviacoes.FieldByName('ABF_ALQRET_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString,
                  AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQINTERNAST), '.', ','), cdsAbreviacoes.FieldByName('ABF_CODABF').AsString]);

              cdsAbreviacoes.FieldByName('ABF_ALQRET_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString :=
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQINTERNAST), '.', ',');

              cdsAbreviacoes.FieldByName('DIF_ALQRET_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString := 'S';

              cdsAbreviacoes.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
            end;
          end;
        end;

        if cdsAbreviacoes.FindField('ABF_ALQRED_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))) <> nil then
        begin
          if not fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContador, cALIQREDUZIDAST))) then
          begin
            if not EhNumero(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQREDUZIDAST), '.', ',')) then
            begin
              AdicionarCdsErros(intContador, cALIQREDUZIDAST, 'Célula com valor inválido.');
              Continue;
            end;

            if cdsAbreviacoes.FieldByName('ABF_ALQRED_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString <>
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQREDUZIDAST), '.', ',') then
            begin
              cdsLogABF.AppendRecord([cdsAbreviacoes.FieldByName('ABF_ESTADO').AsString,
                  'ABF_ALQRED_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL)),
                  cdsAbreviacoes.FieldByName('ABF_ALQRED_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString,
                  AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQREDUZIDAST), '.', ','), cdsAbreviacoes.FieldByName('ABF_CODABF').AsString]);

              cdsAbreviacoes.FieldByName('ABF_ALQRED_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString :=
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQREDUZIDAST), '.', ',');

              cdsAbreviacoes.FieldByName('DIF_ALQRED_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString := 'S';

              cdsAbreviacoes.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
            end;
          end;
        end;

        if cdsAbreviacoes.FindField('ABF_IVA_ST_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))) <> nil then
        begin
          if not fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContador, cIVAST))) then
          begin
            if not EhNumero(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cIVAST), '.', ',')) then
            begin
              AdicionarCdsErros(intContador, cIVAST, 'Célula com valor inválido.');
              Continue;
            end;

            if cdsAbreviacoes.FieldByName('ABF_IVA_ST_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString <>
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cIVAST), '.', ',') then
            begin
              cdsLogABF.AppendRecord([cdsAbreviacoes.FieldByName('ABF_ESTADO').AsString,
                  'ABF_IVA_ST_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL)),
                  cdsAbreviacoes.FieldByName('ABF_IVA_ST_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString,
                  AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cIVAST), '.', ','), cdsAbreviacoes.FieldByName('ABF_CODABF').AsString]);

              cdsAbreviacoes.FieldByName('ABF_IVA_ST_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString :=
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cIVAST), '.', ',');

              cdsAbreviacoes.FieldByName('DIF_IVA_ST_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString := 'S';

              cdsAbreviacoes.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
            end;
          end;
        end;

        if cdsAbreviacoes.FindField('ABF_ALQEFO_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))) <> nil then
        begin
          if not fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContador, cALIQEFETIVAORIGEMDIFAL))) then
          begin
            if not EhNumero(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQEFETIVAORIGEMDIFAL), '.', ',')) then
            begin
              AdicionarCdsErros(intContador, cALIQEFETIVAORIGEMDIFAL, 'Célula com valor inválido.');
              Continue;
            end;

            if cdsAbreviacoes.FieldByName('ABF_ALQEFO_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString <>
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQEFETIVAORIGEMDIFAL), '.', ',') then
            begin
              cdsLogABF.AppendRecord([cdsAbreviacoes.FieldByName('ABF_ESTADO').AsString,
                  'ABF_ALQEFO_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL)),
                  cdsAbreviacoes.FieldByName('ABF_ALQEFO_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString,
                  AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQEFETIVAORIGEMDIFAL), '.', ','), cdsAbreviacoes.FieldByName('ABF_CODABF').AsString]);

              cdsAbreviacoes.FieldByName('ABF_ALQEFO_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString :=
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQEFETIVAORIGEMDIFAL), '.', ',');

              cdsAbreviacoes.FieldByName('DIF_ALQEFO_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString := 'S';

              cdsAbreviacoes.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
            end;
          end;
        end;

        if cdsAbreviacoes.FindField('ABF_ALQIED_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))) <> nil then
        begin
          if not fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContador, cALIQINTERNAESTADODESTINODIFAL))) then
          begin
            if not EhNumero(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQINTERNAESTADODESTINODIFAL), '.', ',')) then
            begin
              AdicionarCdsErros(intContador, cALIQINTERNAESTADODESTINODIFAL, 'Célula com valor inválido.');
              Continue;
            end;

            if cdsAbreviacoes.FieldByName('ABF_ALQIED_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString <>
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQINTERNAESTADODESTINODIFAL), '.', ',') then
            begin
              cdsLogABF.AppendRecord([cdsAbreviacoes.FieldByName('ABF_ESTADO').AsString,
                  'ABF_ALQIED_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL)),
                  cdsAbreviacoes.FieldByName('ABF_ALQIED_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString,
                  AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQINTERNAESTADODESTINODIFAL), '.', ','), cdsAbreviacoes.FieldByName('ABF_CODABF').AsString]);

              cdsAbreviacoes.FieldByName('ABF_ALQIED_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString :=
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cALIQINTERNAESTADODESTINODIFAL), '.', ',');

              cdsAbreviacoes.FieldByName('DIF_ALQIED_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString := 'S';

              cdsAbreviacoes.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
            end;
          end;
        end;

        if cdsAbreviacoes.FindField('ABF_BASDDS_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))) <> nil then
        begin
          if not fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContador, cBASEDESTINODIFAL))) then
          begin
            if not EhNumero(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cBASEDESTINODIFAL), '.', ',')) then
            begin
              AdicionarCdsErros(intContador, cBASEDESTINODIFAL, 'Célula com valor inválido.');
              Continue;
            end;

            if cdsAbreviacoes.FieldByName('ABF_BASDDS_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString <>
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cBASEDESTINODIFAL), '.', ',') then
            begin
              cdsLogABF.AppendRecord([cdsAbreviacoes.FieldByName('ABF_ESTADO').AsString,
                  'ABF_BASDDS_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL)),
                  cdsAbreviacoes.FieldByName('ABF_BASDDS_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString,
                  AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cBASEDESTINODIFAL), '.', ','), cdsAbreviacoes.FieldByName('ABF_CODABF').AsString]);

              cdsAbreviacoes.FieldByName('ABF_BASDDS_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString :=
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cBASEDESTINODIFAL), '.', ',');

              cdsAbreviacoes.FieldByName('DIF_BASDDS_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString := 'S';

              cdsAbreviacoes.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
            end;
          end;
        end;

        if cdsAbreviacoes.FindField('ABF_ALQFCP_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))) <> nil then
        begin
          if not fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContador, cFCP))) then
          begin
            if not EhNumero(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cFCP), '.', ',')) then
            begin
              AdicionarCdsErros(intContador, cFCP, 'Célula com valor inválido.');
              Continue;
            end;

            if cdsAbreviacoes.FieldByName('ABF_ALQFCP_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString <>
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cFCP), '.', ',') then
            begin
              cdsLogABF.AppendRecord([cdsAbreviacoes.FieldByName('ABF_ESTADO').AsString,
                  'ABF_ALQFCP_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL)),
                  cdsAbreviacoes.FieldByName('ABF_ALQFCP_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString,
                  AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cFCP), '.', ','), cdsAbreviacoes.FieldByName('ABF_CODABF').AsString]);

              cdsAbreviacoes.FieldByName('ABF_ALQFCP_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString :=
                AnsiReplaceStr(objValidaExcel.fGetValueCSV(intContador, cFCP), '.', ',');

              cdsAbreviacoes.FieldByName('DIF_ALQFCP_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString := 'S';

              cdsAbreviacoes.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
            end;
          end;
        end;

        if cdsAbreviacoes.FindField('ABF_MENS01_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))) <> nil then
        begin
          if not fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContador, cMensagem01))) then
          begin
            if cdsAbreviacoes.FieldByName('ABF_MENS01_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString <>
                Trim(objValidaExcel.fGetValueCSV(intContador, cMensagem01)) then
            begin
              cdsLogABF.AppendRecord([cdsAbreviacoes.FieldByName('ABF_ESTADO').AsString,
                  'ABF_MENS01_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL)),
                  cdsAbreviacoes.FieldByName('ABF_MENS01_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString,
                  objValidaExcel.fGetValueCSV(intContador, cMensagem01), cdsAbreviacoes.FieldByName('ABF_CODABF').AsString]);

              cdsAbreviacoes.FieldByName('ABF_MENS01_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString :=
                objValidaExcel.fGetValueCSV(intContador, cMensagem01);

              cdsAbreviacoes.FieldByName('DIF_MENS01_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString := 'S';

              cdsAbreviacoes.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
            end;
          end;
        end;

        if cdsAbreviacoes.FindField('ABF_MENS02_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))) <> nil then
        begin
          if not fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContador, cMensagem02))) then
          begin
            if cdsAbreviacoes.FieldByName('ABF_MENS02_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString <>
                Trim(objValidaExcel.fGetValueCSV(intContador, cMensagem02)) then
            begin
              cdsLogABF.AppendRecord([cdsAbreviacoes.FieldByName('ABF_ESTADO').AsString,
                  'ABF_MENS02_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL)),
                  cdsAbreviacoes.FieldByName('ABF_MENS02_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString,
                  objValidaExcel.fGetValueCSV(intContador, cMensagem02), cdsAbreviacoes.FieldByName('ABF_CODABF').AsString]);

              cdsAbreviacoes.FieldByName('ABF_MENS02_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString :=
                objValidaExcel.fGetValueCSV(intContador, cMensagem02);

              cdsAbreviacoes.FieldByName('DIF_MENS02_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString := 'S';

              cdsAbreviacoes.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
            end;
          end;
        end;

        if cdsAbreviacoes.FindField('ABF_CODBEN_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))) <> nil then
        begin
          if not fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContador, cCODBEN))) then
          begin
            if cdsAbreviacoes.FieldByName('ABF_CODBEN_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString <>
                Trim(objValidaExcel.fGetValueCSV(intContador, cCODBEN)) then
            begin
              cdsLogABF.AppendRecord([cdsAbreviacoes.FieldByName('ABF_ESTADO').AsString,
                  'ABF_CODBEN_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL)),
                  cdsAbreviacoes.FieldByName('ABF_CODBEN_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString,
                  objValidaExcel.fGetValueCSV(intContador, cCODBEN), cdsAbreviacoes.FieldByName('ABF_CODABF').AsString]);

              cdsAbreviacoes.FieldByName('ABF_CODBEN_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString :=
                objValidaExcel.fGetValueCSV(intContador, cCODBEN);

              cdsAbreviacoes.FieldByName('DIF_CODBEN_' + fRetornarComplementoPerfil(objValidaExcel.fGetValueCSV(intContador, cPERFIL))).AsString := 'S';

              cdsAbreviacoes.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
            end;
          end;
        end;

        cdsAbreviacoes.Post;
      end;

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
    End;
  finally
    begin
      cdsAbreviacoes.DeleteIndex('indiceLocalizaABF');
      cdsAbreviacoes.IndexName := '';

      cdsAbreviacoes.EnableControls;
      frmAbreviacoesIcms.cxgDados.EndUpdate;
     end;
  end;
end;

function TfrmImportacaoAbreviacaoIcms.fImportar(
  cxProgresso: TcxProgressBar): Boolean;
var
   dlgOpen: TOpenDialog;
begin
  try
    dlgOpen := TOpenDialog.Create(Self);
    dlgOpen.Filter := 'Arquivos do Excel|*.xls;*.xlsx;*.csv';

    if dlgOpen.Execute then
    begin
      If Not (FileExists(dlgOpen.FileName)) Then
      Begin
        pMensagemOk('Arquivo não encontrado : ' + dlgOpen.FileName + ' !');
        Result := True;
        Exit;
      End;

      frmGravando.lblGravando.Caption := 'Carregando arquivo, aguarde...';

      Application.ProcessMessages;

      pCarregarAbreviacoesImportacao(dlgOpen.FileName);

      pImportarPlanilha(cxProgresso);

      if cdsErros.RecordCount > 0 then
      begin
        fMensagem('','Ocorreram erros na importação do arquivo, clique em Ok para emitir o relatório de inconsistências!', ['&O k']);
        frxRelatorio.DataSet := cdsErros;
        frxRelatorioJ.Script.Variables['NOMEMP'] := fRetNomeEmpresaSelec(VS_strCodEmp);
        pPreviewReport(Self.Name, Self.Caption + ' (Relatório de inconsistências)', frxRelatorioJ);
      end;

      btnGravar.Enabled := fPossuiAlteracao;
      pnlAbreviacoes.Enabled := False;
      btnImportar.Enabled := False;
      pnlGridResultado.Enabled := True;
    end;
  finally
    Result := True;
  end;
end;

procedure TfrmImportacaoAbreviacaoIcms.pLiberarExportacao(blnLiberar: Boolean);
begin
  pnlAbreviacoes.Enabled := not blnLiberar;
  pnlGridResultado.Enabled := blnLiberar;
  clsFilterPerfil.Enabled := blnLiberar;
  btnExportar.Enabled := blnLiberar;
  btnImportar.Enabled := not blnLiberar;
  btnGravar.Enabled := False;

  if not blnLiberar then
  begin
    edtAbreviacaoCodigo.Text := EmptyStr;
    edtAbreviacaoDescricao.Text := EmptyStr;
  end;
end;

function TfrmImportacaoAbreviacaoIcms.fPossuiAlteracao: Boolean;
begin
  cdsAbreviacoes.DisableControls;

  cdsAbreviacoes.Filter := 'POSSUI_DIFERENCA = ' + QuotedStr('S');
  cdsAbreviacoes.Filtered := True;

  Result := cdsAbreviacoes.RecordCount > 0;

  cdsAbreviacoes.Filtered := False;
  cdsAbreviacoes.EnableControls;
end;

function TfrmImportacaoAbreviacaoIcms.fPrepararCamposDif: string;
var
  strLCampos: TStringList;
  strTipAbf: string;
  intContador: Integer;
begin
  strLCampos := TStringList.Create;
  strLCampos.Delimiter := ',';
  strLCampos.QuoteChar := ' ';

  For intContador := 0 To clsFilterPerfil.Items.Count -1 Do
  Begin
    strTipAbf := AnsiLeftStr(clsFilterPerfil.Items[intContador].Text, 3);

    strLCampos.Add('"N" as DIF_CODSIT_' + fRetornarComplementoPerfil(strTipAbf));
    strLCampos.Add('"N" as DIF_BASICM_' + fRetornarComplementoPerfil(strTipAbf));
    strLCampos.Add('"N" as DIF_ALQICM_' + fRetornarComplementoPerfil(strTipAbf));
    strLCampos.Add('"N" as DIF_BASRET_' + fRetornarComplementoPerfil(strTipAbf));
    strLCampos.Add('"N" as DIF_ALQRET_' + fRetornarComplementoPerfil(strTipAbf));
    strLCampos.Add('"N" as DIF_IVA_ST_' + fRetornarComplementoPerfil(strTipAbf));
    strLCampos.Add('"N" as DIF_ALQFCP_' + fRetornarComplementoPerfil(strTipAbf));
    strLCampos.Add('"N" as DIF_ALQEFO_' + fRetornarComplementoPerfil(strTipAbf));
    strLCampos.Add('"N" as DIF_ALQIED_' + fRetornarComplementoPerfil(strTipAbf));
    strLCampos.Add('"N" as DIF_ALQRED_' + fRetornarComplementoPerfil(strTipAbf));
    strLCampos.Add('"N" as DIF_BASDDS_' + fRetornarComplementoPerfil(strTipAbf));
    strLCampos.Add('"N" as DIF_MENS01_' + fRetornarComplementoPerfil(strTipAbf));
    strLCampos.Add('"N" as DIF_MENS02_' + fRetornarComplementoPerfil(strTipAbf));
    strLCampos.Add('"N" as DIF_CODBEN_' + fRetornarComplementoPerfil(strTipAbf));
  End;

  Result := strLCampos.DelimitedText;
end;

procedure TfrmImportacaoAbreviacaoIcms.pPrepararPlanilha;
begin
  If Not Assigned(objValidaExcel) Then
    Exit;

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescAbreviacao, cAbreviacao, 3, True, True, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescPERFIL, cPERFIL, 3, True, True, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescUF, cUF, 2, True, True, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescCST, cCST, 3, True, False, '', '', True));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescBASEICMS, cBASEICMS, 55, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescALIQUOTAICMS, cALIQUOTAICMS, 55, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescBASEST, cBASEST, 55, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescALIQINTERNAST, cALIQINTERNAST, 55, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescALIQREDUZIDAST, cALIQREDUZIDAST, 55, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescIVAST, cIVAST, 55, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescALIQEFETIVAORIGEMDIFAL, cALIQEFETIVAORIGEMDIFAL, 55, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescALIQINTERNAESTADODESTINODIFAL, cALIQINTERNAESTADODESTINODIFAL, 55, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescBASEDESTINODIFAL, cBASEDESTINODIFAL, 55, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescFCP, cFCP, 55, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescMensagem01, cMensagem01, 255, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescMensagem02, cMensagem02, 255, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescCODBEN, cCODBEN, 255, False, False, '', ''));
end;

function TfrmImportacaoAbreviacaoIcms.fCarregarAbreviacoes(cxProgresso: TcxProgressBar): Boolean;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;

  If qryConsulta.Active Then
      qryConsulta.Close;

  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT ABFICM.* FROM ABFICM WHERE ABF_CODABF IN (');
  qryConsulta.SQL.Add(fArrCodigosToLista(edtAbreviacaoCodigo.text, arrAbf) + ')');
  qryConsulta.Open;

  pSetaClientDataSet(qryConsulta, cdsAbreviacoes);

  Result := True;
end;

function TfrmImportacaoAbreviacaoIcms.fExportarCsv(cxProgresso: TcxProgressBar): Boolean;
Var
  intContador: Integer;
  stlLinha, stlLinhas: TStringList;
  strTipAbf, strNomeArquivo: string;
  savPedeArquivo: TSaveDialog;
begin
  try
    strNomeArquivo := '';
    Result := False;

    cdsAbreviacoes.DisableControls;

    stlLinhas := TStringList.Create;
    stlLinha  := TStringList.Create;

    cxProgresso.Properties.Max := cdsAbreviacoes.RecordCount;

    if not cdsAbreviacoes.RecordCount > 0 then
    begin
      Result := True;
      Exit;
    end;

    savPedeArquivo := TSaveDialog.Create(Self);
    savPedeArquivo.Filter     := 'Arquivos CSV|*.csv';
    savPedeArquivo.DefaultExt := 'csv';

    If savPedeArquivo.Execute Then
    Begin
      strNomeArquivo := savPedeArquivo.FileName;
    End;

    stlLinha.Add('Abreviação');
    stlLinha.Add('Perfil');
    stlLinha.Add('UF');
    stlLinha.Add('CST');
    stlLinha.Add('% BASE ICMS');
    stlLinha.Add('% ALIQ ICMS');
    stlLinha.Add('% BASE ST');
    stlLinha.Add('% ALIQ INT. ST');
    stlLinha.Add('% ALIQ REDUZ. ST');
    stlLinha.Add('IVA ST');
    stlLinha.Add('% ALIQ EFET. ORIGEM');
    stlLinha.Add('% ALIQ INT. ESTADO DESTINO');
    stlLinha.Add('% BASE DESTINO');
    stlLinha.Add('% FCP');
    stlLinha.Add('MENSAGEM 01');
    stlLinha.Add('MENSAGEM 02');
    stlLinha.Add('CODBEN');
    stlLinhas.Add(fCommaText(stlLinha, False, ';'));
    stlLinha.Clear;

    cdsAbreviacoes.First;
    while not cdsAbreviacoes.Eof do
    begin
      For intContador := 0 To clsFilterPerfil.Items.Count -1 Do
      Begin
        if not clsFilterPerfil.Items[intContador].Checked then
          Continue;

        strTipAbf := AnsiLeftStr(clsFilterPerfil.Items[intContador].Text, 3);

        stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_CODABF').AsString);
        stlLinha.Add(strTipAbf);
        stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_ESTADO').AsString);
        stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_CODSIT_' + fRetornarComplementoPerfil(strTipAbf)).AsString);
        stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_BASICM_' + fRetornarComplementoPerfil(strTipAbf)).AsString);
        stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_ALQICM_' + fRetornarComplementoPerfil(strTipAbf)).AsString);
        stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_BASRET_' + fRetornarComplementoPerfil(strTipAbf)).AsString);
        stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_ALQRET_' + fRetornarComplementoPerfil(strTipAbf)).AsString);
        stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_ALQRED_' + fRetornarComplementoPerfil(strTipAbf)).AsString);
        stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_IVA_ST_' + fRetornarComplementoPerfil(strTipAbf)).AsString);
        stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_ALQEFO_' + fRetornarComplementoPerfil(strTipAbf)).AsString);
        stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_ALQIED_' + fRetornarComplementoPerfil(strTipAbf)).AsString);
        stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_BASDDS_' + fRetornarComplementoPerfil(strTipAbf)).AsString);
        stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_ALQFCP_' + fRetornarComplementoPerfil(strTipAbf)).AsString);

        if cdsAbreviacoes.FindField('ABF_MENS01_' + fRetornarComplementoPerfil(strTipAbf)) <> nil then
          stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_MENS01_' + fRetornarComplementoPerfil(strTipAbf)).AsString)
        else
          stlLinha.Add(EmptyStr);

        if cdsAbreviacoes.FindField('ABF_MENS02_' + fRetornarComplementoPerfil(strTipAbf)) <> nil then
          stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_MENS02_' + fRetornarComplementoPerfil(strTipAbf)).AsString)
          else
            stlLinha.Add(EmptyStr);

          if fCfgSis('OBRBEN', varBoolean) And (cdsAbreviacoes.FindField('ABF_CODBEN_' + fRetornarComplementoPerfil(strTipAbf)) <> nil) then
            stlLinha.Add(cdsAbreviacoes.FieldByName('ABF_CODBEN_' + fRetornarComplementoPerfil(strTipAbf)).AsString)
          else
            stlLinha.Add(EmptyStr);

          stlLinhas.Add(fCommaText(stlLinha, False, ';'));
          stlLinha.Clear;
      end;

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;

      cdsAbreviacoes.Next;
    end;

    frmGravando.lblGravando.Caption := 'Salvando arquivo, aguarde...';
    Application.ProcessMessages;

    stlLinhas.SaveToFile(strNomeArquivo);

    pMensagemOk('Arquivo gerado com sucesso!');

    pLimparAcao;

    Result := True;
  finally
    cdsAbreviacoes.EnableControls;
    FreeAndNil(savPedeArquivo);
  end;
end;

function TfrmImportacaoAbreviacaoIcms.fGravaLogChanges: Boolean;
Var
    qryLogABF: TUniQuery;
    intRecNo: Integer;
    strSQLLog: String;
    intCount: Integer;
    strAutoIncremLog: String;
begin
  Result := True;

  intCount := cdsLogABF.RecordCount;
  If intCount <= 0 Then
    Exit;

  cdsLogABF.First;
  intRecNo := cdsLogABF.RecNo;

  strAutoIncremLog := fRetAutoIncrem('LOGABF', VS_strCodEmp, intCount);
  If fEmptyStr(strAutoIncremLog) Then
    Exit;

  strSQLLog := 'INSERT INTO LOGABF (AUTOINCREM, LOG_DTAALT, LOG_HORALT, LOG_CODOPE, LOG_CODEMP, '+
               'LOG_CODABF, LOG_ESTADO, LOG_NOMCAM, LOG_VALANT, LOG_VALATU) VALUES ';

  qryLogABF := fCriaQuery();
  Try
    Try
      While Not cdsLogABF.Eof Do
      Begin
        If cdsLogABF.RecNo <> intRecNo Then
          strSQLLog := strSQLLog + ', ';

        strSQLLog := strSQLLog + '('+QuotedStr(strAutoIncremLog)+', CURRENT_DATE, CURRENT_TIME, '+
                     QuotedStr(strLoginUsuarioLogado)+', '+QuotedStr(VS_strCodEmp)+', '+
                     QuotedStr(cdsLogABF.FieldByName('LOG_CODABF').AsString)+', '+
                     QuotedStr(cdsLogABF.FieldByName('LOG_ESTADO').AsString)+', '+
                     QuotedStr(cdsLogABF.FieldByName('LOG_NOMCAM').AsString)+', '+
                     QuotedStr(cdsLogABF.FieldByName('LOG_VALANT').AsString)+', '+
                     QuotedStr(cdsLogABF.FieldByName('LOG_VALATU').AsString)+')';
        strAutoIncremLog := fNextAutoIncrem(strAutoIncremLog);

        cdsLogABF.Next;
      End;
      qryLogABF.SQL.Text := strSQLLog+';';
      qryLogABF.ExecSQL;

    Except
      On E: Exception Do
      begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmImportacaoAbreviacaoIcms.fGravaLogChanges]')
      end;
    End;
  Finally
    FreeAndNil(qryLogABF);
  End
end;

function TfrmImportacaoAbreviacaoIcms.fGravar(
  cxProgresso: TcxProgressBar): Boolean;
begin
  try
    cdsAbreviacoes.DisableControls;

    cdsAbreviacoes.Filter := 'POSSUI_DIFERENCA = ' + QuotedStr('S');
    cdsAbreviacoes.Filtered := True;

    if fGravarAlteracaoAbreviacao(cxProgresso) then
      pMensagemOk('Alteração realizada com sucesso!');
  finally
    cdsAbreviacoes.Filtered := False;
    cdsAbreviacoes.EnableControls;

    pLimparAcao;

    Result := True;
  end;
end;

function TfrmImportacaoAbreviacaoIcms.fGravarAlteracaoAbreviacao(cxProgresso: TcxProgressBar): Boolean;
Var
  qryGen: TUniQuery;
  strSQL: String;
  prcScroll: TPrcScroll;
  intField: Integer;
begin
  Result := False;

  Try
    If Not fStartTransaction Then
    begin
      Exit;
    end;

    pDisableControls(cdsAbreviacoes, prcScroll);

    cxProgresso.Position := 0;
    cxProgresso.Properties.Max := cdsAbreviacoes.RecordCount + 1;

    qryGen := fCriaQuery;

    cdsAbreviacoes.First;
    While Not cdsAbreviacoes.Eof Do
    Begin
      strSQL := '';
      strSQL := strSQL + ' UPDATE ';
      strSQL := strSQL + '   ABFICM ';
      strSQL := strSQL + ' SET ';

      For intField := 0 To cdsAbreviacoes.FieldCount - 1 Do
      Begin
        If (Pos('ABF_CODSIT_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_BASICM_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_ALQICM_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_BASRET_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_ALQRET_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_IVA_ST_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_ALQEFO_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_BASDDS_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_BASDOR_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_ALQFCP_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_ALQIED_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_CODBEN_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_RICMPR_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_ALQRIC_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_ALQCLI_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_ALQIMP_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_ALQRED_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_MENS01_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_MENS02_', cdsAbreviacoes.Fields[intField].FieldName) > 0) OR
            (Pos('ABF_CODBEN_', cdsAbreviacoes.Fields[intField].FieldName) > 0)
        Then
        Begin
          strSQL := strSQL + cdsAbreviacoes.Fields[intField].FieldName + ' = ' +
            AnsiReplaceStr(cdsAbreviacoes.Fields[intField].FieldName, 'ABF_', ':');

          strSQL := strSQL + ', ';
        End;
      End;

      strSQL := strSQL + ' WHERE ';
      strSQL := StringReplace(strSQL, ',  WHERE', ' WHERE', [rfReplaceAll, rfIgnoreCase]);
      strSQL := strSQL + 'AUTOINCREM = :AUTINC ';

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);

      qryGen.ParamByName('AUTINC').AsString := cdsAbreviacoes.Fieldbyname('AUTOINCREM').AsString;

      For intField := 0 To qryGen.Params.Count - 1 Do
          If cdsAbreviacoes.FindField('ABF_' + qryGen.Params[intField].Name) <> Nil Then
            qryGen.Params[intField].Value := cdsAbreviacoes.FindField('ABF_' + qryGen.Params[intField].Name).Value;

      frmGravando.lblGravando.Caption := 'AGUARDE, ATUALIZANDO ABREVIAÇÃO FISCAL - ' +
        cdsAbreviacoes.Fieldbyname('ABF_CODABF').AsString + ' - Estado - ' +
        cdsAbreviacoes.Fieldbyname('ABF_ESTADO').AsString;
      Application.ProcessMessages;

      cxProgresso.Position := cdsAbreviacoes.RecNo;

      Application.ProcessMessages;

      qryGen.ExecSQL;

      cdsAbreviacoes.Next;
    End;

    frmGravando.lblGravando.Caption := 'AGUARDE, INSERINDO LOG DA ABREVIAÇÃO FISCAL';

    cxProgresso.Position := cxProgresso.Position + 1;

    Application.ProcessMessages;

    Result := fGravaLogChanges;

    If Not Result Then
      Exit;

    Result := fCommit;
  Finally
    If Not Result Then
      fRollBack;

    pEnableControls(cdsAbreviacoes, prcScroll);

    FreeAndNil(qryGen);
  End;
end;

end.
