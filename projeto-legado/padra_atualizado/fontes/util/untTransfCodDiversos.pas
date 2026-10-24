unit untTransfCodDiversos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, untPaiTransfCod, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, ComCtrls,
  AppEvnts, Uni, UniClientDataSet, strUtils, DB, BitBtnLockedIncrem, untTypesSistema,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons, untTransfImportAutomatico, untZClient, untModulo;

type
  TForeignKey = Record
    strCampoOri: String;
    strTabela  : String;
    strCampoRel: String;
End;  

type
  TForeignKeyArray = Array of TForeignKey;  

Type
  TCamposDiverso = record
    strNomArq: String;
    strDesCam: String;
    strCamCod: String;

  End;

type
  TfrmTransfCodDiversos = class(TfrmPaiTransfCod)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtDivOri: TEditFocus;
    edtDesDivOri: TEditFocus;
    edtDivDes: TEditFocus;
    edtDesDivDes: TEditFocus;
    lsvArqAlterados: TListView;
    btnConfirmaDados: TBitBtnLocked;
    frxReport: TfrxReport;
    btnImpExcel: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtDivOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtDivDesKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure btnImpExcelClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
  private
    { Private declarations }
    arrCamposDiverso: Array Of TCamposDiverso;

    objExcelTrans: TTransfImportAutomatico;
    cdsDiverso: TZClient;
    blnDivergencia: Boolean;

    function fTransfereCodDiverso: Boolean;
    function fAtualizaCodDiverso(strNomArq, strCampo, strDivOri, strDivDes: String): Integer;

    procedure pCriaClientDiverso;
    procedure pMostraDivergencia;
    procedure pCriaForm;
    procedure pPreencheArray;
    procedure pChecarTabelas;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override; 
  public
    { Public declarations }
  end;

var
  frmTransfCodDiversos: TfrmTransfCodDiversos;

implementation

uses untfuncoesSimples,
     untConsultas,
     untCfgRepositorio, untGravando;

{$R *.dfm}

procedure TfrmTransfCodDiversos.FormCreate(Sender: TObject);
begin
  inherited;
  blnDivergencia := True;
  objExcelTrans := TTransfImportAutomatico.Create;
end;

