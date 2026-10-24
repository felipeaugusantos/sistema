unit untImportaPrecos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, Mask, FilenameEditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxProgressBar, untFuncoesSimples, untZClient, cxGridBandedTableView,
  cxGridDBBandedTableView, cxCurrencyEdit, ComboBoxFocus, frxClass,
  frxDBSet, StrUtils, cxContainer,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxTextEdit, cxMaskEdit,
  cxButtonEdit, frxExportCSVTestabilidade, Uni , untCalculaComposicaoCusto,
  untParCalculaPrecoCusto, untTValidaExcel ;

type
  TfrmImportaPrecos = class(TfrmPaiEdit)
    btnGravar: TBitBtnLocked;
    pnlPath: TPanel;
    lbl1: TLabel;
    cxlGrid1Level1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxbItens: TcxGridDBBandedTableView;
    cxcItensDBBandedTableView1Column1: TcxGridDBBandedColumn;
    cxcItensDBBandedTableView1Column2: TcxGridDBBandedColumn;
    cxcItensDBBandedTableView1Column3: TcxGridDBBandedColumn;
    cxcItensDBBandedTableView1Column4: TcxGridDBBandedColumn;
    cxcItensDBBandedTableView1Column5: TcxGridDBBandedColumn;
    cxcItensDBBandedTableView1Column6: TcxGridDBBandedColumn;
    cxcItensDBBandedTableView1Column7: TcxGridDBBandedColumn;
    cxcItensDBBandedTableView1Column8: TcxGridDBBandedColumn;
    cbbTabPre: TComboBoxFocus;
    lbl2: TLabel;
    btnCarregar: TBitBtnLocked;
    cxs1: TcxStyleRepository;
    cxs2: TcxStyle;
    btnRelInc: TBitBtnLocked;
    frxInconsistencias: TfrxReport;
    frxDBInconsistencia: TfrxDBDataset;
    edtPath: TFilenameEditFocus;
    btnHlpImp: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCarregarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure btnRelIncClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
  private
    { Private declarations }
    blnAtualizou: Boolean;
    cdsItens: TZClient;
    intDecUni: Integer;
    intDecMar: Integer;
    strFrmCus: String;
    cpcParams: TParCalculaPrecoCusto;


    function fSQLItens(blnCarregaItem: Boolean; strPreVen: String): String;
    function fSQLIteger(strPreVen: String): String;
    function fSQLDetCus(strPreVen: String): String;

    function fImportaItens: Boolean;
    function fImportaExcel(pgbStatus: TcxProgressBar): Boolean;
    function fConvetVazioToNull(texto: string): Variant;


    function fCarregaItens: Boolean;
    function fCarregaDados(pgbStatus: TcxProgressBar): Boolean;

    Function fInsereItem(Excel: TValidadorExcel; intContador: Integer): Boolean;
    function fGravaItens(pgbStatus: TcxProgressBar): Boolean;
    function fAtualizaPrecos: Boolean;
    function fInserePreAlt: Boolean;
    Function fTemInconsistencias: Boolean;

    procedure pCarregaTabPre;
    procedure pMostraRelInconsistencias;
    function fRetPrecoCusto(dataSet: TDataSet; fltIcmEnt, fltSubst, fltSubFed: Double): Double;


  public
    { Public declarations }
  protected

    blnSufram: Boolean;

    strAgrupadorPreAlt: String;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmImportaPrecos: TfrmImportaPrecos;

implementation

{$R *.dfm}

Uses
  untGravando, ComObj, untPreAlt, untPreAlt_Trigger, untTConfiguracao;

Const
  ERR_PRECO            = 'P';
  ERR_NAO_ECONTRADO    = 'I';
  ERR_SEM_TABELA_PRECO = 'T';

procedure TfrmImportaPrecos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Not blnAtualizou) And (modalResult = mrCancel) Then
  Begin
    If Not fPergunta('Deseja abandonar a tarefa?') Then
      Action := caNone
    Else
      FreeAndNil(cpcParams);
  End;
