unit untTransfCodProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, untPaiTransfCod, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, EditFocus, Uni, UniClientDataSet, StrUtils, DB, DateUtils,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxButtons, untTransfImportAutomatico, untZClient, untSaldoPedidoCompra, cxProgressBar;

Type
  TCamposProduto = record
    strNomArq: String;
    strDesCam: String;
    strCamCod: String;
  End;

type
  TForeignKey = Record
    strCampoOri: String;
    strTabela  : String;
    strCampoRel: String;
  End;

type
  TForeignKeyArray = Array of TForeignKey;

type
  TfrmTransfCodProduto = class(TfrmPaiTransfCod)
    lsvArqAlterados: TListView;
    pnlCabecalho: TPanel;
    pnlProgresso: TPanel;
    Label10: TLabel;
    pgbProgresso: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    edtCodPrO: TEditFocus;
    edtDesPrO: TEditFocus;
    edtDesPrD: TEditFocus;
    edtCodPrD: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnImpExcel: TBitBtnLocked;
    frxReport: TfrxReport;
    btnHlpImp: TBitBtnLocked;
    pnlOpcTransfPreco: TPanel;
    chkOpcTransfPreco: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure edtCodPrOKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPrDKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lsvArqAlteradosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnImpExcelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    strTabTin: String;
    qryConPro: TUniQuery;
    blnDivergencia: Boolean;
    cdsProduto: TZClient;
    objExcelTrans: TTransfImportAutomatico;
    arrCamposProduto: Array Of TCamposProduto;
    procedure pCriaClientProduto;
    procedure pCarregaTabelasTinta;
    procedure pCarregaProduto(edtCodigo, edtDescricao: TEditFocus);
    procedure pExisteTabela;
    procedure pComparaLista;
    procedure pMostraDivergencia;
    procedure pCriaForm;
    procedure pLimparCabecalho;
    function fAlteraItens: Boolean;
    function fTransferePrecosParaDestino: Boolean;
    function fAtualizaItem(strNomArq, strCamCod, strProOri, strProDes: String;
      intOpcao: Integer): Integer;
    procedure pRecalculaGiro;
    function fRetMovimentoDia(strCodIte, strCodEmp: String): Double;
    procedure pAtualizaInventario(strTabela: String);
    function fTransferePrecosParaDestinoAux(pgbProgresso: TcxProgressBar): Boolean;

    procedure pPreencheArray;
    procedure pChecarTabelas;
    Procedure pDesmarcaIteBarPrincipal(strCodPr0: String);
    Procedure pTratarDigEle(strProOri, strProDes: String);
    Procedure pTratarPROBRI_ITE(strProOri: String);

    Procedure pApagaPreIteDuplicado(strIteOld, strIteNew: String);
    Procedure pApagaITEDTEDuplicado(strCodPrO: string);
    Procedure pApagaCOMETIDuplicado(strIteOld: String);
    Procedure pApagaTRAYITELIBDuplicado(strIteOld: String);
    Procedure pApagaNUVM_ITELIBDuplicado(strIteOld: String);

    Procedure pCriaLotesAjustaSaldo;

    Procedure pApagaPCDDET_RES(strProOri: String);
    procedure pAcertaAgeiteDuplicada;
    procedure pAcertaITECODPAG;

    function fValidaItemEstrutura(blnValidaSubItem:Boolean = False): Boolean;


  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmTransfCodProduto: TfrmTransfCodProduto;

implementation

uses
 untFuncoesSimples, untPesqAux,
 untMovSba, untFecGiroEstoque, untConsultas,
 untCfgRepositorio, untGravando, untTypesSistema,
 untModulo, untTIntegridadeTransferenciaCodigo;

{$R *.dfm}

procedure TfrmTransfCodProduto.pExisteTabela;
begin
  pCriaClientProduto;
  pComparaLista;
end;

procedure TfrmTransfCodProduto.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfCodProduto.btnImpExcelClick(Sender: TObject);
begin
  inherited;
  objExcelTrans.pAddEditInput(edtCodPrO, fTamCodIte, True);
  objExcelTrans.pAddEditInput(edtCodPrD, fTamCodIte, True);
  objExcelTrans.pEventoQueTransfere := btnConfirma.OnClick;
  objExcelTrans.fExecutar;
end;


