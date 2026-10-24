
unit untTransfCodMotorista;

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
  TCamposMotorista = record
    strNomArq: String;
    strDesCam: String;
    strCamCod: String;
  End;

type
  TfrmTransfCodMotorista = class(TfrmPaiTransfCod)
    pnlCentral: TPanel;
    lblTransfMovMoto: TLabel;
    lblParaMoto: TLabel;
    edtMotOri: TEditFocus;
    edtDesMotOri: TEditFocus;
    edtMotDes: TEditFocus;
    edtDesMotDes: TEditFocus;
    lsvArqAlterados: TListView;
    btnConfirmaDados: TBitBtnLocked;
    frxReport: TfrxReport;
    btnImpExcel: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtMotOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtMotDesKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnImpExcelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    cdsMotorista: TZClient;
    blnDivergencia: Boolean;
    objExcelTrans: TTransfImportAutomatico;

    arrCamposMotorista: Array Of TCamposMotorista;

    function fTransfereCodMotorista: Boolean;
    function fAtualizaCodMotorista(strNomArq, strCampo, strAtiOri, strAtiDes: String; intOpcao: Integer): Integer;

    procedure pCriaClientMotorista;
    procedure pMostraDivergencia;
    procedure pCriaForm;
    procedure pPreencheArray;
    procedure pChecarTabelas;

  public
    { Public declarations }
    arrMotorista: TConsultasArray;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  end;

var
  frmTransfCodMotorista: TfrmTransfCodMotorista;

implementation


uses untConsultas,
     untFuncoesConsulta,
     untCfgRepositorio, untGravando, untModulo;

{$R *.dfm}

procedure TfrmTransfCodMotorista.FormCreate(Sender: TObject);
begin
  inherited;
  blnDivergencia := True;
  objExcelTrans := TTransfImportAutomatico.Create;

end;

procedure TfrmTransfCodMotorista.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

end;