end;

procedure TfrmImportaPrecos.FormCreate(Sender: TObject);
begin
  inherited;
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
  blnSufram := fCfgSis('SUFRAM', varBoolean);
  strFrmCus := fCfgSis('FRMCUS', varString);

  blnAtualizou := False;
  intDecUni := fCfgSis('DECUNI', varInteger);
  intDecMar := fCfgSis('DECMAR', varInteger);

  cdsItens := TZClient.Create(Self, fSQLItens(False, '1'));
  cdsItens.fAbreClient(True, 'TfrmImportaPrecos.FormCreate');
  cdsItens.pAlinhaCampoCentro('CODITE');

  cxbItens.DataController.DataSource := cdsItens.dtsSource;
  frxDBInconsistencia.DataSet := cdsItens;
  pCarregaTabPre;

end;

procedure TfrmImportaPrecos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F7 : btnCarregar.Click;
    VK_F8 : btnRelInc.Click;
    VK_F10: btnGravar.Click;
  End;
end;

procedure TfrmImportaPrecos.pCarregaTabPre;
  Var
    intContador: Integer;
Begin
  cbbTabPre.Items.Clear;

  For intContador := 1 To Length(VS_strTabPrc) Do
    If VS_strTabPrc[intContador] = 'S' Then
      cbbTabPre.Items.Add(IntToStr(intContador));
End;

