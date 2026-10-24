unit untCadPrevisao;

interface

uses
  Windows, Classes, Controls, untPaiOrdena, DB, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids,
  Buttons, ExtCtrls, ComCtrls, BitBtnLockedIncrem, MemDS, DBAccess, Provider,
  frxClass, frxExportCSVTestabilidade, UniClientDataSet, Datasnap.DBClient,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar;

type
  TfrmCadPrevisao = class(TfrmPaiOrdena)
    gpb1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    gpb2: TGroupBox;
    edtCodEmp: TEditFocus;
    lbl4: TLabel;
    edtEspDoc: TEditFocus;
    edtDesEmp: TEditFocus;
    lbl3: TLabel;
    cdsPrevisoes: TUniClientDataSet;
    cdsPrevisoesDTALAN: TDateField;
    cdsPrevisoesHORLAN: TTimeField;
    cdsPrevisoesVALPAG: TFloatField;
    cdsPrevisoesVALREC: TFloatField;
    cdsPrevisoesESPDOC: TStringField;
    cdsPrevisoesCODEMP: TStringField;
    cdsPrevisoesDESCRI: TStringField;
    pbProgresso: TProgressBar;
    btnConfirmar: TBitBtnLocked;
    btnCopiarDescri: TBitBtnLocked;
    btnCopiarValPag: TBitBtnLocked;
    btnCopiarValRec: TBitBtnLocked;
    Label1: TLabel;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnCarregar: TBitBtnLocked;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCopiarDescriClick(Sender: TObject);
    procedure btnCopiarValPagClick(Sender: TObject);
    procedure btnCopiarValRecClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dbgConsultaTitleClick(Column: TColumn);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure cdsPrevisoesAfterInsert(DataSet: TDataSet);
    procedure btnCarregarClick(Sender: TObject);
  private
    { Private declarations }
    procedure pDeletaRegistro;
    procedure pLimpaTela;
    procedure pAbreConsulta;
    procedure pIncluiRegistros;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, Forms, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadPrevisao.btnCarregarClick(Sender: TObject);
begin
  inherited;
  if not fValidaCampos(mskDtaIni) then
  begin
    exit;
  end;
  if not fValidaCampos(mskDtaFin) then
  begin
    exit;
  end;
  if fVerificaCampos then
    pAbreConsulta;
  if not cdsprevisoes.isempty then
     pSetFocus(dbgConsulta);
end;

procedure TfrmCadPrevisao.btnConfirmarClick(Sender: TObject);
  Var
    qryCadIns: TUniQuery;
begin
  inherited;
  If (cdsPrevisoes.RecordCount = 0) Then
  begin
    pMensagemOK('É necessário selecionar ao menos uma previsão!');
    Exit;
  end;

  If fMensagem('','Confirma a gravação das previsões?',['&Sim','&Não']) = 2 Then
    Exit;

  qryCadIns := fCriaQuery;
  Try
    With qryCadIns, SQL Do
    Begin
      cdsPrevisoes.DisableControls;
      pbProgresso.Visible := True;
      pbProgresso.Max     := cdsPrevisoes.RecordCount;
      cdsPrevisoes.First;
      While Not cdsPrevisoes.Eof Do
      Begin
        pbProgresso.Position := cdsPrevisoes.RecNo;
        Application.ProcessMessages;
