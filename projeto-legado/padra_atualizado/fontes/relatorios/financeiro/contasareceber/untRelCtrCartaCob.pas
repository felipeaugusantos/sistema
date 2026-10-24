unit untRelCtrCartaCob;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Mask, MaskEditFocus, RLFilters, RLDraftFilter,
  Menus, StdCtrls, EditFocus, QColorLabel, Buttons, ExtCtrls, RLReport,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, DB,  ComObj, untTypesSistema, Math,
   Uni, UniClientDataSet, AppEvnts, BitBtnLockedIncrem, ComCtrls,
  DBCtrls, DBLookupComboBoxFocus, WordXP, CurrencyEditFocus, UniDataSetProvider,
  untFuncoesSimples, untFuncoesGenerica, MemDS, DBAccess, frxExportCSVTestabilidade,
  TypesRel, System.StrUtils, cxGraphics, cxControls, cxLookAndFeels, cxProgressBar,
  cxLookAndFeelPainters, cxContainer, cxEdit, Datasnap.DBClient, cxTextEdit, cxCurrencyEdit,
  dxCore, cxDateUtils, cxMaskEdit, cxDropDownEdit, cxCalendar, untTEnvioEmail,untValorPorExtenso;

type
  TfrmRelCartaCob = class(TfrmPaiRelatorio)
    Label1: TLabel;
    edtCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    lblEmpresa: TLabel;
    edtEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label2: TLabel;
    frxEmpresa: TfrxDBDataset;
    qryEmpresa: TUniQuery;
    edtDiasAtraso: TEditFocus;
    edtTaxaJuros: TEditFocus;
    LbJuros: TLabel;
    frxCartaCobranca_M: TfrxReport;
    frxCartaCobranca_J: TfrxReport;
    frxInformacoes: TfrxDBDataset;
    qryInformacoes: TUniClientDataSet;
    qryInformacoesIMAGEM: TStringField;
    qryInformacoesDIRETORIO: TStringField;
    lbPorcentJuros: TLabel;
    Label5: TLabel;
    cbbModelo: TDBLookupComboBoxFocus;
    qryModelos: TUniQuery;
    dtsModelos: TDataSource;
    qryModelosCOB_CODCOB: TStringField;
    qryModelosCOB_NOMCOB: TStringField;
    qryModelosCOB_PATCOB: TStringField;
    edtVlrMin: TCurrencyEditFocus;
    lbl1: TLabel;
    grp1: TGroupBox;
    lbl2: TLabel;
    chkImpEti: TCheckBox;
    edtQtdEti: TEditFocus;
    pnlEndere: TPanel;
    rdbEndCob: TRadioButton;
    rdbEndFat: TRadioButton;
    pnlTipImp: TPanel;
    rdbImpLas: TRadioButton;
    rdbImpMat: TRadioButton;
    shpLiberado: TShape;
    mskEspecie: TMaskEditFocus;
    Label6: TLabel;
    GroupBox1: TGroupBox;
    Label12: TLabel;
    mskDtaIni: TcxDateEdit;
    Label11: TLabel;
    mskDtaFin: TcxDateEdit;
    Label3: TLabel;
    edtPortador: TEditFocus;
    edtDesPortador: TEditFocus;
    rgFormaEnvio: TRadioGroup;
    frxPDFExport: TfrxPDFExport;
    frxDataSetDuplicatasExtCob: TfrxDBDataset;
    cdsModelos: TUniClientDataSet;
    cdsModelosAUTOINCREM: TStringField;
    cdsModelosCOB_NOMCOB: TStringField;
    cdsModelosCOB_PATCOB: TStringField;
    procedure FormShow(Sender: TObject);
    procedure edtClienteExit(Sender: TObject);
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaCliente(Var qryCadCli: TUniQuery);
    procedure edtEmpresaExit(Sender: TObject);
    procedure edtEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function frxCartaCobranca_MUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    function fVirgulaPontoFloatStr(strValor: String): String;
    procedure cbbModeloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkImpEtiClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtPortadorExit(Sender: TObject);
    procedure edtPortadorKeyPress(Sender: TObject; var Key: Char);
    procedure cbbModeloCloseUp(Sender: TObject);
    procedure cbbModeloExit(Sender: TObject);
  private
    { Private declarations }
    qryRelatorio: TUniQuery;
    cdsRelWrd: TUniClientDataSet;
    cdsRelato: TUniClientDataSet;
    dspRelato: TUniDataSetProvider;
    cpuCampos: TCamposUso;
    strNomImp: String;
    strNomPro: string;
    strDesPro: string;
    intColAtu: Integer;
    arrLinhasEti : Array Of String;
    fltPerMul    : Double;
    intTolerancia: Integer;
    thrSincEmail   : TThreadSincronizaEmails;
    blnConfirma: Boolean;
    arrEmp: TConsultasArray;
    arrPortadores: TConsultasArray;
    FPais: TPais;
    function fRemoveAcentoEspecificos(Str:String): String;
    function fGeraCartaCobranca(pgbProgresso: TcxProgressBar): Boolean;
    function fRetornaPathModelo(strCodMod: String): String;
    function fChamaTelaSelecaoImp: Boolean;
    function fClienteSelecionado(strCodCli: String): Boolean;
    procedure pAgrupaPorCliente;
    procedure pImpEtiquetas;
    procedure pImpEtiquetasMatricial;
    function  fImprimeEtiquetaClienteLaser: Boolean;
    function  fRetAutoIncremCliente: String;
    function  fMulta(dtaDtaVen: TDateTime; fltValDup: Double) : Double;

    procedure pAtualizaCamposUso;
    procedure pAtribuiCamposUso;
    procedure pFinalizaCamposUso;

    procedure pImpRegistro;
    procedure pImpArrLinhasEti;
    procedure pHabilitaCamposEtiquetas;

    procedure pCriaQryRelatorio;
    function SelecionaClientes(pgbProgresso: TcxProgressBar): Boolean;
    procedure StepStatusSelecao(pgbStatus: TcxProgressBar);

    function pEnviarEmail(strArquivo, strDestinatario, strNomeDestinatario : String; blnEnviarMensagem: Boolean): Boolean;
    function fRetornaEmailCliente(ADados: TDataset): String;
    function fLoadReport: Boolean;
    function fGeraCartaCobrancaPersonalizada(pgbProgresso: TcxProgressBar): Boolean;
    function fRetornaTotalCorrigido(strCliAnt: String): Real;
    function fRetornaSelectEmp: String;
    function fRetornaSelectOpe: String;
    procedure pCarregaModelos;
    procedure pVerificaFormato;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

implementation

uses untPai, untCtrSelClienteImp, untWord, untModulo, untFuncMacro, untConsultas,
    untCfgRel, untFuncoesEtiquetas, untGravando,untFuncoesConsulta;

{$R *.dfm}

procedure TfrmRelCartaCob.pCarregaModelos;
begin
  qryModelos.Close;
  qryModelos.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryModelos.Open;

  cdsModelos.CreateDataSet;
  cdsModelos.Open;
  cdsModelos.EmptyDataSet;

  qryModelos.First;
  While Not qryModelos.EOF Do
  Begin
    cdsModelos.Append;
    cdsModelosAUTOINCREM.asString := qryModelosCOB_CODCOB.asString;
    cdsModelosCOB_NOMCOB.AsString := qryModelosCOB_NOMCOB.asString;
    cdsModelosCOB_PATCOB.asString := qryModelosCOB_PATCOB.asString;
    cdsModelos.Post;

    qryModelos.Next;
  End;

  If fLoadReport Then
  Begin
    cdsModelos.First;
    cdsModelos.Insert;
    cdsModelosAUTOINCREM.asString := '-1';
    cdsModelosCOB_NOMCOB.AsString := 'Layout Personalizado';
    cdsModelosCOB_PATCOB.asString := '';
    cdsModelos.Post;
  End;

end;

procedure TfrmRelCartaCob.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtTaxaJuros.Text := FloatToStrF(fCfgSis('JURATR', varDouble), ffFixed, 12, 2);
  fltPerMul         := fCfgSis('MULATR', varDouble);
  intTolerancia     := fCfgSis('TOLATR', varInteger);

  edtEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  inherited;
  pCarregaModelos;

  If Not (fVerificaAcessoSistema('COBIMP', strLoginUsuarioLogado)) Then
  Begin
    edtDestino.Text := 'I';
    edtDestino.Enabled := False;
    edtDestino.TabStop := False;
    shpLiberado.Brush.Color := clRed;
  End
  Else
    shpLiberado.Brush.Color := clGreen;

  pHabilitaCamposEtiquetas;

end;

