{***********************}
{* qryConCid -> CADCID *}
{********************JB*}
{***********************}
{* qryCadCid -> CADCID *}
{********************RV*}
unit untTransfCodCidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, untPaiTransfCod, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls, ComCtrls,
  untTransfCodCid, Uni, AppEvnts, UniClientDataSet, strUtils, DB,
  BitBtnLockedIncrem, untTypesSistema, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons, untTransfImportAutomatico, untZClient;

type
  TForeignKey = Record
    strCampoOri: String;
    strTabela  : String;
    strCampoRel: String;
End;  

type
  TForeignKeyArray = Array of TForeignKey;

type
  TfrmTransfCodCidade = class(TfrmPaiTransfCod)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCidOri: TEditFocus;
    edtDesCidOri: TEditFocus;
    edtCidDes: TEditFocus;
    edtDesCidDes: TEditFocus;
    lsvArqAlterados: TListView;
    btnConfirmaDados: TBitBtnLocked;
    frxReport: TfrxReport;
    btnImpExcel: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    procedure edtCidOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtCidDesExit(Sender: TObject);
    procedure edtCidDesKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImpExcelClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    objCidade: TTransfCodCid;
    qryConCid: TUniQuery;
    qryCadCid: TUniQuery;

    objExcelTrans: TTransfImportAutomatico;
    cdsCidade: TZClient;
    blnDivergencia: Boolean;    

    procedure pCriaClient;
    procedure pMostraDivergencia;
    procedure pCriaForm;
    procedure pChecarTabelas;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  end;

var
  frmTransfCodCidade: TfrmTransfCodCidade;

implementation

uses untFuncoesSimples, untConsultas, untGravando, untModulo;

{$R *.dfm}

procedure TfrmTransfCodCidade.edtCidOriKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;

  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCidOri, edtDesCidOri, Nil, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(edtCidOri, True) Then
      SelectNext(ActiveControl, True, True);
  End;
  
end;

procedure TfrmTransfCodCidade.edtCidDesExit(Sender: TObject);
begin
  inherited;
end;