//        If (cdsPrevisoesVALPAG.AsFloat > 0) Or (cdsPrevisoesVALREC.AsFloat > 0) Then
//        Begin
        Close;
        Clear;
        Add(' DELETE FROM CADPRE ');
        Add(' WHERE');
        Add('   PRE_DTALAN = :DTALAN AND PRE_CODEMP = :CODEMP AND PRE_ESPECI = :ESPDOC');
        ParamByName('DTALAN').AsDateTime := cdsPrevisoesDTALAN.AsDateTime;
        ParamByName('CODEMP').AsString   := cdsPrevisoesCODEMP.AsString;
        ParamByName('ESPDOC').AsString   := cdsPrevisoesESPDOC.AsString;
        ExecSQL;

        Close;
        Clear;
        Add(' INSERT INTO CADPRE ');
        Add('  (AUTOINCREM, PRE_DTALAN, PRE_HORLAN, PRE_VALAPA, PRE_VALARE, PRE_ESPECI, PRE_CODEMP, PRE_DESCRI) ');
        Add(' VALUES');
        Add('  (:AUTOIN, :DTALAN, :HORLAN, :VALAPA, :VALARE, :ESPDOC, :CODEMP, :DESCRI) ');
        ParamByName('AUTOIN').AsString   := fRetAutoIncrem('CADPRE', edtCodEmp.Text);
        ParamByName('DTALAN').AsDateTime := cdsPrevisoesDTALAN.AsDateTime;
        ParamByName('HORLAN').AsDateTime := cdsPrevisoesHORLAN.AsDateTime;
        ParamByName('VALAPA').AsFloat    := cdsPrevisoesVALPAG.AsFloat;
        ParamByName('VALARE').AsFloat    := cdsPrevisoesVALREC.AsFloat;
        ParamByName('ESPDOC').AsString   := cdsPrevisoesESPDOC.AsString;
        ParamByName('CODEMP').AsString   := cdsPrevisoesCODEMP.AsString;
        ParamByName('DESCRI').AsString   := cdsPrevisoesDESCRI.AsString;
        ExecSQL;
//        End;
        cdsPrevisoes.Next;
      End;
      cdsPrevisoes.EnableControls;
    End;
    fMensagem('AVISO', 'Previsões gravadas com sucesso!', ['&O k']);
    pbProgresso.Visible := False;
    pLimpaTela;
  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  FreeAndNil(qryCadIns);
end;

procedure TfrmCadPrevisao.btnCopiarDescriClick(Sender: TObject);
  Var
    strDescri: String;
    intRec   : Integer;
begin
  inherited;
  If (cdsPrevisoes.RecordCount = 0) Then
    Exit;

  strDescri := cdsPrevisoesDESCRI.AsString;
  intRec    := cdsPrevisoes.RecNo;
  If fMensagem('','Copiar a Descrição "' + strDescri + '" para o período?',['&Sim','&Não']) = 2 Then
    Exit;

  Try
    cdsPrevisoes.DisableControls;
    pbProgresso.Visible := True;
    pbProgresso.Max     := cdsPrevisoes.RecordCount;
    cdsPrevisoes.First;
    While Not cdsPrevisoes.Eof Do
    Begin
      pbProgresso.Position := cdsPrevisoes.RecNo;
      Application.ProcessMessages;
      cdsPrevisoes.Edit;
      cdsPrevisoesDESCRI.AsString := strDescri;
      cdsPrevisoes.Post;
      cdsPrevisoes.Next;
    End;
    cdsPrevisoes.RecNo := intRec;
    cdsPrevisoes.EnableControls;
    pbProgresso.Visible := False;
  Except
    On E : Exception Do
    Begin
      pbProgresso.Visible := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmCadPrevisao.btnCopiarValPagClick(Sender: TObject);
  Var
    dblValPag: Double;
    intRec   : Integer;
begin
  inherited;
  If (cdsPrevisoes.RecordCount = 0) Then
    Exit;

  dblValPag := cdsPrevisoesVALPAG.AsFloat;
  intRec    := cdsPrevisoes.RecNo;
  If fMensagem('','Copiar o Total a Pagar "R$ ' + FormatFloat(',0.00', dblValPag) + '" para o período?',['&Sim','&Não']) = 2 Then
    Exit;

  Try
    cdsPrevisoes.DisableControls;
    pbProgresso.Visible := True;
    pbProgresso.Max     := cdsPrevisoes.RecordCount;
    cdsPrevisoes.First;
    While Not cdsPrevisoes.Eof Do
    Begin
      pbProgresso.Position := cdsPrevisoes.RecNo;
      Application.ProcessMessages;
      cdsPrevisoes.Edit;
      cdsPrevisoesVALPAG.AsFloat := dblValPag;
      cdsPrevisoes.Post;
      cdsPrevisoes.Next;
    End;
    cdsPrevisoes.RecNo := intRec;
    cdsPrevisoes.EnableControls;
    pbProgresso.Visible := False;
  Except
    On E : Exception Do
    Begin
      pbProgresso.Visible := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmCadPrevisao.btnCopiarValRecClick(Sender: TObject);
  Var
    dblValRec: Double;
    intRec   : Integer;
