unit untTransfCodPlacaVeiculo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, untPaiTransfCod, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxButtons, Vcl.ComCtrls, Vcl.StdCtrls,
  EditFocus, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  untTransfImportAutomatico, untZClient, Data.DB,
  Vcl.Buttons, BitBtnLockedIncrem, Uni, Vcl.Mask, MaskEditFocus, System.StrUtils;

type
  TForeignKey = Record
    strCampoOri: String;
    strTabela  : String;
    strCampoRel: String;
  End;

  TForeignKeyArray = Array of TForeignKey;

  TCampo = record
    strNomArq: String;
    strDesCam: String;
    strCamCod: String;
  End;

  TfrmTransfCodPlacaVeiculo = class(TfrmPaiTransfCod)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtDesOri: TEditFocus;
    edtDesDes: TEditFocus;
    lsvArqAlterados: TListView;
    btnImpExcel: TBitBtnLocked;
    btnConfirmaDados: TBitBtnLocked;
    btnHlpImp: TcxButton;
    frxReport: TfrxReport;
    edtCodOri: TEditFocus;
    edtCodDes: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtCodOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDesKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure btnImpExcelClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    arrCampos: Array Of TCampo;
    objExcelTrans: TTransfImportAutomatico;
    cdsVeiculo: TZClient;
    blnDivergencia: Boolean;
    qryGenTmp: TUniQuery;
    function fTransferePlacaVeiculo: Boolean;
    function fAtualizaPlacaVeiculo(strNomArq, strCampo, strCodOri, strCodDes: String): Integer;
    function fCancelarTransferencia(Sender: TObject): Boolean;
    procedure pCriaClientVeiculo;
    procedure pMostraDivergencia;
    procedure pCriaForm;
    procedure pPreencheArray;
    procedure pChecarTabelas;
    Procedure pDeletaRegistrosDuplicadosCLIVEI(strCodigoOrigem, strCodigoDestino: String);
  public
    { Public declarations }
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  end;

var
  frmTransfCodPlacaVeiculo: TfrmTransfCodPlacaVeiculo;

implementation

uses untfuncoesSimples,
     untConsultas,
     untCfgRepositorio, untGravando, untTypesSistema, untModulo;

{$R *.dfm}

procedure TfrmTransfCodPlacaVeiculo.FormCreate(Sender: TObject);
begin
  inherited;
  blnDivergencia := True;
  objExcelTrans := TTransfImportAutomatico.Create;
  qryGenTmp := fCriaQuery(Self);
end;

procedure TfrmTransfCodPlacaVeiculo.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryGenTmp);
  inherited;
end;

procedure TfrmTransfCodPlacaVeiculo.edtCodOriKeyPress(Sender: TObject; var Key: Char);
Var
  arrVei : TConsultasArray;
