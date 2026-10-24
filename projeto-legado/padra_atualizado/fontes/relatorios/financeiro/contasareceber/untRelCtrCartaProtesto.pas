unit untRelCtrCartaProtesto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, Buttons, Mask, MaskEditFocus, Uni, StrUtils, BitBtnLockedIncrem,
  DB,   DBCtrls, DBLookupComboBoxFocus,
  WordXP, ComObj, UniClientDataSet, UniDataSetProvider, MemDS, DBAccess,
  frxExportCSVTestabilidade, untWordBRO, untWordOfc, untWord, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar;
type
  TfrmRelCtrCartaProtesto = class(TfrmPaiRelatorio)
    lbl1: TLabel;
    lblDesDtaIni: TLabel;
    lbl2: TLabel;
    lblDesDtaFin: TLabel;
    lbl3: TLabel;
    edtCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtEmpresa: TEditFocus;
    lblEmpresa: TLabel;
    lbl4: TLabel;
    edtDiasAtraso: TEditFocus;
    lbl5: TLabel;
    edtTaxaJuros: TEditFocus;
    lbl6: TLabel;
    Label5: TLabel;
    cbbModelo: TDBLookupComboBoxFocus;
    dtsModelos: TDataSource;
    qryModelos: TUniQuery;
    qryModelosPRO_CODPRO: TStringField;
    qryModelosPRO_NOMPRO: TStringField;
    qryModelosPRO_PATPRO: TStringField;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    rgFormaEnvio: TRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    edtTaxaMulta: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtClienteExit(Sender: TObject);
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpresaExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbModeloEnter(Sender: TObject);
    procedure cbbModeloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    cdsRelato: TUniClientDataSet;
    dspRelato: TUniDataSetProvider;

    function fVirgulaPontoFloatStr(strValor: String): String;
    function fGeraCartaProtesto(qryCarta, qryEmpresa: TUniQuery): Boolean;
    function fRetornaPathModelo(strCodMod: String): String;
    function fChamaTelaSelecaoImp: Boolean;
    function fClienteSelecionado(strCodCli: String): Boolean;
    procedure pAgrupaPorCliente;
    function pEnviarEmail(strArquivo, strDestinatario: String): Boolean;
    function fMaiorComprimento(aLinhaAtual, aLinhaNova: Integer; var aComprimento: Integer; aDuplicata: String): Integer;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    function fRemoveAcentoEspecificos(Str:String): String;
  public
    { Public declarations }
  end;

implementation

uses untModulo, untTypesSistema, untIFuncoes, untClassPanelCx,
     untFuncoesSimples, untConsultas, untFuncoes, untCfgRel, untTEnvioEmail, untMemo;

{$R *.dfm}

{ TfrmRelCtrCartaProtesto }

procedure TfrmRelCtrCartaProtesto.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    fltJuros: Double;
    fltMulta: Double;
    strImagem: String;
    strDirImagem: String;
    intDiasAtraso: Integer;
    blnConfirma: Boolean;

    qryCarta: TUniQuery;
    qryEmpresa: TUniQuery;
    LSQLMulta: String;
