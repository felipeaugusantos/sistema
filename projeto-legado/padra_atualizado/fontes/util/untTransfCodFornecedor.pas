{***********************}
{* qryConFor -> CADFOR *}
{********************JB*}

unit untTransfCodFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, untPaiTransfCod, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls, EditFocus,
  Uni, AppEvnts, UniClientDataSet, strUtils, DB, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons, untTransfImportAutomatico,
  untZClient, untModulo;

type
  TForeignKey = Record
    strCampoOri: String;
    strTabela  : String;
    strCampoRel: String;
End;  

type
  TForeignKeyArray = Array of TForeignKey;  

Type
  TCamposFornecedor = record
    strNomArq: String;
    strDesCam: String;
    strCamCod: String;
  End;

type
  TfrmTransfCodFornecedor = class(TfrmPaiTransfCod)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtForOri: TEditFocus;
    edtDesForOri: TEditFocus;
    edtForDes: TEditFocus;
    edtDesForDes: TEditFocus;
    lsvArqAlterados: TListView;
    btnConfirmaDados: TBitBtnLocked;
    btnImpExcel: TBitBtnLocked;
    frxReport: TfrxReport;
    btnHlpImp: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtForOriKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure edtForDesKeyPress(Sender: TObject; var Key: Char);
    procedure btnImpExcelClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
  private
    { Private declarations }
    qryConFor: TUniQuery;
    cdsFornecedor: TZClient;
    blnDivergencia: Boolean;

    objExcelTrans: TTransfImportAutomatico;
    arrCamposFornecedor: Array Of TCamposFornecedor;

    procedure pCarregaFornecedor(edtCod, edtNom: TEditFocus);

    function fTransfereCodFornecedor: Boolean;
    function fAtualizaCodFornecedor(strNomArq, strCampo, strForOri, strForDes: String; intOpcao: Integer): Integer;

    procedure pCriaClientFornecedor;
    procedure pMostraDivergencia;
    procedure pCriaForm;
    procedure pPreencheArray;
    procedure pChecarTabelas;
    Procedure pAtualizaCADINT;
    procedure pValidaCodCtaOriDes;
    function fPossuiCadPagConflitante(AForOri, AForDes: String): Boolean;

  public
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  end;

var
  frmTransfCodFornecedor: TfrmTransfCodFornecedor;

implementation


uses  untfuncoesSimples,
      untConsultas,
      untCfgRepositorio, untGravando, untTypesSistema,
      untTIntegridadeTransferenciaCodigo;

{$R *.dfm}

procedure TfrmTransfCodFornecedor.FormCreate(Sender: TObject);
begin
  inherited;
  blnDivergencia := True;
  objExcelTrans := TTransfImportAutomatico.Create;

end;

{***************************************}
{PESQUISAR FORNECEDOR DE ORIGEM         }
{************************************RL*}
procedure TfrmTransfCodFornecedor.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfCodFornecedor.btnImpExcelClick(Sender: TObject);
begin
  inherited;
  objExcelTrans.pAddEditInput(edtForOri, 8, True);
  objExcelTrans.pAddEditInput(edtForDes, 8, True);
  objExcelTrans.pEventoQueTransfere := btnConfirmaDados.OnClick;
  objExcelTrans.fExecutar;
end;

