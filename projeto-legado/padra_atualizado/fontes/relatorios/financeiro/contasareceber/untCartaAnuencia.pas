{***************************}
{* qryConCli -> CADCLI     *}
{************************JB*}

unit untCartaAnuencia;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, Mask, Uni,
  MaskEditFocus, EditFocus, ComCtrls, Buttons, ExtCtrls, DB, Menus,
  AppEvnts, MemoFocus, UniClientDataSet, UniDataSetProvider, untFuncoesGenerica, StrUtils,
  BitBtnLockedIncrem, DBCtrls, DBLookupComboBoxFocus, MemDS, DBAccess, frxClass,
  frxExportCSVTestabilidade, Math, untClassPanelCx, CurrencyEditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, QColorLabel, untTypesSistema;

type
  TfrmCartaAnuencia = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    pnlAux2: TPanel;
    dbgDuplicatas: TDBGridCitel;
    pnlTotais: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtTotalDup: TEditFocus;
    edtTotalSelecionado: TEditFocus;
    pnlDadosDup: TPanel;
    pnlBotoesBaixa: TPanel;
    Label3: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Nome: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    edtCodCliBai: TEditFocus;
    edtNomCliBai: TEditFocus;
    edtNomPorBai: TEditFocus;
    edtCodPorBai: TEditFocus;
    edtNosNum: TEditFocus;
    edtHistor: TMemoFocus;
    chkExiPar: TCheckBox;
    rdgValDup: TRadioGroup;
    chkExiEsp: TCheckBox;
    btnConfirma: TBitBtnLocked;
    btnSairAgrup: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    Label9: TLabel;
    cbbModelo: TDBLookupComboBoxFocus;
    qryModelos: TUniQuery;
    dtsModelos: TDataSource;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnConsultar: TBitBtnLocked;
    Label11: TLabel;
    edtStatus: TEditFocus;
    ColorLabel1: TColorLabel;
    procedure btnSairAgrupClick(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);

    procedure dbgDuplicatasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDuplicatasDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgDuplicatasDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
  protected
    procedure pCriaTemporaria;
    procedure pCalculaTotalDuplicatas(edtValorTotal: TEditFocus; blnFiltrar: Boolean);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    { Private declarations }
    qryConCli: TUniQuery;
    cdsCtaRec: TUniClientDataSet;
    dtsCtaRec: TDataSource;
    arrDuplicata: TarrDuplicata;

    FPais: TPais;
    function fImprimeDuplicatas(var AErroAplicacaoAberta : Boolean) : Boolean;
    procedure pCarregaCliente;
    procedure pSelecionaDuplicata;
    procedure pMarcaDuplicata(blnMarcar: Boolean);
    procedure pLimpaDados;
    procedure pAtualizaDados(DataSet: TDataSet);

    function fGeraCartaAnuencia(ANomImp: String; var AErroAplicacaoAberta : Boolean): Boolean;
    function fRetornaPathModelo(strCodMod: String): String;
    function ProcessoEstaEmExecucao(const ANomeProcesso: String): Boolean;
    procedure ForcaFecharAplicacao;
  public
    { Public declarations }
  end;

implementation

uses untModulo, untCadConfRelatorios, untDtaEmissao, untPai,
     untWord, untIFuncoes,untFuncoesSimples,
     untConsultas, untFuncoes, untCfgRel, untValorPorExtenso,
     untFuncoesRelatorios, untFuncoesConsulta, untPesqAux;
{$R *.dfm}

procedure TfrmCartaAnuencia.btnSairAgrupClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCartaAnuencia.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmCadConfRelatorios,frmCadConfRelatorios);
    frmCadConfRelatorios.strNomeForm   := Self.Name;
    frmCadConfRelatorios.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCartaAnuencia.btnConfigurarClick]');
    End;
  End;

  pFreeAndNil(frmCadConfRelatorios);

  If cdsCtaRec.Active Then
    pSetFocus(dbgDuplicatas)
  Else
    pSetFocus(edtCodCli);
end;

