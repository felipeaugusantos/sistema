unit untCadReceitAgronomicoExpFitoSanitario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  Uni, cxProgressBar, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  MaskEditFocus, EditFocus, DirectoryEditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  Data.DB, 
  untFrameDirectoryEditFocus;

type
  TfrmCadReceitAgroExpFitoSanitario = class(TfrmPaiSimples)
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label2: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lbl4: TLabel;
    edtCodRes: TEditFocus;
    edtNomRes: TEditFocus;
    lbl2: TLabel;
    lbl5: TLabel;
    edtNumArt: TEditFocus;
    edtNumRec: TEditFocus;
    Label5: TLabel;
    btnExportar: TBitBtnLocked;
    dtrCaminhoArq: TfraDirectoryEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodResKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodResExit(Sender: TObject);
  private
    function fExporta: Boolean; Overload;
    procedure pLimpaTela;
    function fExporta(cxProgressBar : TcxProgressBar):Boolean; Overload;
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean;Override;
  end;

var
  frmCadReceitAgroExpFitoSanitario: TfrmCadReceitAgroExpFitoSanitario;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas, untGravando,
  untFuncoesGenerica;

{ TfrmCadReceitAgronomicoExpFitoSanitario }

procedure TfrmCadReceitAgroExpFitoSanitario.btnExportarClick(Sender: TObject);
begin
  inherited;

  If (Not fVerificaCampos()) Then
    Exit;

  fAtuCfgSis('PATFSA', IncludeTrailingPathDelimiter(dtrCaminhoArq.edtDirectory.Text));

  If fExporta Then
    fMensagem('', 'Fim da geração dos arquivos!', ['&OK']);
end;

function TfrmCadReceitAgroExpFitoSanitario.fExporta:Boolean;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.fExecutarAcao := fExporta;
  frmGravando.ShowModal;
  Result := frmGravando.blnConfirma;
  FreeAndNil(frmGravando);
End;

function TfrmCadReceitAgroExpFitoSanitario.fExporta(cxProgressBar : TcxProgressBar):Boolean;
  Var
    qryNota: TUniQuery;
    stlArquivo: TStringList;
    strFiltroNota: String;

  Const
    SQL_NOTA = 'SELECT DISTINCT ' +
                    '  MOVGRO.AUTOINCREM AS AUTINC, ' +
                    '  MGR_NOTFIS AS NUMDOC, ' +
                    '  MGR_DTANOT AS DTAENT, ' +
                    '  DIV_NOMDIV AS NOMAGR, ' +
                    '  CLI_CODCLI AS CODCLI, ' +
                    '  CLI_NOMCLI AS NOMCLI, ' +
                    '  CONCAT(CLI_ENDERE, ", ", CLI_ENDNUM) AS ENDCLI, ' +
                    '  CLI_BAIRRO AS BAICLI, ' +
                    '  CLI_C_E_P_ AS CEPCLI, ' +
                    '  MGR_CIDCLI AS CIDCLI, ' +
                    '  MGR_ESTCLI AS ESTCLI, ' +
                    '  CLI_C_G_C_ AS C_G_C_, ' +
                    '  MGR_INSCLI AS INSCLI, ' +
                    '  CLI_CONTAT AS CONTAT, ' +
                    '  IFNULL(CLI_FONE01, CLI_FONE02) AS TELCLI, ' +
                    '  CLI_F_A_X_ AS F_A_X_, ' +
                    '  CLI_EMAIL_ AS EMAIL_, ' +
                    '  CLI_HOMEPA AS HOMEPA, ' +

                    '  FAZ_CODFAZ AS CODFAZ, ' +
                    '  FAZ_NOMFAZ AS NOMFAZ, ' +
                    '  CONCAT(FAZ_ENDERE, ", ", FAZ_ENDNUM) AS ENDERE, ' +
                    '  FAZ_C_E_P_ AS C_E_P_, ' +
                    '  CID_NOMCID AS CIDADE, ' +
                    '  CID_ESTADO AS ESTADO, ' +
                    '  FAZ_C_G_C_ AS FAZCGC, ' +
                    '  FAZ_I_E_S_ AS FAZIES, ' +
                    '  ""         AS INCRA_, ' +
                    '  0          AS AREA__, ' +
                    '  FAZ_NOMCON AS CONTAT, ' +
                    '  FAZ_TELCON AS TELFAZ, ' +
                    '  ""         AS FAXFAZ, ' +
                    '  ""         AS FAZEMA, ' +

                    '  ITE_CODITE AS CODITE, ' +
                    '  ITE_DESITE AS DESITE, ' +
                    '  ""         AS CODCUL, ' +
                    '  MGR_CULTUR AS DESCUL, ' +
                    '  MGR_AREREC AS AREREC, ' +
                    '  MGR_TOTADQ AS TOTADQ, ' +
                    '  4          AS UNIADQ  ' +

                    'FROM ' +
                    '  MOVGRO ' +
                    '  LEFT JOIN CADDIV ' +
                    '    ON DIV_CODDIV = MGR_CODRES ' +
                    '  LEFT JOIN CADCLI ' +
                    '    ON CLI_CODCLI = MGR_CODCLI ' +
                    '  LEFT JOIN CADFAZ ' +
                    '    ON FAZ_CODFAZ = MGR_CODFAZ ' +
                    '  LEFT JOIN CADCID ' +
                    '    ON CID_CODCID = FAZ_CODCID ' +
                    '  INNER JOIN CADITE ' +
                    '    ON MGR_CODITE = ITE_CODITE ' +
                    'WHERE <<FILTROS>> ' +
                    'GROUP BY MGR_NOTFIS, MGR_DTANOT, CLI_CODCLI, MGR_CODRES, MGR_ARTIGO ' +
                    'ORDER BY MGR_ARTIGO ';

  procedure pCriarQuerys; begin
    qryNota := fCriaQuery(Self);
    qryNota.Close();
    qryNota.SQL.Clear();
    qryNota.SQL.Add(SQL_NOTA);
  end;

  function fRemoverCaractInvalidos(strTexto: String): String; begin
    Result := StringReplace(strTexto,
                            '"',
                            ' ',
                            [rfReplaceAll]);

    Result := StringReplace(strTexto,
                            ';',
                            ' ',
                            [rfReplaceAll]);

    Result := Trim(Result);
  end;

