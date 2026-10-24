unit Contabilidade.View.ExclusaoLanctoContabil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, ComboBoxFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxCurrencyEdit, CurrencyEditFocus, EditFocus, Contabilidade.View.TfrmPaiContabilidade,
  Uni, cxProgressBar, System.Types;

type
  TfrmExclusaoLanctoContabil = class(TfrmPaiContabilidade)
    pnlFundo: TPanel;
    Label12: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label1: TLabel;
    edtTipLan: TComboBoxFocus;
    Label2: TLabel;
    edtValor: TCurrencyEditFocus;
    lblCodEmp: TLabel;
    edtCodOpe: TEditFocus;
    edtDesOpe: TEditFocus;
    rdgLancto: TRadioGroup;
    mskContaDebito: TMaskEditFocus;
    mskContaCredito: TMaskEditFocus;
    edtDesContaCRedito: TEditFocus;
    edtDesContaDebito: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    btnGerar: TBitBtnLocked;
    Label5: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure mskContaDebitoExit(Sender: TObject);
    procedure mskContaDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaCreditoExit(Sender: TObject);
    procedure mskContaCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeExit(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure pDescarteSqlOutrasEmpresas(var AqryDelete: TUniQuery) ;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean = True): Boolean; Override;
  private
    FlblGravando : TLabel;
    { Private declarations }
    procedure pMontaQueryExclusaoLancamentoContabilLote(var AQuery: TUniQuery; var AprocurarLancDependentes: boolean);
    procedure pExclusaoLancamentoContabil;
    function fDeletaDadosGeradosPorOutraEmpresa(
      pgbProgresso: TcxProgressBar): Boolean;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
      strTexto: String);
    procedure pExcluirCheckList ;
    function fRetornaTipLan: TStringDynArray ;
    function fValidacaoComplementarExclusaoLote: Boolean ;
  public
    { Public declarations }
  end;

var
  frmExclusaoLanctoContabil: TfrmExclusaoLanctoContabil;

implementation

uses
  StrUtils, untTypesSistema, untFuncoesSimples, Contabilidade.Funcoes,
  untConsultas, Contabilidade.Consultas,
  Contabilidade.Classes.CheckListImportacao, DateUtils, Data.DB,
  Contabilidade.Interfaces, Contabilidade.Classes.FechamentoDiaMes,
  Contabilidade.Classes.UniQueryAuditoria;

{$R *.dfm}

{ TfrmExclusaoLanctoContabil }

procedure TfrmExclusaoLanctoContabil.btnGerarClick(Sender: TObject);
var
  strMensagem: string;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  if (fLancamentoAnteriorFechamento(StrToDate(mskDtaIni.Text), edtCodEmp.Text, strMensagem)) then
  begin
    fMensagem('', strMensagem, ['&OK']);
    Exit;
  end;

  if TVerificaFechamentoDiaMes.fTemFechamento(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), edtCodEmp.Text, False) then
  begin
    Exit;
  end;

  if not fValidacaoComplementarExclusaoLote then
    Exit ;

  If (fMensagem('', 'Confirmar exclusão dos lançamentos?', ['&Sim', '&Não'], 1) = 2) Then
    Exit;

  pExclusaoLancamentoContabil;

end;

procedure TfrmExclusaoLanctoContabil.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmExclusaoLanctoContabil.edtCodOpeExit(Sender: TObject);
begin
  edtDesOpe.Text := fRetNomeOperador(edtCodOpe.Text);
  If fEmptyStr(edtDesOpe.Text) And (Not fEmptyStr(edtCodOpe.Text))  Then
  Begin
    fMensagem('AVISO', 'Código do operador inválido!', ['&OK']);
    pSetFocus(edtCodOpe);
  End;
end;

