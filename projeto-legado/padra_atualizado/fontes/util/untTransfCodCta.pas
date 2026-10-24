{***********************}
{* qryConCta -> CADCTA *}
{********************JB*}

unit untTransfCodCta;

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
  TCamposCta = record
    strNomArq: String;
    strDesCam: String;
    strCamCod: String;

  End;

type
  TfrmTransfCodCta = class(TfrmPaiTransfCod)
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCtaOri: TEditFocus;
    edtDesCtaOri: TEditFocus;
    edtCtaDes: TEditFocus;
    edtDesCtaDes: TEditFocus;
    lsvArqAlterados: TListView;
    btnConfirmaDados: TBitBtnLocked;
    frxReport: TfrxReport;
    btnImpExcel: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure edtCtaOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtCtaDesKeyPress(Sender: TObject; var Key: Char);
    procedure btnImpExcelClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
  private
    { Private declarations }
    qryConCta: TUniQuery;
    arrCamposCta: Array Of TCamposCta;
    cdsCentroCusto: TZClient;
    objExcelTrans: TTransfImportAutomatico;
    blnDivergencia: Boolean;

    procedure pCarregaCta(edtCodigo, edtDescricao: TEditFocus);

    function fTransfereCodCta: Boolean;

    function fAtualizaCodCta(strNomArq, strCampo, strCtaOri, strCtaDes: String; intOpcao: Integer): Integer;

    procedure pCriaClientCentroCusto;
    procedure pMostraDivergencia;
    procedure pCriaForm;
    procedure pGravaLog(strTabela, strCtaOri, strCtaDes: String);
    procedure pPreencheArray;
    procedure pChecarTabelas;

  protected

    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;

  public
    { Public declarations }
  end;

var
  frmTransfCodCta: TfrmTransfCodCta;

implementation

uses untfuncoesSimples, untPesqAux, untConsultas, untCfgRepositorio, untGravando,
  untTypesSistema, untTCadChqRepository, untTIntegridadeTransferenciaCodigo;

{$R *.dfm}