function TfrmTransfCodProduto.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCodPrO) Then
  Begin

    If (fEmptyStr(edtCodPrO.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O Produto origem deve ser preenchido!');
      Result := False;
    End
    Else If edtCodPrO.Text = edtCodPrD.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O Produto origem deve diferente do Produto destino!');
      Result := False;
    End
    Else If fExisteVinculoIntegracoes(edtCodPrO.Text, True) Then
    Begin
      Result := False;
    End
    Else
    Begin
      pCarregaProduto(edtCodPrO, edtDesPrO);
      If (fEmptyStr(edtDesPrO.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse Produto ' + edtCodPrO.Text + ' não está cadastrado!');
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtCodPrD) Then
  Begin

    If (fEmptyStr(edtCodPrD.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O Produto destino deve ser preenchido!');
      Result := False;
    End
    Else If edtCodPrO.Text = edtCodPrD.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O Produto destino deve diferente do Produto origem!');
      Result := False;
    End
    Else
    Begin
      pCarregaProduto(edtCodPrD, edtDesPrD);
      If (fEmptyStr(edtDesPrD.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse Produto ' + edtDesPrD.Text + ' não está cadastrado!');
        Result := False;
      End
      Else If fValidaItemEstrutura Then
      Begin
        objExcelTrans.pAddNotificacao('Produto de Origem: '+edtCodPrO.Text+' é produto estrutura do produto Destino: '+edtCodPrD.Text+ ' ');
        Result := False;
      End
      Else If fValidaItemEstrutura(True) Then
      Begin
        objExcelTrans.pAddNotificacao('Produto de Origem: '+edtCodPrO.Text+' é subitem da estrutura do produto Destino: '+edtCodPrD.Text+ ' ');
        Result := False;
      End;
    End;

  End;

end;

function TfrmTransfCodProduto.fValidaItemEstrutura(blnValidaSubItem:Boolean = False): Boolean;
begin
  Result := False;

  {Origem}
  pCarregaProduto(edtCodPrO, edtDesPrO);
  If (fEmptyStr(edtDesPrO.Text)) Then
    Exit;
  {Destino}
  pCarregaProduto(edtCodPrD, edtDesPrD);
  If (fEmptyStr(edtDesPrD.Text)) Then
    Exit;

  If blnValidaSubItem Then
  Begin
    If fSubItemDaEstrutura(edtCodPrO.Text,edtCodPrD.Text) Then
      Result := True;
  End
  Else
  Begin
    If fSubItemDaEstrutura(edtCodPrD.Text, edtCodPrO.Text) Then
      Result := True;
  End;
end;

procedure TfrmTransfCodProduto.pCarregaProduto(edtCodigo, edtDescricao: TEditFocus);
begin
  pPesquisaCadIte(qryConPro, qryConPro, edtCodigo.Text, '', False, False, False, False);
  With qryConPro Do
  Begin
    edtDescricao.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;

procedure TfrmTransfCodProduto.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodPrO);
  pSetaCodIte(edtCodPrD);
  blnDivergencia := True;
  chkOpcTransfPreco.Checked := False;
  pnlOpcTransfPreco.Visible := (fCfgSis('OPCTPR') <> 'N');
  chkOpcTransfPreco.Checked := (fCfgSis('OPCTPR') = 'M');
  qryConPro := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  pSetaQueryCadIte(qryConPro);
  objExcelTrans := TTransfImportAutomatico.Create;
  pSetaCodIte(edtCodPrO);
  pSetaCodIte(edtCodPrD);
end;

procedure TfrmTransfCodProduto.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objExcelTrans);
end;

procedure TfrmTransfCodProduto.edtCodPrOKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodPrO, edtDesPrO, qryConPro, Key, arrSel, True, nil, 'Consulta de Itens', '1')  Then
  Begin
    If (fValidaCampos(edtCodPrO, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmTransfCodProduto.edtCodPrDKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodPrD, edtDesPrD, qryConPro, Key, arrSel, True, nil, 'Cosulta de Itens', '1') Then
  Begin
    If (fValidaCampos(edtCodPrD, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmTransfCodProduto.btnConfirmaClick(Sender: TObject);
begin
  If (fVerificaCampos) Then
  Begin
     If (Sender <> objExcelTrans) And
       (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
       Exit;

    pSetFocus(Self);

    Screen.Cursor := crHourGlass;

    btnConfirma.Enabled := False;
    btnSair.Enabled := False;

    edtCodPrD.Enabled := False;

    Application.ProcessMessages;

    Try
      fStartTransaction;

      If fAlteraItens Then
      Begin
        fCommit;
        pLimparCabecalho;

        If (Sender <> objExcelTrans) Then
          fMensagem('','Transferência realizada com sucesso!', ['&O k']);
      End
      Else
        fRollBack;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        If objExcelTrans.blnExecutandoTransferencia Then
          objExcelTrans.pAddNotificacao(E.Message)
        Else
          pMensagensErro(E.Message, '[TfrmTransfCodProduto.btnConfirmaClick]');
      End;
    End;

    pnlProgresso.Visible := False;

    pSetFocus(edtCodPrO);

    edtCodPrD.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Screen.Cursor := crDefault;
  End;

end;

procedure TfrmTransfCodProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) Then
    btnConfirma.Click;

end;

procedure TfrmTransfCodProduto.FormPaint(Sender: TObject);
begin
  inherited;

  If blnDivergencia Then
    btnSair.Click;

end;

procedure TfrmTransfCodProduto.pLimparCabecalho;
  Var
    intContador: Integer;
begin

  For intContador := 0 To pnlCabecalho.ControlCount -1 Do
  Begin
    If (pnlCabecalho.Controls[intContador] Is TEdit) Then
      (pnlCabecalho.Controls[intContador] As TEdit).Clear;
  End;

end;

procedure TfrmTransfCodProduto.lsvArqAlteradosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
    btnSair.Click;
end;


procedure TfrmTransfCodProduto.pChecarTabelas;
Begin
  frmGravandoGenericProcedure.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';

  Application.ProcessMessages;

  pPreencheArray;
  pCarregaTabelasTinta;
  pExisteTabela;
End;

procedure TfrmTransfCodProduto.FormShow(Sender: TObject);
begin
  inherited;
  Try
    TfrmGravando.fExecutarModal(pChecarTabelas, 'Validando Chave Estrangeira do Banco de Dados, Aguarde...', '');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodProduto.FormShow]');
    End;
  End;

  Screen.Cursor := crDefault;
  pMostraDivergencia;

  pSetFocus(edtCodPrO);
end;

procedure TfrmTransfCodProduto.pCriaClientProduto;
begin

  If Not Assigned(cdsProduto) Then
  Begin
    cdsProduto := TZClient.Create(Self);

    With cdsProduto, qryQuery, SQL Do
    Begin
      Add('SELECT DISTINCT');
      Add('  table_name AS TABELA,');
      Add('  column_name AS CAMPO,');
      Add('  "S" AS EXISTE');
      Add('  FROM information_schema.KEY_COLUMN_USAGE');
      Add('  LEFT JOIN TCOARR ON TCA_ARQREL = table_name AND TCA_CAMREL = column_name');
      Add('  WHERE True');

      If Assigned(frmModulo) Then
        Add('  AND table_schema = '+QuotedStr(frmModulo.GetCurrentConnection.database));

      If Assigned(frmModulo) Then
        Add('  AND CONSTRAINT_SCHEMA = ' + QuotedStr(frmModulo.GetCurrentConnection.database));

      Add('  AND referenced_table_name = "CADITE"');
      Add('  AND referenced_column_name = "ITE_CODITE"');
      Add('  AND TCA_ARQREL IS NULL');
      Add('  AND NOT LOCATE(table_name, "CADITE_ITEGER_DESSIT_GIRITE")');

      fAbreClient(True, 'pCriaClientProduto');
    End;
  End;

end;

procedure TfrmTransfCodProduto.pComparaLista;
  Var
    intContador: Integer;
    blnExiste: Boolean;
    blnUsaTmq : Boolean;
begin

  blnUsaTmq := fCfgSis('USATMQ', varBoolean);
  With cdsProduto Do
  Begin

    First;

    While Not Eof Do
    Begin

      blnExiste := False;

      If (Trim(FieldByName('TABELA').AsString) <> 'CADITE') And
         (Trim(FieldByName('TABELA').AsString) <> 'ITEGER') And
         (Trim(FieldByName('TABELA').AsString) <> 'DESSIT') And
         (Trim(FieldByName('TABELA').AsString) <> 'ITEETI') And
         (Trim(FieldByName('TABELA').AsString) <> 'GIRITE') Then
      Begin

        If (not blnUsaTmq) And (Pos(FieldByName('TABELA').AsString, strTabTin) > 0) Then
          blnExiste := True
        Else
        Begin
          For intContador := 0 To Length(arrCamposProduto) - 1 Do
          Begin
            If (Trim(FieldByName('TABELA').AsString) = arrCamposProduto[intContador].strNomArq) And
               (Trim(FieldByName('CAMPO').AsString)  = arrCamposProduto[intContador].strCamCod) Then
              blnExiste := True;
          End;
        End;

        If Not blnExiste Then
        Begin
          Edit;
          FieldByName('EXISTE').AsString := 'N';
          Post;
        End;

      End;

      Next;
    End;

  End;

end;

procedure TfrmTransfCodProduto.pMostraDivergencia;
begin

  With cdsProduto Do
  Begin
    Filter   := '';
    Filtered := False;

    Filter   := ' EXISTE = ' + QuotedStr('N');
    Filtered := True;

    If Not IsEmpty Then
      pCriaForm
    Else
      blnDivergencia := False;
  End;

end;

procedure TfrmTransfCodProduto.pPreencheArray;
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
      Add(' TCA_ARQUIV = "CADITE" ');
      Add(' ORDER BY              ');
      Add('    IF(TCA_ARQREL = "PCDDET_RES", "PCMDET_RES1", IF(TCA_ARQREL = "COTFOR", "COTITE1", IF(TCA_ARQREL = "COTFOR_RES", "COTITE_RES1", TCA_ARQREL))) ');
      Open;

      intPosicao := 0;
      While Not Eof Do
      Begin

        SetLength(arrCamposProduto, succ(intPosicao));

        arrCamposProduto[intPosicao].strNomArq := FieldByName('TCA_ARQREL').AsString;
        arrCamposProduto[intPosicao].strDesCam := FieldByName('TCA_DESCRI').AsString;
        arrCamposProduto[intPosicao].strCamCod := FieldByName('TCA_CAMREL').AsString;

        Next;

        inc(intPosicao);

      End;

    End;

  Finally
    FreeAndNil(qryTcoArr);
  End;

end;

procedure TfrmTransfCodProduto.pCriaForm;
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

      With cdsProduto Do
      Begin
        First;
        While Not Eof Do
        Begin

//          If (Trim(FieldByName('TABELA').AsString) <> 'BONGEN') Then
          If (Trim(FieldByName('TABELA').AsString) <> 'CADITE') And
             (Trim(FieldByName('TABELA').AsString) <> 'ITEGER') And
             (Trim(FieldByName('TABELA').AsString) <> 'GIRITE') Then

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
      pMensagensErro(E.Message, '[frmTransfCodProduto.pCriaForm]');
    End;
  End;

  pFreeAndNil(Form);

end;

Procedure TfrmTransfCodProduto.pDesmarcaIteBarPrincipal(strCodPr0: String);
  Var
    qryIteBar: TUniQuery;
Begin
  qryIteBar := fCriaQuery(Self);
  With qryIteBar, SQL Do
  Begin
    Add('UPDATE ITEBAR O SET');
    Add('  O.BAR_PRINCI = 0, ');
    Add('  O.BAR_COMPRA = 0  ');
    Add('WHERE');
    Add('  O.BAR_CODITE =  :CODORI ');

    ParamByName('CODORI').AsString := strCodPr0;

    ExecSQL;
  End;
  FreeAndNil(qryIteBar);
End;

procedure TfrmTransfCodProduto.pApagaCOMETIDuplicado(strIteOld: String);
  Var
    qryGen: TUniQuery;
begin

  qryGen := fCriaQuery;

  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT * FROM COMETI WHERE ETI_CODITE = :CODITEOLD ');
    qryGen.ParamByName('CODITEOLD').AsString := strIteOld;
    qryGen.Open;

    If Not qryGen.IsEmpty Then
    Begin
      fVerificaIntegridade(Self.Name, 'COMETI', qryGen, True);

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(' DELETE FROM COMETI WHERE ETI_CODITE = :CODITEOLD ');
      qryGen.ParamByName('CODITEOLD').AsString := strIteOld;
      qryGen.ExecSQL;
    End;

  Finally
    FreeAndNil(qryGen)
  End;
end;

Procedure TfrmTransfCodProduto.pApagaITEDTEDuplicado(strCodPrO: string);
  Var
    qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery;

  qryDelete.SQL.Clear;
  qryDelete.SQL.Add('DELETE FROM ITEDTE WHERE ');
  qryDelete.SQL.Add('  ITE_CODITE = "' + strCodPrO + '" ');
  qryDelete.ExecSQL;

  FreeAndNil(qryDelete);
End;

procedure TfrmTransfCodProduto.pApagaNUVM_ITELIBDuplicado(strIteOld: String);
  Var
    qryGen: TUniQuery;
begin

  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT * FROM NUVM_ITELIB WHERE NUVM_CODITE = :CODITEOLD ');
    qryGen.ParamByName('CODITEOLD').AsString := strIteOld;
    qryGen.Open;

    If Not qryGen.IsEmpty Then
    Begin
      {Tem PrimaryKey na tabela DEL SHOW CREATE TABLE DEL_NUVM_ITELIB; PRIMARY KEY (`NUVM_CODEMP`,`NUVM_CODITE`), }
      {fVerificaIntegridade(Self.Name, 'COMETI', qryGen, True); }

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(' DELETE FROM NUVM_ITELIB WHERE NUVM_CODITE = :CODITEOLD ');
      qryGen.ParamByName('CODITEOLD').AsString := strIteOld;
      qryGen.ExecSQL;
    End;

  Finally
    FreeAndNil(qryGen)
  End;
end;

Procedure TfrmTransfCodProduto.pApagaPreIteDuplicado(strIteOld, strIteNew: String);
  Var
    qryDelete: TUniQuery;
    strSQL: String;
Begin
  qryDelete := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'DELETE FROM PREITE WHERE ';
  strSQL := strSQL + '  PRE_CODITE = "' + strIteOld + '" ';
  strSQL := strSQL + '  AND PRE_DTAPRE IN (                 ';
  strSQL := strSQL + ' SELECT PRE_DTAPRE FROM (             ';
  strSQL := strSQL + ' SELECT PRE_DTAPRE, COUNT(*) AS QTD FROM PREITE ';
  strSQL := strSQL + ' WHERE PRE_CODITE IN ("' + strIteOld + '", "' + strIteNew + '")';
  strSQL := strSQL + ' GROUP BY PRE_DTAPRE ';
  strSQL := strSQL + ' HAVING QTD > 1) AS TAB) ';

  With qryDelete Do
  Begin
    SQL.Text := strSQL;
    ExecSQL;
  End;

  FreeAndNil(qryDelete);
End;

procedure TfrmTransfCodProduto.pApagaTRAYITELIBDuplicado(strIteOld: String);
Var
    qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery;
  Try
    qryDelete.Close;
    qryDelete.SQL.Clear;
    qryDelete.SQL.Add('SELECT * FROM TRAY_ITELIB WHERE ');
    qryDelete.SQL.Add('  TRAY_CODITE = "' + strIteOld + '" ');
    qryDelete.Open;

    If (Not qryDelete.IsEmpty) Then
    Begin

      While Not qryDelete.Eof Do
      Begin
        fVerificaIntegridade(Self.Name, 'TRAY_ITELIB', qryDelete, True);
        qryDelete.Next;
      End;

      qryDelete.Close;
      qryDelete.SQL.Clear;
      qryDelete.SQL.Add('DELETE FROM TRAY_ITELIB WHERE ');
      qryDelete.SQL.Add('  TRAY_CODITE = "' + strIteOld + '" ');
      qryDelete.ExecSQL;

    End;

  Finally
    FreeAndNil(qryDelete);
  End;

end;

function TfrmTransfCodProduto.fAlteraItens: Boolean;
  Var
    strSQL     : String;
    intTamMat      : Integer;
    intContador    : Integer;
    intContador2   : Integer;
    intRegAlterados: Integer;

    fltSalBal: Double;
    fltSaldos: Double;
    fltSMlBal: Double;
    fltMl_Sal: Double;

    qryGenTab: TUniQuery;
    qryGenIte: TUniQuery;

    qryMovSal: TUniQuery;

    fltMovDia: Double;
    objInteg : TIntegridadeTransferenciaCodigo;


  const
    SQL_MOVSAL = ' SELECT                                                                                                             '+
                 '   DET_CODEMP,                                                                                                      '+
                 '   G.ITE_DTABAL,                                                                                                    '+
                 '   SUM(                                                                                                             '+
                 '       IF(DET_ESPDOC <> "ML",                                                                                       '+
                 '          IF(LEFT(DET_CLAFIS, 1) < 5, 1, -1) *  DET_QTDITE,                                                         '+
                 '          IF(LEFT(DET_CLAFIS, 1) < 5, 1, -1) *  DET_QTDITE / IF(IFNULL(ITE_CNV_ML, 1) = 0, 1, IFNULL(ITE_CNV_ML, 1))'+
                 '         )                                                                                                          '+
                 '      ) AS QTD                                                                                                      '+
                 ' FROM                                                                                                               '+
                 '   ITEGER G                                                                                                         '+
                 '   JOIN MOVDET   ON   DET_CODEMP = G.ITE_CODEMP                                                                     '+
                 '   JOIN CADITE I ON I.ITE_CODITE = DET_CODITE                                                                       '+
                 ' WHERE                                                                                                              '+
                 '       G.ITE_CODITE =  :ITEDES                                                                                      '+
                 '   AND   DET_CODITE =  :ITEORI                                                                                      '+
                 '   AND   DET_ESPDOC <> "TM"                                                                                         '+
                 '   AND   DET_ESPDOC <> "DF"                                                                                         '+
                 '   AND   DET_FILKAR =  FALSE                                                                                        '+
                 '   AND   DET_DTAENT >  G.ITE_DTABAL                                                                                 '+
                 ' GROUP BY                                                                                                           '+
                 '   DET_CODEMP                                                                                                       ';

begin
  qryGenTab := fCriaQuery(Self);
  qryGenIte := fCriaQuery(Self);
  qryMovSal := fCriaQuery(Self);
  intContador := 0;
  lsvArqAlterados.Items.Clear;

  Result    := True;
  intTamMat := Length(arrCamposProduto);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE ';

  Try
    pDesmarcaIteBarPrincipal(edtCodPrO.Text);

    pApagaPreIteDuplicado(edtCodPrO.Text, edtCodPrD.Text);
    pApagaITEDTEDuplicado(edtCodPrO.Text);
    pAcertaAgeiteDuplicada;
    pApagaCOMETIDuplicado(edtCodPrO.Text);
    pAcertaITECODPAG;
    pApagaNUVM_ITELIBDuplicado(edtCodPrO.Text);

    objInteg := TIntegridadeTransferenciaCodigo.Create('CADITE', edtCodPrO.Text, edtCodPrD.Text);
    Try
      objInteg.pAjustaRegistrosDuplicados(nil);
    Finally
      FreeAndNil(objInteg);
    End;

    With qryGenIte Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtCodPrO.Text;
      Open;

      If IsEmpty Then
      Begin
        fMensagem('', 'Não há itens com esses Dados!', ['&O k']);
        Result := False;
        Exit;
      End;

      //monta o saldo de balanço do item de origem com a mesma data do balanço do item destino
      qryMovSal.SQL.Text := SQL_MOVSAL;
      qryMovSal.ParamByName('ITEORI').AsString := edtCodPrO.Text;
      qryMovSal.ParamByName('ITEDES').AsString := edtCodPrD.Text;
      qryMovSal.Open;

      {********************************************}
      {* PEGA AS TABELAS REFERENTES AO INVENTÁRIO *}
      {* FÍSICO                                   *}
      {*****************************************MV*}
      strSQL := '';
      strSQL := strSQL + 'SHOW TABLES LIKE "I\_%" ';

      qryGenTab.Close;
      qryGenTab.SQL.Clear;
      qryGenTab.SQL.Add(strSQL);
      qryGenTab.Open;

      pnlProgresso.Visible  := True;
      pgbProgresso.Max      := intTamMat;
      pgbProgresso.Position := 0;

      intContador := 0;

      While intContador < intTamMat Do
      Begin
        lsvArqAlterados.Items.Add;
        lsvArqAlterados.Items[intContador].Caption := arrCamposProduto[intContador].strDesCam;
        lsvArqAlterados.Items[intContador].SubItems.Add('Processando...');
        Inc(intContador);
        Application.ProcessMessages;
      End;

      {*******************************************}
      {* ADICIONA TABELAS DE INVENTÁRIO COM O    *}
      {* STATUS "PROCESSANDO"                    *}
      {****************************************MV*}
      While (Not qryGenTab.Eof) Do
      Begin
        lsvArqAlterados.Items.Add;
        lsvArqAlterados.Items[intContador].Caption := qryGenTab.Fields[0].AsString;
        lsvArqAlterados.Items[intContador].SubItems.Add('Processando...');
        Inc(intContador);
        Application.ProcessMessages;

        qryGenTab.Next;
      End;

      intContador := 0;

      While intContador < intTamMat Do
      Begin

        Application.ProcessMessages;
        intRegAlterados := 0;

        If (arrCamposProduto[intContador].strNomArq <> 'DESSIT') And
           (arrCamposProduto[intContador].strNomArq <> 'ITEETI') And
           (Pos('SALINV_', arrCamposProduto[intContador].strNomArq) <= 0) Then
        Begin
          For intContador2 := 1 To 2 Do
          Begin
            intRegAlterados := intRegAlterados + fAtualizaItem(arrCamposProduto[intContador].strNomArq,
                                                               arrCamposProduto[intContador].strCamCod,
                                                               edtCodPrO.Text,
                                                               edtCodPrD.Text,
                                                               intContador2);

            Application.ProcessMessages;

          End;
        End
        Else If (Pos('SALINV_', arrCamposProduto[intContador].strNomArq) > 0) Then
          pAtualizaInventario(arrCamposProduto[intContador].strNomArq);
        lsvArqAlterados.Items[intContador].Selected := True;
        lsvArqAlterados.Items[intContador].MakeVisible(False);
        lsvArqAlterados.Items[intContador].SubItems[0] := IntToStr(intRegAlterados);

        pgbProgresso.StepBy(1);
        Application.ProcessMessages;
        Inc(intContador);

      End;

      {*******************************************}
      {* ALTERA LINHA E GRUPO DO INVENTÁRIO      *}
      {****************************************MV*}
      qryGenTab.First;
      While (Not qryGenTab.Eof) Do
      Begin
        Application.ProcessMessages;
        intRegAlterados := 0;

        pAtualizaInventario(qryGenTab.Fields[0].AsString);

        Application.ProcessMessages;

        lsvArqAlterados.Items[intContador].SubItems[0] := IntToStr(intRegAlterados);

        pgbProgresso.StepBy(1);
        Application.ProcessMessages;
        Inc(intContador);

        qryGenTab.Next;
      End;

    End;


    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE CADLOT SET LOT_DTABAL = :DTABAL WHERE LOT_CODITE = :CODITE');
      ParamByName('DTABAL').AsDateTime := VS_Date-1;
      ParamByName('CODITE').AsString := edtCodPrD.Text;
      ExecSQL;
    End;

    {********************************}
    {* ITEGER                       *}
    {* ALTERANDO O SALDO DE BALANÇO *}
    {*****************************LU*}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_CODITE, ';
    strSQL := strSQL + '  ITE_CODEMP, ';
    strSQL := strSQL + '  ITE_SALDOS, ';
    strSQL := strSQL + '  ITE_SAL_ML,  ';
    strSQL := strSQL + '  ITE_SALBAL  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtCodPrO.Text;
      Open;
      First;

      While Not Eof Do
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  ITE_CODITE, ';
        strSQL := strSQL + '  ITE_CODEMP, ';
        strSQL := strSQL + '  ITE_SALDOS, ';
        strSQL := strSQL + '  ITE_SAL_ML,  ';
        strSQL := strSQL + '  ITE_ML_BAL,  ';
        strSQL := strSQL + '  ITE_SALBAL  ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  ITEGER ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
        strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

        qryGenTab.Close;
        qryGenTab.SQL.Clear;
        qryGenTab.SQL.Add(strSQL);
        qryGenTab.ParamByName('CODEMP').AsString   := Fieldbyname('ITE_CODEMP').AsString;
        qryGenTab.ParamByName('CODITE').AsString   := edtCodPrD.Text;
        qryGenTab.Open;

        fltMovDia := fRetMovimentoDia(qryGenTab.FieldByName('ITE_CODITE').AsString,
                                      qryGenTab.FieldByName('ITE_CODEMP').AsString);

        fltSalBal := qryGenTab.fieldbyname('ITE_SALBAL').AsFloat;
        fltMl_Sal := qryGenTab.fieldbyname('ITE_ML_BAL').AsFloat;
        fltSMlBal := qryGenTab.fieldbyname('ITE_SAL_ML').AsFloat;
        fltSaldos := qryGenTab.fieldbyname('ITE_SALDOS').AsFloat;

        strSQL := '';
        strSQL := strSQL + ' UPDATE ';
        strSQL := strSQL + '   ITEGER ';
        strSQL := strSQL + ' SET ';
        strSQL := strSQL + '   ITE_SALBAL = (ITE_SALDOS + :SALDOS - :MOVDIA), ';
        strSQL := strSQL + '   ITE_ML_BAL = (ITE_SAL_ML + :SAL_ML), ';
        
        strSQL := strSQL + '   ITE_DTABAL = :DTABAL, ';
        
        strSQL := strSQL + '   ITE_SALDOS = (ITE_SALDOS + :SALDOS), ';
        strSQL := strSQL + '   ITE_SAL_ML = (ITE_SAL_ML + :SAL_ML)  ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   ITE_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '   ITE_CODITE = :CODITE ';

        qryGenTab.Close;
        qryGenTab.SQL.Clear;
        qryGenTab.SQL.Add(strSQL);
        qryGenTab.ParamByName('CODEMP').AsString   := Fieldbyname('ITE_CODEMP').AsString;
        qryGenTab.ParamByName('DTABAL').AsDateTime := VS_Date-1;
        qryGenTab.ParamByName('MOVDIA').AsFloat    := fltMovDia;
        qryGenTab.ParamByName('SALDOS').AsFloat    := Fieldbyname('ITE_SALDOS').AsFloat;
        qryGenTab.ParamByName('SAL_ML').AsFloat    := Fieldbyname('ITE_SAL_ML').AsFloat;
        qryGenTab.ParamByName('CODITE').AsString   := edtCodPrD.Text;
        qryGenTab.ExecSQL;

        if qryMovSal.Locate('DET_CODEMP', FieldByName('ITE_CODEMP').AsString, []) then
        begin
          fGravaMovSba(FieldByName('ITE_CODEMP').AsString,
                       edtCodPrD.Text,
                       strLoginUsuarioLogado,
                       fltSaldos + FieldByName('ITE_SALDOS').AsFloat,
                       fltML_Sal + FieldByName('ITE_SAL_ML').AsFloat,
                       VS_Date-1,
                       fltSaldos + FieldByName('ITE_SALDOS').AsFloat - fltMovDia,
                       fltSMlBal + FieldByName('ITE_SAL_ML').AsFloat,
                       VS_Date,
                       fTime(),
                       qryMovSal.FieldByName('ITE_DTABAL').AsFloat,
                       fltSalBal + FieldByName('ITE_SALDOS').AsFloat - qryMovSal.FieldByName('QTD').AsFloat,
                       fltSMLBal + FieldByName('ITE_SAL_ML').AsFloat);
        end;

        Next;
      End;

    End;

    {********************************}
    {* GIRITE                       *}
    {*****************************LU*}
    pRecalculaGiro;

    {******************}
    {* GRAVANDO O LOG *}
    {***************LU*}
    strSQL := '';
    strSQL := strSQL + 'INSERT INTO LOGITE (';
    strSQL := strSQL + '  AUTOINCREM, ';
    strSQL := strSQL + '  LOG_DTALOG, ';
    strSQL := strSQL + '  LOG_HORLOG, ';
    strSQL := strSQL + '  LOG_CODEMP, ';
    strSQL := strSQL + '  LOG_CODOPE, ';
    strSQL := strSQL + '  LOG_ITEORI, ';
    strSQL := strSQL + '  LOG_ITEDES) ';
    strSQL := strSQL + 'VALUES (';
    strSQL := strSQL + '  :AUTINC, ';
    strSQL := strSQL + '  :DTALOG, ';
    strSQL := strSQL + '  :HORLOG, ';
    strSQL := strSQL + '  :CODEMP, ';
    strSQL := strSQL + '  :CODOPE, ';
    strSQL := strSQL + '  :ITEORI, ';
    strSQL := strSQL + '  :ITEDES) ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsString  := fRetAutoIncrem('LOGITE', VS_strCodEmp);
      ParamByName('DTALOG').AsDateTime:= VS_Date;
      ParamByName('HORLOG').AsTime    := fTime();
      ParamByName('CODEMP').AsString  := VS_strCodEmp;
      ParamByName('CODOPE').AsString  := strLoginUsuarioLogado;
      ParamByName('ITEORI').AsString  := edtCodPrO.Text;
      ParamByName('ITEDES').AsString  := edtCodPrD.Text;
      ExecSQL;
    End;

    //Leva os preços para o Destino;
    If chkOpcTransfPreco.Checked Then
    begin
      If Not fTransferePrecosParaDestino Then
        raise Exception.Create('Falha ao replicar preços!');
    end;

    pGravarTabelaLog(edtCodPrO.Text, edtCodPrD.Text, 'CADITE');

    {************************************}
    {* APAGANDO O ITEM DA TABELA ITEGER *}
    {*********************************LU*}

    strSQL := '';
    strSQL := strSQL + 'SELECT * ';
    strSQL := strSQL + 'FROM ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtCodPrO.Text;
      Open;

      While Not Eof Do
      Begin
        fVerificaIntegridade(Self.Name, 'ITEGER', qryGenIte, True);
        Next;
      End;

    End;

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtCodPrO.Text;
      ExecSQL;
    End;


    strSQL := '';
    strSQL := strSQL + 'SELECT * ';
    strSQL := strSQL + 'FROM ITEETI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ETI_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtCodPrO.Text;
      Open;
    End;


    {*************************************}
    {* APAGANDO A DESCRIÇÃO SITE DO ITEM *}
    {**********************************AL*}
    strSQL := '';
    strSQL := strSQL + 'SELECT * ';
    strSQL := strSQL + 'FROM DESSIT ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtCodPrO.Text;
      Open;
    End;

    fVerificaIntegridade(Self.Name, 'DESSIT', qryGenIte, True);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  DESSIT ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtCodPrO.Text;
      ExecSQL;
    End;

    {************************************}
    {* APAGANDO O ITEM DA TABELA CADITE *}
    {*********************************LU*}
    strSQL := '';
    strSQL := strSQL + 'SELECT *    ';
    strSQL := strSQL + 'FROM CADITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtCodPrO.Text;
      Open;
    End;

    fVerificaIntegridade(Self.Name, 'CADITE', qryGenIte, True);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtCodPrO.Text;
      ExecSQL;
    End;

    TSaldoPedido.fAtualizaSaldoPedidoCompraGeralPrg(nil);
    ReprocessarItem(edtCodPrD.Text, '');

  Except
    On E: Exception Do
    Begin
      Result := False;
      If objExcelTrans.blnExecutandoTransferencia Then
        objExcelTrans.pAddNotificacao(E.Message)
      Else
      Begin
        pMensagensErro(E.Message, '[fAlteraItens]');
        pMensagemOk('Tabela:' + arrCamposProduto[intContador].strNomArq + '#13#10' + E.Message );
      End;
    End;
  End;

  FreeAndNil(qryGenTab);
  FreeAndNil(qryGenIte);
  FreeAndNil(qryMovSal);

end;

Procedure TfrmTransfCodProduto.pCriaLotesAjustaSaldo;
  Var
    strSQL: String;
    qryIteger,
    qryCadLot,
    qryCadLotFaltaDestino,
    qryCadEmp,
    qryComand: TUniQuery;
Begin
  qryCadLot := fCriaQuery;
  qryCadLotFaltaDestino := fCriaQuery;
  qryComand := fCriaQuery;
  qryCadLot.SQL.Text := 'SELECT * FROM CADLOT WHERE FALSE';
  qryCadLot.Open;

  qryIteger := fCriaQuery;
  qryIteger.SQL.Text := 'SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '    EMP_CODEMP AS CODEMP, ';
  strSQL := strSQL + '    (SELECT COUNT(*) FROM CADLOT WHERE LOT_CODEMP = EMP_CODEMP AND LOT_CODITE = :PROORI) - ';

  strSQL := strSQL + '    IF(((SELECT COUNT(*) FROM CADLOT WHERE LOT_CODEMP = EMP_CODEMP AND LOT_CODITE = :PROORI) = 1) AND ';
  strSQL := strSQL + '      ((SELECT LOT_SALDOS FROM CADLOT WHERE LOT_CODEMP = EMP_CODEMP AND LOT_CODITE = :PROORI AND LOT_NUMLOT = "A DEFINIR") = 0), 1, 0) AS QTDORI, ';


  strSQL := strSQL + '    (SELECT COUNT(*) FROM CADLOT WHERE LOT_CODEMP = EMP_CODEMP AND LOT_CODITE = :PRODES) - ';

  strSQL := strSQL + '    IF(((SELECT COUNT(*) FROM CADLOT WHERE LOT_CODEMP = EMP_CODEMP AND LOT_CODITE = :PRODES) = 1) AND ';
  strSQL := strSQL + '      ((SELECT LOT_SALDOS FROM CADLOT WHERE LOT_CODEMP = EMP_CODEMP AND LOT_CODITE = :PRODES AND LOT_NUMLOT = "A DEFINIR") = 0), 1, 0) AS QTDDES  ';

  strSQL := strSQL + ' FROM       ';
  strSQL := strSQL + '   CADEMP   ';
  strSQL := strSQL + ' HAVING QTDDES XOR QTDORI ';

  qryCadEmp := fCriaQuery;

  With qryCadEmp Do
  Begin
    SQL.Text := strSQL;

    ParamByName('PROORI').AsString := edtCodPrO.Text;
    ParamByName('PRODES').AsString := edtCodPrD.Text;

    Open;

    While Not Eof Do
    Begin

      qryIteger.Close;
      qryIteger.ParamByName('CODEMP').AsString := FieldByName('CODEMP').AsString;

      // NAO TEM LOTE NA EMPRESA DESTINO - É PRECISO INCLUIR UM LOTE COM O SALDO DA EMPRESA DESTINO
      If FieldByName('QTDORI').AsInteger > 0 Then
      Begin
        qryIteger.ParamByName('CODITE').AsString := edtCodPrD.Text;
      End Else
      // NAO TEM LOTE NA EMPRESA ORIGEM  - É PRECISO INCLUIR UM LOTE COM O SALDO DA EMPRESA ORIGEM
      Begin
        qryIteger.ParamByName('CODITE').AsString := edtCodPrO.Text;
      End;

      qryIteger.Open;

      If (Not IsEmpty) And
         ((qryIteger.FieldByName('ITE_SALDOS').AsFloat <> 0)  Or
          (qryIteger.FieldByName('ITE_SAL_ML').AsFloat <> 0)) Then
      Begin
        qryCadLot.Insert;
        qryCadLot.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', VS_strCodEmp);
        qryCadLot.FieldByName('LOT_CODEMP').AsString   := FieldByName('CODEMP').AsString;
        qryCadLot.FieldByName('LOT_CODITE').AsString   := edtCodPrD.Text;
        qryCadLot.FieldByName('LOT_NUMLOT').AsString   := 'TRANSF.COD. ' + edtCodPrO.Text;

        qryCadLot.FieldByName('LOT_DTABAL').Value := VS_Date-1;
        qryCadLot.FieldByName('LOT_SALBAL').Value := qryIteger.FieldByName('ITE_SALBAL').Value;
        qryCadLot.FieldByName('LOT_ML_BAL').Value := qryIteger.FieldByName('ITE_ML_BAL').Value;

        qryCadLot.FieldByName('LOT_SALDOS').Value := qryIteger.FieldByName('ITE_SALDOS').Value;
        qryCadLot.FieldByName('LOT_SAL_ML').Value := qryIteger.FieldByName('ITE_SAL_ML').Value;

        qryCadLot.FieldByName('LOT_SALCON').Value := qryIteger.FieldByName('ITE_SALCON').Value;
        qryCadLot.FieldByName('LOT_ML_CON').Value := qryIteger.FieldByName('ITE_GMLCON').Value;

        qryCadLot.FieldByName('LOT_DIFSAL').Value := qryIteger.FieldByName('ITE_DIFSAL').Value;
        qryCadLot.FieldByName('LOT_DIF_ML').Value := qryIteger.FieldByName('ITE_DIF_ML').Value;
        qryCadLot.Post;

      End;

      Next;
    End; {While Not Eof Do}

  End;

  qryCadLotFaltaDestino.sql.Clear;

  qryCadLotFaltaDestino.sql.Add('SELECT ');
  qryCadLotFaltaDestino.sql.Add('(SELECT LOT_NUMLOT FROM CADLOT');
  qryCadLotFaltaDestino.sql.Add('  WHERE LOT_CODITE = :PRODES');
  qryCadLotFaltaDestino.sql.Add('   AND CADLOT.LOT_NUMLOT = TMP2.LOT_NUMLOT ');
  qryCadLotFaltaDestino.sql.Add('  AND CADLOT.LOT_CODEMP = TMP2.LOT_CODEMP) AS LOTDES,');
  qryCadLotFaltaDestino.sql.Add('  TMP2.*');
  qryCadLotFaltaDestino.sql.Add(' FROM (SELECT * FROM');
  qryCadLotFaltaDestino.sql.Add('(SELECT LOT_CODEMP, LOT_CODITE, LOT_NUMLOT, LOT_DTABAL, LOT_SALBAL, LOT_ML_BAL, LOT_SALDOS, LOT_SAL_ML, LOT_SALCON, LOT_ML_CON, LOT_DIFSAL, LOT_DIF_ML');
  qryCadLotFaltaDestino.sql.Add('  FROM MOVLOT');
  qryCadLotFaltaDestino.sql.Add(' INNER JOIN CADLOT ON LOT_CODITE  = MLT_CODITE AND LOT_NUMLOT = MLT_LOTDES');
  qryCadLotFaltaDestino.sql.Add(' WHERE MLT_CODITE = :PROORI');
  qryCadLotFaltaDestino.sql.Add(' UNION ALL');
  qryCadLotFaltaDestino.sql.Add(' SELECT LOT_CODEMP, LOT_CODITE, LOT_NUMLOT, LOT_DTABAL, LOT_SALBAL, LOT_ML_BAL, LOT_SALDOS, LOT_SAL_ML, LOT_SALCON, LOT_ML_CON, LOT_DIFSAL, LOT_DIF_ML');
  qryCadLotFaltaDestino.sql.Add('  FROM MOVLOT');
  qryCadLotFaltaDestino.sql.Add(' INNER JOIN CADLOT ON LOT_CODITE  = MLT_CODITE AND LOT_NUMLOT = MLT_LOTORI');
  qryCadLotFaltaDestino.sql.Add(' WHERE MLT_CODITE = :PROORI) TESTE');
  qryCadLotFaltaDestino.sql.Add(' GROUP BY LOT_NUMLOT, LOT_CODEMP) TMP2');
  qryCadLotFaltaDestino.sql.Add('GROUP BY LOT_NUMLOT, LOT_CODEMP');


  qryCadLotFaltaDestino.ParamByName('PROORI').AsString := edtCodPrO.Text;
  qryCadLotFaltaDestino.ParamByName('PRODES').AsString := edtCodPrD.Text;

  qryCadLotFaltaDestino.Open;

  While not qryCadLotFaltaDestino.Eof Do
  Begin
    If qryCadLotFaltaDestino.FieldByName('LOTDES').AsString = '' Then
    Begin
      qryCadLot.Insert;
      qryCadLot.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', VS_strCodEmp);
      qryCadLot.FieldByName('LOT_CODEMP').AsString   := qryCadLotFaltaDestino.FieldByName('LOT_CODEMP').AsString;
      qryCadLot.FieldByName('LOT_CODITE').AsString   := edtCodPrD.Text;
      qryCadLot.FieldByName('LOT_NUMLOT').AsString   := qryCadLotFaltaDestino.FieldByName('LOT_NUMLOT').AsString;

      qryCadLot.FieldByName('LOT_DTABAL').Value := qryCadLotFaltaDestino.FieldByName('LOT_DTABAL').AsString;
      qryCadLot.FieldByName('LOT_SALBAL').Value := qryCadLotFaltaDestino.FieldByName('LOT_SALBAL').Value;
      qryCadLot.FieldByName('LOT_ML_BAL').Value := qryCadLotFaltaDestino.FieldByName('LOT_ML_BAL').Value;

//    qryCadLot.FieldByName('LOT_SALDOS').Value := qryCadLotFaltaDestino.FieldByName('LOT_SALDOS').Value;
//    qryCadLot.FieldByName('LOT_SAL_ML').Value := qryCadLotFaltaDestino.FieldByName('LOT_SAL_ML').Value;

      qryCadLot.FieldByName('LOT_SALCON').Value := qryCadLotFaltaDestino.FieldByName('LOT_SALCON').Value;
      qryCadLot.FieldByName('LOT_ML_CON').Value := qryCadLotFaltaDestino.FieldByName('LOT_ML_CON').Value;

      qryCadLot.FieldByName('LOT_DIFSAL').Value := qryCadLotFaltaDestino.FieldByName('LOT_DIFSAL').Value;
      qryCadLot.FieldByName('LOT_DIF_ML').Value := qryCadLotFaltaDestino.FieldByName('LOT_DIF_ML').Value;
      qryCadLot.Post;
    End;
    qryCadLotFaltaDestino.Next;
  End;

  qryComand.sql.Clear;

  qryComand.SQL.Text := 'UPDATE MOVLOT SET MLT_CODITE = "' + edtCodPrD.Text + '"' +
                              ' WHERE MLT_CODITE =  "' + edtCodPrO.Text + '"';

  qryComand.ExecSQL;

  FreeAndNil(qryCadEmp);
  FreeAndNil(qryCadLot);
  FreeAndNil(qryIteger);
  FreeAndNil(qryComand);
  FreeAndNil(qryCadLotFaltaDestino);
End;

Procedure TfrmTransfCodProduto.pApagaPCDDET_RES(strProOri: String);
  Var
    qryPedido: TUniQuery;
Begin
  qryPedido := fCriaQuery;
  qryPedido.SQL.Text := 'DELETE FROM PCDDET_RES WHERE PCD_CODITE = :CODITE';
  qryPedido.ParamByName('CODITE').AsString := strProOri;
  qryPedido.ExecSQL;
  FreeAndNil(qryPedido);
End;

function TfrmTransfCodProduto.fAtualizaItem(strNomArq, strCamCod, strProOri, strProDes: String;
  intOpcao: Integer): Integer;
  Var
    strSQL   : String;
    strCFG   : String;
    qryGenTmp: TUniQuery;

  Procedure pChecaCadLote;
    Var
      qryCadLot: TUniQuery;
  Begin
    if Pos('CADLOT', strNomArq) <= 0 then
      Exit;

    Try

      If SameText('CADLOT', strNomArq) then
        pCriaLotesAjustaSaldo;

      qryCadLot := fCriaQuery(Self);

      With qryCadLot, Sql do
      Begin
        Clear;
        Add(' SELECT * FROM ' + strNomArq + ' WHERE LOT_CODITE = :CODITE ');
        ParamByName('CODITE').AsString := strProOri;
        Open;
      End;

      strSQL := '';
      strSQL := strSQL + ' SELECT * FROM ' + strNomArq ;
      strSQL := strSQL + ' WHERE LOT_NUMLOT = :NUMLOT ';
      strSQL := strSQL + '   AND LOT_CODEMP = :CODEMP ';
      strSQL := strSQL + '   AND LOT_CODITE = :CODITE ';

      with qryGenTmp, Sql Do
      Begin

        While not qryCadLot.Eof do
        Begin
          Close;
          Clear;
          Add(strSQL);
          ParamByName('NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
          ParamByName('CODEMP').AsString := qryCadLot.FieldByName('LOT_CODEMP').AsString;
          ParamByName('CODITE').AsString := strProDes;
          Open;

          If Not IsEmpty then
          Begin
            Clear;
            Add(' UPDATE ' + strNomArq + ' SET       ');
            Add(' LOT_SALBAL = LOT_SALBAL + :SALBAL, ');
            Add(' LOT_SALDOS = LOT_SALDOS + :SALDOS, ');
            Add(' LOT_SALCON = LOT_SALCON + :SALCON, ');
            Add(' LOT_DIFSAL = LOT_DIFSAL + :DIFSAL, ');
            Add(' LOT_DIF_ML = LOT_DIF_ML + :DIF_ML, ');
            Add(' LOT_ML_CON = LOT_ML_CON + :ML_CON, ');
            Add(' LOT_SAL_ML = LOT_SAL_ML + :SAL_ML, ');
            Add(' LOT_ML_BAL = LOT_ML_BAL + :ML_BAL  ');
            Add(' WHERE LOT_NUMLOT = :NUMLOT         ');
            Add('   AND LOT_CODEMP = :CODEMP         ');
            Add('   AND LOT_CODITE = :CODITE         ');

            ParamByName('NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
            ParamByName('CODEMP').AsString := qryCadLot.FieldByName('LOT_CODEMP').AsString;
            ParamByName('CODITE').AsString := strProDes;
            ParamByName('SALBAL').Value := qryCadLot.FieldByName('LOT_SALBAL').Value;
            ParamByName('SALDOS').Value := qryCadLot.FieldByName('LOT_SALDOS').Value;
            ParamByName('SALCON').Value := qryCadLot.FieldByName('LOT_SALCON').Value;
            ParamByName('DIFSAL').Value := qryCadLot.FieldByName('LOT_DIFSAL').Value;
            ParamByName('DIF_ML').Value := qryCadLot.FieldByName('LOT_DIF_ML').Value;
            ParamByName('ML_CON').Value := qryCadLot.FieldByName('LOT_ML_CON').Value;
            ParamByName('SAL_ML').Value := qryCadLot.FieldByName('LOT_SAL_ML').Value;
            ParamByName('ML_BAL').Value := qryCadLot.FieldByName('LOT_ML_BAL').Value;

            ExecSQL;

            Clear;
            Add(' DELETE FROM ' + strNomArq + '      ');
            Add(' WHERE LOT_NUMLOT = :NUMLOT         ');
            Add('   AND LOT_CODEMP = :CODEMP         ');
            Add('   AND LOT_CODITE = :CODITE         ');

            ParamByName('NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
            ParamByName('CODEMP').AsString := qryCadLot.FieldByName('LOT_CODEMP').AsString;
            ParamByName('CODITE').AsString := strProOri;

            ExecSQL;
          End;

          Inc(Result);

          qryCadLot.Next;
        End; {While not qryCadLot.Eof do}

      End; {with qryGenTmp, Sql Do}

    Finally
      FreeAndNil(qryCadLot);
    End;

  End;

begin
  Try
    Result := 0;

    qryGenTmp := fCriaQuery(Self);

    If intOpcao = 2 Then
      strNomArq := 'DEL_' + strNomArq;

    If Not fTabelaExiste(strNomArq) Then
      Exit;


    if Not fCampoExiste(strNomArq, strCamCod) then
      Exit;

    {*************************************************************}
    {* A TABELA GIRITE ESTA NO TCOARR, POREM ELA NÃO DEVE SER    *}
    {* ATUALIZADA PARA NÃO VIOLAR A CHAVE PRIMARIA, O GIRO É     *}
    {* RECALCULADO NO FINAL DA TRANSFERENCIA ENTÃO FICA CORRETO! *}
    {**********************************************************GB*}
    If (Pos(strNomArq, 'CADITE_ITEGER_DESSIT_GIRITE') > 0 ) Then
      Exit;

    If SameText('DEL_COMETI', strNomArq) Then
      Exit;

    pChecaCadLote;

    If SameText('PCMDET_RES', strNomArq) then
      pApagaPCDDET_RES(strProOri);


    If strNomArq = 'DIGELE' Then
      pTratarDigEle(strProOri, strProDes);


    If strNomArq = 'PROBRI_ITE' Then
      pTratarPROBRI_ITE(strProOri);

    If SameText('TRAY_ITELIB', strNomArq) Then
      pApagaTRAYITELIBDuplicado(strProOri);

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + strNomArq;
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + strCamCod + ' = :PRODES ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + strCamCod + '  = :PROORI ';

    If (strNomArq = 'CFGSIS') Then
    Begin
      strCFG := '';

      If Assigned(ProcRetCfgRelacionadaArquivo) then
        strCFG := ProcRetCfgRelacionadaArquivo('CADITE');

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
      ParamByName('PRODES').AsString := edtCodPrD.Text;
      ParamByName('PROORI').AsString := edtCodPrO.Text;
      ExecSQL;
      Result := RowsAffected;
      Close;

    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

procedure TfrmTransfCodProduto.pRecalculaGiro;
Var
  strSQL : String;


  qryGenEmp : TUniQuery;
  qryGenGir : TUniQuery;
  qryGenFis : TUniQuery;
Begin
  qryGenEmp := fCriaQuery;
  qryGenGir := fCriaQuery;
  qryGenFis := fCriaQuery;

  Try
    {****************************************}
    {* DELETANDO O GIRITE DOS DOIS PRODUTOS *}
    {*************************************LU*}
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  GIRITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GIR_CODITE = :CODITE ';

    With qryGenGir Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtCodPrO.Text;
      ExecSQL;
    End;

    {***************************}
    {* LOCALIZANDO AS EMPRESAS *}
    {************************LU*}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_CODEMP AS CODEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      While Not Eof Do
      Begin

        Try
          pCriarFormularios(TfrmFecGiroEstoque, frmFecGiroEstoque);
          frmFecGiroEstoque.strItemGiro := edtCodPrD.Text;
          frmFecGiroEstoque.strEmpGiro  := qryGenEmp.FieldByName('CODEMP').AsString;
          frmFecGiroEstoque.blnControlaTransacao := False;
          frmFecGiroEstoque.ShowModal;
          FreeAndNil(frmFecGiroEstoque);

          Application.ProcessMessages;
        Except
          On E: Exception Do
          Begin
            fMensagem('ATENÇÃO!', 'Favor realizar o cálculo do giro manualmente. ' + E.Message, ['&Ok']);
            Break;
          End;
        End;

        Next;

      End;

    End;

  Finally
    FreeAndNil(qryGenEmp);
    FreeAndNil(qryGenGir);
    FreeAndNil(qryGenFis);
  End;

End;

procedure TfrmTransfCodProduto.pAcertaITECODPAG;
Var
  qryUpdate : TUniQuery;
Begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('SELECT COUNT(1) AS QTD FROM CADITE WHERE ITE_CODPAG = :CODPAG ');
    qryUpdate.ParamByName('CODPAG').AsString := edtCodPrO.Text;
    qryUpdate.Open;
    If Not qryUpdate.IsEmpty Then
    Begin
       qryUpdate.Close;
       qryUpdate.SQL.Clear;
       qryUpdate.SQL.Add(' UPDATE CADITE               ');
       qryUpdate.SQL.Add('    SET ITE_CODPAG = :ITEDES ');
       qryUpdate.SQL.Add('  WHERE ITE_CODPAG = :ITEORI  ');

       qryUpdate.ParamByName('ITEDES').AsString := edtCodPrD.Text;
       qryUpdate.ParamByName('ITEORI').AsString := edtCodPrO.Text;

       qryUpdate.ExecSQL;
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;
End;

procedure TfrmTransfCodProduto.pAcertaAgeiteDuplicada;
Var
  qryAGEREC : TUniQuery;
  qryUpdate : TUniQuery;

Begin
  qryAGEREC := fCriaQuery;
  qryUpdate := fCriaQuery;
  Try
    {****************************************}
    {* DELETANDO O AGEITE DOS DOIS PRODUTOS *}
    {*************************************LO*}

    qryAGEREC.SQL.Add('SELECT                                     ');
    qryAGEREC.SQL.Add('  AGEREC.AUTOINCREM AS SEQGER,             ');
    qryAGEREC.SQL.Add('	(SELECT                                   ');
    qryAGEREC.SQL.Add('		 COUNT(1)                               ');
    qryAGEREC.SQL.Add('		FROM                                    ');
    qryAGEREC.SQL.Add('		 AGEITE                                 ');
    qryAGEREC.SQL.Add('		WHERE AIT_CODITE IN (:CODORI, :CODDES)  ');
    qryAGEREC.SQL.Add('		AND AIT_SEQGER =  AGEREC.AUTOINCREM     ');
    qryAGEREC.SQL.Add('		)  AS QTD                               ');
    qryAGEREC.SQL.Add('FROM AGEREC                                ');
    qryAGEREC.SQL.Add('HAVING QTD > 1                             ');

    qryAGEREC.ParamByName('CODORI').AsString := edtCodPrO.Text;
    qryAGEREC.ParamByName('CODDES').AsString := edtCodPrD.Text;

    qryAGEREC.Open;

    qryAGEREC.First;
    while not qryAGEREC.eof do
    begin

      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add('UPDATE                                                                                               ');
      qryUpdate.SQL.Add('  AGEITE                                                                                             ');
      qryUpdate.SQL.Add('  INNER JOIN AGEILO ON AIL_SEQITE = AGEITE.AUTOINCREM                                                ');
      qryUpdate.SQL.Add('SET AIL_SEQITE = (SELECT AUTOINCREM FROM AGEITE WHERE AIT_SEQGER = :SEQGER AND AIT_CODITE = :CODDES) ');
      qryUpdate.SQL.Add('WHERE AIT_SEQGER =  :SEQGER                                                                          ');
      qryUpdate.SQL.Add('  AND AIT_CODITE =  :CODORI                                                                          ');

      qryUpdate.ParamByName('CODORI').AsString := edtCodPrO.Text;
      qryUpdate.ParamByName('CODDES').AsString := edtCodPrD.Text;
      qryUpdate.ParamByName('SEQGER').AsString := qryAGEREC.FieldByName('SEQGER').AsString;
      qryUpdate.ExecSQL;

      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add('UPDATE                                                                                         ');
      qryUpdate.SQL.Add('  AGEITE                                                                                       ');
      qryUpdate.SQL.Add('  INNER JOIN (SELECT                                                                           ');
      qryUpdate.SQL.Add('               AIT_SEQGER,                                                                     ');
      qryUpdate.SQL.Add('               SUM(AIT_QTDITE) AS QTDITE,                                                      ');
      qryUpdate.SQL.Add('								SUM(AIT_QTDTOT) AS QTDTOT,                                                      ');
      qryUpdate.SQL.Add('								SUM(AIT_QTDEND) AS QTDEND,                                                      ');
      qryUpdate.SQL.Add('								SUM(AIT_QTDDEV) AS QTDDEV                                                       ');
      qryUpdate.SQL.Add('							FROM                                                                              ');
      qryUpdate.SQL.Add('								AGEITE                                                                          ');
      qryUpdate.SQL.Add('							WHERE AIT_SEQGER = :SEQGER                                                        ');
      qryUpdate.SQL.Add('								AND AIT_CODITE IN (:CODORI, :CODDES)) QTD ON QTD.AIT_SEQGER = AGEITE.AIT_SEQGER ');
      qryUpdate.SQL.Add('  SET AIT_QTDITE = QTDITE,                                                                     ');
      qryUpdate.SQL.Add('      AIT_QTDTOT = QTDTOT,                                                                     ');
      qryUpdate.SQL.Add('      AIT_QTDEND = QTDEND,                                                                     ');
      qryUpdate.SQL.Add('      AIT_QTDDEV = QTDDEV                                                                      ');
      qryUpdate.SQL.Add('WHERE AGEITE.AIT_SEQGER = :SEQGER                                                              ');
      qryUpdate.SQL.Add('  AND AGEITE.AIT_CODITE = :CODDES                                                              ');

      qryUpdate.ParamByName('CODORI').AsString := edtCodPrO.Text;
      qryUpdate.ParamByName('CODDES').AsString := edtCodPrD.Text;
      qryUpdate.ParamByName('SEQGER').AsString := qryAGEREC.FieldByName('SEQGER').AsString;
      qryUpdate.ExecSQL;

      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add('DELETE FROM AGEITE WHERE AIT_SEQGER = :SEQGER AND AIT_CODITE = :CODORI ');

      qryUpdate.ParamByName('CODORI').AsString := edtCodPrO.Text;
      qryUpdate.ParamByName('SEQGER').AsString := qryAGEREC.FieldByName('SEQGER').AsString;
      qryUpdate.ExecSQL;

      qryAGEREC.Next;
    end;


  Finally
    FreeAndNil(qryAGEREC);
    FreeAndNil(qryUpdate);
  End;

End;

function TfrmTransfCodProduto.fRetMovimentoDia(strCodIte, strCodEmp: String): Double;
  Var
    strSQL: String;
    qryMovDia: TUniQuery;
begin

  qryMovDia := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SUM( ';
  strSQL := strSQL + '       IF(DET_ESPDOC <> "ML", ';

  strSQL := strSQL + '          IF(LEFT(DET_CLAFIS, 1) < 5, 1, -1) *  DET_QTDITE, ';

  strSQL := strSQL + '          IF(LEFT(DET_CLAFIS, 1) < 5, 1, -1) *  DET_QTDITE / IF(IFNULL(ITE_CNV_ML, 1) = 0, 1, IFNULL(ITE_CNV_ML, 1)) ';

  strSQL := strSQL + '       ) ';
  strSQL := strSQL + '  ) AS QTDDIA ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + 'JOIN CADITE ON ITE_CODITE = DET_CODITE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_ESPDOC <> "TM" AND ';
  strSQL := strSQL + '  DET_ESPDOC <> "DF" AND ';
  strSQL := strSQL + '  DET_FILKAR = FALSE AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  DET_CODITE = :CODITE AND ';
  strSQL := strSQL + '  DET_DTAENT = :DTAMOV ';

  qryMovDia.SQL.Add(strSQL);
  qryMovDia.ParamByName('CODEMP').AsString   := strCodEmp;
  qryMovDia.ParamByName('CODITE').AsString   := strCodIte;
  qryMovDia.ParamByName('DTAMOV').AsDateTime := VS_Date;
  qryMovDia.Open;

  Result := 0.0;
  While (Not qryMovDia.Eof) Do
  Begin
    Result := Result + qryMovDia.FieldByName('QTDDIA').AsFloat;
    qryMovDia.Next;
  End;

  qryMovDia.Close;
  FreeAndNil(qryMovDia);

end;

procedure TfrmTransfCodProduto.pCarregaTabelasTinta;
begin
  strTabTin := 'TINDET_BZA_CADBAS_BZI_CADBAS_BZI_CADBZI_CORIMO_CADBAS_CORIMO_CADCOR_CORIMO_CADNFM_' +
               'CORIND_CADBAS_CORIND_CADCOR_CORIND_CADNFM_DAC_CADBAS_DAC_CADDAC_DUP_CADBAS_FUT_CADBAS_'     +
               'FUT_CADCOL_FUT_CADFUT_KIL_CADBAS_KIL_CADCOL_KIL_CADKIL_LKS_CADBAS_LKS_CADLKS_REI_CADBAS_'   +
               'REI_CADREI_SAL_CADBAS_SHE_CADBAS_SHE_CADSHE_STA_CADBAS_SUV_CADBAS_SUV_CADSUV_SUV_CADCOL_'   +
               'WANPRO_CADBAS_WAN_CADBAS_TINDOR_DETELE_';
end;

procedure TfrmTransfCodProduto.pAtualizaInventario(strTabela: String);
  var
    qryDel: TUniQuery;
    qryGen: TUniQuery;
    qryUpd: TUniQuery;
    strSql: String;
begin
  If Not fTabelaExiste(strTabela) Then
    Exit;

  qryGen := fCriaQuery;
  qryUpd := fCriaQuery;
  qryDel := fCriaQuery;


  qryDel.SQL.Text := 'DELETE FROM ' + strTabela + ' WHERE ITE_CODITE = :CODITE';

  qryGen.Options.StrictUpdate := False;
  qryUpd.Options.StrictUpdate := False;

  With qryGen, Sql Do
  Begin
    Close;
    Clear;
    Add('SELECT * FROM ' + strTabela);
    Add('WHERE ITE_CODITE = ' + QuotedStr(edtCodPrO.Text));
    Open;

    strSql := '';
    strSql := strSql + ' UPDATE ';
    strSql := strSql + '   ' + strTabela;
    strSql := strSql + ' SET ';
    strSql := strSql + '   ITE_SALDOS = ITE_SALDOS + :SALDOS, ';
    strSql := strSql + '   ITE_SALBAL = ITE_SALBAL + :SALBAL  ';
    strSql := strSql + ' WHERE ';
    strSql := strSql + '   ITE_CODITE = :CODITE AND ';
    strSql := strSql + '   ITE_CODEMP = :CODEMP ';

    First;

    While Not Eof Do
    Begin
      qryUpd.SQL.Clear;
      qryUpd.SQL.Add(strSql);

      qryUpd.ParamByName('SALDOS').AsFloat  := FieldByName('ITE_SALDOS').AsFloat;
      qryUpd.ParamByName('SALBAL').AsFloat  := FieldByName('ITE_SALBAL').AsFloat;
      qryUpd.ParamByName('CODITE').AsString := edtCodPrD.Text;
      qryUpd.ParamByName('CODEMP').AsString := FieldByName('ITE_CODEMP').AsString;

      qryUpd.ExecSQL;

      Next;
    End;

    First;

    While Not qryGen.Eof Do
    Begin
      qryDel.Close;
      qryDel.ParamByName('CODITE').AsString := edtCodPrO.Text;
      qryDel.ExecSQL;

      qryGen.Next;
    end;

  End;

  FreeAndNil(qryGen);
  FreeAndNil(qryUpd);
end;


function TfrmTransfCodProduto.fTransferePrecosParaDestinoAux(pgbProgresso: TcxProgressBar): Boolean;
  var qryItegerOrigem: TUniQuery;
      qryCadIte: TUniQuery;
      qryItegerDestinoUpdate: TUniQuery;
      i: Integer;
begin
  Result := True;
  Try
    qryItegerOrigem := fCriaQuery(Self);
    qryItegerDestinoUpdate := fCriaQuery(Self);
    Try
      qryItegerOrigem.SQL.Add('SELECT ITEGER.* FROM ITEGER');
      qryItegerOrigem.SQL.Add(' WHERE ITE_CODITE = "' + edtCodPrO.Text + '"');
      qryItegerOrigem.Open;

      qryItegerDestinoUpdate.SQL.Add('UPDATE ITEGER SET ');
      qryItegerDestinoUpdate.SQL.Add(' ITE_PRECOM = :ITE_PRECOM,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_PREDOL = :ITE_PREDOL,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_DESF01 = :ITE_DESF01,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_DESF02 = :ITE_DESF02,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_DESF03 = :ITE_DESF03,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_DESF04 = :ITE_DESF04,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_DESF05 = :ITE_DESF05,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_DESF06 = :ITE_DESF06,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_PRECUS = :ITE_PRECUS,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_ICMENT = :ITE_ICMENT,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_SUBFED = :ITE_SUBFED,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_IPIENT = :ITE_IPIENT,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_FREENT = :ITE_FREENT,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_VALFRE = :ITE_VALFRE,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_ACRFIN = :ITE_ACRFIN,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_SUBSTI = :ITE_SUBSTI,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_DESADB = :ITE_DESADB,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_TCIFCU = :ITE_TCIFCU,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_TSCUST = :ITE_TSCUST,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_DEPICO = :ITE_DEPICO,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_DEICMS = :ITE_DEICMS,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_FATREG = :ITE_FATREG,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_OUTVAL = :ITE_OUTVAL,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_ICMSAI = :ITE_ICMSAI,');
      qryItegerDestinoUpdate.SQL.Add(' ITE_IMPFED = :ITE_IMPFED,');
      For i := 1 To 7 do
      begin
        qryItegerDestinoUpdate.SQL.Add(' ITE_MARBR'+i.toString+' = :ITE_MARBR'+i.toString+',');
        qryItegerDestinoUpdate.SQL.Add(' ITE_COMTB'+i.toString+' = :ITE_COMTB'+i.toString+',');
        qryItegerDestinoUpdate.SQL.Add(' ITE_PREVE'+i.toString+' = :ITE_PREVE'+i.toString+',');
      end;
      qryItegerDestinoUpdate.SQL.Add(' ITE_DESOPE = :ITE_DESOPE');
      qryItegerDestinoUpdate.SQL.Add(' WHERE ITE_CODITE = "' + edtCodPrD.Text + '"');
      qryItegerDestinoUpdate.SQL.Add('   AND ITE_CODEMP = :ITE_CODEMP');
      pgbProgresso.Properties.Max := qryItegerOrigem.RecordCount;
      while not qryItegerOrigem.Eof Do
      begin
        qryItegerDestinoUpdate.ParamByName('ITE_PRECOM').Value := qryItegerOrigem.FieldByName('ITE_PRECOM').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_PREDOL').Value := qryItegerOrigem.FieldByName('ITE_PREDOL').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_DESF01').Value := qryItegerOrigem.FieldByName('ITE_DESF01').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_DESF02').Value := qryItegerOrigem.FieldByName('ITE_DESF02').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_DESF03').Value := qryItegerOrigem.FieldByName('ITE_DESF03').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_DESF04').Value := qryItegerOrigem.FieldByName('ITE_DESF04').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_DESF05').Value := qryItegerOrigem.FieldByName('ITE_DESF05').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_DESF06').Value := qryItegerOrigem.FieldByName('ITE_DESF06').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_ICMENT').Value := qryItegerOrigem.FieldByName('ITE_ICMENT').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_SUBFED').Value := qryItegerOrigem.FieldByName('ITE_SUBFED').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_IPIENT').Value := qryItegerOrigem.FieldByName('ITE_IPIENT').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_FREENT').Value := qryItegerOrigem.FieldByName('ITE_FREENT').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_VALFRE').Value := qryItegerOrigem.FieldByName('ITE_VALFRE').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_ACRFIN').Value := qryItegerOrigem.FieldByName('ITE_ACRFIN').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_SUBSTI').Value := qryItegerOrigem.FieldByName('ITE_SUBSTI').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_DESADB').Value := qryItegerOrigem.FieldByName('ITE_DESADB').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_PRECUS').Value := qryItegerOrigem.FieldByName('ITE_PRECUS').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_TCIFCU').Value := qryItegerOrigem.FieldByName('ITE_TCIFCU').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_TSCUST').Value := qryItegerOrigem.FieldByName('ITE_TSCUST').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_DEPICO').Value := qryItegerOrigem.FieldByName('ITE_DEPICO').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_DEICMS').Value := qryItegerOrigem.FieldByName('ITE_DEICMS').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_FATREG').Value := qryItegerOrigem.FieldByName('ITE_FATREG').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_OUTVAL').Value := qryItegerOrigem.FieldByName('ITE_OUTVAL').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_ICMSAI').Value := qryItegerOrigem.FieldByName('ITE_ICMSAI').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_IMPFED').Value := qryItegerOrigem.FieldByName('ITE_IMPFED').Value;
        qryItegerDestinoUpdate.ParamByName('ITE_DESOPE').Value := qryItegerOrigem.FieldByName('ITE_DESOPE').Value;
        For i := 1 To 7 do
        begin
          qryItegerDestinoUpdate.ParamByName('ITE_MARBR' + i.toString).Value := qryItegerOrigem.FieldByName('ITE_MARBR' + i.toString).Value;
          qryItegerDestinoUpdate.ParamByName('ITE_PREVE' + i.toString).Value := qryItegerOrigem.FieldByName('ITE_PREVE' + i.toString).Value;
          qryItegerDestinoUpdate.ParamByName('ITE_COMTB' + i.toString).Value := qryItegerOrigem.FieldByName('ITE_COMTB' + i.toString).Value;
        End;
        qryItegerDestinoUpdate.ParamByName('ITE_CODEMP').Value := qryItegerOrigem.FieldByName('ITE_CODEMP').Value;

        qryItegerDestinoUpdate.ExecSQL;

        qryItegerOrigem.Next;
        pgbProgresso.Position := qryItegerOrigem.RecNO;
        Application.ProcessMessages;
      End;


      qryCadIte := fCriaQuery;
      Try
        qryCadIte.SQL.Text := 'SELECT ITE_CODGPR, ITE_DTAALT FROM CADITE WHERE ITE_CODITE = :CODITE';
        qryCadIte.ParamByName('CODITE').AsString := edtCodPrD.Text;
        qryCadIte.Open;

        If Not fEmptyStr(qryCadIte.FieldByName('ITE_CODGPR').AsString) Then
        begin
          qryItegerDestinoUpdate.SQL.Clear;
          qryItegerDestinoUpdate.SQL.Add(' UPDATE ITEGER D ');
          qryItegerDestinoUpdate.SQL.Add(' INNER JOIN ITEGER O ON O.ITE_CODITE = "'+edtCodPrD.Text+'" AND D.ITE_CODEMP = O.ITE_CODEMP ');
          qryItegerDestinoUpdate.SQL.Add(' INNER JOIN CADITE C ON C.ITE_CODITE = D.ITE_CODITE AND C.ITE_CODGPR = "'+qryCadIte.FieldByName('ITE_CODGPR').AsString+'"');
          qryItegerDestinoUpdate.SQL.Add('                    AND C.ITE_CODITE <> "'+edtCodPrD.Text+'"');
          qryItegerDestinoUpdate.SQL.Add(' SET ');
          qryItegerDestinoUpdate.SQL.Add('   C.ITE_DTAALT = CURDATE(),    ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_PRECOM = O.ITE_PRECOM, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_PREDOL = O.ITE_PREDOL, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_DESF01 = O.ITE_DESF01, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_DESF02 = O.ITE_DESF02, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_DESF03 = O.ITE_DESF03, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_DESF04 = O.ITE_DESF04, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_DESF05 = O.ITE_DESF05, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_DESF06 = O.ITE_DESF06, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_ICMENT = O.ITE_ICMENT, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_SUBFED = O.ITE_SUBFED, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_IPIENT = O.ITE_IPIENT, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_FREENT = O.ITE_FREENT, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_VALFRE = O.ITE_VALFRE, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_ACRFIN = O.ITE_ACRFIN, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_SUBSTI = O.ITE_SUBSTI, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_DESADB = O.ITE_DESADB, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_PRECUS = O.ITE_PRECUS, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_TCIFCU = O.ITE_TCIFCU, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_TSCUST = O.ITE_TSCUST, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_DEPICO = O.ITE_DEPICO, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_DEICMS = O.ITE_DEICMS, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_FATREG = O.ITE_FATREG, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_OUTVAL = O.ITE_OUTVAL, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_ICMSAI = O.ITE_ICMSAI, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_IMPFED = O.ITE_IMPFED, ');
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_DESOPE = O.ITE_DESOPE, ');
          For i := 1 To 7 do
          begin
            qryItegerDestinoUpdate.SQL.Add('   D.ITE_MARBR' + i.toString + ' = O.ITE_MARBR' + i.toString + ', ');
            qryItegerDestinoUpdate.SQL.Add('   D.ITE_COMTB' + i.toString + ' = O.ITE_COMTB' + i.toString + ', ');
            qryItegerDestinoUpdate.SQL.Add('   D.ITE_PREVE' + i.toString + ' = O.ITE_PREVE' + i.toString + ', ');
          end;
          qryItegerDestinoUpdate.SQL.Add('   D.ITE_DESOPE = O.ITE_DESOPE; ');
          qryItegerDestinoUpdate.ExecSQL;
        end;
      Finally
        FreeAndNil(qryCadIte);
      End;
    Finally
      FreeAndNil(qryItegerOrigem);
      FreeAndNil(qryItegerDestinoUpdate);
    End;
  Except
    on e: Exception do
    begin
      pMensagensErro(e.message, 'TfrmTransfCodProduto.fTransferePrecosParaDestinoAux');
      Result := false;
    end;
  End;
