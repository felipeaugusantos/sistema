unit untGerInventario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask,
  MaskEditFocus, ComboBoxFocus,  Uni, CheckLst, AppEvnts, UniClientDataSet,  untFuncoesConsulta,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxProgressBar, untGravando, EditFocus, untTypesSistema,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, untZClient,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, cxTextEdit;

type
  TfrmGerInventario = class(TfrmPai)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    btnGravar: TBitBtnLocked;
    btnCopiar: TBitBtnLocked;
    chkInverter: TCheckBox;
    rdbEntFut: TRadioGroup;
    btnExcluir: TBitBtnLocked;
    chkSumNeg: TCheckBox;
    chkOrdInd: TCheckBox;
    chkOrdPro: TCheckBox;
    edtCodEmpresa: TEditFocus;
    lblEmpresa: TLabel;
    edtDesEmpresa: TEditFocus;
    cxvArqs: TcxGridDBTableView;
    cxgArqsLevel1: TcxGridLevel;
    cxgArqs: TcxGrid;
    cxvArqsNomArq: TcxGridDBColumn;
    cxvArqsMARCAR: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lstArquivosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure btnCopiarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure chkInverterClick(Sender: TObject);
    procedure chkSumNegClick(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryIteGer    : TUniQuery;
    strForFil,
    strNomTabBas : String;
    strEspDoc    : String;
    qryGen       : TUniQuery;
    blnContribuinteIPI: Boolean;
    blnMedSe2,
    blnAtuMed,
    blnExcInv    : Boolean;
    blnSalMlBase : Boolean;
    blnMedEmpGlobal : Boolean;
    strEmpMedEmp : String;


    cdsTabelas: TZClient;

    Procedure pAfterPost(dataSet: TDataSet);
    Procedure pAfterScroll(dataSet: TDataSet);

    Function fCarregaMovimentoItem(strCodIte: String; strCodEmp: String; Var fltPreMed, fltSalMov, fltPreUlt, fltImpUlt: Double; blnGlobal: Boolean = False; blnCalcMed: Boolean = True): Boolean;

    procedure pCarregaArqBase;
    procedure pCriaTabela(strNovaTabela: String);
    Function fProcessaArquivo(strNovaTabela: String; pgbProgressBar: TcxProgressBar): Boolean;
    procedure pCriaIndices(strTabela, strCampos: String);

    procedure pCopiarTabela(strTabela, strNovaTabela: String);

    function fRetSaldoIniItem(strCodIte: String; strCodEmp: String; Var fltPreMed, fltCnv_ML, fltPreUlt, fltImpUlt: Double;
                               Var blnTemNoArquivoBase: Boolean; blnGlobal: Boolean = False): Double;

    function fRetNumMesSelec: String;
    function fValidaArqSelecionado(strArqSel: String;
      var strNovoArq: String): Boolean;

    Function fSQLMovDet(strTabela: String; blnGlobal: Boolean = False): String;
    procedure pSomaItens(strNovaTabela: String);
    Function fGerarArquivo(pgbProgressBar: TcxProgressBar): boolean;

    Function fGetProdutosLigacaoAutomotiva: String;


  public
    { Public declarations }
    arrLinEmp: TConsultasArray;
    strLinEmp: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;


  end;

var
  frmGerInventario: TfrmGerInventario;

implementation

uses untfuncoesSimples,  StrUtils, untConstantes, untConsultas;

{$R *.dfm}

procedure TfrmGerInventario.pCarregaArqBase;
  Var
    strSQL: String;

begin

  cdsTabelas.EmptyDataSet;

  strSQL := '';
  strSQL := strSQL + 'SHOW TABLES ';
  strSQL := strSQL + '  LIKE "I\_%"';
  With qryGen Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    While Not Eof Do
    Begin
      cdsTabelas.Append;
      cdsTabelas.FieldByName('MARCAR').AsString := 'N';
      cdsTabelas.FieldByName('NOMARQ').AsString := Fields[0].AsString;
      cdsTabelas.Post;

      Next;
    End;

  End;

  strSQL := '';
  strSQL := strSQL + 'SHOW TABLES ';
  strSQL := strSQL + '  LIKE "SALINV%"';
  With qryGen Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    While Not Eof Do
    Begin
      cdsTabelas.Append;
      cdsTabelas.FieldByName('MARCAR').AsString := 'N';
      cdsTabelas.FieldByName('NOMARQ').AsString := Fields[0].AsString;
      cdsTabelas.Post;

      Next;
    End;

  End;

  cdsTabelas.AfterPost   := pAfterPost;
  cdsTabelas.AfterScroll := pAfterScroll;
  pAfterScroll(cdsTabelas);

  cxvArqs.NavigatorButtons.First.Click;
end;

procedure TfrmGerInventario.FormCreate(Sender: TObject);
begin
  inherited;
  qryIteGer := fCriarQuery('DESC ITEGER ', Self);
  qryIteGer.Open;

  blnContribuinteIPI := (fCfgSis('CONIPI', varBoolean));

  cdsTabelas := TZClient.Create(Self, 'SELECT "N" AS MARCAR, CAST(NULL AS CHAR(255)) AS NOMARQ');
  cdsTabelas.fLeDados('TfrmGerInventario.FormCreate');
  cxvArqs.DataController.DataSource := cdsTabelas.dtsSource;

  qryGen := fCriaQuery;

  blnAtuMed := fCfgSis('ATUMED', varBoolean);
  blnMedSe2 := fCfgSis('MEDSE2', varBoolean);
  strForFil := fRetForFilialTodos;

  chkOrdInd.Visible := fCfgSis('UTIIND', varBoolean);
  If (not chkOrdInd.Visible) Then
  Begin
    Self.Height := Self.Height - chkOrdInd.Height - 4;
    rdbEntFut.Top := rdbEntFut.Top - chkOrdInd.Height - 4;
  End;
  edtCodEmpresa.Text := VS_StrCodEmp;
  chkOrdPro.Visible := fCfgSis('ORDPRO', varBoolean);
  If (Not chkOrdPro.Visible) Then
  Begin
    Self.Height := Self.Height - chkOrdPro.Height - 4;
    rdbEntFut.Top := rdbEntFut.Top - chkOrdPro.Height;
  End;

  If (not chkOrdInd.Visible) And (chkOrdPro.Visible) Then
  Begin
    chkOrdPro.Top := chkOrdPro.Top - chkOrdPro.Height - 4;
  End;

  //*************************************************//
  // CARREGA ARQUIVOS DE INVENTARIO                  //
  //**********************************************ED*//
  pCarregaArqBase;
  blnExcInv := fVerificaAcessoSistema('EXCINV');
end;

procedure TfrmGerInventario.btnExcluirClick(Sender: TObject);
  Var
    qryExcluir : TUniQuery;
begin
  inherited;
  If not blnExcInv Then
  Begin
    fMensagem('ATENÇÃO', 'Usuário sem permissão para excluir arquivos de inventário', ['&OK']);
    Exit;
  End;

  If fMensagem('ATENÇÃO', 'Deseja realmente excluir o arquivo: ' + cdsTabelas.FieldByName('NOMARQ').AsString + ' ?', ['&Sim','&Não'], 2) = 2 Then
    Exit;

  Try
    qryExcluir := fCriaQuery(Self);
    With qryExcluir, Sql Do
    Begin
      Add('DROP TABLE ' + cdsTabelas.FieldByName('NOMARQ').AsString + ';') ;
      Add('DELETE FROM TCOARR WHERE TCA_ARQREL = "'+cdsTabelas.FieldByName('NOMARQ').AsString+'"');

      try
        ExecSQL
      Except
        On E: Exception Do
        Begin
          pMensagensErro(e.Message, '[TfrmGerInventario.btnExcluirClick(Sender: TObject);]');
        End;

      end;
    End;

  Finally
    FreeAndNil(qryExcluir);
  End;
  pCarregaArqBase;
  btnExcluir.Enabled := False;
end;

procedure TfrmGerInventario.btnGravarClick(Sender: TObject);
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  try
    with frmGravando do
    begin
      fExecutarAcao := fGerarArquivo;
      lblGravando.Caption := 'Aguarde... Gerando inventário.';
      ShowModal;
      if blnConfirma Then
        fMensagem('','Geração concluída com sucesso.',['&O K']);
    end;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmGerInventario.fGerarArquivo]');
  End;
  pFreeAndNil(frmGravando);