procedure TfrmCartaAnuencia.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCartaAnuencia.fGeraCartaAnuencia(ANomImp: String; var AErroAplicacaoAberta : Boolean): Boolean;
  Var
    Word: TWord;
    strArqOri : String;
    strArqDes : String;
    strLogCit : String;
    strSQL    : String;
    qryEmp    : TUniQuery;
    qryAux    : TUniQuery;
    intRecNo  : Integer;
    intLinha  : Integer;
    intQtdLin : Integer;

    procedure pGeraCabDuplicatas;
    begin
      Word.pCriaTabela('{{DUPLIC}}', intQtdLin, 6);
      intLinha := 1;

      Word.pCelulaNegrito(intLinha, 1);
      Word.pCelulaEscreve(intLinha, 1, 'N. TÍTULO');
      Word.pCelulaNegrito(intLinha, 2);
      Word.pCelulaEscreve(intLinha, 2, 'NOSSO NÚMERO');
      Word.pCelulaNegrito(intLinha, 3);
      Word.pCelulaEscreve(intLinha, 3, 'EMISSÃO');
      Word.pCelulaNegrito(intLinha, 4);
      Word.pCelulaEscreve(intLinha, 4, 'EMPRESA');
      Word.pCelulaNegrito(intLinha, 5);
      Word.pCelulaAlignRight(intLinha, 5);
      Word.pCelulaEscreve(intLinha, 5, 'VENCIMENTO');
      Word.pCelulaNegrito(intLinha, 6);
      Word.pCelulaAlignRight(intLinha, 6);
      Word.pCelulaEscreve(intLinha, 6, 'VALOR');

      Inc(intLinha);
    end;