{***************************************}
{VALIDA CAMPOS                          }
{************************************RL*}
function TfrmTransfCodCidade.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCidOri) Then
  Begin

    If (fEmptyStr(edtCidOri.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('A cidade de origem deve ser preenchida !');
      Result := False;
    End
    Else If edtCidOri.Text = edtCidDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('A cidade origem deve diferente da cidade destino!');
      Result := False;
    End
    Else
    Begin
      If fEmptyStr(edtCidOri.Text) Then
        edtDesCidOri.Text := 'TODOS'
      Else
        edtDesCidOri.Text := fRetNomCidade(edtCidOri.Text);

      If fEmptyStr(edtDesCidOri.Text) And (Not fEmptyStr(edtCidOri.Text))  Then
      Begin
        objExcelTrans.pAddNotificacao('Código da cidade não encontrado.');
        edtCidOri.Clear;
        Result := False;
      End
      Else If (fEmptyStr(edtDesCidOri.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Essa cidade não está cadastrada!');
        Result := False;
      End;

    End;

  End

  Else If (Sender = edtCidDes) Then
  Begin

    If (fEmptyStr(edtCidDes.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('A cidade de destino deve ser preenchida!');
      Result := False;
    End
    Else If edtCidOri.Text = edtCidDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('A cidade destino deve diferente da cidade origem!');
      Result := False;
    End
    Else
    Begin

      If fEmptyStr(edtCidDes.Text) Then
        edtDesCidDes.Text := 'TODOS'
      Else
        edtDesCidDes.Text := fRetNomCidade(edtCidDes.Text);

      If fEmptyStr(edtDesCidDes.Text) And (Not fEmptyStr(edtCidDes.Text))  Then
      Begin
        objExcelTrans.pAddNotificacao('Código da cidade não encontrado.');
        edtCidDes.Clear;
        Result := False;
      End
      Else If (fEmptyStr(edtDesCidDes.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Essa cidade não está cadastrada!');
        Result := False;
      End;
    End;

  End;


end;

procedure TfrmTransfCodCidade.edtCidDesKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;

  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCidDes, edtDesCidDes, Nil, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(edtCidDes, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmTransfCodCidade.FormCreate(Sender: TObject);
begin
  inherited;

  blnDivergencia := True;  

  objCidade                 := TTransfCodCid.Create(Self);
  objCidade.lsvArqAlterados := lsvArqAlterados;

  objExcelTrans := TTransfImportAutomatico.Create;

  qryCadCid                 := fCriaQuery(Self);
  qryConCid                 := qryCadCid;
end;

procedure TfrmTransfCodCidade.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos) Then
  Begin
     If (Sender <> objExcelTrans) And
       (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
       Exit;
    objCidade.strCodCidOri := edtCidOri.Text;
    objCidade.strCodCidDes := edtCidDes.Text;

    btnConfirmaDados.Enabled := False;
    If (objCidade.fTransferirCodCidade) Then
    Begin
      objExcelTrans.pAddNotificacao('Código de cidade transferido corretamente!');

      lsvArqAlterados.Clear;
      btnConfirmaDados.Enabled := True;

      edtCidOri.Clear;
      edtDesCidOri.Clear;
      edtCidDes.Clear;
      edtDesCidDes.Clear;

      pSetFocus(edtCidOri);
    End
    Else If ObjExcelTrans.blnExecutandoTransferencia Then
      ObjExcelTrans.pAddNotificacao('Não foi possível transferir. Consulte a Tabela LOGERR!');
  End;

end;

procedure TfrmTransfCodCidade.pChecarTabelas;
Begin
  frmGravandoGenericProcedure.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';
  Application.ProcessMessages;

  objCidade.pPreencheArray;
  pCriaClient;
End;

procedure TfrmTransfCodCidade.FormShow(Sender: TObject);
begin
  inherited;

  Try
    pSetFocus(edtCidOri);
    TfrmGravando.fExecutarModal(pChecarTabelas, 'Validando Chave Estrangeira do Banco de Dados, Aguarde...', '');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodCidade.FormShow]');
    End;
  End;

  Screen.Cursor := crDefault;
  pMostraDivergencia;

end;

procedure TfrmTransfCodCidade.pCriaClient;
begin

  If Not Assigned(cdsCidade) Then
  Begin
    cdsCidade := TZClient.Create(Self);

    With cdsCidade, qryQuery, SQL Do
    Begin
      Add('SELECT DISTINCT');
      Add('  table_name AS TABELA,');
      Add('  column_name AS CAMPO ');
      Add('  FROM information_schema.KEY_COLUMN_USAGE');
      Add('  LEFT JOIN TCOARR ON TCA_ARQREL = table_name AND TCA_CAMREL = column_name');
      Add('  WHERE');
      Add('      referenced_table_name = "CADCID"');
      Add('  AND referenced_column_name = "CID_CODCID"');
      Add('  AND TCA_ARQREL IS NULL');

      If Assigned(frmModulo) Then
        Add('  AND CONSTRAINT_SCHEMA = ' + QuotedStr(frmModulo.GetCurrentConnection.database));

      fAbreClient(True, 'pCriaClient');
    End;
  End;

end;

procedure TfrmTransfCodCidade.pMostraDivergencia;
begin

  With cdsCidade Do
  Begin

    If Not IsEmpty Then
    Begin
      pCriaForm;
    End
    Else
      blnDivergencia := False;

  End;

end;

procedure TfrmTransfCodCidade.pCriaForm;
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

      With cdsCidade Do
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
      pMensagensErro(E.Message, '[frmTransfCodCidade.pCriaForm]');
    End;
  End;

  pFreeAndNil(Form);

end;

procedure TfrmTransfCodCidade.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsCidade);
  FreeAndNil(objExcelTrans);
  If (Action <> caNone) Then
  Begin
    FreeAndNil(qryCadCid);
  End;
end;

procedure TfrmTransfCodCidade.btnHlpImpClick(Sender: TObject);
begin
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfCodCidade.btnImpExcelClick(Sender: TObject);
begin
  inherited;
  objExcelTrans.pAddEditInput(edtCidOri, 5, True);
  objExcelTrans.pAddEditInput(edtCidDes, 5, True);
  objExcelTrans.pEventoQueTransfere := btnConfirmaDados.OnClick;
  objExcelTrans.fExecutar;
end;

procedure TfrmTransfCodCidade.FormPaint(Sender: TObject);
begin
  inherited;
  If blnDivergencia Then
    btnSair.Click;
end;

end.