end;

procedure TfrmGerInventario.chkInverterClick(Sender: TObject);
begin
  inherited;
  if chkSumNeg.Checked And chkInverter.Checked then
    chkSumNeg.Checked := False;
end;

procedure TfrmGerInventario.chkSumNegClick(Sender: TObject);
begin
  inherited;
  if chkSumNeg.Checked And chkInverter.Checked then
    chkInverter.Checked := False;
end;

procedure TfrmGerInventario.edtCodEmpresaExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrLinEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');


end;

procedure TfrmGerInventario.edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrLinEmp, False, True) Then
  Begin
    fValidaCampos(edtCodEmpresa, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;


function TfrmGerInventario.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;

  var intIndex: Integer;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA A DATA INICIAL                 *}
    {**************************************ED*}
    If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Result := False;

    End

    {*****************************************}
    {* VALIDA A DATA FINAL                   *}
    {**************************************ED*}
    Else If (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End

      End;
    End    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        If (edtCodEmpresa.Text <> '000') Then
          edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não cadastrada!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If Length(arrLinEmp) > 0 Then
          Begin
            For intIndex := Low(arrLinEmp) To High(arrLinEmp) Do
              If Pos(arrLinEmp[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
              Begin
                fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a Empresa ' + arrLinEmp[intIndex].strCodigo + '!', ['&O k']);
                Result := False;
                Break;
              End;
          End
          Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else pDesmarcaLista(edtCodEmpresa, arrLinEmp);
    End ;


  End;

  If Not Result Then
    pSetFocus(Sender);


end;




procedure TfrmGerInventario.pCriaTabela(strNovaTabela: String);
  Var
    strSQL       : String;
begin
  strSQL := '';
  strSQL := strSQL + 'CREATE TABLE ';
  strSQL := strSQL + '`'+strNovaTabela+'`';
  strSQL := strSQL + '  ( AUTOINCREM VARCHAR(20) NOT NULL, ';

  qryIteGer.First;
  While not qryIteGer.Eof Do
  Begin
    If qryIteGer.FieldByName('Field').AsString <> 'AUTOINCREM' Then
      strSQL := strSQL + qryIteGer.FieldByName('Field').AsString  + ' ' +  qryIteGer.FieldByName('Type').AsString + ', ';
    qryIteGer.Next;
  End;

  strSQL := strSQL + '    ITE_CODUNI  char(2),       ';
  strSQL := strSQL + '    ITE_DESITE  varchar(70),   ';
  strSQL := strSQL + '    ITE_REFERE  varchar(16),   ';
  strSQL := strSQL + '    ITE_CLAIPI  varchar(10),   ';
  strSQL := strSQL + '    ITE_CODGRU  varchar(6),    ';
  strSQL := strSQL + '    ITE_CNV_ML  decimal(12,4), ';
  strSQL := strSQL + '    ITE_ITEATI  char(1),       ';
  strSQL := strSQL + '    ITE_BASE_E  decimal(12,2), ';
  strSQL := strSQL + '    ITE_BASE_S  decimal(12,2), ';
  strSQL := strSQL + '    ITE_ALQ__E  decimal(12,2), ';
  strSQL := strSQL + '    ITE_ALQ__S  decimal(12,2), ';
  strSQL := strSQL + '    ITE_CODSIT  char(3),       ';
  strSQL := strSQL + '    ITE_SITCON  char(3),       ';
  strSQL := strSQL + '    PRIMARY KEY (AUTOINCREM)) ';

  strSQL := strSQL + 'ENGINE=InnoDB; ';


  strSQL := strSQL + 'ALTER TABLE `' + strNovaTabela + '` ADD CONSTRAINT `FK_CODITE_'+ strNovaTabela +'` '+
   ' FOREIGN KEY (`ITE_CODITE`) REFERENCES `CADITE`(`ITE_CODITE`) ON UPDATE CASCADE ON DELETE CASCADE; ';

  strSQL := strSQL + 'REPLACE INTO TCOARR (TCA_ARQUIV, TCA_ARQREL, TCA_CAMREL, TCA_DESCRI, TCA_DELDUP) VALUES ' +
                                         '("CADITE", "' + strNovaTabela + '", "ITE_CODITE", "INVENTARIO" , 0); ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

end;


Function TfrmGerInventario.fProcessaArquivo(strNovaTabela: String; pgbProgressBar: TcxProgressBar): Boolean;
  Var
    strIteLig,
    strItemAnterior,
    strSQL    : String;
    fltSalMov,
    fltSldIni,
    fltPreMed,
    fltCnv_ML,
    fltPreUlt,
    fltImpUlt : Double;
    fltSalMovGlb,
    fltSldIniGlb,
    fltPreMedGlb,
    fltCnv_MLGlb,
    fltPreUltGlb,
    fltImpUltGlb : Double;
    qryGenIte : TUniQuery;
    blnTemNoArquivoBase,
    blnTemBaseGlb : Boolean;
Begin
  Result := True;

  qryGenIte := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  If fCfgSIs('TIPABF') = '1' Then
    strSQL := strSQL + '   I.ITE_CODABF, '
  Else
    strSQL := strSQL + '   G.ITE_CODABF, ';

  qryIteGer.First;
  While not qryIteGer.Eof Do
  Begin
    If (qryIteGer.FieldByName('Field').AsString <> 'ITE_CODABF') And
       (qryIteGer.FieldByName('Field').AsString <> 'AUTOINCREM') Then
      strSQL := strSQL + 'G.' + qryIteGer.FieldByName('Field').AsString  + ', ';
    qryIteGer.Next;
  End;

  strSQL := strSQL + '     I.ITE_CODUNI,                     ';
  strSQL := strSQL + '     I.ITE_DESITE,                     ';
  strSQL := strSQL + '     I.ITE_REFERE,                     ';
  strSQL := strSQL + '     I.ITE_CLAIPI,                     ';
  strSQL := strSQL + '     I.ITE_CODGRU,                     ';
  strSQL := strSQL + '     I.ITE_CNV_ML,                     ';
  strSQL := strSQL + '     I.ITE_ITEATI,                     ';
  strSQL := strSQL + '     ABF_BASICM_ENT_PEJ AS ITE_BASE_E, ';
  strSQL := strSQL + '     ABF_BASICM_SAI_CCO AS ITE_BASE_S, ';
  strSQL := strSQL + '     ABF_ALQICM_ENT_PEJ AS ITE_ALQ__E, ';
  strSQL := strSQL + '     ABF_ALQICM_SAI_CCO AS ITE_ALQ__S, ';
  strSQL := strSQL + '     ABF_CODSIT_SAI_CNC AS ITE_CODSIT, ';
  strSQL := strSQL + '     ABF_CODSIT_SAI_CCO AS ITE_SITCON  ';

  strSQL := strSQL + ' FROM ITEGER G   ';
  strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + ' INNER JOIN CADEMP   ON   EMP_CODEMP = G.ITE_CODEMP ';
  strSQL := strSQL + ' INNER JOIN CADCID   ON   CID_CODCID = EMP_CODCID   ';
  If fCfgSIs('TIPABF') = '1' Then
    strSQL := strSQL + ' LEFT JOIN ABFICM A ON ABF_CODABF = I.ITE_CODABF AND ABF_ESTADO = CID_ESTADO '
  else
    strSQL := strSQL + ' LEFT JOIN ABFICM A ON ABF_CODABF = G.ITE_CODABF AND ABF_ESTADO = CID_ESTADO ';

  strSQL := strSQL + ' WHERE I.ITE_DTACAD <= :DTACAD  ';

  strSQL := strSQL + fStrLocate(edtCodEmpresa, arrLinEmp, 'G.ITE_CODEMP', 'CODEMP');


  strIteLig := fGetProdutosLigacaoAutomotiva;

  if Not fEmptyStr(strIteLig) Then
    strSQL := strSQL + ' AND I.ITE_CODITE NOT IN (' + strIteLig  + ')';

  strSQL := strSQL + ' ORDER BY G.ITE_CODITE ';


  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    pSetaParam(edtCodEmpresa.Text, arrLinEmp, strLinEmp, 'CODEMP', qryGen);
    ParamByName('DTACAD').AsDate   := StrToDate(mskDtaFin.Text);
    Open;

    pgbProgressbar.Position := 1;
    pgbProgressbar.Properties.Max := RecordCount;

    If Not IsEmpty Then
    Begin

      qryGenIte.Close;
      qryGenIte.SQL.Clear;
      qryGenIte.SQL.Add('SELECT * FROM `' + strNovaTabela + '` WHERE FALSE');
      qryGenIte.Open;

      strItemAnterior := '';

      While Not Eof Do
      Begin
        blnMedEmpGlobal := (fCfgSis('MEDEMP', varString, qryGen.FieldByName('ITE_CODEMP').AsString) = '1') And (Not fEmptyStr(strEmpMedEmp));

        // BUSCA NO ARQUIVO SELECIONADO (SALDO POR EMPRESA)
        fltSldIni := fRetSaldoIniItem(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_CODEMP').AsString, fltPreMed, fltCnv_ML, fltPreUlt, fltImpUlt, blnTemNoArquivoBase);

        fltSalMov := fltSldIni;
        Result := fCarregaMovimentoItem(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_CODEMP').AsString, fltPreMed, fltSalMov, fltPreUlt, fltImpUlt, False, Not blnMedEmpGlobal);

        If Not Result Then
          Break;

        // PRECO MEDIO GLOBAL (CFG_MEDEMP = '1'): SOMA DO ESTOQUE DE TODAS AS
        // EMPRESAS DO GRUPO. CALCULA UMA VEZ POR ITEM (REGISTROS ORDENADOS
        // POR ITE_CODITE) E REPLICA O MESMO VALOR EM TODAS AS EMPRESAS.
        If blnMedEmpGlobal And (FieldByName('ITE_CODITE').AsString <> strItemAnterior) Then
        Begin
          fltSldIniGlb := fRetSaldoIniItem(FieldByName('ITE_CODITE').AsString, '', fltPreMedGlb, fltCnv_MLGlb, fltPreUltGlb, fltImpUltGlb, blnTemBaseGlb, True);
          fltSalMovGlb := fltSldIniGlb;
          Result := fCarregaMovimentoItem(FieldByName('ITE_CODITE').AsString, '', fltPreMedGlb, fltSalMovGlb, fltPreUltGlb, fltImpUltGlb, True, True);

          If Not Result Then
            Break;

          strItemAnterior := FieldByName('ITE_CODITE').AsString;
        End;

        qryGenIte.Insert;
        qryGenIte.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SALINV',qryGen.FieldByName('ITE_CODEMP').AsString);

        qryIteGer.First;
        While not qryIteGer.Eof Do
        Begin
          If (qryIteGer.FieldByName('Field').AsString <> 'AUTOINCREM') Then
            qryGenIte.FieldByName( qryIteGer.FieldByName('Field').AsString ).Value := qryGen.FieldByName(qryIteGer.FieldByName('Field').AsString).Value;
          qryIteGer.Next;
        End;

        If fltCnv_ML > 0 Then
        Begin
          qryGenIte.FieldByName('ITE_SALDOS').AsFloat  := Trunc(fltSalMov);
          qryGenIte.FieldByName('ITE_SAL_ML').AsFloat  := Frac(fltSalMov) * fltCnv_ML;
        End
        Else
        Begin
          qryGenIte.FieldByName('ITE_SALDOS').AsFloat  := fltSalMov;
          qryGenIte.FieldByName('ITE_SAL_ML').AsFloat  := 0.00;
        End;

        If blnMedEmpGlobal Then
        Begin
          qryGenIte.FieldByName('ITE_PREULT').AsFloat  := fltPreUltGlb;
          qryGenIte.FieldByName('ITE_IMPULT').AsFloat  := fltImpUltGlb;
          qryGenIte.FieldByName('ITE_PREMED').AsFloat  := fltPreMedGlb;
        End
        Else
        Begin
          qryGenIte.FieldByName('ITE_PREULT').AsFloat  := fltPreUlt;
          qryGenIte.FieldByName('ITE_IMPULT').AsFloat  := fltImpUlt;
          qryGenIte.FieldByName('ITE_PREMED').AsFloat  := fltPreMed;
        End;
        qryGenIte.FieldByName('ITE_SALBAL').AsFloat  := fltSldIni;

        qryGenIte.FieldByName('ITE_CODUNI').AsString := FieldByName('ITE_CODUNI').AsString;
        qryGenIte.FieldByName('ITE_DESITE').AsString := FieldByName('ITE_DESITE').AsString;
        qryGenIte.FieldByName('ITE_REFERE').AsString := FieldByName('ITE_REFERE').AsString;
        qryGenIte.FieldByName('ITE_CLAIPI').AsString := FieldByName('ITE_CLAIPI').AsString;
        qryGenIte.FieldByName('ITE_CODGRU').AsString := FieldByName('ITE_CODGRU').AsString;
        qryGenIte.FieldByName('ITE_CNV_ML').AsFloat  := FieldByName('ITE_CNV_ML').AsFloat;
        qryGenIte.FieldByName('ITE_ITEATI').AsString := FieldByName('ITE_ITEATI').AsString;
        qryGenIte.FieldByName('ITE_BASE_E').AsFloat  := FieldByName('ITE_BASE_E').AsFloat;
        qryGenIte.FieldByName('ITE_BASE_S').AsFloat  := FieldByName('ITE_BASE_S').AsFloat;
        qryGenIte.FieldByName('ITE_ALQ__E').AsFloat  := FieldByName('ITE_ALQ__E').AsFloat;
        qryGenIte.FieldByName('ITE_ALQ__S').AsFloat  := FieldByName('ITE_ALQ__S').AsFloat;
        qryGenIte.FieldByName('ITE_CODSIT').AsString := FieldByName('ITE_CODSIT').AsString;
        qryGenIte.FieldByName('ITE_SITCON').AsString := FieldByName('ITE_SITCON').AsString;

        qryGenIte.Post;

        Next;
        pgbProgressbar.Position := pgbProgressbar.Position + 1;
        Application.ProcessMessages;
      End;
    End
   Else
     fMensagem('Atenção', 'Não há registros para gerar inventário.', ['&OK']);
    Close;
  End;
  FreeAndNil(qryGenIte);
end;

function TfrmGerInventario.fRetSaldoIniItem(strCodIte: String; strCodEmp: String; Var fltPreMed, fltCnv_ML, fltPreUlt, fltImpUlt: Double;
     Var blnTemNoArquivoBase: Boolean; blnGlobal: Boolean): Double;
  Var
    strSQL   : String;
    qryGenSal: TUniQuery;

begin
  Try
    Result := 0;

    qryGenSal := fCriaQuery(Self);

    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      If blnGlobal Then
      Begin
        strSQL := strSQL + ' IFNULL(SUM(B.ITE_SALDOS), 0) AS ITE_SALDOS, ';
        strSQL := strSQL + ' IFNULL(MAX(B.ITE_PREULT), 0) AS ITE_PREULT, ';
        strSQL := strSQL + ' IFNULL(MAX(B.ITE_IMPULT), 0) AS ITE_IMPULT, ';

        If blnSalMlBase Then
        Begin
          strSQL := strSQL + ' IFNULL(SUM(B.ITE_SAL_ML), 0) AS ITE_SAL_ML, ';
          strSQL := strSQL + ' IFNULL(MAX(C.ITE_CNV_ML), 0) AS ITE_CNV_ML, ';
        End;
        strSQL := strSQL + ' IFNULL(SUM(B.ITE_SALDOS * B.ITE_PREMED) / NULLIF(SUM(B.ITE_SALDOS), 0), 0) AS ITE_PREMED ';
      End
      Else
      Begin
        strSQL := strSQL + ' B.ITE_SALDOS, ';
        strSQL := strSQL + ' B.ITE_PREULT, ';
        strSQL := strSQL + ' B.ITE_IMPULT, ';

        If blnSalMlBase Then
        Begin
          strSQL := strSQL + ' B.ITE_SAL_ML, ';
          strSQL := strSQL + ' C.ITE_CNV_ML, ';
        End;
        strSQL := strSQL + ' B.ITE_PREMED ';
      End;
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '`'+ strNomTabBas + '` B ';
      strSQL := strSQL + 'INNER JOIN CADITE C ON C.ITE_CODITE = B.ITE_CODITE ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  B.ITE_CODITE = :CODITE AND ';
      If blnGlobal Then
        strSQL := strSQL + '  B.ITE_CODEMP IN (' + strEmpMedEmp + ') '
      Else
        strSQL := strSQL + '  B.ITE_CODEMP = :CODEMP     ';
      With qryGenSal Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODITE').AsString := strCodIte;
        If Not blnGlobal Then
          ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        blnTemNoArquivoBase := Not IsEmpty;

        fltCnv_ML := 0;
        If IsEmpty Then
        Begin
          Result    := 0;
          fltPreMed := 0;
          fltPreUlt := 0;
          fltImpUlt := 0;
        End Else
        Begin
          Result    := FieldByName('ITE_SALDOS').AsFloat;
          If blnSalMlBase and (FieldByName('ITE_CNV_ML').AsFloat > 0) Then
          Begin
            Result := Result + ( FieldByName('ITE_SAL_ML').AsFloat / FieldByName('ITE_CNV_ML').AsFloat );
            fltCnv_ML := FieldByName('ITE_CNV_ML').AsFloat;
          End;
          fltPreMed := FieldByName('ITE_PREMED').AsFloat;
          fltPreUlt := FieldByName('ITE_PREULT').AsFloat;
          fltImpUlt := FieldByName('ITE_IMPULT').AsFloat;
        End;

        Close;
      End;

    Except
      Result := 0;
    End;

  Finally
    FreeAndNil(qryGenSal);
  End;

end;

procedure TfrmGerInventario.pCriaIndices(strTabela, strCampos: String);
  Var
    strSQL : String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'CREATE INDEX ';
    strSQL := strSQL + '  `IDX_' + strTabela + '_' + strCampos+'` ';
    strSQL := strSQL + ' ON ';
    strSQL := strSQL + ' `' + strTabela + '` ';
    strSQL := strSQL + ' (' + strCampos +')';
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
    End;
  Except
  End;

end;

function TfrmGerInventario.fRetNumMesSelec: String;
Begin
  Result := '';

  If cdsTabelas.Locate('MARCAR', 'S', []) Then
    Result := cdsTabelas.FieldByName('NOMARQ').AsString;
End;

Procedure TfrmGerInventario.pAfterPost(dataSet: TDataSet);
  Var
    strNomArq: String;
Begin
  If cdsTabelas.FieldByName('MARCAR').AsString = 'S' Then
  Begin
    cdsTabelas.DisableControls;

    strNomArq := cdsTabelas.FieldByName('NOMARQ').AsString;

    cdsTabelas.filter := 'MARCAR = ' + QuotedStr('S') + ' AND NOMARQ <> ' + QuotedStr(strNomArq);
    cdsTabelas.filtered := True;

    If Not cdsTabelas.IsEmpty Then
    Begin
      cdsTabelas.Edit;
      cdsTabelas.FieldByName('MARCAR').AsString := 'N';
      cdsTabelas.Post;
    End;

    cdsTabelas.filtered := False;

    cdsTabelas.Locate('MARCAR', 'S', []);

    cdsTabelas.EnableControls;
  End;
End;

Procedure TfrmGerInventario.pAfterScroll(dataSet: TDataSet);
Begin
  btnExcluir.Enabled := SameText( Copy( UpperCase(cdsTabelas.FieldByName('NOMARQ').AsString), 1, 7), 'SALINV_');
End;

procedure TfrmGerInventario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Escape: btnSair.Click;
    VK_RETURN: If ActiveControl Is TRadioButton Then
                 Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmGerInventario.lstArquivosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_Return Then
    pSetFocus(mskDtaIni);

end;

// SELECT CFG_IDEPRO, CFG_CODCFG
// FROM CFGTIN WHERE CFG_CODEMP = '001' AND LENGTH(CFG_VALCFG) = 5 AND LOCATE(CFG_IDEPRO, '_LAZ_SKY_GEN_PPG_ZYN_STA_WAN_WCP_SAL_GLA_DUP_AUT_FAR_GLA_MZA_NEX_BZC_BZA_DOX_STW_AJT_');

Function TfrmGerInventario.fGetProdutosLigacaoAutomotiva(): String;
Const
  AUTOMOT: Array[1..21] Of String = (
'LAZ',
'SKY',
'GEN',
'PPG',
'ZYN',
'STA',
'WAN',
'WCP',
'SAL',
'GLA',
'DUP',
'AUT',
'FAR',
'GLA',
'MZA',
'NEX',
'BZC',
'BZA',
'DOX',
'STW',
'AJT');

  Var
    qryCfgTin: TUniQuery;
    intContador: Integer;
    stlItens: TStringList;
Begin
  stlItens := TStringList.Create;

  qryCfgTin := fCriaQuery;
  qryCfgTin.SQL.Text := 'SELECT CFG_VALCFG FROM CFGTIN WHERE CFG_IDEPRO = :IDEPRO ' +
                        ' AND CFG_CODEMP = :CODEMP AND UPPER(CFG_DESCRI) LIKE "%PRODUTO%VENDA%"';

  for intContador := Low(AUTOMOT) to High(AUTOMOT) do
  Begin
    qryCfgTin.Close;
    qryCfgTin.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCfgTin.ParamByName('IDEPRO').AsString := AUTOMOT[intContador];
    qryCfgTin.Open;

    if Not qryCfgTin.IsEmpty then
      stlItens.Add(QuotedStr(qryCfgTin.FieldByName('CFG_VALCFG').AsString));
  End;

  Result := stlItens.CommaText;

  FreeAndNil(qryCfgTin);
  FreeAndNil(stlItens);
End;

procedure TfrmGerInventario.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(qryGen);
end;

Function TfrmGerInventario.fSQLMovDet(strTabela: String; blnGlobal: Boolean): String;
  Var
    strSQL   : String;
Begin
  strSQL := '';
  strSQL := strSQL + '  SELECT SQL_NO_CACHE ';

  strSQL := strSQL + '    D.DET_NUMDOC, ';
  strSQL := strSQL + '    D.DET_ESPDOC, ';
  strSQL := strSQL + '    D.DET_CODEMP, ';
  strSQL := strSQL + '    D.DET_CODFOR, ';
  strSQL := strSQL + '    D.DET_TOTITE, ';
  strSQL := strSQL + '    D.DET_DESESP, ';
  strSQL := strSQL + '    D.DET_DESACE, ';

  strSQL := strSQL + '    D.DET_CODFIS, ';
  strSQL := strSQL + '    ROUND((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE, 4) AS DET_UNITAR, ';
  strSQL := strSQL + '    D.DET_VALRET, ';
  strSQL := strSQL + '    D.DET_ALQICM, ';
  strSQL := strSQL + '    D.DET_PERBAS, ';
  strSQL := strSQL + '    D.DET_VALIPI, ';
  strSQL := strSQL + '    D.DET_VALICM, ';
  strSQL := strSQL + '    D.DET_CLAFIS, ';
  strSQL := strSQL + '    IF( DET_ESPDOC = "ML", D.DET_QTDITE / ITE_CNV_ML, D.DET_QTDITE  ) AS DET_QTDITE, ';
  strSQL := strSQL + '    D.DET_TOTFRE, ';
  strSQL := strSQL + '    D.DET_INCPIS, ';

  If strTabela = 'MOVDET' Then
    strSQL := strSQL + '    IFNULL(T.DET_CONFRE, 0) AS DET_CONFRE, '
  Else
    strSQL := strSQL + '    0.00 AS DET_CONFRE, ';

  strSQL := strSQL + '    IFNULL(T.DET_VAERET, 0) AS DET_VAERET, ';
  strSQL := strSQL + '    IFNULL(T.DET_VAEIPI, 0) AS DET_VAEIPI, ';

  strSQL := strSQL + '    IFNULL(T.DET_VLGNRE, 0) AS DET_VLGNRE, ';
  strSQL := strSQL + '    IFNULL(T.DET_VALTCI, 0) AS DET_VALTCI, ';
  strSQL := strSQL + '    IFNULL(T.DET_VAL_TS, 0) AS DET_VAL_TS, ';

  strSQL := strSQL + '    IFNULL(T.DET_ICMANT, 0) AS DET_ICMANT, ';
  strSQL := strSQL + '    IFNULL(T.DET_OUTDES, 0) AS DET_OUTDES, ';
  strSQL := strSQL + '    IFNULL(T.DET_VENDOR, 0) AS DET_VENDOR, ';
  strSQL := strSQL + '    IFNULL(T.DET_IMPULT, 0) AS DET_IMPULT, ';
  strSQL := strSQL + '    IFNULL(T.DET_VFCPST, 0) AS DET_VFCPST, ';
  strSQL := strSQL + '    IFNULL(V.ICD_PERFCP, 0) AS ICD_PERFCP, ';
  strSQL := strSQL + '    IFNULL(V.ICD_VALFCP, 0) AS ICD_VALFCP, ';
  strSQL := strSQL + '    T.DET_SEQGER AS SEQTRI,            ';
  strSQL := strSQL + '    T.DET_ALQFRE,                      ';

  strSQL := strSQL +  '   IFNULL(T.DET_ICMNCR, 0) AS DET_ICMNCR, ';
  strSQL := strSQL +  '   IFNULL(T.DET_FCPNCR, 0) AS DET_FCPNCR, ';

  strSQL := strSQL + '    D.DET_DTAENT, ';
  strSQL := strSQL + '    D.DET_HORENT  ';

  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + strTabela + ' D ';

  strSQL := strSQL + '  LEFT JOIN ' +  fRetNomTabMovTri(strTabela) + ' T ON D.AUTOINCREM = T.DET_SEQGER ';
  strSQL := strSQL + '  LEFT JOIN CADITE C ON C.ITE_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '  LEFT JOIN MOVICD V ON ICD_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    DET_CODITE = :CODITE AND ';
  If blnGlobal Then
    strSQL := strSQL + '    DET_CODEMP IN (' + strEmpMedEmp + ') AND '
  Else
    strSQL := strSQL + '    DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '    DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQL := strSQL + '    RIGHT(DET_CLAFIS,3) <> "929" AND ';
  If strTabela = 'NOTDET' Then
    strSQL := strSQL + '    LEFT(DET_CLAFIS, 1) <> "3" AND ';

  Case rdbEntFut.ItemIndex Of
    0:   strSQL := strSQL + '  (LOCATE(DET_CLAFIS, CONCAT(' + CLAFIS_ENTFUT_VEN +',' + CLAFIS_ENTFUT_ENT + ')) <= 0) AND ';
    1:   strSQL := strSQL + '  DET_CLAFIS NOT IN ("5922", "6922", "1922", "2922") AND ';
  End;
  strSQL := strSQL + '  (LOCATE(DET_CLAFIS, "' + fCfgSis('CLFSIV', varString) + '") = 0) AND ';

  strSQL := strSQL + '   ( DET_ESPDOC IN (' + strEspDoc + ') ';

  If Not fCfgSis('NESTIN', VarBoolean) Then
    strSQL := strSQL + '    OR (DET_ESPDOC = "ML" AND DET_TIPFAT IN (' + strEspDoc + ') )';

  strSQL := strSQL + ' ) ';

  Result := strSQL;
End;

Function TfrmGerInventario.fCarregaMovimentoItem(strCodIte: String; strCodEmp: String; Var fltPreMed, fltSalMov, fltPreUlt, fltImpUlt: Double; blnGlobal: Boolean; blnCalcMed: Boolean): Boolean;
  Var
    strSQL   : String;
    qryGenDet: TUniQuery;
    fltIcmMed: Double;
    strClaFisBonificacao: String;
begin
  Result := True;

  strSQL := fSQLMovDet('MOVDET', blnGlobal) + ' UNION ALL ' + fSQLMovDet('NOTDET', blnGlobal) ;

  strSQL := strSQL + ' ORDER BY DET_DTAENT, DET_HORENT ';

  qryGenDet := fCriaQuery(Nil);

  With qryGenDet, SQL Do
  Begin
    Clear;
    Add(strSQL);

    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    If Not blnGlobal Then
      ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODITE').AsString := strCodIte;

    Open;

    strClaFisBonificacao := fRetornarClassificacoesBonificacaoEntrada;

    While Not Eof Do
    Begin

      If FieldByName('DET_CLAFIS').AsString < '5000' Then
      Begin

        If blnCalcMed Then
        Begin

          If ((Pos(FieldByName('DET_CLAFIS').AsString, VS_strClaCom + '_1117_2117' + strClaFisBonificacao) > 0) And (Not (Pos(FieldByName('DET_CODFOR').AsString, strForFil) > 0))) Or
             (blnAtuMed And (Pos(FieldByName('DET_CODFOR').AsString, strForFil) > 0)) Then
          Begin
            fltPreUlt := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat) / FieldByName('DET_QTDITE').AsFloat;
            fltImpUlt := FieldByName('DET_IMPULT').AsFloat / FieldByName('DET_QTDITE').AsFloat;
          End;

          If (((Pos(FieldByName('DET_CLAFIS').AsString, VS_strClaCom + '_1117_2117' + strClaFisBonificacao) > 0) And (Not (Pos(FieldByName('DET_CODFOR').AsString, strForFil) > 0))) Or
              (blnAtuMed And (Pos(FieldByName('DET_CODFOR').AsString, strForFil) > 0))) And
             (SameText(FieldByName('DET_ESPDOC').AsString, 'NF') Or blnMedSe2) Then
          Begin
            Try

              If (Pos(FieldByName('DET_CODFOR').AsString, strForFil) <= 0) Then
                fltIcmMed := IIF((Pos(FieldByName('DET_CODFIS').AsString, CST_REDUCAO) > 0) ,
                                                  fFormataFloat((FieldByName('DET_ALQICM').AsFloat * FieldByName('DET_PERBAS').AsFloat) / 100, 2),
                                                   FieldByName('DET_ALQICM').AsFloat + FieldByName('ICD_PERFCP').AsFloat)
              Else
                fltIcmMed := 0;

              fltPreMed := fCalculaPrecoMedio(FieldByName('DET_CODFIS').AsString,        // Código Fiscal
                                              FieldByName('DET_CLAFIS').AsString,        // Classificação Fiscal
                                              fltPreMed,
                                              IIF( not chkInverter.Checked,
                                                   fltSalMov,
                                                   fltSalMov - FieldByName('DET_QTDITE').AsFloat), // Saldo anterior
                                              FieldByName('DET_QTDITE').AsFloat,         // Quantidade de entrada
                                              FieldByName('DET_UNITAR').AsFloat,         // Unitario sem impostos

                                              fltIcmMed, // Aliquota de ICMS do Item

                                              FieldByName('DET_VALIPI').AsFloat +
                                              FieldByName('DET_VAEIPI').AsFloat,           // Valor do IPI

                                              FieldByName('DET_VALRET').AsFloat +          // Valor de Substituição
                                              FieldByName('DET_VAERET').AsFloat,

                                              FieldByName('DET_ICMANT').AsFloat,           // Valor ICMS Antecipado

                                              FieldByName('DET_VLGNRE').AsFloat,
                                              FieldByName('DET_VALTCI').AsFloat,
                                              FieldByName('DET_VAL_TS').AsFloat,

                                              blnContribuinteIPI,                          // Contribuinte de IPI?
                                              (Pos(FieldByName('DET_CODFOR').AsString, strForFil) > 0), // Fornec Filial

                                              FieldByName('DET_INCPIS').AsString,          // Indice se incide Pis

                                              FieldByName('DET_TOTFRE').AsFloat +
                                              FieldByName('DET_CONFRE').AsFloat,

                                              FieldByName('DET_OUTDES').AsFloat +
                                              FieldByName('DET_VENDOR').AsFloat +
                                              FieldByName('DET_DESACE').AsFloat,

                                              FieldByName('DET_VALICM').AsFloat + FieldByName('ICD_VALFCP').AsFloat,

                                              IIF((FieldByName('DET_VALICM').AsFloat + FieldByName('ICD_VALFCP').AsFloat) > 0,
                                                  0,
                                                  FieldByName('DET_ICMNCR').AsFloat + FieldByName('DET_FCPNCR').AsFloat),

                                              FieldByName('DET_VFCPST').AsFloat,
                                              FieldByName('DET_ALQFRE').AsFloat,
                                              nil,
                                              FieldByName('DET_VAEIPI').AsFloat > 0);

            Except
              On E: Exception Do
              Begin
                pMensagemOk('Nota ' + FieldByName('DET_NUMDOC').AsString + '-' + FieldByName('DET_ESPDOC').AsString + '-' +
                            FieldByName('DET_CODEMP').AsString + ' com valores negativos! ' + E.Message);
                Result := False;
                Break;
              End;
            End;

          End;

        End;

        if Not chkInverter.Checked Then
          fltSalMov := fltSalMov + FieldByName('DET_QTDITE').AsFloat
        Else
          fltSalMov := fltSalMov - FieldByName('DET_QTDITE').AsFloat;

      End Else
      Begin
        if Not chkInverter.Checked Then
          fltSalMov := fltSalMov - FieldByName('DET_QTDITE').AsFloat
        Else
          fltSalMov := fltSalMov + FieldByName('DET_QTDITE').AsFloat;

      End;

      Next;
    End;

    FreeAndNil(qryGenDet);

  End;

end;

function TfrmGerInventario.fGerarArquivo(pgbProgressBar: TcxProgressBar): boolean;
Var
    strNovaTabela: String;
    strNomTabPrefixo: String;
begin
  inherited;
  Result := False;

  If (Not cdsTabelas.Locate('MARCAR', 'S', [])) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar um arquivo de inventário!', ['&Ok']);
    Exit;
  End;

  If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Or (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário preecher as datas inicial e final!', ['&Ok']);
    Exit;
  End;

  strNomTabBas := fRetNumMesSelec;
  If AnsiStartsText('SALINV', strNomTabBas) Then
    strNomTabPrefixo := 'SALINV'
  Else
    strNomTabPrefixo := 'SALINV' + Copy(strNomTabBas, 9, MaxInt);

  strNovaTabela := '';
  If (Not fValidaArqSelecionado(strNomTabPrefixo, strNovaTabela)) Then
    Exit;

  btnGravar.Enabled := False;

  //*************************************************//
  // STRING QUE ARMAZENA AS ESPECIES DE DOCUMENTOS   //
  // A SEREM PROCESSADOS                             //
  //**********************************************ED*//
  strEspDoc := '''NF'',''EL'',''D1'',''IF'',''NV'',''IV''';

  If chkOrdPro.Checked Then
    strEspDoc := strEspDoc + ', ' + QuotedStr('OP');

  If chkOrdInd.Checked Then
    strEspDoc := strEspDoc + ', ' + QuotedStr('OI');

  //*************************************************//
  // GERA A TABELA SALINV                            //
  //**********************************************ED*//
  pCriaTabela(strNovaTabela);

  pCriaIndices(strNovaTabela, 'ITE_CODITE');
  pCriaIndices(strNovaTabela, 'ITE_DESITE');
  pCriaIndices(strNovaTabela, 'ITE_CODEMP');

  //*************************************************//
  // CRIA OS INDICES NECESSARIOS                     //
  //**********************************************ED*//
  pCriaIndices(strNomTabBas, 'ITE_CODITE');


  blnSalMlBase := fCampoExiste('`'+strNomTabBas+'`', 'ITE_SAL_ML');
  // CFG_MEDEMP = '1': CALCULO DE PRECO MEDIO GLOBAL //
  // (SOMA DO ESTOQUE DE TODAS AS EMPRESAS).         //
  //**********************************************CIT*//
  strEmpMedEmp    := fEmpresasMedEmp;
  //*************************************************//
  //*************************************************//
  // PROCESSA OS ARQUIVOS CADITE, MOVDET, NOTDET     //
  //**********************************************ED*//
  If fProcessaArquivo(strNovaTabela, pgbProgressBar) Then
  Begin

    If chkSumNeg.Checked Then
      pSomaItens(strNovaTabela);
  End;

  btnGravar.Enabled := True;

  result := true;

end;

procedure TfrmGerInventario.btnCopiarClick(Sender: TObject);
  Var
    strArqSel: String;
    strNovoArq: String;
begin
  inherited;
  strArqSel := fRetNumMesSelec;

  If (Not fValidaArqSelecionado(strArqSel, strNovoArq)) Then
    Exit;

  If (fMensagem('ATENÇÃO!', 'Confirma copiar a tabela (-' + strArqSel + '-) com o nome (-' + strNovoArq + '-)?',
    ['&Sim', '&Não']) = 1) Then
  Begin
    Screen.Cursor := crHourGlass;
    pCopiarTabela(strArqSel, strNovoArq);
    Screen.Cursor := crDefault;

    pCarregaArqBase;
  End;
end;

procedure TfrmGerInventario.pCopiarTabela(strTabela,
  strNovaTabela: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('CREATE TABLE `' + strNovaTabela + '` SELECT * FROM `' + strTabela + '` WHERE TRUE ');
  qryAux.SQL.Add(fStrLocate(edtCodEmpresa, arrLinEmp, 'ITE_CODEMP', 'CODEMP'));
  pSetaParam(edtCodEmpresa.Text, arrLinEmp, strLinEmp, 'CODEMP', qryAux);

  qryAux.ExecSQL;

  pCriaIndices(strNovaTabela, 'ITE_CODITE');
  pCriaIndices(strNovaTabela, 'ITE_DESITE');
  pCriaIndices(strNovaTabela, 'ITE_CODEMP');

  FreeAndNil(qryAux);
end;

function TfrmGerInventario.fValidaArqSelecionado(strArqSel: String;
  Var strNovoArq: String): Boolean;

  function fValidaNomeArq(strNomArq : String):Boolean;
    Var intCorre : Integer;
  Begin
    Result := True;
    For intCorre := 1 To Length(strNomArq) Do
    Begin
      If (Not CharInSet(strNomArq[intCorre], ['A'..'Z', 'a'..'z', '0'..'9', '_' ])) Then
      Begin
        Result := False;
        Break;
      End;
    End;
  End;

begin
  Result     := False;
  strNovoArq := '';

  If fEmptyStr(strArqSel) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar um arquivo.', ['&Ok']);
    Exit;
  End;

  strNovoArq := strArqSel + '_';
  If (Not InputQuery('Novo arquivo', 'Digite o novo nome do arquivo', strNovoArq)) Then
  Begin
    Exit;
  End;

  If not fValidaNomeArq(strNovoArq) Then
  Begin
    fMensagem('ATENÇÃO!','Não é Permitido Espaço ou Caracteres Especiais no Nome do Arquivo!',['&Ok']);
    Exit;
  End;

  strNovoArq := AnsiUpperCase(strNovoArq);

  If (fEmptyStr(strNovoArq)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Digite um nome de arquivo válido.', ['Ok']);
    Exit;
  End;

  If (Not AnsiStartsStr(strArqSel, strNovoArq)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O nome do arquivo deve começar com ' + strArqSel, ['Ok']);
    Exit;
  End;

  If fTabelaExiste('`'+strNovoArq+'`') Then
  Begin
    fMensagem('ATENÇÃO!', 'Esta tabela já existe.', ['Ok']);
    Exit;
  End;

  Result := True;
end;

procedure TfrmGerInventario.pSomaItens(strNovaTabela : String);
  var
    qryUpdate : TUniQuery;
begin
  qryUpdate := fCriaQuery(Self);
  Try
    With qryUpdate, Sql Do
    Begin
      Clear;
      Add('INSERT INTO `'+ strNomTabBas + '` ( '          );
      Add('                                  AUTOINCREM, ');
      Add('                                  ITE_CODITE, ');
      Add('                                  ITE_CODEMP, ');
      Add('                                  ITE_CODABF, ');
      Add('                                  ITE_CODUNI, ');
      Add('                                  ITE_DESITE, ');
      Add('                                  ITE_REFERE, ');
      Add('                                  ITE_PRECOM, ');
      Add('                                  ITE_PRECUS, ');
      Add('                                  ITE_PREVE1, ');
      Add('                                  ITE_PREVE2, ');
      Add('                                  ITE_PREVE3, ');
      Add('                                  ITE_PREVE4, ');
      Add('                                  ITE_PREVE5, ');
      Add('                                  ITE_PREVE6, ');
      Add('                                  ITE_PREVE7, ');
      Add('                                  ITE_PREMED, ');
      Add('                                  ITE_PREULT, ');
      Add('                                  ITE_SALDOS, ');
      Add('                                  ITE_SAL_ML, ');
      Add('                                  ITE_SALBAL, ');
      Add('                                  ITE_IMPULT, ');
      Add('                                  ITE_CLAIPI, ');
      Add('                                  ITE_CODGRU, ');
      Add('                                  ITE_IMPLIS, ');
      Add('                                  ITE_ITEATI) ');
      Add('SELECT DESTINO.AUTOINCREM,                    ');
      Add('       DESTINO.ITE_CODITE,                    ');
      Add('       DESTINO.ITE_CODEMP,                    ');
      Add('       DESTINO.ITE_CODABF,                    ');
      Add('       DESTINO.ITE_CODUNI,                    ');
      Add('       DESTINO.ITE_DESITE,                    ');
      Add('       DESTINO.ITE_REFERE,                    ');
      Add('       DESTINO.ITE_PRECOM,                    ');
      Add('       DESTINO.ITE_PRECUS,                    ');
      Add('       DESTINO.ITE_PREVE1,                    ');
      Add('       DESTINO.ITE_PREVE2,                    ');
      Add('       DESTINO.ITE_PREVE3,                    ');
      Add('       DESTINO.ITE_PREVE4,                    ');
      Add('       DESTINO.ITE_PREVE5,                    ');
      Add('       DESTINO.ITE_PREVE6,                    ');
      Add('       DESTINO.ITE_PREVE7,                    ');
      Add('       DESTINO.ITE_PREMED,                    ');
      Add('       DESTINO.ITE_PREULT,                    ');
      Add('       DESTINO.ITE_SALDOS,                    ');
      Add('       DESTINO.ITE_SAL_ML,                    ');
      Add('       DESTINO.ITE_SALBAL,                    ');
      Add('       DESTINO.ITE_IMPULT,                    ');
      Add('       DESTINO.ITE_CLAIPI,                    ');
      Add('       DESTINO.ITE_CODGRU,                    ');
      Add('       DESTINO.ITE_IMPLIS,                    ');
      Add('       DESTINO.ITE_ITEATI                     ');
      Add('FROM `' + strNovaTabela + '` DESTINO          ');

      Add('  LEFT JOIN `' + strNomTabBas + '` ORIGEM       ');
      Add('  ON  ORIGEM.ITE_CODITE = DESTINO.ITE_CODITE  ');
      Add('  AND ORIGEM.ITE_CODEMP = DESTINO.ITE_CODEMP  ');

      Add('WHERE ORIGEM.ITE_CODITE IS NULL');
      Add('  AND DESTINO.ITE_SALDOS < 0                  ');
      Try
        ExecSQL;
      Except
        On E : Exception Do
        Begin
          pMensagensErro(e.Message, '[TfrmGerInventario.pSomaItens(strNovaTabela : String);]');
        End;
      End;


      Clear;
      Add('UPDATE `' + strNomTabBas + '` '                                     );
      Add(' INNER JOIN (                                                      ');
      Add('             SELECT ITE_CODITE AS CODITE,                          ');
      Add('                    ITE_CODEMP AS CODEMP,                          ');
      Add('                ABS(ITE_SALDOS) AS SALDOS                          ');
      Add('             FROM `' + strNovaTabela + '`                          ');
      Add('             WHERE ITE_SALDOS < 0                                  ');
      Add('           ) AS TMP ON CODITE = ITE_CODITE AND CODEMP = ITE_CODEMP ');
      Add('SET ITE_SALDOS = ITE_SALDOS + SALDOS                               ');

      Try
        ExecSQL;
      Except
        On E : Exception Do
        Begin
          pMensagensErro(e.Message, '[TfrmGerInventario.pSomaItens(strNovaTabela : String);]');
        End;
      End;
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;

end;

end.

