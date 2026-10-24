unit untCadMetasValor;

interface

uses
  Windows, Classes, Controls, Forms, untPaiOrdena, DB, UniDataSetProvider, Uni,
  AppEvnts, Menus, StdCtrls, EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids,
  Buttons, ExtCtrls, untModulo, BitBtnLockedIncrem, MemDS, DBAccess, UniClientDataSet,
  Provider, frxClass, frxExportCSVTestabilidade, cxProgressBar, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Datasnap.DBClient;

type
  TTipoMeta = (tmeFaturamento, tmeRecebimento);
  
  TfrmCadMetasValor = class(TfrmPaiOrdena)
    pnlMesAnoOrigem: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    mskDtaOrigem: TMaskEditFocus;
    Label2: TLabel;
    mskDtaAtual: TMaskEditFocus;
    qryConsultaCODVEN: TStringField;
    qryConsultaTOTMET: TFloatField;
    qryCadVen: TUniQuery;
    qryConsultaNOMVEN: TStringField;
    qryConsultaAUTOINCREM: TStringField;
    Splitter1: TSplitter;
    DataSource1: TDataSource;
    qryConsultaMET_MESANO: TStringField;
    shpLiberado: TShape;
    cdsConsultaMET_CODVEN: TStringField;
    cdsConsultaOPE_NOMOPE: TStringField;
    cdsConsultaMET_TOTMET: TFloatField;
    cdsConsultaMET_MESANO: TStringField;
    btnConfirmar: TBitBtnLocked;
    btnCopiarMetas: TBitBtnLocked;
    Label3: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    qryConsultaFUNCAO: TStringField;
    qryConsultaSUBGER: TStringField;
    qryConsultaGERENT: TStringField;
    cdsConsultaFUNCAO: TStringField;
    cdsConsultaGERENT: TStringField;
    cdsConsultaSUBGER: TStringField;
    qryConsultaMET_MARGEM: TFloatField;
    cdsConsultaMET_MARGEM: TFloatField;
    cdsConsultaAUTOINCREM: TStringField;
    btnPerGru: TBitBtnLocked;
    cdsConsultaMET_TOTFRE: TFloatField;
    qryConsultaMET_TOTFRE: TFloatField;
    shpCodEmp: TShape;
    pnlTotalizacoes: TPanel;
    edtTotFat: TEditFocus;
    edtTotFre: TEditFocus;
    edtMedMar: TEditFocus;
    lblTotFat: TLabel;
    lblTotFre: TLabel;
    lblMedMar: TLabel;
    btnImportarMetas: TBitBtnLocked;
    cdsConsultaMET_CODEMP: TStringField;
    qryConsultaMET_CODEMP: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCopiarMetasClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure pnlTailEnter(Sender: TObject);
    procedure pnlTailExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsConsultaBeforeScroll(DataSet: TDataSet);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure mskDtaAtualKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure btnPerGruClick(Sender: TObject);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
    procedure dtsConsultaUpdateData(Sender: TObject);
    procedure btnImportarMetasClick(Sender: TObject);

  private
    { Private declarations }
    strCadMet,
    strDetMet: String;
    blnLiberado : Boolean;
    strMesAno   : String;
    strMesAnoOri: String;
    blnChecarCemPorCento: Boolean;
    blnEstavaFiltrado: Boolean;

    Function fCopiaMeta: Boolean;
    Function fCopiaMetaCadMet: Boolean;
    procedure pCopiaMetaDetMet;

    procedure pSetaFiltro;

    procedure pAbreConsulta(blnInciar: Boolean);
    procedure pProcessarTotais;

    function  fIncluiRegistros(pgbProgresso: TcxProgressBar = Nil): Boolean;
    function  fGravaMeta(pgbProgresso: TcxProgressBar = Nil): Boolean;
    function  fCopiaSubMetas(pgbProgresso: TcxProgressBar = Nil): Boolean;

    procedure pInfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);
    procedure pStepStatusGravacao(pgbProgresso: TcxProgressBar);

    procedure pCopiaMeta;
    function  fValidaEdicao(Sender: TObject): Boolean;

    function fExibeCamposECMVBI():Boolean;
    procedure pImportarMetas;
    procedure pChamaTelaImportacao(TfrmImportacao: TComponentClass; blnExibeMargem: Boolean = False);
    procedure pPreencheParametrosPremios(var qryDados: TUniQuery; fltVlrFat: Double);
    function fExisteMetFag(Var strAutInc: String): Boolean;
    function fExisteMetFad: Boolean;
    procedure pInserirMetaRentabilidade;
    procedure pInserirMetFad(strSeqGer: String);
    procedure pInserirMetFag(strAutInc: String);
    function fExibeColunaMargem: Boolean;
  public
    { Public declarations }
    tmtTipMet: TTipoMeta;
    blnPorSubMetas,
    blnPorMarca: Boolean;
    blnECMVBI: Boolean;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

Const
  VS_fltValMax = 9999999999.99;

implementation

uses SysUtils, StrUtils, Graphics, untPai, untConsultas, untTypesSistema,
   untFuncoesSimples, untFuncoesConsulta, untCadMetasGrupo, untGravando,
   untCadMetasMarca, untImportacaoMetas, untImportacaoMetasVendedor,
   untImportacaoMetasMarca, untImportacaoMetasLinhaGrupo, untParPre,
   untParPreController;

{$R *.dfm}

procedure TfrmCadMetasValor.FormCreate(Sender: TObject);
begin
  inherited;

  blnECMVBI := fCfgSis('ECMVBI', varBoolean);

  blnPorMarca := fCfgSis('MTGRMA', varString) = 'M';

  tmtTipMet := tmeFaturamento;
  strCadMet := 'CADMET';

  if blnPorMarca then
    strDetMet := 'METMAR'
  Else
    strDetMet := 'DETMET';

  blnChecarCemPorCento := True;
  blnPorSubMetas       := False;

  mskDtaAtual.Text := FormatDateTime('mm/yyyy', VS_Date);
  strMesAno        := AnsiReplaceStr(mskDtaAtual.Text, '/', '');

  If (Not blnPorSubMetas) And (tmtTipMet <> tmeFaturamento) Then
    btnImportarMetas.Visible := False;

  qryCadVen.Open;
end;

function  TfrmCadMetasValor.fIncluiRegistros(pgbProgresso: TcxProgressBar = Nil): Boolean;
  Var
    qryCadMet: TUniQuery;
    qryCadIns: TUniQuery;

  function fVerificaJaInseriu: Boolean;
  begin
    Result := fCampoTabela('COUNT(1)',
                           'CADMET',
                           ['MET_CODEMP', 'MET_MESANO', 'MET_CODVEN'],
                           [VS_strCodEmp, strMesAno, qryCadMet.FieldByName('OPE_CODOPE').AsString]) > 0;
  end;
