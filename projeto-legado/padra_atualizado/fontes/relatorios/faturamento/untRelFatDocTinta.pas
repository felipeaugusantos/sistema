unit untRelFatDocTinta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiRelatorio,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, frxDesgn, frxClass,
  frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS,
  frxExportRTF, RLFilters, RLDraftFilter, Vcl.ExtCtrls, Vcl.StdCtrls, EditFocus,
  QColorLabel, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, Uni, DB,
  UniClientDataSet, untGeraExcel, Vcl.ComCtrls, StrUtils, untITintasDeMaquina,
  Datasnap.DBClient, untTSelecionaTinta;

type
  TfrmRelFatDocTinta = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label1: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    cdsFormulacao: TUniClientDataSet;
    cdsFormulacaoNUMDOC: TStringField;
    cdsFormulacaoESPDOC: TStringField;
    cdsFormulacaoCODCLI: TStringField;
    cdsFormulacaoDTAENT: TDateField;
    cdsFormulacaoIDEPRO: TStringField;
    cdsFormulacaoTINTA: TStringField;
    cdsFormulacaoDESCRI: TStringField;
    cdsFormulacaoVALOR: TFloatField;
    cdsFormulacaoUNIDAD: TStringField;
    cdsFormulacaoNOMCLI: TStringField;
    frxQckJatoTinta: TfrxReport;
    cdsFormulacaoQTDITE: TFloatField;
    pbProgresso: TProgressBar;
    frxQckMatricial: TfrxReport;
    Label4: TLabel;
    edtTintasDisp: TEditFocus;
    edtDesTinta: TEditFocus;
    gpbEspecie: TGroupBox;
    ColorLabel2: TColorLabel;
    edtEspecie: TEditFocus;
    cdsFormulacaoVENDEDOR: TStringField;
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtTintasDispKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryCadEmp: TUniQuery;
    iTintas: ITintasDeMaquina;

    procedure pInicializaQuerys;
    procedure pCarregaEmpresa(strCodEmp: String);
    procedure pAdicionaNaTemporaria(qryFatDor: TUniQuery);
    procedure pGeraRelatorio;
    procedure pGeraExcel;
    procedure pAbreQueryRelatorio(qryFatDor: TUniQuery);
    procedure pProcessaQueryRelatorio(qryFatDor: TUniQuery);

    function fExisteDivergencia(qryFatDor: TUniQuery): Boolean;
    function fTintaPossuiMD5(qryFatDor: TUniQuery): Boolean;
    function fRetornaTabelaTinta(strIdePro: String): String;
    function fRetornaTabelaExcecao(strIdePro: String): String;
    function fRetornaCampoTabelaTinta(strIdePro: String): String;
    function fLocalizouAFormulacao(qryFatDor: TUniQuery): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

implementation

uses
  untTypesSistema, untConsultas, untFuncoesSimples, untPesqAux, untFuncTinta,
  untCfgRel;

{$R *.dfm}

procedure TfrmRelFatDocTinta.btnImprimirClick(Sender: TObject);
var
  qryFatDor: TUniQuery;
begin
  Try
    Try
      inherited;
      Screen.Cursor := crHourGlass;
      qryFatDor := fCriaQuery(Self);

      If blnImprime Then
      Begin
        pAbreQueryRelatorio(qryFatDor);

        pProcessaQueryRelatorio(qryFatDor);

        pGeraRelatorio;
      End;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    Screen.Cursor := crDefault;
    btnImprimir.Enabled := True;
    pSetFocus(mskDtaIni);

    cdsFormulacao.EmptyDataSet;
    If Assigned(qryFatDor) Then pFreeAndNil(qryFatDor);
  End;
end;

procedure TfrmRelFatDocTinta.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatDocTinta.edtDestinoExit(Sender: TObject);
begin
  If (edtDestino.Text <> 'E') Then
    inherited;
end;