begin
  fltJuros      := 0;
  strNomImp     := '';
  strTipImp     := '';
  strImagem     := '';
  strDirImagem  := '';
  intDiasAtraso := 0;
  blnConfirma   := False;

  If (edtDestino.Text = 'M') Then
    pnlInfo.Caption := 'Gerando e-Mail...'
  Else
    pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  If (edtDestino.Text <> 'M') Then Begin
    inherited;
  End Else Begin
    blnImprime := fVerificaCampos();
  End;

  If blnImprime Then
  Begin
    {*******************************************}
    {* CALCULA TAXA DE JUROS                   *}
    {****************************************RV*}
    If (Not fEmptyStr(edtTaxaJuros.Text)) And (Not (edtTaxaJuros.Text = '0')) Then
    Begin
      fltJuros := fStrToFloat(edtTaxaJuros.Text);
    End;

    If (Not fEmptyStr(edtDiasAtraso.Text)) And (Not (edtDiasAtraso.Text = '0')) Then
      intDiasAtraso := StrToInt(edtDiasAtraso.Text);

    fltMulta := fStrToFloat(edtTaxaMulta.Text);
    LSQLMulta := '0.00';

    If (fltMulta > 0) Then
      LSQLMulta := '  IF((DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN) > 0),(CTR_VALDUP * ('+fVirgulaPontoFloatStr(FloatToStr(fltMulta))+' / 100)),0) ';

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE CONCAT(CTR_NUMDUP,CTR_PARCEL,"-",CTR_ESPDOC,"-",CTR_CODEMP) AS CTR_NUMDUP, ';
    strSQL := strSQL + '        CTR_PARCEL, ';
    strSQL := strSQL + '        CTR_ESPDOC, ';
    strSQL := strSQL + '        CTR_DTACAD, ';
    strSQL := strSQL + '        CTR_DTAVEN, ';
    strSQL := strSQL + '        CTR_VALORI, ';
    strSQL := strSQL + '        (CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) AS CTR_VALDUP, ';

    {*******************************************}
    {* CALCULA JUROS SE HOUVER                 *}
    {****************************************RV*}
    If (Not (fltJuros = 0)) And (Not (intDiasAtraso = 0)) Then
      strSQL := strSQL + '        (ROUND((CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) + ((CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) * (((' + fVirgulaPontoFloatStr(FloatToStr(fltJuros)) + ' * ' + IntToStr(intDiasAtraso) + ') /30) /100)), 2)  + ' + LSQLMulta +') AS CTR_CORRIGIDO, '
    Else If (Not (fltJuros = 0)) Then
      strSQL := strSQL + '        (ROUND((CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) + ((CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) * (((' + fVirgulaPontoFloatStr(FloatToStr(fltJuros)) + ' * IF(DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN) > 0, DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN), 0)) /30) /100)), 2)  + ' + LSQLMulta +') AS CTR_CORRIGIDO, '
    Else
      strSQL := strSQL + '        ((CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0))  + ' + LSQLMulta +') AS CTR_CORRIGIDO, ';

    strSQL := strSQL + '        CTR_CODCLI, ';
    strSQL := strSQL + '        CLI_NOMCLI, ';
    strSQL := strSQL + '        CLI_EMAIL_, ';
    strSQL := strSQL + '        ' + QuotedStr('S') + ' AS MOSTRA, ';
    If (edtDestino.Text = 'M') Then
      strSQL := strSQL + '        IF (IFNULL(CLI_EMAIL_,'''') = '''',  ' + QuotedStr('D') + ', ' + QuotedStr('M') + ') AS MARDES, '
    else
      strSQL := strSQL + '        ' + QuotedStr('M') + ' AS MARDES, ';
    strSQL := strSQL + '        1 AS QTDTIT, ';
    strSQL := strSQL + '        IF (DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN) > 0, DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN), 0) AS DIAS_ATRASO ';
    strSQL := strSQL + '   FROM CADREC      ';
    strSQL := strSQL + '   JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI ';
    strSQL := strSQL + '  WHERE CTR_DTAREC IS NULL ';
    strSQL := strSQL + '    AND IF (DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN) > 0, DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN), 0) > 0 ';
    strSQL := strSQL + '    AND CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIM ';

    If (Not (intDiasAtraso = 0)) Then
      strSQL := strSQL + '    AND DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN) = :DIAS_ATRASO ';

    If (Not fEmptyStr(edtCliente.Text)) Then
      strSQL := strSQL + '    AND CTR_CODCLI = :CODCLI ';

    If (Not fEmptyStr(edtEmpresa.Text)) Then
      strSQL := strSQL + '    AND CTR_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '    AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + ' ORDER BY CLI_NOMCLI, CTR_DTAVEN, CTR_ESPDOC, CTR_NUMDUP ';

    qryCarta := fCriaQuery(Self);

    cdsRelato := TUniClientDataSet.Create(Self);
    dspRelato := TUniDataSetProvider.Create(Self);
    cdsRelato.SetProvider(dspRelato);
    dspRelato.DataSet := qryCarta;

    With qryCarta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIM').AsDate := StrToDate(mskDtaFin.Text);

      If (Not (intDiasAtraso = 0)) Then
        ParamByName('DIAS_ATRASO').AsString := edtDiasAtraso.Text;

      If (Not fEmptyStr(edtCliente.Text)) Then
        ParamByName('CODCLI').AsString := edtCliente.Text;

      If (Not fEmptyStr(edtEmpresa.Text)) Then
        ParamByName('CODEMP').AsString := edtEmpresa.Text;

      Open;

      If IsEmpty Then
      Begin
        If (edtDestino.Text = 'M') Then
          fMensagem('', 'Não há dados para enviar o e-mail!', ['&Ok'])
        Else
          fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);
        btnImprimir.Enabled := True;
        pnlInfo.Caption     := '';
        Exit;
      End;
    End;

    pSetaClient(qryCarta);
    cdsRelato.Open;
    pSetaClient(cdsRelato);

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSql := strSql + '        CONCAT(EMP_CODEMP,"-",EMP_NOMEMP) AS EMPRESA, ';
    strSQL := strSQL + '        CONCAT(EMP_ENDERE,", ",IFNULL(EMP_ENDNUM,""),"  ",IFNULL(EMP_ENDCMP,"")) AS ENDERECO, ';
    strSQL := strSQL + '        EMP_FONE01 AS TELEFONE, ';
    strSQL := strSQL + '        EMP_FONE02 AS TELEFONE2, ';
    strSQL := strSQL + '        CONCAT(EMP_BAIRRO," - ",CONCAT(CID.CID_NOMCID," - ",IFNULL(CID.CID_ESTADO,""))) AS BAIRRO, ';
    strSQL := strSQL + '        CONCAT(CID.CID_CODCID ,"-", IFNULL(CID.CID_NOMCID,"")) AS CIDADE, ';
    strSQL := strSQL + '        IFNULL(CID.CID_NOMCID,"") AS CIDADE_CARTA, ';
    strSQL := strSQL + '        EMP_C_E_P_ AS CEP, ';
    strSQL := strSQL + '        EMP_F_A_X_, ';
    strSQL := strSQL + '        EMP_CONTAT, ';
    strSQL := strSQL + '        EMP_EMAIL_, ';
    strSQL := strSQL + '        DATE_FORMAT(' + fCurrentDate + ', "%d/%m/%Y") AS DATA ';
    strSQL := strSQL + '   FROM CADEMP EMP ';
    strSQL := strSQL + '   JOIN CADCID CID ON CID.CID_CODCID = EMP.EMP_CODCID ';
    strSQL := strSQL + '  WHERE EMP_CODEMP = :CODEMP ';

    qryEmpresa := fCriaQuery(Self);
    With qryEmpresa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;
    End;

    {*******************************************}
    {* CARREGA IMAGEM                          *}
    {****************************************RV*}
    If FileExists(fCfgSis('PATLOG')) Then
    Begin
      strImagem    := 'S';
      strDirImagem := fCfgSis('PATLOG');
    End
    Else
    Begin
      strImagem    := 'N';
      strDirImagem := '';
    End;

    If qryCarta.IsEmpty Then
      If (edtDestino.Text = 'M') Then
        fMensagem('', 'Não há dados para enviar o e-mail!', ['&Ok'])
      Else
        fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok'])
    Else
    Begin
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

    If blnConfirma Then
    Begin

      If Not fGeraCartaProtesto(qryCarta, qryEmpresa) Then
        fMensagem('ATENÇÃO!', 'Problemas ao gerar a(s) Carta(s) de Aviso de protesto!', ['&O k']);
    End;

    FreeAndNil(qryEmpresa);
    FreeAndNil(qryCarta);
    FreeAndNil(cdsRelato);
    FreeAndNil(dspRelato);
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';
  pnlInfo.Repaint;
  pSetFocus(mskDtaIni);
  