Begin
  qryCadIns := fCriaQuery;
  qryCadMet := fCriaQuery;

  try
    qryCadIns.SQL.Clear;

    If fExibeCamposECMVBI() Then
    Begin
      qryCadIns.SQL.Add(' INSERT INTO ' + strCadMet);
      qryCadIns.SQL.Add('  (AUTOINCREM, MET_MESANO, MET_CODEMP, MET_CODVEN, MET_TOTMET, '+IIF(tmtTipMet=tmeFaturamento,'MET_TOTFRE,','')+' MET_MARGEM, ');
      qryCadIns.SQL.Add('   MET_ATEDIA, MET_TICMED, MET_ITEDOC)');
      qryCadIns.SQL.Add(' VALUES');
      qryCadIns.SQL.Add('  (:AUTOIN, :MESANO, :CODEMP, :CODVEN, 0, '+IIF(tmtTipMet=tmeFaturamento,'0,','')+' 0, 0, 0, 0) ');
    End
    Else
    Begin
      qryCadIns.SQL.Add(' INSERT INTO ' + strCadMet);
      qryCadIns.SQL.Add('  (AUTOINCREM, MET_MESANO, MET_CODEMP, MET_CODVEN, MET_TOTMET, '+IIF(tmtTipMet=tmeFaturamento,'MET_TOTFRE,','')+' MET_MARGEM) ');
      qryCadIns.SQL.Add(' VALUES');
      qryCadIns.SQL.Add('  (:AUTOIN, :MESANO, :CODEMP, :CODVEN, 0, '+IIF(tmtTipMet=tmeFaturamento,'0,','')+' 0) ');
    End;

    qryCadMet.SQL.Clear;
    qryCadMet.SQL.Add(' SELECT OPE_CODOPE FROM CADOPE ');
    qryCadMet.SQL.Add(' LEFT JOIN '  + strCadMet + ' ON           ');
    qryCadMet.SQL.Add('   OPE_CODOPE = MET_CODVEN AND ');
    qryCadMet.SQL.Add('   MET_MESANO = :MESANO        ');
    qryCadMet.SQL.Add(' WHERE                         ');
    qryCadMet.SQL.Add('   MET_CODVEN IS NULL AND      ');
    qryCadMet.SQL.Add('   OPE_INTEXT IN ("I","E","D","G","S") ');
    qryCadMet.ParamByName('MESANO').AsString := strMesAno;
    qryCadMet.Open;
    qryCadMet.First;

    Result := Not qryCadMet.IsEmpty;

    If Assigned(pgbProgresso) Then
    Begin
      pInfoStatusGravacao('Aguarde... Carregando Metas', pgbProgresso);
      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := qryCadMet.RecordCount;

      if Not Result then
        pgbProgresso.Position := 100;
    End;

    While Not qryCadMet.Eof Do
    Begin
      if (not fVerificaJaInseriu) then
      begin
        fStartTransaction;

        try
          qryCadIns.Close;
          qryCadIns.ParamByName('CODVEN').AsString := qryCadMet.FieldByName('OPE_CODOPE').AsString;
          qryCadIns.ParamByName('MESANO').AsString := strMesAno;
          qryCadIns.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryCadIns.ParamByName('AUTOIN').AsString := fRetAutoIncrem(strCadMet, VS_strCodEmp);
          qryCadIns.ExecSQL;

          fCommit;
        except on E: Exception do
          begin
            fRollback;
            Result := False;
            pMensagensErro(E.Message, '[fIncluiRegistros]');
          end;
        end;
      end;

      pStepStatusGravacao(pgbProgresso);
      qryCadMet.Next;
    End;

    qryCadMet.Close;
  finally
    FreeAndNil(qryCadMet);
    FreeAndNil(qryCadIns);
  end;
End;

procedure TfrmCadMetasValor.pInfoStatusGravacao(strInformacao: String;
  pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
end;

function TfrmCadMetasValor.fCopiaSubMetas(
  pgbProgresso: TcxProgressBar): Boolean;
  Var
    cdsDados : TUniClientDataSet;
    strCodVen: String;
    i: Integer;
begin
  Try
    blnChecarCemPorCento := False;
    strCodVen            := cdsConsulta.FieldByName('MET_CODVEN').AsString;

    If blnPorMarca Then
    Begin
      {******************************************************}
      {* EXCLUI DO CLIENT AS MARCAS DE TODOS OS VENDEDORES, *}
      {* EXCETO O VENDEDOR SELECIONADO                      *}
      {***************************************************MM*}
      With frmCadMetasMarca.cdsConsulta Do
      Begin
        Filtered := False;
        Filter   := ' MET_MESANO  = ' + QuotedStr(fTiraCaracEspeciais(mskDtaAtual.Text)) + ' AND ' +
                    ' MET_CODVEN <> ' + QuotedStr(strCodVen);
        Filtered := True;

        If (Active) And (Not IsEmpty) Then
        Begin
          pInfoStatusGravacao('Aguarde... Deletando Marca', pgbProgresso);
          pgbProgresso.Position       := 0;
          pgbProgresso.Properties.Max := RecordCount;

          For i := 1 To RecordCount Do
          Begin
            If Not fEmptyStr(edtCodEmp.Text) Then
            Begin
              If (fRetEmpresaOperador(FieldByName('MET_CODVEN').AsString)) = edtCodEmp.Text Then
                Delete
              Else
                Next;
            End
            Else
              Delete;

            pStepStatusGravacao(pgbProgresso);
          End;
        End;
      End;
    End
    Else
    Begin
      {*************************************************************}
      {* EXCLUI DO CLIENT AS LINHAS/GRUPOS DE TODOS OS VENDEDORES, *}
      {* EXCETO O VENDEDOR SELECIONADO                             *}
      {**********************************************************MM*}
      With frmCadMetasGrupo.cdsConsulta Do
      Begin
        Filtered := False;
        Filter   := ' MET_MESANO  = ' + QuotedStr(fTiraCaracEspeciais(mskDtaAtual.Text)) + ' AND ' +
                    ' MET_CODVEN <> ' + QuotedStr(strCodVen);
        Filtered := True;

        If (Active) And (Not IsEmpty) Then
        Begin
          pInfoStatusGravacao('Aguarde... Deletando Linha/Grupo', pgbProgresso);
          pgbProgresso.Position       := 0;
          pgbProgresso.Properties.Max := RecordCount;

          For i := 1 To RecordCount Do
          Begin
            If Not fEmptyStr(edtCodEmp.Text) Then
            Begin
              If (fRetEmpresaOperador(FieldByName('MET_CODVEN').AsString)) = edtCodEmp.Text Then
                Delete
              Else
                Next;
            End
            Else
              Delete;
            pStepStatusGravacao(pgbProgresso);
          End;
        End;
      End;
    End;

    {************************************************}
    {* COPIA AS LINHAS/GRUPOS QUE SERÃO REPASSADOS  *}
    {*********************************************MM*}
    cdsDados      := TUniClientDataSet.Create(Nil);
    If blnPorMarca Then
      cdsDados.Data := frmCadMetasMarca.cdsConsulta.Data
    Else
      cdsDados.Data := frmCadMetasGrupo.cdsConsulta.Data;

    {*************************}
    {* INSERE DADOS COPIADOS *}
    {**********************MM*}
    blnEstavaFiltrado := cdsConsulta.Filtered;
    If blnEstavaFiltrado Then
      cdsConsulta.Filtered := False;

    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := cdsConsulta.RecordCount;

    cdsConsulta.First;
    While Not cdsConsulta.EOF Do
    Begin
      If blnPorMarca Then
        pInfoStatusGravacao('Aguarde... Copiando Marca', pgbProgresso)
      ELse
        pInfoStatusGravacao('Aguarde... Copiando Linha/Grupo', pgbProgresso);

      pStepStatusGravacao(pgbProgresso);

      if (strCodVen <> cdsConsulta.FieldByName('MET_CODVEN').AsString) Then
      Begin
        cdsDados.First;
        While Not cdsDados.Eof Do
        Begin
          If IIF(fEmptyStr(edtCodEmp.Text), True, (fRetEmpresaOperador(cdsDados.FieldByName('MET_CODVEN').AsString) = edtCodEmp.Text)) Then
          Begin
            If blnPorMarca Then
            Begin
              frmCadMetasMarca.cdsConsulta.Tag := 1;

              frmCadMetasMarca.cdsConsulta.Insert;
              frmCadMetasMarca.cdsConsulta.FieldByName('MET_MESANO').AsString := fTiraCaracEspeciais(mskDtaAtual.Text);
              frmCadMetasMarca.cdsConsulta.FieldByName('MET_CODVEN').AsString := cdsConsulta.FieldByName('MET_CODVEN').AsString;
              frmCadMetasMarca.cdsConsulta.FieldByName('MET_CODEMP').AsString := VS_strCodEmp;
              frmCadMetasMarca.cdsConsulta.FieldByName('MET_CODMAR').AsString := cdsDados.FieldByName('MET_CODMAR').AsString;
              frmCadMetasMarca.cdsConsulta.FieldByName('MET_PERMAR').AsFloat  := cdsDados.FieldByName('MET_PERMAR').AsFloat;
              frmCadMetasMarca.cdsConsulta.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(strDetMet, VS_strCodEmp);
              frmCadMetasMarca.cdsConsulta.Post;

              frmCadMetasMarca.cdsConsulta.Tag := 0;
            End
            Else
            Begin
              frmCadMetasGrupo.cdsConsulta.Tag := 1;

              frmCadMetasGrupo.cdsConsulta.Insert;
              frmCadMetasGrupo.cdsConsulta.FieldByName('MET_MESANO').AsString := fTiraCaracEspeciais(mskDtaAtual.Text);
              frmCadMetasGrupo.cdsConsulta.FieldByName('MET_CODVEN').AsString := cdsConsulta.FieldByName('MET_CODVEN').AsString;
              frmCadMetasGrupo.cdsConsulta.FieldByName('MET_CODEMP').AsString := VS_strCodEmp;
              frmCadMetasGrupo.cdsConsulta.FieldByName('MET_CODGRU').AsString := cdsDados.FieldByName('MET_CODGRU').AsString;
              frmCadMetasGrupo.cdsConsulta.FieldByName('MET_PERGRU').AsFloat  := cdsDados.FieldByName('MET_PERGRU').AsFloat;
              frmCadMetasGrupo.cdsConsulta.FieldByName('MET_MARGRU').AsFloat  := cdsDados.FieldByName('MET_MARGRU').AsFloat;
              frmCadMetasGrupo.cdsConsulta.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(strDetMet, VS_strCodEmp);
              frmCadMetasGrupo.cdsConsulta.FieldByName('MET_DEFTIP').AsString := cdsDados.FieldByName('MET_DEFTIP').AsString;
              frmCadMetasGrupo.cdsConsulta.Post;

              frmCadMetasGrupo.cdsConsulta.Tag := 0;
            End;
          End;

          cdsDados.Next;
        End;
      End;
      cdsConsulta.Next;
    End;

    If blnEstavaFiltrado Then
      cdsConsulta.Filtered := True;

    blnChecarCemPorCento := True;
    Result               := True;
    FreeAndNil(cdsDados);

  Except

    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCopiaSubMetas]');
    End;

  End;