begin
  Result := false;
  Word := nil;
  qryEmp := nil;
  Try
    AErroAplicacaoAberta := False;

    If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'CARTAS DE ANUENCIA') Then
      CreateDir(ExtractFilePath(Application.ExeName) + 'CARTAS DE ANUENCIA');

    strArqOri := fRetornaPathModelo(cbbModelo.KeyValue);
    strArqOri := AnsiReplaceStr(strArqOri, '"', '');

    If FileExists(strArqOri) Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   EMP_NOMEMP, ';
      strSQL := strSQL + '   CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT(", ", EMP_ENDCMP))) AS EMP_ENDERE, ';
      strSQL := strSQL + '   IF(IFNULL(EMP_BAIRRO,"") = "", "", CONCAT(", ", EMP_BAIRRO)) AS EMP_BAIRRO, ';
      strSQL := strSQL + '   CONCAT(CID_NOMCID, "-" , CID_ESTADO) AS EMP_CIDADE, ';
      strSQL := strSQL + '   CID_NOMCID, ';
      strSQL := strSQL + '   EMP_C_G_C_, ';
      strSQL := strSQL + '   EMP_FONE01, ';
      strSQL := strSQL + '   EMP_I_E_S_, ';
      strSQL := strSQL + '   EMP_C_E_P_  ';
      strSQL := strSQL + ' FROM   ';
      strSQL := strSQL + '   CADEMP ';
      strSQL := strSQL + '   JOIN CADCID ON CID_CODCID = EMP_CODCID ';
      strSQL := strSQL + ' WHERE    ';
      strSQL := strSQL + '   EMP_CODEMP = "' + VS_strCodEmp +  '"  ';
      qryEmp := fCriaQuery(Self);
      With qryEmp, SQL Do
      Begin
        Clear;
        Add(strSQL);
        Open;
      End;

      Screen.Cursor := crHourGlass;
      Application.ProcessMessages;

      strArqDes := ExtractFilePath(Application.ExeName) + 'CARTAS DE ANUENCIA\CARTA_DE_ANUENCIA_' + FormatDateTime('yyyymmdd', Date) + '-' + cdsCtaRec.FieldByName('CTR_CODCLI').AsString + '.DOC';
      If FileExists(strArqDes) Then
        DeleteFile(strArqDes);

      If FileExists(strArqDes) Then
        strArqDes := ExtractFilePath(Application.ExeName) + 'CARTAS DE ANUENCIA\CARTA_DE_ANUENCIA_' + FormatDateTime('yyyymmdd', Date) + '-' + cdsCtaRec.FieldByName('CTR_CODCLI').AsString +'-'+FormatDateTime('hhnnss', fNow) + '.DOC';

      CopyFile(pChar(strArqOri), pChar(strArqDes), False);

      Word := TWord.fCriarWord(Self);

      If Word = Nil Then
        Exit;

      Try

        If Not Word.AbrirArquivo(strArqDes) Then
        Begin
          fMensagem('','Não foi possível abrir o arquivo!',['&OK']);
          Exit;
        End;

        {*************************************}
        {* VAI PARA O CABEÇALHO DO DOCUMENTO *}
        {**********************************JU*}
        Word.pGoToPageHeader;

        strLogCit := ExtractFilePath(Application.ExeName) + 'CITEL.BMP';

        Word.pInsereImagem(IfThen(FileExists(fCfgSis('PATLOG')), fCfgSis('PATLOG'), strLogCit));

        Word.pReplace('{{NOMEMP}}', qryEmp.FieldByName('EMP_NOMEMP').AsString);
        Word.pReplace('{{ENDEMP}}', qryEmp.FieldByName('EMP_ENDERE').AsString);
        Word.pReplace('{{CIDEMP}}', qryEmp.FieldByName('EMP_CIDADE').AsString);
        Word.pReplace('{{FONEMP}}', fFormataFone(qryEmp.FieldByName('EMP_FONE01').AsString));
        Word.pReplace('{{BAIEMP}}', qryEmp.FieldByName('EMP_BAIRRO').AsString);
        Word.pReplace('{{CGCEMP}}', fFormataCpfCgc(qryEmp.FieldByName('EMP_C_G_C_').AsString, FPais));
        Word.pReplace('{{IESEMP}}', qryEmp.FieldByName('EMP_I_E_S_').AsString);

        {*************************************}
        {* VAI PARA O CORPO DO DOCUMENTO     *}
        {**********************************JU*}
        Word.pGoToMainDocument;

        {*************************************}
        {* SUBSTITUI OS TEXTOS DO CORPO      *}
        {**********************************JU*}
        Word.pReplace('{{NOMEMP}}', qryEmp.FieldByName('EMP_NOMEMP').AsString);
        Word.pReplace('{{ENDEMP}}', qryEmp.FieldByName('EMP_ENDERE').AsString);
        Word.pReplace('{{CIDEMP}}', qryEmp.FieldByName('EMP_CIDADE').AsString);
        Word.pReplace('{{BAIEMP}}', qryEmp.FieldByName('EMP_BAIRRO').AsString);
        Word.pReplace('{{CGCEMP}}', fFormataCpfCgc(qryEmp.FieldByName('EMP_C_G_C_').AsString, FPais));

        Word.pReplace('{{NOMCLI}}', cdsCtaRec.FieldByName('CLI_NOMCLI').AsString);
        Word.pReplace('{{ENDCLI}}', cdsCtaRec.FieldByName('CLI_ENDERE').AsString);
        Word.pReplace('{{CIDCLI}}', cdsCtaRec.FieldByName('CLI_CIDADE').AsString);
        Word.pReplace('{{CEPCLI}}', fFormataCEP(cdsCtaRec.FieldByName('CLI_C_E_P_').AsString));
        Word.pReplace('{{BAICLI}}', cdsCtaRec.FieldByName('CLI_BAIRRO').AsString);
        Word.pReplace('{{CGCCLI}}', fFormataCpfCgc(cdsCtaRec.FieldByName('CLI_C_G_C_').AsString, FPais));
        Word.pReplace('{{FONCLI}}', fFormataFone(cdsCtaRec.FieldByName('CLI_FONE01').AsString));

        {*************************************}
        {* CRIA UMA TABELA COM AS DUPLICATAS *}
        {**********************************JU*}

        intRecNo := cdsCtaRec.RecNo;
        cdsCtaRec.DisableControls;
        cdsCtaRec.Filtered := False;
        cdsCtaRec.Filter   := 'CTR_MARDES = ''M''';
        cdsCtaRec.Filtered := True;

        intQtdLin := cdsCtaRec.RecordCount + 1;

        pGeraCabDuplicatas;

        cdsCtaRec.First;
        While Not cdsCtaRec.Eof Do
        Begin
          Word.pCelulaEscreve(intLinha, 1, cdsCtaRec.FieldByName('NRODUP').AsString +
                              IfThen(chkExiPar.Checked, cdsCtaRec.FieldByName('PARDUP').AsString, '') +
                              IfThen(chkExiEsp.Checked, '-' + cdsCtaRec.FieldByName('CTR_ESPDOC').AsString, ''));
          Word.pCelulaEscreve(intLinha, 2,cdsCtaRec.FieldByName('CTR_NOSNUM').AsString);
          Word.pCelulaEscreve(intLinha, 3, FormatDateTime('dd/mm/yyyy', cdsCtaRec.FieldByName('CTR_DTACAD').AsDateTime));
          Word.pCelulaEscreve(intLinha, 4, cdsCtaRec.FieldByName('CTR_CODEMP').AsString);
          Word.pCelulaAlignRight(intLinha, 5);
          Word.pCelulaEscreve(intLinha, 5, FormatDateTime('dd/mm/yyyy', cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime));
          Word.pCelulaAlignRight(intLinha, 6);
          Word.pCelulaEscreve(intLinha, 6, FormatFloat(',0.00', cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat));
          cdsCtaRec.Next;
          Inc(intLinha);
        End;

        cdsCtaRec.Filtered := False;
        cdsCtaRec.EnableControls;
        cdsCtaRec.RecNo := intRecNo;

        {*********************}
        {* VAI PARA O RODAPE *}
        {******************JU*}
        Word.pGoToPageFooter;

        Word.pReplace('{{NOMCID}}', fRetDataExtenso(VS_Date,True));
        Word.pReplace('{{NOMEMP}}', qryEmp.FieldByName('EMP_NOMEMP').AsString);

        qryAux := fCriaQuery(Self);
        qryAux.SQL.Add('SELECT * FROM CADSOC WHERE SOC_CODEMP = :CODEMP');
        qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryAux.Open;

        Word.pReplace('{{NOMRES}}', qryAux.FieldByName('SOC_NOMSOC').AsString);
        Word.pReplace('{{RG_RES}}', 'RG: ' + qryAux.FieldByName('SOC_NUMR_G').AsString);
        Word.pReplace('{{CGCRES}}', IfThen(Length(fTiraCaracEspeciaisPonto(qryAux.FieldByName('SOC_NUMCPF').AsString)) > 11, 'CNPJ: ', 'CPF: ') +
                                    fFormataCpfCgc(qryAux.FieldByName('SOC_NUMCPF').AsString, FPais));

        FreeAndNil(qryAux);

        Word.pSalvar;
      Finally
        Word.pFechar;
        FreeAndNil(Word);
        if assigned(qryEmp) then
          FreeAndNil(qryEmp);
        Screen.Cursor := crDefault;
        Application.ProcessMessages;
      End;

      If Not TCfgRel.VS_TSPlus Then
        pExecArquivo(strArqDes, Handle)
      Else
        fMensagem('Sucesso!', 'Carta de Anuência gerada na pasta: ' + ExtractFilePath(Application.ExeName) + 'Cartas de Anuencia', ['&O k']);

      Result := True;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Modelo de Carta não encontrado!', ['&O k']);
      Result := False;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      Screen.Cursor := crDefault;

      If Assigned(Word) Then
      begin
        Word.pFechar;
        FreeAndNil(Word);
      End;

      if assigned(qryEmp) then
        FreeAndNil(qryEmp);

      AErroAplicacaoAberta := Pos('NoSuchElementException', E.Message) > 0;
      If AErroAplicacaoAberta Then
        pGravarErro(True, '[fGeraCartaAnuencia] LibreOffice NoSuchElementException: ' + E.Message, '')
      Else
        pMensagensErro(E.Message, '[fGeraCartaAnuencia]');
    End;
  End;
