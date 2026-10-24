unit untManutencaoConferenciasEntradaSimplificadaColetor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxLabel, EditFocus, untZClient, MemDS, DBAccess, Uni,
  cxImageComboBox, System.ImageList, Vcl.ImgList, cxImageList, dxGDIPlusClasses;

type
  TfrmManutencaoConferenciasEntradaSimplificadaColetor = class(TfrmPaiEdit)
    pnlGrids: TPanel;
    cxgDocumentosTBV: TcxGridDBTableViewCitel;
    cxgDocumentosLVL: TcxGridLevel;
    cxgDocumentos: TcxGridCitel;
    cxgDocumentosTBVColumn1: TcxGridDBColumn;
    cxgDocumentosTBVColumn2: TcxGridDBColumn;
    btnExcluirDocumento: TBitBtnLocked;
    btnExcluirDivergentes: TBitBtnLocked;
    btnExcluirItem: TBitBtnLocked;
    cxgItens: TcxGridCitel;
    cxgItensTBV: TcxGridDBTableViewCitel;
    cxgItensTBVDESITE: TcxGridDBColumn;
    cxgItensTBVQTDDOC: TcxGridDBColumn;
    cxgItenLVL: TcxGridLevel;
    cxgItensTBVQTDDIG: TcxGridDBColumn;
    lblCodCfr: TLabel;
    edtCodCon: TEditFocus;
    cxgItensTBVCODITE: TcxGridDBColumn;
    btnExcluirConferencia: TBitBtnLocked;
    btnFinalizarComDivergencia: TBitBtnLocked;
    pnlLegendas: TPanel;
    edtOpeIni: TEditFocus;
    edtDtaIni: TEditFocus;
    Label1: TLabel;
    lblDataIni: TLabel;
    Image1: TImage;
    Label8: TLabel;
    Image2: TImage;
    Label9: TLabel;
    Image3: TImage;
    Label10: TLabel;
    cxImageList2: TcxImageList;
    cxgItensTBVSTATUS: TcxGridDBColumn;
    btnCancelar: TBitBtnLocked;
    Label2: TLabel;
    Image4: TImage;
    procedure edtCodConKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnExcluirDivergentesClick(Sender: TObject);
    procedure btnExcluirItemClick(Sender: TObject);
    procedure btnExcluirDocumentoClick(Sender: TObject);
    procedure btnExcluirConferenciaClick(Sender: TObject);
    procedure btnFinalizarComDivergenciaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
  private
    cdsDocumentos : TZClient;
    cdsItens  : TZClient;
    strAutoincrem : String;
    FblnGerTrf: Boolean;
    function fGetSQLDocumentos : String;
    function fGetSQLItens : String;
    procedure pExcluiItem;
    procedure pLimpaCampos;
    function fGerarTransferenciasDivergenciaColetor: Boolean;
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untConsultas, untTypesSistema, untFuncoesSimples, untLiberacao,
  untMsgLiberacao, untConstantes, untTransferenciaDivergenciaExcedente;

{$R *.dfm}

procedure TfrmManutencaoConferenciasEntradaSimplificadaColetor.pExcluiItem;
  var
    qryQuery : TUniQUery;
begin

  qryQuery := fCriaQuery;
  try
    qryQuery.Close;
    qryQuery.SQL.Clear;
    qryQuery.SQL.Add('DELETE FROM CONDIG WHERE');
    qryQuery.SQL.Add('DIG_CODITE = ' + QuotedStr(cdsItens.FieldByName('CODITE').AsString) + ' AND DIG_SEQCON = ' + QuotedStr(cdsItens.FieldByName('SEQCON').AsString) );
    qryQuery.ExecSQL;
  finally
    FreeAndNil(qryQuery);
  end;

end;

procedure TfrmManutencaoConferenciasEntradaSimplificadaColetor.btnCancelarClick(
  Sender: TObject);
begin
  inherited;
  pLimpaCampos;
end;

procedure TfrmManutencaoConferenciasEntradaSimplificadaColetor.btnExcluirConferenciaClick(
  Sender: TObject);
var
    qryQuery : TUniQUery;