procedure TfrmExclusaoLanctoContabil.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    if fPesqOperador(Self, edtCodOpe, edtDesOpe, qryTabela, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodOpe, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmExclusaoLanctoContabil.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmExclusaoLanctoContabil.FormCreate(Sender: TObject);
  var
    strMascara : String;
begin
  inherited;
  pCarregaTiposContabeis(edtTipLan, True, True);
  strMascara := fMskCon;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
  mskContaDebito.EditMask := strMascara;
  mskContaCredito.EditMask := strMascara;
end;

function TfrmExclusaoLanctoContabil.fRetornaTipLan: TStringDynArray;
var
  LintCnt: integer ;
begin
  SetLength(Result, 0);
  if (edtTipLan.ItemIndex >= 0) then
  begin
    SetLength(Result, Length(Result)+1);
    Result[High(Result)] := LeftStr(edtTipLan.Text, 3) ;
  end
  else
  begin
    for LintCnt := 0 to edtTipLan.Items.Count-1 do
    begin
      SetLength(Result, Length(Result)+1);
      Result[High(Result)] := LeftStr(edtTipLan.Items.Strings[LintCnt], 3) ;
    end ;
  end ;
end;

function TfrmExclusaoLanctoContabil.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&OK']);
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
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&OK']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&OK']);
              Result := False;
            End;
          End;
        End
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If (Not fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);
        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&OK']);
          Result := False;
        End;
      End
      Else
      begin
        edtNomEmp.Clear;
        fMensagem('ATENÇÃO!', 'Empresa deve ser preenchida!', ['&OK']);
        Result := False;
      end;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmExclusaoLanctoContabil.fValidacaoComplementarExclusaoLote: Boolean;
begin
  Result := True ;
  if StrToDate(mskDtaIni.Text) < IncDay(VS_Date, -90) then
  begin
    Result := fMensagem('', 'Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (90 dias). Deseja continuar?', ['&Sim', '&Não'], 2) = 1;
    if not Result then
    begin
      pSetFocus(mskDtaIni) ;
      Exit ;
    end ;
  end ;

  if fEmptyStr(edtTipLan.Text) then
  begin
    Result := fMensagem('', 'Tipo não informado. Deseja continuar?', ['&Sim', '&Não'], 2) = 1;
    if not Result then
    begin
      pSetFocus(edtTipLan) ;
      Exit ;
    end ;
  end ;

end;

procedure TfrmExclusaoLanctoContabil.mskContaCreditoExit(Sender: TObject);
var
  strTplaco : string ;
begin
  strTplaco := fRetTplacoEmpresaLogada ;
  edtDesContaCredito.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaCredito.Text), strTplaco], False);
  If (Not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) And (fEmptyStr(edtDesContaCredito.Text)) Then
  Begin
    fMensagem('ATENÇÃO!','Conta de Crédito Inválida!',['&OK']);
    pSetFocus(mskContaCredito);
    Exit;
  End;
end;

procedure TfrmExclusaoLanctoContabil.mskContaCreditoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPlan: TConsultasArray;
begin
  If fPesqPlanoContabil(Self, mskContaCredito, edtDesContaCRedito, Nil, Key, arrPlan) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmExclusaoLanctoContabil.mskContaDebitoExit(Sender: TObject);
var
  strTplaco: string ;
begin
  strTplaco := fRetTplacoEmpresaLogada ;
  edtDesContaDebito.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplaco], False);
  If (Not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) And (fEmptyStr(edtDesContaDebito.Text)) Then
  Begin
    fMensagem('ATENÇÃO!','Conta de Débito Inválida!',['&OK']);
    pSetFocus(mskContaDebito);
    Exit;
  End;
end;

procedure TfrmExclusaoLanctoContabil.mskContaDebitoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPlan: TConsultasArray;
begin
  If fPesqPlanoContabil(Self, mskContaDebito, edtDesContaDebito, Nil, Key, arrPlan) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmExclusaoLanctoContabil.pExcluirCheckList;
var
  LarrTipLan: TStringDynArray ;
  LstrTipLan: String ;
begin
  LarrTipLan := fRetornaTipLan ;
  for LstrTipLan in LarrTipLan do
  begin
    TProcessaCheckList.fEstornarPorExcecao(LstrTipLan, edtCodEmp.Text, StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text)) ;
  end ;
end;