end;

function TfrmCadMetasValor.fExibeCamposECMVBI: Boolean;
begin
  Result := ((blnECMVBI) And (strCadMet = 'CADMET'));
end;

function TfrmCadMetasValor.fGetSql(blnLike: Boolean): String;
  procedure pAdd(strSQL: String);
  Begin
    Result := Result + IIF(fEmptyStr(Result), '', #13#10) + strSQL;
  End;
Begin
  Result := '';

  pAdd('SELECT');
  pAdd('  M.AUTOINCREM, ');
  pAdd('  M.MET_CODEMP, ');
  pAdd('  M.MET_MESANO, ');
  pAdd('  M.MET_CODVEN, ');
  pAdd('  M.MET_TOTMET, ');
  pAdd('  M.MET_TOTGAL, ');
  pAdd('  M.MET_MARGEM, ');  
  If (tmtTipMet = tmeFaturamento) Then
    pAdd('         M.MET_TOTFRE, ')
  Else   
    pAdd(' 0.00 AS MET_TOTFRE,   ');

  If fExibeCamposECMVBI() Then
  Begin
    pAdd('  M.MET_ATEDIA, ');
    pAdd('  M.MET_TICMED, ');
    pAdd('  M.MET_ITEDOC, ');
  End;

  pAdd('  (SELECT G.OPE_NOMOPE FROM CADOPE G WHERE G.OPE_CODOPE = O.OPE_CODGER) AS GERENT,');
  pAdd('  (SELECT S.OPE_NOMOPE FROM CADOPE S WHERE S.OPE_CODOPE = O.OPE_CODSUB) AS SUBGER,');
  pAdd('  CASE');
  pAdd('    WHEN IFNULL(O.OPE_INTEXT, "") = "G" THEN "GERENTE"');
  pAdd('    WHEN IFNULL(O.OPE_INTEXT, "") = "S" THEN "SUB-GERENTE"');
  pAdd('    ELSE "VENDEDOR"');
  pAdd('  END AS FUNCAO');
  pAdd('FROM');
  pAdd('  '+ strCadMet + ' M');
  pAdd('  LEFT JOIN CADOPE O ON O.OPE_CODOPE = MET_CODVEN');
  pAdd('WHERE');
  pAdd('  M.MET_MESANO = :MESANO        AND');
  pAdd('  O.OPE_STATUS = "A"            AND');
  pAdd('  O.OPE_INTEXT IN ("I","E","D","G","S") AND');

  If Not fEmptyStr(edtCodEmp.Text) Then
    pAdd('  O.OPE_CODEMP = :CODEMP')
  Else
    pAdd('  LOCATE(O.OPE_CODEMP, :CODEMP) > 0');

  pAdd('GROUP BY');
  pAdd('  MET_MESANO,');
  pAdd('  MET_CODVEN');
End;

function TfrmCadMetasValor.fGravaMeta(pgbProgresso: TcxProgressBar): Boolean;
  Var
    intNroErr: Integer;
    bkmMarca: TBookmark;
    strUPD: String;
    qryUPD: TUniQuery;

    function fGetSQLUpdate : String;
    begin

      Result := '';
      Result := Result + 'UPDATE     ';
      Result := Result + '  METFAG G ';
      Result := Result + '  INNER JOIN METFAD D ON (D.FAD_SEQGER = G.AUTOINCREM) ';
      Result := Result + 'SET                          ';
      Result := Result + '  D.FAD_VALFAT = :VALFAT,    ';
      Result := Result + '  D.FAD_PREM01 = :PREM01,    ';
      Result := Result + '  D.FAD_PREM02 = :PREM02,    ';
      Result := Result + '  D.FAD_PREM03 = :PREM03,    ';
      Result := Result + '  D.FAD_PREM04 = :PREM04     ';
      Result := Result + 'WHERE                        ';
      Result := Result + '  G.MET_MESANO = :MESANO AND ';
      Result := Result + '  (LOCATE(G.MET_CODEMP, :CODEMP) > 0) AND ';

      Result := Result + '  D.FAD_CODVEN = :CODVEN';

    end;

    procedure pAtualizaVlrFaturamentoCadMetaRentabilidade;
      var
        qryUpdate : TUniQuery;
    begin

      If cdsConsulta.IsEmpty Then
        Exit;

      If fEmptyStr(cdsConsulta.FieldByName('MET_MESANO').AsString) Then
        Exit;

      If fEmptyStr(cdsConsulta.FieldByName('MET_CODVEN').AsString) Then
        Exit;

      qryUpdate := fCriaQuery;

      Try

        qryUpdate.Close;
        qryUpdate.SQL.Clear;
        qryUpdate.SQL.Add(fGetSQLUpdate);
        qryUpdate.ParamByName('MESANO').AsString := cdsConsulta.FieldByName('MET_MESANO').AsString;
        qryUpdate.ParamByName('CODEMP').AsString := fRetEmpresaOperador(cdsConsulta.FieldByName('MET_CODVEN').AsString);
        qryUpdate.ParamByName('CODVEN').AsString := cdsConsulta.FieldByName('MET_CODVEN').AsString;
        qryUpdate.ParamByName('VALFAT').AsFloat  := cdsConsulta.FieldByName('MET_TOTMET').AsFloat;
        pPreencheParametrosPremios(qryUpdate, cdsConsulta.FieldByName('MET_TOTMET').AsFloat);
        qryUpdate.ExecSQL;

      Finally
        FreeAndNil(qryUpdate);
      End;

    end;

begin
  Try

    fStartTransaction;

    With cdsConsulta Do
    Begin
      bkmMarca := GetBookmark;
      DisableControls;

      Try
        intNroErr := 0;

        pInfoStatusGravacao('Aguarde... Gravando Metas', pgbProgresso);

        blnEstavaFiltrado := cdsConsulta.Filtered;
        If blnEstavaFiltrado Then
          cdsConsulta.Filtered := False;

        pgbProgresso.Position := 0;
        pgbProgresso.Properties.Max := RecordCount + 1;

        qryUPD := fCriaQuery(Self);

        strUPD := '';
        strUPD := strUPD + ' UPDATE ' + strCadMet;
        strUPD := strUPD + '   SET MET_TOTMET = :TOTMET, ';
        If (tmtTipMet = tmeFaturamento) Then
          strUPD := strUPD + '       MET_TOTFRE = :TOTFRE, ';
        strUPD := strUPD + '       MET_MARGEM = :MARGEM  ';

        If fExibeCamposECMVBI() Then
        Begin
          strUPD := strUPD + '      ,MET_ATEDIA = :ATEDIA, ';
          strUPD := strUPD + '       MET_TICMED = :TICMED, ';
          strUPD := strUPD + '       MET_ITEDOC = :ITEDOC ';
        End;

        strUPD := strUPD + ' WHERE ';
        strUPD := strUPD + '   AUTOINCREM = :AUTINC ';

        First;

        While Not Eof Do
        Begin
          qryUPD.Close;
          qryUPD.SQL.Clear;
          qryUPD.Params.Clear;

          qryUPD.SQL.Add(strUPD);
          qryUPD.ParamByName('TOTMET').AsFloat  := FieldByName('MET_TOTMET').AsFloat;
          If (tmtTipMet = tmeFaturamento) Then
            qryUPD.ParamByName('TOTFRE').AsFloat  := FieldByName('MET_TOTFRE').AsFloat;
          qryUPD.ParamByName('MARGEM').AsFloat  := FieldByName('MET_MARGEM').AsFloat;

          If fExibeCamposECMVBI() Then
          Begin
            qryUPD.ParamByName('ATEDIA').AsFloat  := FieldByName('MET_ATEDIA').AsFloat;
            qryUPD.ParamByName('TICMED').AsFloat  := FieldByName('MET_TICMED').AsFloat;
            qryUPD.ParamByName('ITEDOC').AsFloat  := FieldByName('MET_ITEDOC').AsFloat;
          End;

          qryUPD.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
          qryUPD.ExecSQL;

          If (Not fExisteMetFad) Then
            pInserirMetaRentabilidade
          Else
            pAtualizaVlrFaturamentoCadMetaRentabilidade;

          pStepStatusGravacao(pgbProgresso);

          Next;
        End;

        FreeAndNil(qryUPD);

        If blnEstavaFiltrado Then
          cdsConsulta.Filtered := True;

        GotoBookmark(bkmMarca);
        FreeBookmark(bkmMarca);
        EnableControls;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[Inserir Registro]');
          intNroErr := 1;
        End;
      End;
    End;

    If blnPorSubMetas And (intNroErr = 0) Then
    Begin
      if blnPorMarca then
      Begin
        intNroErr := frmCadMetasMarca.cdsConsulta.ApplyUpdates(-1);
      End
      Else
      Begin
        intNroErr := frmCadMetasGrupo.cdsConsulta.ApplyUpdates(-1);
      End;
    End;

    If intNroErr = 0 Then
    Begin
      fCommit;
      Result := True;
    End
    Else
    Begin
      fRollBack;
      Result := False;
    End;

    pStepStatusGravacao(pgbProgresso);

  Except

    On E : Exception Do
    Begin
      fRollBack;
       Result := False;
      pMensagensErro(E.Message, '[pGravarMetas]');
    End;

  End;

end;

procedure TfrmCadMetasValor.pAbreConsulta(blnInciar: Boolean);
Begin
  blnChecarCemPorCento := False;

  If cdsConsulta.Active Then
    cdsConsulta.CancelUpdates;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fIncluiRegistros;
    frmGravando.ShowModal;
    pFreeAndNil(frmGravando);
  Except
    On E: Exception Do
    Begin
      pFreeAndNil(frmGravando);
      pMensagensErro(E.Message, '');
    End;
  End;

  fAbreConsulta;
  pProcessarTotais;

  If blnPorSubMetas Then
  Begin
    if blnPorMarca then
    Begin
      frmCadMetasMarca.strMesAno := strMesAno;

      If blnInciar Then
      Begin
        frmCadMetasMarca.Dock(pnlTail,pnlTail.BoundsRect);
        frmCadMetasMarca.Show;
      End
      Else
        frmCadMetasMarca.pAbreConsulta;
    End
    Else
    Begin
      frmCadMetasGrupo.strMesAno := strMesAno;

      If blnInciar Then
      Begin
        frmCadMetasGrupo.Dock(pnlTail,pnlTail.BoundsRect);
        frmCadMetasGrupo.Show;
      End
      Else
        frmCadMetasGrupo.pAbreConsulta;
    End;

    cdsConsulta.FieldByName('MET_TOTMET').FocusControl;

    pSetaFiltro;
  End;

  blnChecarCemPorCento := True;

End;

procedure TfrmCadMetasValor.FormShow(Sender: TObject);
var
  qryEmpOpe: TUniQuery;
  objCol : TColumn;
  objField : TField;
begin
  inherited;

  If Not blnPorSubMetas Then
  Begin
    case tmtTipMet Of
      tmeFaturamento: Begin
                        strCadMet := 'CADMET';
                        Caption   := 'Cadastro de Metas de Vendedores - Faturamento';
                      End;
      tmeRecebimento: Begin
                        strCadMet := 'CADMTR';
                        Caption   := 'Cadastro de Metas de Vendedores - Recebimento';
                      End;
    end;
  End;

  If fExibeCamposECMVBI() Then
  Begin
    objField := TFloatField.Create(qryConsulta);
    objField.FieldName := 'MET_ATEDIA';
    objField.Name := 'qryConsultaMET_ATEDIA';
    objField.DataSet := qryConsulta;

    objField := TFloatField.Create(qryConsulta);
    objField.FieldName := 'MET_TICMED';
    objField.Name := 'qryConsultaMET_TICMED';
    objField.DataSet := qryConsulta;

    objField := TFloatField.Create(qryConsulta);
    objField.FieldName := 'MET_ITEDOC';
    objField.Name := 'qryConsultaMET_ITEDOC';
    objField.DataSet := qryConsulta;

    objField := TFloatField.Create(cdsConsulta);
    objField.FieldName := 'MET_ATEDIA';
    objField.Name := 'cdsConsultaMET_ATEDIA';
    objField.DataSet := cdsConsulta;

    objField := TFloatField.Create(cdsConsulta);
    objField.FieldName := 'MET_TICMED';
    objField.Name := 'cdsConsultaMET_TICMED';
    objField.DataSet := cdsConsulta;

    objField := TFloatField.Create(cdsConsulta);
    objField.FieldName := 'MET_ITEDOC';
    objField.Name := 'cdsConsultaMET_ITEDOC';
    objField.DataSet := cdsConsulta;

    objCol := dbgConsulta.Columns.Add;
    objCol.FieldName := 'MET_ATEDIA';
    objCol.Alignment := taRightJustify;
    objCol.Expanded := False;
    objCol.Title.Alignment := taRightJustify;
    objCol.Title.Caption := 'Meta Atend.Diário';
    objCol.Width := 110;
    objCol.Visible := True;

    objCol := dbgConsulta.Columns.Add;
    objCol.FieldName := 'MET_TICMED';
    objCol.Alignment := taRightJustify;
    objCol.Expanded := False;
    objCol.Title.Alignment := taRightJustify;
    objCol.Title.Caption := 'Meta Ticket Médio';
    objCol.Width := 110;
    objCol.Visible := True;

    objCol := dbgConsulta.Columns.Add;
    objCol.FieldName := 'MET_ITEDOC';
    objCol.Alignment := taRightJustify;
    objCol.Expanded := False;
    objCol.Title.Alignment := taRightJustify;
    objCol.Title.Caption := 'Meta Itens por  Doc';
    objCol.Width := 110;
    objCol.Visible := True;
  End;


  blnSempreRelerBanco := False;
  blnTemSelecao       := False;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  pnlTail.Visible := blnPorSubMetas;
  btnPerGru.Visible := blnPorSubMetas;

  If tmtTipMet = tmeRecebimento  Then
   dbgConsulta.Columns[6].Visible := False;

  dbgConsulta.Columns[7].Title.Caption := IfThen(((fCfgSis('MARMKP') =  1) or (fCfgSis('MARMKP') =  5)), 'Margem%','Markup%');

  If blnPorSubMetas Then
  Begin
    If blnPorMarca Then
    Begin
      pCriarFormularios(TfrmCadMetasMarca, frmCadMetasMarca);
      Caption           := 'Cadastro de Metas de Vendedores em Valor - Marca';
      btnPerGru.Caption := '[ F9 ] Percentual Marcas';
    End
    Else
    Begin
      pCriarFormularios(TfrmCadMetasGrupo, frmCadMetasGrupo);
      Caption           := 'Cadastro de Metas de Vendedores em Valor - Linha/Grupo';
      btnPerGru.Caption := '[ F9 ] Percentual Grupos';
    End;

    blnLiberado := fVerificaAcessoSistema('METVAL');
  End
  Else
    blnLiberado := fVerificaAcessoSistema('METVEN');

  If Not blnLiberado Then
    shpLiberado.Brush.Color  := clRed
  Else
    shpLiberado.Brush.Color  := clGreen;

  pAbreConsulta(True);

  qryEmpOpe := fCriaQuery;
  try
    with qryEmpOpe do
    begin
      Close;
      SQL.Add('SELECT OPE_CODEMP FROM CADOPE WHERE OPE_CODOPE = :CODOPE');
      ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      Open;
      if not IsEmpty then
      begin
        edtCodEmp.Text := FieldByName('OPE_CODEMP').AsString;
        fValidaCampos(edtCodEmp);
      end;
    end;
  finally
    FreeAndNil(qryEmpOpe);
  end;

  blnLiberado := fVerificaAcessoSistema('OSECMV');
  If Not blnLiberado Then
  Begin
    If edtCodEmp.Text = '' Then
      edtCodEmp.Text := VS_strCodEmp;
    edtCodEmp.Enabled := False;
  End;

  pVerdeVermelho(edtCodEmp, shpCodEmp, fVerificaAcessoSistema('OSECMV'), False, False);
end;

procedure TfrmCadMetasValor.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  if blnPorMarca then
  Begin
    If blnPorSubMetas And (Not frmCadMetasMarca.fValidaTotalMarca) Then
      Exit;
  End
  Else
  Begin
    If blnPorSubMetas And (Not frmCadMetasGrupo.fValidaTotalGrupo) Then
      Exit;
  End;

  If (Not fValidaEdicao(Sender)) Then
    Exit;

  If fMensagem('','Confirma a gravação das metas?',['&Sim','&Não']) = 2 Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravaMeta;
    frmGravando.ShowModal;
    pFreeAndNil(frmGravando);
  Except
    On E: Exception Do
    Begin
      pFreeAndNil(frmGravando);
      pMensagensErro(E.Message, '');
    End;
  End;

  pnlMesAnoOrigem.Visible := False;
end;

procedure TfrmCadMetasValor.btnCopiarMetasClick(Sender: TObject);
begin
  inherited;

  If (Not fValidaEdicao(Sender)) Then
    Exit;

  If pnlMesAnoOrigem.Visible Then
  Begin
    pnlMesAnoOrigem.Visible := False;
    mskDtaOrigem.Clear;
  End Else
  Begin
    pnlMesAnoOrigem.Visible := True;
    blnMudarFoco := True;
    pSetFocus(mskDtaOrigem);
  End;
end;

procedure TfrmCadMetasValor.btnImportarMetasClick(Sender: TObject);
begin
  inherited;
  pImportarMetas;
end;

procedure TfrmCadMetasValor.btnPerGruClick(Sender: TObject);
  Var
    blnSubMetasVazio : Boolean;
    strSubMeta : String;
begin
  inherited;

  If Not btnPerGru.Visible Then
    Exit;

  if blnPorMarca then
  Begin
    blnSubMetasVazio := frmCadMetasMarca.cdsConsulta.IsEmpty;
    strSubMeta       := 'Marca';
  End
  Else
  Begin
    blnSubMetasVazio := frmCadMetasGrupo.cdsConsulta.IsEmpty;
    strSubMeta       := 'Linha/Grupo';
  End;

  If (Not blnSubMetasVazio) Then
  Begin
    If fMensagem('','Repassar as metas de ' + strSubMeta + ' do vendedor ' + #13 +
                     cdsConsulta.FieldByName('OPE_NOMOPE').AsString + #13 +
                    'para todos os outros vendedores?',['&Sim','&Não']) = 1 Then
    Begin
      Try
        pCriarFormularios(TfrmGravando, frmGravando);
        frmGravando.fExecutarAcao := fCopiaSubMetas;
        frmGravando.ShowModal;
        pFreeAndNil(frmGravando);
      Except
        On E: Exception Do
        Begin
          pFreeAndNil(frmGravando);
          pMensagensErro(E.Message, '');
        End;
      End;
    End;
  End;
End;

Function TfrmCadMetasValor.fCopiaMeta: Boolean;
Begin
  cdsConsulta.DisableControls;

  Try
    blnChecarCemPorCento := False;
    
    Result := fCopiaMetaCadMet;

    If Result and blnPorSubMetas Then
      pCopiaMetaDetMet;

  Except
  	On E: Exception Do
    Begin
      Result := False;

      blnChecarCemPorCento := True;

      if blnPorMarca then
      begin
        frmCadMetasMarca.cdsConsulta.Filtered := True;

        If blnPorSubMetas Then
          frmCadMetasMarca.cdsConsulta.Tag := 0;
      end
      else
      begin
        frmCadMetasGrupo.cdsConsulta.Filtered := True;

        If blnPorSubMetas Then
          frmCadMetasGrupo.cdsConsulta.Tag := 0;
      end;

    	pMensagensErro(E.Message,'[fCopiaMeta]');
    End;
  End;

  cdsConsulta.First;

  If blnPorSubMetas Then
    pSetaFiltro;

  blnChecarCemPorCento := True;

  cdsConsulta.EnableControls;
End;

procedure TfrmCadMetasValor.pCopiaMetaDetMet;
  Var
    qryDetMet: TUniQuery;
Begin
  qryDetMet := fCriaQuery;
  With qryDetMet, SQL Do
  Begin
    Clear;
    Add(' SELECT * FROM ' + strDetMet);
    Add('  LEFT JOIN CADOPE O ON O.OPE_CODOPE = MET_CODVEN');
    Add(' WHERE                   ');
    Add('   MET_MESANO = :MESANO  AND ');
    Add('   OPE_INTEXT IN ("I","E","D","G","S") AND ');

    If Not fEmptyStr(edtCodEmp.Text) Then
      Add('  O.OPE_CODEMP = :CODEMP')
    Else
      Add('  LOCATE(O.OPE_CODEMP, :CODEMP) > 0');

    ParamByName('MESANO').AsString := strMesAnoOri;

    If Not fEmptyStr(edtCodEmp.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text
    Else
      ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;

    Open;
  End;

  If blnPorMarca Then
  Begin
    frmCadMetasMarca.cdsConsulta.DisableControls;
    frmCadMetasMarca.cdsConsulta.Tag := 1;

    // EmptyDataSet;  // NAO FUNCIONOU NO COMMIT, DUPLICANDO TODOS OS REGISTROS

    frmCadMetasMarca.cdsConsulta.Filtered := False;

    frmCadMetasMarca.cdsConsulta.First;
    While Not frmCadMetasMarca.cdsConsulta.Eof Do
    Begin

      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        If (fRetEmpresaOperador(frmCadMetasMarca.cdsConsulta.FieldByName('MET_CODVEN').AsString)) = edtCodEmp.Text Then
          frmCadMetasMarca.cdsConsulta.Delete
        Else
          frmCadMetasMarca.cdsConsulta.Next;
      End
      Else
        frmCadMetasMarca.cdsConsulta.Delete

    End;

    frmCadMetasMarca.cdsConsulta.Filtered := True;

    While Not qryDetMet.Eof Do
    Begin

      frmCadMetasMarca.cdsConsulta.Insert;
      frmCadMetasMarca.cdsConsulta.FieldByName('MET_CODVEN').AsString := qryDetMet.FieldByName('MET_CODVEN').AsString;
      frmCadMetasMarca.cdsConsulta.FieldByName('MET_CODEMP').AsString := qryDetMet.FieldByName('MET_CODEMP').AsString;
      frmCadMetasMarca.cdsConsulta.FieldByName('MET_CODMAR').AsString := qryDetMet.FieldByName('MET_CODMAR').AsString;
      frmCadMetasMarca.cdsConsulta.FieldByName('MET_PERMAR').AsString := qryDetMet.FieldByName('MET_PERMAR').AsString;
      frmCadMetasMarca.cdsConsulta.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(strDetMet, VS_strCodEmp);
      frmCadMetasMarca.cdsConsulta.FieldByName('MET_MESANO').AsString := strMesAno;
      frmCadMetasMarca.cdsConsulta.Post;

      qryDetMet.Next;
    End;

    frmCadMetasMarca.cdsConsulta.Tag := 0;

    frmCadMetasMarca.cdsConsulta.EnableControls;
  End
  Else
  Begin
    frmCadMetasGrupo.cdsConsulta.DisableControls;
    frmCadMetasGrupo.cdsConsulta.Tag := 1;

    // EmptyDataSet;  // NAO FUNCIONOU NO COMMIT, DUPLICANDO TODOS OS REGISTROS

    frmCadMetasGrupo.cdsConsulta.Filtered := False;

    frmCadMetasGrupo.cdsConsulta.First;
    While Not frmCadMetasGrupo.cdsConsulta.Eof Do
    Begin

      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        If (fRetEmpresaOperador(frmCadMetasGrupo.cdsConsulta.FieldByName('MET_CODVEN').AsString)) = edtCodEmp.Text Then
          frmCadMetasGrupo.cdsConsulta.Delete
        Else
          frmCadMetasGrupo.cdsConsulta.Next;
      End
      Else
        frmCadMetasGrupo.cdsConsulta.Delete;

    End;

    frmCadMetasGrupo.cdsConsulta.Filtered := True;

    While Not qryDetMet.Eof Do
    Begin

      frmCadMetasGrupo.cdsConsulta.Insert;
      frmCadMetasGrupo.cdsConsulta.FieldByName('MET_CODVEN').AsString := qryDetMet.FieldByName('MET_CODVEN').AsString;
      frmCadMetasGrupo.cdsConsulta.FieldByName('MET_CODEMP').AsString := qryDetMet.FieldByName('MET_CODEMP').AsString;
      frmCadMetasGrupo.cdsConsulta.FieldByName('MET_CODGRU').AsString := qryDetMet.FieldByName('MET_CODGRU').AsString;
      frmCadMetasGrupo.cdsConsulta.FieldByName('MET_PERGRU').AsString := qryDetMet.FieldByName('MET_PERGRU').AsString;
      frmCadMetasGrupo.cdsConsulta.FieldByName('MET_MARGRU').AsString := qryDetMet.FieldByName('MET_MARGRU').AsString;
      frmCadMetasGrupo.cdsConsulta.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(strDetMet, VS_strCodEmp);
      frmCadMetasGrupo.cdsConsulta.FieldByName('MET_MESANO').AsString := strMesAno;
      frmCadMetasGrupo.cdsConsulta.FieldByName('MET_DEFTIP').AsString := qryDetMet.FieldByName('MET_DEFTIP').AsString;
      frmCadMetasGrupo.cdsConsulta.Post;

      qryDetMet.Next;
    End;

    frmCadMetasGrupo.cdsConsulta.Tag := 0;

    frmCadMetasGrupo.cdsConsulta.EnableControls;
  End;

  FreeAndNil(qryDetMet);
End;

Function TfrmCadMetasValor.fCopiaMetaCadMet: Boolean;
  Var
    qryCadMet: TUniQuery;
Begin
  Result := False;

  qryCadMet := fCriaQuery;
  With qryCadMet, SQL Do
  Begin
    Clear;
    Add(' SELECT * FROM ' + strCadMet);
    Add('  LEFT JOIN CADOPE O ON O.OPE_CODOPE = MET_CODVEN');
    Add(' WHERE                   ');
    Add('   MET_MESANO = :MESANO AND ');

    If Not fEmptyStr(edtCodEmp.Text) Then
      Add('  O.OPE_CODEMP = :CODEMP')
    Else
      Add('  LOCATE(O.OPE_CODEMP, :CODEMP) > 0');

    ParamByName('MESANO').AsString := strMesAnoOri;

    If Not fEmptyStr(edtCodEmp.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text
    Else
      ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;

    Open;

    While Not Eof Do
    Begin
      If cdsConsulta.Locate('MET_CODVEN', FieldByName('MET_CODVEN').AsString, []) Then
      Begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('MET_TOTMET').AsFloat := FieldByName('MET_TOTMET').AsFloat;
        If (tmtTipMet = tmeFaturamento) Then
          cdsConsulta.FieldByName('MET_TOTFRE').AsFloat := FieldByName('MET_TOTFRE').AsFloat;
        cdsConsulta.FieldByName('MET_MARGEM').AsFloat := FieldByName('MET_MARGEM').AsFloat;

        If fExibeCamposECMVBI() Then
        Begin
          cdsConsulta.FieldByName('MET_ATEDIA').AsFloat := FieldByName('MET_ATEDIA').AsFloat;
          cdsConsulta.FieldByName('MET_TICMED').AsFloat := FieldByName('MET_TICMED').AsFloat;
          cdsConsulta.FieldByName('MET_ITEDOC').AsFloat := FieldByName('MET_ITEDOC').AsFloat;
        End;

        cdsConsulta.Post;

        Result := True;
      End;

      Next;
    End;

  End;

  FreeAndNil(qryCadMet);
End;

procedure TfrmCadMetasValor.mskDtaAtualKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Key = Char(VK_RETURN) Then
    pSetFocus(edtCodEmp);
end;

procedure TfrmCadMetasValor.pCopiaMeta;
  Var
    strAno: String;
    strMes: String;
begin
  //**********************************************//
  // COMPLETA O ANO PARA 4 DÍGITOS CASO O USUÁRIO //
  // DIGITE APENAS DOIS DÍGITOS NO ANO. EX:       //
  // SE FOR DIGITADO 07, COMPLETA PARA 2007       //
  //*******************************************RL*//
  If (RightStr(mskDtaOrigem.Text,4) <> '') And (LeftStr(mskDtaOrigem.Text,2) <> '') Then
  Begin
    strMes := Trim(LeftStr(mskDtaOrigem.Text,2));
    strAno := Trim(RightStr(mskDtaOrigem.Text,4));

    If Length(strAno) = 1 Then
      mskDtaOrigem.Text := strMes + '/200' + strAno
    Else If Length(strAno) = 2 Then
      mskDtaOrigem.Text := strMes + '/20' + strAno
    Else If Length(strAno) = 3 Then
      mskDtaOrigem.Text := strMes + '/2' + strAno;

    strMesAnoOri := AnsiReplaceStr(mskDtaOrigem.Text, '/', '');

    If fCopiaMeta Then
    Begin
      pMensagemOK('Metas copiadas com sucesso!');
      mskDtaOrigem.Clear;
      pnlMesAnoOrigem.Visible := False;
    End
    Else
      pMensagemOK('Não há metas cadastradas para o Mês Origem informado!');

  End;
end;

function TfrmCadMetasValor.fSetParametros: Boolean;
begin
  Result := True;
  qryConsulta.ParamByName('MESANO').AsString := strMesAno;
  If Not fEmptyStr(edtCodEmp.Text) Then
    qryConsulta.ParamByName('CODEMP').AsString := edtCodEmp.Text
  Else
    qryConsulta.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;
end;

function TfrmCadMetasValor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {**************************************}
    {* VALIDA DATA DE ORIGEM              *}
    {***********************************RL*}
    If (Sender = mskDtaOrigem) Then
    Begin

      If pnlMesAnoOrigem.Visible Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaOrigem.Text)) Then
        Begin
          fMensagem('', 'Informar o mês / ano de origem !', ['&O k']);
          Result := False;
        End
        Else
        Begin

          Try
            strToDate('01/' + mskDtaOrigem.Text);
          Except
            fMensagem('', 'Mês / Ano inválido !', ['&O k']);
            Result := False;
          End;

          If Result Then
            pCopiaMeta;

        End;
      End Else
      Begin
        mskDtaOrigem.Clear;
      End;

    End

    {**************************************}
    {* VALIDA DATA ATUAL                  *}
    {***********************************RL*}
    Else If (Sender = mskDtaAtual) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaAtual.Text)) Then
      Begin
        fMensagem('', 'Informar o mês / ano atual !', ['&O k']);
        Result := False;
      End
      Else
      Begin

        Try
          mskDtaAtual.Text := fTrataAnoDataMesAno(mskDtaAtual.Text);
          strToDate('01/' + mskDtaAtual.Text);

          If Not SameText(fTiraCaracEspeciais(mskDtaAtual.Text), strMesAno) Then
          Begin
            strMesAno := fTiraCaracEspeciais(mskDtaAtual.Text);
            cdsConsulta.Close;
            pAbreConsulta(False);
            pSetFocus(mskDtaAtual);
          End;

        Except
          fMensagem('', 'Mês / Ano inválido !', ['&O k']);
          Result := False;
        End;

      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&OK']);
          Result := False;
        End
        Else
        Begin
          cdsConsulta.Close;
          pAbreConsulta(False);
          pSetFocus(edtCodEmp);
        End;
      End
      Else
      Begin
        cdsConsulta.Close;
        pAbreConsulta(False);
        pSetFocus(edtCodEmp);
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadMetasValor.fValidaEdicao(Sender: TObject): Boolean;
begin
  Try
    If (cdsConsulta.State = dsEdit) Then
    Begin
      cdsConsulta.Post;
      Result := True;
    End
    Else
      Result := True;
  Except
    Result := False;
  End;