procedure TfrmRelCartaCob.pVerificaFormato;
begin
  If (cbbModelo.KeyValue = '-1') Then
  Begin
    rgFormaEnvio.ItemIndex := 1;
    rgFormaEnvio.Enabled := False;
  End
  Else
  Begin
    rgFormaEnvio.Enabled := True;
  End;
end;

procedure TfrmRelCartaCob.cbbModeloCloseUp(Sender: TObject);
begin
  pVerificaFormato;
end;

procedure TfrmRelCartaCob.cbbModeloExit(Sender: TObject);
begin
  pVerificaFormato;
end;

procedure TfrmRelCartaCob.cbbModeloKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Down) Then
  Begin
    cbbModelo.DropDown;
  End
  Else If (Key = VK_Return) Then
  Begin
    cbbModelo.CloseUp(True);
    pProximoControle(Sender);
  End;
end;

procedure TfrmRelCartaCob.chkImpEtiClick(Sender: TObject);
begin
  inherited;
  pHabilitaCamposEtiquetas;
end;

procedure TfrmRelCartaCob.edtClienteExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCliente.Text) Then
    edtDesCliente.Text := 'TODOS'
  Else
    edtDesCliente.Text := fRetNomCliente(edtCliente.Text);

  If fEmptyStr(edtDesCliente.Text) And (Not fEmptyStr(edtCliente.Text)) Then
  Begin
    fMensagem('AVISO','Código do Cliente não encontrado',['&O K']);
    edtCliente.Clear;
    pSetFocus(edtCliente);
  End;


end;

