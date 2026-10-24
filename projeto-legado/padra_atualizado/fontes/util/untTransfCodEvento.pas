
unit untTransfCodEvento;

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
  TCamposEvento = record
    strNomArq: String;
    strDesCam: String;
    strCamCod: String;
  End;

type
  TfrmTransfCodEvento = class(TfrmPaiTransfCod)
    pnlCentral: TPanel;
    lblTransfMovEve: TLabel;
    lblParaEve: TLabel;
    edtEveOri: TEditFocus;
    edtDesEveOri: TEditFocus;
    edtEveDes: TEditFocus;
    edtDesEveDes: TEditFocus;
    lsvArqAlterados: TListView;
    btnConfirmaDados: TBitBtnLocked;
    frxReport: TfrxReport;
    btnImpExcel: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtEveOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtEveDesKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnImpExcelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    cdsEvento: TZClient;
    blnDivergencia: Boolean;
    objExcelTrans: TTransfImportAutomatico;

    arrCamposEvento: Array Of TCamposEvento;

    function fTransfereCodEvento: Boolean;
    function fAtualizaCodEvento(strNomArq, strCampo, strEveOri, strEveDes: String; intOpcao: Integer): Integer;

    procedure pCriaClientEvento;
    procedure pMostraDivergencia;
    procedure pCriaForm;
    procedure pPreencheArray;
    procedure pChecarTabelas;

  public
    { Public declarations }
    arrEvento: TConsultasArray;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  end;

var
  frmTransfCodEvento: TfrmTransfCodEvento;

implementation


uses untConsultas,
     untFuncoesConsulta,
     untCfgRepositorio, untGravando, untModulo;

{$R *.dfm}

procedure TfrmTransfCodEvento.FormCreate(Sender: TObject);
begin
  inherited;
  blnDivergencia := True;
  objExcelTrans := TTransfImportAutomatico.Create;

end;

procedure TfrmTransfCodEvento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

end;