end;

function TfrmTransfCodProduto.fTransferePrecosParaDestino: Boolean;
  Var
    LfrmGravando: TfrmGravando;
Begin
  Try
    pCriarFormularios(TfrmGravando, LfrmGravando);
    LfrmGravando.fExecutarAcao := fTransferePrecosParaDestinoAux;
    LfrmGravando.lblGravando.Caption := 'Copiando preços...';
    LfrmGravando.ShowModal;
    Result := LfrmGravando.blnConfirma;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmTransfCodProduto.pTratarDigEle(strProOri, strProDes: String);
  Var
    qryConsulta: TUniQuery;
    qrySQL: TUniQuery;
    Const cDelete = 'DELETE FROM DIGELE WHERE AUTOINCREM = :AUTINC';

          cUpdate = 'UPDATE DIGELE SET DIG_QTDITE = DIG_QTDITE + :QTDITE WHERE AUTOINCREM = :AUTINC';
begin
  qryConsulta := fCriaQuery;
  qrySQL := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT ORI.AUTOINCREM CHAVEORI,');
    qryConsulta.SQL.Add('       DES.AUTOINCREM CHAVEDES,');
    qryConsulta.SQL.Add('       ORI.DIG_QTDITE AS QTDORI,');
    qryConsulta.SQL.Add('       DES.DIG_QTDITE AS QTDDES');
    qryConsulta.SQL.Add('  FROM DIGELE ORI,');
    qryConsulta.SQL.Add('       (SELECT AUTOINCREM, DIG_IDEDIG, DIG_CODEMP, DIG_QTDITE  FROM DIGELE');
    qryConsulta.SQL.Add('         WHERE DIG_CODITE = '+ QuotedStr(strProDes) +') DES');
    qryConsulta.SQL.Add(' WHERE DES.DIG_IDEDIG = ORI.DIG_IDEDIG');
    qryConsulta.SQL.Add('   AND DES.DIG_CODEMP = ORI.DIG_CODEMP');
    qryConsulta.SQL.Add('   AND ORI.DIG_CODITE = '+ QuotedStr(strProOri));

    qryConsulta.Open;

    If qryConsulta.IsEmpty Then
      Exit;


    While Not qryConsulta.Eof Do
    Begin
      qrySQL.SQL.Text := cUpdate;
      qrySQL.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('CHAVEDES').AsString;
      qrySQL.ParamByName('QTDITE').AsFloat := qryConsulta.FieldByName('QTDORI').AsFloat;

      qrySQL.ExecSQL;

      qrySQL.SQL.Text := cDelete;
      qrySQL.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('CHAVEORI').AsString;
      qrySQL.ExecSQL;

      qryConsulta.Next;
    End;

  Finally
    FreeAndNil(qryConsulta);
    FreeAndNil(qrySQL)
  End;
end;

procedure TfrmTransfCodProduto.pTratarPROBRI_ITE(strProOri: String);
var qrySQL: TUniQuery;
begin
  qrySQL := fCriaQuery;
  Try
    qrySQL.SQL.Text := 'DELETE FROM PROBRI_ITE WHERE PRO_CODITE = "' + strProOri + '"';
    qrySQL.ExecSQL;
  Finally
    FreeAndNil(qrySQL)
  End;
end;

end.