begin
  inherited;
  If fPesqVeiculos(Self,
                   edtCodOri,
                   edtDesOri,
                   Nil,
                   Key,
                   arrVei) Then
  Begin
    edtCodOri.Text := ReplaceStr(edtCodOri.Text, '-', '');
    If fValidaCampos(edtCodOri, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTransfCodPlacaVeiculo.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfCodPlacaVeiculo.btnImpExcelClick(Sender: TObject);
begin
  inherited;
  objExcelTrans.pAddEditInput(edtCodOri, 7, True);
  objExcelTrans.pAddEditInput(edtCodDes, 7, True);
  objExcelTrans.pEventoQueTransfere := btnConfirmaDados.OnClick;
  objExcelTrans.fExecutar;
end;

procedure TfrmTransfCodPlacaVeiculo.edtCodDesKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrVeic : TConsultasArray;
begin
  inherited;
  If fPesqVeiculos(Self,
                   edtCodDes,
                   edtDesDes,
                   Nil,
                   Key,
                   arrVeic) Then
  Begin
    edtCodDes.Text := ReplaceStr(edtCodDes.Text, '-', '');
    If fValidaCampos(edtCodDes, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmTransfCodPlacaVeiculo.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (Sender = edtCodOri) Then
  Begin
    If (fEmptyStr(edtCodOri.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('A Placa origem deve ser preenchido!');
      Result := False;
    End
    Else If edtCodOri.Text = edtCodDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('A Placa origem deve diferente da Placa destino!');
      Result := False;
    End
    Else
    Begin
      edtDesOri.Text := fRetDescVeiculo(edtCodOri.Text);
      If (fEmptyStr(edtDesOri.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Essa Placa não está cadastrada!');
        Result := False;
      End
    End;
  End
  Else If (Sender = edtCodDes) Then
  Begin
    If (fEmptyStr(edtCodDes.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('A Placa destino deve ser preenchido!');
      Result := False;
    End
    Else If edtCodOri.Text = edtCodDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('A Placa destino ser deve diferente da Placa origem!');
      Result := False;
    End
    Else
    Begin
      edtDesDes.Text := fRetDescVeiculo(edtCodDes.Text);
      If (fEmptyStr(edtDesDes.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Essa Placa não está cadastrada!');
        Result := False;
      End
    End;
  End;
end;

function TfrmTransfCodPlacaVeiculo.fTransferePlacaVeiculo: Boolean;
  Var
    intContador    : Integer;
    intTamMat      : Integer;
    intRegAlterados: Integer;
    strSQL         : String;
    qryGenOri      : TUniQuery;
begin
  Try

    qryGenOri := fCriaQuery(Self);

    intTamMat := Length(arrCampos);
    intContador := 0;

    Try

      While intContador < intTamMat Do
      Begin

        lsvArqAlterados.Items.Add;
        lsvArqAlterados.Items[intContador].Caption := arrCampos[intContador].strDesCam;
        lsvArqAlterados.Items[intContador].SubItems.Add('Processando...');
        Inc(intContador);
        Application.ProcessMessages;

      End;

      intContador := 0;
      fStartTransaction;

      pDeletaRegistrosDuplicadosCLIVEI(edtCodOri.Text, edtCodDes.Text);

      While intContador < intTamMat Do
      Begin

        Application.ProcessMessages;
        intRegAlterados := 0;


        intRegAlterados := intRegAlterados + fAtualizaPlacaVeiculo(arrCampos[intContador].strNomArq,
                                                                   arrCampos[intContador].strCamCod,
                                                                   edtCodOri.Text,
                                                                   edtCodDes.Text);

        Application.ProcessMessages;

        lsvArqAlterados.Items[intContador].Selected := True;
        lsvArqAlterados.Items[intContador].MakeVisible(False);
        lsvArqAlterados.Items[intContador].SubItems[0] := IntToStr(intRegAlterados);

        Application.ProcessMessages;
        Inc(intContador);

      End;

      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CADVEI WHERE VEI_PLAVEI = :PLAORI ';

      qryGenOri.Close;
      qryGenOri.SQL.Clear;
      qryGenOri.SQL.Add(strSQL);
      qryGenOri.ParamByName('PLAORI').AsString := edtCodOri.Text;
      qryGenOri.Open;
      fVerificaIntegridade(Self.Name, 'CADVEI', qryGenOri, True);
      qryGenOri.Close;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADVEI WHERE VEI_PLAVEI = :PLAORI ';

      qryGenOri.Close;
      qryGenOri.SQL.Clear;
      qryGenOri.SQL.Add(strSQL);
      qryGenOri.ParamByName('PLAORI').AsString := edtCodOri.Text;
      qryGenOri.ExecSQL;
      qryGenOri.Close;

      pGravarTabelaLog(edtCodOri.Text, edtCodDes.Text, 'CADVEI');

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
          pMensagensErro(E.Message, '[fTransfereCodPlacaVeiculo]');
      End;
    End;

  Finally
    FreeAndNil(qryGenOri);
  End;

end;

function TfrmTransfCodPlacaVeiculo.fAtualizaPlacaVeiculo(strNomArq, strCampo, strCodOri, strCodDes: String): Integer;
begin
  Result := 0;
  If Not fTabelaExiste(strNomArq) Then
    Exit;
  if Not fCampoExiste(strNomArq, strCampo) then
    Exit;
  qryGenTmp.Sql.Clear;
  qryGenTmp.Sql.Add('UPDATE');
  qryGenTmp.Sql.Add(strNomArq);
  qryGenTmp.Sql.Add('SET ');
  qryGenTmp.Sql.Add(strCampo + ' = :CODDES');
  qryGenTmp.Sql.Add('WHERE ');
  qryGenTmp.Sql.Add(strCampo + ' = :CODORI');
  qryGenTmp.ParamByName('CODDES').AsString := strCodDes;
  qryGenTmp.ParamByName('CODORI').AsString := strCodOri;
  qryGenTmp.ExecSQL;
  Result := qryGenTmp.RowsAffected;
  qryGenTmp.Close;
end;

function TfrmTransfCodPlacaVeiculo.fCancelarTransferencia(
  Sender: TObject): Boolean;
begin
  Result := False;

  If (Sender = objExcelTrans) Then
    Exit;

  If (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) = 1) Then
    Exit;

  Result := True;
end;

procedure TfrmTransfCodPlacaVeiculo.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
     If fCancelarTransferencia(Sender) Then
       Exit;
    btnConfirmaDados.Enabled := False;
    If (fTransferePlacaVeiculo) Then
    Begin
      objExcelTrans.pAddNotificacao('Placa do Veículo transferida corretamente!');
      lsvArqAlterados.Clear;
      btnConfirmaDados.Enabled := True;
      edtDesOri.Clear;
      edtDesDes.Clear;
      edtCodOri.Clear;
      edtCodDes.Clear;
      pSetFocus(edtCodOri);
    End;
  End;
end;

procedure TfrmTransfCodPlacaVeiculo.pChecarTabelas;
Begin
  frmGravandoGenericProcedure.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';
  Application.ProcessMessages;

  pPreencheArray;
  pCriaClientVeiculo;
End;

procedure TfrmTransfCodPlacaVeiculo.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodOri);
  Try
    TfrmGravando.fExecutarModal(pChecarTabelas, 'Validando Chave Estrangeira do Banco de Dados, Aguarde...', '');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodPlacaVeiculo.FormShow]');
    End;
  End;


  Screen.Cursor := crDefault;
  pMostraDivergencia;
end;

procedure TfrmTransfCodPlacaVeiculo.pCriaClientVeiculo;
begin

  If Not Assigned(cdsVeiculo) Then
  Begin

    cdsVeiculo := TZClient.Create(Self);

    cdsVeiculo.qryQuery.SQL.Add('SELECT DISTINCT');
    cdsVeiculo.qryQuery.SQL.Add('  table_name AS TABELA,');
    cdsVeiculo.qryQuery.SQL.Add('  column_name AS CAMPO ');
    cdsVeiculo.qryQuery.SQL.Add('  FROM information_schema.KEY_COLUMN_USAGE');
    cdsVeiculo.qryQuery.SQL.Add('  LEFT JOIN TCOARR ON TCA_ARQREL = table_name AND TCA_CAMREL = column_name');
    cdsVeiculo.qryQuery.SQL.Add('  WHERE');
    cdsVeiculo.qryQuery.SQL.Add('      referenced_table_name = "CADVEI"');
    cdsVeiculo.qryQuery.SQL.Add('  AND referenced_column_name = "VEI_PLAVEI"');

    cdsVeiculo.qryQuery.SQL.Add('  AND TCA_ARQREL IS NULL');

    If Assigned(frmModulo) Then
      cdsVeiculo.qryQuery.SQL.Add('  AND CONSTRAINT_SCHEMA = ' + QuotedStr(frmModulo.GetCurrentConnection.database));

    cdsVeiculo.fAbreClient(True, 'pCriaClient');

  End;

end;

procedure TfrmTransfCodPlacaVeiculo.pMostraDivergencia;
begin
  If Not cdsVeiculo.IsEmpty Then
  Begin
    pCriaForm;
  End
  Else
    blnDivergencia := False;
end;

procedure TfrmTransfCodPlacaVeiculo.pCriaForm;
  Var
    Form: TForm;
    Memo: TMemo;
    lblDin: TLabel;
    BitBtnLockedDin : TBitBtnLocked;
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

    lblDin := TLabel.Create(form);
    lblDin.Parent     := Form;
    lblDin.Caption    := 'Tabela(s) que não existe(m) na lista :';
    lblDin.Left       := 10;
    lblDin.Top        := 10;
    lblDin.Font.Style := [fsBold];

    BitBtnLockedDin := TBitBtnLocked.Create(form);
    BitBtnLockedDin.Parent  := form;
    BitBtnLockedDin.Width   := 100;
    BitBtnLockedDin.Height  := 23;
    BitBtnLockedDin.Left    := 280;
    BitBtnLockedDin.Top     := 340;
    BitBtnLockedDin.Kind    := bkClose;
    BitBtnLockedDin.Caption := '&Sair';

		Memo := TMemo.Create(form);

    Memo.Parent     := form;
    Memo.Left       := 10;
    Memo.Top        := 35;
    Memo.Color      := clInfoBk;
    Memo.Width      := form.ClientWidth - 22;
    Memo.Height     := 300;
    Memo.ScrollBars := ssBoth;

    cdsVeiculo.First;
    While Not cdsVeiculo.Eof Do
    Begin
      Memo.Lines.Add(cdsVeiculo.FieldByName('TABELA').AsString + ' - ' + cdsVeiculo.FieldByName('CAMPO').AsString);
      cdsVeiculo.Next;
    End;

    Memo.ReadOnly := True;

    Form.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodPlacaVeiculo.pCriaForm]');
    End;
  End;

  pFreeAndNil(Form);

end;


procedure TfrmTransfCodPlacaVeiculo.pDeletaRegistrosDuplicadosCLIVEI(strCodigoOrigem, strCodigoDestino: String);
  Var
    qrySQL, qryDelete: TUniQuery;
begin
  qrySQL := fCriaQuery;
  qryDelete := fCriaQuery;

  Try
    qrySQL.Close;
    qrySQL.SQL.Clear;
    qrySQL.SQL.Add('SELECT * FROM CLIVEI WHERE ');
    qrySQL.SQL.Add('  CLI_PLAVEI IN ( "' + strCodigoOrigem + '","'+ strCodigoDestino + '" ) ');
    qrySQL.SQL.Add(' GROUP BY CLI_CODCLI HAVING COUNT(1) > 1 ');
    qrySQL.Open;

    If (Not qrySQL.IsEmpty) Then
    Begin
      qrySQL.First;
      While (Not qrySQL.Eof) Do
      Begin
        qryDelete.Close;
        qryDelete.SQL.Clear;
        qryDelete.SQL.Add(' SELECT * FROM CLIVEI WHERE ' );
        qryDelete.SQL.Add(' CLI_PLAVEI =  "' + strCodigoOrigem + '" ' );
        qryDelete.SQL.Add(' AND CLI_CODCLI =  "' + qrySQL.FieldByName('CLI_CODCLI').AsString + '" ' );
        qryDelete.Open;

        If (Not qryDelete.IsEmpty) Then
        Begin
          fVerificaIntegridade(Self.Name, 'CLIVEI', qryDelete, True);

          qryDelete.Close;
          qryDelete.SQL.Clear;
          qryDelete.SQL.Add('DELETE FROM CLIVEI WHERE ');
          qryDelete.SQL.Add('  CLI_PLAVEI = "' + strCodigoOrigem + '" ');
          qryDelete.SQL.Add(' AND CLI_CODCLI =  "' + qrySQL.FieldByName('CLI_CODCLI').AsString + '" ' );
          qryDelete.ExecSQL;
        End;

        qrySQL.Next;
      End;
    End;
  Finally
    FreeAndNil(qryDelete);
    FreeAndNil(qryDelete);
  End;
end;

procedure TfrmTransfCodPlacaVeiculo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(cdsVeiculo);
  FreeAndNil(objExcelTrans);
end;

procedure TfrmTransfCodPlacaVeiculo.FormPaint(Sender: TObject);
begin
  inherited;

  If blnDivergencia Then
    btnSair.Click;

end;

procedure TfrmTransfCodPlacaVeiculo.pPreencheArray;
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
    qryTcoArr.SQL.Add(' TCA_ARQUIV = "CADVEI" ');

    qryTcoArr.Open;

    intPosicao := 0;
    While Not qryTcoArr.Eof Do
    Begin

      SetLength(arrCampos, succ(intPosicao));

      arrCampos[intPosicao].strNomArq := qryTcoArr.FieldByName('TCA_ARQREL').AsString;
      arrCampos[intPosicao].strDesCam := qryTcoArr.FieldByName('TCA_DESCRI').AsString;
      arrCampos[intPosicao].strCamCod := qryTcoArr.FieldByName('TCA_CAMREL').AsString;

      qryTcoArr.Next;

      inc(intPosicao);

    End;

  Finally
    FreeAndNil(qryTcoArr);
  End;

end;

end.
