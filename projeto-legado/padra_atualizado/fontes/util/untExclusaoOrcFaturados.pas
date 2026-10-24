unit untExclusaoOrcFaturados;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Dialogs,
  StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Uni, ExtCtrls, Mask,
  MaskEditFocus, AppEvnts, EditFocus, strUtils, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untTypesSistema;

type
  TfrmExclusaoOrcFaturados = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    mskDtaIni: TMaskEditFocus;
    Label1: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label2: TLabel;
    pnlFundo: TPanel;
    rdgOpcao: TRadioGroup;
    Label3: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVendedorExit(Sender: TObject);
  private
    { Private declarations }
    arrVendedor : TConsultasArray;
    procedure pDeletaOrcamentosFaturados;
    function  fSQLDelete: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    intQtdIte: Integer;
  end;

implementation

uses untFuncoes, untfuncoesSimples, DB,  untConsultas, untAtualizaOcorrenciasCRM,
  untFuncoesConsulta;

{$R *.dfm}

procedure TfrmExclusaoOrcFaturados.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmExclusaoOrcFaturados.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    pDeletaOrcamentosFaturados;
    pSetFocus(mskDtaIni);
  End;

end;

procedure TfrmExclusaoOrcFaturados.pDeletaOrcamentosFaturados;
  Var
    strSQL   : String;
    qryGenGor: TUniQuery;
    qryGenDor: TUniQuery;
    qryGenDel: TUniQuery;
    intOpcao : Integer;
    strCodEmp,
    strCodCli,
    strNumDoc: String;
    objAtuCrm: TAtuOcoCrm;
begin
  objAtuCrm := TAtuOcoCrm.Create(Nil);
  Try
    objAtuCrm.strNomFrm := Self.Name;
    intOpcao  := rdgOpcao.ItemIndex;
    qryGenGor := fCriaQuery(Self);
    qryGenDor := fCriaQuery(Self);
    qryGenDel := fCriaQuery(Self);

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT   ';
      strSQL := strSQL + '  *      ';
      strSQL := strSQL + 'FROM     ';
      strSQL := strSQL + '  FATGOR ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  FGO_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  FGO_ESPDOC = :ESPDOC AND ';

      If (Not fEmptyStr(edtCodVendedor.Text)) Or (Length(arrVendedor) > 0) Then
        strSQL := strSQL + '  FGO_CODVEN IN (' + fArrCodigosToLista(edtCodVendedor.Text, arrVendedor) + ') AND ';

      strSQL := strSQL + '  FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

      If intOpcao = 0 Then
        strSQL := strSQL + '  AND FGO_JAFATU = TRUE ';

      If intOpcao = 1 Then
        strSQL := strSQL + '  AND FGO_JAFATU = FALSE ';

      With qryGenGor Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString   := VS_strCodEmp;
        ParamByName('ESPDOC').AsString   := 'OR';
        ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
        Open;
      End;

      If (Not qryGenGor.IsEmpty) Then
      Begin
        intQtdIte := qryGenGor.RecordCount;
        strSQL := AnsiReplaceStr(strSQL,'FATGOR','FATDOR');
        strSQL := AnsiReplaceStr(strSQL,'FGO','FDO');

        {*********************************}
        {* CARREGA OS ITENS DO ORÇAMENTO *}
        {******************************PZ*}
        With qryGenDor Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODEMP').AsString   := VS_strCodEmp;
          ParamByName('ESPDOC').AsString   := 'OR';
          ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
          ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);

          Open;
        End;

        fStartTransaction;

        {*******************************************}
        {* GRAVA OS REGISTROS NA TABELA DEL_FATDOR *}
        {****************************************PZ*}
        qryGenDor.First;
        While Not qryGenDor.Eof Do
        Begin
          fVerificaIntegridade(Self.Name, 'FATDOR', qryGenDor);
          qryGenDor.Next
        End;

        {*******************************************}
        {* GRAVA OS REGISTROS NA TABELA DEL_FATGOR *}
        {****************************************PZ*}
        qryGenGor.First;
        While Not qryGenGor.Eof Do
        Begin
          fVerificaIntegridade(Self.Name, 'FATGOR', qryGenGor);
          qryGenGor.Next
        End;

        {***********************************}
        {* REALIZA BAIXA DE OCORRENCIA CRM *}
        {***********************************}
        If fCfgSis('UTICRM', varBoolean) Then
        Begin
          qryGenGor.First;
          While Not qryGenGor.Eof Do
          Begin
            strCodEmp := qryGenGor.FieldByName('FGO_CODEMP').AsString;
            strCodCli := qryGenGor.FieldByName('FGO_CODCLI').AsString;
            strNumDoc := qryGenGor.FieldByName('FGO_NUMDOC').AsString;

            objAtuCrm.pCarregaOcorrenciaCliente(strCodEmp, 'OR', strNumDoc, strCodCli);
            objAtuCrm.pFinalizaOcorrencia('Baixa realizada pela exclusão global de orçamentos.');
            qryGenGor.Next;
          End;
        End;

        {***********************************}
        {* APAGA OS ORÇAMENTOS             *}
        {********************************PZ*}
        With qryGenDel Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(fSQLDelete);
          ParamByName('CODEMP').AsString   := VS_strCodEmp;
          ParamByName('ESPDOC').AsString   := 'OR';
          ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
          ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);

          ExecSQL;
          fCommit;
          fMensagem('', 'Orçamentos excluídos com sucesso!' + #10#13 + 'Nº de Orçamentos excluídos: ' + IntToStr(intQtdIte), ['&O k']);
        End;
      End
      Else
        fMensagem('', 'Não foram encontrados Orçamentos para exclusão!', ['&O k']);

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[fDeletaOrcamentosFaturados]');
      End;
    End;

  Finally
    FreeAndNil(qryGenGor);
    FreeAndNil(qryGenDor);
    FreeAndNil(qryGenDel);
    FreeAndNil(objAtuCrm);
  End;

end;

function TfrmExclusaoOrcFaturados.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (Not fCompDatas(mskDtaIni.Text, mskDtaFin.Text)) Then
      Begin
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmExclusaoOrcFaturados.FormCreate(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
end;

procedure TfrmExclusaoOrcFaturados.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (ActiveControl Is TRadioButton) Then
    self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmExclusaoOrcFaturados.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fEntraCons(Key) then
  begin
    if fPesqOperador(Self, edtCodVendedor, edtDesVendedor, qryTabela, Key, arrVendedor, False) then
    Begin
      If fValidaCampos(edtCodVendedor, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
End;

procedure TfrmExclusaoOrcFaturados.edtCodVendedorExit(Sender: TObject);
Begin
  inherited;

  pEdtCodSelectExit(edtCodVendedor, edtDesVendedor, arrVendedor, fRetNomeOperador, nil, 'do Vendedor');

End;

function TfrmExclusaoOrcFaturados.fSQLDelete: String;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  FATGOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FGO_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  FGO_ESPDOC = :ESPDOC AND ';

  If (Not fEmptyStr(edtCodVendedor.Text)) Or (Length(arrVendedor) > 0) Then
    strSQL := strSQL + '  FGO_CODVEN IN (' + fArrCodigosToLista(edtCodVendedor.Text, arrVendedor) + ') AND ';

  strSQL := strSQL + '  FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  If (rdgOpcao.ItemIndex = 0) Then
    strSQL := strSQL + '  AND FGO_JAFATU = TRUE '
  Else If (rdgOpcao.ItemIndex = 1) Then
    strSQL := strSQL + '  AND FGO_JAFATU = FALSE ';

  Result := strSQL;
end;


End.