end;

procedure TfrmRelCtrCartaProtesto.cbbModeloEnter(Sender: TObject);
begin
  inherited;

  cbbModelo.KeyValue := qryModelos.FieldByName('PRO_CODPRO').AsString;

end;

procedure TfrmRelCtrCartaProtesto.cbbModeloKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

procedure TfrmRelCtrCartaProtesto.edtClienteExit(Sender: TObject);
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

procedure TfrmRelCtrCartaProtesto.edtClienteKeyPress(Sender: TObject;
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

procedure TfrmRelCtrCartaProtesto.edtEmpresaExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODOS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtEmpresa.Text)) Then
  Begin
    fMensagem('AVISO','Código da Empresa não encontrado',['&O K']);
    edtEmpresa.Clear;
    pSetFocus(edtEmpresa);
  End;
end;

procedure TfrmRelCtrCartaProtesto.edtEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelCtrCartaProtesto.fChamaTelaSelecaoImp: Boolean;
var
  strOrdenacao: String;
  oleDados: OleVariant;
  bVerificarEmail : Boolean;
begin
  Result := False;
  Try
    pAgrupaPorCliente;

    If (edtDestino.Text = 'M') Then
      bVerificarEmail := True
    Else
      bVerificarEmail := False;

    strOrdenacao := '';
    oleDados     := cdsRelato.Data;
    If fRetTelaSelecaoImp(oleDados, strOrdenacao, bVerificarEmail) Then
    begin
      cdsRelato.Data := oleDados;
      if strOrdenacao <> '' then
        cdsRelato.IndexFieldNames := strOrdenacao;

      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmRelCartaCob.pChamaTelaSelecaoImp]');
    End;
  End;
