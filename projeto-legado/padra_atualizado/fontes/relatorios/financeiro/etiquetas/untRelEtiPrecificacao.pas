unit untRelEtiPrecificacao;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, StrUtils, EditFocus, Menus, untfuncoesSimples,
  untTypesSistema, TypesRel, untFuncoesEtiquetas, Printers, frxClass,
  frxDBSet, MaskUtils, frxBarcode, Uni, AppEvnts,
  DB, UniClientDataSet, UniDataSetProvider, QColorLabel, untFuncoesRel,
  untFuncoesGenerica, DateUtils, BitBtnLockedIncrem, frxExportCSVTestabilidade,
  Datasnap.DBClient, ComboBoxFocus, Vcl.Mask, MaskEditFocus;

type
  TfrmRelEtiPrecificacao = class(TfrmPaiSimples)
    dbgEtiquetas: TDBGridCitel;
    pnlBotoesImp: TPanel;
    frxDBImpEti: TfrxDBDataset;
    frxPagina: TfrxReport;
    frxEtiqItensCodBarra: TfrxReport;
    CodigoBarra: TfrxBarCodeObject;
    frxEtiqItensZebra: TfrxReport;
    frxUserDataSet1: TfrxUserDataSet;
    pnlCabecalho: TPanel;
    frxReport1: TfrxReport;
    frxReport2: TfrxReport;
    btnSairImp: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    lbl3: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    lbl5: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    lbl6: TLabel;
    edtRefere: TEditFocus;
    lbl2: TLabel;
    edtCodFor: TEditFocus;
    lbl9: TLabel;
    edtDescri: TEditFocus;
    lblLocFis: TLabel;
    edtLocFis: TEditFocus;
    lbl1: TLabel;
    edtNomFor: TEditFocus;
    rdgStatus: TRadioGroup;
    lbl10: TLabel;
    lblDescon: TColorLabel;
    lblSimDes: TColorLabel;
    lblAcresc: TColorLabel;
    lblSimAcr: TColorLabel;
    pnl1: TPanel;
    shpMultSel: TShape;
    cmbPreVis: TComboBoxFocus;
    cmbPrePra: TComboBoxFocus;
    lblQtdPar: TLabel;
    edtQtdPar: TEditFocus;
    lblQtdEtq: TLabel;
    edtQtdEtq: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnLimFil: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    lblTotEti: TLabel;
    edtTotEti: TEditFocus;
    edtPerAcr: TEditFocus;
    edtPerDes: TEditFocus;
    cdsImpEti: TUniClientDataSet;
    cdsImpEtiNOME: TStringField;
    cdsImpEtiENDERE: TStringField;
    cdsImpEtiBAIRRO: TStringField;
    cdsImpEtiC_E_P_: TStringField;
    cdsImpEtiNOMCID: TStringField;
    cdsImpEtiENDNUM: TStringField;
    cdsImpEtiENDCOM: TStringField;
    cdsImpEtiIte: TUniClientDataSet;
    cdsImpEtiIteNOMEMP: TStringField;
    cdsImpEtiIteDESITE: TStringField;
    cdsImpEtiIteQTDETI: TIntegerField;
    cdsImpEtiIteVALITE: TFloatField;
    cdsImpEtiIteCODBAR: TStringField;
    cdsImpEtiIteREFERE: TStringField;
    cdsImpEtiIteSIGUNI: TStringField;
    cdsImpEtiIteCODFAB: TStringField;
    cdsImpEtiIteCODITE: TStringField;
    cdsImpEtiIteLOCFIS: TStringField;
    cdsImpEtiIteCODEMP: TStringField;
    cdsImpEtiIteVALVIS: TFloatField;
    cdsImpEtiIteCODIGO: TStringField;
    cdsImpEtiIteDESMAR: TStringField;
    cdsImpEtiIteCODAMZ: TStringField;
    cdsArmaze: TUniClientDataSet;
    cdsArmazeCODITE: TStringField;
    cdsArmazeCODAMZ: TStringField;
    cdsCodBar: TUniClientDataSet;
    cdsCodBarCODITE: TStringField;
    cdsCodBarCODBAR: TStringField;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtSerie: TEditFocus;
    edtCodForDoc: TEditFocus;
    edtNomForDoc: TEditFocus;
    lbl7: TLabel;
    edtCodBarra: TEditFocus;
    RadTipoAlteracao: TRadioGroup;
    lbl4: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    rdgSaldo: TRadioGroup;
    cbxLocFisicaPrincipal: TCheckBox;
    cbxLocFisicaLote: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnSairImpClick(Sender: TObject);
    procedure dbgEtiquetasDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    function fRetQtdSel: Integer;
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnLimFilClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodBarraKeyPress(Sender: TObject; var Key: Char);
    procedure RadTipoAlteracaoClick(Sender: TObject);
  private
    { Private declarations }
    qryEtique: TUniQuery;
    qryImpEti: TUniQuery;
    dtsImpEti: TDataSource;
    updImpEti: TUniUpdateSQL;
    blnUsaArm: Boolean;
    blnCadLoc: Boolean;

    arrLinGru : TConsultasArray;
    arrItem   : TConsultasArray;
    arrMarca  : TConsultasArray;
    arrFornec : TConsultasArray;
    arrCodBar : TConsultasArray;

    strLinGru,
    strMarca,
    strProduto,
    strCodBar,
    strFornec: String;

    FPais: TPais;

    {*****************************************}
    {* VARIAVEIS RELATIVAS ÀS BUSCAS         *}
    {**************************************MV*}
    intIndBusca: Integer;

    {*****************************************}
    {* MATRIZ QUE REPRESENTARÁ 1 LINHA DE    *}
    {* ETIQUETAS. Ex: EM UMA IMPRESSÃO DE 2  *}
    {* COLUNAS, A MATRIZ CONTERÁ 2 ETIQUETAS *}
    {**************************************MV*}
    arrLinhasEti: Array Of String;
    strTipEti: String;
    strCamQtd: String;
    strAmzEti: String;
    intColAtu: Integer;
    strNomImp, strNomPro, strDesPro: String;
    cpuCampos: TCamposUso;

    //Usada para impressao de etiquetas(itens) matricial.
    FPreco: Integer;
    FDecimais: Integer;
    FValor: Double;
    FInfAdi: String;
    FPrePra: Integer;

    strValDes: String;
    strValAcr: String;

    strCfgTipEti: String;
    strEtiPrp : String;

    blnImpPre: Boolean;
    blnETQLOC: Boolean;
    //*************************************************//
    // PROCEDURES DA UNIT                              //
    //**********************************************ED*//

    procedure pCarregaTabelaPrecosVista;
    procedure pCarregaTabelaPrecosPrazo;

    procedure pAbreItens;
    procedure pSetParamsItens(qryMarca: TUniQuery);
    procedure pLimparFiltros;

    procedure pImpEtiquetasMatricial;
    procedure pImpRegistro;
    procedure pImpArrLinhasEti;
    procedure pEscolheTabelaPreco;
    procedure pEscolheTabelaPrecoPrazo;

    procedure pConsulta(blnManter: Boolean = False);
    procedure pHabilitaLocFis(blnHabili: Boolean);

    //*************************************************//
    // FUNCOES DA UNIT                                 //
    //**********************************************ED*//

    function fImprimeLaserArgox: Boolean;

    function fRetornaSQLIte: String;
    function fGetFiltrosItens(blnIteEti: boolean = False): String;
    function fMarca(strSQl: String; blnDesmarcar: Boolean = False): Boolean;
    function fDesmarcar: boolean;
    function fDocumentoInformado: Boolean;
    function fLeftJoinIteger: boolean;

  published

      property intPreco: Integer read FPreco;
      property intPrePra: Integer read FPrePra;
      property intDecimais: Integer read FDecimais;
      property fltValor: Double read FValor;
      property strInfAdi: String read FInfAdi;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    intTipEti: Integer;
    blnMovDet: Boolean;
    strDtaIni: String;
    strDtaFin: String;
    strTipPer: String;

    blnViaBol: Boolean;
    strCliBol: String;
  end;


