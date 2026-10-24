unit untCadReceitAgronomicoExpCrea;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  Uni, cxProgressBar, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  MaskEditFocus, EditFocus, DirectoryEditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmCadReceitAgronomicoExpCrea = class(TfrmPaiSimples)
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
    DirectoryEditFocus: TfraDirectoryEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodResKeyPress(Sender: TObject; var Key: Char);
  private
    function fExporta: Boolean; Overload;
    function fExporta(cxProgressBar : TcxProgressBar):Boolean; Overload;
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean;Override;
  end;

var
  frmCadReceitAgronomicoExpCrea: TfrmCadReceitAgronomicoExpCrea;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas, untGravando;

{ TfrmCadReceitAgronomicoExpCrea }

procedure TfrmCadReceitAgronomicoExpCrea.btnExportarClick(Sender: TObject);
begin
  inherited;
  if not fVerificaCampos Then
    Exit;

  fAtuCfgSis('PATCRE', IncludeTrailingPathDelimiter(DirectoryEditFocus.edtDirectory.Text));

  If fExporta Then
    fMensagem('', 'Fim da geração dos arquivos!', ['&OK']);

end;

function TfrmCadReceitAgronomicoExpCrea.fExporta:Boolean;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.fExecutarAcao := fExporta;
  frmGravando.ShowModal;
  Result := frmGravando.blnConfirma;
  FreeAndNil(frmGravando);

End;

function TfrmCadReceitAgronomicoExpCrea.fExporta(cxProgressBar : TcxProgressBar):Boolean;
  Var
    qryQuery : TUniQuery;
    strArtigo: String;
    strLinAux: String;
    txtFile  : TextFile;
    intValidadeReceituario: Integer;
    procedure pEscreveArquivo(strLinha : String);
    Begin
      WriteLn(txtFile, strLinha);
    End;

    procedure pAbreArquivo;
    Begin
      AssignFile(txtFile, IncludeTrailingPathDelimiter(DirectoryEditFocus.edtDirectory.Text) + 'contratos_art_' + strArtigo + '.txt' );
      ReWrite(txtFile);
      pEscreveArquivo('#Numero de Ordem#Contratante#Telefone#CPF/CNPJ#Logradouro#Número#CEP#Valor do Contrato#Início#Término#');
    End;

    procedure pSalvaArquivo;
    Begin
      CloseFile(txtFile);
    End;

Begin
  intValidadeReceituario := fCfgSis('VALREC', varInteger);

  Result := True;
  Try
    Try
      qryQuery := fCriaQuery(Self);
      With qryQuery, SQL Do
      Begin
        Close;
        Clear;

        Add(' SELECT SQL_NO_CACHE                          ');
        Add('        MGR_ARTIGO,                           ');
        Add('        MGR_NUMREC,                           ');
        Add('        CLI_NOMCLI,                           ');
        Add('        CLI_FONE01,                           ');
        Add('        CLI_C_G_C_,                           ');
        Add('        CLI_ENDERE,                           ');
        Add('        CLI_ENDNUM,                           ');
        Add('        CLI_C_E_P_,                           ');
        Add('        MGR_TOTADQ,                           ');
        Add('        MGR_DTANOT                            ');
        Add(' FROM MOVGRO                                  ');
        Add(' INNER JOIN CADCLI ON CLI_CODCLI = MGR_CODCLI ');
        Add(' WHERE TRUE                                   ');

        If Not fEmptyStr(edtCodCli.Text) Then
          Add(' AND MGR_CODCLI = ' + QuotedStr(edtCodCli.Text));

        if Not fEmptyStr(edtCodRes.Text) Then
          Add(' AND MGR_CODRES = ' + QuotedStr(edtCodRes.Text) );

        If Not fEmptyStr(edtNumArt.Text) Then
          Add(' AND MGR_ARTIGO = ' + QuotedStr(edtNumArt.Text));

        If Not fEmptyStr(edtNumRec.Text) Then
          Add(' AND MGR_NUMREC = ' + QuotedStr(edtNumRec.Text));

        Add(' ORDER BY MGR_ARTIGO                          ');

        Open;

        cxProgressBar.Properties.Max := RecordCount;
        cxProgressBar.Position := 0;

        strArtigo := '';

        While Not Eof Do
        Begin
          If (strArtigo <> FieldByName('MGR_ARTIGO').AsString) Then
          Begin
            strArtigo := FieldByName('MGR_ARTIGO').AsString;
            pAbreArquivo;
          End;

          strLinAux := '#';
          strLinAux := strLinAux + FieldByName('MGR_NUMREC').AsString + '#';
          strLinAux := strLinAux + FieldByName('CLI_NOMCLI').AsString + '#';
          strLinAux := strLinAux + fRetSomenteNumeros(FieldByName('CLI_FONE01').AsString) + '#';
          strLinAux := strLinAux + fTiraCaracEspeciaisPonto(FieldByName('CLI_C_G_C_').AsString) + '#';
          strLinAux := strLinAux + FieldByName('CLI_ENDERE').AsString + '#';
          strLinAux := strLinAux + FieldByName('CLI_ENDNUM').AsString + '#';
          strLinAux := strLinAux + fRetSomenteNumeros(FieldByName('CLI_C_E_P_').AsString) + '#';
          strLinAux := strLinAux + FormatFloat('#0.00',FieldByName('MGR_TOTADQ').AsFloat) + '#';
          strLinAux := strLinAux + FormatDateTime('dd/mm/yyyy',FieldByName('MGR_DTANOT').AsDateTime) + '#';
          strLinAux := strLinAux + FormatDateTime('dd/mm/yyyy',FieldByName('MGR_DTANOT').AsDateTime + intValidadeReceituario) + '#';

          pEscreveArquivo( strLinAux );

          strArtigo := FieldByName('MGR_ARTIGO').AsString;

          Next;

          If (strArtigo <> FieldByName('MGR_ARTIGO').AsString) Or Eof Then
            pSalvaArquivo;

          cxProgressBar.Position := RecNo;

          If (RecNo Mod 100) = 0 Then
            Application.ProcessMessages;

        End;

      End;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmCadReceitAgronomicoExpCrea.fExporta');
      End;
    End;
  Finally
    FreeAndNil(qryQuery);
  End;

End;

procedure TfrmCadReceitAgronomicoExpCrea.edtCodCliKeyPress(Sender: TObject;
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

procedure TfrmCadReceitAgronomicoExpCrea.edtCodResKeyPress(Sender: TObject;
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

procedure TfrmCadReceitAgronomicoExpCrea.FormShow(Sender: TObject);
  Var
    strDir : String;
begin
  inherited;
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  pSetFocus(mskDtaIni);

  strDir := fCfgSisL('PATCRE');

  If (not fEmptyStr(strDir)) And DirectoryExists(strDir) Then
    DirectoryEditFocus.edtDirectory.Text := IncludeTrailingPathDelimiter(strDir);

end;

function TfrmCadReceitAgronomicoExpCrea.fValidaCampos(Sender: TWinControl;
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
      End
      Else
        edtNomCli.Clear;

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
    If (Sender  = DirectoryEditFocus) Then
    Begin
      Result := DirectoryExists(DirectoryEditFocus.edtDirectory.text);

      If Not Result Then
        fMensagem('','Diretório inválido!', ['&OK']);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

end.