end;

procedure TfrmCartaAnuencia.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli (*frmModuloCadCli.qryCadCli*), qryConCli, edtCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmCartaAnuencia.dbgDuplicatasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  {*****************************************}
  {* MARCA / DESMARCA CHEQUE               *}
  {**************************************MV*}
  If (Key = VK_Return) Then
  Begin
    pSelecionaDuplicata;
    pSetFocus(Self);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(edtCodCli);
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End
end;

procedure TfrmCartaAnuencia.dbgDuplicatasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If Not cdsCtaRec.IsEmpty Then
  Begin
    If cdsCtaRec.FieldByName('CTR_MARDES').AsString = 'M' Then
    Begin
      If (State = [gdSelected]) And (dbgDuplicatas.Focused) Then
        dbgDuplicatas.Canvas.Font.Color := clLime
      Else
        dbgDuplicatas.Canvas.Font.Color := clBlue;
    End;
  End;
  dbgDuplicatas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCartaAnuencia.dbgDuplicatasDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDuplicata;
  pSetFocus(Self);
end;

procedure TfrmCartaAnuencia.pSelecionaDuplicata;
begin
  If Not cdsCtaRec.IsEmpty Then
  Begin
    pMarcaDuplicata(cdsCtaRec.FieldByName('CTR_MARDES').AsString <> 'M');
    pCalculaTotalDuplicatas(edtTotalSelecionado, True);
  End;
end;

