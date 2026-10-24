unit untTransfCodCorIndustrial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, untPaiTransfCod, Vcl.ExtCtrls, frxClass, Uni,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ComCtrls, EditFocus, untZClient, Data.DB;

Type
  TCamposCor = record
    strNomArq: String;
    strDesCam: String;
    strCamCod: String;
  End;

type
  TfrmTransfCodCorIndustrial = class(TfrmPaiTransfCod)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCorOri: TEditFocus;
    edtDesCorOri: TEditFocus;
    edtCorDes: TEditFocus;
    edtDesCorDes: TEditFocus;
    lsvArqAlterados: TListView;
    btnConfirmaDados: TBitBtnLocked;
    procedure edtCorOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtCorDesKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    arrCamposCor: Array Of TCamposCor;
    cdsCor : TZClient;
    blnDivergencia : Boolean;

    procedure pPreencheArray;
    procedure pCriaClientCor;
    procedure pCriaForm;
    procedure pMostraDivergencia;
    procedure pChecarTabelas;

    function fAtualizaCodCor(strNomArq, strCampo, strCorOri,strCorDes: String): Integer;
    function fTransfereCodCor: Boolean;

  public
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  end;

var
  frmTransfCodCorIndustrial: TfrmTransfCodCorIndustrial;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema, untModulo, untGravando,
  untCfgRepositorio;

procedure TfrmTransfCodCorIndustrial.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
     If (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
       Exit;

    btnConfirmaDados.Enabled := False;
    If (fTransfereCodCor) Then
    Begin
      pMensagemOK('Transferência realizada com Sucesso!');

      lsvArqAlterados.Clear;
      btnConfirmaDados.Enabled := True;

      edtCorOri.Clear;
      edtDesCorOri.Clear;
      edtCorDes.Clear;
      edtDesCorDes.Clear;

      pSetFocus(edtCorOri);
    End;

  End;

end;

procedure TfrmTransfCodCorIndustrial.edtCorDesKeyPress(Sender: TObject;  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqCores(Self, edtCorDes, edtDesCorDes, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCorDes, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmTransfCodCorIndustrial.edtCorOriKeyPress(Sender: TObject;  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqCores(Self, edtCorOri, edtDesCorOri, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCorOri, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmTransfCodCorIndustrial.FormCreate(Sender: TObject);
begin
  inherited;
  blnDivergencia := True;
end;

procedure TfrmTransfCodCorIndustrial.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsCor);
  inherited;
end;

procedure TfrmTransfCodCorIndustrial.FormPaint(Sender: TObject);
begin
  inherited;
  If blnDivergencia Then
    btnSair.Click;

end;

procedure TfrmTransfCodCorIndustrial.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCorOri);
  Try
    TfrmGravando.fExecutarModal(pChecarTabelas, 'Validando Chave Estrangeira do Banco de Dados, Aguarde...', '');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodCorIndustrial.FormShow]');
    End;
  End;

  Screen.Cursor := crDefault;
  pMostraDivergencia;
end;

function TfrmTransfCodCorIndustrial.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnValidaIndividual);

  if Result Then
  Begin
    If (Sender = edtCorOri) Then
    Begin
      edtDesCorOri.Text := fRetNomCor(edtCorOri.Text);
      If fEmptyStr(edtDesCorOri.Text) Then
      Begin
        Result := fMensagem('','Informe o Código da Cor de Origem!', ['&OK']) = -1;
      End;

    End

    Else
    If (Sender = edtCorDes) Then
    Begin
      edtDesCorDes.Text := fRetNomCor(edtCorDes.Text);
      If fEmptyStr(edtDesCorDes.Text) Then
      Begin
        Result := fMensagem('','Informe o Código da Cor de Destino!', ['&OK']) = -1;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmTransfCodCorIndustrial.pPreencheArray;
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
      Add(' TCA_ARQUIV = "CADCOR" ');

      Open;

      intPosicao := 0;
      While Not Eof Do
      Begin

        SetLength(arrCamposCor, Succ(intPosicao));

        arrCamposCor[intPosicao].strNomArq := FieldByName('TCA_ARQREL').AsString;
        arrCamposCor[intPosicao].strDesCam := FieldByName('TCA_DESCRI').AsString;
        arrCamposCor[intPosicao].strCamCod := FieldByName('TCA_CAMREL').AsString;

        Next;

        Inc(intPosicao);

      End;

    End;

  Finally
    FreeAndNil(qryTcoArr);
  End;

end;

procedure TfrmTransfCodCorIndustrial.pCriaClientCor;
begin

  If Not Assigned(cdsCor) Then
  Begin

    cdsCor := TZClient.Create(Self);

    With cdsCor, qryQuery, SQL Do
    Begin
      Add('SELECT DISTINCT');
      Add('  table_name AS TABELA,');
      Add('  column_name AS CAMPO ');
      Add('  FROM information_schema.KEY_COLUMN_USAGE');
      Add('  LEFT JOIN TCOARR ON TCA_ARQREL = table_name AND TCA_CAMREL = column_name');
      Add('  WHERE');
      Add('      referenced_table_name = "CADDIV"');
      Add('  AND referenced_column_name = "DIV_CODDIV"');
      Add('  AND TCA_ARQREL IS NULL');

      If Assigned(frmModulo) Then
        Add('  AND CONSTRAINT_SCHEMA = ' + QuotedStr(frmModulo.GetCurrentConnection.database));

      fAbreClient(True, 'pCriaClient');
    End;

  End;

end;

procedure TfrmTransfCodCorIndustrial.pMostraDivergencia;
begin

  With cdsCor Do
  Begin

    If Not IsEmpty Then
    Begin
      pCriaForm;
    End
    Else
      blnDivergencia := False;

  End;

end;

procedure TfrmTransfCodCorIndustrial.pCriaForm;
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

      With cdsCor Do
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
      pMensagensErro(E.Message, '[frmTransfCodCorIndustrial.pCriaForm]');
    End;
  End;

  pFreeAndNil(Form);

end;

procedure TfrmTransfCodCorIndustrial.pChecarTabelas;
Begin
  frmGravandoGenericProcedure.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';
  Application.ProcessMessages;

  pPreencheArray;
  pCriaClientCor;
End;

//

function TfrmTransfCodCorIndustrial.fTransfereCodCor: Boolean;
  Var
    intContador    : Integer;
    intTamMat      : Integer;
    intRegAlterados: Integer;
    strSQL         : String;
    qryGenOri      : TUniQuery;
begin
  Try

    qryGenOri := fCriaQuery(Self);

    intTamMat := Length(arrCamposCor);
    intContador := 0;

    Try

      While intContador < intTamMat Do
      Begin

        lsvArqAlterados.Items.Add;
        lsvArqAlterados.Items[intContador].Caption := arrCamposCor[intContador].strDesCam;
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


        intRegAlterados := intRegAlterados + fAtualizaCodCor(arrCamposCor[intContador].strNomArq,
                                                             arrCamposCor[intContador].strCamCod,
                                                             edtCorOri.Text,
                                                             edtCorDes.Text);

        Application.ProcessMessages;

        lsvArqAlterados.Items[intContador].Selected := True;
        lsvArqAlterados.Items[intContador].MakeVisible(False);
        lsvArqAlterados.Items[intContador].SubItems[0] := IntToStr(intRegAlterados);

        Application.ProcessMessages;
        Inc(intContador);

      End;

      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CADCOR WHERE COR_CODCOR = :CORORI ';

      With qryGenOri Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CORORI').AsString := edtCorOri.Text;
        Open;
        fVerificaIntegridade(Self.Name, 'CADCOR', qryGenOri, True);
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADCOR WHERE COR_CODCOR = :CORORI ';

      With qryGenOri Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CORORI').AsString := edtCorOri.Text;
        ExecSQL;
        Close;
      End;

      pGravarTabelaLog(edtCorOri.Text, edtCorDes.Text, 'CADCOR');

      fCommit;
      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '[fTransfereCodCor]');
      End;
    End;

  Finally
    FreeAndNil(qryGenOri);
  End;