begin
  if fEmptyStr(strAutoincrem) then
    exit;

  if fMensagem('','Deseja realmente excluir a conferência?', ['&Sim', '&Não']) = 2 then
    exit;

  qryQuery := fCriaQuery;
  try
    qryQuery.Close;
    qryQuery.SQL.Clear;
    qryQuery.SQL.Add('DELETE FROM CONGER WHERE AUTOINCREM = ' + QuotedStr(strAutoincrem));
    qryQuery.ExecSQL;

    pLimpaCampos;

    fMensagem('','Conferência excluída com sucesso!', ['&Ok']);
  finally
    FreeAndNil(qryQuery);
  end;

end;


procedure TfrmManutencaoConferenciasEntradaSimplificadaColetor.btnExcluirDivergentesClick(
  Sender: TObject);
begin
  inherited;
  if cdsItens.RecordCount > 0 then
  begin
    try
      cdsItens.DisableControls;
      cdsItens.Filtered := False;
      cdsItens.Filter := 'QTDDOC <> QTDDIG';
      cdsItens.Filtered := True;

      if cdsItens.isEmpty then
      begin
        fMensagem('','Não existem itens divergentes', ['&Ok']);
        exit;
      end;

      cdsItens.First;
      fStartTransaction;
      try
        while not cdsItens.eof do
        begin
          if cdsItens.FieldByName('QTDDOC').AsFloat <> cdsItens.FieldByName('QTDDIG').AsFloat then
            pExcluiItem;

          cdsItens.Next;
        end;

        fCommit;

        fMensagem('','Divergências excluídas com sucesso!', ['&Ok']);

      except
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[TfrmManutencaoConferenciasEntradaSimplificadaColetor.btnExcluirDivergentesClick]');
        End;
      end;
    finally
      cdsItens.Filter := '';
      cdsItens.Filtered := False;
      cdsItens.Refresh;
      cdsItens.EnableControls;
    end;
  end;
end;

procedure TfrmManutencaoConferenciasEntradaSimplificadaColetor.btnExcluirDocumentoClick(
  Sender: TObject);
  var
    qryQuery : TUniQUery;
begin
  if cdsDocumentos.isEmpty then
    exit;

  if cdsDocumentos.RecordCount <= 1 then
  begin
    fMensagem('', 'Não é possível excluir todos os documentos da conferência, se for necessário, exclua a conferência!', ['&Ok']);
    exit;
  end;

  if fMensagem('','Deseja realmente excluir o documento '+cdsDocumentos.FieldByName('DOCUMENTO').AsString+'?', ['&Sim', '&Não']) = 2 then
    exit;


  qryQuery := fCriaQuery;
  try
    qryQuery.Close;
    qryQuery.SQL.Clear;
    qryQuery.SQL.Add('DELETE FROM CONDOC WHERE AUTOINCREM = ' + QuotedStr(cdsDocumentos.FieldByName('AUTOINCREM').AsString) );
    qryQuery.ExecSQL;

    fMensagem('','Documento excluído com sucesso!', ['&Ok']);
    cdsDocumentos.Refresh;
    cdsItens.Refresh;
  finally
    FreeAndNil(qryQuery);
  end;

end;

procedure TfrmManutencaoConferenciasEntradaSimplificadaColetor.btnExcluirItemClick(
  Sender: TObject);
begin
  inherited;
  if cdsItens.isEmpty then
    exit;

  pExcluiItem;
  cdsItens.Refresh;
  fMensagem('','Divergência excluída com sucesso!', ['&Ok']);
end;

procedure TfrmManutencaoConferenciasEntradaSimplificadaColetor.btnFinalizarComDivergenciaClick(
  Sender: TObject);
  Var
    objLiberacao : TLiberacao;
    objTabela : TRegistroMsgLiberaTabela;
  	objLinha  : TLinhaMsgLibera;
    qryQuery : TUniQuery;
    LblnResultado: Boolean;
