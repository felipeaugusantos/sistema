unit untRelCadDireitosDeAcesso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus,
  QColorLabel, ExtCtrls, Buttons, CheckLst,
  Uni, StrUtils, DB, UniClientDataSet, ComCtrls,
  BitBtnLockedIncrem, frxExportCSVTestabilidade, untIFuncoes, Datasnap.DBClient;

type
  TfrmRelCadDireitosDeAcesso = class(TfrmPaiRelatorio)
    Label1: TLabel;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    cklGrupos: TCheckListBox;
    Label2: TLabel;
    frxReportM: TfrxReport;
    frxReportJ: TfrxReport;
    cdsRelat: TUniClientDataSet;
    frxDBRelat: TfrxDBDataset;
    cdsRelatNOMOPE: TStringField;
    cdsRelatNOMGRU: TStringField;
    cdsRelatNOMFUN: TStringField;
    cdsRelatCODOPE: TStringField;
    prgProgresso: TProgressBar;
    cdsRelatORDEM_: TIntegerField;
    rdgDireitos: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cklGruposKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    intOrdem : Integer;
    qryDirAce: TUniQuery;
    qryGruOpe: TUniQuery;

    Function fGetGrupos(cklGrupos: TCheckListBox): Boolean;
    Function fGetSelecao(cklLista: TCheckListBox; blnQuote: Boolean = True): String;
    Function fTemDireito(strNomFrm: String): Boolean;


    procedure pAbreRelatorio;

    procedure pMontaRelatorioUsuario;
    procedure pMontaMenuOperador(strCodOpe, strNomOpe: String);
    procedure pDireitosOperador(strCodOpe: String);
    procedure pGruposOperador(strCodOpe: String);
    procedure pIncluiGruposRestantes(strCodOpe, strNomOpe: String);
    procedure pMontaSubMenuOperador(mnuSubMenu: TMenuItem; strCodOpe, strNomOpe: String);

    procedure pMontaRelatorioGrupo;
    procedure pMontaMenuGrupo(strNomGru: String);
    procedure pDireitosGrupo(strCodGru: String);
    procedure pOperadoresGrupo(strCodGru: String);
    procedure pIncluiOperadoresRestantes(strNomGru: String);
    procedure pMontaSubMenuGrupo(mnuSubMenu: TMenuItem; strNomGru: String);

  public
    { Public declarations }
    mnuMainMenu: TMainMenu;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelCadDireitosDeAcesso: TfrmRelCadDireitosDeAcesso;

implementation

uses untTypesSistema, untFuncoesSimples, untConsultas, untFuncoes;

{$R *.dfm}

Function TfrmRelCadDireitosDeAcesso.fGetGrupos(cklGrupos: TCheckListBox): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  cklGrupos.Clear;
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT                 ';
    strSQL := strSQL + '   GPO_DESCRI AS GRUPO  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADGPO      ';
    strSQL := strSQL + ' ORDER BY GPO_DESCRI    ';

    qryGen := fCriaQuery(Self);
    With qryGen Do
    Begin
      SQL.Text := strSQL;
      Open;

      First;
      While Not Eof Do
      Begin
        cklGrupos.Items.Add(FieldByName('GRUPO').AsString);
        Next;
      End;

      Close;
    End;
    Result := TRUE;

  Except
    On E : Exception Do
    Begin
      Result := FALSE;
			pMensagensErro(E.Message,'[TfrmRelCadDireitosDeAcesso.fGetGrupos]');
    End;
  End;

  FreeAndNil(qryGen);
End;

procedure TfrmRelCadDireitosDeAcesso.FormShow(Sender: TObject);
begin
  inherited;

  fGetGrupos(cklGrupos);
  
end;

procedure TfrmRelCadDireitosDeAcesso.cklGruposKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Escape: btnSair.Click;
  End;

end;

