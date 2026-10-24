unit untExpFunBosh;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  MaskEditFocus, DirectoryEditFocus, Uni,
  StrUtils, ComCtrls, FilenameEditFocus, BitBtnLockedIncrem, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  frxClass, frxExportCSVTestabilidade, UniClientDataSet, EditFocus, untTypesSistema, 
  untFrameDirectoryEditFocus;

type
  TfrmExpFunBosh = class(TfrmPaiEdit)
    grbPeridoBaixa: TGroupBox;
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblPathExp: TLabel;
    Label2: TLabel;
    pgbProgresso: TProgressBar;
    Label3: TLabel;
    rgpPessoa: TRadioGroup;
    btnGravar: TBitBtnLocked;
    fraPatArq: TfraDirectoryEditFocus;
    edtArqAut: TFilenameEditFocus;
    edtNomArq: TEditFocus;
    Label4: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    chkIgnCnp: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruExit(Sender: TObject);
  private
    { Private declarations }
    qryMovDet: TUniQuery;
    txtArqExp: TextFile;
    cdsCnpjs: TUniClientDataSet;
    cdsExportado: TUniClientDataSet;
    arrLinGru : TConsultasArray;
    strLinGru : String;
    Function fGeraArquivoBosch: Boolean;
    Function fLeMovimento: Boolean;
    Function fGetWhere: String;
    Function fstrInner: String;
    Function fRetCodAutECarregaCnpjs(Var strCodAut: String): Boolean;
    function fRetPathExp(strPath: string): string;
    procedure pSetParms;
    procedure pMarcaExportado(strTabela: String);
    procedure pCriaCdsCnpjs;
    procedure pCriaCdsExportado;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmExpFunBosh: TfrmExpFunBosh;

implementation

uses untFuncoesSimples, untPai, DB, untConsultas, untFuncoesConsulta;

{$R *.dfm}

function TfrmExpFunBosh.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender  = fraPatArq) Then
    Begin
      If fEmptyStr(fraPatArq.edtDirectory.text) Then
      Begin
        fMensagem('ATENÇÃO','O Path para geração do arquivo deve ser preenchido!',['&OK']);
        Result := False;
      End

      Else If Not DirectoryExists(fraPatArq.edtDirectory.text) Then
      Begin
        fMensagem('ATENÇÃO','O Path para geração do arquivo não existe!',['&OK']);
        Result := False;
      End
    End

    Else If (Sender  = edtNomArq) Then
    Begin
      If fEmptyStr(edtNomArq.Text) Then
      Begin
        fMensagem('ATENÇÃO','O nome do arquivo deve ser preenchido!',['&OK']);
        Result := False;
      End;
    End

    Else If (Sender  = edtArqAut) Then
    Begin
      If fEmptyStr(edtArqAut.Text) Then
      Begin
        fMensagem('ATENÇÃO','O arquivo de autorização deve ser informado!',['&OK']);
        Result := False;
      End Else
      Begin
        If Not FileExists(edtArqAut.Text) Then
        Begin
          fMensagem('ATENÇÃO','Arquivo de autorização não encontrado!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Informe o período!',['&OK']);
        Result := False;
      End;

    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
         (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&OK']);
        Result := False;
      End;

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmExpFunBosh.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6, True);
end;

procedure TfrmExpFunBosh.mskLinGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtDesGru, Nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

Function TfrmExpFunBosh.fGetWhere: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' WHERE DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  strSQL := strSQL + '   AND DET_PROEMB <> "S" ';
  strSQL := strSQL + '   AND DET_TIP_FC = "C" ';
  strSQL := strSQL + '   AND DET_CODCLI NOT IN (' + VS_strCliFil + ') ';
  strSQL := strSQL + '   AND (LOCATE(DET_CLAFIS, :CLAVEN) > 0) ';
  strSQL := strSQL + '   AND DET_CODEMP = :CODEMP   ';
  strSQL := strSQL + '   AND DET_ESPDOC IN ("NF", "EL", "IF", "IV", "D1") ';
  strSQL := strSQL + '   AND IFNULL(DET_FUNEXP, "N") = "N" ';

  If rgpPessoa.ItemIndex = 1 Then
    strSQL := strSQL + ' AND GER_CGCCPF = 2 '

  Else If rgpPessoa.ItemIndex = 2 Then
    strSQL := strSQL + ' AND GER_CGCCPF = 1 ';

  strSQL := strSQL + fStrLocateLinGru(mskLinGru, arrLinGru, 'ITE_CODGRU', 'CODGRU', False, True);

  Result := strSQL;
End;

Function TfrmExpFunBosh.fstrInner: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';
  strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ';
  strSQL := strSQL + '  INNER JOIN MOVGER ON GER_NUMDOC = DET_NUMDOC AND ';
  strSQL := strSQL + '                       GER_ESPDOC = DET_ESPDOC AND ';
  strSQL := strSQL + '                       GER_CODEMP = DET_CODEMP AND ';
  strSQL := strSQL + '                       GER_CODCLI = DET_CODCLI     ';
  strSQL := strSQL + '  INNER JOIN BOSMAR ON BOS_CODMAR = ITE_CODMAR ';
  Result := strSQL;