Begin
  objLiberacao := TLiberacao.Create;
  try
    Try
      cdsItens.DisableControls;
      cdsItens.Filtered := False;
      cdsItens.Filter   := 'QTDDIG <> QTDDOC';
      cdsItens.Filtered := True;
      cdsItens.First;

      if cdsItens.isEmpty then
      begin
        fMensagem('','Não existem itens divergentes', ['&Ok']);
        exit;
      end;

      objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE ENTRADA SIMPLIFICADA');
      objLiberacao.objMsgLibera.pAddTexto('CONFERÊNCIA COLETOR:' + edtCodCon.Text);
      objLiberacao.objMsgLibera.pAddTexto('AS QUANTIDADES DOS ITENS CONFERIDOS ESTÃO DIFERENTES DA(S) NOTA(S).');
      objLiberacao.objMsgLibera.pAddQuebra;


      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'CÓDIGO'     , fTamCodite  , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'DESCRIÇÃO'  , 40 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'QTD. NOTA'  , 12 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'QTD. CONF'  , 12 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      While Not cdsItens.Eof Do
      Begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('CÓDIGO'     , cdsItens.FieldByName('CODITE').AsString                              , fTamCodite  , alEsquerda );
        objLinha.pAddColuna('DESCRIÇÃO'  , cdsItens.FieldByName('ITE_DESITE').AsString                          , 40 , alEsquerda );
        objLinha.pAddColuna('QTD. NOTA'  , FloatToStrF(cdsItens.FieldByName('QTDDOC').AsFloat, ffNumber, 12, 2) , 12 , alDireita  );
        objLinha.pAddColuna('QTD. CONF'  , FloatToStrF(cdsItens.FieldByName('QTDDIG').AsFloat, ffNumber, 12, 2) , 12 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

        cdsItens.Next;
      End;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objLiberacao.strDirAce := 'LIBCONSIM';
      objLiberacao.strMsgSen := 'LIBERAÇÃO DE ENTRADA SIMPLIFICADA';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;
      objLiberacao.blnUsarSenhaFixa := False;
      objLiberacao.blnSempreVariavelUsuario := True;
      objLiberacao.tipCliFor := cfFornecedor;

      if objLiberacao.fLibera then
      begin
        fStartTransaction;
        try
          LblnResultado := True;
          If FblnGerTrf Then
            LblnResultado := fGerarTransferenciasDivergenciaColetor;

          If LblnResultado Then
          Begin
            qryQuery := fCriaQuery;
            try
              qryQuery.Close;
              qryQuery.SQL.Clear;
              qryQuery.SQL.Add('UPDATE CONGER SET GER_OPEFIM = '+QuotedStr(strLoginUsuarioLogado)+
                               ', GER_DTAFIM = '+fCurrentDateTime+
                               ' WHERE AUTOINCREM = ' + QuotedStr(strAutoincrem));
              qryQuery.ExecSQL;
            finally
              FreeAndNil(qryQuery);
            end;
          End;

          if LblnResultado then
            fCommit
          else if fInTransaction then
            fRollBack;

          if LblnResultado then
          begin
            pLimpaCampos;
            fMensagem('','Conferência finalizada com sucesso!', ['&Ok']);
          end;
        except
          on E: Exception do
          begin
            if fInTransaction then
              fRollBack;
            pMensagensErro(E.Message,
              '[TfrmManutencaoConferenciasEntradaSimplificadaColetor.btn...Click]');
          end;
        end;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmManutencaoConferenciasEntradaSimplificadaColetor.fPedeLiberacao]');
      End;
    End;
  finally
    FreeAndNil(objLiberacao);
    cdsItens.Filtered := False;
    cdsItens.EnableControls;
  end;
End;

procedure TfrmManutencaoConferenciasEntradaSimplificadaColetor.pLimpaCampos;
begin
  edtCodCon.clear;
  edtCodCon.Enabled := True;
  edtOpeIni.clear;
  edtDtaIni.clear;
  cdsDocumentos.Close;
  cdsDocumentos.QryQuery.Close;
  cdsItens.Close;
  cdsItens.QryQuery.Close;
  strAutoincrem := '';
  pSetFocus(edtCodCon);
end;

procedure TfrmManutencaoConferenciasEntradaSimplificadaColetor.edtCodConKeyPress(
  Sender: TObject; var Key: Char);
   Var
     arrSel: TConsultasArray;
begin
  inherited;

  If fPesqConferenciaEntradaSimplificada(Self, edtCodCon, True, Nil, Key, arrSel, True) Then
  Begin
    strAutoincrem := arrSel[0].strCodigo;
    fValidaCampos(edtCodCon, True);
  End;