procedure TfrmCartaAnuencia.pLimpaDados;
begin
  edtCodCliBai.Clear;
  edtNomCliBai.Clear;
  edtCodPorBai.Clear;
  edtNomPorBai.Clear;
  edtNosNum.Clear;
  edtHistor.Clear;

  edtTotalDup.Clear;
  edtTotalSelecionado.Clear;

  edtCodCli.Clear;
  edtNomCli.Clear;
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

  cdsCtaRec.Close;
end;

procedure TfrmCartaAnuencia.pMarcaDuplicata(blnMarcar: Boolean);
begin
  With cdsCtaRec Do
  Begin
    Edit;
    FieldByName('CTR_MARDES').AsString := IfThen(blnMarcar, 'M', 'D');
    Post;
  End;
end;

procedure TfrmCartaAnuencia.pCalculaTotalDuplicatas(edtValorTotal: TEditFocus; blnFiltrar: Boolean);
  Var
    cdsGen: TUniClientDataSet;
    fldTot: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  //fldTot := fCriaAggregateField(cdsGen, 'FLDTOT', 'SUM(CTR_VALDUP)', '#,##0.00');

  fldTot :=  TAggregateField.Create(cdsGen);
  With fldTot Do
  Begin
    FieldName := 'FLDTOT';
    DataSet := cdsGen;
    Expression := 'SUM(CTR_VALDUP)';
    DisplayFormat := '#,##0.00';
    Active := True;
  End;

  With cdsGen Do
  Begin
    Data := cdsCtaRec.Data;
    If blnFiltrar Then
    Begin
      Filtered := False;
      Filter := 'CTR_MARDES = ''M''';
      Filtered := True;
    End;

    AggregatesActive := True;
    If fldTot.Value = Null Then
      edtValorTotal.Text := FormatFloat('#,##0.00', 0)
    Else
      edtValorTotal.Text := FormatFloat('#,##0.00', fldTot.Value);
  End;

  FreeAndNil(cdsGen);
end;

procedure TfrmCartaAnuencia.pCriaTemporaria;
  Var
    strSQL: String;
    qryCtaRec: TUniQuery;
    dspCtaRec: TUniDataSetProvider;
