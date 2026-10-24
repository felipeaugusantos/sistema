unit untDesagrupCtaPag;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untTypesSistema,
  untFuncoesConsulta, untConsultas, untPesqAux, System.IoUtils;

type
  TfrmDesagrupCtaPag = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    edtNumAgr: TEditFocus;
    Label1: TLabel;
    Label6: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label5: TLabel;
    edtNomFor: TEditFocus;
    edtCodFor: TEditFocus;
    btnConfirmaCtaPag: TBitBtnLocked;
    btnSairCtaPag: TBitBtnLocked;
    pnlRodape: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairCtaPagClick(Sender: TObject);
    procedure btnConfirmaCtaPagClick(Sender: TObject);
    procedure edtNumAgrExit(Sender: TObject);
  private
    { Private declarations }
    arrFornec: TConsultasArray;

    qryConFor: TUniQuery;

    function fDesagrupaDuplicatas(strNumAgr: String): Boolean;
    procedure GravaLogCtp(AAutoIncrem, strDescricaoLog: String);

  protected

    procedure pCarregaFornecedor;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    function fRetornaNumeroAgrFormatado: String;


  public
    { Public declarations }
  end;


implementation

uses  untConstantes, untfuncoesSimples, untCadPag, untLogCtp;

{$R *.dfm}

procedure TfrmDesagrupCtaPag.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumAgr);

  edtCodEmp.Text     := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresaSelec(VS_strCodEmp);

  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
end;

function TfrmDesagrupCtaPag.fRetornaNumeroAgrFormatado: String;
const
  SIGLA_AG = 'AG';
  DIG_APOS_AG = 10;
begin
  Result := '';

  if (Length(edtNumAgr.Text) <= DIG_APOS_AG) then
  begin
    Result := SIGLA_AG + fStrZero(edtNumAgr.Text, DIG_APOS_AG);
  end
  else
  begin
    Result := fStrZero(edtNumAgr.Text, 12);
  end;
end;