procedure TfrmExclusaoLanctoContabil.pMontaQueryExclusaoLancamentoContabilLote(var AQuery: TUniQuery; var AprocurarLancDependentes: boolean );
begin
  AprocurarLancDependentes := False;

  AQuery.Close;
  AQuery.SQL.Clear;
  AQuery.SQL.Add(' SELECT * ');
  AQuery.SQL.Add('   FROM LANCON ');
  AQuery.SQL.Add('  WHERE CON_EMPLAN = :CODEMP ');
  AQuery.SQL.Add('    AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

  pDescarteSqlOutrasEmpresas(AQuery);

  AQuery.ParamByName('CODEMP').AsString := edtCodEmp.Text;
  AQuery.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
  AQuery.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);

  If (edtTipLan.ItemIndex >= 0) Then
  begin
    AQuery.SQL.Add('  AND CON_TIPLAN = :TIPLAN ');
    AQuery.ParamByName('TIPLAN').AsString := LeftStr(edtTipLan.Text, 3);
  end;

  If (edtValor.Value > 0) Then
  begin
    AQuery.SQL.Add('  AND CON_VALLAN = :VALLAN ');
    AQuery.ParamByName('VALLAN').AsFloat := edtValor.Value;
    AprocurarLancDependentes := True;
  end;

  If (Not fEmptyStr(edtCodOpe.Text)) Then
  begin
    AQuery.SQL.Add('  AND CON_CODOPE = :CODOPE ');
    AQuery.ParamByName('CODOPE').AsString := edtCodOpe.Text;
  end;

  Case rdgLancto.ItemIndex Of
    1: AQuery.SQL.Add('  AND CON_AUTOMA = 0 ');
    2: AQuery.SQL.Add('  AND CON_AUTOMA = 1 ');
  End;

  If (Not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) Then
  Begin
    AQuery.SQL.Add('  AND CON_CONDEB = :CONDEB ');
    AQuery.ParamByName('CONDEB').AsString := fSemMascaraPlaNco(mskContaDebito.Text);
    AprocurarLancDependentes := True;
  End;

  If (Not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) Then
  Begin
    AQuery.SQL.Add('  AND CON_CONCRE = :CONCRE ');
    AQuery.ParamByName('CONCRE').AsString := fSemMascaraPlaNco(mskContaCredito.Text);
    AprocurarLancDependentes := True;
  End;

end;

procedure TfrmExclusaoLanctoContabil.pExclusaoLancamentoContabil;
  Var
    qryDelete, qryDeletePartidaSimples : TUniQuery;
    LprocurarLancDependentes: Boolean;
    LAchouLancDependentes: Boolean;
    LqryExec: TUniQuery ;
    LarrAutoInc: Tarray<string>;
    LIndice: integer;

