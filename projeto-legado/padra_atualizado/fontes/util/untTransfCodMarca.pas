{***********************}
{* qryConMar -> CADMAR *}
{********************PZ*}

unit untTransfCodMarca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, untPaiTransfCod, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, ComCtrls,
  AppEvnts, Uni, UniClientDataSet, strUtils, DB, BitBtnLockedIncrem, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxButtons, frxClass, frxExportCSVTestabilidade,
  untTransfImportAutomatico, untZClient, untModulo;

type
  TForeignKey = Record
    strCampoOri: String;
    strTabela  : String;
    strCampoRel: String;
End;

type
  TForeignKeyArray = Array of TForeignKey;  

Type
  TCamposMarca = record
    strNomArq: String;
    strDesCam: String;
    strCamCod: String;

  End;

type
  TfrmTransfCodMarca = class(TfrmPaiTransfCod)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtMarOri: TEditFocus;
    edtDesMarOri: TEditFocus;
    edtMarDes: TEditFocus;
    edtDesMarDes: TEditFocus;
    lsvArqAlterados: TListView;
    btnConfirmaDados: TBitBtnLocked;
    btnImpExcel: TBitBtnLocked;
    frxReport: TfrxReport;
    btnHlpImp: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtMarOriKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure edtMarDesKeyPress(Sender: TObject; var Key: Char);
    procedure btnImpExcelClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
  private
    { Private declarations }
    qryConMar: TUniQuery;
    arrCamposMarca: Array Of TCamposMarca;

    objExcelTrans: TTransfImportAutomatico;
    cdsMarca: TZClient;
    blnDivergencia: Boolean;

    procedure pCarregaMarca(edtCodigo, edtDescricao: TEditFocus);

    function fTransfereCodMarca: Boolean;
    function fAtualizaCodMarca(strNomArq, strCampo, strMarOri, strMarDes: String; intOpcao: Integer): Integer;

    procedure pCriaClientMarca;
    procedure pMostraDivergencia;
    procedure pCriaForm;
    procedure pPreencheArray;
    procedure pChecarTabelas;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untfuncoesSimples, untPesqAux, untConsultas, untGravando, untCfgRepositorio,
  untTypesSistema;


{$R *.dfm}

procedure TfrmTransfCodMarca.FormCreate(Sender: TObject);
begin
  inherited;
  blnDivergencia := True;
  qryConMar := fCriarQuery('SELECT * FROM CADMAR WHERE FALSE', Self);
  objExcelTrans := TTransfImportAutomatico.Create;
end;

procedure TfrmTransfCodMarca.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfCodMarca.btnImpExcelClick(Sender: TObject);
begin
  objExcelTrans.pAddEditInput(edtMarOri, 3, True);
  objExcelTrans.pAddEditInput(edtMarDes, 3, True);
  objExcelTrans.pEventoQueTransfere := btnConfirmaDados.OnClick;
  objExcelTrans.fExecutar;
end;

procedure TfrmTransfCodMarca.edtMarDesKeyPress(Sender: TObject; var Key: Char);
Var
  arrMarca : TConsultasArray;