end;

procedure TfrmCadMetasValor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F9) Then
    btnPerGru.Click

  Else If (Key = VK_F10) Then
    btnConfirmar.Click

  ELse If (Key = VK_F11) Then
    btnCopiarMetas.Click

  Else If (Shift = [ssAlt]) then
  Begin
    If (Key = Ord('B')) And blnPorSubMetas Then
      If blnPorMarca Then
        pSetFocus(frmCadMetasMarca.dbgConsulta)
      Else
        pSetFocus(frmCadMetasGrupo.dbgConsulta);
  End;

end;

procedure TfrmCadMetasValor.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;

end;

procedure TfrmCadMetasValor.FormDestroy(Sender: TObject);
begin
  inherited;

  If blnPorSubMetas Then
  Begin
    If blnPorMarca Then
      pFreeAndNil(frmCadMetasMarca)
    Else
      pFreeAndNil(frmCadMetasGrupo);
  End;

end;

procedure TfrmCadMetasValor.pSetaFiltro;
Begin
  If blnPorMarca Then
  Begin
    frmCadMetasMarca.cdsCadMet            := cdsConsulta;
    frmCadMetasMarca.cdsConsulta.Filter   := ' MET_MESANO = ' + QuotedStr(cdsConsulta.FieldByName('MET_MESANO').AsString) + ' AND ' +
                                             ' MET_CODVEN = ' + QuotedStr(cdsConsulta.FieldByName('MET_CODVEN').AsString);
    frmCadMetasMarca.cdsConsulta.Filtered := True;
    frmCadMetasMarca.pLimpaDados(False);
  End
  Else
  Begin
    frmCadMetasGrupo.cdsCadMet            := cdsConsulta;
    frmCadMetasGrupo.cdsConsulta.Filter   := ' MET_MESANO = ' + QuotedStr(cdsConsulta.FieldByName('MET_MESANO').AsString) + ' AND ' +
                                             ' MET_CODVEN = ' + QuotedStr(cdsConsulta.FieldByName('MET_CODVEN').AsString);
    frmCadMetasGrupo.cdsConsulta.Filtered := True;
    frmCadMetasGrupo.pLimpaDados(False);
  End;