end;

procedure TfrmManutencaoConferenciasEntradaSimplificadaColetor.FormCreate(
  Sender: TObject);
begin
  inherited;
  FblnGerTrf := fCfgSis('GERTRF', varBoolean);
  cdsDocumentos := TZClient.Create(Self, fGetSQLDocumentos);
  cxgDocumentosTBV.DataController.DataSource := cdsDocumentos.dtsSource;

  cdsItens := TZClient.Create(Self, fGetSQLItens);
  cxgItensTBV.DataController.DataSource := cdsItens.dtsSource;
end;

procedure TfrmManutencaoConferenciasEntradaSimplificadaColetor.FormKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F1: btnExcluirDivergentes.Click;
    VK_F2: btnExcluirItem.Click;
    VK_F3: btnExcluirDocumento.Click;
    VK_F4: btnExcluirConferencia.Click;
    VK_F5: btnFinalizarComDivergencia.Click;
    VK_ESCAPE: if not (cdsDocumentos.IsEmpty) then
               begin
                 pLimpaCampos;
                 exit;
               end;
  end;
  inherited;
end;

function TfrmManutencaoConferenciasEntradaSimplificadaColetor.fGetSQLDocumentos : String;
begin
  Result := '';
  Result := Result + ' SELECT                                                        ';
  Result := Result + '   DOC.AUTOINCREM,                                             ';
  Result := Result + '   DOC_SEQCON,                                                 ';
  Result := Result + '   CONCAT(GER_NUMDOC, "-", GER_ESPDOC) AS DOCUMENTO,           ';
  Result := Result + '   EMP_NOMEMP                                                  ';
  Result := Result + '   ,GER_CODEMP                                                 ';
  Result := Result + '   ,GER_NUMDOC                                                 ';
  Result := Result + '   ,GER_ESPDOC                                                 ';
  Result := Result + ' FROM                                                          ';
  Result := Result + '   CONDOC DOC                                                  ';
  Result := Result + '   INNER JOIN MOVGER GER ON GER.AUTOINCREM = DOC.DOC_SEQGER    ';
  Result := Result + '   INNER JOIN CADEMP EMP ON EMP.EMP_CODEMP  = GER.GER_CODEMP   ';
  Result := Result + ' WHERE                                                         ';
  Result := Result + '       DOC.DOC_SEQCON = :SEQCON                                ';
  Result := Result + ' ORDER BY                                                      ';
  Result := Result + '   DOCUMENTO                                                   ';
end;

