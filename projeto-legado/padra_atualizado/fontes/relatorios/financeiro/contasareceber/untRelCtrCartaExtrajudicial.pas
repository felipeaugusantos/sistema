unit untRelCtrCartaExtrajudicial;

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
  TfrmRelCtrCartaExtrajudicial = class(TfrmPaiRelatorio)
    Label1: TLabel;
    edtCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    lblEmpresa: TLabel;
    edtEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    frxEmpresa: TfrxDBDataset;
    qryEmpresa: TUniQuery;
    frxCartaExtrajudicial_M: TfrxReport;
    frxCartaExtrajudicial_J: TfrxReport;
    frxInformacoes: TfrxDBDataset;
    qryInformacoes: TUniClientDataSet;
    qryInformacoesIMAGEM: TStringField;
    qryInformacoesDIRETORIO: TStringField;
    Label5: TLabel;
    cbbModelo: TDBLookupComboBoxFocus;
    qryModelos: TUniQuery;
    dtsModelos: TDataSource;
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
    GroupBox1: TGroupBox;
    Label12: TLabel;
    mskDtaIni: TcxDateEdit;
    Label11: TLabel;
    mskDtaFin: TcxDateEdit;
    Label3: TLabel;
    edtPortador: TEditFocus;
    edtDesPortador: TEditFocus;
    rgFormaEnvio: TRadioGroup;
    qryModelosAUTOINCREM: TStringField;
    qryModelosEXJ_NOMEXJ: TStringField;
    qryModelosEXJ_PATEXJ: TStringField;
    procedure FormShow(Sender: TObject);
    procedure edtClienteExit(Sender: TObject);
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaCliente(Var qryCadCli: TUniQuery);
    procedure edtEmpresaExit(Sender: TObject);
    procedure edtEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function frxCartaExtrajudicial_MUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    function fVirgulaPontoFloatStr(strValor: String): String;
    procedure cbbModeloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtPortadorExit(Sender: TObject);
    procedure edtPortadorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryRelatorio: TUniQuery;
    cdsRelWrd: TUniClientDataSet;
    cdsRelato: TUniClientDataSet;
    dspRelato: TUniDataSetProvider;
    cpuCampos: TCamposUso;
    strNomImp, strNomPro, strDesPro: String;
    intColAtu: Integer;
    arrLinhasEti : Array Of String;
    fltPerMul    : Double;
    intTolerancia: Integer;
    thrSincEmail   : TThreadSincronizaEmails;
    blnConfirma: Boolean;
    arrEmp: TConsultasArray;
    FPais: TPais;
    strDirPath : String;
    function fRemoveAcentoEspecificos(Str:String): String;
    function fGeraCartaExtrajudicial(pgbProgresso: TcxProgressBar): Boolean;
    function fRetornaPathModelo(strCodMod: String): String;
    function fChamaTelaSelecaoImp: Boolean;
    function fClienteSelecionado(strCodCli: String): Boolean;
    procedure pAgrupaPorCliente;
    procedure pImpEtiquetas;
    procedure pImpEtiquetasMatricial;
    function  fImprimeEtiquetaClienteLaser: Boolean;
    function  fRetAutoIncremCliente: String;

    procedure pAtualizaCamposUso;
    procedure pAtribuiCamposUso;
    procedure pFinalizaCamposUso;

    procedure pImpRegistro;
    procedure pImpArrLinhasEti;


    procedure pCriaQryRelatorio;
    function SelecionaClientes(pgbProgresso: TcxProgressBar): Boolean;
    procedure StepStatusSelecao(pgbStatus: TcxProgressBar);

    function pEnviarEmail(strArquivo, strDestinatario, strNomeDestinatario : String; blnEnviarMensagem: Boolean): Boolean;
    function fRetornaEmailCliente(ADados: TDataset): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

implementation

uses untPai, untCtrSelClienteImp, untWord, untModulo, untFuncMacro, untConsultas,
    untCfgRel, untFuncoesEtiquetas, untGravando,untFuncoesConsulta;

{$R *.dfm}