procedure TfrmTransfCodFornecedor.edtForDesKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtForDes, edtDesForDes, qryConFor, Key, arrSel) Then
  Begin
    If (fValidaCampos(TEditFocus(Sender), True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmTransfCodFornecedor.edtForOriKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtForOri, edtDesForOri, qryConFor, Key, arrSel) Then
  Begin
    If (fValidaCampos(TEditFocus(Sender), True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

{***************************************}
{PESQUISAR FORNECEDOR DE DESTINO        }
{************************************RL*}
procedure TfrmTransfCodFornecedor.pCarregaFornecedor(edtCod, edtNom: TEditFocus);
begin
  edtNom.Text := fRetNomFornecedor(edtCod.Text);
end;

{***************************************}
{VALIDA CAMPOS                          }
{************************************RL*}
function TfrmTransfCodFornecedor.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtForOri) Then
  Begin

    If (fEmptyStr(edtForOri.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O fornecedor de origem deve ser preenchido!');
      Result := False;
    End
    Else If edtForOri.Text = edtForDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O fornecedor origem deve diferente do fornecedor destino!');
      Result := False;
    End
    Else
    Begin
      pCarregaFornecedor(edtForOri, edtDesForOri);
      If (fEmptyStr(edtDesForOri.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse fornecedor não está cadastrado!');
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtForDes) Then
  Begin

    If (fEmptyStr(edtForDes.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O fornecedor de destino deve ser preenchido!');
      Result := False;
    End
    Else If edtForOri.Text = edtForDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O fornecedor destino deve diferente do fornecedor origem!');
      Result := False;
    End
    Else
    Begin
      pCarregaFornecedor(edtForDes, edtDesForDes);
      If (fEmptyStr(edtDesForDes.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse fornecedor não está cadastrado!');
        Result := False;
      End;
    End;

  End;


end;

procedure TfrmTransfCodFornecedor.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
     If (Sender <> objExcelTrans) And
       (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
       Exit;

    btnConfirmaDados.Enabled := False;
    If (fTransfereCodFornecedor) Then
    Begin
      objExcelTrans.pAddNotificacao('Código de fornecedor transferido corretamente!');

      lsvArqAlterados.Clear;
      btnConfirmaDados.Enabled := True;

      edtForOri.Clear;
      edtDesForOri.Clear;
      edtForDes.Clear;
      edtDesForDes.Clear;

      pSetFocus(edtForOri);
    End
    Else
      btnConfirmaDados.Enabled := True;

  End;

end;

{***************************************}
{TRANFERIR FORNECEDOR                   }
{************************************RL*}
Procedure TfrmTransfCodFornecedor.pAtualizaCADINT;
  Var
    qryCadInt: TUniQuery;
Begin
  qryCadInt := fCriaQuery;

  With qryCadInt, SQL Do
  Begin
    Add('UPDATE CADINT');
    Add('SET INT_VALCOM = :FORDES');
    Add('WHERE INT_NOMFRM = "FRMDIGGIROESTOQUE" AND INT_NOMCOM = "edtCodFor" AND INT_VALCOM = :FORORI');

    ParamByName('FORORI').AsString := edtForOri.Text;
    ParamByName('FORDES').AsString := edtForDes.Text;

    ExecSQL;
  End;

  FreeAndNil(qryCadInt);
End;

function TfrmTransfCodFornecedor.fPossuiCadPagConflitante(AForOri, AForDes: String): Boolean;
Var
  LQryPag: TUniQuery;
  LTxtMsg: String;
  LQtdLin: Integer;
begin
  LQryPag := fCriaQuery;
  LQtdLin := 5;
  Try
    LQryPag.SQL.Add('SELECT CTP_NUMDUP, CTP_PARCEL, CTP_CODEMP, CTP_SERIE_, CTP_SEQBAI ');
    LQryPag.SQL.Add('FROM CADPAG ');
    LQryPag.SQL.Add('WHERE CTP_CODFOR IN (:FORORI, :FORDES) ');
    LQryPag.SQL.Add('GROUP BY CTP_NUMDUP, CTP_PARCEL, CTP_CODEMP, CTP_SERIE_, CTP_SEQBAI ');
    LQryPag.SQL.Add('HAVING COUNT(1) > 1 ');

    LQryPag.ParamByName('FORORI').AsString := AForOri;
    LQryPag.ParamByName('FORDES').AsString := AForDes;

    LQryPag.Open;

    Result := Not LQryPag.IsEmpty;

    If (Result) Then
    Begin
      LTxtMsg := '';
      LTxtMsg := LTxtMsg + 'Processo Abortado! Não é possível realizar a transferência de ';
      LTxtMsg := LTxtMsg + 'código de fornecedor, pois existem documentos iguais entre os fornecedores: ' + #13#10;
      LTxtMsg := LTxtMsg + #13#10;

      LQryPag.First;
      While Not LQryPag.Eof Do
      Begin
        LTxtMsg := LTxtMsg + 'Documento: ' +
                              LQryPag.FieldByName('CTP_NUMDUP').AsString + '-' +
                              LQryPag.FieldByName('CTP_PARCEL').AsString + '-' +
                              LQryPag.FieldByName('CTP_SERIE_').AsString + ' Emp: ' +
                              LQryPag.FieldByName('CTP_CODEMP').AsString + ' - ' +
                              'Fornecedor: ' + AForOri + #13#10;

        LTxtMsg := LTxtMsg + 'Documento: ' +
                              LQryPag.FieldByName('CTP_NUMDUP').AsString + '-' +
                              LQryPag.FieldByName('CTP_PARCEL').AsString + '-' +
                              LQryPag.FieldByName('CTP_SERIE_').AsString + ' Emp: ' +
                              LQryPag.FieldByName('CTP_CODEMP').AsString + ' - ' +
                              'Fornecedor: ' + AForDes + #13#10;
        LQtdLin := LQtdLin + 2;
        LQryPag.Next;
      End;

      LTxtMsg := LTxtMsg + #13#10;
      LTxtMsg := LTxtMsg + 'Ajustar os documentos e realizar o processo novamente.';

      fMensagem('Aviso', LTxtMsg, ['&OK'], 1, False, 1, 0, False, 0, False, False, False, 0, 0, LQtdLin);
    End;
  Finally
    FreeAndNil(LQryPag);
  End;
end;

function TfrmTransfCodFornecedor.fTransfereCodFornecedor: Boolean;
  Var
    intContador    : Integer;
    intContador2   : Integer;
    intTamMat      : Integer;
    intRegAlterados: Integer;
    strSQL         : String;
    qryGenFor      : TUniQuery;
    objInteg       : TIntegridadeTransferenciaCodigo;
begin
  If (fPossuiCadPagConflitante(edtForOri.Text, edtForDes.Text)) Then
  Begin
    Result := False;
    Exit;
  End;

  Try

    qryGenFor := fCriaQuery(Self);

    intTamMat   := Length(arrCamposFornecedor);
    intContador := 0;

    Try

      While intContador < intTamMat Do
      Begin

        lsvArqAlterados.Items.Add;
        lsvArqAlterados.Items[intContador].Caption := arrCamposFornecedor[intContador].strDesCam;
        lsvArqAlterados.Items[intContador].SubItems.Add('Processando...');
        Inc(intContador);
        Application.ProcessMessages;

      End;

      intContador := 0;
      fStartTransaction;

      pValidaCodCtaOriDes;
      objInteg := TIntegridadeTransferenciaCodigo.Create('CADFOR', edtForOri.Text, edtForDes.Text);
      Try
        objInteg.pAjustaRegistrosDuplicados(nil);
      Finally
        FreeAndNil(objInteg);
      End;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM FORNEO WHERE NEO_CODFOR = :FORORI ';

      With qryGenFor Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('FORORI').AsString := edtForOri.Text;
        ExecSQL;
        Close;
      End;

      While intContador < intTamMat Do
      Begin

        Application.ProcessMessages;
        intRegAlterados := 0;

        {***************************************}
        {ATUALIZAR FORNECEDOR DE ORIGEM         }
        {************************************RL*}
        For intContador2 := 1 To 2 Do
        Begin

          intRegAlterados := intRegAlterados + fAtualizaCodFornecedor(arrCamposFornecedor[intContador].strNomArq,
                                                                      arrCamposFornecedor[intContador].strCamCod,
                                                                      edtForOri.Text,
                                                                      edtForDes.Text,
                                                                      intContador2);

          Application.ProcessMessages;

        End;
        lsvArqAlterados.Items[intContador].Selected := True;
        lsvArqAlterados.Items[intContador].MakeVisible(False);
        lsvArqAlterados.Items[intContador].SubItems[0] := IntToStr(intRegAlterados);

        Application.ProcessMessages;
        Inc(intContador);

      End;

      {***************************************}
      {EXCLUIR FORNECEDOR DE ORIGEM           }
      {************************************RL*}
      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CADFOR WHERE FOR_CODFOR = :FORORI ';

      With qryGenFor Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('FORORI').AsString := edtForOri.Text;
        Open;
        fVerificaIntegridade(Self.Name, 'CADFOR', qryGenFor, True);
        Close;
      End;


      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADFOR WHERE FOR_CODFOR = :FORORI; ';

      strSQL := strSQL + 'UPDATE ITEGER ';
      strSQL := strSQL + '   SET ITE_NOTULT = CONCAT(LEFT(ITE_NOTULT, LENGTH(ITE_NOTULT) - 8), :FORDES) ';
      strSQL := strSQL + ' WHERE RIGHT(ITE_NOTULT, 8) = :FORORI; ';

      With qryGenFor Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('FORORI').AsString := edtForOri.Text;
        ParamByName('FORDES').AsString := edtForDes.Text;
        ExecSQL;
        Close;
      End;

      pAtualizaCADINT;

      pGravarTabelaLog(edtForOri.Text, edtForDes.Text, 'CADFOR');

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
          pMensagensErro(E.Message, '[fTransfereCodFornecedor]');
      End;
    End;


  Finally
    FreeAndNil(qryGenFor);
  End;

end;

{*****************************************}
{ATUALIZAR FORNECEDOR DE DESTINO          }
{**************************************RL*}
function TfrmTransfCodFornecedor.fAtualizaCodFornecedor(strNomArq, strCampo, strForOri, strForDes: String;
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
    {**************************************RL*}

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
    strSQL := strSQL + '  ' + strCampo + ' = :FORDES ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ' + strCampo + ' = :FORORI ';

    If (strNomArq = 'LOGNFE') Then
      strSQL := strSQL + ' AND NFE_TIP_FC = "F" '
    Else
    If (strNomArq = 'CADFIS') Then
      strSQL := strSQL + ' AND FIS_TIP_FC = "F" '
    Else
    If (strNomArq = 'ADEDET') Then
      strSQL := strSQL + ' AND DET_TIP_FC = "F" '
    Else
    If (strNomArq = 'DOCDTA') Then
      strSQL := strSQL + ' AND DOC_TIP_FC = "F" '
    Else
    If (strNomArq = 'CFGSIS') Then
    Begin
      strCFG := '';

      If Assigned(ProcRetCfgRelacionadaArquivo) then
        strCFG := ProcRetCfgRelacionadaArquivo('CADFOR');

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
      ParamByName('FORDES').AsString := strForDes;
      ParamByName('FORORI').AsString := strForOri;
      ExecSQL;
      Result := RowsAffected;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;
procedure TfrmTransfCodFornecedor.pChecarTabelas;
Begin
  frmGravandoGenericProcedure.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';
  Application.ProcessMessages;

  pPreencheArray;
  pCriaClientFornecedor;
End;

procedure TfrmTransfCodFornecedor.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtForOri);
  Try
    TfrmGravando.fExecutarModal(pChecarTabelas, 'Validando Chave Estrangeira do Banco de Dados, Aguarde...', '');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodFornecedor.FormShow]');
    End;
  End;

  Screen.Cursor := crDefault;
  pMostraDivergencia;

end;

procedure TfrmTransfCodFornecedor.pCriaClientFornecedor;
begin

  If Not Assigned(cdsFornecedor) Then
  Begin

    cdsFornecedor := TZClient.Create(Self);

    With cdsFornecedor, qryQuery, SQL Do
    Begin
      Add('SELECT DISTINCT');
      Add('  table_name AS TABELA,');
      Add('  column_name AS CAMPO ');
      Add('  FROM information_schema.KEY_COLUMN_USAGE');
      Add('  LEFT JOIN TCOARR ON TCA_ARQREL = table_name AND TCA_CAMREL = column_name');
      Add('  WHERE');
      Add('      referenced_table_name = "CADFOR"');
      Add('  AND referenced_column_name = "FOR_CODFOR"');
      Add('  AND TCA_ARQREL IS NULL');

      If Assigned(frmModulo) Then
        Add('  AND CONSTRAINT_SCHEMA = ' + QuotedStr(frmModulo.GetCurrentConnection.database));

      fAbreClient(True, 'pCriaClient');
    End;

  End;

end;

procedure TfrmTransfCodFornecedor.pMostraDivergencia;
begin

  With cdsFornecedor Do
  Begin

    If Not IsEmpty Then
    Begin
      pCriaForm;
    End
    Else
      blnDivergencia := False;

  End;

end;

procedure TfrmTransfCodFornecedor.pCriaForm;
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

      With cdsFornecedor Do
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
      pMensagensErro(E.Message, '[frmTransfCodFornecedor.pCriaForm]');
    End;
  End;

  pFreeAndNil(Form);

end;


procedure TfrmTransfCodFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(cdsFornecedor);
  FreeAndNil(objExcelTrans);

end;

procedure TfrmTransfCodFornecedor.FormPaint(Sender: TObject);
begin
  inherited;

  If blnDivergencia Then
    btnSair.Click;

end;

procedure TfrmTransfCodFornecedor.pPreencheArray;
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
      Add(' TCA_ARQUIV = "CADFOR" ');

      Open;

      intPosicao := 0;
      While Not Eof Do
      Begin

        SetLength(arrCamposFornecedor, succ(intPosicao));

        arrCamposFornecedor[intPosicao].strNomArq := FieldByName('TCA_ARQREL').AsString;
        arrCamposFornecedor[intPosicao].strDesCam := FieldByName('TCA_DESCRI').AsString;
        arrCamposFornecedor[intPosicao].strCamCod := FieldByName('TCA_CAMREL').AsString;

        Next;

        inc(intPosicao);

      End;

    End;

  Finally
    FreeAndNil(qryTcoArr);
  End;

end;

procedure TfrmTransfCodFornecedor.pValidaCodCtaOriDes;
  Var
    qryOri : TUniQuery;
  procedure pDeleteCodCta(AUTOINCREM: String);
  Var
      qryGen : TUniQuery;
  begin
    Try
      qryGen := fCriaQuery();
      With qryGen, SQL Do
      Begin
        Add(' DELETE FROM CTAFOR              ');
        Add(' WHERE AUTOINCREM = :AUTOINCREM  ');
        ParamByName('AUTOINCREM').AsString := AUTOINCREM;
        ExecSQL;
      End;

    Finally
      FreeAndNil(qryGen);
    End;
  End;
begin
  Try
    qryOri := fCriaQuery();
    With qryOri, SQL Do
    Begin
      Add(' SELECT AUTOINCREM FROM CTAFOR                       ');
      Add(' WHERE CTF_CODFOR  =  :FORORI                        ');
      Add(' AND  ( SELECT  COUNT(1) FROM CTAFOR DES             ');
      Add('        WHERE DES.CTF_CODFOR = :FORDES               ');
      Add('        AND DES.CTF_CODCTA =  CTAFOR.CTF_CODCTA      ');
      Add('        AND DES.CTF_CODEMP =  CTAFOR.CTF_CODEMP) > 0 ');
      ParamByName('FORORI').AsString := edtForOri.Text;
      ParamByName('FORDES').AsString := edtForDes.Text;
      ExecSQL;

      If IsEmpty then
        Exit;

      First;
      While Not Eof do
      Begin
        pDeleteCodCta(FieldByName('AUTOINCREM').AsString);
        Next;
      End;

    End;

  Finally
    FreeAndNil(qryOri);
  End;
end;

end.