function TfrmImportaPrecos.fSQLItens(blnCarregaItem: Boolean; strPreVen: String): String;
  Var
    strSQL: String;
    intContador: Integer;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   "S"          AS STATUS,  ';
  strSQL := strSQL + '   I.ITE_INCPIS,  ';
  strSQL := strSQL + '   I.ITE_CODITE AS CODITE,  ';
  strSQL := strSQL + '   I.ITE_DESITE AS DESITE,  ';
  strSQL := strSQL + '   I.ITE_REFERE AS REFERE,  ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI,    ';
  strSQL := strSQL + '   F.ITE_CODFOR,  ';
  strSQL := strSQL + '   IF(IFNULL(D.AUTOINCREM, "") = "", G.ITE_PRECOM, D.ITE_PRECOM) AS ITE_PRECOM, ';

  For intContador := 1 To 7 Do
  Begin
    strSQL := strSQL + '   G.ITE_PREVE' + IntToStr(intContador) + ' AS PREAN' + IntToStr(intContador) + ',  ';
    strSQL := strSQL + '   G.ITE_MARBR' + IntToStr(intContador) + ' AS MARAN' + IntToStr(intContador) + ',  ';

    strSQL := strSQL + '   G.ITE_PREVE' + IntToStr(intContador) + ' AS PREAT' + IntToStr(intContador) + ',  ';
    strSQL := strSQL + '   G.ITE_MARBR' + IntToStr(intContador) + ' AS MARAT' + IntToStr(intContador) + ',  ';
  End;

  strSQL := strSQL + '   G.ITE_PREVE' + strPreVen + ' AS PREANT,    ';
  strSQL := strSQL + '   G.ITE_PREVE' + strPreVen + ' AS PRENOV,    ';
  strSQL := strSQL + '   G.ITE_PREVE' + strPreVen + ' AS PREFOR,    ';

  strSQL := strSQL + '   G.ITE_MARBR' + strPreVen + ' AS MARANT,    ';
  strSQL := strSQL + '   G.ITE_MARBR' + strPreVen + ' AS MARNOV,    ';
  strSQL := strSQL + '   G.ITE_MARBR' + strPreVen + ' AS MARFOR,    ';

  strSQL := strSQL + '   G.ITE_PRECUS AS CUSITE, ';


  strSQL := strSQL + '   D.ITE_IPIENT, ';
  strSQL := strSQL + '   D.ITE_CODABF, ';
  strSQL := strSQL + '   D.ITE_DESF01, ';
  strSQL := strSQL + '   D.ITE_DESF02, ';
  strSQL := strSQL + '   D.ITE_DESF03, ';
  strSQL := strSQL + '   D.ITE_DESF04, ';
  strSQL := strSQL + '   D.ITE_DESF05, ';
  strSQL := strSQL + '   D.ITE_DESF06, ';
  strSQL := strSQL + '   D.ITE_PREDOL, ';

  strSQL := strSQL + '   D.ITE_FREENT, ';
  strSQL := strSQL + '   D.ITE_ACRFIN, ';
  strSQL := strSQL + '   D.ITE_VALFRE, ';
  strSQL := strSQL + '   D.ITE_DESADB, ';
  strSQL := strSQL + '   D.ITE_SUBFED, ';

  strSQL := strSQL + '   D.ITE_TCIFCU, ';
  strSQL := strSQL + '   D.ITE_TSCUST, ';
  strSQL := strSQL + '   D.ITE_DEPICO, ';
  strSQL := strSQL + '   D.ITE_DEICMS, ';
  strSQL := strSQL + '   D.ITE_FATREG, ';
  strSQL := strSQL + '   D.ITE_COMTBL, ';
  strSQL := strSQL + '   D.AUTOINCREM AS INCDET, ';

  strSQL := strSQL + '   F.ITE_CODTAB AS CODTAB, ';
  strSQL := strSQL + '   IF(IFNULL(F.ITE_CNVCUS, 1) <> 0, IFNULL(F.ITE_CNVCUS, 1), 1) AS CNVCUS, ';
  strSQL := strSQL + '   D.ITE_PRECUS AS PRECUS, ';
  strSQL := strSQL + '   DC.DET_ICMSAI AS ICMSAI  ';

  strSQL := strSQL + ' FROM        ';
  strSQL := strSQL + '   CADITE I  ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND ';
  strSQL := strSQL + '                        G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  strSQL := strSQL + ' INNER JOIN CADUNI ON UNI_CODUNI = I.ITE_CODUNI ';

  strSQL := strSQL + ' INNER JOIN ITEFOR F ON F.ITE_CODITE = G.ITE_CODITE AND ';
  strSQL := strSQL + '                       F.ITE_CODTAB = G.ITE_TABPR' + strPreVen + ' ';

  strSQL := strSQL + ' INNER JOIN TABDET D ON D.ITE_SEQGER = F.AUTOINCREM AND ';
  strSQL := strSQL + '                       D.ITE_CODEMP = G.ITE_CODEMP AND ';
  strSQL := strSQL + '                       D.ITE_CODTAB = G.ITE_TABPR' + strPreVen + ' ';

  strSQL := strSQL + ' INNER JOIN DETCUS DC ON DC.DET_SEQDET = D.AUTOINCREM AND ';
  strSQL := strSQL + '                        DC.DET_TABELA = ' + strPreVen + ' ';


  strSQL := strSQL + ' WHERE  ';

  If blnCarregaItem Then
    strSQL := strSQL + ' I.ITE_CODITE = :CODITE '
  Else
    strSQL := strSQL + ' FALSE ';

  Result := strSQL;
End;