end;

function TfrmRelCtrCartaProtesto.fClienteSelecionado(
  strCodCli: String): Boolean;
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

function TfrmRelCtrCartaProtesto.fGeraCartaProtesto(qryCarta,
  qryEmpresa: TUniQuery): Boolean;
  Var
    strArqOri : String;
    strArqDes : String;
    strLogCit : String;
    strCliAnt : String;
    intLinha  : Integer;
    intQtdLin : Integer;
    intRecno  : Integer;
    fltTotDup : Double;
    stlCarUso : TStringList;
    objWord   : TWord;
    strArqDesHtml: String;
    strEmail: String;
    intMaiorLinha: Integer;
    intComprimento: Integer;
    LEnviarPdf:Boolean;
    LArqDesPdf: String;
    LArqTrava: String;
    LCartaAberta: Boolean;

    procedure pGeraCabDuplicatas;
    begin
      intRecno := qryCarta.RecNo;
      qryCarta.Filtered := False;
      qryCarta.Filter := 'CTR_CODCLI = ' + QuotedStr(strCliAnt);
      qryCarta.Filtered := True;
      intQtdLin := qryCarta.RecordCount + 2;
      qryCarta.Filtered := False;
      qryCarta.RecNo := intRecno;

      if Trim(edtDiasAtraso.Text) <> '' then
      Begin
        objWord.pCriaTabela('{{DUPLIC}}', intQtdLin, 5);
        intLinha := 1;

        objWord.pCelulaNegrito(intLinha, 1);
        objWord.pCelulaEscreve(intLinha, 1, 'TITULO');
        objWord.pCelulaNegrito(intLinha, 2);
        objWord.pCelulaEscreve(intLinha, 2, 'EMISSAO');
        objWord.pCelulaNegrito(intLinha, 3);
        objWord.pCelulaEscreve(intLinha, 3, 'VR. TITULO');
        objWord.pCelulaNegrito(intLinha, 4);
        objWord.pCelulaEscreve(intLinha, 4, 'VR. CORRIGIDO');
        objWord.pCelulaNegrito(intLinha, 5);
        objWord.pCelulaEscreve(intLinha, 5, 'VENCIMENTO');
      End
      Else
      begin
        objWord.pCriaTabela('{{DUPLIC}}', intQtdLin, 6);
        intLinha := 1;

        objWord.pCelulaNegrito(intLinha, 1);
        objWord.pCelulaEscreve(intLinha, 1, 'TITULO');
        objWord.pCelulaNegrito(intLinha, 2);
        objWord.pCelulaEscreve(intLinha, 2, 'DIAS ATR.');
        objWord.pCelulaNegrito(intLinha, 3);
        objWord.pCelulaEscreve(intLinha, 3, 'EMISSAO');
        objWord.pCelulaNegrito(intLinha, 4);
        objWord.pCelulaEscreve(intLinha, 4, 'VR. TITULO');
        objWord.pCelulaNegrito(intLinha, 5);
        objWord.pCelulaEscreve(intLinha, 5, 'VR. CORRIGIDO');
        objWord.pCelulaNegrito(intLinha, 6);
        objWord.pCelulaEscreve(intLinha, 6, 'VENCIMENTO');
      end;

      Inc(intLinha);
    end;