Begin
  Result := True;

  Try
    stlArquivo := TStringList.Create();
    pCriarQuerys();

    Try
      strFiltroNota := ' MGR_DTANOT BETWEEN :DTAINI AND :DTAFIM ';

      If Not fEmptyStr(edtCodCli.Text) Then
        strFiltroNota := strFiltroNota + ' AND MGR_CODCLI = ' + QuotedStr(edtCodCli.Text);

      If Not fEmptyStr(edtCodRes.Text) Then
        strFiltroNota := strFiltroNota + ' AND MGR_CODRES = ' + QuotedStr(edtCodRes.Text);

      If Not fEmptyStr(edtNumArt.Text) Then
        strFiltroNota := strFiltroNota + ' AND MGR_ARTIGO = ' + QuotedStr(edtNumArt.Text);

      If Not fEmptyStr(edtNumRec.Text) Then
        strFiltroNota := strFiltroNota + ' AND MGR_NUMREC = ' + QuotedStr(edtNumRec.Text);

      qryNota.SQL.Text := StringReplace(qryNota.SQL.Text,
                                        '<<FILTROS>>',
                                        strFiltroNota,
                                        [rfReplaceAll]);

      qryNota.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      qryNota.ParamByName('DTAFIM').AsDate := StrToDate(mskDtaFin.Text);

      qryNota.Open();

      qryNota.First();

      If (qryNota.IsEmpty) Then Begin
        fMensagem('ATENÇÃO!', 'Não há registros para geração do arquivo!', ['&OK']);
        pLimpaTela();
        Result := False;
        Exit;
      End;

      cxProgressBar.Properties.Max := qryNota.RecordCount;
      cxProgressBar.Position := 0;

      While (Not qryNota.Eof) Do Begin
        //DADOS DA NOTA FISCAL
        stlArquivo.Add('/u"' + fRemoverCaractInvalidos(qryNota.FieldByName('NUMDOC').AsString) + '";' +
                         '"' + FormatDateTime('ddmmyyyy',
                            qryNota.FieldByName('DTAENT').AsDateTime) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('NOMAGR').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('CODCLI').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('NOMCLI').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('ENDCLI').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('BAICLI').AsString) + '";' +
                         '"";' +
                         '"' + fRemoverCaractInvalidos(fFormataCEP(fRetSomenteNumeros(
                             qryNota.FieldByName('CEPCLI').AsString))) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('CIDCLI').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('ESTCLI').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(fFormataCpfCgc(fTiraCaracEspeciaisPonto(
                              qryNota.FieldByName('C_G_C_').AsString), fSetaPais())) + '";' +
                         '"' + fRemoverCaractInvalidos(fRetSomenteNumeros(
                              qryNota.FieldByName('INSCLI').AsString)) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('CONTAT').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(fFormataFone(fRetSomenteNumeros(
                             qryNota.FieldByName('TELCLI').AsString))) + '";' +
                         '"' + fRemoverCaractInvalidos(fFormataFone(fRetSomenteNumeros(
                             qryNota.FieldByName('F_A_X_').AsString))) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('EMAIL_').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('HOMEPA').AsString) + '";');

        stlArquivo.Add('/f"' + fRemoverCaractInvalidos(qryNota.FieldByName('CODFAZ').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('NOMFAZ').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('ENDERE').AsString) + '";' +
                         '"";' +
                         '"' + fRemoverCaractInvalidos(fFormataCEP(fRetSomenteNumeros(
                             qryNota.FieldByName('C_E_P_').AsString))) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('CIDADE').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('ESTADO').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(fFormataCpfCgc(fTiraCaracEspeciaisPonto(
                              qryNota.FieldByName('FAZCGC').AsString), fSetaPais())) + '";' +
                         '"' + fRemoverCaractInvalidos(fRetSomenteNumeros(
                              qryNota.FieldByName('FAZIES').AsString)) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('INCRA_').AsString) + '";' +
                         '"' + FormatFloat('#0.00',
                               qryNota.FieldByName('AREA__').AsFloat) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('CONTAT').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(fFormataFone(fRetSomenteNumeros(
                             qryNota.FieldByName('TELFAZ').AsString))) + '";' +
                         '"' + fRemoverCaractInvalidos(fFormataFone(fRetSomenteNumeros(
                             qryNota.FieldByName('FAXFAZ').AsString))) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('FAZEMA').AsString) + '";');

        stlArquivo.Add('/p"' + fRemoverCaractInvalidos(qryNota.FieldByName('CODITE').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('DESITE').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('CODCUL').AsString) + '";' +
                         '"' + fRemoverCaractInvalidos(qryNota.FieldByName('DESCUL').AsString) + '";' +
                         '"' + FormatFloat('#0.00',
                               qryNota.FieldByName('AREREC').AsFloat) + '";' +
                         '"' + FormatFloat('#0.00',
                               qryNota.FieldByName('TOTADQ').AsFloat) + '";' +
                         '"' + qryNota.FieldByName('UNIADQ').AsString + '";');

        qryNota.Next();

        cxProgressBar.Position := qryNota.RecNo;

        If (qryNota.RecNo Mod 100) = 0 Then
          Application.ProcessMessages;
      End;

      stlArquivo.SaveToFile(dtrCaminhoArq.edtDirectory.text + '\' + FormatDateTime('yyyymmddhhmmss', fNow()) + '.frp');

      pLimpaTela();
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmCadReceitAgronomicoExpFitoSanitario.fExporta');
      End;
    End;
  Finally
    FreeAndNil(stlArquivo);
    FreeAndNil(qryNota);
  End;
End;

procedure TfrmCadReceitAgroExpFitoSanitario.edtCodCliExit(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(edtCodCli.Text)) Then
    edtNomCli.Text := 'TODOS';
end;

procedure TfrmCadReceitAgroExpFitoSanitario.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCliente: TConsultasArray;
Begin
  If fEntraCons(Key) Then
  Begin
    If fPesqCliente(conCliCompleta, Self, edtCodCli, edtNomCli, Nil, Key, arrCliente) Then
    Begin
      If fValidaCampos(edtCodCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadReceitAgroExpFitoSanitario.edtCodResExit(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(edtCodRes.Text)) Then
    edtNomRes.Text := 'TODOS';
end;

procedure TfrmCadReceitAgroExpFitoSanitario.edtCodResKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrResp: TConsultasArray;
Begin
  If fPesqDiversos(Self, edtCodRes, edtNomRes, Nil, Key, arrResp) Then
  Begin
    If fValidaCampos(edtCodRes, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadReceitAgroExpFitoSanitario.FormShow(Sender: TObject);
  Var
    strDir : String;
begin
  inherited;
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  pSetFocus(mskDtaIni);

  strDir := fCfgSisL('PATFSA');

  If (not fEmptyStr(strDir)) And DirectoryExists(strDir) Then
    dtrCaminhoArq.edtDirectory.Text := IncludeTrailingPathDelimiter(strDir);
end;

function TfrmCadReceitAgroExpFitoSanitario.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
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

      If Result Then
        Try
          TMaskEditFocus(Sender).Text := DateToStr(StrToDate(TMaskEditFocus(Sender).Text));
        Except
        End;

    End

    Else
    If (Sender = edtCodCli) Then
    Begin
      If not fEmptyStr(edtCodCli.Text) Then
      Begin
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este cliente não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodRes) Then
    Begin

      If not fEmptyStr(edtCodRes.Text) Then
      Begin
        edtNomRes.Text := fRetNomDiversos(edtCodRes.Text);
        If fEmptyStr(edtNomRes.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este responsável não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End
      Else
        edtCodRes.Clear;

    End

    Else
    If(Sender = edtNumArt) Then
    Begin
      If (Not fEmptyStr(edtNumArt.Text)) And (Length(edtNumArt.Text) > 20) Then Begin
        fMensagem('ATENÇÃO!', 'O Número do ART deve conter no máximo 20 caracteres!', ['&OK']);
        Result := False;
      End;
    End

    Else
    If (Sender  = dtrCaminhoArq) Then
    Begin
      Result := DirectoryExists(dtrCaminhoArq.edtDirectory.text);

      If Not Result Then
        fMensagem('','Diretório inválido!', ['&OK']);
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadReceitAgroExpFitoSanitario.pLimpaTela;
begin
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

  edtCodCli.Text := '';
  edtNomCli.Text := '';
  edtCodRes.Text := '';
  edtNomRes.Text := '';
  edtNumArt.Text := '';
  edtNumRec.Text := '';

  pSetFocus(mskDtaIni);
end;

end.