{*********************************}
{* PESQUISAR MOTORISTA DE ORIGEM *}
{******************************PZ*}
procedure TfrmTransfCodMotorista.edtMotOriKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrMotor: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE MOTORISTA *}
  {****************************RV*}
  If fPesqMotorista(Self, edtMotOri, edtDesMotOri, Nil, Key, arrMotor) Then
  Begin
    if fValidaCampos(edtMotOri, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

{**********************************}
{* PESQUISAR MOTORISTA DE DESTINO. }
{*******************************PZ*}
procedure TfrmTransfCodMotorista.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfCodMotorista.btnImpExcelClick(Sender: TObject);
begin
  inherited;
  objExcelTrans.pAddEditInput(edtMotOri, 3, True);
  objExcelTrans.pAddEditInput(edtMotDes, 3, True);
  objExcelTrans.pEventoQueTransfere := btnConfirmaDados.OnClick;
  objExcelTrans.fExecutar;
end;

procedure TfrmTransfCodMotorista.edtMotDesKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrMotor: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE MOTORISTA *}
  {****************************RV*}
  If fPesqMotorista(Self, edtMotDes, edtDesMotDes, Nil, Key, arrMotor) Then
  Begin
    if fValidaCampos(edtMotDes, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

{*******************}
{* VALIDA CAMPOS    }
{****************PZ*}
function TfrmTransfCodMotorista.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtMotOri) Then
  Begin

    If (fEmptyStr(edtMotOri.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O Motorista de origem deve ser preenchido!');
      Result := False;
    End
    Else If edtMotOri.Text = edtMotDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O Motorista origem deve ser diferente do Motorista destino!');
      Result := False;
    End
    Else
    Begin
      pEdtCodSelectExit(edtMotOri, edtDesMotOri, arrMotorista, nil, fRetMotorista,
                        'do Motorista', 0 ,False, 'Código', False, objExcelTrans.blnExecutandoTransferencia);

      If (fEmptyStr(edtDesMotOri.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse Motorista não está cadastrado!');
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtMotDes) Then
  Begin

    If (fEmptyStr(edtMotDes.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O Motorista de destino deve ser preenchido!');
      Result := False;
    End
    Else If edtMotOri.Text = edtMotDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O Motorista destino deve ser diferente do Motorista de origem!');
      Result := False;
    End
    Else
    Begin
      pEdtCodSelectExit(edtMotDes, edtDesMotDes, arrMotorista, nil, fRetMotorista,
                        'do Motorista', 0 ,False, 'Código', False, objExcelTrans.blnExecutandoTransferencia);
      If (fEmptyStr(edtDesMotDes.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse Motorista não está cadastrado!');
        Result := False;
      End;
    End;

  End;
end;

procedure TfrmTransfCodMotorista.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
     If (Sender <> objExcelTrans) And
       (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
       Exit;

    btnConfirmaDados.Enabled := False;
    If (fTransfereCodMotorista) Then
    Begin
      objExcelTrans.pAddNotificacao('Código do Motorista transferido corretamente!');

      lsvArqAlterados.Clear;
      btnConfirmaDados.Enabled := True;

      edtMotOri.Clear;
      edtDesMotOri.Clear;
      edtMotDes.Clear;
      edtDesMotDes.Clear;

      pSetFocus(edtMotOri);
    End;

  End;
end;

{***********************}
{* TRANFERIR MOTORISTA *}
{********************PZ*}
function TfrmTransfCodMotorista.fTransfereCodMotorista: Boolean;
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

    intTamMat   := Length(arrCamposMotorista);
    intContador := 0;

    Try

      While intContador < intTamMat Do
      Begin

        lsvArqAlterados.Items.Add;
        lsvArqAlterados.Items[intContador].Caption := arrCamposMotorista[intContador].strDesCam;
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
        {* ATUALIZAR MOTORISTA DE ORIGEM *}
        {******************************PZ*}
        For intContador2 := 1 To 2 Do
        Begin

          intRegAlterados := intRegAlterados + fAtualizaCodMotorista(arrCamposMotorista[intContador].strNomArq,
                                                                     arrCamposMotorista[intContador].strCamCod,
                                                                     edtMotOri.Text,
                                                                     edtMotDes.Text,
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
      {* EXCLUIR MOTORISTA DE ORIGEM *}
      {****************************PZ*}
      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CADMOT WHERE MOT_CODMOT = :MOTORI ';

      qryGenAti.Close;
      qryGenAti.SQL.Clear;
      qryGenAti.SQL.Add(strSQL);
      qryGenAti.ParamByName('MOTORI').AsString := edtMotOri.Text;
      qryGenAti.Open;
      fVerificaIntegridade(Self.Name, 'CADMOT', qryGenAti, True);
      qryGenAti.Close;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADMOT WHERE MOT_CODMOT = :MOTORI ';

      qryGenAti.Close;
      qryGenAti.SQL.Clear;
      qryGenAti.SQL.Add(strSQL);
      qryGenAti.ParamByName('MOTORI').AsString := edtMotOri.Text;
      qryGenAti.ExecSQL;
      qryGenAti.Close;

      pGravarTabelaLog(edtMotOri.Text, edtMotDes.Text, 'CADMOT');

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
          pMensagensErro(E.Message, '[fTransfereCodMotorista]');
      End;
    End;

  Finally
    FreeAndNil(qryGenAti);
  End;
end;

{**********************************}
{* ATUALIZAR MOTORISTA DE DESTINO *}
{*******************************PZ*}
function TfrmTransfCodMotorista.fAtualizaCodMotorista(strNomArq, strCampo, strAtiOri, strAtiDes: String;
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
    strSQL := strSQL + '  ' + strCampo + ' = :MOTDES ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ' + strCampo + ' = :MOTORI ';

    If (strNomArq = 'CADFIS') Then
      strSQL := strSQL + ' AND FIS_TIP_FC = "F" ';

    If (strNomArq = 'CFGSIS') Then
    Begin
      strCFG := '';

      If Assigned(ProcRetCfgRelacionadaArquivo) then
        strCFG := ProcRetCfgRelacionadaArquivo('CADMOT');


      if fEmptyStr(strCFG) then
        Exit;

      strSQL := strSQL + ' AND SIS_CODCFG IN (' + strCFG + ')'

    End;

    qryGenTmp.Close;
    qryGenTmp.SQL.Clear;
    qryGenTmp.SQL.Add(strSQL);
    qryGenTmp.ParamByName('MOTDES').AsString := strAtiDes;
    qryGenTmp.ParamByName('MOTORI').AsString := strAtiOri;
    qryGenTmp.ExecSQL;
    Result := qryGenTmp.RowsAffected;
    qryGenTmp.Close;

  Finally
    FreeAndNil(qryGenTmp);
  End;
end;

procedure TfrmTransfCodMotorista.pChecarTabelas;
begin
  frmGravandoGenericProcedure.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';
  Application.ProcessMessages;

  pPreencheArray;
  pCriaClientMotorista;
end;

procedure TfrmTransfCodMotorista.FormShow(Sender: TObject);
begin
  inherited;
  Try
    pSetFocus(edtMotOri);
    TfrmGravando.fExecutarModal(pChecarTabelas, 'Validando Chave Estrangeira do Banco de Dados, Aguarde...', '');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodMotorista.FormShow]');
    End;
  End;

  Screen.Cursor := crDefault;
  pMostraDivergencia;
end;

procedure TfrmTransfCodMotorista.pCriaClientMotorista;
begin

  If Not Assigned(cdsMotorista) Then
  Begin
    cdsMotorista := TZClient.Create(Self);

    cdsMotorista.qryQuery.SQL.Add('SELECT DISTINCT');
    cdsMotorista.qryQuery.SQL.Add('  table_name AS TABELA,');
    cdsMotorista.qryQuery.SQL.Add('  column_name AS CAMPO ');
    cdsMotorista.qryQuery.SQL.Add('  FROM information_schema.KEY_COLUMN_USAGE');
    cdsMotorista.qryQuery.SQL.Add('  LEFT JOIN TCOARR ON TCA_ARQREL = table_name AND TCA_CAMREL = column_name');
    cdsMotorista.qryQuery.SQL.Add('  WHERE');
    cdsMotorista.qryQuery.SQL.Add('      referenced_table_name = "CADMOT"');
    cdsMotorista.qryQuery.SQL.Add('  AND referenced_column_name = "MOT_CODMOT"');
    cdsMotorista.qryQuery.SQL.Add('  AND TCA_ARQREL IS NULL');

    If Assigned(frmModulo) Then
      cdsMotorista.qryQuery.SQL.Add('  AND CONSTRAINT_SCHEMA = ' + QuotedStr(frmModulo.GetCurrentConnection.database));

    cdsMotorista.fAbreClient(True, 'pCriaClientMotorista');

  End;

end;

procedure TfrmTransfCodMotorista.pMostraDivergencia;
begin
  If Not cdsMotorista.IsEmpty Then
  Begin
    pCriaForm;
  End
  Else
    blnDivergencia := False;
end;

procedure TfrmTransfCodMotorista.pCriaForm;
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

    cdsMotorista.First;
    While Not cdsMotorista.Eof Do
    Begin
      Memo.Lines.Add(cdsMotorista.FieldByName('TABELA').AsString + ' - ' + cdsMotorista.FieldByName('CAMPO').AsString);
      cdsMotorista.Next;
    End;

    Memo.ReadOnly := True;

    Form.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodMotorista.pCriaForm]');
    End;
  End;

  pFreeAndNil(Form);
end;

procedure TfrmTransfCodMotorista.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsMotorista);
  FreeAndNil(objExcelTrans);
end;

procedure TfrmTransfCodMotorista.FormPaint(Sender: TObject);
begin
  inherited;
  If blnDivergencia Then
    btnSair.Click;
end;

procedure TfrmTransfCodMotorista.pPreencheArray;
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
    qryTcoArr.SQL.Add(' TCA_ARQUIV = "CADMOT" ');

    qryTcoArr.Open;

    intPosicao := 0;
    While Not qryTcoArr.Eof Do
    Begin

      SetLength(arrCamposMotorista, succ(intPosicao));

      arrCamposMotorista[intPosicao].strNomArq := qryTcoArr.FieldByName('TCA_ARQREL').AsString;
      arrCamposMotorista[intPosicao].strDesCam := qryTcoArr.FieldByName('TCA_DESCRI').AsString;
      arrCamposMotorista[intPosicao].strCamCod := qryTcoArr.FieldByName('TCA_CAMREL').AsString;

      qryTcoArr.Next;

      inc(intPosicao);

    End;

  Finally
    FreeAndNil(qryTcoArr);
  End;

end;

end.


