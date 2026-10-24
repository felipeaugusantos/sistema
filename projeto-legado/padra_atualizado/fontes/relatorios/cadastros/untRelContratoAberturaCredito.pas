unit untRelContratoAberturaCredito;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter,
  EditFocus, Buttons, ExtCtrls, QColorLabel, Menus, frxDesgn, frxClass,
  frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS,
  frxExportRTF, AppEvnts, Uni, Mask, MaskEditFocus,
  BitBtnLockedIncrem, untFuncoesGenerica, MaskUtils, frxExportCSVTestabilidade,
  untIFuncoes, untClassPanelCx;

type
  TfrmRelContratoAberturaCredito = class(TfrmPaiRelatorio)
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label2: TLabel;
    edtLimCre: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    mskDtaCon: TMaskEditFocus;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    FPais: TPais;
    procedure pImprimir;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

implementation

uses DB, Windows, ComObj, Printers,strUtils, untTypesSistema, untFuncoesSimples,
     untValorPorExtenso, untCfgRel, untConsultas, untWord, VirtualUI_SDK, untGravando;

{$R *.dfm}

procedure TfrmRelContratoAberturaCredito.btnImprimirClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModalA(pImprimir, 'Aguarde, gerando contrato ...', '');
end;

procedure TfrmRelContratoAberturaCredito.pImprimir;
  Var
    strSQL: String;
    qryEmp: TUniQuery;
    qryCli: TUniQuery;
    Word  : TWord;
    strArqOri    : String;
    strArqDes    : String;
    strNomImp    : String;
