unit untExportaXMLNotasRomaneio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxButtonEdit, DirectoryEditFocus, EditFocus, Vcl.ComCtrls, Uni, cxMemo, Data.DB, 
  untFrameDirectoryEditFocus;

type
  TfrmExportaXMLNotasRomaneio = class(TfrmPai)
    pnlBase: TPanel;
    lblPatExp: TLabel;
    fraPatXML: TfraDirectoryEditFocus;
    lblNumRom: TLabel;
    edtNumRom: TEditFocus;
    pgbProgresso: TProgressBar;
    btnConfirma: TBitBtnLocked;
    memTarefas: TcxMemo;
    procedure edtNumRomKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untConsultas, untFuncoesSimples, untTypesSistema, untRomGer, untLibNfe,
  untTEnvioEmail;

function TfrmExportaXMLNotasRomaneio.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  //#Asimov# inherited fValidaCampos
  If not (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Exit(False);
  //
  Result := True;

  If (Sender = edtNumRom) Then
  Begin
    If (Not fEmptyStr(edtNumRom.Text)) Then
    Begin
      If (Not fRomaneioExiste(edtNumRom.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse romaneio não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'O número de romaneio deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = fraPatXML) Then
  Begin
    If fEmptyStr(fraPatXML.edtDirectory.text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o pasta de importação de arquivos!', ['&Ok']);
      Result := False;
    End

    Else If Not DirectoryExists(fraPatXML.edtDirectory.text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Pasta não econtrada!', ['&Ok']);
      Result := False;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmExportaXMLNotasRomaneio.btnConfirmaClick(Sender: TObject);
  Var
    qryGen : TUniQuery;
    strXML : TStringList;
    intQtd : Integer;
    strAux : String;
    arrArquivos: TStringArray;
begin

  If fVerificaCampos Then
  Begin
    SetLength(arrArquivos, 0);

    strXML := TStringList.Create;
    qryGen := fCriaQuery(Nil);
    Try
      qryGen.SQL.Text :=
            ' SELECT '+
            '   GER_NUMROM AS NUMROM, '+
            '   CONCAT(GER_NUMDOC,"-",GER_ESPDOC,"-",GER_CODEMP) AS NUMDOC, '+
            '   FIS_ACESSO AS ACESSO '+
            ' FROM ROMGERX '+
            '   LEFT JOIN CADFIS ON FIS_NUMDOC = GER_NUMDOC '+
            '                   AND FIS_ESPDOC = GER_ESPDOC '+
            '                   AND FIS_CODEMP = GER_CODEMP '+
            '                   AND FIS_FORCLI = GER_CODCLI '+
            '                   AND FIS_TIP_FC = GER_TIP_FC '+
            ' WHERE '+
            '   GER_NUMROM = :NUMROM AND '+
            '   GER_EMPROM = :EMPROM AND '+
            '   TRIM(IFNULL(FIS_ACESSO,"")) <> "" ';

      qryGen.ParamByName('NUMROM').AsString := edtNumRom.Text;
      qryGen.ParamByName('EMPROM').AsString := VS_strCodEmp;
      qryGen.Open;
      qryGen.First;
      intQtd := qryGen.RecordCount;

      memTarefas.Clear;
      pgbProgresso.Max := intQtd;
      pgbProgresso.Position := 0;
      Application.ProcessMessages;

      If intQtd > 0 Then
      Begin
        memTarefas.Lines.Add('------------------------------------------------------------------------');
        memTarefas.Lines.Add('ROMANEIO: '+qryGen.FieldByName('NUMROM').AsString+'  '+IntToStr(intQtd)+' NOTA(S)');
        memTarefas.Lines.Add('------------------------------------------------------------------------');
        memTarefas.Lines.Add('INICIANDO DOWNLOAD');
        memTarefas.Lines.Add('------------------------------------------------------------------------');
        memTarefas.Lines.Add('');
      End;

      While Not qryGen.Eof Do
      Begin
        strXML.Clear;
        strXML.Text := fXMLNFELibNfe(VS_strCodEmp, qryGen.FieldByName('ACESSO').AsString);

        If Pos('xmlns="http://www.portalfiscal.inf.br/nfe"', strXML.Text) > 0 Then
        Begin
          strAux := qryGen.FieldByName('ACESSO').AsString + '.xml';
          pAddDados(arrArquivos, strAux);
          strXML.SaveToFile(IncludeTrailingPathDelimiter(fraPatXML.edtDirectory.text) + strAux);

          memTarefas.Lines.Add('NOTA '+qryGen.FieldByName('NUMDOC').AsString+' [OK]');
        End
        Else
        Begin
          memTarefas.Lines.Add('NOTA '+qryGen.FieldByName('NUMDOC').AsString+' [ERRO]>'+strXML.Text);
        End;

        pgbProgresso.StepBy(1);
        Application.ProcessMessages;

        qryGen.Next;
      End;

    Finally
      If qryGen.IsEmpty Then
      Begin
        pMensagemOk('Não há arquivos a gerar pois o romaneio informado não teve suas notas autorizadas!')
      End

      Else If Length(arrArquivos) > 0 Then
      Begin
        strAux := 'XML_NF_ROMANEIO_'+edtNumRom.Text+'.ZIP';
        memTarefas.Lines.Add('------------------------------------------------------------------------');
        memTarefas.Lines.Add('COMPACTADANDO ARQUIVOS');
        memTarefas.Lines.Add('------------------------------------------------------------------------');
        CompactarArquivos(IncludeTrailingPathDelimiter(fraPatXML.edtDirectory.text), strAux, arrArquivos);

        If FileExists(IncludeTrailingPathDelimiter(fraPatXML.edtDirectory.text) + strAux) Then
        Begin
          memTarefas.Lines.Add('------------------------------------------------------------------------');
          memTarefas.Lines.Add('XMLS EXPORTADOS COM SUCESSO. COMPACTADOS EM: '+strAux);
          memTarefas.Lines.Add('------------------------------------------------------------------------');

          If Pos('[ERRO]', memTarefas.Text) > 0 Then
            pMensagemOk('Arquivo gerado porém, com ausência de algumas notas. Verifique o log acima!')
          Else
            pMensagemOk('Arquivo gerado com sucesso!');
        End
        Else
        Begin
          memTarefas.Lines.Add('------------------------------------------------------------------------');
          memTarefas.Lines.Add('ERRO AO COMPACTAR OS ARQUIVOS XML');
          memTarefas.Lines.Add('------------------------------------------------------------------------');

          pMensagemOk('Erro ao compactar os arquivos!')
        End;
      End;
      pgbProgresso.Position := 0;
      FreeAndNil(strXML);
      FreeAndNil(qryGen);
    End;
  End;
end;

procedure TfrmExportaXMLNotasRomaneio.edtNumRomKeyPress(Sender: TObject; var Key: Char);
  Var
    qrySel : TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;

  qrySel := fCriaQuery(Nil);
  Try
    If fPesqRomaneio(Self, edtNumRom, qrySel, Key, arrSel, '', True, True, 'Consulta de Romaneios') Then
    Begin
      If (fValidaCampos(edtNumRom, True)) Then
        SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qrySel);
  End;
end;

procedure TfrmExportaXMLNotasRomaneio.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumRom);
end;

end.