function TfrmTransfCodCta.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCtaOri) Then
  Begin

    If (fEmptyStr(edtCtaOri.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O código origem deve ser preenchido!');
      Result := False;
    End
    Else if edtCtaOri.Text = edtCtaDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O plano de contas origem deve diferente do plano de contas destino!');
      Result := False;
    End
    Else
    Begin
      pCarregaCta(edtCtaOri, edtDesCtaOri);
      If (fEmptyStr(edtDesCtaOri.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse plano de contas não está cadastrado!');
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtCtaDes) Then
  Begin

    If (fEmptyStr(edtCtaDes.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O plano de contas destino deve ser preenchido!');
      Result := False;
    End
    Else if edtCtaOri.Text = edtCtaDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O plano de contas destino deve diferente do plano de contas origem!');
      Result := False;
    End
    Else
    Begin
      pCarregaCta(edtCtaDes, edtDesCtaDes);
      If (fEmptyStr(edtDesCtaDes.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse plano de contas não está cadastrado!');
        Result := False;
      End;
    End;

  End;


end;

procedure TfrmTransfCodCta.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfCodCta.btnImpExcelClick(Sender: TObject);
begin
  inherited;
  objExcelTrans.pAddEditInput(edtCtaOri, 7, True);
  objExcelTrans.pAddEditInput(edtCtaDes, 7, True);
  objExcelTrans.pEventoQueTransfere := btnConfirmaDados.OnClick;
  objExcelTrans.fExecutar;
end;

procedure TfrmTransfCodCta.edtCtaDesKeyPress(Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, edtCtaDes, edtDesCtaDes, Nil, Key, arrCentroCusto) Then
  begin
    if fValidaCampos(TEditFocus(Sender), True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmTransfCodCta.edtCtaOriKeyPress(Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, edtCtaOri, edtDesCtaOri, Nil, Key, arrCentroCusto) Then
  begin
    if fValidaCampos(TEditFocus(Sender), True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmTransfCodCta.fAtualizaCodCta(strNomArq, strCampo, strCtaOri, strCtaDes: String;
  intOpcao: Integer): Integer;
  Var
    strSQL   : String;
    strCFG   : String;
    qryGenCta: TUniQuery;

begin

  Try

    Result := 0;

    qryGenCta := fCriaQuery(Self);

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
    strSQL := strSQL + '  ' + strCampo + ' = :CTADES ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ' + strCampo + ' = :CTAORI ';

    If (strNomArq = 'CADFIS') Then
      strSQL := strSQL + ' AND FIS_TIP_FC = "C" ';

    If (strNomArq = 'CFGSIS') Then
    Begin
      strCFG := '';

      If Assigned(ProcRetCfgRelacionadaArquivo) then
        strCFG := ProcRetCfgRelacionadaArquivo('CADCTA');

      if not fEmptyStr(strCFG) then
        strSQL := strSQL + ' AND SIS_CODCFG IN (' + strCFG + ')'
      Else
      Begin
        Result := 0; 
        Exit;
      End;

    End;

    With qryGenCta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CTADES').AsString := strCtaDes;
      ParamByName('CTAORI').AsString := strCtaOri;
      ExecSQL;
      Result := RowsAffected;
      Close;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create('Tabela: ' + strNomArq + Chr(13) + E.Message);
  End;

  FreeAndNil(qryGenCta);

end;

function TfrmTransfCodCta.fTransfereCodCta: Boolean;
  Var
    intContador    : Integer;
    intContador2   : Integer;
    intRegAlterados: Integer;
    intTamMat: Integer;
    strSQL   : String;
    qryGenCta: TUniQuery;
    objInteg : TIntegridadeTransferenciaCodigo;
begin
  Try

    qryGenCta := fCriaQuery(Self);

    intTamMat := Length(arrCamposCta);
    intContador := 0;


    Try

      While intContador < intTamMat Do
      Begin

        lsvArqAlterados.Items.Add;
        lsvArqAlterados.Items[intContador].Caption := arrCamposCta[intContador].strDesCam;
        lsvArqAlterados.Items[intContador].SubItems.Add('Processando...');
        Inc(intContador);
        Application.ProcessMessages;

      End;

      intContador := 0;
      fStartTransaction;

      objInteg := TIntegridadeTransferenciaCodigo.Create('CADCTA', edtCtaOri.Text, edtCtaDes.Text);
      Try
        objInteg.pAjustaRegistrosDuplicados(nil);
      Finally
        FreeAndNil(objInteg);
      End;
      //deleta CADPME vinculado à CTARES
      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CADPME WHERE PME_CODRES IN (SELECT CRE_CODCRE FROM CTARES  WHERE CRE_CODCTA = :CTAORI)';

      With qryGenCta Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CTAORI').AsString := edtCtaOri.Text;
        Open;
        fVerificaIntegridade(Self.Name, 'CADPME', qryGenCta, True);
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADPME WHERE PME_CODRES IN (SELECT CRE_CODCRE FROM CTARES WHERE CRE_CODCTA = :CTAORI)';

      With qryGenCta Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CTAORI').AsString := edtCtaOri.Text;
        ExecSQL;
        Close;
      End;


      //deleta CTARES
      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CTARES WHERE CRE_CODCTA = :CTAORI ';

      With qryGenCta Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CTAORI').AsString := edtCtaOri.Text;
        Open;
        fVerificaIntegridade(Self.Name, 'CTARES', qryGenCta, True);
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CTARES WHERE CRE_CODCTA = :CTAORI ';

      With qryGenCta Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CTAORI').AsString := edtCtaOri.Text;
        ExecSQL;
        Close;
      End;


      //DELETA CTADET
      strSQL := '';
      strSQL := strSQL + ' DELETE ORI FROM CTADET ORI                                  ';
      strSQL := strSQL + ' INNER JOIN CTADET DES ON DES.CTA_EMPDET = ORI.CTA_EMPDET    ';
      strSQL := strSQL + ' WHERE ORI.CTA_CODCTA = :CTAORI AND DES.CTA_CODCTA = :CTADES ';

      With qryGenCta Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CTAORI').AsString := edtCtaOri.Text;
        ParamByName('CTADES').AsString := edtCtaDes.Text;
        ExecSQL;

        Close;
      End;

      //DELETA CTANCO
      strSQL := '';
      strSQL := strSQL + ' DELETE O.*';
      strSQL := strSQL + ' FROM CTANCO O';
      strSQL := strSQL + ' WHERE (SELECT QTD';
      strSQL := strSQL + '             FROM (SELECT COUNT(1) QTD';
      strSQL := strSQL + '                   FROM CTANCO D';
      strSQL := strSQL + '                   WHERE D.NCO_CODCTA = :CTADES)TMP) > 0';
      strSQL := strSQL + ' AND  O.NCO_CODCTA = :CTAORI';
      With qryGenCta Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CTAORI').AsString := edtCtaOri.Text;
        ParamByName('CTADES').AsString := edtCtaDes.Text;
        ExecSQL;

        Close;
      End;


      While intContador < intTamMat Do
      Begin

        If Pos(arrCamposCta[intContador].strNomArq, 'CADCHQ') > 0 Then
          pGravaLog(arrCamposCta[intContador].strNomArq, edtCtaOri.Text, edtCtaDes.Text);

        Application.ProcessMessages;
        intRegAlterados := 0;

        For intContador2 := 1 To 2 Do
        Begin

          intRegAlterados := intRegAlterados + fAtualizaCodCta(arrCamposCta[intContador].strNomArq,
                                                                   arrCamposCta[intContador].strCamCod,
                                                                   edtCtaOri.Text,
                                                                   edtCtaDes.Text,
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
      strSQL := strSQL + 'SELECT * FROM CADCTA WHERE CTA_CODCTA = :CTAORI ';

      With qryGenCta Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CTAORI').AsString := edtCtaOri.Text;
        Open;
        fVerificaIntegridade(Self.Name, 'CADCTA', qryGenCta, True);
        Close;
      End;


      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADCTA WHERE CTA_CODCTA = :CTAORI ';

      With qryGenCta Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CTAORI').AsString := edtCtaOri.Text;
        ExecSQL;
        Close;
      End;

      pGravarTabelaLog(edtCtaOri.Text, edtCtaDes.Text, 'CADCTA');

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
          pMensagensErro(E.Message, '[fTransfereCodCta]');
      End;
    End;

  Finally
    FreeAndNil(qryGenCta);
  End;

end;

procedure TfrmTransfCodCta.pCarregaCta(edtCodigo, edtDescricao: TEditFocus);
begin
  pPesquisaCadCta(qryConCta, qryConCta, edtCodigo.Text);
  With qryConCta Do
  Begin
    edtDescricao.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmTransfCodCta.FormCreate(Sender: TObject);
begin
  inherited;
  blnDivergencia := True;
  qryConCta      := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  objExcelTrans := TTransfImportAutomatico.Create;
end;

procedure TfrmTransfCodCta.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos) Then
  Begin
     If (Sender <> objExcelTrans) And
       (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
       Exit;

    btnConfirmaDados.Enabled := False;
    If (fTransfereCodCta) Then
    Begin
      objExcelTrans.pAddNotificacao('Código de plano de contas transferido corretamente!');

      lsvArqAlterados.Clear;
      btnConfirmaDados.Enabled := True;

      edtCtaOri.Clear;
      edtDesCtaOri.Clear;
      edtCtaDes.Clear;
      edtDesCtaDes.Clear;

      pSetFocus(edtCtaOri);
    End;

  End;

end;

procedure TfrmTransfCodCta.pChecarTabelas;
Begin
  frmGravandoGenericProcedure.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';
  Application.ProcessMessages;

  pPreencheArray;
  pCriaClientCentroCusto;
End;

procedure TfrmTransfCodCta.FormShow(Sender: TObject);
begin
  inherited;

  Try
    TfrmGravando.fExecutarModal(pChecarTabelas, 'Validando Chave Estrangeira do Banco de Dados, Aguarde...', '');

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodCta.FormShow]');
    End;
  End;

  Screen.Cursor := crDefault;
  pMostraDivergencia;

  pSetFocus(edtCtaOri);

end;

procedure TfrmTransfCodCta.pGravaLog(strTabela, strCtaOri, strCtaDes: String);
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    repCadChq  : TCadChqRepository;
begin

  strSQL := '';
  strSQL := strSQL + ' SELECT *               ';
  strSQL := strSQL + ' FROM ' + strTabela      ;
  strSQL := strSQL + ' WHERE                  ';
  strSQL := strSQL + '   CHQ_CODCLI = :CODCLI ';

  qryConsulta := fCriaQuery;

  With qryConsulta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCtaOri;
    Open;
    First;

    repCadChq := TCadChqRepository.Create;

    While Not Eof Do
    Begin
      repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                          FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                          'TRANSFERIU DA CONTA ' + strCtaOri + ' PARA ' + strCtaDes);
      Next;
    End;

    FreeAndNil(repCadChq);
  End;

  FreeAndNil(qryConsulta);
end;

procedure TfrmTransfCodCta.pCriaClientCentroCusto;
begin

  If Not Assigned(cdsCentroCusto) Then
  Begin

    cdsCentroCusto := TZClient.Create(Self);

    With cdsCentroCusto, qryQuery, SQL Do
    Begin
      Add('SELECT DISTINCT');
      Add('  table_name AS TABELA,');
      Add('  column_name AS CAMPO,');
      Add('  "S" AS EXISTE');
      Add('  FROM information_schema.KEY_COLUMN_USAGE');
      Add('  LEFT JOIN TCOARR ON TCA_ARQREL = table_name AND TCA_CAMREL = column_name');
      Add('  WHERE');
      Add('      referenced_table_name = "CADCTA"');
      Add('  AND referenced_column_name = "CTA_CODCTA"');
      Add('  AND TCA_ARQREL IS NULL');

      If Assigned(frmModulo) Then
        Add('  AND CONSTRAINT_SCHEMA = ' + QuotedStr(frmModulo.GetCurrentConnection.database));

      fAbreClient(True, 'pCriaClientProduto');
    End;

  End;

end;

procedure TfrmTransfCodCta.pMostraDivergencia;
begin

  With cdsCentroCusto Do
  Begin

    If Not IsEmpty Then
    Begin
      pCriaForm;
    End
    Else
      blnDivergencia := False;

  End;

end;

procedure TfrmTransfCodCta.pCriaForm;
  Var
    Form: TForm;
    Memo: TMemo;
begin

    pCriarFormularios(TForm, Form);

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

      With cdsCentroCusto Do
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
      pMensagensErro(E.Message, '[frmTransfCodCta.pCriaForm]');
    End;
  End;

  pFreeAndNil(Form);
  
end;

procedure TfrmTransfCodCta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(cdsCentroCusto);
  
end;

procedure TfrmTransfCodCta.FormPaint(Sender: TObject);
begin
  inherited;

  If blnDivergencia Then
    btnSair.Click;

end;

procedure TfrmTransfCodCta.pPreencheArray;
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
      Add(' TCA_ARQUIV = "CADCTA" ');

      Open;

      intPosicao := 0;
      While Not Eof Do
      Begin

        SetLength(arrCamposCta, succ(intPosicao));

        arrCamposCta[intPosicao].strNomArq := FieldByName('TCA_ARQREL').AsString;
        arrCamposCta[intPosicao].strDesCam := FieldByName('TCA_DESCRI').AsString;
        arrCamposCta[intPosicao].strCamCod := FieldByName('TCA_CAMREL').AsString;

        Next;

        inc(intPosicao);

      End;

    End;

  Finally
    FreeAndNil(qryTcoArr);
  End;

end;

end.