End;                                             

procedure TfrmExpFunBosh.pSetParms;
Begin
  With qryMovDet, SQL Do
  Begin
    ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    ParamByName('CLAVEN').AsString := VS_strClaVen;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryMovDet);
  End;
End;

procedure TfrmExpFunBosh.pCriaCdsCnpjs;
begin
  cdsCnpjs := TUniClientDataSet.Create(Self);
  With cdsCnpjs, FieldDefs Do
  Begin
    With AddFieldDef Do
    Begin
      Name     := 'CNPJ';
      DataType := ftString;
      Size     := 18;
      Required := False;
    End;
    IndexFieldNames := 'CNPJ';
    CreateDataSet;
  End;
end;

procedure TfrmExpFunBosh.pCriaCdsExportado;
begin
  cdsExportado := TUniClientDataSet.Create(Self);
  With cdsExportado, FieldDefs Do
  Begin
    With AddFieldDef Do
    Begin
      Name     := 'AUTINC';
      DataType := ftString;
      Size     := 20;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'TABELA';
      DataType := ftString;
      Size     := 20;
      Required := False;
    End;

    IndexFieldNames := 'TABELA;AUTINC';
    CreateDataSet;
  End;
end;

procedure TfrmExpFunBosh.pMarcaExportado(strTabela: String);
  Var
    qryUpDate : TUniQuery;
    strWhere : String;
Begin
  qryUpDate := fCriaQuery(Self);
  Try
    cdsExportado.Filter := 'TABELA = ' + QuotedStr(strTabela);
    cdsExportado.Filtered := True;

    strWhere := '';

    cdsExportado.First;
    While Not cdsExportado.Eof Do
    Begin

      If Not fEmptyStr(cdsExportado.FieldByName('AUTINC').AsString) Then
      Begin
        If fEmptyStr(strWhere) Then
          strWhere := QuotedStr(cdsExportado.FieldByName('AUTINC').AsString)
        Else
          strWhere := strWhere + ', ' + QuotedStr(cdsExportado.FieldByName('AUTINC').AsString);
      End;

      cdsExportado.Next;
    End;

    If Not fEmptyStr(strWhere) Then
    Begin
      With qryUpDate Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' UPDATE ' + strTabela);
        SQL.Add('    SET DET_FUNEXP = "S" ');
        SQL.Add('  WHERE AUTOINCREM IN (' + strWhere + ') ');
        ExecSQL;
      End;
    End;
  Finally
    FreeAndNil(qryUpDate);
    cdsExportado.Filtered := False;
    cdsExportado.Filter := '';
  End;
End;

Function TfrmExpFunBosh.fLeMovimento: Boolean;
  Var
    strSQL: String;
Begin
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '        IF((CLI_NOMCLI LIKE "%CONSUMIDOR%") OR (CLI_NOMCLI LIKE "%SEGURADORA%"), GER_CGCCON, CLI_C_G_C_) AS C_G_C_, ';
    strSQL := strSQL + '        DET_NUMDOC AS NUMDOC, ';
    strSQL := strSQL + '        DET_CODITE AS CODITE, ';
    strSQL := strSQL + '        ITE_CODFAB AS CODFAB, ';
    strSQL := strSQL + '        DET_QTDITE AS QTDITE, ';
    strSQL := strSQL + '        (DET_TOTITE - DET_DESESP) AS TOTITE, ';
    strSQL := strSQL + '        DET_DTAENT AS DTAENT,  ';
    strSQL := strSQL + '        "MOVDET" AS TABELA, ';
    strSQL := strSQL + '        MOVDET.AUTOINCREM AS AUTINC ';
    strSQL := strSQL + '   FROM MOVDET         ';
    strSQL := strSQL +  fstrInner;
    strSQL := strSQL +  fGetWhere;
    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET');

    With qryMovDet, SQL Do
    Begin
      Close;
      Clear;
      SQL.Add(strSQL);
      pSetParms;
      Open;
      Result := Not IsEmpty;
      If IsEmpty Then
        pMensagemOk('Nenhum movimento encontrado!');
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fLeMovimento]');
    End;
  End;
End;

Function TfrmExpFunBosh.fRetCodAutECarregaCnpjs(Var strCodAut: String): Boolean;
  Var
    stlArquivo : TStringList;
    intCnt : Integer;