procedure TfrmRelCadDireitosDeAcesso.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqOperador(Self, edtCodOpe, edtNomOpe, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelCadDireitosDeAcesso.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodOpe) Then
    Begin
      If Not fEmptyStr(edtCodOpe.Text) Then
      Begin
        edtNomOpe.Text := fRetNomVendRep(edtCodOpe.Text);
        If fEmptyStr(edtNomOpe.Text) Then
        Begin
          fMensagem('','Operador não cadastrado!', ['&Ok']);
          Result := False;
        End
      End

      Else edtNomOpe.Clear;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmRelCadDireitosDeAcesso.fGetSelecao(cklLista: TCheckListBox; blnQuote: Boolean = True): String;
  Var
    intIndex: Integer;
Begin
  Result := '';
  With cklLista Do
  For intIndex := 0 To Count - 1 Do
    If Checked[intIndex] Then
      If blnQuote Then
        Result := Result + ',' + QuotedStr(Items[intIndex])
      Else
        Result := Result + ', ' + Items[intIndex];

  If Length(Result) > 0 Then
    Delete(Result,1,1);
End;

procedure TfrmRelCadDireitosDeAcesso.pAbreRelatorio;
  Var
    strNomImp: String;
    frxReport: TfrxReport;
Begin
  pCarregaConfImpr(qryCfgRel, Self.Name);
  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

  If strTipImp = 'M' Then
  Begin
    frxReport := frxReportM;
  End Else
  Begin
    frxReport := frxReportJ;
    TfrxMemoView(frxReport.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
  End;

  With frxReport, Script Do
  Begin
    PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

    Variables['NOMREL']   := 'RELATÓRIO DE DIREITOS DE ACESSO';
    Variables['OPERADOR'] := 'OPERADOR: ' + Ifthen(fEmptyStr(edtCodOpe.Text), 'TODOS', edtCodOpe.Text);
    Variables['GRUPOS']   := 'GRUPOS  : ' + Ifthen(fEmptyStr(fGetSelecao(cklGrupos, False)), 'TODOS', fGetSelecao(cklGrupos, False));

    Case rdgDireitos.ItemIndex Of
      0,
      2: Begin
           TfrxMemoView(frxReport.FindObject('mmoTitulo1')).Text := 'OPERADOR';
           TfrxMemoView(frxReport.FindObject('mmoTitulo2')).Text := 'GRUPO';
           TfrxGroupHeader(frxReport.FindObject('GroupHeader')).Condition := 'frxDBRelat."CODOPE"';
           TfrxMemoView(frxReport.FindObject('mmoHeader')).Text := '[frxDBRelat."CODOPE"] - [frxDBRelat."NOMOPE"]';
           TfrxMemoView(frxReport.FindObject('mmoCamList')).Text := '[frxDBRelat."NOMGRU"]';
         End;
      1: Begin
           TfrxMemoView(frxReport.FindObject('mmoTitulo1')).Text := 'GRUPO';
           TfrxMemoView(frxReport.FindObject('mmoTitulo2')).Text := 'OPERADOR';
           TfrxGroupHeader(frxReport.FindObject('GroupHeader')).Condition := 'frxDBRelat."NOMGRU"';
           TfrxMemoView(frxReport.FindObject('mmoHeader')).Text := '[frxDBRelat."NOMGRU"]';
           TfrxMemoView(frxReport.FindObject('mmoCamList')).Text := '[IIF(<frxDBRelat."CODOPE"> <> '''', <frxDBRelat."CODOPE"> + ''-'' + <frxDBRelat."NOMOPE">, '''')]';
         End;
    End;

    If edtDestino.Text = 'V' Then
      pPreviewReport(Self.Name, Self.Caption, frxReport)
    Else
     If PrepareReport Then
       pPrintReport(Self.Name, Self.Caption, strNomImp, frxReport);
  End;
End;

Function TfrmRelCadDireitosDeAcesso.fTemDireito(strNomFrm: String): Boolean;
Begin
  Result := qryDirAce.Locate('DIR_NOMFRM', strNomFrm, [loCaseInsensitive])
End;

procedure TfrmRelCadDireitosDeAcesso.pMontaSubMenuOperador(mnuSubMenu: TMenuItem; strCodOpe, strNomOpe: String);
  Var
    intContador: Integer;
Begin
  For intContador := 0 To mnuSubMenu.Count - 1 Do
  With cdsRelat Do
  If (Not SameText(mnuSubMenu.Items[intContador].Caption, '-')) And
     fTemDireito(mnuSubMenu.Items[intContador].Hint) Then
  Begin
    Append;
    FieldByName('ORDEM_').AsInteger := intOrdem;
    FieldByName('CODOPE').AsString := strCodOpe;
    FieldByName('NOMOPE').AsString := strNomOpe;

    If qryGruOpe.Eof Then
    Begin
      FieldByName('NOMGRU').AsString := ' ';
    End Else
    Begin
      FieldByName('NOMGRU').AsString := qryGruOpe.FieldByName('GPO_DESCRI').AsString;
      qryGruOpe.Next;
    End;

    If mnuSubMenu.Items[intContador].Count > 0 Then
      FieldByName('NOMFUN').AsString := '* ' + AnsiReplaceStr(mnuSubMenu.Items[intContador].Caption, '&', '')
    Else
      FieldByName('NOMFUN').AsString := AnsiReplaceStr(mnuSubMenu.Items[intContador].Caption, '&', '');

    Post;
    inc(intOrdem);

    pMontaSubMenuOperador(mnuSubMenu.Items[intContador], strCodOpe, strNomOpe);
  End;
End;

procedure TfrmRelCadDireitosDeAcesso.pMontaMenuOperador(strCodOpe, strNomOpe: String);
  Var
    intContador: Integer;
Begin
  intOrdem := 0;

  For intContador := 0 To mnuMainMenu.Items.Count - 1 Do
  With cdsRelat Do
  If (Not SameText(mnuMainMenu.Items[intContador].Caption, '-')) And
     fTemDireito(mnuMainMenu.Items[intContador].Hint) Then
  Begin

    Append;
    FieldByName('ORDEM_').AsInteger := intOrdem;
    FieldByName('CODOPE').AsString  := strCodOpe;
    FieldByName('NOMOPE').AsString  := strNomOpe;

    If qryGruOpe.Eof Then
    Begin
      FieldByName('NOMGRU').AsString := ' ';
    End Else
    Begin
      FieldByName('NOMGRU').AsString := qryGruOpe.FieldByName('GPO_DESCRI').AsString;
      qryGruOpe.Next;
    End;

    If mnuMainMenu.Items[intContador].Count > 0 Then
      FieldByName('NOMFUN').AsString := '* ' + AnsiReplaceStr(mnuMainMenu.Items[intContador].Caption, '&', '')
    Else
      FieldByName('NOMFUN').AsString := AnsiReplaceStr(mnuMainMenu.Items[intContador].Caption, '&', '');

    Post;
    inc(intOrdem);

    pMontaSubMenuOperador(mnuMainMenu.Items[intContador], strCodOpe, strNomOpe);
  End;
End;

procedure TfrmRelCadDireitosDeAcesso.pDireitosOperador(strCodOpe: String);
Begin
  With qryDirAce, SQL Do
  Begin
    Close;
    Clear;

    If rdgDireitos.ItemIndex <> 1 {Grupo} Then
    Begin
      Add('SELECT DISTINCT        ');
      Add('  DIR_NOMFRM           ');
      Add('FROM                   ');
      Add('  DIROPE               ');
      Add('WHERE                  ');
      Add('  OPE_CODOPE = :CODOPE ');
    End;

    If rdgDireitos.ItemIndex = 2 {Todos} Then
      Add('UNION                  ');

    If rdgDireitos.ItemIndex <> 0 {Usuário} Then
    Begin
      Add('SELECT DISTINCT        ');
      Add('  DIR_NOMFRM           ');
      Add('FROM                   ');
      Add('  DIRGPO D             ');
      Add('INNER JOIN OPEGPO G ON G.GPO_CODGPO = D.GPO_CODGPO ');
      Add('WHERE                    ');
      Add('  G.OPE_CODOPE = :CODOPE ');
    End;

    ParamByName('CODOPE').AsString := strCodOpe;

    Open;
  End;
End;

procedure TfrmRelCadDireitosDeAcesso.pGruposOperador(strCodOpe: String);
Begin
  With qryGruOpe, SQL Do
  Begin
    Clear;
    Close;
    Add('SELECT DISTINCT          ');
    Add('   GPO_DESCRI            ');
    Add('FROM                     ');
    Add('  OPEGPO G               ');
    Add('INNER JOIN CADGPO C ON C.GPO_CODGPO = G.GPO_CODGPO ');
    Add('WHERE                    ');
    Add('  G.OPE_CODOPE = :CODOPE ');
    Add('ORDER BY GPO_DESCRI      ');

    ParamByName('CODOPE').AsString := strCodOpe;

    Open;

  End;
End;

procedure TfrmRelCadDireitosDeAcesso.pIncluiGruposRestantes(strCodOpe, strNomOpe: String);
Begin
  While Not qryGruOpe.Eof Do
  Begin
    With cdsRelat Do
    Begin
      Append;
      FieldByName('ORDEM_').AsInteger := intOrdem;
      FieldByName('CODOPE').AsString  := strCodOpe;
      FieldByName('NOMOPE').AsString  := strNomOpe;
      FieldByName('NOMGRU').AsString  := qryGruOpe.FieldByName('GPO_DESCRI').AsString;
      FieldByName('NOMFUN').AsString  := ' ';
      Post;
    End;

    inc(intOrdem);

    qryGruOpe.Next;
  End;
End;

procedure TfrmRelCadDireitosDeAcesso.pMontaRelatorioUsuario;
  Var
    qryCadOpe: TUniQuery;
Begin
  With cdsRelat Do
  Begin
    Close;
    CreateDataSet;
    Open;
    IndexFieldNames := 'NOMOPE;ORDEM_';
  End;

  qryCadOpe := fCriaQuery(Self);
  With qryCadOpe, SQL Do
  Begin
    Clear;
    Add('SELECT DISTINCT ');
    Add('  O.OPE_CODOPE AS CODOPE,');
    Add('  O.OPE_NOMOPE AS NOMOPE ');
    Add('FROM');
    Add('  CADOPE O');

    If Not fEmptyStr(fGetSelecao(cklGrupos)) Then
    Begin
      Add('INNER JOIN OPEGPO G ON G.OPE_CODOPE = O.OPE_CODOPE');
      Add('INNER JOIN CADGPO C ON C.GPO_CODGPO = G.GPO_CODGPO');
    End;

    Add('WHERE ');
    Add('  O.OPE_STATUS = "A"');

    If Not fEmptyStr(edtCodOpe.Text) Then
      Add(' AND O.OPE_CODOPE = :CODOPE ');

    If Not fEmptyStr(fGetSelecao(cklGrupos)) Then
      Add(' AND C.GPO_DESCRI IN (' + fGetSelecao(cklGrupos) + ') ');


    If Not fEmptyStr(edtCodOpe.Text) Then
      ParamByName('CODOPE').AsString := edtCodOpe.Text;

    Open;

    prgProgresso.Max := RecordCount;
    While Not Eof Do
    Begin
      pDireitosOperador(FieldByName('CODOPE').AsString);

      pGruposOperador(FieldByName('CODOPE').AsString);
      pMontaMenuOperador(FieldByName('CODOPE').AsString, FieldByName('NOMOPE').AsString);
      pIncluiGruposRestantes(FieldByName('CODOPE').AsString, FieldByName('NOMOPE').AsString);

      Next;
      prgProgresso.StepBy(1);
      Application.ProcessMessages;
    End;

    prgProgresso.Position := 0;
    Close;

    FreeAndNil(qryCadOpe);
  End;
End;

procedure TfrmRelCadDireitosDeAcesso.pMontaSubMenuGrupo(mnuSubMenu: TMenuItem; strNomGru: String);
  Var
    intContador: Integer;
Begin
  For intContador := 0 To mnuSubMenu.Count - 1 Do
  With cdsRelat Do
  If (Not SameText(mnuSubMenu.Items[intContador].Caption, '-')) And
     fTemDireito(mnuSubMenu.Items[intContador].Hint) Then
  Begin
    Append;
    FieldByName('ORDEM_').AsInteger := intOrdem;
    FieldByName('NOMGRU').AsString  := strNomGru;

    If qryGruOpe.Eof Then
    Begin
      FieldByName('CODOPE').AsString  := ' ';
      FieldByName('NOMOPE').AsString  := ' ';
    End Else
    Begin
      FieldByName('CODOPE').AsString  := qryGruOpe.FieldByName('CODOPE').AsString;
      FieldByName('NOMOPE').AsString  := qryGruOpe.FieldByName('NOMOPE').AsString;
      qryGruOpe.Next;
    End;

    If mnuSubMenu.Items[intContador].Count > 0 Then
      FieldByName('NOMFUN').AsString := '* ' + AnsiReplaceStr(mnuSubMenu.Items[intContador].Caption, '&', '')
    Else
      FieldByName('NOMFUN').AsString := AnsiReplaceStr(mnuSubMenu.Items[intContador].Caption, '&', '');

    Post;
    inc(intOrdem);

    pMontaSubMenuGrupo(mnuSubMenu.Items[intContador], strNomGru);
  End;
End;

procedure TfrmRelCadDireitosDeAcesso.pMontaMenuGrupo(strNomGru: String);
  Var
    intContador: Integer;
Begin
  intOrdem := 0;

  For intContador := 0 To mnuMainMenu.Items.Count - 1 Do
  With cdsRelat Do
  If (Not SameText(mnuMainMenu.Items[intContador].Caption, '-')) And
     fTemDireito(mnuMainMenu.Items[intContador].Hint) Then
  Begin

    Append;
    FieldByName('ORDEM_').AsInteger := intOrdem;
    FieldByName('NOMGRU').AsString  := strNomGru;

    If qryGruOpe.Eof Then
    Begin
      FieldByName('CODOPE').AsString  := ' ';
      FieldByName('NOMOPE').AsString  := ' ';
    End Else
    Begin
      FieldByName('CODOPE').AsString  := qryGruOpe.FieldByName('CODOPE').AsString;
      FieldByName('NOMOPE').AsString  := qryGruOpe.FieldByName('NOMOPE').AsString;
      qryGruOpe.Next;
    End;

    If mnuMainMenu.Items[intContador].Count > 0 Then
      FieldByName('NOMFUN').AsString := '* ' + AnsiReplaceStr(mnuMainMenu.Items[intContador].Caption, '&', '')
    Else
      FieldByName('NOMFUN').AsString := AnsiReplaceStr(mnuMainMenu.Items[intContador].Caption, '&', '');

    Post;
    inc(intOrdem);

    pMontaSubMenuGrupo(mnuMainMenu.Items[intContador], strNomGru);
  End;
End;

procedure TfrmRelCadDireitosDeAcesso.pDireitosGrupo(strCodGru: String);
Begin
  With qryDirAce, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT DISTINCT        ');
    Add('  DIR_NOMFRM           ');
    Add('FROM                   ');
    Add('  DIRGPO D             ');
    Add('INNER JOIN OPEGPO G ON G.GPO_CODGPO = D.GPO_CODGPO ');
    Add('WHERE                    ');
    Add('  D.GPO_CODGPO = :CODGPO ');

    ParamByName('CODGPO').AsString := strCodGru;

    Open;
  End;
End;

procedure TfrmRelCadDireitosDeAcesso.pOperadoresGrupo(strCodGru: String);
Begin
  With qryGruOpe, SQL Do
  Begin
    Clear;
    Close;
    Add('SELECT DISTINCT            ');
    Add('   C.OPE_CODOPE AS CODOPE, ');
    Add('   C.OPE_NOMOPE AS NOMOPE  ');
    Add('FROM                     ');
    Add('  OPEGPO G               ');
    Add('INNER JOIN CADOPE C ON C.OPE_CODOPE = G.OPE_CODOPE ');
    Add('WHERE                    ');
    Add('  G.GPO_CODGPO = :CODGPO ');
    Add('ORDER BY OPE_NOMOPE      ');

    If Not fEmptyStr(edtCodOpe.Text) Then
      Add(' AND C.OPE_CODOPE = :CODOPE ');

    ParamByName('CODGPO').AsString := strCodGru;

    If Not fEmptyStr(edtCodOpe.Text) Then
      ParamByName('CODOPE').AsString := edtCodOpe.Text;

    Open;

  End;
End;

procedure TfrmRelCadDireitosDeAcesso.pIncluiOperadoresRestantes(strNomGru: String);
Begin
  While Not qryGruOpe.Eof Do
  Begin
    With cdsRelat Do
    Begin
      Append;
      FieldByName('ORDEM_').AsInteger := intOrdem;
      FieldByName('CODOPE').AsString  := qryGruOpe.FieldByName('CODOPE').AsString;
      FieldByName('NOMOPE').AsString  := qryGruOpe.FieldByName('NOMOPE').AsString;
      FieldByName('NOMGRU').AsString  := strNomGru;
      FieldByName('NOMFUN').AsString  := ' ';
      Post;
    End;

    inc(intOrdem);

    qryGruOpe.Next;
  End;
End;

procedure TfrmRelCadDireitosDeAcesso.pMontaRelatorioGrupo;
  Var
    qryCadGru: TUniQuery;
Begin
  With cdsRelat Do
  Begin
    Close;
    CreateDataSet;
    Open;
    IndexFieldNames := 'NOMGRU;ORDEM_';
  End;

  qryCadGru := fCriaQuery(Self);
  With qryCadGru, SQL Do
  Begin
    Clear;
    Add('SELECT DISTINCT         ');
    Add('  GPO_CODGPO AS CODGRU, ');
    Add('  GPO_DESCRI AS NOMGRU  ');
    Add('FROM                    ');
    Add('  CADGPO                ');

    If Not fEmptyStr(fGetSelecao(cklGrupos)) Then
    Begin
      Add('WHERE                                           ');
      Add('  GPO_DESCRI IN (' + fGetSelecao(cklGrupos) + ') ');
    End;

    Add(' ORDER BY GPO_DESCRI ');

    Open;

    prgProgresso.Max := RecordCount;
    While Not Eof Do
    Begin
      pDireitosGrupo(FieldByName('CODGRU').AsString);
      pOperadoresGrupo(FieldByName('CODGRU').AsString);

      pMontaMenuGrupo(FieldByName('NOMGRU').AsString);

      pIncluiOperadoresRestantes(FieldByName('NOMGRU').AsString);

      Next;
      prgProgresso.StepBy(1);
      Application.ProcessMessages;
    End;

    prgProgresso.Position := 0;
    Close;

    FreeAndNil(qryCadGru);
  End;
End;

procedure TfrmRelCadDireitosDeAcesso.btnImprimirClick(Sender: TObject);
begin
  inherited;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  If blnImprime Then
  Begin

    Case rdgDireitos.ItemIndex Of
      0,
      2: pMontaRelatorioUsuario;
      1: pMontaRelatorioGrupo;
    End;  

    If Not cdsRelat.IsEmpty Then
    Begin
      Try

        pAbreRelatorio;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmRelCadDireitosDeAcesso.btnImprimirClick]');
        End;
      End;

    End
    Else
    Begin
      pTabelaVazia;
    End;

  End;
  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
  pSetFocus(cklGrupos);

end;

procedure TfrmRelCadDireitosDeAcesso.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(cklGrupos);
end;

procedure TfrmRelCadDireitosDeAcesso.FormCreate(Sender: TObject);
begin
  inherited;

  qryDirAce := fCriaQuery(Self);
  qryGruOpe := fCriaQuery(Self);
end;

procedure TfrmRelCadDireitosDeAcesso.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

//  If Key = VK_Escape Then  Case Key Of
//    VK_Escape: btnSair.Click;  End;
  
  Case Key Of
    VK_RETURN: If (ActiveControl Is TCheckListBox) Or
                  (ActiveControl Is TRadioButton) Then
                 self.SelectNext(ActiveControl, True, True);
                 
    VK_Escape: btnSair.Click;             

  End;

end;


end.