begin
  Try
    cdsCtaRec.Close;
    qryCtaRec := fCriaQuery(Self);
    dspCtaRec := TUniDataSetProvider.Create(Self);
    dspCtaRec.DataSet := qryCtaRec;
    cdsCtaRec.SetProvider(dspCtaRec);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CTR_NUMDUP AS NRODUP, ';
    strSQL := strSQL + '  CTR_PARCEL AS PARDUP, ';
    strSQL := strSQL + '  R.CTR_CODVEL AS CTR_CODVEL, ';
    strSQL := strSQL + '  CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL, "-", R.CTR_ESPDOC) AS CTR_NUMDUP, ';
    strSQL := strSQL + '  R.CTR_ESPDOC AS CTR_ESPDOC, ';
    strSQL := strSQL + '  R.CTR_SEQBAI AS CTR_SEQBAI, ';
    strSQL := strSQL + '  R.CTR_DTAVEN AS CTR_DTAVEN, ';
    strSQL := strSQL + '  R.CTR_DTACAD AS CTR_DTACAD, ';
    strSQL := strSQL + '  C.CLI_FONE01 AS CLI_FONE01, ';

    {*************************************************}
    {* SE FOR VALOR PARCIAL MOSTRA O VALOR EM ABERTO *}
    {* SENÃO MOSTRA O VALOR TOTAL DA DUPLICATA.      *}
    {**********************************************PZ*}
    If (rdgValDup.ItemIndex = 0) Then
      strSQL := strSQL + ' R.CTR_VALDUP AS CTR_VALDUP, '
    Else
      strSQL := strSQL + ' R.CTR_VALORI AS CTR_VALDUP, ';

    strSQL := strSQL + '  R.CTR_CODCLI AS CTR_CODCLI, ';
    strSQL := strSQL + '  C.CLI_NOMCLI AS CLI_NOMCLI, ';

    strSQL := strSQL + '  C.CLI_CGCCPF AS CLI_CGCCPF, ';
    strSQL := strSQL + '  C.CLI_C_G_C_ AS CLI_C_G_C_, ';

    strSQL := strSQL + '  CONCAT(C.CLI_ENDERE, ", ", IFNULL(C.CLI_ENDNUM, ""), IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM))) AS CLI_ENDERE, ';

    strSQL := strSQL + '  C.CLI_BAIRRO AS CLI_BAIRRO, ';
    strSQL := strSQL + '  C.CLI_C_E_P_ AS CLI_C_E_P_, ';
    strSQL := strSQL + '  CONCAT(D.CID_NOMCID,"-",D.CID_ESTADO) AS CLI_CIDADE, ';

    strSQL := strSQL + '  CONCAT(R.CTR_CODEMP,"-",E.EMP_NOMEMP) AS CTR_CODEMP, ';
    strSQL := strSQL + '  C.CLI_CODREP AS CTR_CODREP, ';
    strSQL := strSQL + '  R.CTR_CODVEN AS CTR_CODVEN, ';
    strSQL := strSQL + '  R.CTR_CODPOR AS CTR_CODPOR, ';
    strSQL := strSQL + '  P.POR_NOMPOR AS POR_NOMPOR, ';
    strSQL := strSQL + '  R.CTR_DESCOB AS CTR_DESCOB, ';
    strSQL := strSQL + '  R.CTR_DESCON AS CTR_DESCON, ';
    strSQL := strSQL + '  R.CTR_NOSNUM AS CTR_NOSNUM, ';
    strSQL := strSQL + '  R.CTR_HIST01 AS CTR_HIST01, ';
    strSQL := strSQL + '  R.CTR_HIST02 AS CTR_HIST02, ';
    strSQL := strSQL + '  A.EMP_NOMEMP AS NOMEMP,     ';
    strSQL := strSQL + '  CONCAT(A.EMP_ENDERE, ", ", A.EMP_ENDNUM,         ';
    strSQL := strSQL + '         IF(IFNULL(A.EMP_ENDCMP, "") = "", "",     ';
    strSQL := strSQL + '         CONCAT("  ", A.EMP_ENDCMP))) AS ENDERE,   ';
    strSQL := strSQL + '  CONCAT(B.CID_NOMCID,"-",B.CID_ESTADO) AS CIDADE, ';
    strSQL := strSQL + '  A.EMP_BAIRRO AS BAIRRO,     ';
    strSQL := strSQL + '  A.EMP_C_G_C_ AS CGC,        ';
    strSQL := strSQL + '  A.EMP_I_E_S_ AS IES,        ';
    strSQL := strSQL + '  " " AS CTR_MARDES           ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC R ';
    strSQL := strSQL + '  JOIN CADCLI C ON R.CTR_CODCLI = C.CLI_CODCLI ';
    strSQL := strSQL + '  JOIN CADCID D ON C.CLI_CODCID = D.CID_CODCID ';
    strSQL := strSQL + '  JOIN CADEMP E ON R.CTR_CODEMP = E.EMP_CODEMP ';

    strSQL := strSQL + '  JOIN CADEMP A ON A.EMP_CODEMP = "' + VS_strCodEmp + '" ';
    strSQL := strSQL + '  JOIN CADCID B ON A.EMP_CODCID = B.CID_CODCID ';

    strSQL := strSQL + 'LEFT JOIN CADPOR P ON R.CTR_CODPOR = P.POR_CODPOR ';
    strSQL := strSQL + 'WHERE ';

    {*********************************************************}
    {* MOSTRA SOMENTE AS DUPLICATAS COM VALOR MAIOR QUE ZERO *}
    {******************************************************RV*}
    If (rdgValDup.ItemIndex = 0) Then
    Begin
      strSQL := strSQL + '  R.CTR_SEQBAI = 0 ';
      strSQL := strSQL + ' AND R.CTR_VALDUP > 0 '
    End
    Else
      strSQL := strSQL + ' R.CTR_VALORI > 0 ';

    If Not fEmptyStr(edtCodCli.Text) Then
      strSQL := strSQL + '  AND R.CTR_CODCLI = :CODCLI ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + '  AND R.CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

    If edtStatus.Text = 'A' Then
      strSQL := strSQL + '  AND R.CTR_DTAREC IS NULL  '
    Else If edtStatus.Text = 'B' Then
      strSQL := strSQL + '  AND R.CTR_DTAREC IS NOT NULL  ';

    With qryCtaRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(edtCodCli.Text) Then
        ParamByName('CODCLI').AsString := edtCodCli.Text;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
      End;
      Open;

      If Not IsEmpty Then
      Begin
        pSetaClient(qryCtaRec);
        With cdsCtaRec Do
        Begin
          Open;
          TFloatField(FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';
          IndexFieldNames := 'CTR_CODCLI;CTR_NUMDUP;CTR_CODEMP';
          First;
        End;
      End Else
      Begin
        fMensagem('ATENÇÃO!', 'Não há duplicatas para gerar a carta!', ['&O k']);
        pSetFocus(edtCodCli);
      End;

      Close;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCartaAnuencia.pCriaTemporaria]');
  End;

  cdsCtaRec.SetProvider(nil);
  FreeAndNil(dspCtaRec);
  FreeAndNil(qryCtaRec);