function TfrmManutencaoConferenciasEntradaSimplificadaColetor.fGetSQLItens : String;
begin
  Result := '';
  Result := Result + ' SELECT                                                                                                                               ';
  Result := Result + '   *,                                                                                                                                 ';
  Result := Result + '   CASE                                                                                                                               ';
  Result := Result + '     WHEN QTDDOC = 0 AND QTDDIG > 0 THEN "FALTOU"                                                                                     ';
  Result := Result + '     WHEN QTDDIG > QTDDOC THEN "MAIS"                                                                                                 ';
  Result := Result + '     WHEN QTDDIG < QTDDOC THEN "MENOS"                                                                                                ';
  Result := Result + '     WHEN QTDDIG = QTDDOC THEN "OK"                                                                                                   ';
  Result := Result + '   END AS STATUS                                                                                                                      ';
  Result := Result + ' FROM                                                                                                                                 ';
  Result := Result + '   (SELECT                                                                                                                            ';
  Result := Result + '      DIG.AUTOINCREM,                                                                                                                 ';
  Result := Result + '      DIG.DIG_SEQCON AS SEQCON,                                                                                                       ';
  Result := Result + '      DIG.DIG_CODITE AS CODITE,                                                                                                       ';
  Result := Result + '      ITE_DESITE,                                                                                                                     ';
  Result := Result + '      IFNULL(SUM(IFNULL(DIG.DIG_QTDITE,0)),0) AS QTDDIG,                                                                              ';
  Result := Result + '      0 AS QTDDOC                                                                                                                     ';
  Result := Result + '    FROM                                                                                                                              ';
  Result := Result + '      CONDIG DIG                                                                                                                      ';
  Result := Result + '      INNER JOIN CADITE     ON     ITE_CODITE = DIG.DIG_CODITE                                                                        ';
  Result := Result + '    WHERE                                                                                                                             ';
  Result := Result + '          DIG.DIG_SEQCON = :SEQCON                                                                                                    ';
  Result := Result + '      AND DIG.DIG_CODITE NOT IN (SELECT                                                                                               ';
  Result := Result + '    														    DET_CODITE                                                                                        ';
  Result := Result + '     														FROM                                                                                                  ';
  Result := Result + '    															  CONDOC DOC                                                                                        ';
  Result := Result + '    																INNER JOIN MOVDET DET ON     DET.DET_SEQGER = DOC.DOC_SEQGER                                      ';
  Result := Result + '    																    										 AND DET.DET_CODITE NOT IN ( '+QuotedStr(fCfgSis('ITESER', varString))     ;
  Result := Result + '    																    										                            ,'+QuotedStr(fCfgSis('SERTER', varString))+') ';
  Result := Result + '    															WHERE                                                                                               ';
  Result := Result + '    															      DOC.DOC_SEQCON = DIG.DIG_SEQCON                                                               ';
  Result := Result + '    															  AND DET.DET_CODITE = DIG.DIG_CODITE)                                                              ';
  Result := Result + '    GROUP BY                                                                                                                          ';
  Result := Result + '      DIG.DIG_CODITE                                                                                                                  ';
  Result := Result + '    UNION ALL                                                                                                                         ';
  Result := Result + '    SELECT                                                                                                                            ';
  Result := Result + '      "",                                                                                                                             ';
  Result := Result + '      DOC.DOC_SEQCON AS SEQCON,                                                                                                       ';
  Result := Result + '      DET.DET_CODITE AS CODITE,                                                                                                       ';
  Result := Result + '      ITE_DESITE,                                                                                                                     ';
  Result := Result + '      IFNULL((SELECT                                                                                                                  ';
  Result := Result + '               SUM(IFNULL(DIG.DIG_QTDITE,0))                                                                                          ';
  Result := Result + '             FROM                                                                                                                     ';
  Result := Result + '               CONDIG DIG                                                                                                             ';
  Result := Result + '             WHERE                                                                                                                    ';
  Result := Result + '                   DIG.DIG_SEQCON = DOC.DOC_SEQCON                                                                                    ';
  Result := Result + '               AND DIG.DIG_CODITE = DET.DET_CODITE),0) AS QTDDIG,                                                                     ';
  Result := Result + '      IFNULL(SUM(IFNULL(DET.DET_QTDITE,0)),0) AS QTDDOC                                                                               ';
  Result := Result + '    FROM                                                                                                                              ';
  Result := Result + '      CONDOC DOC                                                                                                                      ';
  Result := Result + '      INNER JOIN MOVDET DET ON     DET.DET_SEQGER = DOC.DOC_SEQGER                                                                    ';
  Result := Result + '                               AND DET.DET_CODITE NOT IN ( '+QuotedStr(fCfgSis('ITESER', varString))                                   ;
  Result := Result + '                                                          ,'+QuotedStr(fCfgSis('SERTER', varString))+')                               ';
  Result := Result + '      INNER JOIN CADITE     ON     ITE_CODITE = DET.DET_CODITE                                                                        ';
  Result := Result + '    WHERE                                                                                                                             ';
  Result := Result + '      DOC_SEQCON = :SEQCON                                                                                                            ';
  Result := Result + '    GROUP BY                                                                                                                          ';
  Result := Result + '      DET.DET_CODITE) T1                                                                                                              ';

  Result := Result + ' ORDER BY                                                                                                                             ';
  Result := Result + '   CODITE                                                                                                                             ';
end;

function TfrmManutencaoConferenciasEntradaSimplificadaColetor.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  var
    qryQuery : TUniQuery;