begin
  inherited;
  If (cdsPrevisoes.RecordCount = 0) Then
    Exit;

  dblValRec := cdsPrevisoesVALREC.AsFloat;
  intRec    := cdsPrevisoes.RecNo;
  If fMensagem('','Copiar o Total a Receber "R$ ' + FormatFloat(',0.00', dblValRec) + '" para o período?',['&Sim','&Não']) = 2 Then
    Exit;

  Try
    cdsPrevisoes.DisableControls;
    pbProgresso.Visible := True;
    pbProgresso.Max     := cdsPrevisoes.RecordCount;
    cdsPrevisoes.First;
    While Not cdsPrevisoes.Eof Do
    Begin
      pbProgresso.Position := cdsPrevisoes.RecNo;
      Application.ProcessMessages;
      cdsPrevisoes.Edit;
      cdsPrevisoesVALREC.AsFloat := dblValRec;
      cdsPrevisoes.Post;
      cdsPrevisoes.Next;
    End;
    cdsPrevisoes.RecNo := intRec;
    cdsPrevisoes.EnableControls;
    pbProgresso.Visible := False;
  Except
    On E : Exception Do
    Begin
      pbProgresso.Visible := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmCadPrevisao.cdsPrevisoesAfterInsert(DataSet: TDataSet);
begin
  inherited;
  if dbgConsulta.Focused Then
    DataSet.Cancel;
end;

procedure TfrmCadPrevisao.dbgConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_Delete Then
  Begin
    pDeletaRegistro;
  End;

end;

procedure TfrmCadPrevisao.dbgConsultaKeyPress(Sender: TObject; var Key: Char);
  Var
    strKey: String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];
end;

procedure TfrmCadPrevisao.dbgConsultaTitleClick(Column: TColumn);
begin
  //inherited;

end;

procedure TfrmCadPrevisao.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadPrevisao.fGetSql(blnLike: Boolean): String;
begin
  Result := '';
  Result := Result + 'SELECT   ';
  Result := Result + '  *      ';
  Result := Result + 'FROM     ';
  Result := Result + '  CADPRE ';
  Result := Result + 'WHERE    ';
  Result := Result + '  PRE_CODEMP = ' + QuotedStr(edtCodEmp.Text) + ' AND ';
  Result := Result + '  PRE_DTALAN BETWEEN ' + QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(mskDtaIni.Text))) + ' AND ';
  Result := Result + QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(mskDtaFin.Text)));
end;

procedure TfrmCadPrevisao.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);

end;