procedure TfrmRelFatDocTinta.edtTintasDispKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Key := #0;
    edtTintasDisp.Text := fEscolheTintaNovo('');

    If fValidaCampos(edtTintasDisp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelFatDocTinta.fExisteDivergencia(qryFatDor: TUniQuery): Boolean;
begin
  Result := False;
  If fTintaPossuiMD5(qryFatDor) Then
    Result := Not fLocalizouAFormulacao(qryFatDor);
end;

function TfrmRelFatDocTinta.fLocalizouAFormulacao(
  qryFatDor: TUniQuery): Boolean;
var
  qryFormul: TUniQuery;
begin
  Try
    qryFormul := fCriaQuery;
    With qryFormul Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT TRUE');
      SQL.Add('  FROM ' + fRetornaTabelaTinta(qryFatDor.FieldByName('FDO_IDEPRO').AsString));
      SQL.Add(' WHERE ' + fRetornaCampoTabelaTinta(qryFatDor.FieldByName('FDO_IDEPRO').AsString) + ' = :MD5KEY');
      ParamByName('MD5KEY').AsString := qryFatDor.FieldByName('FDO_ITETIN').AsString;
      Open;

      Result := Not IsEmpty;
    End;
  Finally
    FreeAndNil(qryFormul);
  End;
end;

procedure TfrmRelFatDocTinta.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmRelFatDocTinta.FormShow(Sender: TObject);
begin
  pInicializaQuerys;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

  iTintas := fGetTintasdeMaquina;
  inherited;

end;

function TfrmRelFatDocTinta.fRetornaCampoTabelaTinta(strIdePro: String): String;
begin
  Result := strIdePro + '_MD5KEY';

  If strIdePro = 'LKS' Then
    Result := 'LKD_MD5KEY'
  Else If strIdePro = 'WCP' Then
    Result := 'WAN_MD5KEY'
  Else If strIdePro = 'LAZ' Then
    Result := 'MIX_CODIGO'
  Else If strIdePro = 'CIM' Then
    Result := 'COR_MD5KEY';
end;

function TfrmRelFatDocTinta.fRetornaTabelaExcecao(strIdePro: String): String;
begin
  Result := '';

  If strIdePro = 'CIM' Then
    Result := 'CORIMO_CADCOR'
  Else If strIdePro = 'WCP' Then
    Result := 'WANPRO_CADWAN'
  Else If strIdePro = 'LKS' Then
    Result := 'LKD_CADLKD'
  Else If strIdePro = 'LAZ' Then
    Result := 'LAZ_CADMIX';
end;

function TfrmRelFatDocTinta.fRetornaTabelaTinta(strIdePro: String): String;
begin
  Result := strIdePro + '_CAD' + strIdePro;

  If Not fTabelaExiste(Result) Then
    Result := fRetornaTabelaExcecao(strIdePro);
end;

function TfrmRelFatDocTinta.fTintaPossuiMD5(qryFatDor: TUniQuery): Boolean;
begin
  Result := fCampoExiste(fRetornaTabelaTinta(qryFatDor.FieldByName('FDO_IDEPRO').AsString),
                         fRetornaCampoTabelaTinta(qryFatDor.FieldByName('FDO_IDEPRO').AsString));
end;

function TfrmRelFatDocTinta.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  {*********************}
  {* VALIDA DATAS      *}
  {******************LU*}
  If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else
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
      End
    End;

  End

  Else If (Sender = edtCodEmpresa) Then
  Begin
    If fEmptyStr(edtCodEmpresa.Text) Then
    Begin
      edtDesEmpresa.Text := 'TODAS';
    End
    Else
    Begin
      pCarregaEmpresa(edtCodEmpresa.Text);
      If (qryCadEmp.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!','Essa empresa não está cadastrada!',['&O K']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtEspecie) Then
  Begin
    If (Pos(edtEspecie.Text, 'PD_OR_') <= 0) Then
    Begin
      fMensAgem('ATENÇÃO!', 'O Campo espécie deve ser preenchido com P ou O', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = edtTintasDisp) Then
  Begin

    If fEmptyStr(edtTintasDisp.Text) Then
    Begin
      edtDesTinta.Text := 'TODAS';
    End
    Else
    Begin
      If Not iTintas.fEstaDisponivel(edtTintasDisp.Text) Then
      Begin
        fMensagem('ATENÇÃO!','Essa Tinta não está disponível!',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesTinta.Text := iTintas.fGetNomeTinta(edtTintasDisp.Text);
      End;
    End;

  End
end;

procedure TfrmRelFatDocTinta.pAbreQueryRelatorio(qryFatDor: TUniQuery);
begin
  With qryFatDor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT FDO_IDEPRO,         ');
    SQL.Add('        FDO_ITETIN,         ');
    SQL.Add('        FDO_NUMDOC,         ');
    SQL.Add('        FDO_ESPDOC,         ');
    SQL.Add('        FDO_CODCLI,         ');
    SQL.Add('        FDO_CODEMP,         ');
    SQL.Add('        FDO_DESCRI,         ');
    SQL.Add('        FDO_DTAENT,         ');
    SQL.Add('        FDO_QTDITE,         ');
    SQL.Add('        FDO_TOTITE,         ');
    SQL.Add('        FDO_UNIDAD,         ');
    SQL.Add('        CONCAT(OPE_CODOPE, "-", OPE_NOMOPE) AS FDO_NOMVEN,        ');
    SQL.Add('        CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS FDO_NOMCLI         ');
    SQL.Add('   FROM FATDOR              ');
    SQL.Add('  INNER JOIN CADCLI ON CLI_CODCLI = FDO_CODCLI');
    SQL.Add('  INNER JOIN CADOPE ON OPE_CODOPE = FDO_CODVEN');
    SQL.Add('  WHERE FDO_JAFATU = 0      ');
    SQL.Add('    AND FDO_IDEPRO <> "NOR" ');
    SQL.Add('    AND FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN ');

    If Not fEmptyStr(edtTintasDisp.Text) Then
      SQL.Add('  AND FDO_IDEPRO = :IDEPRO ');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      SQL.Add('  AND FDO_CODEMP = :CODEMP ');

    If Not fEmptyStr(edtEspecie.Text) Then
      SQL.Add('  AND FDO_ESPDOC = :ESPDOC ');

    qryFatDor.ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
    qryFatDor.ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);

    If Not fEmptyStr(edtTintasDisp.Text) Then
      qryFatDor.ParamByName('IDEPRO').AsString := edtTintasDisp.Text;

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      qryFatDor.ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

    If Not fEmptyStr(edtEspecie.Text) Then
      qryFatDor.ParamByName('ESPDOC').AsString := IIF(edtEspecie.Text = 'P', 'PD', 'OR');

    Open;
  End;
end;

procedure TfrmRelFatDocTinta.pAdicionaNaTemporaria(qryFatDor: TUniQuery);
begin
  cdsFormulacao.Append;
  cdsFormulacaoNUMDOC.AsString   := qryFatDor.FieldByName('FDO_NUMDOC').AsString;
  cdsFormulacaoESPDOC.AsString   := qryFatDor.FieldByName('FDO_ESPDOC').AsString;
  cdsFormulacaoCODCLI.AsString   := qryFatDor.FieldByName('FDO_CODCLI').AsString;
  cdsFormulacaoNOMCLI.AsString   := qryFatDor.FieldByName('FDO_NOMCLI').AsString;
  cdsFormulacaoDTAENT.AsDateTime := qryFatDor.FieldByName('FDO_DTAENT').AsDateTime;
  cdsFormulacaoIDEPRO.AsString   := qryFatDor.FieldByName('FDO_IDEPRO').AsString;
  cdsFormulacaoTINTA.AsString    := fRetornaNomeTinta(qryFatDor.FieldByName('FDO_IDEPRO').AsString);
  cdsFormulacaoDESCRI.AsString   := qryFatDor.FieldByName('FDO_DESCRI').AsString;
  cdsFormulacaoQTDITE.AsFloat    := qryFatDor.FieldByName('FDO_QTDITE').AsFloat;
  cdsFormulacaoVALOR.AsFloat     := qryFatDor.FieldByName('FDO_TOTITE').AsFloat;
  cdsFormulacaoUNIDAD.AsString   := qryFatDor.FieldByName('FDO_UNIDAD').AsString;
  cdsFormulacaoVENDEDOR.AsString := qryFatDor.FieldByName('FDO_NOMVEN').AsString;
  cdsFormulacao.Post;
end;

procedure TfrmRelFatDocTinta.pCarregaEmpresa(strCodEmp: String);
begin
  pPesquisaCadEmp(Nil, qryCadEmp, edtCodEmpresa.Text);
  edtDesEmpresa.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmRelFatDocTinta.pGeraExcel;
  Var
    objGeraExcel: TGeraExcel;
begin
  Try
    objGeraExcel := TGeraExcel.Create(cdsFormulacao, pbProgresso);

    objGeraExcel.strNomRel := 'FORMULAÇÃO DE DOCUMENTOS - TINTA DE MÁQUINA';

    objGeraExcel.AddFiltro('REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);
    objGeraExcel.AddFiltro('EMPRESA: ' + IIF(fEmptyStr(edtCodEmpresa.Text),  'TODAS', edtCodEmpresa.Text  + ' - ' + edtDesEmpresa.Text));

    objGeraExcel.AddCampo('NUMDOC', 'DOCUMENTO');
    objGeraExcel.AddCampo('ESPDOC', 'ESPÉCIE');
    objGeraExcel.AddCampo('NOMCLI', 'CLIENTE');
    objGeraExcel.AddCampo('DTAENT', 'DATA ENTRADA');
    objGeraExcel.AddCampo('TINTA',  'TINTA');
    objGeraExcel.AddCampo('DESCRI', 'DESCRIÇÃO');
    objGeraExcel.AddCampo('QTDITE', 'QUANTIDADE');
    objGeraExcel.AddCampo('VALOR',  'VALOR');

    objGeraExcel.AddQuebra('VENDEDOR', 'VENDEDOR: ');
    objGeraExcel.AddQuebra('TINTA', 'TINTA: ');

    If objGeraExcel.fGerarRelatorio Then
      fMensagem('','Arquivo excel gerado com sucesso!',['&OK']);

  Finally
    FreeAndNil(objGeraExcel);
  End;
end;

procedure TfrmRelFatDocTinta.pGeraRelatorio;
var
  qckRel: TfrxReport;
  strNomeFila : String;
  strTipImp   : String;
begin
  If cdsFormulacao.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'Não há dados para gerar o relatório.', ['&Ok']);
    Exit;
  End;

  If (edtDestino.Text = 'E') Then
  Begin
    pGeraExcel;
  End
  Else
  Begin
    frxRelatorio.DataSet := cdsFormulacao;

    pCarregaConfImpr(qryCfgRel, Self.Name);
    strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
    strTipImp   := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

    If (strTipImp = 'M') Then
      qckRel := frxQckMatricial
    Else
      qckRel := frxQckJatoTinta;

    qckRel.Script.Variables['PERIODO'] := 'PERIODO...: ' + mskDtaIni.Text + ' a ' + mskDtaFin.Text;
    qckRel.Script.Variables['EMPRESA'] := 'EMPRESA...: ' + IIF(fEmptyStr(edtCodEmpresa.Text), '', edtCodEmpresa.Text + '-') + edtDesEmpresa.Text;
    qckRel.Script.Variables['TINTA']   := 'TINTA.....: ' + IIF(fEmptyStr(edtTintasDisp.Text), '', edtTintasDisp.Text + '-') + edtDesTinta.Text;
    qckRel.Script.Variables['ESPECIE'] := 'ESPÉCIE...: ' + IIF(fEmptyStr(edtEspecie.Text)   , '', IIF(edtEspecie.Text = 'P', 'PD', 'OR'));

    qckRel.PrintOptions.Printer := AnsiReplaceText(strNomeFila, '\\' + fRetNomeRede + '\', '');
    qckRel.PrepareReport;

    If (edtDestino.Text = 'V') Then
    Begin
      pPreviewReport(Self.Name, Self.Caption, qckRel)
    End
    Else
    Begin
      pPrintReport(Self.Name, Self.Caption, strNomImp, qckRel);
    End;
  End;
end;

procedure TfrmRelFatDocTinta.pInicializaQuerys;
begin
  qryCadEmp := fCriaQuery(Self);
  cdsFormulacao.CreateDataSet;
  cdsFormulacao.IndexFieldNames := 'VENDEDOR;TINTA';
end;

procedure TfrmRelFatDocTinta.pProcessaQueryRelatorio(qryFatDor: TUniQuery);
begin
  qryFatDor.First;
  While Not qryFatDor.Eof Do
  Begin
    If fExisteDivergencia(qryFatDor) Then
      pAdicionaNaTemporaria(qryFatDor);

    qryFatDor.Next;
  End;
end;

end.