begin
  LprocurarLancDependentes := False;
  LAchouLancDependentes    := False;
  qryDeletePartidaSimples  := nil;

  qryDelete := fCriaQueryContabilidade('LANCON', Self.Name, Self);
  Try
    pMontaQueryExclusaoLancamentoContabilLote(qryDelete, LprocurarLancDependentes);

    qryDelete.Open ;
    qryDelete.First ;
    if not qryDelete.IsEmpty then
    begin
      If LprocurarLancDependentes Then
      Begin
        SetLength(LarrAutoInc, 0);
        LAchouLancDependentes := False;
        LqryExec := fCriaQuery ;
        Try
          while not qryDelete.Eof do
          begin
            if fEhExclusaoLancamentoPartidaSimples(qryDelete.FieldByName('AUTOINCREM').AsString, LarrAutoInc, LqryExec) then
              LAchouLancDependentes := True;

            qryDelete.Next;
          end ;
        Finally
          FreeAndNil(LqryExec);
        End;
      End;
    end ;

    If LAchouLancDependentes Then
    Begin
      LqryExec := fCriaQuery ;
      Try
        LqryExec.SQL.Add('SELECT AUTOINCREM, CON_EMPLAN, CON_DTALAN, CON_TIPLAN, CON_DESVAL, CON_CONCRE, CON_CONDEB, CON_VALLAN, CON_HISTOR ');
        LqryExec.SQL.Add('FROM LANCON ');
        LqryExec.SQL.Add('WHERE AUTOINCREM IN ( ');

        for Lindice := low(LarrAutoInc) to high(LarrAutoInc) do
        begin
          If LIndice = low(LarrAutoInc) Then
            LqryExec.SQL.Add( LarrAutoInc[Lindice] )
          else
            LqryExec.SQL.Add( ',' + LarrAutoInc[Lindice] );
        end;
        LqryExec.SQL.Add( ')' );

        LqryExec.Open;

        if (fMensagem('AVISO', 'Existe(m) Lançamento(s) efetuado(s) por Partida Simples que possuem Lançamentos dependentes, que também serão EXCLUÍDOS. Deseja visualizar os Lançamentos?', ['&Sim', '&Não']) = 1) then
          pMostraLancamentosDependentesDaPartidaSimples(LqryExec);

        if (fMensagem('AVISO', 'Confirma a EXCLUSÃO do(s) Lançamento(s) e de todos os seus Lançamentos dependentes?', ['&Sim', '&Não']) = 2) then
          Exit;

      Finally
        FreeAndNil(LqryExec);
      End;

    End;

  Finally
    FreeAndNil(qryDelete);
  End;

  qryDelete := fCriaQueryContabilidade('LANCON', Self.Name, Self);
  Try
    fStartTransaction();
    try

      FlblGravando := Nil ;
      try
        fChamaTelaGravando(fDeletaDadosGeradosPorOutraEmpresa) ;
      finally
        FlblGravando := Nil ;
      end ;

      pMontaQueryExclusaoLancamentoContabilLote(qryDelete, LprocurarLancDependentes);

      if Length(LarrAutoInc) > 0 then
      begin
        qryDelete.SQL.Add('UNION ');
        qryDelete.SQL.Add('SELECT * ');
        qryDelete.SQL.Add('FROM LANCON ');
        qryDelete.SQL.Add('WHERE AUTOINCREM IN ( ');

        for Lindice := low(LarrAutoInc) to high(LarrAutoInc) do
        begin
          If LIndice = low(LarrAutoInc) Then
            qryDelete.SQL.Add( LarrAutoInc[Lindice] )
          else
            qryDelete.SQL.Add( ',' + LarrAutoInc[Lindice] );
        end;
        qryDelete.SQL.Add( ')' );

      end;

      qryDelete.Open ;
      qryDelete.First ;
      if not qryDelete.IsEmpty then
      begin
        if Length(LarrAutoInc) = 0 then
        begin
          while not qryDelete.Eof do
            qryDelete.Delete;
        end
        else
        begin
          qryDeletePartidaSimples := fCriaQueryContabilidade('LANCON', Self.Name, Self);
          qryDeletePartidaSimples.SQL.Text := 'SELECT * FROM LANCON WHERE AUTOINCREM = :AUTOINCREM' ;
          while not qryDelete.Eof do
          begin
            qryDeletePartidaSimples.Close;
            qryDeletePartidaSimples.ParamByName('AUTOINCREM').AsString := qryDelete.FieldByName('AUTOINCREM').AsString;
            qryDeletePartidaSimples.Open ;

            qryDeletePartidaSimples.Delete;
            qryDelete.Next;
          end ;
        end;
      end ;

      pExcluirCheckList ;

      if (fConfiguracaoExiste('LTCONT')) then
      begin
        if fCfgSis('LTCONT', varBoolean) then
        begin
          qryDelete.Close;
          qryDelete.SQL.Clear;
          qryDelete.SQL.Add(' DELETE ');
          qryDelete.SQL.Add('   FROM LOTINC ');
          qryDelete.SQL.Add('  WHERE INC_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
          qryDelete.SQL.Add('    AND INC_EMPLAN = :CODEMP ');

          if (edtTipLan.ItemIndex >= 0) then
          begin
            qryDelete.SQL.Add('  AND INC_TIPLAN = :TIPLAN ');
            qryDelete.ParamByName('TIPLAN').AsString := LeftStr(edtTipLan.Text, 3);
          end;

          if (rdgLancto.ItemIndex > 0) then
          begin
            qryDelete.SQL.Add('  AND INC_AUTOMA = :AUTOMA ');
            qryDelete.ParamByName('AUTOMA').AsInteger := Pred(rdgLancto.ItemIndex);
          end;

          qryDelete.ParamByName('CODEMP').AsString := edtCodEmp.Text;
          qryDelete.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
          qryDelete.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);

          qryDelete.ExecSQL;
        end;
      end;
      fCommit();
    Except
      On E: Exception Do
      begin
        fRollBack();
        pMensagensErro(E.Message, 'TfrmExclusaoLanctoContabil.pExclusaoLancamentoContabil');
      end ;
    End;

    fMensagem('ATENÇÃO!', 'Exclusão concluída com sucesso!', ['&Ok']);
  Finally
    FreeAndNil(qryDelete);
    FreeAndNil(qryDeletePartidaSimples);
  End;
