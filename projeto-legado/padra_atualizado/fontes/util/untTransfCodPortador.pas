unit untTransfCodPortador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, untPaiTransfCod, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxButtons, Vcl.ComCtrls, Vcl.StdCtrls,
  EditFocus, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  untTransfImportAutomatico, untZClient, Data.DB,
  Vcl.Buttons, BitBtnLockedIncrem, Uni,

  untTransfCod,untFuncaoPortadores;

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

  TfrmTransfCodPortador = class(TfrmPaiTransfCod)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCodOri: TEditFocus;
    edtPorOri: TEditFocus;
    edtCodDes: TEditFocus;
    edtPorDes: TEditFocus;
    lsvArqAlterados: TListView;
    btnImpExcel: TBitBtnLocked;
    btnConfirmaDados: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    frxReport: TfrxReport;
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
    cdsPortador: TZClient;
    blnDivergencia: Boolean;
    qryGenTmp: TUniQuery;
    function fTransfereCodPortador: Boolean;
    function fAtualizaCodPortador(strNomArq, strCampo, strCodOri, strCodDes: String): Integer;
    procedure pCriaClientPortador;
    procedure pMostraDivergencia;
    procedure pCriaForm;
    procedure pPreencheArray;
    procedure pChecarTabelas;
  public
    { Public declarations }
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  end;

var
  frmTransfCodPortador: TfrmTransfCodPortador;

implementation

uses untfuncoesSimples,
     untConsultas,
     untCfgRepositorio, untGravando, untTypesSistema, untModulo,
     untTIntegridadeTransferenciaCodigo;

{$R *.dfm}

procedure TfrmTransfCodPortador.FormCreate(Sender: TObject);
begin
  inherited;
  blnDivergencia := True;
  objExcelTrans := TTransfImportAutomatico.Create;
  qryGenTmp := fCriaQuery(Self);
end;

procedure TfrmTransfCodPortador.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryGenTmp);
  inherited;
end;