begin
  stlCarUso := TStringList.Create;
  stlCarUso.Duplicates := dupIgnore;
  stlCarUso.Add('--------------------------------------------------------------------');
  stlCarUso.Add(' Abaixo, segue relação dos clientes para os quais não foram gerados ');
  stlCarUso.Add(' os arquivos das cartas de protesto. Certifique se estes arquivos   ');
  stlCarUso.Add(' já existem e se estão sendo utilizados!                            ');
  stlCarUso.Add('--------------------------------------------------------------------');
  intMaiorLinha  := 0;
  intComprimento := 0;
  objWord        := Nil;
  LCartaAberta   := False;
  Try
    If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'CARTAS AVISO DE PROTESTO') Then
      CreateDir(ExtractFilePath(Application.ExeName) + 'CARTAS AVISO DE PROTESTO');

    strArqOri := fRetornaPathModelo(cbbModelo.KeyValue);
    strArqOri := AnsiReplaceStr(strArqOri, '"', '');

    If FileExists(strArqOri) Then
    Begin

      // Sem dono: se o LibreOffice/Word falhar ao ser liberado, a falha não pode impedir a liberação da tela
      // ("A component named frmRelCtrCartaProtesto already exists" ao reabrir). Ele é liberado nesta função.
      objWord := TWord.fCriarWord(Nil);

      With qryCarta Do
      Begin
        First;
        While Not Eof Do
        Begin
          If (Not fClienteSelecionado(FieldByName('CTR_CODCLI').AsString)) Then
          Begin
            Next;
            Continue;
          End;

          strCliAnt := FieldByName('CTR_CODCLI').AsString;
          strEmail  := FieldByName('CLI_EMAIL_').AsString;
          Screen.Cursor := crHourGlass;
          Application.ProcessMessages;

          fltTotDup := 0;

          strArqDes     := ExtractFilePath(Application.ExeName) + 'CARTAS AVISO DE PROTESTO\CARTA_AVISO_DE_PROTESTO_' + FormatDateTime('yyyymmdd', Date) + '-' + FieldByName('CTR_CODCLI').AsString + '.DOC';
          strArqDesHtml := ExtractFilePath(Application.ExeName) + 'CARTAS AVISO DE PROTESTO\CARTA_AVISO_DE_PROTESTO_' + FormatDateTime('yyyymmdd', Date) + '-' + FieldByName('CTR_CODCLI').AsString + '.html';
          LArqDesPdf    := ExtractFilePath(Application.ExeName) + 'CARTAS AVISO DE PROTESTO\CARTA_AVISO_DE_PROTESTO_' + FormatDateTime('yyyymmdd', Date) + '-' + FieldByName('CTR_CODCLI').AsString + '.pdf';

          If FileExists(LArqDesPdf) Then
            DeleteFile(LArqDesPdf);

          If FileExists(strArqDes) Then
          Begin
           // DeleteFile(strArqDes);
            If Not DeleteFile(strArqDes) Then
            Begin
              stlCarUso.Add(' ' + fPadR(FieldByName('CTR_CODCLI').AsString, 8) +  ' - ' +
                            ' ' + fPadR(FieldByName('CLI_NOMCLI').AsString,50)+ ' ');

              While (FieldByName('CTR_CODCLI').AsString = strCliAnt) Do
              Begin
                Next;
                If Eof Then
                  Break;
              End;
              Continue;
            End;

          End;

          // Trava (.~lock) que o LibreOffice de outra sessão deixou ao não liberar a carta: chegando aqui a carta
          // não existe mais (foi apagada acima), então ninguém a tem aberta e a trava é velha. Com ela, a cópia nova
          // abre somente leitura, a tabela das duplicatas não é criada e a geração para em NoSuchElementException.
          LArqTrava := ExtractFilePath(strArqDes) + '.~lock.' + ExtractFileName(strArqDes) + '#';
          If FileExists(LArqTrava) Then
            DeleteFile(LArqTrava);

          CopyFile(pChar(strArqOri), pChar(strArqDes), False);

          objWord.AbrirArquivo(strArqDes);
          LCartaAberta := True;

          {*************************************}
          {* VAI PARA O CABEÇALHO DO DOCUMENTO *}
          {**********************************RV*}
          objWord.pGoToPageHeader;

          strLogCit := ExtractFilePath(Application.ExeName) + 'CITEL.BMP';

          {*************************************}
          {* INSERE E REDIMENSIONA A IMAGEM    *}
          {**********************************RV*}
          If FileExists(fCfgSis('PATLOG')) Then
            strLogCit := fCfgSis('PATLOG');

          {*************************************}
          {* SUBSTITUI OS TEXTOS DO CABEÇALHO  *}
          {**********************************RV*}
          objWord.pInsereImagem(strLogCit);

          objWord.pReplace('{{NOMEMP}}', qryEmpresa.FieldByName('EMPRESA').AsString);
          objWord.pReplace('{{ENDEMP}}', qryEmpresa.FieldByName('ENDERECO').AsString);
          objWord.pReplace('{{BAIEMP}}', qryEmpresa.FieldByName('BAIRRO').AsString);
          objWord.pReplace('{{CEPEMP}}', qryEmpresa.FieldByName('CEP').AsString);
          objWord.pReplace('{{FONEMP}}', qryEmpresa.FieldByName('TELEFONE').AsString);
          objWord.pReplace('{{FAXEMP}}', qryEmpresa.FieldByName('EMP_F_A_X_').AsString);
          objWord.pReplace('{{DTAEMI}}', FormatDateTime('dd/mm/yyyy', qryEmpresa.FieldByName('DATA').AsDateTime));

          {*************************************}
          {* VAI PARA O CORPO DO DOCUMENTO     *}
          {**********************************RV*}
          objWord.pGoToMainDocument;

          {*************************************}
          {* SUBSTITUI OS TEXTOS DO CORPO      *}
          {**********************************RV*}
          objWord.pReplace('{{DATA}}', FormatDateTime('dd/mm/yyyy', VS_Date));
          objWord.pReplace('{{CLINOM}}', FieldByName('CLI_NOMCLI').AsString);
          objWord.pReplace('{{NOMEMP}}', qryEmpresa.FieldByName('EMPRESA').AsString);
          objWord.pReplace('{{DIAATR}}', FieldByName('DIAS_ATRASO').AsString);

          {*************************************}
          {* CRIA UMA TABELA COM AS DUPLICATAS *}
          {**********************************RV*}
          pGeraCabDuplicatas;

          While (FieldByName('CTR_CODCLI').AsString = strCliAnt) Do
          Begin
            if Trim(edtDiasAtraso.Text) <> '' then
            Begin
              objWord.pCelulaEscreve(intLinha, 1, FieldByName('CTR_NUMDUP').AsString);
              objWord.pCelulaEscreve(intLinha, 2, FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTACAD').AsDateTime));
              objWord.pCelulaAlignRight(intLinha, 3);
              objWord.pCelulaEscreve(intLinha, 3, FormatFloat(',0.00', FieldByName('CTR_VALDUP').AsFloat));
              objWord.pCelulaAlignRight(intLinha, 4);
		          objWord.pCelulaEscreve(intLinha, 4, FormatFloat(',0.00', FieldByName('CTR_CORRIGIDO').AsFloat));
              objWord.pCelulaEscreve(intLinha, 5, FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTAVEN').AsDateTime));
              intMaiorLinha := fMaiorComprimento(intMaiorLinha,intLinha,intComprimento,FieldByName('CTR_NUMDUP').AsString);
            End
            else
            begin
              objWord.pCelulaEscreve(intLinha, 1, FieldByName('CTR_NUMDUP').AsString);
              objWord.pCelulaEscreve(intLinha, 2, FieldByName('DIAS_ATRASO').AsString);
              objWord.pCelulaEscreve(intLinha, 3, FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTACAD').AsDateTime));
              objWord.pCelulaAlignRight(intLinha, 4);
              objWord.pCelulaEscreve(intLinha, 4, FormatFloat(',0.00', FieldByName('CTR_VALDUP').AsFloat));
              objWord.pCelulaAlignRight(intLinha, 5);
			        objWord.pCelulaEscreve(intLinha, 5, FormatFloat(',0.00', FieldByName('CTR_CORRIGIDO').AsFloat));
              objWord.pCelulaEscreve(intLinha, 6, FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTAVEN').AsDateTime));
              intMaiorLinha := fMaiorComprimento(intMaiorLinha,intLinha,intComprimento,FieldByName('CTR_NUMDUP').AsString);
            end;

            fltTotDup := fltTotDup + FieldByName('CTR_VALDUP').AsFloat + (FieldByName('CTR_CORRIGIDO').AsFloat - FieldByName('CTR_VALDUP').AsFloat);
            Next;
            Inc(intLinha);
            If Eof Then
              Break;
          End;

          objWord.pCelulaAlignRight(intLinha + 1, 2);
          objWord.pCelulaNegrito(intLinha + 1, 2);
          objWord.pCelulaEscreve(intLinha + 1, 2, 'TOTAIS:');
          objWord.pCelulaAlignRight(intLinha + 1, 3);
          objWord.pCelulaNegrito(intLinha + 1, 3);
          objWord.pCelulaEscreve(intLinha + 1, 3, FormatFloat(',0.00', fltTotDup));

          objWord.pSalvarSemPerguntarFormato;

          if Trim(edtDiasAtraso.Text) <> '' then
          Begin
            objWord.pOtimizaTamanho(1,5, 65);
            objWord.pOtimizaTamanho(1,4, 75);
            objWord.pOtimizaTamanho(1,3, 65);
            objWord.pOtimizaTamanho(2,2, 65);
            objWord.pOtimizaTamanho(intMaiorLinha,1, 125);
          End Else
          Begin
            objWord.pOtimizaTamanho(1,6, 65);
            objWord.pOtimizaTamanho(1,5, 75);
            objWord.pOtimizaTamanho(1,4, 65);
            objWord.pOtimizaTamanho(1,2, 65);
            objWord.pOtimizaTamanho(2,3, 65);
            objWord.pOtimizaTamanho(intMaiorLinha,1, 125);
          End;

          LEnviarPdf := (rgFormaEnvio.ItemIndex = 1);
          objWord.pSalvarSemPerguntarFormato;

          // exporta carta criada em word/ods para PDF
          If LEnviarPdf Then
            objWord.SaveAsPDF(LArqDesPdf);
          
          If (edtDestino.Text = 'I') Then
            TCfgRel.pPrintReport(Self.Name, ExtractFileName(strArqDes), strNomImp, objWord);

          If (edtDestino.Text = 'M') Then
            objWord.pSaveAsHtml;

          objWord.pFechar;
          LCartaAberta := False;

          If (edtDestino.Text = 'V') Then
            pExecArquivo(IIF(LEnviarPdf,LArqDesPdf,strArqDes), Handle)
          Else If (edtDestino.Text = 'M') Then
          Begin
            Sleep(1000);
            If Not LEnviarPdf And FileExists(strArqDesHtml) Then
            begin
              If (Not pEnviarEmail(strArqDesHtml, strEmail)) Then
              Begin
                Screen.Cursor := crDefault;
                Break;
              End;
            end
            else
            begin
              If (Not pEnviarEmail(IIF(LEnviarPdf,LArqDesPdf,strArqDes), strEmail)) Then
              Begin
                Screen.Cursor := crDefault;
                Break;
              End;
            end;
          End;

        End;

        Application.ProcessMessages;
        Screen.Cursor := crDefault;

        If stlCarUso.Count > 5 Then
        Begin
          pCriarFormularios(TfrmMemo, frmMemo);
          Try

            frmMemo.cxMemo.Lines.Assign(stlCarUso);
            SetForegroundWindow(Self.Handle);
            frmMemo.ShowModal;
          Finally
            FreeAndNil(frmMemo);
          End;

        End;

        FreeAndNil(stlCarUso);

      End;
      SetForegroundWindow(Self.Handle);
      FreeAndNil(objWord);
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

      // Fecha a carta que ficou aberta e libera o LibreOffice/Word: aberta, a carta segue presa e a próxima
      // geração deste cliente cai na lista de arquivos em uso.
      If Assigned(objWord) Then
      Begin
        Try
          Try
            If LCartaAberta Then
              objWord.pFechar;
          Finally
            FreeAndNil(objWord);
          End;
        Except
          // LibreOffice/Word já encerrado (ex.: finalizado pelo Gerenciador de Tarefas): não há o que fechar, e o
          // erro que interessa ao operador já foi mostrado acima.
        End;
      End;

      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmRelCtrCartaProtesto.fMaiorComprimento(aLinhaAtual,
  aLinhaNova: Integer; var aComprimento: Integer; aDuplicata: String): Integer;
begin
  If Length(aDuplicata) > aComprimento Then
  Begin
    aComprimento := Length(aDuplicata);
    Result  := aLinhaNova;
  end else
    Result := aLinhaAtual;
end;

procedure TfrmRelCtrCartaProtesto.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelCtrCartaProtesto.FormCreate(Sender: TObject);
begin
  inherited;
  qryModelos.Connection := frmModulo.GetCurrentConnection;
end;

procedure TfrmRelCtrCartaProtesto.FormShow(Sender: TObject);
begin
  mskDtaIni.Text     := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text     := FormatDateTime('dd/mm/yyyy',VS_Date);
  edtTaxaJuros.Text  := FloatToStrF(fCfgSis('JURATR', varDouble), ffFixed, 12, 2);
  edtTaxaMulta.Text  := FloatToStrF(fCfgSis('MULATR', varDouble), ffFixed, 12, 2);
  edtEmpresa.Text    := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;
  inherited;

  qryModelos.Close;
  qryModelos.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryModelos.Open;
  qryModelos.First;

  blnEmail := True;
end;

function TfrmRelCtrCartaProtesto.fRemoveAcentoEspecificos(Str: String): String;
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

function TfrmRelCtrCartaProtesto.fRetornaPathModelo(strCodMod: String): String;
  Var
    qryAux: TUniQuery;
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT       ';
  strSQL := strSQL + '  PRO_PATPRO ';
  strSQL := strSQL + 'FROM         ';
  strSQL := strSQL + '  CARPRO     ';
  strSQL := strSQL + 'WHERE        ';
  strSQL := strSQL + '  PRO_CODPRO = :CODMOD AND ';
  strSQL := strSQL + '  PRO_CODEMP = :CODEMP     ';
  qryAux := fCriaQuery(Self);
  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODMOD').AsString := strCodMod;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    If Not IsEmpty Then
      Result := FieldByName('PRO_PATPRO').AsString
    Else
      Result := '';
  End;
end;

function TfrmRelCtrCartaProtesto.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

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
        If Pos(edtEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
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
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmRelCtrCartaProtesto.fVirgulaPontoFloatStr(
  strValor: String): String;
begin
  Result := AnsiReplaceStr(strValor,',','.');
end;

procedure TfrmRelCtrCartaProtesto.pAgrupaPorCliente;
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

function TfrmRelCtrCartaProtesto.pEnviarEmail(strArquivo,
  strDestinatario: String): Boolean;
  Var
    arrArquivos, arrDestinatarios : TStringArray;
begin
  pCriarArrayAnexosEDestinatarios(strArquivo, strDestinatario, arrDestinatarios, arrArquivos);

  Result := TEnvioEmail.EnviarEmail(Self,
                                    strLoginUsuarioLogado,
                                    'Carta de aviso de Protesto',
                                    arrDestinatarios,
                                    [],
                                    [],
                                    ['Segue em anexo carta de aviso de protesto.'],
                                    arrArquivos,
                                    False);

end;

end.