function TfrmImportaPrecos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  Try

    If (inherited fValidaCampos(Sender)) Then
    Begin

      If (Sender = edtPath) Then
      Begin
        edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');

        If fEmptyStr(edtPath.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe o nome do arquivo para importação!', ['&Ok']);
          Result := False;
        End

        Else If Not FileExists(edtPath.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Arquivo não encontrado!', ['&Ok']);
          Result := False;
        End;

      End

      Else If (Sender = cbbTabPre) Then
      Begin

        If cbbTabPre.ItemIndex = -1 Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe a tabela de preço que será atualizada!', ['&Ok']);
          Result := False;
        End;

      End;

    End;

  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmImportaPrecos.fValidaCampos]');
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

Function TfrmImportaPrecos.fInsereItem(Excel: TValidadorExcel; intContador: Integer): Boolean;
  Var
    strCodIte: String;
Begin
  Result := False;

  With cdsItens Do
  Begin
    strCodIte := Excel.fGetValueCSV(intContador, 'A');

    If Not fEmptyStr(strCodIte) Then
    Begin
      Append;
      strCodIte :=  fStrZero(strCodIte, fTamCodIte);
      FieldByName('STATUS').AsString := 'S';
      FieldByName('CODITE').AsString := strCodIte;

      Try
        FieldByName('PRENOV').AsFloat  := fConvetVazioToNull(Excel.fGetValueCSV(intContador, 'B'));
      Except
        FieldByName('STATUS').AsString := ERR_PRECO;
      End;

      If FieldByName('PRENOV').AsFloat <= 0 Then
        FieldByName('STATUS').AsString := ERR_PRECO;

      Post;

      Result := True;
    End;

  End;
End;


function TfrmImportaPrecos.fConvetVazioToNull(texto: string): Variant;
begin
  If Texto = '' Then
    Result := null
  Else
    Result := texto;
end;

function TfrmImportaPrecos.fImportaExcel(pgbStatus: TcxProgressBar): Boolean;
  Var
    intIni,
    intContador: Integer;
    objValidaExcel: TValidadorExcel;
Begin
  Try
    cdsItens.DisableControls;

    objValidaExcel := TValidadorExcel.Create(edtPath.Text, 2,'A', '');
    Try

      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := objValidaExcel.intQtdLinhas;

      pPreAltDefineVariaveisAltPre(fNow, 'IMPORTAÇÃO DE PREÇOS PELO XML', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);
      intIni := 1;

      For intContador := intIni To objValidaExcel.intQtdLinhas Do
      Begin
        If Not fInsereItem(objValidaExcel, intContador) Then
          Break;

        pgbStatus.Position := pgbStatus.Position + 1;
        Application.ProcessMessages;
      End;

      Result := True;
      strAgrupadorPreAlt := '';

    Except
      On E: Exception Do
      Begin
        strAgrupadorPreAlt := '';
        pMensagensErro(E.Message, '[TfrmImportaPrecos.fImportaItens]');
        Result := False;
      End;
    End;

    cdsItens.EnableControls;
  Finally
    FreeAndNil(objValidaExcel);
  End;
End;

function TfrmImportaPrecos.fImportaItens: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fImportaExcel;
    frmGravando.lblGravando.Caption  := 'Aguarde, importando preços...';
    frmGravando.ShowModal;
    Result                    := frmGravando.blnConfirma;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmImportaPrecos.fImportaItens]');
      Result := False;
    End;
  End;
  pFreeAndNil(frmGravando);
End;

function TfrmImportaPrecos.fCarregaItens: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fCarregaDados;
    frmGravando.lblGravando.Caption := 'Aguarde, carregando itens...';
    frmGravando.ShowModal;
    Result                    := frmGravando.blnConfirma;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmImportaPrecos.fImportaItens]');
      Result := False;
    End;
  End;
  pFreeAndNil(frmGravando);
End;

procedure TfrmImportaPrecos.btnCarregarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    If fImportaItens And fCarregaItens Then
      pnlPath.Enabled := False;

    If fTemInconsistencias Then
      btnRelInc.Click;
  End;

end;

procedure TfrmImportaPrecos.btnGravarClick(Sender: TObject);
begin
  inherited;

  If cdsItens.IsEmpty Then
  Begin
    pMensagemOk('Nenhum item importado para atualização!');
    Exit;
  End;

  If Not fPergunta('Confirma a atualização dos preços?') Then
    Exit;

  blnAtualizou := fAtualizaPrecos;

  If blnAtualizou Then
  Begin
    pMensagemOk('Preços atualizados com sucesso!');
    Close;
  End;
end;

procedure TfrmImportaPrecos.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pMensagemOk('A primeira linha da planilha é para o titulo' + #13 +
              'Coluna A = Código do Produto' + #13 +
              'Coluna B = Novo Preço de Venda.')
end;

procedure TfrmImportaPrecos.btnRelIncClick(Sender: TObject);
begin
  inherited;

  pMostraRelInconsistencias;
end;

