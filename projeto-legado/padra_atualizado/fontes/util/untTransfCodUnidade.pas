{***********************}
{* qryConCid -> CADCID *}
{********************JB*}

unit untTransfCodUnidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, untPaiTransfCod, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls, ComCtrls,
  untTransfCodUni, Uni, AppEvnts, UniClientDataSet, strUtils, DB,
  BitBtnLockedIncrem, untTypesSistema, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons, untTransfImportAutomatico,
  untZClient, untModulo;

type
  TForeignKey = Record
    strCampoOri: String;
    strTabela  : String;
    strCampoRel: String;
End;  

type
  TForeignKeyArray = Array of TForeignKey;

type
  TfrmTransfCodUnidade = class(TfrmPaiTransfCod)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtUniOri: TEditFocus;
    edtDesUniOri: TEditFocus;
    edtUniDes: TEditFocus;
    edtDesUniDes: TEditFocus;
    lsvArqAlterados: TListView;
    btnConfirmaDados: TBitBtnLocked;
    btnImpExcel: TBitBtnLocked;
    frxReport: TfrxReport;
    btnHlpImp: TBitBtnLocked;
    procedure edtUniOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtUniDesKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure btnImpExcelClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
  private
    { Private declarations }
    objUnidade: TTransfCodUni;
    ObjExcelTrans: TTransfImportAutomatico;
    cdsUnidade: TZClient;
    blnDivergencia: Boolean;

    procedure pCriaClientCliente;
    procedure pMostraDivergencia;
    procedure pCriaForm;
    procedure pChecarTabelas;

  public
    { Public declarations }

  protected

    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;

  end;

var
  frmTransfCodUnidade: TfrmTransfCodUnidade;

implementation

uses untfuncoesSimples, untConsultas, untGravando;

{$R *.dfm}

procedure TfrmTransfCodUnidade.edtUniOriKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqUnidade(Self, edtUniOri, edtDesUniOri, nil, nil, Key, arrSel) Then  
  Begin
    fvalidaCampos(edtUniOri,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

{***************************************}
{VALIDA CAMPOS                          }
{************************************RL*}
function TfrmTransfCodUnidade.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtUniOri) Then
  Begin

    If (fEmptyStr(edtUniOri.Text)) Then
    Begin
      ObjExcelTrans.pAddNotificacao('A unidade de origem deve ser preenchida !');
      Result := False;
    End
    Else If edtUniOri.Text = edtUniDes.Text Then
    Begin
      ObjExcelTrans.pAddNotificacao('A unidade origem deve diferente da unidade destino!');
      Result := False;
    End
    Else If (edtUniOri.Text = 'GL') Or
            (edtUniOri.Text = 'QT') Or
            (edtUniOri.Text = 'LA') Or
            (edtUniOri.Text = 'LT') Then
    Begin
      ObjExcelTrans.pAddNotificacao('As unidades reservadas - GL, QT, LA e LT - não podem ser transferidas!');
      Result := False;
    End
    Else
    Begin
      If fEmptyStr(edtUniOri.Text) Then
        edtDesUniOri.Text := 'TODOS'
      Else
        edtDesUniOri.Text := fRetNomUnidade(edtUniOri.Text);

      If fEmptyStr(edtDesUniOri.Text) And (Not fEmptyStr(edtUniOri.Text))  Then
      Begin
        ObjExcelTrans.pAddNotificacao('Código da unidade não encontrado.');
        edtUniOri.Clear;
        Result := False;
      End
      Else If (fEmptyStr(edtDesUniOri.Text)) Then
      Begin
        ObjExcelTrans.pAddNotificacao('Essa unidade não está cadastrada!');
        Result := False;
      End;

    End;

  End

  Else If (Sender = edtUniDes) Then
  Begin

    If (fEmptyStr(edtUniDes.Text)) Then
    Begin
      ObjExcelTrans.pAddNotificacao('A unidade de destino deve ser preenchida!');
      Result := False;
    End
    Else If edtUniOri.Text = edtUniDes.Text Then
    Begin
      ObjExcelTrans.pAddNotificacao('A unidade destino deve diferente da unidade origem!');
      Result := False;
    End
    Else
    Begin

      If fEmptyStr(edtUniDes.Text) Then
        edtDesUniDes.Text := 'TODOS'
      Else
        edtDesUniDes.Text := fRetNomUnidade(edtUniDes.Text);

      If fEmptyStr(edtDesUniDes.Text) And (Not fEmptyStr(edtUniDes.Text))  Then
      Begin
        ObjExcelTrans.pAddNotificacao('Código da unidade não encontrado.');
        edtUniDes.Clear;
        Result := False;
      End
      Else If (fEmptyStr(edtDesUniDes.Text)) Then
      Begin
        ObjExcelTrans.pAddNotificacao('Essa unidade não está cadastrada!');
        Result := False;
      End;
    End;

  End;