procedure TfrmRelCtrCartaExtrajudicial.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  fltPerMul         := fCfgSis('MULATR', varDouble);
  intTolerancia     := fCfgSis('TOLATR', varInteger);

  edtEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  inherited;
  qryModelos.Close;
  qryModelos.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryModelos.Open;

  If Not (fVerificaAcessoSistema('COBIMP', strLoginUsuarioLogado)) Then
  Begin
    edtDestino.Text := 'I';
    edtDestino.Enabled := False;
    edtDestino.TabStop := False;
    shpLiberado.Brush.Color := clRed;
  End
  Else
    shpLiberado.Brush.Color := clGreen;



end;

procedure TfrmRelCtrCartaExtrajudicial.cbbModeloKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmRelCtrCartaExtrajudicial.edtClienteExit(Sender: TObject);
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

procedure TfrmRelCtrCartaExtrajudicial.edtClienteKeyPress(Sender: TObject;
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

procedure TfrmRelCtrCartaExtrajudicial.pCarregaCliente(Var qryCadCli: TUniQuery);
begin

  If Not (fEmptyStr(edtCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';

end;

procedure TfrmRelCtrCartaExtrajudicial.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

function TfrmRelCtrCartaExtrajudicial.pEnviarEmail(strArquivo, strDestinatario, strNomeDestinatario: String; blnEnviarMensagem: Boolean): Boolean;
  Var
    arrArquivos, arrDestinatarios : TStringArray;
begin
  pCriarArrayAnexosEDestinatarios(strArquivo, strDestinatario, arrDestinatarios, arrArquivos);

  Result := TEnvioEmail.EnviarEmailSemMensagemConfirmacao(Self,
                                                          strLoginUsuarioLogado,
                                                          'Carta Extrajudicial' + ' - ' + strNomeDestinatario,
                                                          arrDestinatarios,
                                                          [],
                                                          [],
                                                          [IIF(blnEnviarMensagem,'Segue carta extrajudicial em anexo.','')],
                                                          arrArquivos,
                                                          False,
                                                          thrSincEmail);
end;

procedure TfrmRelCtrCartaExtrajudicial.edtEmpresaExit(Sender: TObject);
begin
  inherited;
  // seleção multi empresa com controle dos digitos 000 quando mais de uma empresa
  If Not edtEmpresa.ReadOnly Then
    pEdtCodSelectExit(edtEmpresa, edtDesEmpresa, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);
    fValidaCampos(edtEmpresa, True);
end;

procedure TfrmRelCtrCartaExtrajudicial.edtEmpresaKeyPress(Sender: TObject;
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

procedure TfrmRelCtrCartaExtrajudicial.edtPortadorExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtPortador.Text) Then
    edtDesPortador.Text := 'TODOS'
  Else
    edtDesPortador.Text := fRetNomPortador(edtPortador.Text);

  If fEmptyStr(edtDesPortador.Text) And (Not fEmptyStr(edtPortador.Text)) Then
  Begin
    fMensagem('AVISO','Código do Portador não encontrado',['&O K']);
    edtPortador.Clear;
    pSetFocus(edtPortador);
  End;
end;

procedure TfrmRelCtrCartaExtrajudicial.edtPortadorKeyPress(Sender: TObject; var Key: Char);
Var
  arrPortadores: TConsultasArray;
begin
  inherited;
  {*******************************}
  {*     CONSULTA DE PORTADORES  *}
  {****************************RV*}
  If fPesqPortador(conSimples, Self, edtPortador, edtDesPortador, Nil, Key, arrPortadores) Then
  Begin
    If fValidaCampos(edtPortador, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelCtrCartaExtrajudicial.fGeraCartaExtrajudicial(pgbProgresso: TcxProgressBar): Boolean;
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

      Word.pCriaTabela('{{DUPLIC}}', intQtdLin, 5);

      intLinha := 1;

      Word.pCelulaNegrito(intLinha, 1);
      Word.pCelulaAlignCenter(intLinha , 1);
      Word.pCelulaEscreve(intLinha, 1, 'DUPLICATA');
      Word.pCelulaNegrito(intLinha, 2);
      Word.pCelulaAlignCenter(intLinha , 2);
      Word.pCelulaEscreve(intLinha, 2, 'VENCIMENTO');
      Word.pCelulaNegrito(intLinha, 3);
      Word.pCelulaAlignCenter(intLinha , 3);
      Word.pCelulaEscreve(intLinha, 3, 'DIAS ATRASO');
      Word.pCelulaNegrito(intLinha, 4);
      Word.pCelulaAlignRight(intLinha, 4);
      Word.pCelulaEscreve(intLinha, 4, 'R$ TITULO');
      Word.pCelulaNegrito(intLinha, 5);
      Word.pCelulaAlignRight(intLinha, 5);
      Word.pCelulaEscreve(intLinha, 5, 'R$ CORRIGIDO');

      Inc(intLinha);
    end;

    function fRetornaTotalCorrigido: Real;
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

    procedure pReplaceTags();
    begin
      //Dados Empresa
      Word.pReplace('{{NOMEMP}}', qryEmp.FieldByName('EMP_NOMEMP').AsString);
      Word.pReplace('{{CGCEMP}}', fFormataCpfCgc(qryEmp.FieldByName('EMP_C_G_C_').AsString,FPais));
      Word.pReplace('{{CEPEMP}}', fFormataCEP(qryEmp.FieldByName('EMP_C_E_P_').AsString));
      Word.pReplace('{{ENDEMP}}', qryEmp.FieldByName('EMP_ENDERE').AsString);
      Word.pReplace('{{CIDEMP}}', qryEmp.FieldByName('EMP_CIDADE').AsString);
      Word.pReplace('{{FONEMP}}', fFormataFone(qryEmp.FieldByName('EMP_FONE01').AsString));
      Word.pReplace('{{FAXEMP}}', fFormataFone(qryEmp.FieldByName('EMP_F_A_X_').AsString));
      Word.pReplace('{{EMAILEMP}}', qryEmp.FieldByName('EMP_EMAIL_').AsString);
      Word.pReplace('{{NOMCID}}', qryEmp.FieldByName('CID_NOMCID').AsString);

      //Dados Diversos
      Word.pReplace('{{DATA}}', FormatDateTime('dd "de" mmmm "de" yyyy',VS_Date));

      //Dados Cliente
      Word.pReplace('{{CLINOM}}', cdsRelWrd.FieldByName('CLI_NOMCLI').AsString);
      Word.pReplace('{{CLIEND}}', cdsRelWrd.FieldByName('CLI_ENDERE').AsString + ', ' +
                                  cdsRelWrd.FieldByName('CLI_ENDNUM').AsString + ' - '+
                                  cdsRelWrd.FieldByName('CLI_ENDCOM').AsString);
      Word.pReplace('{{CLICID}}', cdsRelWrd.FieldByName('CID_NOMCID').AsString);
      Word.pReplace('{{CIDADE}}', cdsRelWrd.FieldByName('CID_CIDADE').AsString);
      Word.pReplace('{{CLIEST}}', cdsRelWrd.FieldByName('CID_ESTADO').AsString);
      Word.pReplace('{{CLICEP}}', fFormataCEP(cdsRelWrd.FieldByName('CLI_C_E_P_').AsString));
      Word.pReplace('{{CLIBAI}}', cdsRelWrd.FieldByName('CLI_BAIRRO').AsString);
      Word.pReplace('{{CLIDOC}}', fFormataCpfCgc(cdsRelWrd.FieldByName('CLI_C_G_C_').AsString, FPais));
      Word.pReplace('{{CLICGC}}', IIF(cdsRelWrd.FieldByName('CLI_CGCCPF').AsString = '1','CNPJ n° ','CPF n° ')+ fFormataCpfCgc(cdsRelWrd.FieldByName('CLI_C_G_C_').AsString, FPais));

      Word.pReplace('{{TOTCOR}}', FormatFloat('R$ #,##0.00', fRetornaTotalCorrigido));
      Word.pReplace('{{TOTEXT}}', fRetExtensoNumero(FloatToStr(fRetornaTotalCorrigido)));
      Word.pReplace('{{CPFOPE}}', fFormataCpfCgc(qryOpe.FieldByName('OPE_NUMCPF').AsString, FPais));
      Word.pReplace('{{NOMFAN}}', qryOpe.FieldByName('OPE_NOMFAN').AsString);
      Word.pReplace('{{NOMOPE}}', qryOpe.FieldByName('OPE_NOMOPE').AsString);
    end;

begin
  Result := false;
  blnConfirma := False;
  strNomCli   := '';

  Try
    If Not DirectoryExists(strDirPath) Then
      CreateDir(strDirPath);

    strArqOri := fRetornaPathModelo(cbbModelo.KeyValue);
    strArqOri := AnsiReplaceStr(strArqOri, '"', '');

    If FileExists(strArqOri) Then
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   EMP_NOMEMP, ';
        strSQL := strSQL + '   CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT(", ", EMP_ENDCMP)), IF(IFNULL(EMP_BAIRRO,"") = "", "", CONCAT(", ", EMP_BAIRRO))) AS EMP_ENDERE, ';
        strSQL := strSQL + '   CONCAT(CID_NOMCID, "-" , CID_ESTADO) AS EMP_CIDADE, ';
        strSQL := strSQL + '   CID_NOMCID, ';
        strSQL := strSQL + '   EMP_C_G_C_, ';
        strSQL := strSQL + '   EMP_FONE01, ';
        strSQL := strSQL + '   EMP_F_A_X_, ';
        strSQL := strSQL + '   EMP_C_E_P_, ';
        strSQL := strSQL + '   EMP_EMAIL_  ';
        strSQL := strSQL + ' FROM   ';
        strSQL := strSQL + '   CADEMP ';
        strSQL := strSQL + '   JOIN CADCID ON CID_CODCID = EMP_CODCID ';
        strSQL := strSQL + ' WHERE    ';
        strSQL := strSQL + '   EMP_CODEMP = "' + VS_strCodEmp +  '"  ';

        qryEmp := fCriaQuery(Self);
        qryEmp.SQL.Clear;
        qryEmp.SQL.Add(strSQL);
        qryEmp.Open;

        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   OPE_NOMFAN, ';
        strSQL := strSQL + '   OPE_NUMCPF, ';
        strSQL := strSQL + '   OPE_NOMOPE ';
        strSQL := strSQL + ' FROM   ';
        strSQL := strSQL + '   CADOPE ';
        strSQL := strSQL + ' WHERE    ';
        strSQL := strSQL + '   OPE_CODOPE = "' + strLoginUsuarioLogado +  '"  ';

        qryOpe := fCriaQuery(Self);
        qryOpe.SQL.Clear;
        qryOpe.SQL.Add(strSQL);
        qryOpe.Open;

        Word := TWord.fCriarWord(Self);

        cdsRelWrd.First;
        pgbProgresso.Position := 0;
        pgbProgresso.Properties.Max := cdsRelWrd.RecordCount;
        While Not cdsRelWrd.Eof Do
          Begin
            If (Not fClienteSelecionado(cdsRelWrd.FieldByName('CTR_CODCLI').AsString)) Then
              Begin
                cdsRelWrd.Next;
                StepStatusSelecao(pgbProgresso);
                Application.ProcessMessages;
                Continue;
              End;

            strNomCli := cdsRelWrd.FieldByName('CLI_NOMCLI').AsString;
            strCliAnt := cdsRelWrd.FieldByName('CTR_CODCLI').AsString;
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

            strArqDes     := strDirPath+'\CARTA_EXTRAJUDICIAL_' + FormatDateTime('yyyymmdd', Date) + '-' + cdsRelWrd.FieldByName('CTR_CODCLI').AsString + '.doc';
            strArqDesHtml := strDirPath+'\CARTA_EXTRAJUDICIAL_' + FormatDateTime('yyyymmdd', Date) + '-' + cdsRelWrd.FieldByName('CTR_CODCLI').AsString + '.html';
            LArqDesPdf    := strDirPath+'\CARTA_EXTRAJUDICIAL_' + FormatDateTime('yyyymmdd', Date) + '-' + cdsRelWrd.FieldByName('CTR_CODCLI').AsString + '.pdf';

            If FileExists(strArqDes) Then
              DeleteFile(strArqDes);

            If FileExists(StringReplace(strArqDes,'.doc','.odt',[rfReplaceAll])) Then
              DeleteFile(StringReplace(strArqDes,'.doc','.odt',[rfReplaceAll]));

            If FileExists(LArqDesPdf) Then
              DeleteFile(LArqDesPdf);

            // se não conseguiu apagar o arquivo já existente segnifica que o mesmo
            // está sendo usado por outro processo, sendo assim crio um novo arquivo
            // para a rotina não apresentar erros.

            If FileExists(LArqDesPdf) Then
              LArqDesPdf:= strDirPath+'\CARTA_EXTRAJUDICIAL_' + FormatDateTime('yyyymmdd', Date) + '-' + cdsRelWrd.FieldByName('CTR_CODCLI').AsString +'-'+FormatDateTime('hhnnss', fNow) + '.pdf';

            If FileExists(strArqDes) Then
              strArqDes :=strDirPath+'\CARTA_EXTRAJUDICIAL_' + FormatDateTime('yyyymmdd', Date) + '-' + cdsRelWrd.FieldByName('CTR_CODCLI').AsString +'-'+FormatDateTime('hhnnss', fNow) + '.doc';

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
            pReplaceTags();//SUBSTITUI OS TEXTOS

            {*************************************}
            {* VAI PARA O CORPO DO DOCUMENTO     *}
            {**********************************RV*}
            Application.ProcessMessages;
            Word.pGoToMainDocument;
            pReplaceTags();//SUBSTITUI OS TEXTOS

            {*************************************}
            {* CRIA UMA TABELA COM AS DUPLICATAS *}
            {**********************************RV*}
            pGeraCabDuplicatas;

            While (cdsRelWrd.FieldByName('CTR_CODCLI').AsString = strCliAnt) Do
            Begin
              Word.pCelulaAlignCenter(intLinha , 1);
              Word.pCelulaEscreve(intLinha, 1, cdsRelWrd.FieldByName('CTR_NUMDUP').AsString);
              Word.pCelulaAlignCenter(intLinha, 2);
              Word.pCelulaEscreve(intLinha, 2, FormatDateTime('dd/mm/yyyy', cdsRelWrd.FieldByName('CTR_DTAVEN').AsDateTime));
              Word.pCelulaAlignCenter(intLinha, 3);
              Word.pCelulaEscreve(intLinha, 3, cdsRelWrd.FieldByName('DIAS_ATRASO').AsString);
              Word.pCelulaAlignRight(intLinha, 4);
              Word.pCelulaEscreve(intLinha, 4, FormatFloat(',0.00', cdsRelWrd.FieldByName('CTR_VALDUP').AsFloat));
              Word.pCelulaAlignRight(intLinha, 5);
              Word.pCelulaEscreve(intLinha, 5, FormatFloat(',0.00', cdsRelWrd.FieldByName('CTR_CORRIGIDO').AsFloat));

              fltTotJur := fltTotJur + cdsRelWrd.FieldByName('CTR_JUROS').AsFloat;
              fltTotMul := fltTotMul + cdsRelWrd.FieldByName('CTR_MULTA').AsFloat;
              fltTotCor := fltTotCor + cdsRelWrd.FieldByName('CTR_CORRIGIDO').AsFloat;
              fltTotOri := fltTotOri + cdsRelWrd.FieldByName('CTR_VALDUP').AsFloat;

              cdsRelWrd.Next;
              StepStatusSelecao(pgbProgresso);
              Application.ProcessMessages;
              Inc(intLinha);
              If cdsRelWrd.Eof Then
                Break;
            End;

            Application.ProcessMessages;
            Word.pCelulaNegrito(intLinha , 3);
            Word.pCelulaAlignRight(intLinha , 3);
            Word.pCelulaEscreve(intLinha , 3, 'TOTAIS:');
            Word.pCelulaNegrito(intLinha , 4);
            Word.pCelulaAlignRight(intLinha , 4);
            Word.pCelulaEscreve(intLinha , 4, FormatFloat(',0.00', fltTotOri));
            Word.pCelulaNegrito(intLinha, 5);
            Word.pCelulaAlignRight(intLinha , 5);
            Word.pCelulaEscreve(intLinha , 5, FormatFloat(',0.00', fltTotCor));

            LEnviarPdf := (rgFormaEnvio.ItemIndex = 1);

            // Reorganiza as colunas para que o número do documento fique apenas em uma linha
            // Devido à biblioteca do OpenOffice, deve setar o tamanho das colunas
            // da esquerda para a direita, isto é, da coluna maior pra menor
            // Parâmetros: linha, coluna e tamanho sugerido (usado pelo Word - Microsoft)
            // Quando for o OpenOffice irá usar a linha/coluna para otimizar o tamanho
            // pelo seu conteúdo
            Word.pOtimizaTamanho(1, 5, 65);
            Word.pOtimizaTamanho(1, 4, 65);
            Word.pOtimizaTamanho(1, 3, 65);
            Word.pOtimizaTamanho(1, 2, 65);
            Word.pOtimizaTamanho(2, 1, 140);

            // exporta carta criada em word/ods para PDF
            If LEnviarPdf Then
              Word.SaveAsPDF(LArqDesPdf);

            If (edtDestino.Text = 'I') Then
              TCfgRel.pPrintReport(Self.Name, ExtractFileName(strArqDes), strNomImp, Word)
            else If (edtDestino.Text = 'V') Then
              Word.pSalvar
            Else If (edtDestino.Text = 'M') Then
              Word.pSaveAsHtml;

            Word.pFechar;

            Application.ProcessMessages;

            If FileExists(StringReplace(strArqDes,'.doc','.odt',[rfReplaceAll])) Then
               strArqDes := StringReplace(strArqDes,'.doc','.odt',[rfReplaceAll]);

            // apaga a carta em word/ods e deixa apenas o pdf exportado
            If LEnviarPdf Then
              Begin
                If FileExists(strArqDes) Then
                  DeleteFile(strArqDes);
              End;

            If (edtDestino.Text = 'V') Then
              begin
                pExecArquivo(IIF(LEnviarPdf,LArqDesPdf,strArqDes), Handle)
              end
            Else If (edtDestino.Text = 'M') Then
              Begin
                {**************************************************************}
                {* SE O ARQUIVO HTML EXITIR, ENVIA A CARTA NO CORPO DO EMAIL, *}
                {* CASO CONTRÁRIO, ENVIA A CARTA Extrajudicial COMO ANEXO. ******}
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
        fMensagem('ATENÇÃO!', 'Modelo de Carta Extrajudicial não encontrado!', ['&O k']);
        blnConfirma := False;
      End;
  Except
    On E: Exception Do
    Begin

      If Assigned(Word) Then
      Begin
        Word.pFechar;
        FreeAndNil(Word);
      End;

      blnConfirma := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmRelCtrCartaExtrajudicial.fValidaCampos(Sender: TWinControl;
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
      If fEmptyStr(cbbModelo.Text) Then
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

procedure TfrmRelCtrCartaExtrajudicial.btnImprimirClick(Sender: TObject);
begin
  Try
    If (edtDestino.Text <> 'M') Then
      inherited
    Else
      blnImprime := fVerificaCampos();

    If not blnImprime Then
      exit;

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
          frmGravando.fExecutarAcao := fGeraCartaExtrajudicial;

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
          fMensagem('ATENÇÃO!', 'Problemas ao gerar a(s) Carta(s) Extrajudicial!', ['&O k']);

        If (blnConfirma) And (chkImpEti.Checked) Then
          pImpEtiquetas;
      End;
  Finally
    qryRelatorio.Close;
    FreeAndNil(cdsRelato);
    FreeAndNil(dspRelato);
    FreeAndNil(cdsRelWrd);

    btnImprimir.Enabled := True;
    pnlInfo.Caption := '';
    pSetFocus(mskDtaIni);
  End;
End;

procedure TfrmRelCtrCartaExtrajudicial.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelCtrCartaExtrajudicial.FormCreate(Sender: TObject);
begin
  inherited;
  blnEmail := True;
  FPais    := FPais;
  strDirPath  := ExtractFilePath(Application.ExeName) + 'CARTAS EXTRAJUDICIAL';

  qryModelos.Connection := frmModulo.GetCurrentConnection;
  qryEmpresa.Connection := frmModulo.GetCurrentConnection;
  {**************************************}
  {* PASSA A FUNCTION PARA O FASTREPORT *}
  {***********************************AC*}
  frxCartaExtrajudicial_M.AddFunction('function fRemoveAcentoEspecificos(Str: String): String');
end;

procedure TfrmRelCtrCartaExtrajudicial.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

function TfrmRelCtrCartaExtrajudicial.frxCartaExtrajudicial_MUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  inherited;
  If MethodName = 'FREMOVEACENTOESPECIFICOS' Then
    Result := UpperCase(fRemoveAcentoEspecificos(Params[0]));
end;

function TfrmRelCtrCartaExtrajudicial.fRemoveAcentoEspecificos(Str:String): String;
Begin
  Result := fRemoveAcento(Str);
end;

function TfrmRelCtrCartaExtrajudicial.fRetornaEmailCliente(
  ADados: TDataset): String;
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

function TfrmRelCtrCartaExtrajudicial.fRetornaPathModelo(strCodMod: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT       ');
  qryAux.SQL.Add('  EXJ_PATEXJ ');
  qryAux.SQL.Add('FROM         ');
  qryAux.SQL.Add('  CAREXJ     ');
  qryAux.SQL.Add('WHERE        ');
  qryAux.SQL.Add('  AUTOINCREM = :CODMOD AND ');
  qryAux.SQL.Add('  EXJ_CODEMP = :CODEMP     ');
  qryAux.ParamByName('CODMOD').AsString := strCodMod;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.Open;
  If Not qryAux.IsEmpty Then
    Result := qryAux.FieldByName('EXJ_PATEXJ').AsString
  Else
    Result := '';
end;

function TfrmRelCtrCartaExtrajudicial.fVirgulaPontoFloatStr(strValor: String): String;
Begin
  Result := AnsiReplaceStr(strValor,',','.');
End;

function TfrmRelCtrCartaExtrajudicial.SelecionaClientes(pgbProgresso: TcxProgressBar): Boolean;
var
  strSQL   : String;
  fltValJur: Double;
  fltValCor: Double;
  strEmpresa: String;
begin
  Result := True;


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

  If rdbEndCob.Checked Then
    Begin
      {*******************************************}
      {* DADOS PARA Extrajudicial                     *}
      {*******************************************}
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

  If (Not fEmptyStr(edtCliente.Text)) Then
    strSQL := strSQL + '    AND CTR_CODCLI = :CODCLI ';

  If (Not fEmptyStr(edtPortador.Text)) Then
    strSQL := strSQL + '    AND CTR_CODPOR = :CODPOR ';

  If (Not fEmptyStr(edtEmpresa.Text)) Then
    strSQL := strSQL + fStrLocate(edtEmpresa, arrEmp, 'CTR_CODEMP', 'CODEMP')
  Else
    strSQL := strSQL + '    AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  strSQL := strSQL + ' ORDER BY CLI_NOMCLI, CTR_DTAVEN, CTR_ESPDOC, CTR_NUMDUP ';

  qryRelatorio.Close;
  qryRelatorio.Params.Clear;
  qryRelatorio.SQL.Clear;
  qryRelatorio.SQL.Add(strSQL);
  qryRelatorio.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
  qryRelatorio.ParamByName('DTAFIM').AsDate := StrToDate(mskDtaFin.Text);

  If (Not fEmptyStr(edtCliente.Text)) Then
    qryRelatorio.ParamByName('CODCLI').AsString := edtCliente.Text;

  If (Not fEmptyStr(edtPortador.Text)) Then
    qryRelatorio.ParamByName('CODPOR').AsString := edtPortador.Text;

  If (Not fEmptyStr(edtEmpresa.Text)) Then
    Begin
      strEmpresa := edtEmpresa.Text;
      pSetaParam(edtEmpresa.Text, arrEmp, strEmpresa , 'CODEMP',qryRelatorio);
    End;

  qryRelatorio.Open;
  pSetaClient(qryRelatorio);

  cdsRelato.Open;
  pSetaClient(cdsRelato);

  blnConfirma := False;

  If qryRelatorio.IsEmpty Then
    Begin
      If (edtDestino.Text = 'M') Then
        fMensagem('', 'Não há dados para enviar o e-mail!', ['&Ok'])
      Else
        fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);

      Exit;
    End;

  cdsRelato.First;
  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := qryRelatorio.RecordCount;

  While Not cdsRelato.Eof Do
  Begin

    {*******************************************}
    {* CALCULA JUROS SE HOUVER                 *}
    {*******************************************}

    fltValJur := fFormataFloat(fCalculaJurosCadCtr(cdsRelato.FieldByName('CTR_DTAVEN').AsDateTime,
                                                   cdsRelato.FieldByName('CTR_VALDUP').AsFloat,
                                                   fCfgSis('JURATR', varDouble)), 2);

    fltValCor := cdsRelato.FieldByName('CTR_VALDUP').AsFloat + fltValJur ;



    cdsRelato.Edit;
    cdsRelato.FieldByName('CTR_CORRIGIDO').AsFloat := fltValCor;
    cdsRelato.FieldByName('CTR_JUROS').AsFloat     := fltValJur;
    cdsRelato.FieldByName('CTR_MULTA').AsFloat     := 0;
    cdsRelato.Post;

    cdsRelato.Next;

    StepStatusSelecao(pgbProgresso);
    Application.ProcessMessages;
  End;

  cdsRelWrd.Data := cdsRelato.Data;
  blnConfirma    := fChamaTelaSelecaoImp;

  If (blnConfirma) And (cdsRelato.IsEmpty) Then
    Begin
      If (edtDestino.Text = 'M') Then
        fMensagem('', 'Não há dados para enviar o e-mail!', ['&Ok'])
      Else
        fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);

      blnConfirma := False;
    End;

end;

procedure TfrmRelCtrCartaExtrajudicial.pAgrupaPorCliente;
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

function TfrmRelCtrCartaExtrajudicial.fChamaTelaSelecaoImp: Boolean;
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
      pMensagensErro(E.Message, '[TfrmRelCtrCartaExtrajudicial.pChamaTelaSelecaoImp]');
    End;
  End;

  pFreeAndNil(frmCtrSelClienteImp);

end;

function TfrmRelCtrCartaExtrajudicial.fClienteSelecionado(strCodCli: String): Boolean;
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

function TfrmRelCtrCartaExtrajudicial.fRetAutoIncremCliente: String;
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

procedure TfrmRelCtrCartaExtrajudicial.pImpEtiquetas;
begin

  fMensagem('ATENÇÃO!','Prepare a impressora ' + IfThen(rdbImpLas.Checked, 'laser/argox', 'matricial') + ' para a imprimir a(s) etiqueta(s)!', ['&O k']);

  intColAtu := 1;

  If (rdbImpLas.Checked) Then
    fImprimeEtiquetaClienteLaser
  Else
    pImpEtiquetasMatricial;
end;

procedure TfrmRelCtrCartaExtrajudicial.pImpEtiquetasMatricial;
  Var
    intContador: Integer;
    intQtdTopo : Integer;
    qryCfgRel  : TUniQuery;
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

procedure TfrmRelCtrCartaExtrajudicial.pAtualizaCamposUso;
begin
  pFinalizaCamposUso;
  pAtribuiCamposUso;
end;

procedure TfrmRelCtrCartaExtrajudicial.pFinalizaCamposUso;
begin
  If cpuCampos <> Nil Then
    FreeAndNil(cpuCampos);
end;

procedure TfrmRelCtrCartaExtrajudicial.pImpRegistro;
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

procedure TfrmRelCtrCartaExtrajudicial.StepStatusSelecao(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmRelCtrCartaExtrajudicial.pImpArrLinhasEti;
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

procedure TfrmRelCtrCartaExtrajudicial.pAtribuiCamposUso;
begin
  If Assigned(cpuCampos) THen
    FreeAndNil(cpuCampos);

  cpuCampos := TCamposUso.Create;
  cpuCampos.AdicionaCampos(cdsRelato, 'CADCLI');
end;

function TfrmRelCtrCartaExtrajudicial.fImprimeEtiquetaClienteLaser: Boolean;
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

end.