function TfrmDesagrupCtaPag.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumAgr) Then
    Begin
      If (fEmptyStr(edtNumAgr.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número do Agrupamento deve ser preenchido!', ['&O k']);
        Result := False;
      End
    End
    Else If (Sender = edtCodFor) Then
    Begin
      If (Not fEmptyStr(edtCodFor.Text)) Then
      Begin

        pCarregaFornecedor;
        If fEmptyStr(edtNomFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
          pSetFocus(edtCodFor);
        End
        Else If edtCodFor.Text = '' Then
        Begin
          fMensagem('ATENÇÃO!', 'O fornecedor deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  End;
End;


procedure TfrmDesagrupCtaPag.GravaLogCtp(AAutoIncrem, strDescricaoLog: String);
begin
  Try
    untLogCtp.GravaLogCtp(AAutoIncrem,
                          strDescricaoLog,
                          Self.Name);
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[frmAgrupDuplicatasCtp.GravaLogCtp]');
  End;
end;


procedure TfrmDesagrupCtaPag.btnConfirmaCtaPagClick(Sender: TObject);
Var
  strChvLoc: String;
  sltAutInc: TStringList;
  intIndex: Integer;
  blnConfirma: Boolean;

begin
  inherited;
            {****** VALIDAR CAMPO DESAGRUPAMENTO ******;;;}
            if fEmptyStr(edtNumAgr.Text) Then
            Begin
              fMensagem('ATENÇÃO', 'Informe número de agrupamento/fornecedor para realizar o desagrupamento', ['&O k']);
              blnConfirma:= False;
            End
            Else if fEmptyStr(edtCodFor.Text) Then
            Begin
              fMensagem('ATENÇÃO', 'Informe número de agrupamento/fornecedor para realizar o desagrupamento', ['&O k']);
              blnConfirma:= False;
            End
            Else If (fVerificaNumAgr(edtNumAgr.Text, edtCodFor.Text, qryConFor.FieldByName('FOR_C_G_C_').AsString)) Then
            Begin
              sltAutInc := Nil;
                If fMensagem('', 'Confirma desagrupamento da(s) duplicata(s)?', ['&Sim', '&Não']) = 1 Then
                Begin
                  blnConfirma := True;
                  sltAutInc := fRetAutIncCadPagAgr('DUPAGP', 'CADPAG', edtNumAgr.Text);

                If Assigned(sltAutInc) And (sltAutInc.Count > 0) Then
                Begin
                  For intIndex := 0 To sltAutInc.Count-1 Do
                  Begin
                    strChvLoc := 'CADPAG' + sltAutInc[intIndex];

                    If Not fLock_Unlock(strChvLoc, True, False) Then
                    Begin
                      fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock(strChvLoc), ['&Ok']);
                      blnConfirma := False;
                      Break;
                    End;
                  End;
                End;

                If blnConfirma Then
                Begin
                  If fDesagrupaDuplicatas(edtNumAgr.Text) Then
                  Begin
                    fMensagem('ATENÇÃO!', 'Duplicata(s) desagrupada(s) com sucesso!', ['&O k']);
                    edtNumAgr.Clear;
                    edtCodFor.Clear;
                    edtNomFor.Clear;
                    pSetFocus(edtNumAgr);
                  End
                  Else
                  Begin
                    fMensagem('ATENÇÃO!', 'A Duplicata não foi desagrupada. Verifique se ela existe ou se foi enviada para o banco!', ['&O k']);
                    edtNumAgr.Clear;
                    edtCodFor.Clear;
                    edtNomFor.Clear;
                  End;
                End;
              End;

              If Assigned(sltAutInc) And (sltAutInc.Count > 0) Then
              Begin
                For intIndex := 0 To sltAutInc.Count-1 Do
                Begin
                  strChvLoc := 'CADPAG' + sltAutInc[intIndex];
                  fLock_Unlock(strChvLoc, False);
                End;
              End;

              blnConfirma := False;
              pSetFocus(edtNumAgr);
            End
            Else
            Begin
              edtNumAgr.Clear;
              edtCodFor.Clear;
              edtNomFor.Clear;
              blnConfirma := False;
            End;

            if not blnConfirma then
            begin
              pSetFocus(edtNumAgr);
            end;

End;


procedure TfrmDesagrupCtaPag.btnSairCtaPagClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDesagrupCtaPag.edtCodForKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      begin
      SelectNext(ActiveControl, True, True);
      pSetFocus(btnConfirmaCtaPag);
      end;
  End;
end;

procedure TfrmDesagrupCtaPag.edtNumAgrExit(Sender: TObject);
begin
  inherited;

  if fEmptyStr(edtNumAgr.Text) then
    Exit;

  edtNumAgr.Text := fRetornaNumeroAgrFormatado;
end;

function TfrmDesagrupCtaPag.fDesagrupaDuplicatas(strNumAgr: String): Boolean;
  Var
    strSQL: String;
    blnConfirma: Boolean;
    qryGen1: TUniQuery;
    qryPagar: TUniQuery;
    strAutInc: String;

  procedure pCopiaAnexos(strCodFor, strCodEmp, strAutInc, strAutNov: String);
    var
      strCaminhoPastaAntiga: String;
      strCaminhoNovaPasta: String;
  begin
    strCaminhoPastaAntiga := ExtractFilePath(Application.ExeName)+ 'ANEXOS_CTP\' +
                             fStrZero( strCodFor, 8  ) + '-' +
                             fStrZero( strCodEmp, 3  ) + '-' +
                             fStrZero( strAutInc, 20 ) ;

    strCaminhoNovaPasta   := ExtractFilePath(Application.ExeName)+ 'ANEXOS_CTP\' +
                             fStrZero( strCodFor, 8  ) + '-' +
                             fStrZero( strCodEmp, 3  ) + '-' +
                             fStrZero( strAutNov, 20 ) ;

    if DirectoryExists( strCaminhoPastaAntiga ) then
    begin
       TDirectory.Copy( strCaminhoPastaAntiga, strCaminhoNovaPasta );
       Sleep(500);
    end;
  End;
begin

  qryGen1 := fCriaQuery;

  blnConfirma := True;

  {*****************************************}
  {* INICIA A TRANSAÇÃO                    *}
  {**************************************MV*}
  fStartTransaction;

  If blnConfirma Then
  begin
    {*********************************************}
    {* GRAVA LOGCTP ANTES DE EXCLUIR A DUPLICATA *}
    {**47667**************************************}
    qryPagar := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT AUTOINCREM, CTP_NUMDUP, CTP_PARCEL, CTP_SEQBAI, ';
    strSQL := strSQL + '       CTP_CODEMP, CTP_CODFOR, CTP_SERIE_ ';
    strSQL := strSQL + 'FROM CADPAG ';
    strSQL := strSQL + 'WHERE CTP_NUMDUP = ' + QuotedStr(strNumAgr) + ' AND ';
    strSQL := strSQL + '      CTP_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
    strSQL := strSQL + '      CTP_CODFOR = "' + fStrZero(edtCodFor.Text, 8) + '" ';

    with qryPagar Do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
    end;

    While Not qryPagar.Eof Do
    Begin
      GravaLogCtp(qryPagar.FieldByName('AUTOINCREM').AsString,
                  'EXCLUSAO DE DUPLICATA - DESAGRUPAMENTO');

      qryPagar.Next;
    End;
    qryPagar.First;

    blnConfirma := fDeletaDuplicatasAgr(strNumAgr, fStrZero(edtCodFor.Text, 8));
  end;

  If blnConfirma Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  DUPAGP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMAGR = :DUPAGP AND ';
    strSQL := strSQL + '  CTP_EMPAGR = :EMPAGP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR ';

    With qryGen1 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DUPAGP').AsString := strNumAgr;
      ParamByName('EMPAGP').AsString := VS_strCodEmp;
      ParamByName('CODFOR').AsString := fStrZero(edtCodFor.Text, 8);
      Open;

      While Not Eof Do
      Begin

        strAutInc   := fRetAutoIncrem('CADPAG', FieldByName('CTP_CODEMP').AsString);

        blnConfirma := fGravaCadPag('frmDesagrupCtaPag',                      // Nome Form LOGCTP
                                    'INCLUSAO DE DUPLICATA - DESAGRUPAMENTO', // Descrição LOGCTP
                                    FieldByName('CTP_CODFOR').AsString,
                                    FieldByName('CTP_NUMDUP').AsString,
                                    FieldByName('CTP_PARCEL').AsString,
                                    FieldByName('CTP_CODEMP').AsString,
                                    FieldByName('CTP_CODCTA').AsString,
                                    FieldByName('CTP_SERIE_').AsString,
                                    FieldByName('CTP_SEQBAI').AsInteger,
                                    FieldByName('CTP_DTACAD').AsDateTime,
                                    FieldByName('CTP_DTAVEN').AsDateTime,
                                    FieldByName('CTP_VALDUP').AsFloat,
                                    FieldByName('CTP_VALORI').AsFloat,
                                    FieldByName('CTP_PREVIS').AsString,
                                    'N',
                                    FieldByName('CTP_DEPOSI').AsString, // Deposito
                                    FieldByName('CTP_HIST01').AsString,
                                    FieldByName('CTP_HIST02').AsString,
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    0,
                                    0,
                                    0,
                                    0,
                                    FieldByName('CTP_CODEMP').AsString,
                                    FieldByName('CTP_CODEVE').AsString,
                                    FieldByName('CTP_USACHQ').AsString,
                                    FieldByName('CTP_CODPOR').AsString,
                                    '',
                                    FieldByName('CTP_JURSUJ').AsFloat,
                                    FieldByName('CTP_DESSUJ').AsFloat,
                                    0,
                                    False,
                                    0,
                                    FieldByName('CTP_TIPDOC').AsString,
                                    FieldByName('CTP_VENDOR').AsFloat,
                                    FieldByName('CTP_VEIONF').AsString,
                                    '','','',
                                    strAutInc,
                                    '','','','',
                                    FieldByName('CTP_USOCON').AsString,
                                    '','','','','',0,0,0,0,
                                    FieldByName('CTP_CODVEN').AsString,
                                    0,
                                    0,
                                    '',
                                    '',
                                    '',
                                    FieldByName('CTP_NUMDDA').AsString,
                                    '',
                                    FieldByName('CTP_Q_GUIA').AsString,
                                    FieldByName('CTP_CODREC').AsString,
                                    FieldByName('CTP_BCOFOR').AsString,
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    0,
                                    '',
                                    FieldByName('CTP_MULSUJ').AsFloat,
                                    '',   // 80 strAutIncPix
                                    0,    // 81 fltGrvOri
                                    0,    // 82 ADtaLiberacao
                                    0,    // 83 AHorLiberacao
                                    '',   // 84 AOpeLiberacao
                                    '',   // 85 strGnreChaveDeApuracao
                                    '',   // 86 AIncCadFis
                                    '',   // 87 strQrCode
                                    FieldByName('CTP_USAMCA').AsString);

        If Not blnConfirma Then
          Break;

        If Not fEmptyStr(FieldByName('CTP_AUTORI').AsString) Then
        Begin
          pCopiaAnexos(FieldByName('CTP_CODFOR').AsString,
                       FieldByName('CTP_CODEMP').AsString,
                       FieldByName('CTP_AUTORI').AsString,
                       strAutInc);
        End;

        Next;

      End;

      Close;
    End;

  End;

  If blnConfirma Then
    blnConfirma := fDeletaDupAgr(strNumAgr, fStrZero(edtCodFor.Text, 8));

  If blnConfirma Then
    fCommit  Else
    fRollBack;

  Result := blnConfirma;

  FreeAndNil(qryGen1);
  FreeAndNil(qryPagar);
end;

procedure TfrmDesagrupCtaPag.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

end.

