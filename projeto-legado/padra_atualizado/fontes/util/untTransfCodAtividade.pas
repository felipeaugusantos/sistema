
unit untTransfCodAtividade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, untPaiTransfCod, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls, EditFocus,
  Uni, AppEvnts, UniClientDataSet, strUtils, DB, untTypesSistema,
  untFuncoesSimples, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons, untTransfImportAutomatico, untZClient;

type
  TForeignKey = Record
    strCampoOri: String;
    strTabela  : String;
    strCampoRel: String;
  End;

type
  TForeignKeyArray = Array of TForeignKey;

Type
  TCamposAtividade = record
    strNomArq: String;
    strDesCam: String;
    strCamCod: String;
  End;

type
  TfrmTransfCodAtividade = class(TfrmPaiTransfCod)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtAtiOri: TEditFocus;
    edtDesAtiOri: TEditFocus;
    edtAtiDes: TEditFocus;
    edtDesAtiDes: TEditFocus;
    lsvArqAlterados: TListView;
    btnConfirmaDados: TBitBtnLocked;
    frxReport: TfrxReport;
    btnImpExcel: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtAtiOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtAtiDesKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnImpExcelClick(Sender: TObject);
  private
    { Private declarations }
    cdsAtividade: TZClient;
    blnDivergencia: Boolean;
    objExcelTrans: TTransfImportAutomatico;

    arrCamposAtividade: Array Of TCamposAtividade;

    function fTransfereCodAtividade: Boolean;
    function fAtualizaCodAtividade(strNomArq, strCampo, strAtiOri, strAtiDes: String; intOpcao: Integer): Integer;

    procedure pCriaClientAtividade;
    procedure pMostraDivergencia;
    procedure pCriaForm;
    procedure pPreencheArray;
    procedure pChecarTabelas;

  public
    { Public declarations }
    arrAtividade: TConsultasArray;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  end;

var
  frmTransfCodAtividade: TfrmTransfCodAtividade;

implementation


uses untConsultas,
     untFuncoesConsulta,
     untCfgRepositorio, untGravando, untModulo;

{$R *.dfm}

procedure TfrmTransfCodAtividade.FormCreate(Sender: TObject);
begin
  inherited;
  blnDivergencia := True;
  objExcelTrans := TTransfImportAutomatico.Create;

end;