procedure TfrmCadPrevisao.FormCreate(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
  cdsPrevisoes.CreateDataSet;
end;

procedure TfrmCadPrevisao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F8  : btnCopiarDescri.Click;
    VK_F9  : btnCopiarValPag.Click;
    VK_F10 : btnConfirmar.Click;
    VK_F11 : btnCopiarValRec.Click;
  End;
end;

procedure TfrmCadPrevisao.FormShow(Sender: TObject);
begin
  blnTemPesquisa := False;
  blnTemSelecao  := False;
  inherited;
end;

function TfrmCadPrevisao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (StrToDateDef(mskDtaIni.Text, 0) <= 0) Then
      begin
        fMensagem('', 'A Data Final do período informada é inválida!', ['&O k']);
        Result := False;
      end
      else
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'Informar a Data Inicial do Período!', ['&O k']);
        Result := False;
      End;

    End
    Else If (Sender = mskDtaFin) Then
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) and (StrToDateDef(mskDtaFin.Text, 0) <= 0) Then
      begin
        fMensagem('', 'A Data Final do período informada é inválida!', ['&O k']);
        Result := False;
      end
      else
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('', 'Informar a Data Final do Período!', ['&O k']);
        Result := False;
      End
      Else If (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text)) Then
      Begin
        fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('','Informar a Empresa!',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Essa empresa não está cadastrada!',['&O K']);
          Result := False;
        End;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadPrevisao.pAbreConsulta;
begin
  If cdsPrevisoes.Active Then
    cdsPrevisoes.CancelUpdates;

  pIncluiRegistros;
end;

procedure TfrmCadPrevisao.pDeletaRegistro;
  Var
    qryCadIns: TUniQuery;
begin

  If (cdsPrevisoes.RecordCount = 0) Then
    Exit;

  If fMensagem('','Confirma a exclusão da previsão?',['&Sim','&Não']) = 2 Then
    Exit;

  qryCadIns := fCriaQuery;
  Try
    With qryCadIns, SQL Do
    Begin
      Application.ProcessMessages;
      Close;
      Clear;
      Add(' DELETE FROM CADPRE ');
      Add(' WHERE');
      Add('   PRE_DTALAN = :DTALAN AND PRE_CODEMP = :CODEMP AND PRE_ESPECI = :ESPDOC');
      ParamByName('DTALAN').AsDateTime := cdsPrevisoesDTALAN.AsDateTime;
      ParamByName('CODEMP').AsString   := cdsPrevisoesCODEMP.AsString;
      ParamByName('ESPDOC').AsString   := cdsPrevisoesESPDOC.AsString;
      ExecSQL;
    End;
    fMensagem('AVISO', 'Previsão excluída com sucesso!', ['&O k']);
    pLimpaTela;
    //pAbreConsulta;
  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  FreeAndNil(qryCadIns);

end;

procedure TfrmCadPrevisao.pIncluiRegistros;
  Var
    qryCadPre: TUniQuery;
    dtaDtaLan: TDateTime;
    intTotDia: Integer;
    intAux   : Integer;
    evtAfterIns : TDataSetNotifyEvent;
begin
  evtAfterIns := cdsPrevisoes.AfterInsert;
  Try
    cdsPrevisoes.AfterInsert := Nil;
    intTotDia := Trunc(StrToDate(mskDtaFin.Text) - StrToDate(mskDtaIni.Text)) + 1;
    qryCadPre := fCriaQuery;
    cdsPrevisoes.DisableControls;
    cdsPrevisoes.EmptyDataSet;
    pbProgresso.Max     := intTotDia - 1;
    pbProgresso.Visible := True;
    For intAux := 0 To intTotDia - 1 Do
    Begin
      pbProgresso.Position := intAux;
      Application.ProcessMessages;

      dtaDtaLan := StrToDate(mskDtaIni.Text);
      dtaDtaLan := dtaDtaLan + intAux;
      With qryCadPre, SQL Do
      Begin
        Clear;
        Add('SELECT       ');
        Add(' PRE_VALAPA, ');
        Add(' PRE_VALARE, ');
        Add(' PRE_ESPECI, ');
        Add(' PRE_DESCRI  ');
        Add('FROM                      ');
        Add(' CADPRE                   ');
        Add('WHERE                     ');
        Add(' PRE_CODEMP = :CODEMP AND ');
        Add(' PRE_DTALAN = :DTALAN     ');
        ParamByName('CODEMP').AsString := edtCodEmp.Text;
        ParamByName('DTALAN').AsDate   := dtaDtaLan;
        Open;

        cdsPrevisoes.Append;
        cdsPrevisoesCODEMP.AsString   := edtCodEmp.Text;
        cdsPrevisoesDTALAN.AsDateTime := dtaDtaLan;
        cdsPrevisoesHORLAN.AsDateTime := fTime();
        If (RecordCount > 0) Then
        Begin
          cdsPrevisoesVALPAG.AsFloat  := FieldByName('PRE_VALAPA').AsFloat;
          cdsPrevisoesVALREC.AsFloat  := FieldByName('PRE_VALARE').AsFloat;
          cdsPrevisoesESPDOC.AsString := FieldByName('PRE_ESPECI').AsString;
          cdsPrevisoesDESCRI.AsString := FieldByName('PRE_DESCRI').AsString;
        End
        Else
        Begin
          cdsPrevisoesVALPAG.AsFloat  := 0;
          cdsPrevisoesVALREC.AsFloat  := 0;
          cdsPrevisoesESPDOC.AsString := edtEspDoc.Text;
          cdsPrevisoesDESCRI.AsString := '';
        End;
        cdsPrevisoes.Post;
      End;
    End;
  Finally
    pnlTail.Visible     := True;
    pbProgresso.Visible := False;
    cdsPrevisoes.First;
    cdsPrevisoes.EnableControls;
    cdsPrevisoes.AfterInsert := evtAfterIns;
    FreeAndNil(qryCadPre);
  end;
end;

procedure TfrmCadPrevisao.pLimpaTela;
begin
  cdsPrevisoes.EmptyDataSet;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
  edtEspDoc.Clear;
  pnlTail.Visible := False;
  pSetFocus(mskDtaIni);
end;

end.
