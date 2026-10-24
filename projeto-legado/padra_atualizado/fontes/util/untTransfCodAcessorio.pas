unit untTransfCodAcessorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, untPaiTransfCod, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls, EditFocus,
  Uni, AppEvnts, UniClientDataSet, strUtils, DB, untTypesSistema,
  untFuncoesSimples, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons,
  untTransfImportAutomatico, untZClient;

type
  TForeignKey = Record
    strCampoOri: String;
    strTabela  : String;
    strCampoRel: String;
End;

type
  TForeignKeyArray = Array of TForeignKey;

type
  TCamposAcessorio = record
    strNomArq: String;
    strDesCam: String;
    strCamCod: String;
  end;

type
  TfrmTransfCodAcessorio = class(TfrmPaiTransfCod)
    btnConfirmaDados: TBitBtnLocked;
    btnImpExcel: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    frxReport: TfrxReport;

    lsvArqAlterados: TListView;
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtAceOri: TEditFocus;
    edtDesAceOri: TEditFocus;
    edtAceDes: TEditFocus;
    edtDesAceDes: TEditFocus;
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnImpExcelClick(Sender: TObject);
    procedure edtAceOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtAceDesKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    cdsAcessorio: TZClient;
    blnDivergencia: Boolean;
    objExcelTrans: TTransfImportAutomatico;
    arrCamposAcessorio: Array Of TCamposAcessorio;
    function fTransfereCodAcessorio: Boolean;
    function fAtualizaCodAcessorio(strNomArq, strCampo, strAceOri, strAceDes: String; intOpcao: Integer): Integer;
    procedure pMostraDivergencia;
    procedure pChecarTabelas;
    procedure pPreencheArray;
    procedure pCriaClientAcessorio;
    procedure pCriaForm;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  public
    { Public declarations }
    arrAcessorio: TConsultasArray;
  end;

var
  frmTransfCodAcessorio: TfrmTransfCodAcessorio;

implementation

uses untConsultas,
     untFuncoesConsulta,
     untCfgRepositorio, untGravando, untModulo;

{$R *.dfm}