{*********************************}
{* PESQUISAR ATIVIDADE DE ORIGEM *}
{******************************PZ*}
procedure TfrmTransfCodAtividade.edtAtiOriKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrAtivid: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtAtiOri, edtDesAtiOri, Nil, Key, arrAtivid) Then
  Begin
    if fValidaCampos(edtAtiOri, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

{**********************************}
{* PESQUISAR ATIVIDADE DE DESTINO. }
{*******************************PZ*}
procedure TfrmTransfCodAtividade.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfCodAtividade.btnImpExcelClick(Sender: TObject);
begin
  inherited;
  objExcelTrans.pAddEditInput(edtAtiOri, 3, True);
  objExcelTrans.pAddEditInput(edtAtiDes, 3, True);
  objExcelTrans.pEventoQueTransfere := btnConfirmaDados.OnClick;
  objExcelTrans.fExecutar;
end;

procedure TfrmTransfCodAtividade.edtAtiDesKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrAtivid: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtAtiDes, edtDesAtiDes, Nil, Key, arrAtivid) Then
  Begin
    if fValidaCampos(edtAtiDes, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

{*******************}
{* VALIDA CAMPOS    }
{****************PZ*}
function TfrmTransfCodAtividade.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtAtiOri) Then
  Begin

    If (fEmptyStr(edtAtiOri.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('A Atividade de origem deve ser preenchida!');
      Result := False;
    End
    Else If edtAtiOri.Text = edtAtiDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('A Atividade origem deve ser diferente da Atividade destino!');
      Result := False;
    End
    Else
    Begin
      pEdtCodSelectExit(edtAtiOri, edtDesAtiOri, arrAtividade, nil, fRetNomAtividade,
                        'da Atividade', 0 ,False, 'Código', False, objExcelTrans.blnExecutandoTransferencia);
      If (fEmptyStr(edtDesAtiOri.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Essa Atividade não está cadastrada!');
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtAtiDes) Then
  Begin

    If (fEmptyStr(edtAtiDes.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('A Atividade de destino deve ser preenchida!');
      Result := False;
    End
    Else If edtAtiOri.Text = edtAtiDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('A Atividade destino deve ser diferente da Atividade origem!');
      Result := False;
    End
    Else
    Begin
      pEdtCodSelectExit(edtAtiDes, edtDesAtiDes, arrAtividade, nil, fRetNomAtividade,
                        'da Atividade', 0 ,False, 'Código', False, objExcelTrans.blnExecutandoTransferencia);
      If (fEmptyStr(edtDesAtiDes.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Essa Atividade não está cadastrada!');
        Result := False;
      End;
    End;

  End;
end;

procedure TfrmTransfCodAtividade.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
     If (Sender <> objExcelTrans) And
       (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
       Exit;

    btnConfirmaDados.Enabled := False;
    If (fTransfereCodAtividade) Then
    Begin
      objExcelTrans.pAddNotificacao('Código da Atividade transferido corretamente!');

      lsvArqAlterados.Clear;
      btnConfirmaDados.Enabled := True;

      edtAtiOri.Clear;
      edtDesAtiOri.Clear;
      edtAtiDes.Clear;
      edtDesAtiDes.Clear;

      pSetFocus(edtAtiOri);
    End;

  End;
end;

{***********************}
{* TRANFERIR ATIVIDADE *}
{********************PZ*}
function TfrmTransfCodAtividade.fTransfereCodAtividade: Boolean;
  Var
    intContador    : Integer;
    intContador2   : Integer;
    intTamMat      : Integer;
    intRegAlterados: Integer;
    strSQL         : String;
    qryGenAti      : TUniQuery;
begin
  Try

    qryGenAti := fCriaQuery(Self);

    intTamMat   := Length(arrCamposAtividade);
    intContador := 0;

    Try

      While intContador < intTamMat Do
      Begin

        lsvArqAlterados.Items.Add;
        lsvArqAlterados.Items[intContador].Caption := arrCamposAtividade[intContador].strDesCam;
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
        {* ATUALIZAR ATIVIDADE DE ORIGEM *}
        {******************************PZ*}
        For intContador2 := 1 To 2 Do
        Begin

          intRegAlterados := intRegAlterados + fAtualizaCodAtividade(arrCamposAtividade[intContador].strNomArq,
                                                                     arrCamposAtividade[intContador].strCamCod,
                                                                     edtAtiOri.Text,
                                                                     edtAtiDes.Text,
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
      {* EXCLUIR ATIVIDADE DE ORIGEM *}
      {****************************PZ*}
      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CADATI WHERE ATI_CODATI = :ATIORI ';

      With qryGenAti Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('ATIORI').AsString := edtAtiOri.Text;
        Open;
        fVerificaIntegridade(Self.Name, 'CADATI', qryGenAti, True);
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADATI WHERE ATI_CODATI = :ATIORI ';
      With qryGenAti Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('ATIORI').AsString := edtAtiOri.Text;
        ExecSQL;
        Close;
      End;

      pGravarTabelaLog(edtAtiOri.Text, edtAtiDes.Text, 'CADATI');

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
          pMensagensErro(E.Message, '[fTransfereCodAtividade]');
      End;
    End;

  Finally
    FreeAndNil(qryGenAti);
  End;
end;

{**********************************}
{* ATUALIZAR ATIVIDADE DE DESTINO *}
{*******************************PZ*}
function TfrmTransfCodAtividade.fAtualizaCodAtividade(strNomArq, strCampo, strAtiOri, strAtiDes: String;
 intOpcao: Integer): Integer;
  Var
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
    strSQL := strSQL + '  ' + strCampo + ' = :ATIDES ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ' + strCampo + ' = :ATIORI ';

    If (strNomArq = 'CADFIS') Then
      strSQL := strSQL + ' AND FIS_TIP_FC = "F" ';

    If (strNomArq = 'CFGSIS') Then
    Begin
      strCFG := '';

      if Assigned(ProcRetCfgRelacionadaArquivo) then
        strCFG := ProcRetCfgRelacionadaArquivo('CADATI');

      if not fEmptyStr(strCFG) then
        strSQL := strSQL + ' AND SIS_CODCFG IN (' + strCFG + ')'
      Else
      Begin
        Result := 0;
        Exit;
      End;
    End;

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('ATIDES').AsString := strAtiDes;
      ParamByName('ATIORI').AsString := strAtiOri;
      ExecSQL;
      Result := RowsAffected;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;
end;

procedure TfrmTransfCodAtividade.pChecarTabelas;
begin
  frmGravandoGenericProcedure.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';
  Application.ProcessMessages;

  pPreencheArray;
  pCriaClientAtividade;
end;

procedure TfrmTransfCodAtividade.FormShow(Sender: TObject);
begin
  inherited;
  Try
    pSetFocus(edtAtiOri);
    TfrmGravando.fExecutarModal(pChecarTabelas, 'Validando Chave Estrangeira do Banco de Dados, Aguarde...', '');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodAtividade.FormShow]');
    End;
  End;

  Screen.Cursor := crDefault;
  pMostraDivergencia;
end;

procedure TfrmTransfCodAtividade.pCriaClientAtividade;
begin

  If Not Assigned(cdsAtividade) Then
  Begin
    cdsAtividade := TZClient.Create(Self);

    With cdsAtividade, qryQuery, SQL Do
    Begin
      Add('SELECT DISTINCT');
      Add('  table_name AS TABELA,');
      Add('  column_name AS CAMPO ');
      Add('  FROM information_schema.KEY_COLUMN_USAGE');
      Add('  LEFT JOIN TCOARR ON TCA_ARQREL = table_name AND TCA_CAMREL = column_name');
      Add('  WHERE');
      Add('      referenced_table_name = "CADATI"');
      Add('  AND referenced_column_name = "ATI_CODATI"');
      Add('  AND TCA_ARQREL IS NULL');

      If Assigned(frmModulo) Then
        Add('  AND CONSTRAINT_SCHEMA = ' + QuotedStr(frmModulo.GetCurrentConnection.database));

      fAbreClient(True, 'pCriaClientAtividade');
    End;
  End;

end;

procedure TfrmTransfCodAtividade.pMostraDivergencia;
begin
  With cdsAtividade Do
  Begin

    If Not IsEmpty Then
    Begin
      pCriaForm;
    End
    Else
      blnDivergencia := False;

  End;
end;

procedure TfrmTransfCodAtividade.pCriaForm;
  Var
    Form: TForm;
    Memo: TMemo;
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

	  With TLabel.Create(form) do
    Begin
		  Parent     := Form;
		  Caption    := 'Tabela(s) que não existe(m) na lista :';
		  Left       := 10;
		  Top        := 10;
      Font.Style := [fsBold];
	  End;

	  With TBitBtnLocked.Create(form) Do
    Begin
		  Parent  := form;
      Width   := 100;
		  Height  := 23;
		  Left    := 280;
		  Top     := 340;
		  Kind    := bkClose;
      Caption := '&Sair';
	  End;

		Memo := TMemo.Create(form);

	  With Memo Do
    Begin
		  Parent     := form;
		  Left       := 10;
		  Top        := 35;
      Color      := clInfoBk;
		  Width      := form.ClientWidth - 22;
      Height     := 300;
      ScrollBars := ssBoth;

      With cdsAtividade Do
      Begin
        First;
        While Not Eof Do
        Begin
          Lines.Add(FieldByName('TABELA').AsString + ' - ' + FieldByName('CAMPO').AsString);
          Next;
        End;
      End;

      ReadOnly := True;
	  End;

    Form.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodAtividade.pCriaForm]');
    End;
  End;

  pFreeAndNil(Form);
end;

procedure TfrmTransfCodAtividade.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsAtividade);
  FreeAndNil(objExcelTrans);
end;

procedure TfrmTransfCodAtividade.FormPaint(Sender: TObject);
begin
  inherited;
  If blnDivergencia Then
    btnSair.Click;
end;

procedure TfrmTransfCodAtividade.pPreencheArray;
  Var
    intPosicao: Integer;
    qryTcoArr : TUniQuery;
begin
  Try
    qryTcoArr := fCriaQuery();
    With qryTcoArr, SQL Do
    Begin
      Add(' SELECT                ');
      Add(' TCA_ARQREL,           ');
      Add(' TCA_CAMREL,           ');
      Add(' TCA_DESCRI            ');
      Add(' FROM TCOARR           ');
      Add(' WHERE                 ');
      Add(' TCA_ARQUIV = "CADATI" ');

      Open;

      intPosicao := 0;
      While Not Eof Do
      Begin

        SetLength(arrCamposAtividade, succ(intPosicao));

        arrCamposAtividade[intPosicao].strNomArq := FieldByName('TCA_ARQREL').AsString;
        arrCamposAtividade[intPosicao].strDesCam := FieldByName('TCA_DESCRI').AsString;
        arrCamposAtividade[intPosicao].strCamCod := FieldByName('TCA_CAMREL').AsString;

        Next;

        inc(intPosicao);

      End;

    End;

  Finally
    FreeAndNil(qryTcoArr);
  End;

end;

end.