end;

procedure TfrmCartaAnuencia.ForcaFecharAplicacao;
begin
  If ProcessoEstaEmExecucao('soffice.bin') Then
  Begin
    KillProcess('soffice.bin');
  End;
end;

procedure TfrmCartaAnuencia.pAtualizaDados(DataSet: TDataSet);
begin
  edtCodCliBai.Text := DataSet.FieldByName('CTR_CODCLI').AsString;
  edtNomCliBai.Text := DataSet.FieldByName('CLI_NOMCLI').AsString;
  edtCodPorBai.Text := DataSet.FieldByName('CTR_CODPOR').AsString;
  edtNomPorBai.Text := DataSet.FieldByName('POR_NOMPOR').AsString;
  edtNosNum.Text    := DataSet.FieldByName('CTR_NOSNUM').AsString;
  edtHistor.Text    := DataSet.FieldByName('CTR_HIST01').AsString;
end;

procedure TfrmCartaAnuencia.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCli);
end;

procedure TfrmCartaAnuencia.FormCreate(Sender: TObject);
begin
  inherited;
  FPais := fSetaPais;
  
  qryConCli := fCriaQuery(Self);
  pZeraDigDuplic(arrDuplicata);

  cdsCtaRec := TUniClientDataSet.Create(Self);
  cdsCtaRec.AfterScroll := pAtualizaDados;
  dtsCtaRec := fCriaDataSource(cdsCtaRec);
  dbgDuplicatas.DataSource := dtsCtaRec;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

  qryModelos.Connection := frmModulo.GetCurrentConnection;
end;

function TfrmCartaAnuencia.fRetornaPathModelo(strCodMod: String): String;
  Var
    qryAux: TUniQuery;
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT       ';
  strSQL := strSQL + '  ANU_PATANU ';
  strSQL := strSQL + 'FROM         ';
  strSQL := strSQL + '  CARANU     ';
  strSQL := strSQL + 'WHERE        ';
  strSQL := strSQL + '  ANU_CODANU = :CODMOD AND ';
  strSQL := strSQL + '  ANU_CODEMP = :CODEMP     ';
  qryAux := fCriaQuery(Self);
  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODMOD').AsString := strCodMod;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    If Not IsEmpty Then
      Result := FieldByName('ANU_PATANU').AsString
    Else
      Result := '';
  End;

  FreeAndNil(qryAux);
end;