end;

procedure TfrmTransfCodUnidade.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfCodUnidade.btnImpExcelClick(Sender: TObject);
begin
  inherited;
  objExcelTrans.pAddEditInput(edtUniOri, 2, True);
  objExcelTrans.pAddEditInput(edtUniDes, 2, True);
  objExcelTrans.pEventoQueTransfere := btnConfirmaDados.OnClick;
  objExcelTrans.fExecutar;
end;

procedure TfrmTransfCodUnidade.edtUniDesKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqUnidade(Self, edtUniDes, edtDesUniDes, nil, nil, Key, arrSel) Then  
  Begin
    fvalidaCampos(edtUniOri,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmTransfCodUnidade.FormCreate(Sender: TObject);
begin
  inherited;

  blnDivergencia := True;

  objUnidade                 := TTransfCodUni.Create(Self);
  objUnidade.lsvArqAlterados := lsvArqAlterados;
  objExcelTrans := TTransfImportAutomatico.Create;

end;

procedure TfrmTransfCodUnidade.btnConfirmaDadosClick(Sender: TObject);
begin
  If (edtUniOri.Text = 'GL') Or
     (edtUniOri.Text = 'QT') Or
     (edtUniOri.Text = 'LA') Or
     (edtUniOri.Text = 'LT') Then 
  Begin
    ObjExcelTrans.pAddNotificacao('As unidades reservadas - GL, QT, LA e LT - não podem ser transferidas!');
    Exit;
  End;

  inherited;

  If (fVerificaCampos) Then
  Begin
     If (Sender <> objExcelTrans) And
       (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
       Exit;

    objUnidade.strCodUniOri := edtUniOri.Text;
    objUnidade.strCodUniDes := edtUniDes.Text;

    btnConfirmaDados.Enabled := False;
    If (objUnidade.fTransferirCodUnidade) Then
    Begin
      ObjExcelTrans.pAddNotificacao('Código de unidade transferido corretamente!');

      lsvArqAlterados.Clear;
      btnConfirmaDados.Enabled := True;

      edtUniOri.Clear;
      edtDesUniOri.Clear;
      edtUniDes.Clear;
      edtDesUniDes.Clear;

      pSetFocus(edtUniOri);
    End
    Else If ObjExcelTrans.blnExecutandoTransferencia Then
      ObjExcelTrans.pAddNotificacao('Não foi possível transferir. Consulte a Tabela LOGERR!');
  End;

end;

procedure TfrmTransfCodUnidade.pChecarTabelas;
Begin
  frmGravandoGenericProcedure.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';
  Application.ProcessMessages;

  objUnidade.pPreencheArray;
  pCriaClientCliente;
End;

procedure TfrmTransfCodUnidade.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtUniOri);
  Try
    TfrmGravando.fExecutarModal(pChecarTabelas, 'Validando Chave Estrangeira do Banco de Dados, Aguarde...', '');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodUnidade.FormShow]');
    End;
  End;

  Screen.Cursor := crDefault;
  pMostraDivergencia;

end;

procedure TfrmTransfCodUnidade.pCriaClientCliente;
begin

  If Not Assigned(cdsUnidade) Then
  Begin

    cdsUnidade := TZClient.Create(Self);

    With cdsUnidade, qryQuery, SQL Do
    Begin
      Add('SELECT DISTINCT');
      Add('  table_name AS TABELA,');
      Add('  column_name AS CAMPO ');
      Add('  FROM information_schema.KEY_COLUMN_USAGE');
      Add('  LEFT JOIN TCOARR ON TCA_ARQREL = table_name AND TCA_CAMREL = column_name');
      Add('  WHERE');
      Add('      referenced_table_name = "CADUNI"');
      Add('  AND referenced_column_name = "UNI_CODUNI"');
      Add('  AND TCA_ARQREL IS NULL');

      If Assigned(frmModulo) Then
        Add('  AND CONSTRAINT_SCHEMA = ' + QuotedStr(frmModulo.GetCurrentConnection.database));

      fAbreClient(True, 'pCriaClient');
    End;

  End;

end;

procedure TfrmTransfCodUnidade.pMostraDivergencia;
begin

  With cdsUnidade Do
  Begin

    If Not IsEmpty Then
    Begin
      pCriaForm;
    End
    Else
      blnDivergencia := False;

  End;

end;

procedure TfrmTransfCodUnidade.pCriaForm;
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

      With cdsUnidade Do
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
      pMensagensErro(E.Message, '[frmTransfCodUnidade.pCriaForm]');
    End;
  End;

  pFreeAndNil(Form);

end;

procedure TfrmTransfCodUnidade.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsUnidade);
  FreeAndNil(objExcelTrans);

end;

procedure TfrmTransfCodUnidade.FormPaint(Sender: TObject);
begin
  inherited;

  If blnDivergencia Then
    btnSair.Click;

end;

end.