Begin
  strCodAut := '';
  cdsCnpjs.EmptyDataSet;

  If FileExists(edtArqAut.Text) Then
  Begin
    stlArquivo := TStringList.Create;
    Try
      stlArquivo.LoadFromFile(edtArqAut.Text);

      For intCnt := 0 To stlArquivo.Count-1 Do
      begin
        If (intCnt = 0) Then
        Begin
          strCodAut := Trim(stlArquivo.Strings[intCnt]);

          If (chkIgnCnp.Checked) Then
            Break;
        End
        Else
        Begin
          If Not fEmptyStr(stlArquivo.Strings[intCnt]) Then
          Begin
            cdsCnpjs.Append;
            cdsCnpjs.FieldByName('CNPJ').AsString := stlArquivo.Strings[intCnt];
            cdsCnpjs.Post;
          End;
        End;
      end;
    Finally
      FreeAndNil(stlArquivo);
    End;

    Result := (Not fEmptyStr(strCodAut));

    If (Result) And (Not chkIgnCnp.Checked) Then
      Result := (Not cdsCnpjs.IsEmpty);

    If Not Result Then
    Begin
      If fEmptyStr(strCodAut) Then
        pMensagemOk('Chave de autorização não encontrada no arquivo (' + edtArqAut.Text + ')!');

      If (cdsCnpjs.IsEmpty) Then
        pMensagemOk('Não há Cnpjs disponíveis no arquivo de autorização (' + edtArqAut.Text + ')!');
    End;
  End
  Else
  Begin
    pMensagemOk('Arquivo de autorização (' + edtArqAut.Text + ') não econtrado!');
    Result := False;
  End
End;

function TfrmExpFunBosh.fRetPathExp(strPath: string): string;
begin
  Result := strPath;

  If RightStr(strPath, 1) <> '\' Then
    Result := strPath + '\';
end;

Function TfrmExpFunBosh.fGeraArquivoBosch: Boolean;
  Var
    strLinha,
    strCodAut: String;
Begin
  Try
    cdsExportado.EmptyDataSet;
    Result := False;

    If Not fRetCodAutECarregaCnpjs(strCodAut) Then
      Exit;

    Result := fLeMovimento;

    If Not Result Then
      Exit;

    AssignFile(txtArqExp, fRetPathExp(fraPatArq.edtDirectory.text) + edtNomArq.Text);
    Rewrite(txtArqExp);

    strLinha := strCodAut + ' ' +
                FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIni.Text)) + ' ' +
                FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFin.Text)) + ' ' +
                RightStr('0' + fTiraCaracEspeciais(fRetCGCEmpresa(VS_strCodEmp)), 15);

    WriteLn(txtArqExp, strLinha);

    With qryMovDet Do
    Begin
      pgbProgresso.Position := 0;
      pgbProgresso.Max := RecordCount;

      First;
      While Not Eof Do
      Begin
        If (chkIgnCnp.Checked) Or (cdsCnpjs.FindKey([FieldByName('C_G_C_').AsString])) Then
        Begin
          cdsExportado.Append;
          cdsExportado.FieldByName('TABELA').AsString := FieldByName('TABELA').AsString;
          cdsExportado.FieldByName('AUTINC').AsString := FieldByName('AUTINC').AsString;
          cdsExportado.Post;

          strLinha := fTiraCaracEspeciais(FieldByName('C_G_C_').AsString) + '-' +
                      FieldByName('NUMDOC').AsString + '-' +
                      fPadR(LeftStr(FieldByName('CODFAB').AsString, 10), 10) + '-' +
                      IntToStr(Trunc((FieldByName('QTDITE').AsFloat)))                    + '-' +
                      FormatFloat('#0.00', FieldByName('TOTITE').AsFloat) + '-' +
                      FormatDateTime('dd/mm/yyyy', FieldByName('DTAENT').AsDateTime);

          WriteLn(txtArqExp, strLinha);
        End;

        Next;

        pgbProgresso.StepBy(1);
      End;
    End;

    CloseFile(txtArqExp);

    fStartTransaction;
    
    pMarcaExportado('MOVDET');
    pMarcaExportado('NOTDET');

    fCommit;

    pgbProgresso.Position := 0;
    
    pMensagemOk('Arquivo gerado com sucesso!');
  Except
    On E: Exception Do
    Begin
      fRollBack;
      CloseFile(txtArqExp);
      Result := False;
      pgbProgresso.Position := 0;
      pMensagensErro(E.Message, '[fGeraArquivoBosch]');
    End;
  End;
End;

procedure TfrmExpFunBosh.FormShow(Sender: TObject);
begin
  inherited;
  fraPatArq.edtDirectory.text := fCfgSis('FUNPAT');
  edtNomArq.Text := fCfgSis('FUNARQ');
  edtArqAut.Dialog.Dialog.InitialDir := fCfgSis('FUNAUT');
end;

procedure TfrmExpFunBosh.FormActivate(Sender: TObject);
begin
  inherited;
  If fEmptyStr(fraPatArq.edtDirectory.text) Then
    pSetFocus(fraPatArq)
  Else If fEmptyStr(edtNomArq.Text) Then
    pSetFocus(edtNomArq)
  Else
    pSetFocus(edtArqAut);
end;

procedure TfrmExpFunBosh.FormCreate(Sender: TObject);
begin
  inherited;
  qryMovDet := fCriaQuery(Self);
  pCriaCdsCnpjs;
  pCriaCdsExportado;
end;

procedure TfrmExpFunBosh.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsCnpjs);
  FreeAndNil(qryMovDet);
  FreeAndNil(cdsExportado);
  inherited;
end;

procedure TfrmExpFunBosh.btnGravarClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  fGeraArquivoBosch;
end;

end.