function TfrmCartaAnuencia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('AVISO','Esse Cliente não está cadastrado!',['&O K']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('AVISO','O Código do Cliente deve ser preenchido!',['&O K']);
        Result := False;
      End;

    End
    Else
    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End

        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
            fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
            Result := False;
        End
        Else If fEmptyStr(edtCodCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O código do cliente deve ser preenchido!', ['&O k']);
          blnMudarFoco := False;
          pSetFocus(edtCodCli);
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser digitada!', ['&Ok']);
        blnMudarFoco := False;
        pSetFocus(mskDtaIni);
      End;
    End

    Else If (Sender = cbbModelo) Then
    Begin
      If fEmptyStr(cbbModelo.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Selecione um Modelo de Carta!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtStatus) Then
    Begin
      If fEmptyStr(edtStatus.Text) Or (Pos(edtStatus.Text, 'ABT') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Status deve ser preenchido com T, A ou B!',['&O K']);
        Result := False;
      End
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCartaAnuencia.ProcessoEstaEmExecucao(const ANomeProcesso: String): Boolean;
begin
  If fEmptyStr(ANomeProcesso) Then
    Exit(False);

  Result := fProcessExists(ANomeProcesso);
end;

procedure TfrmCartaAnuencia.btnConfirmaClick(Sender: TObject);
var
  LErroAplicacaoAberta : Boolean;
begin
  inherited;
  LErroAplicacaoAberta := False;

  If fEmptyStr(cbbModelo.Text) Then
  Begin
    fMensagem('','Você deve selecionar um modelo de carta!', ['&OK']);
    pSetFocus(cbbModelo);
    Exit;
  End;
  
  If Not fImprimeDuplicatas(LErroAplicacaoAberta) Then
  Begin
    If LErroAplicacaoAberta Then
    Begin
      If fMensagem('ATENÇÃO!', 'Falha intermitente do LibreOffice detectada. '+
                               'Deseja finalizar TODAS as instâncias do LibreOffice e tentar novamente? '+
                               'Arquivos abertos sem salvar serão perdidos.',
                               ['&Sim', '&Não']) = 1 Then
      Begin
        ForcaFecharAplicacao;
        If Not fImprimeDuplicatas(LErroAplicacaoAberta) Then
          fMensagem('', 'Não foi possível gerar a carta após nova tentativa. '+
                        'Reinicie sua sessão e tente novamente.', ['&Ok']);
      End;
    End;
  End;
end;

procedure TfrmCartaAnuencia.btnConsultarClick(Sender: TObject);
begin
  inherited;
  if fVerificaCampos then
  begin
    pCriaTemporaria;
    pCalculaTotalDuplicatas(edtTotalDup, False);
    pCalculaTotalDuplicatas(edtTotalSelecionado, True);

    if (cdsCtaRec.Active) and (cdsCtaRec.RecordCount > 0) then
    begin
      pSetFocus(dbgDuplicatas);
    end;
  end;
end;

function TfrmCartaAnuencia.fImprimeDuplicatas(var AErroAplicacaoAberta : Boolean) : Boolean;
  Var
    blnConfirma : Boolean;
    strMensagem : String;
    cdsRelCtr   : TUniClientDataSet;
begin
  Result := False;
  AErroAplicacaoAberta := False;
  cdsRelCtr := nil;

  If (fEmptyStr(edtTotalSelecionado.Text)) Or (fStrToFloat(edtTotalSelecionado.Text) <= 0) Then
    Exit;

  pCriarFormularios(TfrmDtaEmi, frmDtaEmi);
  try
    try
      frmDtaEmi.ShowModal;
      blnConfirma := frmDtaEmi.blnConfirma;

      If blnConfirma Then
      Begin
        Screen.Cursor := crDefault;
        If fMensagem('', 'Imprime Carta?', ['&Sim', '&Não'])= 1 Then
        Begin
          cdsRelCtr := TUniClientDataSet.Create(Self);
          try
            cdsRelCtr.Data := cdsCtaRec.Data;
            cdsRelCtr.Filtered := False;
            cdsRelCtr.Filter := 'CTR_MARDES = ''M''';
            cdsRelCtr.Filtered := True;

            If Not cdsRelCtr.IsEmpty Then
            Begin
              strMensagem := '            A ' +
                             cdsRelCtr.FieldByName('NOMEMP').AsString +
                             ' empresa com sede a ' +
                             cdsRelCtr.FieldByName('ENDERE').AsString +
                             ' - Bairro ' +
                             cdsRelCtr.FieldByName('BAIRRO').AsString +
                             ', ' +
                             cdsRelCtr.FieldByName('CIDADE').AsString +
                             ' inscrita sob o C.N.P.J ' +
                             fFormataCpfCgc(cdsRelCtr.FieldByName('CGC').AsString, FPais) +
                             ' declara para os devidos fins que nada tem que opor ao ' +
                             'cancelamento do protesto do(s) titulo(s) abaixo descrito(s), ' +
                             'tendo em vista a quitacao do(s) mesmo(s), sacado(s) contra a empresa, ' +
                             'entretanto, fica entendido que todas as custas de cartorio, devem ser ' +
                             'pagas pela devedora: ';

              Result := fGeraCartaAnuencia('', AErroAplicacaoAberta);
            End;

          finally
            If Assigned(cdsRelCtr) Then
              FreeAndNil(cdsRelCtr);
          end;

        End;

      End;

    except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[frmCartaAnuencia.pImprimeDuplicatas]');
      End;
    end;
  finally
    pFreeAndNil(frmDtaEmi);
    If Assigned(cdsRelCtr) Then
      FreeAndNil(cdsRelCtr);

    pSetFocus(edtCodCli);
  end;
end;

procedure TfrmCartaAnuencia.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And ((ActiveControl) is TRadioButton) Then
    SelectNext(ActiveControl,True,True);
end;

procedure TfrmCartaAnuencia.FormShow(Sender: TObject);
begin
  inherited;
  qryModelos.Close;
  qryModelos.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryModelos.Open;
end;

end.