End;

procedure TfrmCadMetasValor.pStepStatusGravacao(pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) Then
  Begin
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmCadMetasValor.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If blnPorSubMetas Then
    pSetaFiltro;

  if blnPorMarca then
  Begin
    If Assigned(frmCadMetasMarca) Then
    Begin
      frmCadMetasMarca.strCodVen := '';
      If (DataSet.Active) And (Not DataSet.IsEmpty) Then
        frmCadMetasMarca.strCodVen := DataSet.FieldByName('MET_CODVEN').AsString;
    End;
  End;

end;

procedure TfrmCadMetasValor.pnlTailEnter(Sender: TObject);
begin
  inherited;

  blnMudarFoco := False;
end;

procedure TfrmCadMetasValor.pnlTailExit(Sender: TObject);
begin
  inherited;

  blnMudarFoco := True;
end;

procedure TfrmCadMetasValor.pProcessarTotais;
var
  fltTotFat,
  fltTotFre,
  fltMedMar : Double;
  fltTotLin : Integer;
  cdsCopia  : TUniClientDataSet;
begin

  edtTotFat.Text := '0';
  edtTotFre.Text := '0';
  edtMedMar.Text := '0';

  fltTotFat := 0;
  fltTotFre := 0;
  fltMedMar := 0;
  fltTotLin := 0;

  If Not(cdsConsulta.Active) Then
    Exit;

  If (cdsConsulta.IsEmpty) Then
    Exit;

  cdsCopia := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsCopia, cdsConsulta);

  Try

    cdsCopia.First;
    While Not cdsCopia.Eof Do
    Begin

      fltTotFat := fltTotFat + cdsCopia.FieldByName('MET_TOTMET').AsFloat;
      fltTotFre := fltTotFre + cdsCopia.FieldByName('MET_TOTFRE').AsFloat;

      If (cdsCopia.FieldByName('MET_MARGEM').AsFloat > 0) Then
      Begin
        fltMedMar := fltMedMar + cdsCopia.FieldByName('MET_MARGEM').AsFloat;
        fltTotLin := fltTotLin + 1;
      End;

      cdsCopia.Next;

    End;

  Finally
    FreeAndNil(cdsCopia);
  End;

  If (fltMedMar > 0) Then
    fltMedMar := (fltMedMar / fltTotLin);

  edtTotFat.Text := FormatFloat('#,##0.00', fltTotFat);
  edtTotFre.Text := FormatFloat('#,##0.00', fltTotFre);
  edtMedMar.Text := FormatFloat('#,##0.00', fltMedMar);