end;

{*****************************************}
{* OPÇÃO:                                *}
{* 1 -> ARQUIVO                          *}
{* 3 -> ARQUIVO DELETADO                 *}
{**************************************MV*}

function TfrmTransfCodCorIndustrial.fAtualizaCodCor(strNomArq, strCampo, strCorOri, strCorDes: String): Integer;
  Var
    strSQL   : String;
    strCFG   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    Result := 0;

    qryGenTmp := fCriaQuery(Self);

    If Not fTabelaExiste(strNomArq) Then
      Exit;

    if Not fCampoExiste(strNomArq, strCampo) then
      Exit;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  ' + strNomArq + ' A ';

    If Pos(strNomArq, 'GEIMAT_GEDMAT_') > 0 Then
    Begin
      strSQL := strSQL + '  LEFT JOIN '+ strNomArq +' B ON B.GMT_CODEMP = A.GMT_CODEMP ';
      strSQL := strSQL + '                             AND B.GMT_CODITE = A.GMT_CODITE ';
      strSQL := strSQL + '                             AND B.GMT_CODCOR = :CORDES      ';
      strSQL := strSQL + '                             AND B.GMT_STATUS = "A"          ';
    End;

    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  A.' + strCampo + ' = :CORDES ';

    If Pos(strNomArq, 'GEIMAT_GEDMAT_') > 0 Then
      strSQL := strSQL + ', A.GMT_STATUS = IF( B.AUTOINCREM IS NOT NULL, "I", A.GMT_STATUS ) ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  A.' + strCampo + ' = :CORORI ';

    If (strNomArq = 'CFGSIS') Then
    Begin
      strCFG := '';

      If Assigned(ProcRetCfgRelacionadaArquivo) then
        strCFG := ProcRetCfgRelacionadaArquivo('CADCOR');

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
      ParamByName('CORDES').AsString := strCorDes;
      ParamByName('CORORI').AsString := strCorOri;
      ExecSQL;
      Result := RowsAffected;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;


end.