end;

function TfrmExclusaoLanctoContabil.fDeletaDadosGeradosPorOutraEmpresa(
  pgbProgresso: TcxProgressBar): Boolean;
var
  LarrIncDoc: TArrIncDoc ;
begin
  SetLength(LarrIncDoc, 0);
  result := fDeletaLacamentosGeradosParaOutraEmpresaExec(StrToDate(mskDtaIni.Text),
                                                            StrToDate(mskDtaFin.Text),
                                                            edtCodEmp.Text,
                                                            '',
                                                            LarrIncDoc,
                                                            pSetaTextoProgresso,
                                                            pgbProgresso,
                                                            edtValor.Value,
                                                            edtCodOpe.Text,
                                                            mskContaDebito.Text,
                                                            mskContaCredito.Text,
                                                            ifthen(edtTipLan.ItemIndex >= 0, LeftStr(edtTipLan.Text, 3), ''));
end;

procedure TfrmExclusaoLanctoContabil.pDescarteSqlOutrasEmpresas(var AqryDelete: TUniQuery);
begin
  AqryDelete.SQL.Add('  AND AUTOINCREM NOT IN ( SELECT CONTROLE FROM (');
  AqryDelete.SQL.Add('                          SELECT LANCNT.CNT_CONTRO  AS CONTROLE ');
  AqryDelete.SQL.Add('                          FROM LANCNT INNER JOIN LANCON AS L ON L.AUTOINCREM = LANCNT.CNT_CONTRO ');
  if edtTipLan.ItemIndex >= 0 then
  begin
    AqryDelete.SQL.Add(' WHERE L.CON_TIPLAN = :TIPLAN ');
    AqryDelete.ParamByName('TIPLAN').AsString := LeftStr(edtTipLan.Text, 3) ;
  end
  else
  begin
    AqryDelete.SQL.Add(' WHERE TRUE ');
  end ;
  AqryDelete.SQL.Add('  AND L.CON_EMPLAN = :CODEMP ');
  AqryDelete.SQL.Add('  AND L.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
  AqryDelete.ParamByName('CODEMP').AsString := edtCodEmp.Text;
  AqryDelete.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
  AqryDelete.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);

  If (edtValor.Value > 0) Then
  begin
    AqryDelete.SQL.Add('  AND L.CON_VALLAN = :VALLAN ');
    AqryDelete.ParamByName('VALLAN').AsFloat := edtValor.Value;
  end;

  If (Not fEmptyStr(edtCodOpe.Text)) Then
  begin
    AqryDelete.SQL.Add('  AND L.CON_CODOPE = :CODOPE ');
    AqryDelete.ParamByName('CODOPE').AsString := edtCodOpe.Text;
  end;

  Case rdgLancto.ItemIndex Of
    1: AqryDelete.SQL.Add('  AND L.CON_AUTOMA = 0 ');
    2: AqryDelete.SQL.Add('  AND L.CON_AUTOMA = 1 ');
  End;

  If (Not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) Then
  Begin
    AqryDelete.SQL.Add('  AND L.CON_CONDEB = :CONDEB ');
    AqryDelete.ParamByName('CONDEB').AsString := fSemMascaraPlaNco(mskContaDebito.Text);
  End;

  If (Not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) Then
  Begin
    AqryDelete.SQL.Add('  AND L.CON_CONCRE = :CONCRE ');
    AqryDelete.ParamByName('CONCRE').AsString := fSemMascaraPlaNco(mskContaCredito.Text);
  End;

  AqryDelete.SQL.Add(' ) AS SEL  ) ');
end;

procedure TfrmExclusaoLanctoContabil.pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
begin
  if assigned(FlblGravando) then
    FlblGravando.Caption := strTexto
  else if Assigned(pgbProgresso) And (Assigned(pgbProgresso.Parent)) and (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    FlblGravando := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));
    FlblGravando.Caption := strTexto;
  End;
  Application.ProcessMessages;
end;

end.