end;

procedure TfrmCadMetasValor.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaAtual);
end;

procedure TfrmCadMetasValor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If cdsConsulta.Active Then
    cdsConsulta.CancelUpdates;

  If pnlMesAnoOrigem.Visible Then
  Begin
    pnlMesAnoOrigem.Visible := False;
    Action := caNone;
    pAbreConsulta(False);
  End;
end;

procedure TfrmCadMetasValor.cdsConsultaBeforePost(DataSet: TDataSet);
begin
  inherited;
  If ((DataSet.FieldByName('MET_TOTMET').AsFloat) > VS_fltValMax) Then
  Begin
    fMensagem('ATENÇÃO!', 'O valor da Meta de faturamento não pode ser maior que '  + formatFloat('#,##0.00', VS_fltValMax) + '.' + #13#10 + 'Favor verificar!', ['&O k']) ;
    pSetFocus(dbgConsulta);
    dbgConsulta.SelectedField := cdsConsultaMET_TOTMET;
    Abort;
  End
  Else If (tmtTipMet = tmeFaturamento) And (DataSet.FindField('MET_TOTFRE') <> Nil) And ((DataSet.FieldByName('MET_TOTFRE').AsFloat) > VS_fltValMax) Then
  Begin
    fMensagem('ATENÇÃO!', 'O valor da Meta de frete não pode ser maior que '  + formatFloat('#,##0.00', VS_fltValMax) + '.' + #13#10 + 'Favor verificar!', ['&O k']) ;
    pSetFocus(dbgConsulta);
    dbgConsulta.SelectedField := cdsConsultaMET_TOTFRE;
    Abort;
  End
  Else If ((DataSet.FieldByName('MET_MARGEM').AsFloat) > VS_fltValMax) Then
  Begin
    fMensagem('ATENÇÃO!', 'O valor da Margem não pode ser maior que '  + formatFloat('#,##0.00', VS_fltValMax) + '.' + #13#10 + 'Favor verificar!', ['&O k']) ;
    pSetFocus(dbgConsulta);
    dbgConsulta.SelectedField := cdsConsultaMET_MARGEM;
    Abort;
  End
  Else If fExibeCamposECMVBI() Then
  Begin
    If ((DataSet.FieldByName('MET_ATEDIA').AsFloat) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor da Meta do Atendimento Diário não pode ser menor que Zero. Favor verificar!', ['&O k']) ;
      pSetFocus(dbgConsulta);
      dbgConsulta.SelectedField := DataSet.FindField('MET_ATEDIA');
      Abort;
    End
    Else If ((DataSet.FieldByName('MET_TICMED').AsFloat) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor da Meta do Ticket Médio não pode ser menor que Zero. Favor verificar!', ['&O k']) ;
      pSetFocus(dbgConsulta);
      dbgConsulta.SelectedField := DataSet.FindField('MET_TICMED');
      Abort;
    End
    Else If ((DataSet.FieldByName('MET_ITEDOC').AsFloat) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor da Meta de Itens por Documento não pode ser menor que Zero. Favor verificar!', ['&O k']) ;
      pSetFocus(dbgConsulta);
      dbgConsulta.SelectedField := DataSet.FindField('MET_ITEDOC');
      Abort;
    End;
  End;
end;

procedure TfrmCadMetasValor.cdsConsultaBeforeScroll(DataSet: TDataSet);
begin
  inherited;

  If blnPorSubMetas And blnChecarCemPorCento Then
  Begin
    If blnPorMarca Then
    Begin
      If (Not frmCadMetasMarca.fValidaTotalMarca) Then
        Abort;
    End
    Else
    Begin
      If (Not frmCadMetasGrupo.fValidaTotalGrupo) Then
        Abort;
    End;
  End;
End;

procedure TfrmCadMetasValor.dbgConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key In [VK_Return, VK_TAB]) And
     (dbgConsulta.DataSource.DataSet <> Nil) And
     (dbgConsulta.DataSource.DataSet.Active) And
     (dbgConsulta.DataSource.DataSet.RecNo = dbgConsulta.DataSource.DataSet.RecordCount) And
     (dbgConsulta.SelectedField <> Nil) And
     (dbgConsulta.DataSource.DataSet.FindField(dbgConsulta.Columns.Items[dbgConsulta.Columns.Count - 1].FieldName) <> Nil) And
     (dbgConsulta.SelectedField = dbgConsulta.DataSource.DataSet.FieldByName(dbgConsulta.Columns.Items[dbgConsulta.Columns.Count - 1].FieldName)) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End;

  If (Key = VK_Return) Then
    If cdsConsulta.State in ([dsEdit]) Then
      cdsConsulta.Post;

end;

procedure TfrmCadMetasValor.dtsConsultaUpdateData(Sender: TObject);
begin
  inherited;
  pProcessarTotais;
end;

procedure TfrmCadMetasValor.edtCodEmpExit(Sender: TObject);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');

  If Not cdsConsulta.IsEmpty Then
  Begin

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      If (fRetEmpresaOperador(cdsConsulta.FieldByName('MET_CODVEN').AsString)) <> edtCodEmp.Text Then
        If fMensagem('','A empresa foi alterada, deseja recarregar as metas?', ['&Sim','&Não']) = 1 Then
          fValidaCampos(edtCodEmp, True);

  End;

end;

procedure TfrmCadMetasValor.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, True, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMetasValor.pImportarMetas;
  Var
    strMarGru: String;
    intOpcImp: Integer;
begin
  intOpcImp := 1;

  If (blnPorSubMetas) Then
  Begin
    strMarGru := IIF(blnPorMarca, 'Marca', 'Linha/Grupo');
    intOpcImp := fMensagem('','Importar',['&Vendedor','&'+ strMarGru], 1, False, 1, 0, False, 0, False, False, True);
  End;

  Case (intOpcImp) Of
    1:
    Begin
      pChamaTelaImportacao(TfrmImportacaoMetasVendedor);
    End;

    2:
    Begin
      If blnPorMarca Then
        pChamaTelaImportacao(TfrmImportacaoMetasMarca)
      Else
        pChamaTelaImportacao(TfrmImportacaoMetasLinhaGrupo, fExibeColunaMargem);
    End;
  End;

  fValidaCampos(edtCodEmp);
end;

function TfrmCadMetasValor.fExibeColunaMargem: Boolean;
Begin
  If Assigned(frmCadMetasGrupo) Then
    Result := (Not blnPorMarca) and (frmCadMetasGrupo.rdgDefineLinhaGrupo.ItemIndex = 0)
  Else
    Result := False;
End;

procedure TfrmCadMetasValor.pChamaTelaImportacao(TfrmImportacao: TComponentClass; blnExibeMargem: Boolean = False);
  Var
    frmImportacaoMetas: TfrmImportacaoMetas;
begin
  pCriarFormularios(TfrmImportacao, frmImportacaoMetas);
  Try
    Try
      frmImportacaoMetas.blnExibeMargem := blnExibeMargem;
      frmImportacaoMetas.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[pImportacaoMetas]');
    End;
  Finally
    pFreeAndNil(frmImportacaoMetas);
  End;
end;

procedure TfrmCadMetasValor.pPreencheParametrosPremios(Var qryDados: TUniQuery; fltVlrFat: Double);
  Var
    objPremios: TParPre;
    objController: TParPreController;
begin
  objController := TParPreController.Create;
  objPremios := objController.fBuscaPorValor(fltVlrFat, Vs_strCodEmp);

  Try
    If (Not Assigned(objPremios)) Then
      Exit;

    qryDados.ParamByName('VALFAT').AsFloat := objPremios.getVlrFat;
    qryDados.ParamByName('PREM01').AsFloat := objPremios.get1CsAba;
    qryDados.ParamByName('PREM02').AsFloat := objPremios.getMetAti;
    qryDados.ParamByName('PREM03').AsFloat := objPremios.get1CsAci;
    qryDados.ParamByName('PREM04').AsFloat := objPremios.get2CsAci;
  Finally
    FreeAndNil(objPremios);
    FreeAndNil(objController);
  End;
end;

function TfrmCadMetasValor.fExisteMetFag(Var strAutInc: String): Boolean;
  Var
    qryTmp : TUniQuery;
begin
  Result := False;
  qryTmp := fCriaQuery;

  Try
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Text := ' SELECT                     '+
                       '   AUTOINCREM               '+
                       ' FROM                       '+
                       '   METFAG                   '+
                       ' WHERE                      '+
                       '   MET_MESANO = :MESANO AND '+
                       '   MET_CODEMP = :CODEMP     ';

    qryTmp.ParamByName('MESANO').AsString := cdsConsulta.FieldByName('MET_MESANO').AsString;
    qryTmp.ParamByName('CODEMP').AsString := fRetEmpresaOperador(cdsConsulta.FieldByName('MET_CODVEN').AsString);
    qryTmp.Open;

    If (Not qryTmp.IsEmpty) And (Not fEmptyStr(qryTmp.FieldByName('AUTOINCREM').AsString)) Then
    Begin
      strAutInc := qryTmp.FieldByName('AUTOINCREM').AsString;
      Result := True;
    End;

  Finally
    FreeAndNil(qryTmp);
  End;
end;

function TfrmCadMetasValor.fExisteMetFad: Boolean;
  Var
    qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery;

  Try
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Text := ' SELECT                           '+
                       '   COUNT(*) AS TOT                '+
                       ' FROM                             '+
                       '   METFAD                         '+
                       ' INNER JOIN METFAG ON             '+
                       '   FAD_SEQGER = METFAG.AUTOINCREM '+
                       ' WHERE                            '+
                       '   FAD_CODVEN = :CODVEN AND       '+
                       '   MET_MESANO = :MESANO AND       '+
                       '   MET_CODEMP = :CODEMP           ';

    qryTmp.ParamByName('MESANO').AsString := cdsConsulta.FieldByName('MET_MESANO').AsString;
    qryTmp.ParamByName('CODEMP').AsString := fRetEmpresaOperador(cdsConsulta.FieldByName('MET_CODVEN').AsString);
    qryTmp.ParamByName('CODVEN').AsString := cdsConsulta.FieldByName('MET_CODVEN').AsString;
    qryTmp.Open;

    Result := (Not qryTmp.IsEmpty) And (qryTmp.FieldByName('TOT').AsInteger > 0);
  Finally
    FreeAndNil(qryTmp);
  End;
end;

procedure TfrmCadMetasValor.pInserirMetaRentabilidade;
  Var
    strSeqGer: String;
begin
  strSeqGer := '';

  If (Not fExisteMetFag(strSeqGer)) Then
  Begin
    strSeqGer := fRetAutoIncrem('METFAG', VS_strCodEmp);
    pInserirMetFag(strSeqGer);
  End;

  pInserirMetFad(strSeqGer);
end;

procedure TfrmCadMetasValor.pInserirMetFag(strAutInc: String);
  Var
    qryDados: TUniQuery;
begin
  qryDados := fCriaQuery;

  Try
    Try
      fStartTransaction();

      qryDados.Close;
      qryDados.SQL.Clear;
      qryDados.SQL.Text := ' INSERT INTO METFAG                     '+
                           '   (AUTOINCREM, MET_MESANO, MET_CODEMP) '+
                           ' VALUES                                 '+
                           '   (:AUTINC, :MESANO, :CODEMP)          ';

      qryDados.ParamByName('AUTINC').AsString := strAutInc;
      qryDados.ParamByName('MESANO').AsString := cdsConsulta.FieldByName('MET_MESANO').AsString;
      qryDados.ParamByName('CODEMP').AsString := fRetEmpresaOperador(cdsConsulta.FieldByName('MET_CODVEN').AsString);
      qryDados.ExecSql;

      fCommit;
    Except
      On E: Exception Do
        fRollBack;
    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;

procedure TfrmCadMetasValor.pInserirMetFad(strSeqGer: String);
  Var
    qryDados: TUniQuery;
begin
  qryDados := fCriaQuery;

  Try
    Try
      fStartTransaction();

      qryDados.Close;
      qryDados.SQL.Clear;
      qryDados.SQL.Text := ' INSERT INTO METFAD (  '+
                           '   AUTOINCREM,         '+
                           '   FAD_SEQGER,         '+
                           '   FAD_CODVEN,         '+
                           '   FAD_VALFAT,         '+
                           '   FAD_PREM01,         '+
                           '   FAD_PREM02,         '+
                           '   FAD_PREM03,         '+
                           '   FAD_PREM04          '+
                           ' )                     '+
                           ' VALUES                '+
                           '   (                   '+
                           '     :AUTINC,          '+
                           '     :SEQGER,          '+
                           '     :CODVEN,          '+
                           '     :VALFAT,          '+
                           '     :PREM01,          '+
                           '     :PREM02,          '+
                           '     :PREM03,          '+
                           '     :PREM04           '+
                           '   )                   ';

      qryDados.ParamByName('AUTINC').AsString := fRetAutoIncrem('METFAD', VS_strCodEmp);
      qryDados.ParamByName('SEQGER').AsString := strSeqGer;
      qryDados.ParamByName('CODVEN').AsString := cdsConsulta.FieldByName('MET_CODVEN').AsString;
      pPreencheParametrosPremios(qryDados, cdsConsulta.FieldByName('MET_TOTMET').AsFloat);
      qryDados.ExecSql;

      fCommit;
    Except
      On E: Exception Do
        fRollBack;
    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;

end.