Function TfrmImportaPrecos.fTemInconsistencias: Boolean;
Begin
  With cdsItens Do
  Begin
    Try
      DisableControls;

      Filter   := 'STATUS <> ' + QuotedStr('S');
      Filtered := True;
      Result := RecordCount > 0;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmImportaPrecos.fTemInconsistencias]');
      End;
    End;

    Filtered := False;
    First;
    EnableControls;
  End;
End;

procedure TfrmImportaPrecos.pMostraRelInconsistencias;
Begin
  With cdsItens Do
  Begin
    Try
      DisableControls;

      Filter   := 'STATUS <> ' + QuotedStr('S');
      Filtered := True;
      First;

      If RecordCount = 0 Then
      Begin
        pMensagemOk('Nenhuma inconsistência encontrada!')
      End Else
      With frxInconsistencias Do
      Begin
        Script.Variables['NOMEMP'] := fRetNomeEmpresa;
        Script.Variables['NOMREL'] := 'RELATÓRIO DE INCONSISTÊNCIAS';

        ShowReport;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportaPrecos.pMostraRelInconsistencias]');
      End;
    End;

    Filtered := False;
    First;
    EnableControls;
  End;

End;

function TfrmImportaPrecos.fRetPrecoCusto(dataSet: TDataSet; fltIcmEnt, fltSubst, fltSubFed: Double): Double;
  Var
    blnUtilizarConversorDeMoeda: Boolean;
begin
  cpcParams.curPreCom := dataSet.FieldByName('ITE_PRECOM').AsFloat;
  cpcParams.curDesF01 := dataSet.FieldByName('ITE_DESF01').AsFloat;
  cpcParams.curDesF02 := dataSet.FieldByName('ITE_DESF02').AsFloat;
  cpcParams.curDesF03 := dataSet.FieldByName('ITE_DESF03').AsFloat;
  cpcParams.curDesF04 := dataSet.FieldByName('ITE_DESF04').AsFloat;
  cpcParams.curDesF05 := dataSet.FieldByName('ITE_DESF05').AsFloat;
  cpcParams.curDesF06 := dataSet.FieldByName('ITE_DESF06').AsFloat;
  cpcParams.curICMSEnt:= fltIcmEnt;
  cpcParams.curIPIEnt := dataSet.FieldByName('ITE_IPIENT').AsFloat;
  cpcParams.curFrete  := dataSet.FieldByName('ITE_FREENT').AsFloat;
  cpcParams.curAcrFin := dataSet.FieldByName('ITE_ACRFIN').AsFloat;
  cpcParams.curSubsti := fltSubst;
  cpcParams.curValFre := dataSet.FieldByName('ITE_VALFRE').AsFloat;
  cpcParams.curDesAdb := dataSet.FieldByName('ITE_DESADB').AsFloat;
  cpcParams.curSubFed := fltSubFed;

  if blnSufram and (strFrmCus = '4') then
  begin
    cpcParams.curTCIFCu := dataSet.FieldByName('ITE_TCIFCU').AsFloat;
    cpcParams.curTSCust := dataSet.FieldByName('ITE_TSCUST').AsFloat;
    cpcParams.curDePiCo := dataSet.FieldByName('ITE_DEPICO').AsFloat;
    cpcParams.curDeICMS := dataSet.FieldByName('ITE_DEICMS').AsFloat;
    cpcParams.curFatReg := dataSet.FieldByName('ITE_FATREG').AsFloat;
  end
  else
  begin
    cpcParams.curTCIFCu := 0;
    cpcParams.curTSCust := 0;
    cpcParams.curDePiCo := 0;
    cpcParams.curDeICMS := 0;
    cpcParams.curFatReg := 0;
  end;

  blnUtilizarConversorDeMoeda := dataSet.FieldByName('ITE_PREDOL').AsString = 'S';

  Result := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoeda);
end;


function TfrmImportaPrecos.fCarregaDados(pgbStatus: TcxProgressBar): Boolean;
  Var
    intMax : Integer;
    qryItem: TUniQuery;
    fltPreFor: Double;
    strMask: String;
    intContador: Integer;