begin
  inherited;
  If fPesqMarcas(Self, edtMarDes, edtDesMarDes, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtMarDes, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTransfCodMarca.edtMarOriKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrMarca : TConsultasArray;
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtMarOri, edtDesMarOri, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtMarOri, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmTransfCodMarca.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtMarOri) Then
  Begin

    If (fEmptyStr(edtMarOri.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('A Marca origem deve ser preenchida!');
      Result := False;
    End
    Else If edtMarOri.Text = edtMarDes.Text Then
    Begin
      ObjExcelTrans.pAddNotificacao('A marca origem deve ser diferente da marca destino!');
      Result := False;
    End
    Else
    Begin
      pCarregaMarca(edtMarOri, edtDesMarOri);
      If (fEmptyStr(edtDesMarOri.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Essa marca não está cadastrada!');
        Result := False;
      End
    End;

  End

  Else If (Sender = edtMarDes) Then
  Begin

    If (fEmptyStr(edtMarDes.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('A marca destino deve ser preenchida!');
      Result := False;
    End
    Else If edtMarOri.Text = edtMarDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('A marca destino deve ser diferente da marca origem!');
      Result := False;
    End
    Else
    Begin
      pCarregaMarca(edtMarDes, edtDesMarDes);
      If (fEmptyStr(edtDesMarDes.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Essa marca não está cadastrada!');
        Result := False;
      End;
    End;

  End;
  
end;

procedure TfrmTransfCodMarca.pCarregaMarca(edtCodigo, edtDescricao: TEditFocus);
begin
  pPesquisaCadMar(qryConMar, qryConMar, edtCodigo.Text);
  With qryConMar Do
  Begin
    edtDescricao.Text := FieldByName('MAR_DESMAR').AsString;
  End;
end;

function TfrmTransfCodMarca.fTransfereCodMarca: Boolean;
  Var
    intContador    : Integer;
    intContador2   : Integer;
    intTamMat      : Integer;
    intRegAlterados: Integer;
    strSQL         : String;
    qryGenMar      : TUniQuery;

begin
  Try

    qryGenMar := fCriaQuery(Self);

    intTamMat := Length(arrCamposMarca);
    intContador := 0;

    Try

      While intContador < intTamMat Do
      Begin

        lsvArqAlterados.Items.Add;
        lsvArqAlterados.Items[intContador].Caption := arrCamposMarca[intContador].strDesCam;
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

        For intContador2 := 1 To 2 Do
        Begin

          intRegAlterados := intRegAlterados + fAtualizaCodMarca(arrCamposMarca[intContador].strNomArq,
                                                                 arrCamposMarca[intContador].strCamCod,
                                                                 edtMarOri.Text,
                                                                 edtMarDes.Text,
                                                                 intContador2);

          Application.ProcessMessages;

        End;
        lsvArqAlterados.Items[intContador].Selected := True;
        lsvArqAlterados.Items[intContador].MakeVisible(False);
        lsvArqAlterados.Items[intContador].SubItems[0] := IntToStr(intRegAlterados);

        Application.ProcessMessages;
        Inc(intContador);

      End;

      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CADMAR WHERE MAR_CODMAR = :MARORI ';

      With qryGenMar Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('MARORI').AsString := edtMarOri.Text;
        Open;
        fVerificaIntegridade(Self.Name, 'CADMAR', qryGenMar, True);        
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADMAR WHERE MAR_CODMAR = :MARORI ';

      With qryGenMar Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('MARORI').AsString := edtMarOri.Text;
        ExecSQL;
        Close;
      End;

      pGravarTabelaLog(edtMarOri.Text, edtMarDes.Text, 'CADMAR');

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
          pMensagensErro(E.Message, '[fTransfereCodMarca]');
      End;
    End;

  Finally
    FreeAndNil(qryGenMar);
  End;

end;

{*****************************************}
{* OPÇÃO:                                *}
{* 1 -> ARQUIVO                          *}
{* 3 -> ARQUIVO DELETADO                 *}
{**************************************MV*}

function TfrmTransfCodMarca.fAtualizaCodMarca(strNomArq, strCampo, strMarOri, strMarDes: String;
  intOpcao: Integer): Integer;
  Var
    strSQL   : String;
    strCFG   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    Result := 0;

    qryGenTmp := fCriaQuery(Self);

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
    strSQL := strSQL + '  ' + strCampo + ' = :MARDES ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ' + strCampo + ' = :MARORI ';

    If (strNomArq = 'CFGSIS') Then
    Begin
      strCFG := TfrmCfgRepositorio.pRetCfgRelacionadaArquivo('CADMAR');
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
      ParamByName('MARDES').AsString := strMarDes;
      ParamByName('MARORI').AsString := strMarOri;
      ExecSQL;
      Result := RowsAffected;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

procedure TfrmTransfCodMarca.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos) Then
  Begin
     If (Sender <> objExcelTrans) And
       (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
       Exit;
    btnConfirmaDados.Enabled := False;
    If (fTransfereCodMarca) Then
    Begin
      objExcelTrans.pAddNotificacao('Código da Marca transferido corretamente!');

      lsvArqAlterados.Clear;
      btnConfirmaDados.Enabled := True;

      edtMarOri.Clear;
      edtDesMarOri.Clear;
      edtMarDes.Clear;
      edtDesMarDes.Clear;

      pSetFocus(edtMarOri);
    End;

  End;

end;

procedure TfrmTransfCodMarca.pChecarTabelas;
Begin
  frmGravandoGenericProcedure.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';
  Application.ProcessMessages;

  pPreencheArray;
  pCriaClientMarca;
End;

procedure TfrmTransfCodMarca.FormShow(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pChecarTabelas, 'Validando Chave Estrangeira do Banco de Dados, Aguarde...', '');
  pMostraDivergencia;

end;

procedure TfrmTransfCodMarca.pCriaClientMarca;
begin

  If Not Assigned(cdsMarca) Then
  Begin

    cdsMarca := TZClient.Create(Self);

    With cdsMarca, qryQuery, SQL Do
    Begin
      Add('SELECT DISTINCT');
      Add('  table_name AS TABELA,');
      Add('  column_name AS CAMPO ');
      Add('  FROM information_schema.KEY_COLUMN_USAGE');
      Add('  LEFT JOIN TCOARR ON TCA_ARQREL = table_name AND TCA_CAMREL = column_name');
      Add('  WHERE');
      Add('      referenced_table_name = "CADMAR"');
      Add('  AND referenced_column_name = "MAR_CODMAR"');
      Add('  AND TCA_ARQREL IS NULL');

      If Assigned(frmModulo) Then
        Add('  AND CONSTRAINT_SCHEMA = ' + QuotedStr(frmModulo.GetCurrentConnection.database));

      fAbreClient(True, 'pCriaClient');
    End;

  End;

end;

procedure TfrmTransfCodMarca.pMostraDivergencia;
begin

  With cdsMarca Do
  Begin

    If Not IsEmpty Then
    Begin
      pCriaForm;
    End
    Else
      blnDivergencia := False;

  End;

end;

procedure TfrmTransfCodMarca.pCriaForm;
  Var
    Form: TForm;
    Memo: TMemo;
begin
  Form := TForm.Create(Application);

  Try

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

      With cdsMarca Do
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

  Finally
    FreeAndNil(Form);
  End;

end;


procedure TfrmTransfCodMarca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(cdsMarca);
  FreeAndNil(objExcelTrans);

end;

procedure TfrmTransfCodMarca.FormPaint(Sender: TObject);
begin
  inherited;

  If blnDivergencia Then
    btnSair.Click;

end;

procedure TfrmTransfCodMarca.pPreencheArray;
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
      Add(' TCA_ARQUIV = "CADMAR" ');

      Open;

      intPosicao := 0;
      While Not Eof Do
      Begin

        SetLength(arrCamposMarca, succ(intPosicao));

        arrCamposMarca[intPosicao].strNomArq := FieldByName('TCA_ARQREL').AsString;
        arrCamposMarca[intPosicao].strDesCam := FieldByName('TCA_DESCRI').AsString;
        arrCamposMarca[intPosicao].strCamCod := FieldByName('TCA_CAMREL').AsString;

        Next;

        inc(intPosicao);

      End;

    End;

  Finally
    FreeAndNil(qryTcoArr);
  End;

end;

end.