procedure TfrmTransfCodPortador.edtCodOriKeyPress(Sender: TObject; var Key: Char);
Var
  arrPor : TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples,
                   Self,
                   edtCodOri,
                   edtPorOri,
                   Nil,
                   Key,
                   arrPor) Then
  Begin
    If fValidaCampos(edtCodOri, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTransfCodPortador.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfCodPortador.btnImpExcelClick(Sender: TObject);
begin
  inherited;
  objExcelTrans.pAddEditInput(edtCodOri, 5, True);
  objExcelTrans.pAddEditInput(edtCodDes, 5, True);
  objExcelTrans.pEventoQueTransfere := btnConfirmaDados.OnClick;
  objExcelTrans.fExecutar;
end;

procedure TfrmTransfCodPortador.edtCodDesKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrProfis : TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples,
                   Self,
                   edtCodDes,
                   edtPorDes,
                   Nil,
                   Key,
                   arrProfis) Then
  Begin
    If fValidaCampos(edtCodDes, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmTransfCodPortador.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (Sender = edtCodOri) Then
  Begin
    If (fEmptyStr(edtCodOri.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O Portador origem deve ser preenchido!');
      Result := False;
    End
    Else If edtCodOri.Text = edtCodDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O Portador origem deve ser diferente do Portador destino!');
      Result := False;
    End
    Else
    Begin
      edtPorOri.Text := fRetNomPortador(edtCodOri.Text);
      If (fEmptyStr(edtPorOri.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse portador não está cadastrado!');
        Result := False;
      End
    End;
  End
  Else If (Sender = edtCodDes) Then
  Begin
    If (fEmptyStr(edtCodDes.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O Portador destino deve ser preenchido!');
      Result := False;
    End
    {*REQ*145940**********RP*}
    Else If Not fEmpresaTemAcessoPortador(edtCodDes.Text) Then
    Begin
      objExcelTrans.pAddNotificacao('Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no AutCom - Aba "Empresas Acesso"');
      Result := False;
    End
    Else If edtCodOri.Text = edtCodDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O Portador destino ser deve diferente do Portador origem!');
      Result := False;
    End
    Else
    Begin
      edtPorDes.Text := fRetNomPortador(edtCodDes.Text);
      If (fEmptyStr(edtPorDes.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse Portador não está cadastrado!');
        Result := False;
      End
    End;
  End;
end;

function TfrmTransfCodPortador.fTransfereCodPortador: Boolean;
  Var
    intContador    : Integer;
    intTamMat      : Integer;
    intRegAlterados: Integer;
    strSQL         : String;
    qryGenOri      : TUniQuery;
    objInteg       : TIntegridadeTransferenciaCodigo;
    LstrCfgsPortador: String;
begin

   try
    if not Assigned(ParamTransfCodPortador) then
      raise Exception.Create('Parâmetros da transferência não foram recebidos.');

    LstrCfgsPortador := strCfgsPortadorDll;

    if Trim(LstrCfgsPortador) = '' then
      raise Exception.Create('Configurações de portador não foram recebidas.');

    pValidarExclusaoPortadorDll(
      edtCodOri.Text,
      LstrCfgsPortador
    );

  except
    on E: Exception do
    begin
      fMensagem('ATENÇÃO', E.Message, ['&OK'], 1);
      Exit(False);
    end;
  end;

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

      objInteg := TIntegridadeTransferenciaCodigo.Create('CADPOR', edtCodOri.Text, edtCodDes.Text);
      Try
        objInteg.pAjustaRegistrosDuplicados(nil);
      Finally
        FreeAndNil(objInteg);
      End;

      While intContador < intTamMat Do
      Begin

        Application.ProcessMessages;
        intRegAlterados := 0;


        intRegAlterados := intRegAlterados + fAtualizaCodPortador(arrCampos[intContador].strNomArq,
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
      strSQL := strSQL + 'SELECT * FROM CADPOR WHERE POR_CODPOR = :PORORI ';

      With qryGenOri Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('PORORI').AsString := edtCodOri.Text;
        Open;
        fVerificaIntegridade(Self.Name, 'CADPOR', qryGenOri, True);
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADPOR WHERE POR_CODPOR = :PORORI ';

      With qryGenOri Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('PORORI').AsString := edtCodOri.Text;
        ExecSQL;
        Close;
      End;

      pGravarTabelaLog(edtPorOri.Text, edtPorDes.Text, 'CADPOR');

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
          pMensagensErro(E.Message, '[fTransfereCodPortador]');
      End;
    End;

  Finally
    FreeAndNil(qryGenOri);
  End;
end;

function TfrmTransfCodPortador.fAtualizaCodPortador(strNomArq, strCampo, strCodOri, strCodDes: String): Integer;
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

procedure TfrmTransfCodPortador.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
     If (Sender <> objExcelTrans) And (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
       Exit;
    btnConfirmaDados.Enabled := False;
    If (fTransfereCodPortador) Then
    Begin
      objExcelTrans.pAddNotificacao('Código do Portador transferido corretamente!');
      lsvArqAlterados.Clear;
      btnConfirmaDados.Enabled := True;
      edtPorOri.Clear;
      edtPorDes.Clear;
      edtCodOri.Clear;
      edtCodDes.Clear;
      pSetFocus(edtCodOri);
    End;
  End;
end;

procedure TfrmTransfCodPortador.pChecarTabelas;
Begin
  frmGravandoGenericProcedure.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';
  Application.ProcessMessages;

  pPreencheArray;
  pCriaClientPortador;
End;

procedure TfrmTransfCodPortador.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodOri);
  Try
    TfrmGravando.fExecutarModal(pChecarTabelas, 'Validando Chave Estrangeira do Banco de Dados, Aguarde...', '');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodPortador.FormShow]');
    End;
  End;


  Screen.Cursor := crDefault;
  pMostraDivergencia;

end;

procedure TfrmTransfCodPortador.pCriaClientPortador;
begin

  If Not Assigned(cdsPortador) Then
  Begin

    cdsPortador := TZClient.Create(Self);

    With cdsPortador, qryQuery, SQL Do
    Begin
      Add('SELECT DISTINCT');
      Add('  table_name AS TABELA,');
      Add('  column_name AS CAMPO ');
      Add('  FROM information_schema.KEY_COLUMN_USAGE');
      Add('  LEFT JOIN TCOARR ON TCA_ARQREL = table_name AND TCA_CAMREL = column_name');
      Add('  WHERE');
      Add('      referenced_table_name = "CADPOR"');
      Add('  AND referenced_column_name = "POR_CODPOR"');

      Add('  AND TCA_ARQREL IS NULL');

      If Assigned(frmModulo) Then
        Add('  AND CONSTRAINT_SCHEMA = ' + QuotedStr(frmModulo.GetCurrentConnection.database));

      fAbreClient(True, 'pCriaClient');
    End;

  End;

end;

procedure TfrmTransfCodPortador.pMostraDivergencia;
begin
  With cdsPortador Do
  Begin
    If Not IsEmpty Then
    Begin
      pCriaForm;
    End
    Else
      blnDivergencia := False;
  End;
end;

procedure TfrmTransfCodPortador.pCriaForm;
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

      With cdsPortador Do
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
      pMensagensErro(E.Message, '[frmTransfCodPortador.pCriaForm]');
    End;
  End;

  pFreeAndNil(Form);

end;


procedure TfrmTransfCodPortador.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(cdsPortador);
  FreeAndNil(objExcelTrans);
end;

procedure TfrmTransfCodPortador.FormPaint(Sender: TObject);
begin
  inherited;

  If blnDivergencia Then
    btnSair.Click;

end;

procedure TfrmTransfCodPortador.pPreencheArray;
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
      Add(' TCA_ARQUIV = "CADPOR" ');

      Open;

      intPosicao := 0;
      While Not Eof Do
      Begin

        SetLength(arrCampos, succ(intPosicao));

        arrCampos[intPosicao].strNomArq := FieldByName('TCA_ARQREL').AsString;
        arrCampos[intPosicao].strDesCam := FieldByName('TCA_DESCRI').AsString;
        arrCampos[intPosicao].strCamCod := FieldByName('TCA_CAMREL').AsString;

        Next;

        inc(intPosicao);

      End;

    End;

  Finally
    FreeAndNil(qryTcoArr);
  End;

end;

end.