begin
  Application.ProcessMessages;
  If blnImprime Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   EMP_NOMEMP, ';
    strSQL := strSQL + '   CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT(", ", EMP_ENDCMP)), IF(IFNULL(EMP_BAIRRO,"") = "", "", CONCAT(", ", EMP_BAIRRO))) AS EMP_ENDERE, ';
    strSQL := strSQL + '   CONCAT(CID_NOMCID, "-" , CID_ESTADO) AS EMP_CIDADE, ';
    strSQL := strSQL + '   EMP_C_G_C_, ';
    strSQL := strSQL + '   EMP_FONE01  ';
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

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CLI_NOMCLI, ';
    strSQL := strSQL + '   CONCAT(CLI_ENDERE, ", ", IFNULL(CLI_ENDNUM, ""), IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT(", ", CLI_ENDCOM)), IF(IFNULL(CLI_BAIRRO,"") = "", "", CONCAT(", ", CLI_BAIRRO))) AS CLI_ENDERE, ';
    strSQL := strSQL + '   CONCAT(CID_NOMCID, " - ", CID_ESTADO) AS CLI_CIDADE, ';
    strSQL := strSQL + '   CLI_C_G_C_, ';
    strSQL := strSQL + '   CLI_NUMR_G, ';
    strSQL := strSQL + '   CLI_FONE01  ';
    strSQL := strSQL + ' FROM   ';
    strSQL := strSQL + '   CADCLI ';
    strSQL := strSQL + '   JOIN CADCID ON CID_CODCID = CLI_CODCID ';
    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '   CLI_CODCLI = "' + edtCodCli.Text +  '"  ';

    qryCli := fCriaQuery(Self);

    With qryCli, SQL Do
    Begin
      Clear;
      Add(strSQL);
      Open;
    End;

    If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'CONTRATOS') Then
      CreateDir(ExtractFilePath(Application.ExeName) + 'CONTRATOS');

    strArqOri := ExtractFilePath(Application.ExeName) + 'CONTRATO_ABERTURA_CREDITO.odt';
    strArqDes := ExtractFilePath(Application.ExeName) + 'CONTRATOS\CONTRATO_ABERTURA_CREDITO_' + edtCodCli.Text + '.odt';

    If Not FileExists(strArqOri) Then
    Begin
      strArqOri := ExtractFilePath(Application.ExeName) + 'CONTRATO_ABERTURA_CREDITO.doc';
      strArqDes := ExtractFilePath(Application.ExeName) + 'CONTRATOS\CONTRATO_ABERTURA_CREDITO_' + edtCodCli.Text + '.doc';
    End;

    If FileExists(strArqOri) Then
    Begin
      Try
        CopyFile(pChar(strArqOri), pChar(strArqDes), False);

        Word := TWord.fCriarWord(Self);

        If Word = Nil Then
          Exit;

        If Not Word.AbrirArquivo(strArqDes) Then
        Begin
          fMensagem('','Não foi possível abrir o arquivo!',['&OK']);
          Exit;
        End;

        Word.pReplace('(emp_nomemp)', qryEmp.FieldByName('EMP_NOMEMP').AsString);
        Word.pReplace('(emp_cidade)', qryEmp.FieldByName('EMP_CIDADE').AsString);
        Word.pReplace('(emp_endere)', qryEmp.FieldByName('EMP_ENDERE').AsString);
        Word.pReplace('(emp_c_g_c_)', fFormataCpfCgc(qryEmp.FieldByName('EMP_C_G_C_').AsString, FPais));
        Word.pReplace('(emp_fone01)', fFormataFone(qryEmp.FieldByName('EMP_FONE01').AsString));
        Word.pReplace('(cli_nomcli)', qryCli.FieldByName('CLI_NOMCLI').AsString);
        Word.pReplace('(cli_cidade)', qryCli.FieldByName('CLI_CIDADE').AsString);
        Word.pReplace('(cli_endere)', qryCli.FieldByName('CLI_ENDERE').AsString);
        Word.pReplace('(cli_c_g_c_)', fFormataCpfCgc(qryCli.FieldByName('CLI_C_G_C_').AsString, FPais));
        Word.pReplace('(RG)', qryCli.FieldByName('CLI_NUMR_G').AsString);
        Word.pReplace('(cli_fone01)', fFormataFone(qryCli.FieldByName('CLI_FONE01').AsString));
        Word.pReplace('(cli_limcre)', 'R$ ' + edtLimCre.Text + ' (' + LowerCase(Trim(fRetExtensoNumero(edtLimCre.Text))) + ')');
        Word.pReplace('(vs_date)',    FormatDateTime('dd "de" mmmm "de" yyyy', StrToDate(mskDtaCon.Text)));

        Word.pSalvar;

        If Not VirtualUI.Active And (edtDestino.Text = 'I') Then
          If fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, edtDestino.Text) Then
            TCfgRel.pPrintReport(Self.Name, ExtractFileName(strArqDes), strNomImp, Word);

        Word.pFechar;  // FECHA O WORD
        FreeAndNil(Word);

        If VirtualUI.Active Then
          VirtualUI.DownloadFile(strArqDes)

        Else If edtDestino.Text = 'V' Then
          pExecArquivo(strArqDes, Handle);

      Except

        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[procedure TfrmRelContratoAberturaCredito.btnImprimirClick(Sender: TObject)]');
        End;

      End

    End
    Else
      fMensagem('','O Arquivo "CONTRATO_ABERTURA_CREDITO.doc" não foi encontrado!',['&Ok']);

    FreeAndNil(qryEmp);
    FreeAndNil(qryCli);

  End;

end;

function TfrmRelContratoAberturaCredito.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('','Cliente não cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If blnValidaIndividual Then
          edtLimCre.Text := FormatFloat('##,#0.00', fCampoTabela('CLI_LIMCRE', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text]));
      End
      Else
      Begin
        fMensagem('','Cliente deve ser informado!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtLimCre) Then
    Begin
      If fStrToFloat(edtLimCre.Text) <= 0 Then
      Begin
        fMensagem('', 'O limite de crédito deve ser maior que zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaCon) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaCon.Text)) Then
      Begin
        fMensagem('', 'A data da emissão do contrato deve ser informada!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelContratoAberturaCredito.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodCli);
end;

procedure TfrmRelContratoAberturaCredito.FormCreate(Sender: TObject);
begin
  inherited;
  FPais := fSetaPais;
end;

procedure TfrmRelContratoAberturaCredito.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;
  mskDtaCon.Text := DateToStr(VS_Date);

  If VirtualUI.Active Then
    edtDestino.Enabled := False;
end;

procedure TfrmRelContratoAberturaCredito.edtCodCliKeyPress(Sender: TObject;
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

end.