begin
  Result := True;
  try
    If (Sender = edtCodCon) Then
    Begin
      strAutoincrem := '';
      edtOpeIni.clear;
      edtDtaIni.clear;
      cdsDocumentos.qryQuery.Close;
      cdsDocumentos.Close;

      cdsItens.qryQuery.Close;
      cdsItens.Close;

      If not fEmptyStr(edtCodCon.Text) Then
      Begin
        qryQuery := fCriaQuery;
        try

          qryQuery.SQL.Add(' SELECT                                           ');
          qryQuery.SQL.Add('   CONGER.AUTOINCREM,                             ');
          qryQuery.SQL.Add('   GER_OPEINI,                                    ');
          qryQuery.SQL.Add('   GER_DTAINI,                                    ');
          qryQuery.SQL.Add('   GER_DTAFIM,                                    ');
          qryQuery.SQL.Add('   OPE_NOMOPE                                     ');
          qryQuery.SQL.Add(' FROM                                             ');
          qryQuery.SQL.Add('   CONGER                                         ');
          qryQuery.SQL.Add('   INNER JOIN CADOPE ON OPE_CODOPE = GER_OPEINI   ');
          qryQuery.SQL.Add(' WHERE                                            ');
          qryQuery.SQL.Add('       GER_CODCON = :CODCON                       ');
          qryQuery.SQL.Add('   AND GER_CODEMP = :CODEMP                       ');
          qryQuery.ParamByName('CODCON').AsString := edtCodCon.Text;
          qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryQuery.Open;

          if qryQuery.isEmpty then
          begin
            fMensagem('','Conferência não encontrada!', ['&Ok']);
            Result := False;
            pLimpaCampos;
            exit;
          end;

          if not qryQuery.FieldByName('GER_DTAFIM').IsNull then
          begin
            fMensagem('','Esta conferência já foi finalizada!', ['&Ok']);
            Result := False;
            pLimpaCampos;
            exit;
          end;

          strAutoincrem  := qryQuery.fieldByName('AUTOINCREM').AsString;
          edtOpeIni.Text := qryQuery.fieldByName('OPE_NOMOPE').AsString;
          edtDtaIni.Text := qryQuery.fieldByName('GER_DTAINI').AsString;

          cdsDocumentos.qryQuery.ParamByName('SEQCON').AsString := strAutoincrem;
          cdsDocumentos.fAbreClient(True, 'TfrmManutencaoConferenciasEntradaSimplificadaColetor.fValidaCampos');

          cdsItens.qryQuery.Close;
          cdsItens.Close;
          cdsItens.qryQuery.ParamByName('SEQCON').AsString := strAutoincrem;
          cdsItens.fAbreClient(True, 'TfrmManutencaoConferenciasEntradaSimplificadaColetor.fValidaCampos');
          TFloatField(cdsItens.FieldByName('QTDDIG')).DisplayFormat := fMskDigitos(2);
          TFloatField(cdsItens.FieldByName('QTDDOC')).DisplayFormat := fMskDigitos(2);

          edtCodCon.Enabled := False;
          pSetFocus(cxgItens);
          blnMudarFoco := False;

        finally
          FreeAndNil(qryQuery);
        end;

      end;
    End;

  finally

    If Not Result Then
    begin
      if blnMudarFoco then
      begin
        blnMudarFoco := False;
        pSetFocus(Sender);
      end;
    end;

  end;

end;

function TfrmManutencaoConferenciasEntradaSimplificadaColetor.fGerarTransferenciasDivergenciaColetor: Boolean;
var
  LServico: TTransferenciaDivergenciaExcedente;
  LintDeqTem: Integer;
  LsltListaSelecao: TStringList;
begin
  LintDeqTem := fCfgSis('DEQTEM', varInteger);
  LsltListaSelecao := TStringList.Create;
  Try
    cdsDocumentos.First;
    While Not cdsDocumentos.Eof Do
    Begin
      LsltListaSelecao.Add(cdsDocumentos.FieldByName('AUTOINCREM').AsString);
      cdsDocumentos.Next;
    End;

    LServico := TTransferenciaDivergenciaExcedente.fNovo
      .fDocumentos(cdsDocumentos)
      .fItensColetor(cdsItens)
      .fSelecionados(LsltListaSelecao)
      .fDeqTem(LintDeqTem)
      .fGerarTransferencia(True)
      .fEmpresaAtual(VS_strCodEmp);
    try
      Result := LServico.fExecutar;
    finally
      pFreeAndNil(LServico);
    end;
  Finally
    pFreeAndNil(LsltListaSelecao);
  End;
End;

end.