procedure TfrmRelCartaCob.edtClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCartaCob.pCarregaCliente(Var qryCadCli: TUniQuery);
begin

  If Not (fEmptyStr(edtCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';

end;

procedure TfrmRelCartaCob.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

function TfrmRelCartaCob.pEnviarEmail(strArquivo, strDestinatario, strNomeDestinatario: String; blnEnviarMensagem: Boolean): Boolean;
  Var
    arrArquivos, arrDestinatarios : TStringArray;
begin
  pCriarArrayAnexosEDestinatarios(strArquivo, strDestinatario, arrDestinatarios, arrArquivos);

  Result := TEnvioEmail.EnviarEmailSemMensagemConfirmacao(Self,
                                                          strLoginUsuarioLogado,
                                                          'Carta de Cobrança' + ' - ' + strNomeDestinatario,
                                                          arrDestinatarios,
                                                          [],
                                                          [],
                                                          [IIF(blnEnviarMensagem,'Segue carta de cobrança em anexo.','')],
                                                          arrArquivos,
                                                          False,
                                                          thrSincEmail);
end;

procedure TfrmRelCartaCob.edtEmpresaExit(Sender: TObject);
begin
  inherited;
  // seleção multi empresa com controle dos digitos 000 quando mais de uma empresa
  If Not edtEmpresa.ReadOnly Then
    pEdtCodSelectExit(edtEmpresa, edtDesEmpresa, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);
    fValidaCampos(edtEmpresa, True);
end;

procedure TfrmRelCartaCob.edtEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False,True) Then
  Begin
    If fValidaCampos(edtEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCartaCob.edtPortadorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtPortador, edtDesPortador, arrPortadores, Nil, fRetNomPortador, 'do Portador');

  If fEmptyStr(edtDesPortador.Text) And (Not fEmptyStr(edtPortador.Text)) Then
  Begin
    fMensagem('AVISO','Código do Portador não encontrado',['&O K']);
    edtPortador.Clear;
    pSetFocus(edtPortador);
  End;
end;

procedure TfrmRelCartaCob.edtPortadorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {*     CONSULTA DE PORTADORES  *}
  {****************************RV*}
  If fPesqPortador(conSimples,
                   Self,
                   edtPortador,
                   edtDesPortador,
                   nil,
                   Key,
                   arrPortadores,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False
                   ) then
  Begin
    If (fValidaCampos(edtPortador, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelCartaCob.fRetornaTotalCorrigido(strCliAnt: String): Real;
var
  intRecNo: Integer;
begin
  Result := 0;
  intRecno := cdsRelWrd.RecNo;
  cdsRelWrd.Filtered := False;
  cdsRelWrd.Filter := 'CTR_CODCLI = ' + QuotedStr(strCliAnt);
  cdsRelWrd.Filtered := True;

  cdsRelWrd.First;
  While Not cdsRelWrd.Eof Do
  Begin
    Result := Result + cdsRelWrd.FieldByName('CTR_CORRIGIDO').AsFloat;
    cdsRelWrd.Next;
  End;
  cdsRelWrd.Filtered := False;
  cdsRelWrd.RecNo := intRecno;
end;

function TfrmRelCartaCob.fRetornaSelectEmp: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   EMP_NOMEMP, ';
  Result := Result + '   EMP_NOMFAN, ';
  Result := Result + '   CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT(", ", EMP_ENDCMP)), IF(IFNULL(EMP_BAIRRO,"") = "", "", CONCAT(", ", EMP_BAIRRO))) AS EMP_ENDERE, ';
  Result := Result + '   CONCAT(CID_NOMCID, "-" , CID_ESTADO) AS EMP_CIDADE, ';
  Result := Result + '   CID_NOMCID, ';
  Result := Result + '   EMP_C_G_C_, ';
  Result := Result + '   EMP_FONE01, ';
  Result := Result + '   EMP_F_A_X_, ';
  Result := Result + '   EMP_C_E_P_  ';
  Result := Result + ' FROM   ';
  Result := Result + '   CADEMP ';
  Result := Result + '   JOIN CADCID ON CID_CODCID = EMP_CODCID ';
  Result := Result + ' WHERE    ';
  Result := Result + '   EMP_CODEMP = "' + VS_strCodEmp +  '"  ';
end;

function TfrmRelCartaCob.fRetornaSelectOpe: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   OPE_NOMFAN, ';
  Result := Result + '   OPE_NUMCPF, ';
  Result := Result + '   OPE_NOMOPE ';
  Result := Result + ' FROM   ';
  Result := Result + '   CADOPE ';
  Result := Result + ' WHERE    ';
  Result := Result + '   OPE_CODOPE = "' + strLoginUsuarioLogado +  '"  ';
end;

function TfrmRelCartaCob.fGeraCartaCobranca(pgbProgresso: TcxProgressBar): Boolean;
  Var
    Word: TWord;
    strArqOri : String;
    strArqDes : String;
    strLogCit : String;
    strSQL    : String;
    strCliAnt : String;
    qryEmp    : TUniQuery;
    qryOpe    : TUniQuery;
    intLinha  : Integer;
    intQtdLin : Integer;
    intRecno  : Integer;
    fltTotOri : Double;
    fltTotJur : Double;
    fltTotMul : Double;
    fltTotCor : Double;
    strArqDesHtml: String;
    strEmail: String;
    strNomCli: String;
    LArqDesPdf: String;
    LEnviarPdf:Boolean;
    LstrMensagem : String;

    procedure pGeraCabDuplicatas;
    begin
      intRecno := qryRelatorio.RecNo;
      qryRelatorio.Filtered := False;
      qryRelatorio.Filter := 'CTR_CODCLI = ' + QuotedStr(strCliAnt);
      qryRelatorio.Filtered := True;
      intQtdLin := qryRelatorio.RecordCount + 2;
      intQtdLin := IIF(intQtdLin = 2,3,intQtdLin);
      qryRelatorio.Filtered := False;
      qryRelatorio.RecNo := intRecno;

      Word.pCriaTabela('{{DUPLIC}}', intQtdLin, 7);
      intLinha := 1;

      Word.pCelulaNegrito(intLinha, 1);
      Word.pCelulaEscreve(intLinha, 1, 'DUPLICATA');
      Word.pCelulaNegrito(intLinha, 2);
      Word.pCelulaEscreve(intLinha, 2, 'VENCTO.');
      Word.pCelulaNegrito(intLinha, 3);
      Word.pCelulaEscreve(intLinha, 3, 'DIAS ATRASO');
      Word.pCelulaNegrito(intLinha, 4);
      Word.pCelulaAlignRight(intLinha, 4);
      Word.pCelulaEscreve(intLinha, 4, 'R$ TITULO');
      If fCfgSis('RECCOB', varBoolean) Then
      Begin
        Word.pCelulaNegrito(intLinha, 5);
        Word.pCelulaAlignRight(intLinha, 5);
        Word.pCelulaEscreve(intLinha, 5, 'R$ JUROS');
        Word.pCelulaNegrito(intLinha, 6);
        Word.pCelulaAlignRight(intLinha, 6);
        Word.pCelulaEscreve(intLinha, 6, 'R$ MULTA');
        Word.pCelulaNegrito(intLinha, 7);
        Word.pCelulaAlignRight(intLinha, 7);
        Word.pCelulaEscreve(intLinha, 7, 'R$ CORRIGIDO');
      End;
      Inc(intLinha);
    end;

begin
  Result := false;
  blnConfirma := False;
  strNomCli := '';

  Try
    If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA') Then
      CreateDir(ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA');

    strArqOri := fRetornaPathModelo(cbbModelo.KeyValue);
    strArqOri := AnsiReplaceStr(strArqOri, '"', '');

    If FileExists(strArqOri) Then
    Begin
      strSQL := fRetornaSelectEmp;
      qryEmp := fCriaQuery(Self);
      With qryEmp, SQL Do
      Begin
        Clear;
        Add(strSQL);
        Open;
      End;

      strSQL := fRetornaSelectOpe;
      qryOpe := fCriaQuery(Self);
      With qryOpe, SQL Do
      Begin
        Clear;
        Add(strSQL);
        Open;
      End;

      Word := TWord.fCriarWord(Self);

      With cdsRelWrd   Do
      Begin
        First;
        pgbProgresso.Position := 0;
        pgbProgresso.Properties.Max := RecordCount;
        While Not Eof Do
        Begin

          If (Not fClienteSelecionado(FieldByName('CTR_CODCLI').AsString)) Then
          Begin
            Next;
            StepStatusSelecao(pgbProgresso);
            Application.ProcessMessages;
            Continue;
          End;

          strNomCli := FieldByName('CLI_NOMCLI').AsString;
          strCliAnt := FieldByName('CTR_CODCLI').AsString;
          strEmail  := fRetornaEmailCliente(cdsRelWrd);


          If (edtDestino.Text = 'M') Then
          Begin
            If fEmptyStr(strEmail) Then
            Begin
              fMensagem('AVISO','O cliente '+strNomCli+ ' não possui E-mail cadastrado para envio! ' +#13+
                        'Verifique e tente novamente.',['&OK']);
              Exit;
            End;
          End;

          Screen.Cursor := crHourGlass;
          Application.ProcessMessages;

          fltTotOri := 0;
          fltTotJur := 0;
          fltTotMul := 0;
          fltTotCor := 0;

          strArqDes     := ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA\CARTA_DE_COBRANCA_' + FormatDateTime('yyyymmdd', Date) + '-' + FieldByName('CTR_CODCLI').AsString + '.doc';
          strArqDesHtml := ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA\CARTA_DE_COBRANCA_' + FormatDateTime('yyyymmdd', Date) + '-' + FieldByName('CTR_CODCLI').AsString + '.html';
          LArqDesPdf    := ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA\CARTA_DE_COBRANCA_' + FormatDateTime('yyyymmdd', Date) + '-' + FieldByName('CTR_CODCLI').AsString + '.pdf';

          If FileExists(strArqDes) Then
            DeleteFile(strArqDes);

          If FileExists(LArqDesPdf) Then
            DeleteFile(LArqDesPdf);

          // se não conseguiu apagar o arquivo já existente segnifica que o mesmo
          // está sendo usado por outro processo, sendo assim crio um novo arquivo
          // para a rotina não apresentar erros.

          If FileExists(LArqDesPdf) Then
            LArqDesPdf:= ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA\CARTA_DE_COBRANCA_' + FormatDateTime('yyyymmdd', Date) + '-' + FieldByName('CTR_CODCLI').AsString +'-'+FormatDateTime('hhnnss', fNow) + '.pdf';
          If FileExists(strArqDes) Then
            strArqDes := ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA\CARTA_DE_COBRANCA_' + FormatDateTime('yyyymmdd', Date) + '-' + FieldByName('CTR_CODCLI').AsString +'-'+FormatDateTime('hhnnss', fNow) + '.doc';


          CopyFile(pChar(strArqOri), pChar(strArqDes), False);

          If Word = Nil Then
            Exit;

          If Not Word.AbrirArquivo(strArqDes) Then
          Begin
            fMensagem('','Não foi possível abrir o arquivo!',['&OK']);
            Exit;
          End;

          Application.ProcessMessages;

          {*************************************}
          {* VAI PARA O CABEÇALHO DO DOCUMENTO *}
          {**********************************RV*}
          Word.pGoToPageHeader;

          strLogCit := ExtractFilePath(Application.ExeName) + 'CITEL.BMP';

          Word.pInsereImagem(IfThen(FileExists(fCfgSis('PATLOG')), fCfgSis('PATLOG'), strLogCit));

          Word.pReplace('{{NOMEMP}}', qryEmp.FieldByName('EMP_NOMEMP').AsString);
          Word.pReplace('{{CGCEMP}}', fFormataCpfCgc(qryEmp.FieldByName('EMP_C_G_C_').AsString,FPais));
          Word.pReplace('{{CEPEMP}}', fFormataCEP(qryEmp.FieldByName('EMP_C_E_P_').AsString));
          Word.pReplace('{{ENDEMP}}', qryEmp.FieldByName('EMP_ENDERE').AsString);
          Word.pReplace('{{CIDEMP}}', qryEmp.FieldByName('EMP_CIDADE').AsString);
          Word.pReplace('{{FONEMP}}', fFormataFone(qryEmp.FieldByName('EMP_FONE01').AsString));
          Word.pReplace('{{FAXEMP}}', fFormataFone(qryEmp.FieldByName('EMP_F_A_X_').AsString));

          Word.pReplace('{{CLINOM}}', FieldByName('CLI_NOMCLI').AsString);
          Word.pReplace('{{CLIEND}}', FieldByName('CLI_ENDERE').AsString + ', ' +
                                      FieldByName('CLI_ENDNUM').AsString + ' - '+
                                      FieldByName('CLI_ENDCOM').AsString);
          Word.pReplace('{{CLICID}}', FieldByName('CID_NOMCID').AsString);
          Word.pReplace('{{CIDADE}}', FieldByName('CID_CIDADE').AsString);
          Word.pReplace('{{CLIEST}}', FieldByName('CID_ESTADO').AsString);
          Word.pReplace('{{CLICEP}}', fFormataCEP(FieldByName('CLI_C_E_P_').AsString));
          Word.pReplace('{{CLIBAI}}', FieldByName('CLI_BAIRRO').AsString);

          {*************************************}
          {* VAI PARA O CORPO DO DOCUMENTO     *}
          {**********************************RV*}
          Application.ProcessMessages;
          Word.pGoToMainDocument;

          {*************************************}
          {* SUBSTITUI OS TEXTOS DO CORPO      *}
          {**********************************RV*}
          Word.pReplace('{{NOMCID}}', qryEmp.FieldByName('CID_NOMCID').AsString);
          Word.pReplace('{{CLINOM}}', FieldByName('CLI_NOMCLI').AsString);
          Word.pReplace('{{CLIEND}}', FieldByName('CLI_ENDERE').AsString + ', ' +
                                      FieldByName('CLI_ENDNUM').AsString + ' - '+
                                      FieldByName('CLI_ENDCOM').AsString);
          Word.pReplace('{{CLICID}}', FieldByName('CID_NOMCID').AsString);
          Word.pReplace('{{CIDADE}}', FieldByName('CID_CIDADE').AsString);
          Word.pReplace('{{CLIEST}}', FieldByName('CID_ESTADO').AsString);
          Word.pReplace('{{CLICEP}}', fFormataCEP(FieldByName('CLI_C_E_P_').AsString));
          Word.pReplace('{{CLIDOC}}', fFormataCpfCgc(FieldByName('CLI_C_G_C_').AsString, FPais));
          Word.pReplace('{{CLICGC}}', IIF(FieldByName('CLI_CGCCPF').AsString = '1','CNPJ n° ','CPF n° ')+ fFormataCpfCgc(FieldByName('CLI_C_G_C_').AsString, FPais));
          Word.pReplace('{{NOMEMP}}', qryEmp.FieldByName('EMP_NOMEMP').AsString);
          Word.pReplace('{{ENDEMP}}', qryEmp.FieldByName('EMP_ENDERE').AsString);
          Word.pReplace('{{FONEMP}}', fFormataFone(qryEmp.FieldByName('EMP_FONE01').AsString));
          Word.pReplace('{{CLIBAI}}', FieldByName('CLI_BAIRRO').AsString);

          Word.pReplace('{{TOTCOR}}', FormatFloat('R$ #,##0.00', fRetornaTotalCorrigido(strCliAnt)));
          Word.pReplace('{{TOTEXT}}', fRetExtensoNumero(FloatToStr(fRetornaTotalCorrigido(strCliAnt))));
          Word.pReplace('{{CPFOPE}}', fFormataCpfCgc(qryOpe.FieldByName('OPE_NUMCPF').AsString, FPais));
          Word.pReplace('{{NOMFAN}}', qryOpe.FieldByName('OPE_NOMFAN').AsString);
          Word.pReplace('{{NOMOPE}}', qryOpe.FieldByName('OPE_NOMOPE').AsString);

          {*************************************}
          {* CRIA UMA TABELA COM AS DUPLICATAS *}
          {**********************************RV*}
          pGeraCabDuplicatas;

          While (FieldByName('CTR_CODCLI').AsString = strCliAnt) Do
          Begin
            Word.pCelulaEscreve(intLinha, 1, FieldByName('CTR_NUMDUP').AsString);
            Word.pCelulaEscreve(intLinha, 2, FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTAVEN').AsDateTime));
            Word.pCelulaEscreve(intLinha, 3, FieldByName('DIAS_ATRASO').AsString);
            Word.pCelulaAlignRight(intLinha, 4);
            Word.pCelulaEscreve(intLinha, 4, FormatFloat(',0.00', FieldByName('CTR_VALDUP').AsFloat));
            If fCfgSis('RECCOB', varBoolean) Then
            Begin
              Word.pCelulaAlignRight(intLinha, 5);
              Word.pCelulaEscreve(intLinha, 5, FormatFloat(',0.00', FieldByName('CTR_JUROS').AsFloat));
              Word.pCelulaAlignRight(intLinha, 6);
              Word.pCelulaEscreve(intLinha, 6, FormatFloat(',0.00', FieldByName('CTR_MULTA').AsFloat));
              Word.pCelulaAlignRight(intLinha, 7);
              Word.pCelulaEscreve(intLinha, 7, FormatFloat(',0.00', FieldByName('CTR_CORRIGIDO').AsFloat));
              fltTotJur := fltTotJur + FieldByName('CTR_JUROS').AsFloat;
              fltTotMul := fltTotMul + FieldByName('CTR_MULTA').AsFloat;
              fltTotCor := fltTotCor + FieldByName('CTR_CORRIGIDO').AsFloat;
            End;
            fltTotOri := fltTotOri + FieldByName('CTR_VALDUP').AsFloat;
            Next;
            StepStatusSelecao(pgbProgresso);
            Application.ProcessMessages;
            Inc(intLinha);
            If Eof Then
              Break;
          End;

          Application.ProcessMessages;
          Word.pCelulaNegrito(intLinha + 1, 3);
          Word.pCelulaAlignRight(intLinha + 1, 3);
          Word.pCelulaEscreve(intLinha + 1, 3, 'TOTAIS:');
          Word.pCelulaNegrito(intLinha + 1, 4);
          Word.pCelulaAlignRight(intLinha + 1, 4);
          Word.pCelulaEscreve(intLinha + 1, 4, FormatFloat(',0.00', fltTotOri));
          If fCfgSis('RECCOB', varBoolean) Then
          Begin
            Word.pCelulaNegrito(intLinha + 1, 5);
            Word.pCelulaAlignRight(intLinha + 1, 5);
            Word.pCelulaEscreve(intLinha + 1, 5, FormatFloat(',0.00', fltTotJur));
            Word.pCelulaNegrito(intLinha + 1, 6);
            Word.pCelulaAlignRight(intLinha + 1, 6);
            Word.pCelulaEscreve(intLinha + 1, 6, FormatFloat(',0.00', fltTotMul));
            Word.pCelulaNegrito(intLinha + 1, 7);
            Word.pCelulaAlignRight(intLinha + 1, 7);
            Word.pCelulaEscreve(intLinha + 1, 7, FormatFloat(',0.00', fltTotCor));
          End;

          LEnviarPdf := (rgFormaEnvio.ItemIndex = 1);
          Word.pSalvar;

          // Reorganiza as colunas para que o número do documento fique apenas em uma linha
          // Devido à biblioteca do OpenOffice, deve setar o tamanho das colunas
          // da esquerda para a direita, isto é, da coluna maior pra menor
          // Parâmetros: linha, coluna e tamanho sugerido (usado pelo Word - Microsoft)
          // Quando for o OpenOffice irá usar a linha/coluna para otimizar o tamanho
          // pelo seu conteúdo
          Word.pOtimizaTamanho(1,6, 65);
          Word.pOtimizaTamanho(1,5, 65);
          Word.pOtimizaTamanho(1,3, 65);
          Word.pOtimizaTamanho(2,1, 135);

          // exporta carta criada em word/ods para PDF
          If LEnviarPdf Then
            Word.SaveAsPDF(LArqDesPdf);

          If (edtDestino.Text = 'I') Then
            TCfgRel.pPrintReport(Self.Name, ExtractFileName(strArqDes), strNomImp, Word);

          If (edtDestino.Text = 'V') Then
            Word.pSalvar
          Else If (edtDestino.Text = 'M') Then
          begin
            Word.pSaveAsHtml;
          end;

          Try
            Word.pFechar;
          Except

          End;

          Application.ProcessMessages;

          // apaga a carta em word/ods e deixa apenas o pdf exportado
          If LEnviarPdf Then
          Begin
            If FileExists(strArqDes) Then
              DeleteFile(strArqDes);
          End;

          If (edtDestino.Text = 'V') Then
            pExecArquivo(IIF(LEnviarPdf,LArqDesPdf,strArqDes), Handle)
          Else
          If (edtDestino.Text = 'M') Then
          Begin
            {**************************************************************}
            {* SE O ARQUIVO HTML EXITIR, ENVIA A CARTA NO CORPO DO EMAIL, *}
            {* CASO CONTRÁRIO, ENVIA A CARTA DE COBRANÇA COMO ANEXO. ******}
            {*REQ*110852************************************************MO*}
            If Not LEnviarPdf And FileExists(strArqDesHtml) Then
            begin
              If (Not pEnviarEmail(strArqDesHtml, strEmail, strNomCli, False)) Then
              Begin
                Screen.Cursor := crDefault;
                Break;
              End;
            end
            else
            begin
              If (Not pEnviarEmail(IIF(LEnviarPdf,LArqDesPdf,strArqDes), strEmail, strNomCli, True)) Then
              Begin
                Screen.Cursor := crDefault;
                Break;
              End;
            end;
          End;

          Screen.Cursor := crDefault;
        End;
      End;
      //Inicia thread que vai salvar os arquivos dos email's enviados na pasta
      //EmailTemp, e vai sincronizar a pasta enviados no servidor caso use IMAP
      //Essa rotina foi isolada para melhorar o desempenho da mesma
      //que estava muito lenta - MO. 110852 * KP.110123
      if Assigned(thrSincEmail) And (edtDestino.Text = 'M') then
      Begin
        if thrSincEmail.QuantidadeEmails > 0 then
        begin
          thrSincEmail.Start;

          TListaThreadsSincronizaEmails.GetInstance.pAdicionar(thrSincEmail);
        end;
      End;

      FreeAndNil(Word);
      blnConfirma := True;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Modelo de Carta não encontrado!', ['&O k']);
      blnConfirma := False;
    End;
  Except
    On E: Exception Do
    Begin

      If Assigned(Word) Then
      Begin
        Try
          Word.pFechar;
        Except

        End;
        FreeAndNil(Word);
      End;

      blnConfirma := False;

      If pos('A chamada foi rejeitada pelo chamado',E.Message) > 0 Then
      Begin
        LstrMensagem := 'O Word provavelmente está solicitando ativação.'             + #13#10 +
                        'Acesse-o e realize a confirmação/ativação do mesmo,'         + #13#10 +
                        'ou utilize o LibreOffice para gerar corretamente o arquivo!' + #13#10 +
                        'Em dúvida,entrar em contato com a Citel.';

        fMensagem('AVISO!',LstrMensagem, ['&Ok']);
        exit;
      End;

      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmRelCartaCob.fGeraCartaCobrancaPersonalizada(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strSQL    : String;
    strCliAnt : String;
    qryEmp    : TUniQuery;
    strArqDesHtml: String;
    strEmail: String;
    strNomCli: String;
    LArqDesPdf: String;
    LEnviarPdf:Boolean;
begin
  Result := false;
  blnConfirma := False;
  strNomCli := '';

  Try
    If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA') Then
      CreateDir(ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA');

    strSQL := fRetornaSelectEmp;
    qryEmp := fCriaQuery(Self);

    qryEmp.SQL.Clear;
    qryEmp.SQL.Add(strSQL);
    qryEmp.Open;

    cdsRelato.First;
    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := cdsRelato.RecordCount;

    While Not cdsRelato.Eof Do
    Begin

      strNomCli := cdsRelato.FieldByName('CLI_NOMCLI').AsString;
      strCliAnt := cdsRelato.FieldByName('CTR_CODCLI').AsString;
      strEmail  := fRetornaEmailCliente(cdsRelato);


      cdsRelWrd.Filter := 'CLI_CODCLI = ' + cdsRelato.FieldByName('CLI_CODCLI').AsString;
      cdsRelWrd.Filtered := True;
      frxDataSetDuplicatasExtCob.DataSet := cdsRelWrd;

      frxCartaCobranca_J.Script.Variables['NOMCID'] := qryEmp.FieldByName('CID_NOMCID').AsString;
      frxCartaCobranca_J.Script.Variables['NOMEMP'] := qryEmp.FieldByName('EMP_NOMEMP').AsString;
      frxCartaCobranca_J.Script.Variables['EMPFAN'] := qryEmp.FieldByName('EMP_NOMFAN').AsString;
      frxCartaCobranca_J.Script.Variables['CGCEMP'] := fFormataCpfCgc(qryEmp.FieldByName('EMP_C_G_C_').AsString,FPais);
      frxCartaCobranca_J.Script.Variables['CEPEMP'] := fFormataCEP(qryEmp.FieldByName('EMP_C_E_P_').AsString);
      frxCartaCobranca_J.Script.Variables['ENDEMP'] := qryEmp.FieldByName('EMP_ENDERE').AsString;
      frxCartaCobranca_J.Script.Variables['CIDEMP'] := qryEmp.FieldByName('EMP_CIDADE').AsString;
      frxCartaCobranca_J.Script.Variables['FONEMP'] := fFormataFone(qryEmp.FieldByName('EMP_FONE01').AsString);
      frxCartaCobranca_J.Script.Variables['FAXEMP'] := fFormataFone(qryEmp.FieldByName('EMP_F_A_X_').AsString);
      frxCartaCobranca_J.Script.Variables['FANSOB'] := IIF(Not fEmptyStr(cdsRelato.FieldByName('CLI_FANSOB').AsString),
                                                              cdsRelato.FieldByName('CLI_FANSOB').AsString,
                                                              cdsRelato.FieldByName('CLI_NOMCLI').AsString);


      If (edtDestino.Text = 'M') Then
      Begin
        If fEmptyStr(strEmail) Then
        Begin
          fMensagem('AVISO','O cliente '+strNomCli+ ' não possui E-mail cadastrado para envio! ' +#13+
                    'Verifique e tente novamente.',['&OK']);
          Exit;
        End;
      End;

      Screen.Cursor := crHourGlass;
      Application.ProcessMessages;

      strArqDesHtml := ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA\CARTA_DE_COBRANCA_' + FormatDateTime('yyyymmdd', Date) + '-' + cdsRelato.FieldByName('CTR_CODCLI').AsString + '.html';
      LArqDesPdf    := ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA\CARTA_DE_COBRANCA_' + FormatDateTime('yyyymmdd', Date) + '-' + cdsRelato.FieldByName('CTR_CODCLI').AsString + '.pdf';

      If FileExists(LArqDesPdf) Then
        DeleteFile(LArqDesPdf);

      // se não conseguiu apagar o arquivo já existente segnifica que o mesmo
      // está sendo usado por outro processo, sendo assim crio um novo arquivo
      // para a rotina não apresentar erros.

      If FileExists(LArqDesPdf) Then
        LArqDesPdf:= ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA\CARTA_DE_COBRANCA_' + FormatDateTime('yyyymmdd', Date) + '-' + cdsRelato.FieldByName('CTR_CODCLI').AsString +'-'+FormatDateTime('hhnnss', fNow) + '.pdf';

      Application.ProcessMessages;


      LEnviarPdf := (rgFormaEnvio.ItemIndex = 1);

      frxCartaCobranca_J.PrintOptions.ShowDialog := False;

      frxCartaCobranca_J.PrepareReport;
      frxCartaCobranca_J.FileName := LArqDesPdf;

      If (edtDestino.Text <> 'I') Then
      Begin
        frxPDFExport.DefaultPath := ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA\';
        frxPDFExport.FileName    := LArqDesPdf;
        frxPDFExport.ShowDialog  := False;
        frxCartaCobranca_J.Export(frxPDFExport);
      End;

      Application.ProcessMessages;

      If (edtDestino.Text = 'V') Then
      Begin
        pExecArquivo(LArqDesPdf, Handle);
      End
      Else If (edtDestino.Text = 'I') Then
      Begin
        frxCartaCobranca_J.Print;
      End
      Else If (edtDestino.Text = 'M') Then
      Begin

        If Not LEnviarPdf And FileExists(strArqDesHtml) Then
        begin
          If (Not pEnviarEmail(strArqDesHtml, strEmail, strNomCli, False)) Then
          Begin
            Screen.Cursor := crDefault;
            Break;
          End;
        end
        else
        begin
          If (Not pEnviarEmail(LArqDesPdf, strEmail, strNomCli, True)) Then
          Begin
            Screen.Cursor := crDefault;
            Break;
          End;
        end;
      End;

      cdsRelWrd.Filtered := False;
      cdsRelato.Next;
    End;
    Screen.Cursor := crDefault;

    //Inicia thread que vai salvar os arquivos dos email's enviados na pasta
    //EmailTemp, e vai sincronizar a pasta enviados no servidor caso use IMAP
    //Essa rotina foi isolada para melhorar o desempenho da mesma
    //que estava muito lenta - MO. 110852 * KP.110123
    if Assigned(thrSincEmail) And (edtDestino.Text = 'M') then
    Begin
      if thrSincEmail.QuantidadeEmails > 0 then
      begin
        thrSincEmail.Start;

        TListaThreadsSincronizaEmails.GetInstance.pAdicionar(thrSincEmail);
      end;
    End;

    blnConfirma := True;

  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;


function TfrmRelCartaCob.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
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

    Else If (Sender = edtEmpresa) Then
    Begin
      If Not fEmptyStr(edtEmpresa.Text) Then
      Begin
        If (Pos(edtEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0) And (Length(arrEmp) = 1) Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = cbbModelo) Then
    Begin
      If (fEmptyStr(cbbModelo.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Selecione um Modelo de Carta!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtQtdEti) And (edtQtdEti.Enabled) Then
    Begin
      If (fEmptyStr(edtQtdEti.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade de etiquetas deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToInt(edtQtdEti.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade de etiquetas deve ser maior que zero!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtDestino) Then
    Begin
      If (edtDestino.Text <> 'V') and (edtDestino.Text <> 'I') and (edtDestino.Text <> 'M') Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser V, I ou M!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelCartaCob.btnImprimirClick(Sender: TObject);
begin
  If (edtDestino.Text <> 'M') Then
  Begin
    inherited;
  End
  Else
  Begin
    blnImprime := fVerificaCampos();
  End;

  If blnImprime Then
  Begin

    Try

      cdsRelato := TUniClientDataSet.Create(Self);
      cdsRelWrd := TUniClientDataSet.Create(Self);
      dspRelato := TUniDataSetProvider.Create(Self);

      cdsRelato.SetProvider(dspRelato);
      dspRelato.DataSet := qryRelatorio;
      blnConfirma       := False;

      pCriarFormularios(TfrmGravando,frmGravando);
      Try
        frmGravando.fExecutarAcao := SelecionaClientes;
        frmGravando.lblGravando.Caption := 'Aguarde... Selecionando Clientes...';
        frmGravando.ShowModal;
      Finally
        pFreeAndNil(frmGravando);
      End;

      If (blnConfirma) Then
      Begin
        pCriarFormularios(TfrmGravando,frmGravando);
        Try
          If (rgFormaEnvio.ItemIndex = 0) Then
            frmGravando.fExecutarAcao := fGeraCartaCobranca
          Else
          Begin
            If (cbbModelo.KeyValue = '-1') Then
              frmGravando.fExecutarAcao := fGeraCartaCobrancaPersonalizada
            Else
              frmGravando.fExecutarAcao := fGeraCartaCobranca;
          End;

          If (edtDestino.Text = 'M') Then
          begin
            frmGravando.lblGravando.Caption := 'Aguarde... Enviando e-Mail...';
            thrSincEmail    := TThreadSincronizaEmails.Create
          end
          Else
            frmGravando.lblGravando.Caption := 'Aguarde... Gerando Relatório...';

          frmGravando.ShowModal;
        Finally
          pFreeAndNil(frmGravando);
        End;

        If Not blnConfirma Then
          fMensagem('ATENÇÃO!', 'Problemas ao gerar a(s) Carta(s) de Cobrança!', ['&O k']);

        If (blnConfirma) And (chkImpEti.Checked) Then
          pImpEtiquetas;
      End;
    Finally
      qryRelatorio.Close;
      FreeAndNil(cdsRelato);
      FreeAndNil(dspRelato);
      FreeAndNil(cdsRelWrd);
    End;
  End;
  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
  pSetFocus(mskDtaIni);
End;

procedure TfrmRelCartaCob.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelCartaCob.FormCreate(Sender: TObject);
begin
  inherited;
  blnEmail := True;
  FPais    := FPais;

  qryModelos.Connection := frmModulo.GetCurrentConnection;
  qryEmpresa.Connection := frmModulo.GetCurrentConnection;
  {**************************************}
  {* PASSA A FUNCTION PARA O FASTREPORT *}
  {***********************************AC*}
  frxCartaCobranca_M.AddFunction('function fRemoveAcentoEspecificos(Str: String): String');

  If not fCfgSis('RECCOB', varBoolean) Then
  Begin
    edtTaxaJuros.Visible := false;
    lbJuros.Visible      := false;
    lbPorcentJuros.Visible:= False;
  end;
end;

procedure TfrmRelCartaCob.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

function TfrmRelCartaCob.frxCartaCobranca_MUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  inherited;
  If MethodName = 'FREMOVEACENTOESPECIFICOS' Then
    Result := UpperCase(fRemoveAcentoEspecificos(Params[0]));
end;

function TfrmRelCartaCob.fRemoveAcentoEspecificos(Str:String): String;
	Const
		ComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ"´';
		SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
	Var
		x : Integer;
Begin
	For x := 1 to Length(Str) do
		If Pos(Str[x],ComAcento) <> 0 Then
			Str[x] := SemAcento[Pos(Str[x],ComAcento)];
  Result := Str;
end;

function TfrmRelCartaCob.fRetornaPathModelo(strCodMod: String): String;
  Var
    qryAux: TUniQuery;
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT       ';
  strSQL := strSQL + '  COB_PATCOB ';
  strSQL := strSQL + 'FROM         ';
  strSQL := strSQL + '  CARCOB     ';
  strSQL := strSQL + 'WHERE        ';
  strSQL := strSQL + '  AUTOINCREM = :CODMOD AND ';
  strSQL := strSQL + '  COB_CODEMP = :CODEMP     ';
  qryAux := fCriaQuery(Self);
  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODMOD').AsString := strCodMod;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    If Not IsEmpty Then
      Result := FieldByName('COB_PATCOB').AsString
    Else
      Result := '';
  End;
end;

function TfrmRelCartaCob.fVirgulaPontoFloatStr(strValor: String): String;
Begin
  Result := AnsiReplaceStr(strValor,',','.');
End;

function TfrmRelCartaCob.SelecionaClientes(pgbProgresso: TcxProgressBar): Boolean;
var
  strSQL   : String;
  fltJuros : Double;
  fltValJur: Double;
  fltValMul: Double;
  fltValCor: Double;
  intDiasAtraso: Integer;
  strEmpresa,
  strPortador: String;
begin
  Result := True;
  strPortador := '';

  fltJuros      := 0;
  intDiasAtraso := 0;
  {*******************************************}
  {* CALCULA TAXA DE JUROS                   *}
  {****************************************AC*}
  If (Not fEmptyStr(edtTaxaJuros.Text)) And (Not (edtTaxaJuros.Text = '0')) Then
  Begin
    fltJuros := fStrToFloat(edtTaxaJuros.Text);
  End;
  If (Not fEmptyStr(edtDiasAtraso.Text)) And (Not (edtDiasAtraso.Text = '0')) Then
    intDiasAtraso := StrToInt(edtDiasAtraso.Text);

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE CONCAT(CTR_NUMDUP,CTR_PARCEL,"-",CTR_ESPDOC,"-",CTR_CODEMP) AS CTR_NUMDUP, ';
  strSQL := strSQL + '        1   AS QTDTIT, ';
  strSQL := strSQL + '        "S" AS MOSTRA, ';
  strSQL := strSQL + '        "M" AS MARDES, ';
  strSQL := strSQL + '        CTR_PARCEL, ';
  strSQL := strSQL + '        CTR_ESPDOC, ';
  strSQL := strSQL + '        CTR_DTAVEN, ';
  strSQL := strSQL + '        CTR_VALORI, ';
  strSQL := strSQL + '        (CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) AS CTR_VALDUP, ';
  strSQL := strSQL + '        0.00 AS CTR_CORRIGIDO, ';
  strSQL := strSQL + '        0.00 AS CTR_JUROS, ';
  strSQL := strSQL + '        0.00 AS CTR_MULTA, ';
  strSQL := strSQL + '        CTR_DTACAD, ';

  If rdbEndCob.Checked Then
  Begin
    {*******************************************}
    {* DADOS PARA COBRANÇA                     *}
    {****************************************jb*}
    strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_ENDERE, CLI_ENDCOB) AS CLI_ENDERE, ';
    strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_BAIRRO, CLI_BAICOB) AS CLI_BAIRRO, ';
    strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_C_E_P_, CLI_CEPCOB) AS CLI_C_E_P_, ';
    strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, D1.CID_NOMCID, D2.CID_NOMCID) AS CID_NOMCID, ';
    strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CONCAT(D1.CID_NOMCID, "-", D1.CID_ESTADO), CONCAT(D2.CID_NOMCID, "-", D2.CID_ESTADO)) AS CID_CIDADE, ';
    strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, D1.CID_ESTADO, D2.CID_ESTADO) AS CID_ESTADO, ';
    strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_ENDNUM, "") AS CLI_ENDNUM, ';
    strSQL := strSQL + '  CLI_ENDCOM, ';
  End
  Else
  Begin
    strSQL := strSQL + '  CLI_ENDERE, ';
    strSQL := strSQL + '  CLI_BAIRRO, ';
    strSQL := strSQL + '  CLI_C_E_P_, ';
    strSQL := strSQL + '  CLI_ENDNUM, ';
    strSQL := strSQL + '  CLI_ENDCOM, ';
    strSQL := strSQL + '  D1.CID_NOMCID AS CID_NOMCID, ';
    strSQL := strSQL + '  CONCAT(D1.CID_NOMCID, "-", D1.CID_ESTADO) AS CID_CIDADE, ';
    strSQL := strSQL + '  D1.CID_ESTADO AS CID_ESTADO, ';
  End;

  strSQL := strSQL + '        CTR_CODCLI, ';
  strSQL := strSQL + '        CADCLI.AUTOINCREM AS AUTINC, ';
  strSQL := strSQL + '        CLI_CODCLI, ';
  strSQL := strSQL + '        CLI_NOMCLI, ';
  strSQL := strSQL + '        CLI_FANSOB, ';
  strSQL := strSQL + '        CLI_C_G_C_, ';
  strSQL := strSQL + '        CLI_CGCCPF, ';
  strSQL := strSQL + '        CLI_EMAIL_, ';
  strSQL := strSQL + '        CLI_EMCOB1, ';
  strSQL := strSQL + '        CLI_EMCOB2, ';
  strSQL := strSQL + '        CLI_EMAIL2, ';
  strSQL := strSQL + '        CLI_EMAIL3, ';
  strSQL := strSQL + '        IF (DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN) > 0, DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN), 0) AS DIAS_ATRASO ';
  strSQL := strSQL + '   FROM CADREC      ';
  strSQL := strSQL + '     INNER JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI ';
  strSQL := strSQL + '     LEFT  JOIN CADCID D1 ON CLI_CODCID = D1.CID_CODCID ';
  strSQL := strSQL + '     LEFT  JOIN CADCID D2 ON CLI_CIDCOB = D2.CID_CODCID ';
  strSQL := strSQL + '  WHERE CTR_DTAREC IS NULL AND CTR_VALORI > 0 ';
  strSQL := strSQL + '    AND IF (DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN) > 0, DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN), 0) > 0 ';
  strSQL := strSQL + '    AND CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIM ';

  If (Not (intDiasAtraso = 0)) Then
    strSQL := strSQL + '    AND DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN) = :DIAS_ATRASO ';

  If (Not fEmptyStr(edtCliente.Text)) Then
    strSQL := strSQL + '    AND CTR_CODCLI = :CODCLI ';

  If (Not fEmptyStr(edtPortador.Text)) Then
    strSQL := strSQL + fStrLocate(edtPortador, arrPortadores, 'CTR_CODPOR', 'CODPOR')
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (IFNULL(CTR_CODPOR, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  If (Not fEmptyStr(edtEmpresa.Text)) Then
    strSQL := strSQL + fStrLocate(edtEmpresa, arrEmp, 'CTR_CODEMP', 'CODEMP')
  Else
    strSQL := strSQL + '    AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
    strSQL := strSQL + '  AND LOCATE(CTR_ESPDOC, :ESPDOC) > 0 ';

  If (edtVlrMin.Value > 0.00) Then
    strSQL := strSQL + '    HAVING CTR_VALDUP > :VLRMIN ';

  strSQL := strSQL + ' ORDER BY CLI_NOMCLI, CTR_DTAVEN, CTR_ESPDOC, CTR_NUMDUP ';

  With qryRelatorio Do
  Begin

    Close;
    Params.Clear;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIM').AsDate := StrToDate(mskDtaFin.Text);

    If (Not (intDiasAtraso = 0)) Then
      ParamByName('DIAS_ATRASO').AsString := edtDiasAtraso.Text;

    If (Not fEmptyStr(edtCliente.Text)) Then
      ParamByName('CODCLI').AsString := edtCliente.Text;

    If (Not fEmptyStr(edtPortador.Text)) Then
       pSetaParam(edtPortador.Text, arrPortadores, strPortador, 'CODPOR', qryRelatorio);

    If (Not fEmptyStr(edtEmpresa.Text)) Then
    Begin
      strEmpresa := edtEmpresa.Text;
      pSetaParam(edtEmpresa.Text, arrEmp, strEmpresa , 'CODEMP',qryRelatorio);
    End;

    If (edtVlrMin.Value > 0.00) Then
      ParamByName('VLRMIN').AsFloat := edtVlrMin.Value;

    If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
      ParamByName('ESPDOC').AsString := mskEspecie.Text;

    Open;

    pSetaClient(qryRelatorio);
    cdsRelato.Open;
    pSetaClient(cdsRelato);

    blnConfirma := False;

    If IsEmpty Then
    Begin
      If (edtDestino.Text = 'M') Then
        fMensagem('', 'Não há dados para enviar o e-mail!', ['&Ok'])
      Else
        fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);
    End
    Else
    Begin

      cdsRelato.First;
      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := RecordCount;

      With cdsRelato Do
      Begin
        While Not Eof Do
        Begin
          fltValMul := fFormataFloat(fMulta(cdsRelato.FieldByName('CTR_DTAVEN').AsDateTime, cdsRelato.FieldByName('CTR_VALDUP').AsFloat), 2);

          {*******************************************}
          {* CALCULA JUROS SE HOUVER                 *}
          {****************************************JU*}
          If (Not (fltJuros = 0)) And (Not (intDiasAtraso = 0)) And ((VS_Date - cdsRelato.FieldByName('CTR_DTAVEN').AsDateTime) > intTolerancia) Then
          Begin
            fltValJur := fFormataFloat((((cdsRelato.FieldByName('CTR_VALDUP').AsFloat * fltJuros * intDiasAtraso) /30) /100), 2);
            fltValCor := cdsRelato.FieldByName('CTR_VALDUP').AsFloat + fltValJur + fltValMul;
          End
          Else If (Not (fltJuros = 0)) And ((VS_Date - cdsRelato.FieldByName('CTR_DTAVEN').AsDateTime) > intTolerancia) Then
          Begin
            fltValJur := fFormataFloat(fCalculaJurosCadCtr(cdsRelato.FieldByName('CTR_DTAVEN').AsDateTime, cdsRelato.FieldByName('CTR_VALDUP').AsFloat, fltJuros), 2) - fltValMul;
            fltValCor := cdsRelato.FieldByName('CTR_VALDUP').AsFloat + fltValJur + fltValMul;
          End
          Else
          Begin
            fltValJur := 0;
            fltValCor := cdsRelato.FieldByName('CTR_VALDUP').AsFloat + fltValMul;
          End;

          cdsRelato.Edit;
          cdsRelato.FieldByName('CTR_CORRIGIDO').AsFloat := fltValCor;
          cdsRelato.FieldByName('CTR_JUROS').AsFloat     := fltValJur;
          cdsRelato.FieldByName('CTR_MULTA').AsFloat     := fltValMul;
          cdsRelato.Post;

          Next;
          StepStatusSelecao(pgbProgresso);
          Application.ProcessMessages;
        End;
        cdsRelWrd.Data := cdsRelato.Data;
      End;

      blnConfirma := fChamaTelaSelecaoImp;

      If (blnConfirma) And (cdsRelato.IsEmpty) Then
      Begin
        If (edtDestino.Text = 'M') Then
          fMensagem('', 'Não há dados para enviar o e-mail!', ['&Ok'])
        Else
          fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);

        blnConfirma := False;
      End;
    End;
  End;
end;

procedure TfrmRelCartaCob.pAgrupaPorCliente;
Var
  strCliAnt: String;
  intPosPri: Integer;
  intPosAtu: Integer;
  fltValCor: Double;
  fltValPen: Double;
begin
  With cdsRelato Do
  Begin
    IndexFieldNames := 'CTR_CODCLI';
    First;
    strCliAnt := '';
    intPosPri := 1;

    While Not Eof Do
    Begin
      If (FieldByName('CTR_CODCLI').AsString <> strCliAnt) Then
      Begin
        strCliAnt := FieldByName('CTR_CODCLI').AsString;
        intPosPri := RecNo;
      End
      Else
      Begin
        fltValCor := FieldByName('CTR_CORRIGIDO').AsFloat;
        fltValPen := FieldByName('CTR_VALDUP').AsFloat;

        Edit;
        FieldByName('MOSTRA').AsString := 'N';
        Post;

        intPosAtu := RecNo;
        RecNo := intPosPri;

        Edit;
        FieldByName('CTR_CORRIGIDO').AsFloat := FieldByName('CTR_CORRIGIDO').AsFloat + fltValCor;
        FieldByName('CTR_VALDUP').AsFloat    := FieldByName('CTR_VALDUP').AsFloat + fltValPen;
        FieldByName('QTDTIT').AsInteger      := FieldByName('QTDTIT').AsInteger + 1;
        Post;

        RecNo := intPosAtu;
      End;

      Next;
    End;

    Filter := 'MOSTRA =  ' + QuotedStr('S');
    Filtered := True;

  End;
end;

function TfrmRelCartaCob.fChamaTelaSelecaoImp: Boolean;
begin

  Result := False;

  Try

    pAgrupaPorCliente;

    pCriarFormularios(TfrmCtrSelClienteImp, frmCtrSelClienteImp);

    If (edtDestino.Text = 'M') Then
      frmCtrSelClienteImp.Caption := 'Seleção de Clientes para Envio de e-Mail';

    frmCtrSelClienteImp.cdsSelCli.Data := cdsRelato.Data;
    frmCtrSelClienteImp.cdsSelCli.Open;

    TFloatField(frmCtrSelClienteImp.cdsSelCli.FieldByName('CTR_CORRIGIDO')).DisplayFormat := '#,##0.00';
    TFloatField(frmCtrSelClienteImp.cdsSelCli.FieldByName('CTR_VALDUP')).DisplayFormat    := '#,##0.00';

    frmCtrSelClienteImp.cdsSelCli.Filter   := 'MOSTRA = ' + QuotedStr('S');
    frmCtrSelClienteImp.cdsSelCli.Filtered := True;
    frmCtrSelClienteImp.blnCartaCob        := True;

    frmCtrSelClienteImp.ShowModal;

    If (frmCtrSelClienteImp.blnConfirma) Then
    Begin
      cdsRelato.Data := frmCtrSelClienteImp.cdsSelCli.Data;
      cdsRelato.Filter := 'MARDES = ' + QuotedStr('M') + ' AND MOSTRA = ' + QuotedStr('S');
      cdsRelato.Filtered := True;

      If frmCtrSelClienteImp.cxgSelCliDBTableView1.SortedItemCount > 0 Then
        cdsRelato.IndexFieldNames := frmCtrSelClienteImp.cxgSelCliDBTableView1.SortedItems[0].DataBinding.FilterFieldName;

      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmRelCartaCob.pChamaTelaSelecaoImp]');
    End;
  End;

  pFreeAndNil(frmCtrSelClienteImp);

end;

function TfrmRelCartaCob.fClienteSelecionado(strCodCli: String): Boolean;
begin


  With cdsRelato Do
  Begin
    Filter := 'MARDES     = ' + QuotedStr('M') + ' AND ' +
              'MOSTRA     = ' + QuotedStr('S') + ' AND ' +
              'CTR_CODCLI = ' + QuotedStr(strCodCli);

    Filtered := True;

    Result := (Not IsEmpty);

    Filter := 'MARDES     = ' + QuotedStr('M') + ' AND ' +
              'MOSTRA     = ' + QuotedStr('S');
    Filtered := True;
  End;

end;

function TfrmRelCartaCob.fRetAutoIncremCliente: String;
begin

  Result := '';

  With cdsRelato Do
  Begin
    First;

    While Not Eof Do
    Begin
      If (RecNo = 1) Then
        Result := QuotedStr(FieldByName('AUTINC').AsString)
      Else
        Result := Result + ',' + QuotedStr(FieldByName('AUTINC').AsString);
      Next;
    End;
  End;

end;

procedure TfrmRelCartaCob.pImpEtiquetas;
begin

  fMensagem('ATENÇÃO!','Prepare a impressora ' + IfThen(rdbImpLas.Checked, 'laser/argox', 'matricial') + ' para a imprimir a(s) etiqueta(s)!', ['&O k']);

  intColAtu := 1;

  If (rdbImpLas.Checked) Then
    fImprimeEtiquetaClienteLaser
  Else
    pImpEtiquetasMatricial;
end;

procedure TfrmRelCartaCob.pImpEtiquetasMatricial;
  Var
    intContador: Integer;
    intQtdTopo : Integer;
    qryCfgRel  : TUniQuery;
    strNomImp  : String;
    intConEti  : Integer;
    intQtdEti  : Integer;
begin
  qryCfgRel := fCriaQuery(Self);
  pCarregaConfImpr(qryCfgRel, 'frmImpEtiquetas');
  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
  strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;

  If Not fVerificaImpressora(strNomImp) Then
  Begin
    fMensagem('','Impressora configurada incorretamente!',['&OK']);
    Exit;
  End;

  With cdsRelato Do
  Begin

    intQtdTopo := fRetTopoEtiqueta('CLI');

    For intContador := 1 to intQtdTopo Do
    Begin
      pEscreveLinha(untFuncMacro.strArqTxt, ' ', False, strNomImp, strNomPro, strDesPro);
    End;

    First;

    intQtdEti := StrToInt(edtQtdEti.Text);

    While Not Eof Do
    Begin

      Application.ProcessMessages;
      pAtualizaCamposUso;
      Application.ProcessMessages;

      For intConEti := 1 To intQtdEti Do
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
  End;

  FreeAndNil(qryCfgRel);
end;

procedure TfrmRelCartaCob.pAtualizaCamposUso;
begin
  pFinalizaCamposUso;
  pAtribuiCamposUso;
end;

procedure TfrmRelCartaCob.pFinalizaCamposUso;
begin
  If cpuCampos <> Nil Then
    FreeAndNil(cpuCampos);
end;

procedure TfrmRelCartaCob.pHabilitaCamposEtiquetas;
begin
  edtQtdEti.Enabled := chkImpEti.Checked;
  pnlEndere.Enabled := chkImpEti.Checked;
  pnlTipImp.Enabled := chkImpEti.Checked;
end;

procedure TfrmRelCartaCob.pImpRegistro;
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
  intQtdEti   := 1;

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
    ParamByName('TIPETI').AsString := 'CLI';
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

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

    {If (Length(arrLinhasEti) = 0) Then
    Begin
      SetLength(arrLinhasEti, RecordCount-1);
    End;}

    If (Length(arrLinhasEti) = 0) Then
    Begin
      If RecordCount > 0 Then
        SetLength(arrLinhasEti, RecordCount-1)
      Else
        SetLength(arrLinhasEti, 0);
    End;

    While (Not Eof) Do
    Begin

      pAtualizaCamposUso;

      strLinha := '';

      For intContador := intColAtu To IfThen(intQtdEti = 1, intColAtu, intQtdCol) Do
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

    Inc(intColAtu, intQtdEti);
 //   Dec(intQtdEti, (intQtdColOri+1) - (intColAtu - intQtdEti));

    If intColAtu > intQtdColOri Then
    Begin
      pImpArrLinhasEti;
      intColAtu := 1;
    End;

  End;
  FreeAndNil(qryCnfEti);
end;

procedure TfrmRelCartaCob.StepStatusSelecao(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmRelCartaCob.pImpArrLinhasEti;
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

    pEscreveLinha(strArqTxt,AnsiString(arrLinhasEti[intContador1]), blnUltimoReg, strNomImp, strNomPro, strDesPro);
    strLinhaAtu := '';
  End;

  SetLength(arrLinhasEti, 0);
end;

procedure TfrmRelCartaCob.pAtribuiCamposUso;
begin
  If Assigned(cpuCampos) THen
    FreeAndNil(cpuCampos);

  cpuCampos := TCamposUso.Create;
  cpuCampos.AdicionaCampos(cdsRelato, 'CADCLI');
end;

function TfrmRelCartaCob.fImprimeEtiquetaClienteLaser: Boolean;
  Var
    prmDllRel: TParamDllEtiquetas;
Begin

  prmDllRel := TParamDllEtiquetas.Create;

  With prmDllRel Do
  Begin
    If (fCfgSis('ETICLI') = 'L') Then
      tpeTipEtq := tpeClienteLaser
    Else
      tpeTipEtq := tpeClienteArgox;

    strCamBus := 'CLI_NOMCLI';
    blnEdrCob := rdbEndCob.Checked;
    strLisReg := fRetAutoIncremCliente;
    intQtdEti := StrToInt(edtQtdEti.Text);
  End;

  Result := fImprimeEtiqueta(prmDllRel);

  FreeAndNil(prmDllRel);
End;

function TfrmRelCartaCob.fMulta(dtaDtaVen: TDateTime; fltValDup : Double) : Double;
var
  fltDiaAtraso : Double;
Begin

  Result        := 0;
  fltDiaAtraso  := VS_Date - dtaDtaVen;

  If (dtaDtaVen < VS_Date) And (fltDiaAtraso > intTolerancia) Then
    If fltPerMul > 0 Then
      Result := fltValDup * (fltPerMul / 100);

End;

function TfrmRelCartaCob.fRetornaEmailCliente(ADados: TDataset): String;
begin
  If (fCfgSis('GPEMCB', VarBoolean)) Then
  Begin
    Result := '';

    If Not fEmptyStr(ADados.FieldByName('CLI_EMAIL_').AsString) Then
      Result := ADados.FieldByName('CLI_EMAIL_').AsString;

    If fEmptyStr(Result) Then
    Begin
      If Not fEmptyStr(ADados.FieldByName('CLI_EMCOB1').AsString) Then
        Result := ADados.FieldByName('CLI_EMCOB1').AsString;

      If Not fEmptyStr(ADados.FieldByName('CLI_EMCOB2').AsString) Then
      Begin
        If fEmptyStr(Result) Then
          Result := ADados.FieldByName('CLI_EMCOB2').AsString
        Else
          Result := Result + '; ' + ADados.FieldByName('CLI_EMCOB2').AsString;
      End;
    End;

    If fEmptyStr(Result) Then
    Begin
      If Not fEmptyStr(ADados.FieldByName('CLI_EMAIL2').AsString) Then
        Result := ADados.FieldByName('CLI_EMAIL2').AsString
      Else If Not fEmptyStr(ADados.FieldByName('CLI_EMAIL3').AsString) Then
        Result := ADados.FieldByName('CLI_EMAIL3').AsString;
    End;
  End
  Else
  Begin
    If Not fEmptyStr(ADados.FieldByName('CLI_EMAIL_').AsString) Then
      Result := ADados.FieldByName('CLI_EMAIL_').AsString
    Else If Not fEmptyStr(ADados.FieldByName('CLI_EMCOB1').AsString) Then
      Result := ADados.FieldByName('CLI_EMCOB1').AsString
    Else If Not fEmptyStr(ADados.FieldByName('CLI_EMCOB2').AsString) Then
      Result := ADados.FieldByName('CLI_EMCOB2').AsString
    Else If Not fEmptyStr(ADados.FieldByName('CLI_EMAIL2').AsString) Then
      Result := ADados.FieldByName('CLI_EMAIL2').AsString
    Else If Not fEmptyStr(ADados.FieldByName('CLI_EMAIL3').AsString) Then
      Result := ADados.FieldByName('CLI_EMAIL3').AsString
    Else
      Result := '';
  End;

  Result := AnsiReplaceStr(Result, ';;', ';');
end;

function TfrmRelCartaCob.fLoadReport: Boolean;
  Var
   mmsLoad: TStream;
   qryLayImp: TUniQuery;
Begin
  Result := False;

  qryLayImp := fCriaQuery(nil);

  Try
    With qryLayImp, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM ');
      Add('  LAYIMP');
      Add('WHERE');
      Add('  LAY_TIPLAY = :TIPLAY AND  ');
      Add('  LAY_CODEMP = :CODEMP AND  ');
      Add('  LAY_CODLAY = :CODLAY      ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODLAY').AsString := 'CRTCOB';

      ParamByName('TIPLAY').AsString := 'L';

      Add('ORDER BY');
      Add('  LAY_DTAALT DESC,');
      Add('  LAY_HORALT DESC ');
      Add('LIMIT 1');
      Open;

      If Not IsEmpty Then
      Begin
        Try
          Result := True;
          mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmRead);

          frxCartaCobranca_J.LoadFromStream(mmsLoad);
          frxCartaCobranca_J.Variables.Clear;
        Finally
          pFreeAndNil(mmsLoad);
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fLoadReport]');
    End;
  End;

  pFreeAndNil(qryLayImp);
end;

end.