implementation

uses  untConstantes, untDigQtdEti, untConsultas, untCadConfRelatorios, untPai,
      untCnfEtiqueta, untMenuMarcarEti, untCfgRel, untCadPro, untFuncoesEtiqItens,
      untFuncMacro, untfuncoesConsulta,untFuncoes;
{$R *.dfm}

{ TfrmRelEtiPrecificacao }

function TfrmRelEtiPrecificacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskLinGru) Then
    Begin
      pDesmarcaLista(mskLinGru, arrLinGru, '', 6);
    End

    Else If (Sender = edtCodIte) Then
    Begin
      pDesmarcaLista(edtCodIte, arrItem);
    End

    Else If (Sender = edtCodBarra) Then
    Begin
      pDesmarcaLista(edtCodBarra, arrCodBar);
    End

    Else If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar, arrMarca);
    End

    Else If (Sender = edtCodFor) Then
    Begin
      pDesmarcaLista(edtCodFor, arrFornec);
    End

    Else If (Sender = edtLocFis) Then
    Begin

      If blnCadLoc Then
      Begin

        If (Not fEmptyStr(edtLocFis.Text)) Then
        Begin

          If fEmptyStr(fRetNomLocFisica(edtLocFis.Text)) Then
          Begin
            pMensagemOk('Localização Física não encontrada!');
            Result := False;
          End

        End;

      End;

    End

    Else If (Sender = cmbPreVis) Then
    Begin
      If cmbPreVis.ItemIndex < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Escolha tabela para calcular preço a vista!', ['&Ok']);
          Result := False;
        End;
    End

    Else If (Sender = cmbPrePra) Then
    Begin
      If cmbPrePra.ItemIndex < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Escolha tabela para calcular preço a prazo!', ['&Ok']);
          Result := False;
        End;
    End

    {*****************************************}
    {* VALIDA A QUANTIDADE DE ETIQUETAS      *}
    {**************************************MA*}
    Else If (Sender = edtQtdEtq) Then
    Begin
      If fEmptyStr(edtQtdEtq.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Defina uma quantidade de etiquetas!', ['&O  k']);
        Result := False;
      End
      Else If StrToInt(edtQtdEtq.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Defina uma quantidade de etiquetas maior que zero!', ['&O  k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA A QUANTIDADE DE PARCELAS      *}
    {**************************************MA*}
    Else If (Sender = edtQtdPar) Then
    Begin
      If fEmptyStr(edtQtdPar.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Defina um número de parcelas!', ['&O  k']);
        Result := False;
      End
      Else If StrToInt(edtQtdPar.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Defina um número de parcelas maior que zero!', ['&O  k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VERIFICA ACRÉSCIMO ENTRE 0 E 100      *}
    {**************************************MA*}
    Else If (Sender = edtPerAcr) Then
    Begin
      If Not fEmptyStr(edtPerAcr.Text) Then
      Begin
        If Not fValidaEscala(edtPerAcr.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O percentual de acréscimo deve estar entre 0 e 100 !', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodForDoc) Then
    Begin
      If (Not fEmptyStr(edtCodForDoc.Text)) Then
      Begin
        edtNomForDoc.Text := fRetNomFornecedor(edtCodForDoc.Text);

        If fEmptyStr(edtNomForDoc.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else If Not(fEmptyStr(edtNumDoc.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fornecedor deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
        edtNomForDoc.Clear;
    End
    Else If Sender = edtSerie Then
    Begin
      If (Not(fEmptyStr(edtNumDoc.Text))) And (fEmptyStr(edtSerie.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Serie deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

    End
    Else If Sender = edtNumDoc Then
    Begin
      edtEspDoc.Text := 'NF';
      edtSerie.ReadOnly := fEmptyStr(edtNumDoc.Text);
      edtCodForDoc.ReadOnly := fEmptyStr(edtNumDoc.Text);
      edtEspDoc.ReadOnly := fEmptyStr(edtNumDoc.Text);

      edtSerie.TabStop     := Not fEmptyStr(edtNumDoc.Text);
      edtCodForDoc.TabStop := Not fEmptyStr(edtNumDoc.Text);
      edtEspDoc.TabStop := Not fEmptyStr(edtNumDoc.Text);
    End
    
    {*****************************************}
    {* VERIFICA DESCONTO ENTRE 0 E 100       *}
    {**************************************MA*}
    Else If (Sender = edtPerDes) Then
    Begin
      If Not fEmptyStr(edtPerDes.Text) Then
      Begin
        If Not fValidaEscala(edtPerDes.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O percentual de desconto deve estar entre 0 e 100 !', ['&Ok']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelEtiPrecificacao.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru,edtDesGru,arrLinGru,fRetNomeLinhaGrupo,Nil,'da linha/grupo inicial',6);
end;

procedure TfrmRelEtiPrecificacao.mskLinGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinGru,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEtiPrecificacao.FormShow(Sender: TObject);
begin
  inherited;

 //new cdsPromoc.CreateDataSet;
  cdsArmaze.CreateDataSet;
  cdsArmaze.IndexFieldNames := 'CODITE';

  cdsImpEti.CreateDataSet;
  cdsImpEti.Open;
  cdsImpEti.EmptyDataSet;
  cdsImpEti.Filter   := '';
  cdsImpEti.Filtered := FALSE;

  cdsImpEtiIte.CreateDataSet;
  cdsImpEtiIte.Open;
  cdsImpEtiIte.EmptyDataSet;
  cdsImpEtiIte.Filter   := '';
  cdsImpEtiIte.Filtered := FALSE;

  pCarregaTabelaPrecosVista;
  pCarregaTabelaPrecosPrazo;

  qryEtique     := fCriaQuery;

  strValDes := '1';
  strValAcr := '1';

  intIndBusca   := 2;
  strTipEti     := 'PRP';
  strNomeTabela := 'CADITE';
  pAbreItens;

  cdsCodBar.CreateDataSet;
  cdsCodBar.Open;

  blnImpPre := True;
end;

procedure TfrmRelEtiPrecificacao.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDoc);
end;

procedure TfrmRelEtiPrecificacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  Screen.Cursor := crHourGlass;
  pLimparFiltros;
  fDesmarcar;
  Screen.Cursor := crDefault;

  blnLibCnf := False;
  FreeAndNil(stlCampos);
  FreeAndNil(stlDesInd);
  FreeAndNil(qryEtique);
end;

procedure TfrmRelEtiPrecificacao.pImpEtiquetasMatricial;
  Var
    intContador: Integer;
    intQtdTopo : Integer;
    qryCfgRel  : TUniQuery;
begin
  qryCfgRel := fCriaQuery(Self);
  pCarregaConfImpr(qryCfgRel, Self.Name);
  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
  strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;

  pCarregaConfImpr(qryCfgRel, Self.Name + '_ITE');
  If Not fEmptyStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString) Then
  Begin
    strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
    strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
    strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;
  End;

  If Not fVerificaImpressora(strNomImp) Then
  Begin
    fMensagem('','Impressora configurada incorretamente!',['&OK']);
    Exit;
  End;

  pConsulta;
  With qryImpEti Do
  Begin

    intQtdTopo := fRetTopoEtiqueta( strTipEti );

    For intContador := 1 to intQtdTopo Do
    Begin
      pEscreveLinha(untFuncMacro.strArqTxt, ' ', False, strNomImp, strNomPro, strDesPro);
    End;

    First;
    While Not Eof Do
    Begin
      Application.ProcessMessages;
      pImpRegistro;
      Application.ProcessMessages;

      Next;
    End;
    {*****************************************}
    {* É NECESSARIO CHAMAR ESSA PROCEDURE    *}
    {* NESSE PONTO PARA QUE SAIA A ÚLTIMA    *}
    {* ETIQUETA                              *}
    {**************************************MV*}
    pImpArrLinhasEti;

    Close;
   // pConsulta;
  End;

  pSetFocus(dbgEtiquetas);

  FreeAndNil(qryCfgRel);
end;

procedure TfrmRelEtiPrecificacao.pImpRegistro;
  Var
    intQtdCol   : Integer;
    intQtdColOri: Integer;
    intContador : Integer;
    intLinhaAtu : Integer;
    intLinha    : Integer;
    intTamLinAnt: Integer;
    intNumCol   : Integer;
    intQtdEti   : Integer;
    intLinhaEti : Integer;
    strNumCol   : String;
    strLinha    : String;
    strSQL      : String;
    qryCnfEti   : TUniQuery;
begin
  intLinhaAtu := 1;
  intLinha    := 0;
  intLinhaEti := 0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CNFETI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CNF_TIPETI = :TIPETI AND';
  strSQL := strSQL + '  CNF_CODEMP = :CODEMP    ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  CNF_IDENTI, CNF_LINIMP, CNF_COL001 ';

  qryCnfEti := fCriaQuery(Self);
  With qryCnfEti Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('TIPETI').AsString := strTipEti;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    intQtdEti := qryImpEti.FieldByName(strCamQtd).AsInteger;

    While (intQtdEti > 0) Do
    Begin
      First;

      intQtdColOri := FieldByName('CNF_QTDCOL').AsInteger;
      intQtdCol := intQtdColOri;

      If (intQtdCol > intQtdEti) And (intColAtu <= 1) Then
        intQtdCol := intQtdEti;

      {*****************************************}
      {* LÊ E INTERPRETA O ID = '00'           *}
      {**************************************MV*}
      If intColAtu <= 1 Then
      Begin
        pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, 0, qryCnfEti);
        {*****************************************}
        {* ESCREVE COM WRITE, MAS NÃO IMPRIME    *}
        {**************************************MV*}
        pEscreveLinha(strArqTxt, AnsiString(strLinha), not VS_SpoolImpressaoCitel, strNomImp, strNomPro, strDesPro);
      End;
      Next;

      If (Length(arrLinhasEti) = 0) Then
      Begin
        If RecordCount > 0 Then
          SetLength(arrLinhasEti, RecordCount-1)
        Else
          SetLength(arrLinhasEti, 0);
      End;

      While (Not Eof) Do
      Begin

        strLinha := '';

        For intContador := intColAtu To IIF(intQtdEti = 1, intColAtu, intQtdCol) Do
        Begin

          strNumCol := fStrZero(IntToStr(intContador), 03);
          intNumCol := FieldByName('CNF_COL' + strNumCol).AsInteger;

          intTamLinAnt := Length(arrLinhasEti[intLinhaEti]);
          pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, (intNumCol - intTamLinAnt), qryCnfEti);

          arrLinhasEti[intLinhaEti] := arrLinhasEti[intLinhaEti] + strLinha;
          strLinha := ''; //Se desistir da matriz, tirar essa linha

        End;
        Inc(intLinhaEti);

        {*****************************************}
        {* NEXT NO ARQUIVO DE CNF                *}
        {**************************************MV*}
        Next;

      End;

      intLinhaEti := 0;
      Inc(intColAtu, intQtdEti);
      Dec(intQtdEti, (intQtdColOri+1) - (intColAtu - intQtdEti));

      If intColAtu > intQtdColOri Then
      Begin
        pImpArrLinhasEti;
        intColAtu := 1;
      End;

    End;

  End;
  FreeAndNil(qryCnfEti);
end;

procedure TfrmRelEtiPrecificacao.pConsulta(blnManter: Boolean = False);
begin
  If RadTipoAlteracao.ItemIndex = 0 Then
  Begin
    strValDes := AnsiReplaceStr(FloatToStr(((100 - fStrToFloat(edtPerDes.Text))/100)),',','.');
    strValAcr := AnsiReplaceStr(FloatToStr(((100 + fStrToFloat(edtPerAcr.Text))/100)),',','.');
  End
  Else
  Begin
    strValDes := AnsiReplaceStr(edtPerDes.Text,',','.');
    strValAcr := AnsiReplaceStr(edtPerAcr.Text,',','.');

    If fEmptyStr(edtPerDes.Text) then
      strValDes := '0.00';

    If fEmptyStr(edtPerAcr.Text) then
      strValAcr := '0.00';
  End;

  With qryImpEti Do
  Begin
    Close;
    SQL.Clear;
    if blnManter then
    begin
      SQL.Add(fRetornaSQLIte);
      if not fCfgSis('DEFORD', varBoolean) then
        SQL.Add(' ORDER BY ITE_DESITE ')
      else
        SQL.Add(' ORDER BY SEQETI ');
    end
    Else
    Begin
      SQL.Add(fRetornaSQLIte + fGetFiltrosItens);
      if not fCfgSis('DEFORD', varBoolean) then
        SQL.Add(' ORDER BY ITE_DESITE ')
      else
        SQL.Add(' ORDER BY SEQETI ');
      pSetParamsItens(qryImpEti);
    End;


    Open;

    if FieldByName('ITE_PREVE1') <> Nil then
      (FieldByName('ITE_PREVE1') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREVE2') <> Nil then
      (FieldByName('ITE_PREVE2') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREVE3') <> Nil then
      (FieldByName('ITE_PREVE3') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREVE4') <> Nil then
      (FieldByName('ITE_PREVE4') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREVE5') <> Nil then
      (FieldByName('ITE_PREVE5') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREVE6') <> Nil then
      (FieldByName('ITE_PREVE6') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREVE7') <> Nil then
      (FieldByName('ITE_PREVE7') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREVIS') <> Nil then
      (FieldByName('ITE_PREVIS') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREPRA') <> Nil then
      (FieldByName('ITE_PREPRA') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_VALPAR') <> Nil then
      (FieldByName('ITE_VALPAR') As TFloatField).DisplayFormat := '#,##0.00';

  End;

end;

procedure TfrmRelEtiPrecificacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key =  VK_ESCAPE Then
    Close

  Else If (Key = VK_F4) Then
  Begin
    btnLimFil.Click;
  End

  Else If (Key = VK_F6) Then
  Begin
    btnConfigurar.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_Escape) Then
  Begin
    btnSairImp.Click;
  End;

end;

procedure TfrmRelEtiPrecificacao.btnImprimirClick(Sender: TObject);
var
  ArrNomEti: TStringArray;
  intOpcao : Integer;
begin
  inherited;
  strEtiPrp         := fCfgSis('ETIPRP');
  intColAtu := 1;

  If (fMensagem('', 'Confirma impressão das Etiquetas?', ['&Sim', '&Não']) = 1) Then
  Begin
    If (fRetQtdSel > 0) Then
    Begin

      If fEmptyStr(strEtiPrp) Then
      Begin
        SetLength(ArrNomEti, 0);
        pAddDados(ArrNomEti, 'Laser');
        pAddDados(ArrNomEti, 'Argox');
        intOpcao := fGetMenu('Escolha o Modelo:', ArrNomEti, 1, True);
        Case intOpcao Of
          1: strEtiPrp := 'L';
          2: strEtiPrp := 'A';
        Else
          Exit;
        End;
      End;

      If (Pos(strEtiPrp, 'LZA') > 0) Then
      Begin
        pConsulta(True);
        fImprimeLaserArgox;
      End

      {***********************}
      {* IMPRESSAO MATRICIAL *}
      {********************AN*}
      Else
      Begin
        FInfAdi := fInformacaoAdicionalEtiquetaItens;
        pImpEtiquetasMatricial;
      End;

    End
    Else
      fMensagem('ATENÇÃO!', 'Quantidade de etiquetas deve ser maior que zero!', ['&OK']);
  End;
end;

procedure TfrmRelEtiPrecificacao.btnLimFilClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;

  pLimparFiltros;
  fDesmarcar;
  pConsulta;

  Screen.Cursor := crDefault;
  pSetFocus(mskLinGru);
end;

procedure TfrmRelEtiPrecificacao.FormCreate(Sender: TObject);
begin
  inherited;
  blnETQLOC := fCfgSis('ETQLOC', varInteger) = 1;
  cbxLocFisicaPrincipal.Checked := True;
  cbxLocFisicaPrincipal.Visible := blnETQLOC;
  cbxLocFisicaLote.Visible := blnETQLOC;
  If blnETQLOC Then
    edtLocFis.Width := 170;

  {Se resolução disponível for inferior ou igual à (1366 x 768), ajusta a tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  pSetaCodIte(edtCodIte);
  pSetaCodIte(cdsImpEtiIteCODITE);
  pSetaCodIte(cdsArmazeCODITE);

  cpuCampos         := Nil;
  strCfgTipEti      := fCfgSis('TIPETI');
  blnUsaArm         := (fCfgSis('CTLEST') = '2');
  FDecimais         := fCfgSis('DECUNI', varInteger);

  updImpEti := TUniUpdateSQL.Create(Self);
  qryImpEti := fCriaQuery(Self);
  qryImpEti.Options.SetFieldsReadOnly := False;
  qryImpEti.UpdateObject := updImpEti;
  dtsImpEti := fCriaDataSource(qryImpEti);
  dbgEtiquetas.DataSource := dtsImpEti;

  blnViaBol := False;
  strCliBol := '';

  FPais := fSetaPais;

  If blnCadLoc and (not blnUsaArm) Then
    pHabilitaLocFis(False);

  stlCampos   := TStringList.Create;
  stlDesInd   := TStringList.Create;
  intIndBusca := 0;

  If fCfgSis('TIPBAR', varString) = '2' Then
   edtCodBarra.MaxLength := 43;

end;

procedure TfrmRelEtiPrecificacao.pImpArrLinhasEti;
  Var
    intContador1: Integer;
    intLength1: Integer;
    blnUltimoReg: Boolean;
    strLinhaAtu: String;
    blnImprime: Boolean;
begin
  strLinhaAtu := '';
  blnUltimoReg := False;
  intLength1 := Length(arrLinhasEti);
  blnImprime := False;

  For intContador1 := 0 To intLength1-1 Do
  Begin
    If arrLinhasEti[intContador1] <> '' Then
    Begin
      blnImprime := True;
      Break;
    End;
  End;

  If Not blnImprime Then
  Begin
    Exit;
  End;

  For intContador1 := 0 To intLength1-1 Do
  Begin
    If (intContador1 = intLength1-1) Then
    Begin
      blnUltimoReg := True;
    End;

    pEscreveLinha(strArqTxt, AnsiString(arrLinhasEti[intContador1]), blnUltimoReg, strNomImp, strNomPro, strDesPro);
    strLinhaAtu := '';
  End;

  SetLength(arrLinhasEti, 0);
end;

procedure TfrmRelEtiPrecificacao.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmCadConfRelatorios, frmCadConfRelatorios);
    frmCadConfRelatorios.strNomeForm   := Self.Name;
    frmCadConfRelatorios.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmRelEtiPrecificacao.btnConfigurarClick]');
    End;
  End;

  pFreeAndNil(frmCadConfRelatorios);
  pSetFocus(dbgEtiquetas);

end;

function TfrmRelEtiPrecificacao.fLeftJoinIteger: boolean;
begin

  Result := True;

  if not fEmptyStr(edtLocFis.Text) then
    Exit;

  if (rdgSaldo.ItemIndex <> 2) then
    Exit;

  Result := False;
end;

procedure TfrmRelEtiPrecificacao.btnConfirmaClick(Sender: TObject);
Var
  blnUtilizarReplace: boolean;
begin
  inherited;
  If (Not fValidaCampos(cmbPreVis, False)) Then
    Exit;

  If (Not fValidaCampos(cmbPrePra, False)) Then
    Exit;

  If (Not fValidaCampos(edtQtdPar, False)) Then
    Exit;

  If (Not fValidaCampos(edtQtdEtq, False)) Then
    Exit;

  If (Not fValidaCampos(edtSerie, False)) Then
    Exit;

  If (Not fValidaCampos(edtCodForDoc, False)) Then
    Exit;

  pEscolheTabelaPreco;
  pEscolheTabelaPrecoPrazo;

  blnUtilizarReplace := False;
  If fPergunta('Deseja limpar os itens previamente selecionados?') Then
    fDesmarcar
  Else
    blnUtilizarReplace := True;

  Try

    fMarca(fRetornaSQLMarcaIte(StrToInt(edtQtdEtq.Text), blnUtilizarReplace) +
           IfThen(fLeftJoinIteger, 'LEFT JOIN ITEGER G ON G.ITE_CODITE = CADITE.ITE_CODITE AND G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp), '') +
           IfThen(blnETQLOC, 'LEFT JOIN CADLOT L ON L.LOT_CODEMP = G.ITE_CODEMP AND L.LOT_CODITE = G.ITE_CODITE', '') +
           IfThen(fDocumentoInformado, 'INNER JOIN  MOVDET ON DET_CODITE = CADITE.ITE_CODITE ', '') +
           ' WHERE TRUE ' + fGetFiltrosItens(True) +
           ' GROUP BY ETI_CODOPE, ETI_CODITE');

    pConsulta(True);
    edtTotEti.Text := IntToStr( StrToInt(edtQtdEtq.Text) * qryImpEti.RecordCount);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmRelEtiPrecificacao.btnConfirmaClick]');
    End;
  End;

  If Not(fEmptyStr(edtCodBarra.Text)) Then
  Begin
    edtCodBarra.Clear;
    edtCodIte.Clear;
    edtCodIte.Color := clWindow;
    edtCodIte.Enabled:= True;
    edtDesIte.Clear;
  End;

  strEtiPrp := '';
end;

procedure TfrmRelEtiPrecificacao.pAbreItens;
  Var dtsTmp : TDataSource;
  intCont, intIndice: Integer;
begin
  strCamQtd := 'ITE_QTDETI';
  strAmzEti := 'ITE_AMZETI';

  {*****************************************}
  {* INICIALIZA VARIAVEIS DA BUSCA         *}
  {**************************************MV*}


  stlCampos.Add('T.ITE_QTDETI');
  stlCampos.Add('I.ITE_CODITE');
  stlCampos.Add('I.ITE_DESITE');

  For intCont := 1 To Length(Trim(VS_strTabPrc)) Do
  Begin
    If (VS_strTabPrc[intCont] = 'S') Then
      stlCampos.Add('I.ITE_PREVE' + IntToStr(intCont));
  End;
  stlCampos.Add('I.ITE_PREVIS');
  stlCampos.Add('ITE_PREPRA');
  stlCampos.Add('I.ITE_VALPAR');
  stlCampos.Add('I.ITE_CODGRU');
  stlCampos.Add('I.ITE_REFERE');
  stlCampos.Add('I.ITE_CODMAR');
  stlCampos.Add('I.ITE_CODFOR');
  stlCampos.Add('G.ITE_AMZETI');
  stlCampos.Add('G.ITE_LOCFIS');
  stlCampos.Add('I.ITE_ITEATI');

  stlDesInd.Add('Qtd. Etiq.');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');

  if (FPreco>0) then
  begin
    For intCont := 1 To Length(Trim(VS_strTabPrc)) Do
    Begin
      If (VS_strTabPrc[intCont] = 'S') Then
        stlDesInd.Add('Preço Venda ' + IntToStr(intCont) + ' ');
    End;
  end;

  stlDesInd.Add('Preço a Vista');
  stlDesInd.Add('Preço a Prazo');
  stlDesInd.Add('Valor das Parcelas');
  stlDesInd.Add('Grupo');
  stlDesInd.Add('Referência');
  stlDesInd.Add('Marca');
  stlDesInd.Add('Fornecedor');
  stlDesInd.Add('Código Armazém');
  stlDesInd.Add('Loc.Física Estoque');
  stlDesInd.Add('Status');

  With qryImpEti Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fRetornaSQLIte);
    if not fCfgSis('DEFORD', varBoolean) then
      SQL.Add(' ORDER BY ' + stlCampos[intIndBusca] + IIF(intIndBusca = 1, ', ITE_DESITE', ''))
    else
      SQL.Add(' ORDER BY SEQETI ');

    Open;

    if FieldByName('ITE_PREVE1') <> Nil then
      (FieldByName('ITE_PREVE1') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREVE2') <> Nil then
      (FieldByName('ITE_PREVE2') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREVE3') <> Nil then
      (FieldByName('ITE_PREVE3') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREVE4') <> Nil then
      (FieldByName('ITE_PREVE4') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREVE5') <> Nil then
      (FieldByName('ITE_PREVE5') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREVE6') <> Nil then
      (FieldByName('ITE_PREVE6') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREVE7') <> Nil then
      (FieldByName('ITE_PREVE7') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREVIS') <> Nil then
      (FieldByName('ITE_PREVIS') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_VALPAR') <> Nil then
      (FieldByName('ITE_VALPAR') As TFloatField).DisplayFormat := '#,##0.00';
    if FieldByName('ITE_PREPRA') <> Nil then
      (FieldByName('ITE_PREPRA') As TFloatField).DisplayFormat := '#,##0.00';

  End;

  With dbgEtiquetas Do
  Begin
    Columns.Clear;

    intIndice := 0;

    Columns.Add;
    Columns[intIndice].FieldName     := 'ITE_QTDETI';
    Columns[intIndice].Title.Caption := 'Qtd. Eti.';
    Columns[intIndice].Alignment     := taCenter;
    Columns[intIndice].Width         := 50;

    inc(intIndice);

    Columns.Add;
    Columns[intIndice].FieldName     := 'ITE_CODITE';
    Columns[intIndice].Title.Caption := 'Código';

    inc(intIndice);

    Columns.Add;
    Columns[intIndice].FieldName     := 'ITE_DESITE';
    Columns[intIndice].Title.Caption := 'Descrição';
    Columns[intIndice].Width         := 320;

    inc(intIndice);

    if (FPreco>0) then
    begin
      For intCont := 1 To Length(Trim(VS_strTabPrc)) Do
      Begin
        If (VS_strTabPrc[intCont] = 'S') Then
        Begin
          Columns.Add;
          Columns[intIndice].FieldName     := 'ITE_PREVE' + IntToStr(intCont);
          Columns[intIndice].Title.Caption := 'Preço Venda ' + IntToStr(intCont);
          Columns[intIndice].Alignment     := taRightJustify;
          Columns[intIndice].Width         := 80;
          inc(intIndice);
        End;
      End;
    end;

    Columns.Add;
    Columns[intIndice].FieldName     := 'ITE_PREVIS';
    Columns[intIndice].Title.Caption := 'Preço a Vista';

    inc(intIndice);

    Columns.Add;
    Columns[intIndice].FieldName     := 'ITE_PREPRA';
    Columns[intIndice].Title.Caption := 'Preço a Prazo';

    inc(intIndice);

    Columns.Add;
    Columns[intIndice].FieldName     := 'ITE_VALPAR';
    Columns[intIndice].Title.Caption := 'Valor da Parcela';

    inc(intIndice);

    Columns.Add;
    Columns[intIndice].FieldName     := 'ITE_CODGRU';
    Columns[intIndice].Title.Caption := 'Grupo';

    inc(intIndice);

    Columns.Add;
    Columns[intIndice].FieldName     := 'ITE_REFERE';
    Columns[intIndice].Title.Caption := 'Referência';
    Columns[intIndice].Width         := 80;

    inc(intIndice);

    Columns.Add;
    Columns[intIndice].FieldName     := 'ITE_CODMAR';
    Columns[intIndice].Title.Caption := 'Marca';

    inc(intIndice);

    Columns.Add;
    Columns[intIndice].FieldName     := 'ITE_CODFOR';
    Columns[intIndice].Title.Caption := 'Fornecedor';

    inc(intIndice);

    Columns.Add;
    Columns[intIndice].FieldName     := 'ITE_AMZETI';
    Columns[intIndice].Title.Caption := 'Código Armazém';

    inc(intIndice);

    Columns.Add;
    Columns[intIndice].FieldName     := 'ITE_LOCFIS';
    Columns[intIndice].Title.Caption := 'Loc.Física Estoque';

    inc(intIndice);

    Columns.Add;
    Columns[intIndice].FieldName     := 'ITE_ITEATI';
    Columns[intIndice].Title.Caption := 'Status';

  End;

  dtsTmp := dbgEtiquetas.DataSource;

  dbgEtiquetas.DataSource := Nil;

(*new
  QryImpEti.First;

  While Not QryImpEti.Eof Do
  Begin
    If Not fEmptyStr(QryImpEti.FieldByName('ITE_AMZETI').AsString) Then
    Begin
    //  pAlteraArmazem(QryImpEti.FieldByName('ITE_AMZETI').AsString, QryImpEti.FieldByName('ITE_CODITE').AsString);
    End;
    QryImpEti.Next;
  End;
 *)
  QryImpEti.First;
  dbgEtiquetas.DataSource := dtsTmp;

end;

function TfrmRelEtiPrecificacao.fGetFiltrosItens(blnIteEti: boolean = False): String;
  Var
    strSQL: String;
    prefixo: string;
Begin

  strSQL := '';
  Prefixo := IfThen(blnIteEti, 'CADITE', 'I');

  strSQL := strSQL + fStrLocateLinGru(mskLinGru, arrLinGru, Prefixo + '.ITE_CODGRU', 'CODGRU');
  strSQL := strSQL + fStrLocate(edtCodMar,       arrMarca,  Prefixo + '.ITE_CODMAR', 'CODMAR');
  strSQL := strSQL + fStrLocate(edtCodIte,       arrItem,   Prefixo + '.ITE_CODITE', 'CODITE');
  strSQL := strSQL + fStrLocate(edtCodBarra,     arrCodBar, Prefixo + '.ITE_CODBAR', 'CODBAR');
  strSQL := strSQL + fStrLocate(edtCodFor,       arrFornec, Prefixo + '.ITE_CODFOR', 'CODFOR');

  If Not fEmptyStr(edtRefere.Text) Then
    strSQL := strSQL + '  AND ' + Prefixo + '.ITE_REFERE LIKE :REFERE  ';

  If Not fEmptyStr(edtDescri.Text) Then
    strSQL := strSQL + '  AND ' + Prefixo + '.ITE_DESITE LIKE :DESITE  ';

  If Not fEmptyStr(edtLocFis.Text) Then
  Begin
    If cbxLocFisicaPrincipal.Checked And cbxLocFisicaLote.Checked Then
    Begin
      strSQL := strSQL + '  AND  ';
      strSQL := strSQL + '  (LEFT(G.ITE_LOCFIS, LENGTH(:TAMLOC)) = :LOCFIS  OR LEFT(L.LOT_LOCFIS, LENGTH(:TAMLOC)) = :LOCFIS)';
    End
    Else If cbxLocFisicaPrincipal.Checked Then
    Begin
      strSQL := strSQL + '  AND  ';
      strSQL := strSQL + '  LEFT(G.ITE_LOCFIS, LENGTH(:TAMLOC)) = :LOCFIS ';
    End
    Else If cbxLocFisicaLote.Checked Then
    Begin
      strSQL := strSQL + '  AND  ';
      strSQL := strSQL + '  LEFT(L.LOT_LOCFIS, LENGTH(:TAMLOC)) = :LOCFIS ';
    End;

  End;

  If rdgStatus.ItemIndex <> 2 Then
    strSQL := strSQL + ' AND ' + Prefixo + '.ITE_ITEATI = :STATUS ';
  if fDocumentoInformado Then
  Begin
    If Not fEmptyStr(edtNumDoc.Text) Then
      strSQL := strSQL + '  AND DET_NUMDOC = :NUMDOC ';
    If Not fEmptyStr(edtEspDoc.Text) Then
      strSQL := strSQL + '  AND DET_ESPDOC = :ESPDOC ';
    If Not fEmptyStr(edtSerie.Text) Then
      strSQL := strSQL + '  AND IFNULL(DET_SERIE_, "") = :SERIE_ ';
    If Not fEmptyStr(edtNumDoc.Text) Then
      strSQL := strSQL + '  AND DET_CODEMP = "' + VS_StrCodEmp + '" ';
    If Not fEmptyStr(edtCodForDoc.Text) Then
      strSQL := strSQL + '  AND DET_CODFOR = :CODFORDOC ';
  End;

  case rdgSaldo.ItemIndex of
    0: strSQL := strSQL + ' AND G.ITE_SALDOS > 0 ';
    1: strSQL := strSQL + ' AND G.ITE_SALDOS < 0 ';
  end;

  Result := strSQL;
End;

procedure TfrmRelEtiPrecificacao.pSetParamsItens(qryMarca: TUniQuery);
Begin
  With qryMarca Do
  Begin

    pSetaParam(mskLinGru.Text,  arrLinGru, strLinGru,  'CODGRU', qryMarca);
    pSetaParam(edtCodMar.Text,  arrMarca,  strMarca,   'CODMAR', qryMarca);
    pSetaParam(edtCodIte.Text,  arrItem,   strProduto, 'CODITE', qryMarca);
    pSetaParam(edtCodBarra.Text,arrCodBar, strCodBar,  'CODBAR', qryMarca);

    pSetaParam(edtCodFor.Text, arrFornec, strFornec,  'CODFOR', qryMarca);

    If not fEmptyStr(edtRefere.Text) Then
      ParamByName('REFERE').AsString := edtRefere.Text + '%';

    If not fEmptyStr(edtDescri.Text) Then
      ParamByName('DESITE').AsString := edtDescri.Text + '%';

    If Not fEmptyStr(edtLocFis.Text) Then
    Begin
      ParamByName('TAMLOC').AsString := edtLocFis.Text;
      ParamByName('LOCFIS').AsString := edtLocFis.Text;
    End;

    Case rdgStatus.ItemIndex Of
      0: ParamByName('STATUS').AsString := 'S';
      1: ParamByName('STATUS').AsString := 'N';
    End;

    If fDocumentoInformado Then
    Begin
      If Not fEmptyStr(edtNumDoc.Text) Then
        ParamByName('NUMDOC').AsString := edtNumDoc.Text;

      If Not fEmptyStr(edtEspDoc.Text) Then
        ParamByName('ESPDOC').AsString := edtEspDoc.Text;

      If Not fEmptyStr(edtSerie.Text) Then
       ParamByName('SERIE_').AsString := edtSerie.Text;

      If Not fEmptyStr(edtCodForDoc.Text) Then
        ParamByName('CODFORDOC').AsString := edtCodForDoc.Text;
    End;
  End;
End;

procedure TfrmRelEtiPrecificacao.RadTipoAlteracaoClick(Sender: TObject);
begin
  inherited;
  If RadTipoAlteracao.ItemIndex = 0 Then
  Begin
    lblSimDes.Visible := True;
    lblSimAcr.Visible := True;
  End
  Else
  Begin
    lblSimDes.Visible := False;
    lblSimAcr.Visible := False;
  End;
end;

procedure TfrmRelEtiPrecificacao.btnSairImpClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmRelEtiPrecificacao.fDocumentoInformado: Boolean;
Begin
  Result := (Not fEmptyStr(edtNumDoc.Text)) And
            (Not fEmptyStr(edtSerie.Text)) And
            (Not fEmptyStr(edtEspDoc.Text)) And
            (Not fEmptyStr(edtCodForDoc.Text));
End;
function TfrmRelEtiPrecificacao.fRetornaSQLIte: String;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE DISTINCT ';
  strSQL := strSQL + '  I.ITE_CODUNI AS ITE_CODUNI, ';
  strSQL := strSQL + '  I.ITE_CODEMP AS ITE_CODEMP, ';
  strSQL := strSQL + '  T.ETI_QTDETI AS ITE_QTDETI, ';
  strSQL := strSQL + '  IF(I.ITE_ITEATI = "S", "A", "I") AS ITE_ITEATI, ';
  strSQL := strSQL + '  I.ITE_CODITE AS ITE_CODITE, ';
  strSQL := strSQL + '  I.ITE_CODGRU AS ITE_CODGRU, ';
  strSQL := strSQL + '  I.ITE_DESITE AS ITE_DESITE, ';
  strSQL := strSQL + '  I.ITE_REFERE AS ITE_REFERE, ';
  strSQL := strSQL + '  I.ITE_CODBAR AS ITE_CODBAR, ';
  strSQL := strSQL + '  I.ITE_CODFAB AS ITE_CODFAB, ';
  strSQL := strSQL + '  I.ITE_CODMAR AS ITE_CODMAR, ';
  strSQL := strSQL + '  I.ITE_CODBAR AS ITE_CODBAR, ';
  strSQL := strSQL + '  I.ITE_CODFOR AS ITE_CODFOR, ';
  strSQL := strSQL + '  I.ITE_DTAALT AS ITE_DTAALT, ';
  strSQL := strSQL + '  G.ITE_PREVE1 AS ITE_PREVE1, ';
  strSQL := strSQL + '  G.ITE_PREVE2 AS ITE_PREVE2, ';
  strSQL := strSQL + '  G.ITE_PREVE3 AS ITE_PREVE3, ';
  strSQL := strSQL + '  G.ITE_PREVE4 AS ITE_PREVE4, ';
  strSQL := strSQL + '  G.ITE_PREVE5 AS ITE_PREVE5, ';
  strSQL := strSQL + '  G.ITE_PREVE6 AS ITE_PREVE6, ';
  strSQL := strSQL + '  G.ITE_PREVE7 AS ITE_PREVE7, ';
  strSQL := strSQL + '  G.ITE_AMZETI AS ITE_AMZETI, ';
  strSQL := strSQL + '  G.ITE_LOCFIS AS ITE_LOCFIS, ';

  if (FPreco = 0) then
  begin
    {Preço de promoção}
    strSQL := strSQL + '  IFNULL( ';
    strSQL := strSQL + '    (SELECT ';
    strSQL := strSQL + '      IPR_PREVEN ';
    strSQL := strSQL + '    FROM ';
    strSQL := strSQL + '      CADPRO, ';
    strSQL := strSQL + '      PROEMP, ';
    strSQL := strSQL + '      ITEPRO ';
    strSQL := strSQL + '    WHERE CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
    strSQL := strSQL + '      AND PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM ';
    strSQL := strSQL + '      AND PROEMP.PRO_CODEMP = '+ VS_strCodEmp;
    strSQL := strSQL + '      AND IPR_CODITE = T.ETI_CODITE ';
    strSQL := strSQL + '      AND CURDATE() BETWEEN PRO_DTAINI ';
    strSQL := strSQL + '      AND PRO_DTAFIN ';
    strSQL := strSQL + '    ORDER BY PRO_DTAINI, ';
    strSQL := strSQL + '      PRO_DTAFIN ';
    strSQL := strSQL + '    LIMIT 1), ';
    strSQL := strSQL + '    0 ';
    If RadTipoAlteracao.ItemIndex = 0 Then
      strSQL := strSQL + '  ) * ' + strValDes + ' AS ITE_PREVIS, '
    else
      strSQL := strSQL + '  ) - ' + strValDes + ' AS ITE_PREVIS, ';
  end
  else
  begin
    If RadTipoAlteracao.ItemIndex = 0 Then
    Begin
      strSQL := strSQL + '  G.ITE_PREVE' + IIF(FPreco = 0,'1',IntToStr(FPreco)) +  ' * ' + strValDes + ' AS ITE_PREVIS, '
    End
    Else
    Begin
      strSQL := strSQL + '  G.ITE_PREVE' + IIF(FPreco = 0,'1',IntToStr(FPreco)) +  ' - ' + strValDes + ' AS ITE_PREVIS, ';
    End;
  end;

  if (FPrePra = 0) then
  begin

    strSQL := strSQL + '  IFNULL( ';
    strSQL := strSQL + '    (SELECT ';
    strSQL := strSQL + '      IPR_PREVEN ';
    strSQL := strSQL + '    FROM ';
    strSQL := strSQL + '      CADPRO, ';
    strSQL := strSQL + '      PROEMP, ';
    strSQL := strSQL + '      ITEPRO ';
    strSQL := strSQL + '    WHERE CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
    strSQL := strSQL + '      AND PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM ';
    strSQL := strSQL + '      AND PROEMP.PRO_CODEMP = '+ VS_strCodEmp;
    strSQL := strSQL + '      AND IPR_CODITE = T.ETI_CODITE ';
    strSQL := strSQL + '      AND CURDATE() BETWEEN PRO_DTAINI ';
    strSQL := strSQL + '      AND PRO_DTAFIN ';
    strSQL := strSQL + '    ORDER BY PRO_DTAINI, ';
    strSQL := strSQL + '      PRO_DTAFIN ';
    strSQL := strSQL + '    LIMIT 1), ';
    strSQL := strSQL + '    0 ';
    strSQL := strSQL + '  ) AS ITE_PREPRA, ';

     strSQL := strSQL + '  ROUND(((IFNULL( ';
    strSQL := strSQL + '    (SELECT ';
    strSQL := strSQL + '      IPR_PREVEN ';
    strSQL := strSQL + '    FROM ';
    strSQL := strSQL + '      CADPRO, ';
    strSQL := strSQL + '      PROEMP, ';
    strSQL := strSQL + '      ITEPRO ';
    strSQL := strSQL + '    WHERE CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
    strSQL := strSQL + '      AND PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM ';
    strSQL := strSQL + '      AND PROEMP.PRO_CODEMP = '+ VS_strCodEmp;
    strSQL := strSQL + '      AND IPR_CODITE = T.ETI_CODITE ';
    strSQL := strSQL + '      AND CURDATE() BETWEEN PRO_DTAINI ';
    strSQL := strSQL + '      AND PRO_DTAFIN ';
    strSQL := strSQL + '    ORDER BY PRO_DTAINI, ';
    strSQL := strSQL + '      PRO_DTAFIN ';
    strSQL := strSQL + '    LIMIT 1), ';
    strSQL := strSQL + '    0 ';
    strSQL := strSQL + '  )' + IfThen(RadTipoAlteracao.ItemIndex = 0, ' * ', ' - ') + strValAcr + ')/' + IIF(edtQtdPar.Text = '', '1', edtQtdPar.Text ) + '),2) AS ITE_VALPAR, ';
  end
  else
  begin
    strSQL := strSQL + '  G.ITE_PREVE' + IntToStr(FPrePra) + ' AS ITE_PREPRA, ';

    If RadTipoAlteracao.ItemIndex = 0 Then
      strSQL := strSQL + '  ROUND(((G.ITE_PREVE' + IIF(FPrePra = 0,'1',IntToStr(FPrePra)) + ' * ' +  strValAcr +  ')/' + IIF(edtQtdPar.Text = '', '1', edtQtdPar.Text ) + '),2) AS ITE_VALPAR, '
    Else
      strSQL := strSQL + '  ROUND(((G.ITE_PREVE' + IIF(FPrePra = 0,'1',IntToStr(FPrePra)) + ' + ' +  strValAcr +  ')/' + IIF(edtQtdPar.Text = '', '1', edtQtdPar.Text ) + '),2) AS ITE_VALPAR, ';
  end;

  strSQL := strSQL + '"' + edtQtdPar.Text + '"' + ' AS ITE_PARCEL, ';
  strSQL := strSQL + '  E.*,  ';
  strSQL := strSQL + '  U.UNI_SIGUNI, ';
  strSQL := strSQL + '  I.ITE_EMBALA AS ITE_EMBALA, ';
  strSQL := strSQL + '  T.ETI_SEQETI AS SEQETI ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEETI T ';
  strSQL := strSQL + '  LEFT JOIN ITEGER G ON G.ITE_CODITE = T.ETI_CODITE ';
  strSQL := strSQL + '  LEFT JOIN CADITE I ON I.ITE_CODITE = T.ETI_CODITE ';
  strSQL := strSQL + '  LEFT JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';
  strSQL := strSQL + '  LEFT JOIN CADEMP E ON E.EMP_CODEMP = G.ITE_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CADLOT L ON L.LOT_CODEMP = G.ITE_CODEMP ';
  strSQL := strSQL + '                    AND L.LOT_CODITE = T.ETI_CODITE ';
  If fDocumentoInformado Then
    strSQL := strSQL + '  INNER JOIN  MOVDET ON DET_CODITE = G.ITE_CODITE AND DET_CODEMP = G.ITE_CODEMP ';
  strSQL := strSQL + '  WHERE T.ETI_CODOPE = ' + QuotedStr(strLoginUsuarioLogado);
  strSQL := strSQL + '  AND G.ITE_CODEMP = ' + VS_strCodEmp;

  if ((FPreco = 0) or (FPrePra = 0)) then
  begin

    strSQL := strSQL + ' AND (SELECT ';
    strSQL := strSQL + '      COUNT(IPR_PREVEN) ';
    strSQL := strSQL + '    FROM ';
    strSQL := strSQL + '      CADPRO, ';
    strSQL := strSQL + '      PROEMP, ';
    strSQL := strSQL + '      ITEPRO ';
    strSQL := strSQL + '    WHERE CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
    strSQL := strSQL + '      AND PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM ';
    strSQL := strSQL + '      AND PROEMP.PRO_CODEMP = '+ VS_strCodEmp;
    strSQL := strSQL + '      AND IPR_CODITE = T.ETI_CODITE ';
    strSQL := strSQL + '      AND CURDATE() BETWEEN PRO_DTAINI AND PRO_DTAFIN ) > 0 ';

  end;

  Result := strSQL;
end;

function TfrmRelEtiPrecificacao.fRetQtdSel: Integer;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try
    qryGenTmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' SELECT SUM(ITEETI.ETI_QTDETI) AS QTD FROM ITEETI ';
    strSQL := strSQL + ' WHERE ETI_CODOPE = ' + QuotedStr(strLoginUsuarioLogado);

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      Result := FieldByName('QTD').AsInteger;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

procedure TfrmRelEtiPrecificacao.edtCodBarraKeyPress(Sender: TObject;
  var Key: Char);
  var
    qryConsulta: TUniQuery;
begin
  inherited;
  If Key = #13 Then
  Begin
    If Not(fEmptyStr(edtCodBarra.Text)) Then
    Begin
      SetLength(arrCodBar, 0);
      qryConsulta:= fCriaQuery;
      qryConsulta.Close;
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('SELECT ITE_CODITE, ITE_CODBAR, ITE_DESITE FROM CADITE WHERE (LOCATE(:CODBAR, ITE_BARRAS) > 0 ) ');
      qryConsulta.ParamByName('CODBAR').AsString:= edtCodBarra.Text;
      qryConsulta.Open;

      If (qryConsulta.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Código de Barras não encontrado!', ['&Ok']);
        edtCodBarra.Text       := '';
        edtDesIte.Text         := '';
        edtCodIte.Text         := '';
        edtCodIte.ReadOnly     := False;

        pSetFocus(edtCodBarra);
        Exit;
      End
      Else
      Begin
        edtCodBarra.Text       := qryConsulta.FieldByName('ITE_CODBAR').AsString;
        edtDesIte.Text         := qryConsulta.FieldByName('ITE_DESITE').AsString;
        edtCodIte.Text         := qryConsulta.FieldByName('ITE_CODITE').AsString;
        edtCodIte.ReadOnly     := True;

        SetLength(arrCodBar, 1);
        arrCodBar[0].strCodigo:= edtCodBarra.Text;
        arrCodBar[0].strDescri:= edtDesIte.Text;
      End;

    End
    Else
    Begin
      edtCodBarra.Text       := '';
      edtDesIte.Text         := '';
      edtCodIte.Text         := '';
    End;
  End;

end;

procedure TfrmRelEtiPrecificacao.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor,edtNomFor,arrFornec,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmRelEtiPrecificacao.edtCodForKeyPress(Sender: TObject; var Key: Char);
Var
  blnEditCodForDoc: Boolean;
begin
  inherited;

  blnEditCodForDoc := TEditFocus(Sender).Name = edtCodForDoc.Name;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If blnEditCodForDoc Then
  Begin
    If fPesqFornecedor(conForSimples, Self, edtCodForDoc, edtNomForDoc, Nil, Key, arrFornec, False) Then
    Begin
      fValidaCampos(edtCodForDoc,False);
      Self.SelectNext(ActiveControl, True, True);
    End;
  End
  Else
  Begin
    If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, False) Then
    Begin
      fValidaCampos(edtCodFor,False);
      Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmRelEtiPrecificacao.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar,edtDesMar,arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmRelEtiPrecificacao.edtCodMarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEtiPrecificacao.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte,edtDesIte,arrItem,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmRelEtiPrecificacao.edtCodIteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrItem, False, nil, 'Consultas de Itens', '1') Then
  Begin
    fValidaCampos(edtCodIte,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEtiPrecificacao.edtLocFisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If blnCadLoc And fPesqLocFisica(Self, edtLocFis, nil, nil, Key, arrSel) And
     fValidaCampos(edtLocFis, True) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmRelEtiPrecificacao.fImprimeLaserArgox: Boolean;
  Var
    prmDllRel: TParamDllEtiquetas;
begin

  prmDllRel := TParamDllEtiquetas.Create;
// prmDllRel.cdsPromoc := cdsPromoc;
  prmDllRel.cdsCodBar := cdsCodBar;
  prmDllRel.cdsArmaze := cdsArmaze;
  prmDllRel.strTipoAlter := RadTipoAlteracao.ItemIndex;
  prmDllRel.TipoOrigemEtiquetaAbreItens := toeabiPrecificao;
  With prmDllRel Do
  Begin
    If (strEtiPrp = 'L') Then
      tpeTipEtq := tpePrecificacaoProdutosLaser
    Else
      tpeTipEtq := tpePrecificacaoProdutosArgox;

    intTabPre := FPreco;
    intTabPra := FPrePra;
    intParcel := StrToInt(edtQtdPar.Text);
    strCamBus := ShortString(stlCampos[intIndBusca]);
    strNomFrm := Self.Name;
  End;

  prmDllRel.strValDes := strValDes;
  prmDllRel.strValAcr := strValAcr;

  Result := fImprimeEtiqueta(prmDllRel, 'fimprimeetiquetaitens');

  FreeAndNil(prmDllRel);

end;
 
procedure TfrmRelEtiPrecificacao.dbgEtiquetasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If  (Column.Field.DataSet.FieldByName('ITE_ITEATI').AsString = 'I') Then
    dbgEtiquetas.Canvas.Font.Color := clRed
  Else
    dbgEtiquetas.Canvas.Font.Color := clBlack;

  dbgEtiquetas.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmRelEtiPrecificacao.pEscolheTabelaPreco;
begin

  If (cmbPreVis.Text = 'Tabela de Preço 1') Then
    FPreco := 1
  Else If (cmbPreVis.Text = 'Tabela de Preço 2') Then
    FPreco := 2
  Else If (cmbPreVis.Text = 'Tabela de Preço 3') Then
    FPreco := 3
  Else If (cmbPreVis.Text = 'Tabela de Preço 4') Then
    FPreco := 4
  Else If (cmbPreVis.Text = 'Tabela de Preço 5') Then
    FPreco := 5
  Else If (cmbPreVis.Text = 'Tabela de Preço 6') Then
    FPreco := 6
  Else If (cmbPreVis.Text = 'Tabela de Preço 7') Then
    FPreco := 7
  Else  {Tabela de Promoção}
    FPreco := 0
end;

procedure TfrmRelEtiPrecificacao.pEscolheTabelaPrecoPrazo;
begin
  If (cmbPrePra.Text = 'Tabela de Preço 1') Then
    FPrePra := 1
  Else If (cmbPrePra.Text = 'Tabela de Preço 2') Then
    FPrePra := 2
  Else If (cmbPrePra.Text = 'Tabela de Preço 3') Then
    FPrePra := 3
  Else If (cmbPrePra.Text = 'Tabela de Preço 4') Then
    FPrePra := 4
  Else If (cmbPrePra.Text = 'Tabela de Preço 5') Then
    FPrePra := 5
  Else If (cmbPrePra.Text = 'Tabela de Preço 6') Then
    FPrePra := 6
  Else If (cmbPrePra.Text = 'Tabela de Preço 7') Then
    FPrePra := 7
  Else  {Tabela de Promoção}
    FPrePra := 0
end;

procedure TfrmRelEtiPrecificacao.pCarregaTabelaPrecosVista;
  Var
    intCont: Integer;
begin
  cmbPreVis.Items.Clear;

  cmbPreVis.Items.Add('Tabela de Promoção');

  For intCont := 1 To Length(Trim(VS_strTabPrc)) Do
  Begin
    If (VS_strTabPrc[intCont] = 'S') Then
      cmbPreVis.Items.Add('Tabela de Preço ' + IntToStr(intCont));
  End;
end;

procedure TfrmRelEtiPrecificacao.pCarregaTabelaPrecosPrazo;
  Var
    intCont: Integer;
begin
  cmbPrePra.Items.Clear;

  cmbPrePra.Items.Add('Tabela de Promoção');

  For intCont := 1 To Length(Trim(VS_strTabPrc)) Do
  Begin
    If (VS_strTabPrc[intCont] = 'S') Then
      cmbPrePra.Items.Add('Tabela de Preço ' + IntToStr(intCont));
  End;
end;

procedure TfrmRelEtiPrecificacao.pLimparFiltros;
Begin
  inherited;
  mskLinGru.Clear;
  edtDesGru.Clear;
  pDesmarcaLista(mskLinGru, arrLinGru, '', 6);
  edtCodIte.Clear;
  edtDesIte.Clear;
  pDesmarcaLista(edtCodIte, arrItem);
  edtCodMar.Clear;
  edtDesMar.Clear;
  pDesmarcaLista(edtCodMar, arrMarca);
  edtRefere.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
  pDesmarcaLista(edtCodFor, arrFornec);
  edtDescri.Clear;
  edtLocFis.Clear;
  rdgStatus.ItemIndex := 2;
  cmbPreVis.ItemIndex := -1;
  cmbPrePra.ItemIndex := -1;
  edtQtdPar.Clear;
  edtPerDes.Clear;
  edtPerAcr.Clear;
  edtQtdEtq.Clear;
  edtTotEti.Clear;
  edtNumDoc.Clear;
  edtEspDoc.Text := 'NF';
  edtSerie.Clear;
  edtCodForDoc.Clear;
  edtNomForDoc.Clear;
  edtCodBarra.Clear;
  edtCodIte.Clear;
  edtCodIte.Enabled:= True;
  edtCodIte.Color := clWindow;
  pDesmarcaLista(edtCodBarra, arrCodBar);
  rdgSaldo.ItemIndex := 2;
End;

Procedure TfrmRelEtiPrecificacao.pHabilitaLocFis(blnHabili: Boolean);
Begin
  lblLocFis.Enabled := blnHabili;
  edtLocFis.Enabled := blnHabili;

  If Not blnHabili Then
  Begin
    edtLocFis.Clear;
  End;

End;
  {*************************************************}
  {* DESMARCA TODAS AS ETIQUETAS DO ÚLTIMO FILTRO  *}
  {**********************************************MA*}

function TfrmRelEtiPrecificacao.fDesmarcar: boolean;
begin
  Result := fMarca(fRetornaSQLDesmarcaIte, True);
end;

Function TfrmRelEtiPrecificacao.fMarca(strSql: string; blnDesmarcar: Boolean = False): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;
    Try
      Result := True;
      With qryGen Do
      Begin
        Close;
        SQL.Text := strSQL;
        If not blnDesmarcar Then
          pSetParamsItens(qryGen);
        ExecSQL;
      End;
    Except
      Result := False;
    End;
  Finally
    FreeAndNil(qryGen);
  End; 

End;

end.