//    fltComLiq,
    fltIcmEnt,
    fltIcmSai,
    fltSubsti,
    fltImpFed,
    fltSubFed,
    fltDesOpe,
    fltOutVal,
    fltPreVen,
    fltPrecus: Double;
Begin
  Try
    strMask := fMskDigitos(intDecUni);

    qryItem := fCriaQuery;
    qryItem.SQL.Text := fSQLItens(True, cbbTabPre.Text);

    cdsItens.DisableControls;

    intMax := cdsItens.RecordCount;

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := intMax;

    With cdsItens Do
    Begin
      First;

      While Not Eof Do
      Begin
        qryItem.Close;
        qryItem.ParamByName('CODITE').AsString := FieldByName('CODITE').AsString;
        qryItem.Open;

        Edit;

        If qryItem.IsEmpty Then
        Begin
          FieldByName('STATUS').AsString := ERR_NAO_ECONTRADO;
        End Else
        Begin
          For intContador := 0 To Fields.Count - 1 Do
          If Pos(Fields[intContador].FieldName, 'CODITE_PRENOV_STATUS_') <= 0 Then
            Fields[intContador].Value := qryItem.Fields[intContador].Value;

          If fEmptyStr(qryItem.FieldByName('CODTAB').AsString) Then
          Begin
            FieldByName('STATUS').AsString := ERR_SEM_TABELA_PRECO
          End Else
          Begin
            {fltComLiq := untfuncoesSimples.fCalculaPrecoCompraLiq(qryItem.FieldByName('ITE_PRECOM').AsFloat,
                                                                  qryItem.FieldByName('ITE_DESF01').AsFloat,
                                                                  qryItem.FieldByName('ITE_DESF02').AsFloat,
                                                                  qryItem.FieldByName('ITE_DESF03').AsFloat,
                                                                  qryItem.FieldByName('ITE_DESF04').AsFloat,
                                                                  qryItem.FieldByName('ITE_DESF05').AsFloat,
                                                                  qryItem.FieldByName('ITE_DESF06').AsFloat,
                                                                  intDecUni,
                                                                  qryItem.FieldByName('ITE_PREDOL').AsString = 'S'); }

            CalculaComposicaoCusto := TCalculaComposicaoCusto.fRetCustoTabDet(qryItem.FieldByName('ITE_IPIENT').AsFloat,
                                                                              qryItem.FieldByName('ITE_INCPIS').AsString = 'S',
                                                                              qryItem.FieldByName('ITE_CODFOR').AsString,
                                                                              qryItem.FieldByName('ITE_CODABF').AsString,
                                                                              qryItem.FieldByName('INCDET').AsString,
                                                                              cbbTabPre.Text,
                                                                              VS_strCodEmp) ;

            Try
              If CalculaComposicaoCusto.BlnSemST then
              Begin
                fltIcmEnt := CalculaComposicaoCusto.AliquotaICMSEnt;
                fltIcmSai := CalculaComposicaoCusto.AliquotaICMSSai;
                fltSubsti := 0;
              End
              Else
              begin
                fltIcmEnt := 0;
                fltIcmSai := 0;
                fltSubsti := CalculaComposicaoCusto.AliquotaST;
              End;

              fltImpFed := CalculaComposicaoCusto.ImpFed;
              fltSubFed := CalculaComposicaoCusto.SubFed;
              fltDesOpe := CalculaComposicaoCusto.DesOpe;
              fltOutVal := CalculaComposicaoCusto.OutVal;
            Finally
              FreeAndNil(CalculaComposicaoCusto);
            End;
            fltPrecus := fRetPrecoCusto(qryItem, fltIcmEnt, fltSubsti, fltSubFed)+
                         (fltOutVal);
            fltPreVen := cdsItens.FieldByName('PRENOV').AsFloat * qryItem.FieldByName('CNVCUS').AsFloat;
            cdsItens.FieldByName('MARNOV').AsFloat  := fCalculaPrecoVenda(2,
                                                                 fltPrecus,
                                                                 fltPreVen,
                                                                 0,
                                                                 fltIcmSai,
                                                                 fltImpFed,
                                                                 fltDesOpe,
                                                                 qryItem.FieldByName('ITE_COMTBL').AsFloat,
                                                                 '',
                                                                 '',
                                                                 intDecUni);




            fltPreFor := fStrToFloat(FormatFloat(strMask, FieldByName('PRENOV').AsFloat * qryItem.FieldByName('CNVCUS').AsFloat));
            fltPrecus := fltPrecus * qryItem.FieldByName('CNVCUS').AsFloat;

            FieldByName('PREFOR').AsFloat  := fltPreFor;

            FieldByName('MARFOR').AsFloat  := fCalculaPrecoVenda(2,
                                                                 fltPrecus,
                                                                 fltPreFor,
                                                                 0,
                                                                 fltIcmSai,
                                                                 fltImpFed,
                                                                 fltDesOpe,
                                                                 qryItem.FieldByName('ITE_COMTBL').AsFloat,
                                                                 '',
                                                                 '',
                                                                 intDecUni);

            FieldByName('PREAT' + cbbTabPre.Text).AsFloat  := FieldByName('PRENOV').AsFloat;
            FieldByName('MARAT' + cbbTabPre.Text).AsFloat  := FieldByName('MARNOV').AsFloat;
          End;

        End;

        Post;

        Next;
        pgbStatus.Position := pgbStatus.Position + 1;
        Application.ProcessMessages;
      End;

      First;
    End;

    Result := True;

    FreeAndNil(qryItem);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmImportaPrecos.fImportaItens]');
      Result := False;
    End;
  End;

  cdsItens.EnableControls;