{*********************************}
{* PESQUISAR EVENTO DE ORIGEM *}
{******************************PZ*}
procedure TfrmTransfCodEvento.edtEveOriKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEve: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE Evento *}
  {****************************RV*}
  If fPesqEventos(Self, edtEveOri, edtDesEveOri, Nil, Key, arrEve) Then
  Begin
    if fValidaCampos(edtEveOri, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

{**********************************}
{* PESQUISAR Evento DE DESTINO. }
{*******************************PZ*}
procedure TfrmTransfCodEvento.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfCodEvento.btnImpExcelClick(Sender: TObject);
begin
  inherited;
  objExcelTrans.pAddEditInput(edtEveOri, 3, True);
  objExcelTrans.pAddEditInput(edtEveDes, 3, True);
  objExcelTrans.pEventoQueTransfere := btnConfirmaDados.OnClick;
  objExcelTrans.fExecutar;
end;

procedure TfrmTransfCodEvento.edtEveDesKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEve: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE Evento *}
  {****************************RV*}
  If fPesqEventos(Self, edtEveDes, edtDesEveDes, Nil, Key, arrEve) Then
  Begin
    if fValidaCampos(edtEveDes, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

{*******************}
{* VALIDA CAMPOS    }
{****************PZ*}
function TfrmTransfCodEvento.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtEveOri) Then
  Begin

    If (fEmptyStr(edtEveOri.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O Evento de origem deve ser preenchido!');
      Result := False;
    End
    Else If edtEveOri.Text = edtEveDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O Evento origem deve ser diferente do Evento destino!');
      Result := False;
    End
    Else
    Begin
      pEdtCodSelectExit(edtEveOri, edtDesEveOri, arrEvento, nil, fRetEvento,
                        'do Evento', 0 ,False, 'Código', False, objExcelTrans.blnExecutandoTransferencia);

      If (fEmptyStr(edtDesEveOri.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse Evento não está cadastrado!');
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtEveDes) Then
  Begin

    If (fEmptyStr(edtEveDes.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O Evento de destino deve ser preenchido!');
      Result := False;
    End
    Else If edtEveOri.Text = edtEveDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O Evento destino deve ser diferente do Evento de origem!');
      Result := False;
    End
    Else
    Begin
      pEdtCodSelectExit(edtEveDes, edtDesEveDes, arrEvento, nil, fRetEvento,
                        'do Evento', 0 ,False, 'Código', False, objExcelTrans.blnExecutandoTransferencia);
      If (fEmptyStr(edtDesEveDes.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse Evento não está cadastrado!');
        Result := False;
      End;
    End;

  End;
end;

procedure TfrmTransfCodEvento.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
     If (Sender <> objExcelTrans) And
       (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
       Exit;

    btnConfirmaDados.Enabled := False;
    If (fTransfereCodEvento) Then
    Begin
      objExcelTrans.pAddNotificacao('Código do Evento transferido corretamente!');

      lsvArqAlterados.Clear;
      btnConfirmaDados.Enabled := True;

      edtEveOri.Clear;
      edtDesEveOri.Clear;
      edtEveDes.Clear;
      edtDesEveDes.Clear;

      pSetFocus(edtEveOri);
    End;

  End;
end;

{***********************}
{* TRANFERIR EVENTO *}
{********************PZ*}
function TfrmTransfCodEvento.fTransfereCodEvento: Boolean;
  Var
    intContador    : Integer;
    intContador2   : Integer;
    intTamMat      : Integer;
    intRegAlterados: Integer;
    strSQL         : String;
    qryGenEve      : TUniQuery;
begin
  Try

    qryGenEve := fCriaQuery(Self);

    intTamMat   := Length(arrCamposEvento);
    intContador := 0;

    Try

      While intContador < intTamMat Do
      Begin

        lsvArqAlterados.Items.Add;
        lsvArqAlterados.Items[intContador].Caption := arrCamposEvento[intContador].strDesCam;
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
        {* ATUALIZAR EVENTO DE ORIGEM *}
        {******************************PZ*}
        For intContador2 := 1 To 2 Do
        Begin

          intRegAlterados := intRegAlterados + fAtualizaCodEvento(arrCamposEvento[intContador].strNomArq,
                                                                     arrCamposEvento[intContador].strCamCod,
                                                                     edtEveOri.Text,
                                                                     edtEveDes.Text,
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
      {* EXCLUIR EVENTO DE ORIGEM *}
      {****************************PZ*}
      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CADEVE WHERE EVE_CODEVE = :CODEVE ';

      qryGenEve.Close;
      qryGenEve.SQL.Clear;
      qryGenEve.SQL.Add(strSQL);
      qryGenEve.ParamByName('CODEVE').AsString := edtEveOri.Text;
      qryGenEve.Open;
      fVerificaIntegridade(Self.Name, 'CADEVE', qryGenEve, True);
      qryGenEve.Close;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADEVE WHERE EVE_CODEVE = :CODEVE ';

      qryGenEve.Close;
      qryGenEve.SQL.Clear;
      qryGenEve.SQL.Add(strSQL);
      qryGenEve.ParamByName('CODEVE').AsString := edtEveOri.Text;
      qryGenEve.ExecSQL;
      qryGenEve.Close;

      pGravarTabelaLog(edtEveOri.Text, edtEveDes.Text, 'CADEVE');

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
          pMensagensErro(E.Message, '[fTransfereCodEvento]');
      End;
    End;

  Finally
    FreeAndNil(qryGenEve);
  End;
end;

{**********************************}
{* ATUALIZAR EVENTO DE DESTINO *}
{*******************************PZ*}
function TfrmTransfCodEvento.fAtualizaCodEvento(strNomArq, strCampo, strEveOri, strEveDes: String;
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

    If (Not fTabelaExiste(strNomArq)) Or ( Not fCampoExiste(strNomArq, strCampo)) Then
      Exit;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  ' + strNomArq + ' ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  ' + strCampo + ' = :EVEDES ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ' + strCampo + ' = :EVEORI ';

    If (strNomArq = 'CADFIS') Then
      strSQL := strSQL + ' AND FIS_TIP_FC = "F" ';

    If (strNomArq = 'CFGSIS') Then
    Begin
      strCFG := '';

      If Assigned(ProcRetCfgRelacionadaArquivo) then
        strCFG := ProcRetCfgRelacionadaArquivo('CADEVE');

      if fEmptyStr(strCFG) then
        Exit;

      strSQL := strSQL + ' AND SIS_CODCFG IN (' + strCFG + ')'

    End;

    qryGenTmp.Close;
    qryGenTmp.SQL.Clear;
    qryGenTmp.SQL.Add(strSQL);
    qryGenTmp.ParamByName('EVEDES').AsString := strEveDes;
    qryGenTmp.ParamByName('EVEORI').AsString := strEveOri;
    qryGenTmp.ExecSQL;
    Result := qryGenTmp.RowsAffected;
    qryGenTmp.Close;

  Finally
    FreeAndNil(qryGenTmp);
  End;
end;

procedure TfrmTransfCodEvento.pChecarTabelas;
begin
  frmGravandoGenericProcedure.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';
  Application.ProcessMessages;

  pPreencheArray;
  pCriaClientEvento;
end;

procedure TfrmTransfCodEvento.FormShow(Sender: TObject);
begin
  inherited;
  Try
    pSetFocus(edtEveOri);
    TfrmGravando.fExecutarModal(pChecarTabelas, 'Validando Chave Estrangeira do Banco de Dados, Aguarde...', '');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodEvento.FormShow]');
    End;
  End;

  Screen.Cursor := crDefault;
  pMostraDivergencia;
end;

procedure TfrmTransfCodEvento.pCriaClientEvento;
begin

  If Not Assigned(cdsEvento) Then
  Begin
    cdsEvento := TZClient.Create(Self);

    cdsEvento.qryQuery.SQL.Add('SELECT DISTINCT');
    cdsEvento.qryQuery.SQL.Add('  table_name AS TABELA,');
    cdsEvento.qryQuery.SQL.Add('  column_name AS CAMPO ');
    cdsEvento.qryQuery.SQL.Add('  FROM information_schema.KEY_COLUMN_USAGE');
    cdsEvento.qryQuery.SQL.Add('  LEFT JOIN TCOARR ON TCA_ARQREL = table_name AND TCA_CAMREL = column_name');
    cdsEvento.qryQuery.SQL.Add('  WHERE');
    cdsEvento.qryQuery.SQL.Add('      referenced_table_name = "CADEVE"');
    cdsEvento.qryQuery.SQL.Add('  AND referenced_column_name = "EVE_CODEVE"');
    cdsEvento.qryQuery.SQL.Add('  AND TCA_ARQREL IS NULL');

    If Assigned(frmModulo) Then
      cdsEvento.qryQuery.SQL.Add('  AND CONSTRAINT_SCHEMA = ' + QuotedStr(frmModulo.GetCurrentConnection.database));

    cdsEvento.fAbreClient(True, 'pCriaClientEvento');

  End;

end;

procedure TfrmTransfCodEvento.pMostraDivergencia;
begin
  If Not cdsEvento.IsEmpty Then
  Begin
    pCriaForm;
  End
  Else
    blnDivergencia := False;
end;

procedure TfrmTransfCodEvento.pCriaForm;
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

    TLabel.Create(form).Parent     := Form;
    TLabel.Create(form).Caption    := 'Tabela(s) que não existe(m) na lista :';
    TLabel.Create(form).Left       := 10;
    TLabel.Create(form).Top        := 10;
    TLabel.Create(form).Font.Style := [fsBold];

    TBitBtnLocked.Create(form).Parent  := form;
    TBitBtnLocked.Create(form).Width   := 100;
    TBitBtnLocked.Create(form).Height  := 23;
    TBitBtnLocked.Create(form).Left    := 280;
    TBitBtnLocked.Create(form).Top     := 340;
    TBitBtnLocked.Create(form).Kind    := bkClose;
    TBitBtnLocked.Create(form).Caption := '&Sair';

		Memo := TMemo.Create(form);

    Memo.Parent     := form;
    Memo.Left       := 10;
    Memo.Top        := 35;
    Memo.Color      := clInfoBk;
    Memo.Width      := form.ClientWidth - 22;
    Memo.Height     := 300;
    Memo.ScrollBars := ssBoth;

    cdsEvento.First;
    While Not cdsEvento.Eof Do
    Begin
      Memo.Lines.Add(cdsEvento.FieldByName('TABELA').AsString + ' - ' + cdsEvento.FieldByName('CAMPO').AsString);
      cdsEvento.Next;
    End;

    Memo.ReadOnly := True;

    Form.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodEvento.pCriaForm]');
    End;
  End;

  pFreeAndNil(Form);
end;

procedure TfrmTransfCodEvento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsEvento);
  FreeAndNil(objExcelTrans);
end;

procedure TfrmTransfCodEvento.FormPaint(Sender: TObject);
begin
  inherited;
  If blnDivergencia Then
    btnSair.Click;
end;

procedure TfrmTransfCodEvento.pPreencheArray;
  Var
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
    qryTcoArr.SQL.Add(' TCA_ARQUIV = "CADEVE" ');

    qryTcoArr.Open;

    intPosicao := 0;
    While Not qryTcoArr.Eof Do
    Begin

      SetLength(arrCamposEvento, succ(intPosicao));

      arrCamposEvento[intPosicao].strNomArq := qryTcoArr.FieldByName('TCA_ARQREL').AsString;
      arrCamposEvento[intPosicao].strDesCam := qryTcoArr.FieldByName('TCA_DESCRI').AsString;
      arrCamposEvento[intPosicao].strCamCod := qryTcoArr.FieldByName('TCA_CAMREL').AsString;

      qryTcoArr.Next;

      inc(intPosicao);

    End;

  Finally
    FreeAndNil(qryTcoArr);
  End;

end;

end.