procedure TfrmTransfCodAcessorio.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    If (Sender <> objExcelTrans) And
       (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
      Exit;

    btnConfirmaDados.Enabled := False;
    If (fTransfereCodAcessorio) Then
    Begin
      objExcelTrans.pAddNotificacao('Código do Acessório transferido corretamente!');

      lsvArqAlterados.Clear;
      btnConfirmaDados.Enabled := True;

      edtAceOri.Clear;
      edtDesAceOri.Clear;
      edtAceDes.Clear;
      edtDesAceDes.Clear;

      pSetFocus(edtAceOri);
    End;

  End;
end;

procedure TfrmTransfCodAcessorio.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfCodAcessorio.btnImpExcelClick(Sender: TObject);
begin
  inherited;
  objExcelTrans.pAddEditInput(edtAceOri, 2, True);
  objExcelTrans.pAddEditInput(edtAceDes, 2, True);
  objExcelTrans.pEventoQueTransfere := btnConfirmaDados.OnClick;
  objExcelTrans.fExecutar;
end;

procedure TfrmTransfCodAcessorio.edtAceDesKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;

  If fPesqAcessorios(Self, edtAceDes, edtDesAceDes, nil, Key, arrSel) Then
  Begin
    fValidaCampos(edtAceDes, False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTransfCodAcessorio.edtAceOriKeyPress(Sender: TObject; var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  If fPesqAcessorios(Self, edtAceOri, edtDesAceOri, nil, Key, arrSel) Then
  Begin
    fValidaCampos(edtAceOri, False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmTransfCodAcessorio.fAtualizaCodAcessorio(strNomArq, strCampo,
  strAceOri, strAceDes: String; intOpcao: Integer): Integer;
var
  strSQL   : String;
  strCFG   : String;
  qryGenTmp: TUniQuery;
begin
  Try
    Result := 0;

    qryGenTmp := fCriaQuery(Self);

    {*****************************************}
    {* OPÇÃO:                                *}
    {* 1 -> ARQUIVO                          *}
    {* 2 -> ARQUIVO DELETADO                 *}
    {**************************************PZ*}

    If intOpcao = 2 Then
      strNomArq := 'DEL_' + strNomArq;

    If Not fTabelaExiste(strNomArq) Then
      Exit;

    if Not fCampoExiste(strNomArq, strCampo) then
      Exit;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  ' + strNomArq + ' ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  ' + strCampo + ' = :ACEDES ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ' + strCampo + ' = :ACEORI ';

    If (strNomArq = 'CFGSIS') Then
    Begin
      strCFG := '';

      If Assigned(ProcRetCfgRelacionadaArquivo) then
        strCFG := ProcRetCfgRelacionadaArquivo('CADACE');

      if not fEmptyStr(strCFG) then
        strSQL := strSQL + ' AND SIS_CODCFG IN (' + strCFG + ')'
      Else
      Begin
        Result := 0;
        Exit;
      End;
    End;

    qryGenTmp.Close;
    qryGenTmp.SQL.Clear;
    qryGenTmp.SQL.Add(strSQL);
    qryGenTmp.ParamByName('ACEDES').AsString := strAceDes;
    qryGenTmp.ParamByName('ACEORI').AsString := strAceOri;
    qryGenTmp.ExecSQL;
    Result := qryGenTmp.RowsAffected;
    qryGenTmp.Close;
  Finally
    FreeAndNil(qryGenTmp);
  End;
end;

procedure TfrmTransfCodAcessorio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsAcessorio);
  FreeAndNil(objExcelTrans);
end;

procedure TfrmTransfCodAcessorio.FormCreate(Sender: TObject);
begin
  inherited;
  blnDivergencia := True;
  objExcelTrans := TTransfImportAutomatico.Create;
end;

procedure TfrmTransfCodAcessorio.FormPaint(Sender: TObject);
begin
  inherited;

  If blnDivergencia Then
    btnSair.Click;
end;

procedure TfrmTransfCodAcessorio.FormShow(Sender: TObject);
begin
  inherited;

  Try
    pSetFocus(edtAceOri);
    TfrmGravando.fExecutarModal(pChecarTabelas, 'Validando Chave Estrangeira do Banco de Dados, Aguarde...', '');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodAcessorio.FormShow]');
    End;
  End;

  Screen.Cursor := crDefault;
  pMostraDivergencia;
end;

function TfrmTransfCodAcessorio.fTransfereCodAcessorio: Boolean;
var
  intContador    : Integer;
  intContador2   : Integer;
  intTamMat      : Integer;
  intRegAlterados: Integer;
  strSQL         : String;
  qryGenAce      : TUniQuery;
begin
  Try
    qryGenAce := fCriaQuery(Self);

    intTamMat   := Length(arrCamposAcessorio);
    intContador := 0;

    Try
      While intContador < intTamMat Do
      Begin
        lsvArqAlterados.Items.Add;
        lsvArqAlterados.Items[intContador].Caption := arrCamposAcessorio[intContador].strDesCam;
        lsvArqAlterados.Items[intContador].SubItems.Add('Processando...');
        Inc(intContador);
        Application.ProcessMessages;
      End;

      intContador := 0;
      fStartTransaction;

      While intContador < intTamMat Do
      Begin
        Application.ProcessMessages;
        intRegAlterados := 0;

        {*********************************}
        {* ATUALIZAR ACESSÓRIO DE ORIGEM *}
        {******************************DH*}
        For intContador2 := 1 To 2 Do
        Begin
          intRegAlterados := intRegAlterados + fAtualizaCodAcessorio(arrCamposAcessorio[intContador].strNomArq,
                                                                     arrCamposAcessorio[intContador].strCamCod,
                                                                     edtAceOri.Text,
                                                                     edtAceDes.Text,
                                                                     intContador2);

          Application.ProcessMessages;
        End;

        lsvArqAlterados.Items[intContador].Selected := True;
        lsvArqAlterados.Items[intContador].MakeVisible(False);
        lsvArqAlterados.Items[intContador].SubItems[0] := IntToStr(intRegAlterados);

        Application.ProcessMessages;
        Inc(intContador);
      End;

      {*******************************}
      {* EXCLUIR ACESSÓRIO DE ORIGEM *}
      {****************************DH*}
      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CADACE WHERE ACE_CODACE = :ACEORI ';

      qryGenAce.Close;
      qryGenAce.SQL.Clear;
      qryGenAce.SQL.Add(strSQL);
      qryGenAce.ParamByName('ACEORI').AsString := edtAceOri.Text;
      qryGenAce.Open;
      fVerificaIntegridade(Self.Name, 'CADACE', qryGenAce, True);
      qryGenAce.Close;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADACE WHERE ACE_CODACE = :ACEORI ';

      qryGenAce.Close;
      qryGenAce.SQL.Clear;
      qryGenAce.SQL.Add(strSQL);
      qryGenAce.ParamByName('ACEORI').AsString := edtAceOri.Text;
      qryGenAce.ExecSQL;
      qryGenAce.Close;

      pGravarTabelaLog(edtAceOri.Text, edtAceDes.Text, 'CADACE');

      fCommit;
      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        If objExcelTrans.blnExecutandoTransferencia Then
          objExcelTrans.pAddNotificacao(E.Message)
        Else
          pMensagensErro(E.Message, '[fTransfereCodAcessorio]');
      End;
    End;

  Finally
    FreeAndNil(qryGenAce);
  End;
end;

function TfrmTransfCodAcessorio.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtAceOri) Then
  Begin
    If (fEmptyStr(edtAceOri.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O Acessório de origem deve ser preenchido!');
      Result := False;
    End
    Else If edtAceOri.Text = edtAceDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O Acessório origem deve ser diferente do Acessório destino!');
      Result := False;
    End
    Else
    Begin
      edtAceOri.Text := fPadL(edtAceOri.Text, edtAceOri.TamCampo, '0');
      pEdtCodSelectExit(edtAceOri, edtDesAceOri, arrAcessorio, fRetNomAcessorioOS, nil,
                        'do Acessório', 0 ,False, 'Código', False, objExcelTrans.blnExecutandoTransferencia);
      If (fEmptyStr(edtDesAceOri.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse Acessório não está cadastrado!');
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtAceDes) Then
  Begin

    If (fEmptyStr(edtAceDes.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O Acessório de destino deve ser preenchido!');
      Result := False;
    End
    Else If edtAceOri.Text = edtAceDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O Acessório destino deve ser diferente do Acessório origem!');
      Result := False;
    End
    Else
    Begin
      edtDesAceDes.Text := fPadL(edtDesAceDes.Text, edtDesAceDes.TamCampo, '0');
      pEdtCodSelectExit(edtAceDes, edtDesAceDes, arrAcessorio, fRetNomAcessorioOS, nil,
                        'do Acessório', 0 ,False, 'Código', False, objExcelTrans.blnExecutandoTransferencia);
      If (fEmptyStr(edtDesAceDes.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse Acessório não está cadastrado!');
        Result := False;
      End;
    End;

  End;
end;

procedure TfrmTransfCodAcessorio.pChecarTabelas;
begin
  frmGravandoGenericProcedure.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';
  Application.ProcessMessages;

  pPreencheArray;
  pCriaClientAcessorio;
end;

procedure TfrmTransfCodAcessorio.pCriaClientAcessorio;
begin
  if not Assigned(cdsAcessorio) then
  Begin
    cdsAcessorio := TZClient.Create(Self);

    cdsAcessorio.qryQuery.SQL.Add('SELECT DISTINCT');
    cdsAcessorio.qryQuery.SQL.Add('  table_name AS TABELA,');
    cdsAcessorio.qryQuery.SQL.Add('  column_name AS CAMPO ');
    cdsAcessorio.qryQuery.SQL.Add('  FROM information_schema.KEY_COLUMN_USAGE');
    cdsAcessorio.qryQuery.SQL.Add('  LEFT JOIN TCOARR ON TCA_ARQREL = table_name AND TCA_CAMREL = column_name');
    cdsAcessorio.qryQuery.SQL.Add('  WHERE');
    cdsAcessorio.qryQuery.SQL.Add('      referenced_table_name = "CADACE"');
    cdsAcessorio.qryQuery.SQL.Add('  AND referenced_column_name = "ACE_CODACE"');
    cdsAcessorio.qryQuery.SQL.Add('  AND TCA_ARQREL IS NULL');

    If Assigned(frmModulo) Then
    cdsAcessorio.qryQuery.SQL.Add('  AND CONSTRAINT_SCHEMA = ' + QuotedStr(frmModulo.GetCurrentConnection.database));

    cdsAcessorio.fAbreClient(True, 'pCriaClientAcessorio');
  End;
end;

procedure TfrmTransfCodAcessorio.pCriaForm;
var
  Form: TForm;
  Memo: TMemo;
  LLabel: TLabel;
  Lbtn: TBitBtnLocked;
begin
  Try
    pCriarFormularios(TForm, Form);

    Form.BorderStyle := bsDialog;
	  Form.Position    := poScreenCenter;
	  Form.Width       := 400;
	  Form.Height      := 400;
    Form.Font.Name   := 'Arial';
    Form.Font.Size   := 10;
    Form.Color       := $00FFE4D5;

	  LLabel := TLabel.Create(form);
    LLabel.Parent     := Form;
		LLabel.Caption    := 'Tabela(s) que não existe(m) na lista :';
		LLabel.Left       := 10;
		LLabel.Top        := 10;
    LLabel.Font.Style := [fsBold];

	  Lbtn := TBitBtnLocked.Create(form);
    Lbtn.Parent  := form;
    Lbtn.Width   := 100;
		Lbtn.Height  := 23;
		Lbtn.Left    := 280;
		Lbtn.Top     := 340;
		Lbtn.Kind    := bkClose;
    Lbtn.Caption := '&Sair';

		Memo := TMemo.Create(form);

	  Memo.Parent     := form;
		Memo.Left       := 10;
		Memo.Top        := 35;
    Memo.Color      := clInfoBk;
		Memo.Width      := form.ClientWidth - 22;
    Memo.Height     := 300;
    Memo.ScrollBars := ssBoth;

    cdsAcessorio.First;
    While Not cdsAcessorio.Eof Do
    Begin
      Memo.Lines.Add(cdsAcessorio.FieldByName('TABELA').AsString + ' - ' + cdsAcessorio.FieldByName('CAMPO').AsString);
      cdsAcessorio.Next;
    End;

    Memo.ReadOnly := True;

    Form.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodAcessorio.pCriaForm]');
    End;
  End;

  pFreeAndNil(Form);
end;

procedure TfrmTransfCodAcessorio.pMostraDivergencia;
begin
  if not cdsAcessorio.IsEmpty then
    pCriaForm
  else
    blnDivergencia := False;
end;

procedure TfrmTransfCodAcessorio.pPreencheArray;
var
  intPosicao: Integer;
  qryTcoArr : TUniQuery;
begin
  Try
    qryTcoArr := fCriaQuery();
    qryTcoArr.SQL.Add(' SELECT                ');
    qryTcoArr.SQL.Add(' TCA_ARQREL,           ');
    qryTcoArr.SQL.Add(' TCA_CAMREL,           ');
    qryTcoArr.SQL.Add(' TCA_DESCRI            ');
    qryTcoArr.SQL.Add(' FROM TCOARR           ');
    qryTcoArr.SQL.Add(' WHERE                 ');
    qryTcoArr.SQL.Add(' TCA_ARQUIV = "CADACE" ');
    qryTcoArr.Open;

    intPosicao := 0;
    While Not qryTcoArr.Eof Do
    Begin
      SetLength(arrCamposAcessorio, succ(intPosicao));

      arrCamposAcessorio[intPosicao].strNomArq := qryTcoArr.FieldByName('TCA_ARQREL').AsString;
      arrCamposAcessorio[intPosicao].strDesCam := qryTcoArr.FieldByName('TCA_DESCRI').AsString;
      arrCamposAcessorio[intPosicao].strCamCod := qryTcoArr.FieldByName('TCA_CAMREL').AsString;

      qryTcoArr.Next;
      inc(intPosicao);
    End;
  Finally
    FreeAndNil(qryTcoArr);
  End;
end;

end.