End;

function TfrmImportaPrecos.fAtualizaPrecos: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravaItens;
    frmGravando.lblGravando.Caption  := 'Aguarde, atualizando preços...';
    frmGravando.ShowModal;
    Result                    := frmGravando.blnConfirma;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmImportaPrecos.fAtualizaPrecos]');
      Result := False;
    End;
  End;
  pFreeAndNil(frmGravando);
End;

function TfrmImportaPrecos.fSQLIteger(strPreVen: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE ITEGER SET ';
  strSQL := strSQL + '   ITE_PREVE' + strPreVen + ' = :PREVEN, ';
  strSQL := strSQL + '   ITE_MARBR' + strPreVen + ' = :MARBRU, ';
  strSQL := strSQL + '   ITE_PREALT = :ITE_PREALT ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '   ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  Result := strSQL;
End;

function TfrmImportaPrecos.fSQLDetCus(strPreVen: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE DETCUS ';
  strSQL := strSQL + '  SET          ';
  strSQL := strSQL + '   DET_PREVEN = :PREVEN,    ';
  strSQL := strSQL + '   DET_MARBRU = :MARBRU     ';
  strSQL := strSQL + ' WHERE DET_SEQDET = :INCDET ';
  strSQL := strSQL + '   AND DET_TABELA = ' + strPreVen + ';';

  Result := strSQL;
End;


function TfrmImportaPrecos.fInserePreAlt: Boolean;
Begin
  Result := True;
  If Not VS_blnPreAltViaTrigger Then
  begin
    Result := fGravaPreAlt(cdsItens.FieldByName('CODITE').AsString,
                           cdsItens.FieldByName('CUSITE').AsFloat,
                           cdsItens.FieldByName('CUSITE').AsFloat,
                           cdsItens.FieldByName('PREAN1').AsFloat,
                           cdsItens.FieldByName('PREAT1').AsFloat,
                           cdsItens.FieldByName('MARAN1').AsFloat,
                           cdsItens.FieldByName('MARAT1').AsFloat,
                           cdsItens.FieldByName('PREAN2').AsFloat,
                           cdsItens.FieldByName('PREAT2').AsFloat,
                           cdsItens.FieldByName('MARAN2').AsFloat,
                           cdsItens.FieldByName('MARAT2').AsFloat,
                           cdsItens.FieldByName('PREAN3').AsFloat,
                           cdsItens.FieldByName('PREAT3').AsFloat,
                           cdsItens.FieldByName('MARAN3').AsFloat,
                           cdsItens.FieldByName('MARAT3').AsFloat,
                           cdsItens.FieldByName('PREAN4').AsFloat,
                           cdsItens.FieldByName('PREAT4').AsFloat,
                           cdsItens.FieldByName('MARAN4').AsFloat,
                           cdsItens.FieldByName('MARAT4').AsFloat,
                           cdsItens.FieldByName('PREAN5').AsFloat,
                           cdsItens.FieldByName('PREAT5').AsFloat,
                           cdsItens.FieldByName('MARAN5').AsFloat,
                           cdsItens.FieldByName('MARAT5').AsFloat,
                           cdsItens.FieldByName('PREAN6').AsFloat,
                           cdsItens.FieldByName('PREAT6').AsFloat,
                           cdsItens.FieldByName('MARAN6').AsFloat,
                           cdsItens.FieldByName('MARAT6').AsFloat,
                           cdsItens.FieldByName('PREAN7').AsFloat,
                           cdsItens.FieldByName('PREAT7').AsFloat,
                           cdsItens.FieldByName('MARAN7').AsFloat,
                           cdsItens.FieldByName('MARAT7').AsFloat,
                           cdsItens.FieldByName('ITE_PRECOM').AsFloat,
                           cdsItens.FieldByName('ITE_PRECOM').AsFloat,
                           'IMPORTAÇÃO DE PREÇOS PELO XML',
                           Nil,
                           '',
                           strLoginUsuarioLogado);
  End;


End;

function TfrmImportaPrecos.fGravaItens(pgbStatus: TcxProgressBar): Boolean;
  Var
    intMax : Integer;
    qryIteger: TUniQuery;
    qryDetCus: TUniQuery;
Begin
  Try
    Result := True;

    qryIteger:= fCriaQuery;
    qryDetCus:= fCriaQuery;

    qryIteger.SQL.Text := fSQLIteger(cbbTabPre.Text);
    qryDetCus.SQL.Text := fSQLDetCus(cbbTabPre.Text);

    cdsItens.DisableControls;

    With cdsItens Do
    Begin
      Filter   := 'STATUS = ' + QuotedStr('S');
      Filtered := True;

      intMax := cdsItens.RecordCount;
      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := intMax;

      First;

      While Not Eof Do
      Begin

        fStartTransaction;

        qryIteger.Close;
        qryIteger.ParamByName('CODITE').AsString := FieldByName('CODITE').AsString;
        qryIteger.ParamByName('PREVEN').AsFloat  := FieldByName('PRENOV').AsFloat;
        qryIteger.ParamByName('MARBRU').AsFloat  := FieldByName('MARNOV').AsFloat;
        qryIteger.ParamByName('ITE_PREALT').AsString := strAgrupadorPreAlt;
        qryIteger.ExecSQL;


        qryDetCus.Close;
        qryDetCus.ParamByName('INCDET').AsString := FieldByName('INCDET').AsString;
        qryDetCus.ParamByName('PREVEN').AsFloat  := FieldByName('PREFOR').AsFloat;
        qryDetCus.ParamByName('MARBRU').AsFloat  := FieldByName('MARFOR').AsFloat;
        qryDetCus.ExecSQL;

        Result := fInserePreAlt;

        If Result Then
          fCommit
        Else
          fRollBack;

        If Not Result Then
          Break;

        Next;
        pgbStatus.Position := pgbStatus.Position + 1;
        Application.ProcessMessages;
      End;

      First;
    End;

    FreeAndNil(qryIteger);
    FreeAndNil(qryDetCus);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmImportaPrecos.fGravaItens]');
      Result := False;
    End;
  End;

  cdsItens.Filtered := False;
  cdsItens.EnableControls;
End;

end.