procedure TfrmTransfCodDiversos.edtDivOriKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrProfis : TConsultasArray;
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE DIVERSOS *}
  {**************************DP*}
  If fPesqDiversos(Self, edtDivOri, edtDesDivOri, Nil, Key, arrProfis) Then
  Begin
    If fValidaCampos(edtDivOri, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTransfCodDiversos.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfCodDiversos.btnImpExcelClick(Sender: TObject);
begin
  inherited;
  objExcelTrans.pAddEditInput(edtDivOri, 8, True);
  objExcelTrans.pAddEditInput(edtDivDes, 8, True);
  objExcelTrans.pEventoQueTransfere := btnConfirmaDados.OnClick;
  objExcelTrans.fExecutar;
end;

procedure TfrmTransfCodDiversos.edtDivDesKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrProfis : TConsultasArray;
begin
  inherited;
  If fPesqDiversos(Self, edtDivDes, edtDesDivDes, Nil, Key, arrProfis) Then
  Begin
    If fValidaCampos(edtDivDes, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmTransfCodDiversos.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtDivOri) Then
  Begin

    If (fEmptyStr(edtDivOri.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O Diverso origem deve ser preenchido!');
      Result := False;
    End
    Else If edtDivOri.Text = edtDivDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O Diverso origem deve diferente do Diverso destino!');
      Result := False;
    End
    Else
    Begin
      edtDesDivOri.Text := fRetNomProfissional(edtDivOri.Text);
      If (fEmptyStr(edtDesDivOri.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse diverso não está cadastrado!');
        Result := False;
      End
    End;

  End

  Else If (Sender = edtDivDes) Then
  Begin

    If (fEmptyStr(edtDivDes.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O Diverso destino deve ser preenchido!');
      Result := False;
    End
    Else If edtDivOri.Text = edtDivDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O Diverso destino ser deve diferente do Diverso origem!');
      Result := False;
    End
    Else
    Begin
      edtDesDivDes.Text := fRetNomProfissional(edtDivDes.Text);
      If (fEmptyStr(edtDesDivDes.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse Diverso não está cadastrado!');
        Result := False;
      End
    End;

  End;


end;

function TfrmTransfCodDiversos.fTransfereCodDiverso: Boolean;
  Var
    intContador    : Integer;
    intTamMat      : Integer;
    intRegAlterados: Integer;
    strSQL         : String;
    qryGenOri      : TUniQuery;
begin
  Try

    qryGenOri := fCriaQuery(Self);

    intTamMat := Length(arrCamposDiverso);
    intContador := 0;

    Try

      While intContador < intTamMat Do
      Begin

        lsvArqAlterados.Items.Add;
        lsvArqAlterados.Items[intContador].Caption := arrCamposDiverso[intContador].strDesCam;
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


        intRegAlterados := intRegAlterados + fAtualizaCodDiverso(arrCamposDiverso[intContador].strNomArq,
                                                                 arrCamposDiverso[intContador].strCamCod,
                                                                 edtDivOri.Text,
                                                                 edtDivDes.Text);

        Application.ProcessMessages;

        lsvArqAlterados.Items[intContador].Selected := True;
        lsvArqAlterados.Items[intContador].MakeVisible(False);
        lsvArqAlterados.Items[intContador].SubItems[0] := IntToStr(intRegAlterados);

        Application.ProcessMessages;
        Inc(intContador);

      End;

      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CADDIV WHERE DIV_CODDIV = :DIVORI ';

      With qryGenOri Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DIVORI').AsString := edtDivOri.Text;
        Open;
        fVerificaIntegridade(Self.Name, 'CADDIV', qryGenOri, True);
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADDIV WHERE DIV_CODDIV = :DIVORI ';

      With qryGenOri Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DIVORI').AsString := edtDivOri.Text;
        ExecSQL;
        Close;
      End;

      pGravarTabelaLog(edtDivOri.Text, edtDivDes.Text, 'CADDIV');
      
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
          pMensagensErro(E.Message, '[fTransfereCodDiverso]');
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

function TfrmTransfCodDiversos.fAtualizaCodDiverso(strNomArq, strCampo, strDivOri, strDivDes: String): Integer;
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
    strSQL := strSQL + '  ' + strNomArq + ' ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  ' + strCampo + ' = :DIVDES ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ' + strCampo + ' = :DIVORI ';

    If (strNomArq = 'CFGSIS') Then
    Begin
      strCFG := '';

      If Assigned(ProcRetCfgRelacionadaArquivo) then
        strCFG := ProcRetCfgRelacionadaArquivo('CADDIV');

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
      ParamByName('DIVDES').AsString := strDivDes;
      ParamByName('DIVORI').AsString := strDivOri;
      ExecSQL;
      Result := RowsAffected;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

procedure TfrmTransfCodDiversos.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos) Then
  Begin
     If (Sender <> objExcelTrans) And
       (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
       Exit;

    btnConfirmaDados.Enabled := False;
    If (fTransfereCodDiverso) Then
    Begin
      objExcelTrans.pAddNotificacao('Código do Diverso transferido corretamente!');

      lsvArqAlterados.Clear;
      btnConfirmaDados.Enabled := True;

      edtDivOri.Clear;
      edtDesDivOri.Clear;
      edtDivDes.Clear;
      edtDesDivDes.Clear;

      pSetFocus(edtDivOri);
    End;

  End;

end;

procedure TfrmTransfCodDiversos.pChecarTabelas;
Begin
  frmGravandoGenericProcedure.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';
  Application.ProcessMessages;

  pPreencheArray;
  pCriaClientDiverso;
End;

procedure TfrmTransfCodDiversos.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDivOri);
  Try
    TfrmGravando.fExecutarModal(pChecarTabelas, 'Validando Chave Estrangeira do Banco de Dados, Aguarde...', '');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodDiverso.FormShow]');
    End;
  End;


  Screen.Cursor := crDefault;
  pMostraDivergencia;

end;

procedure TfrmTransfCodDiversos.pCriaClientDiverso;
begin

  If Not Assigned(cdsDiverso) Then
  Begin

    cdsDiverso := TZClient.Create(Self);

    With cdsDiverso, qryQuery, SQL Do
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

procedure TfrmTransfCodDiversos.pMostraDivergencia;
begin

  With cdsDiverso Do
  Begin

    If Not IsEmpty Then
    Begin
      pCriaForm;
    End
    Else
      blnDivergencia := False;

  End;

end;

procedure TfrmTransfCodDiversos.pCriaForm;
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

      With cdsDiverso Do
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
      pMensagensErro(E.Message, '[frmTransfCodDiverso.pCriaForm]');
    End;
  End;

  pFreeAndNil(Form);

end;


procedure TfrmTransfCodDiversos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(cdsDiverso);
  FreeAndNil(objExcelTrans);
end;

procedure TfrmTransfCodDiversos.FormPaint(Sender: TObject);
begin
  inherited;

  If blnDivergencia Then
    btnSair.Click;

end;

procedure TfrmTransfCodDiversos.pPreencheArray;
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
      Add(' TCA_ARQUIV = "CADDIV" ');

      Open;

      intPosicao := 0;
      While Not Eof Do
      Begin

        SetLength(arrCamposDiverso, succ(intPosicao));

        arrCamposDiverso[intPosicao].strNomArq := FieldByName('TCA_ARQREL').AsString;
        arrCamposDiverso[intPosicao].strDesCam := FieldByName('TCA_DESCRI').AsString;
        arrCamposDiverso[intPosicao].strCamCod := FieldByName('TCA_CAMREL').AsString;

        Next;

        inc(intPosicao);

      End;

    End;

  Finally
    FreeAndNil(qryTcoArr);
  End;

end;

end.



