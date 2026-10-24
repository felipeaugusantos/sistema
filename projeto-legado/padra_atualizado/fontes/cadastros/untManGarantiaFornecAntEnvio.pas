unit untManGarantiaFornecAntEnvio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, Mask, MaskEditFocus, EditFocus, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView, Uni,
  cxGridDBTableView, cxGrid, UniClientDataSet, untGarant, untFuncoesSimples,
  cxLookAndFeels, cxLookAndFeelPainters, untTypesSistema, untCadLote, cxNavigator, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, untTLock,
  cxCurrencyEdit;

type
  TfrmManGarantiaFornecAntEnvio = class(TfrmPai)
    pnlDados: TPanel;
    Label1: TLabel;
    edtNomFor: TEditFocus;
    edtCodFor: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    edtDescProd: TEditFocus;
    edtRefere: TEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    cxDadosGrid1DBTableView1: TcxGridDBTableView;
    cxDadosGrid1Level1: TcxGridLevel;
    cxDados: TcxGrid;
    cdsDados: TUniClientDataSet;
    dtsDados: TDataSource;
    cdsDadosNUMENT: TStringField;
    cdsDadosCODITE: TStringField;
    cdsDadosCODFAB: TStringField;
    cdsDadosDESITE: TStringField;
    cdsDadosREFERE: TStringField;
    cdsDadosSIGUNI: TStringField;
    cdsDadosCODFOR: TStringField;
    cdsDadosNOMFOR: TStringField;
    cdsDadosDTAENT: TStringField;
    cdsDadosQTDITE: TFloatField;
    NUMENT: TcxGridDBColumn;
    CODITE: TcxGridDBColumn;
    CODFAB: TcxGridDBColumn;
    DESITE: TcxGridDBColumn;
    REFERE: TcxGridDBColumn;
    SIGUNI: TcxGridDBColumn;
    NOMFOR: TcxGridDBColumn;
    DTAENT: TcxGridDBColumn;
    QTDITE: TcxGridDBColumn;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    cdsDadosMARCA: TStringField;
    shpMultSel: TShape;
    Panel1: TPanel;
    grbLegenda: TGroupBox;
    Shape2: TShape;
    Label9: TLabel;
    MARCA: TcxGridDBColumn;
    cdsDadosNUMDOC: TStringField;
    cdsDadosESPDOC: TStringField;
    cdsDadosEMPDOC: TStringField;
    cdsDadosREPOST: TStringField;
    cdsDadosVALITE: TCurrencyField;
    cdsDadosQTDDEV: TFloatField;
    cdsDadosOBSP_1: TStringField;
    cdsDadosOBSP_2: TStringField;
    cdsDadosAUTINC: TStringField;
    cdsDadosCODEMP: TStringField;
    cdsDadosGARFIL: TStringField;
    cdsDadosUC_FORNEC: TStringField;
    cdsDadosUC_DTAENT: TDateField;
    cdsDadosUC_QTDITE: TFloatField;
    UC_FORNEC: TcxGridDBColumn;
    UC_DTAENT: TcxGridDBColumn;
    UC_QTDITE: TcxGridDBColumn;
    DOCVENDA: TcxGridDBColumn;
    EMPDOC: TcxGridDBColumn;
    cdsDadosDOCVENDA: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure cxDadosGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure cxDadosGrid1DBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxDadosGrid1DBTableView1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    objMovGag: TMovGag;
    objCadLot: TCadLot;

    arrFornecedor,
    arrMarca,
    arrLinhaGrupo: TConsultasArray;

    objLock : TLock;
    procedure pPreencheDadosGrid(qryDados: TUniQuery);

    procedure pLimpaTela;
    procedure pSelecionaProduto(pTag: Integer; blnTodos: Boolean = False);

    function fConfirma(strCodForNew: String): Boolean;
    function fVerificaLoteProduto(strNumLot: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

implementation

uses untConsultas, untFuncoesConsulta, untDigFornecedor;

{$R *.dfm}

{ TfrmManGarantiaFornecAntEnvio }

procedure TfrmManGarantiaFornecAntEnvio.btnConfirmarClick(Sender: TObject);
  Var
    frmDigFornecedor: TfrmDigFornecedor;
    bkmMarca: TBookmark;
    blnOK   : Boolean;
begin
  inherited;

  blnOK := False;

  If fMensagem('', 'Confirma a troca do fornecedor nos produtos selecionados?', ['&Sim', '&Não']) = 2 Then
    Exit;

  bkmMarca := cdsDados.GetBookmark;
  cdsDados.DisableControls;

  If Not cdsDados.Locate('MARCA', 'S', []) Then
  Begin
    fMensagem('', 'Marque pelo menos um item para realizar a alteração do fornecedor!', ['&O K']);

    cdsDados.GotoBookmark(bkmMarca);
    cdsDados.FreeBookmark(bkmMarca);
    cdsDados.EnableControls;
    Exit;
  End;

  pCriarFormularios(TfrmDigFornecedor, frmDigFornecedor);

  If frmDigFornecedor.ShowModal = mrOk Then
  Begin
    Try
      If fConfirma(frmDigFornecedor.edtCodFor.Text) Then
      Begin
        fMensagem('', 'Dados atualizados com sucesso!', ['&O K']);
        blnOK := True;
      End;
    Except
      On E: Exception Do
      Begin
			  pMensagensErro(E.Message,'[TfrmManGarantiaFornecAntEnvio.btnConfirmarClick]');
      End;
    End;

  End
  Else
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar um fornecedor para continuar a operação!', ['&O K']);
  End;

  cdsDados.GotoBookmark(bkmMarca);
  cdsDados.FreeBookmark(bkmMarca);
  cdsDados.EnableControls;

  pFreeAndNil(frmDigFornecedor);

  If blnOK Then
    pLimpaTela;
end;

procedure TfrmManGarantiaFornecAntEnvio.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;

  pSelecionaProduto(0, True);
end;

procedure TfrmManGarantiaFornecAntEnvio.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;

  pSelecionaProduto(1, True);
end;

procedure TfrmManGarantiaFornecAntEnvio.cxDadosGrid1DBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  With cdsDados Do
  Begin
    If Not Active Then
      Exit;

    If IfNull(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, MARCA.Index],'N') = 'S' Then
      ACanvas.Font.Color := clGreen;
  end;
end;

procedure TfrmManGarantiaFornecAntEnvio.cxDadosGrid1DBTableView1DblClick(
  Sender: TObject);
begin
  inherited;

  If Not (cdsDados.IsEmpty) Then
  Begin
    If cdsDadosMARCA.AsString = 'S' Then
      pSelecionaProduto(0)
    Else
      pSelecionaProduto(1);
  End;
end;

procedure TfrmManGarantiaFornecAntEnvio.cxDadosGrid1DBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    If Not (cdsDados.IsEmpty) Then
    Begin
      If cdsDadosMARCA.AsString = 'S' Then
        pSelecionaProduto(0)
      Else
        pSelecionaProduto(1);
    End;
  End
  Else If Key = VK_ESCAPE Then
    pLimpaTela;
end;

procedure TfrmManGarantiaFornecAntEnvio.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor,edtNomFor,arrFornecedor,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmManGarantiaFornecAntEnvio.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornecedor, False) Then
  Begin
    fValidaCampos(edtCodFor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManGarantiaFornecAntEnvio.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar,edtDesMar,arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmManGarantiaFornecAntEnvio.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmManGarantiaFornecAntEnvio.fConfirma(strCodForNew: String): Boolean;
  Var
    qryUpdate : TUniQuery;
begin
  Result := True;
  qryUpdate := fCriaQuery;
  With qryUpdate, SQL Do
  Begin
    Close;
    Clear;
    Add(' UPDATE MOVGAD SET GAD_CODFOR = :CODFOR WHERE AUTOINCREM = :AUTINC ');
    ParamByName('CODFOR').AsString := strCodForNew;
  End;

  Try
    With cdsDados Do
    Begin
      First;

      fStartTransaction;

      While Not Eof Do
      Begin
        If FieldByName('MARCA').AsString = 'S' Then
        Begin
          qryUpdate.ParamByName('AUTINC').AsString := FieldByName('AUTINC').AsString;
          qryUpdate.ExecSQL;
        End;

        Next;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[TfrmManGarantiaFornecAntEnvio.fConfirma]');
    End;
  End;

  FreeAndNil(qryUpdate);

  If Result Then
    fCommit;
end;

procedure TfrmManGarantiaFornecAntEnvio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  objLock.pDestravarTodos;
end;

procedure TfrmManGarantiaFornecAntEnvio.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(cdsDadosCODITE);
  cdsDados.FieldDefs[1].Size := fTamCodIte;
  objMovGag := TMovGag.Create(Self);
  objCadLot := TCadLot.Create(Self);
  cdsDados.CreateDataSet;
  objLock := TLock.Create;

end;

procedure TfrmManGarantiaFornecAntEnvio.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objCadLot);
  FreeAndNil(objMovGag);
  inherited;
end;

procedure TfrmManGarantiaFornecAntEnvio.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_F8 Then
    btnMarcarTodos.Click
  Else If Key = VK_F9 Then
    btnDesmarcarTodos.Click
  Else If Key = VK_F10 Then
    btnConfirmar.Click;
end;

function TfrmManGarantiaFornecAntEnvio.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
  Var
    qryDados: TUniQuery;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = edtCodFor) Then
    Begin
      pDesmarcaLista(edtCodFor,arrFornecedor);
    End
    Else If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar,arrMarca);
    End
    Else If (Sender = mskLinhaGrupo) Then
    Begin
      pDesmarcaLista(mskLinhaGrupo,arrLinhaGrupo, '', 6);
    End
    Else If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
            blnMudarFoco := False;
            Result := False;

            pSetFocus(mskDtaIni);
          End;
        End;
      End;

      If (Sender = mskDtaFin) And (Result) Then
      Begin
        If objMovGag.objMovGad.fCarregaProdutosNaoEnviadoFornec(edtDescProd.Text,
                                                                edtRefere.Text,
                                                                mskDtaIni.Text,
                                                                mskDtaFin.Text,
                                                                edtCodFor,
                                                                edtCodMar,
                                                                mskLinhaGrupo,
                                                                arrFornecedor,
                                                                arrMarca,
                                                                arrLinhaGrupo,
                                                                qryDados) Then
        Begin
          pPreencheDadosGrid(qryDados);
        End
        Else
        Begin
          fMensagem('','Itens para envio da garantia ao fornecedor não encontrados!',['&O K']);
          blnMudarFoco := False;
          Result := False;

          pSetFocus(edtCodFor);
        End;

        FreeAndNil(qryDados);
      End;

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmManGarantiaFornecAntEnvio.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmManGarantiaFornecAntEnvio.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinhaGrupo, False) Then
  Begin
    fValidaCampos(mskLinhaGrupo,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManGarantiaFornecAntEnvio.pLimpaTela;
  Var
    intIdx: Integer;
begin
  cdsDados.EmptyDataSet;

  For intIdx := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intIdx] Is TEditFocus Then
      (Self.Components[intIdx] As TEditFocus).Clear;

    If Self.Components[intIdx] Is TMaskEditFocus Then
      (Self.Components[intIdx] As TMaskEditFocus).Clear;
  End;

  pnlDados.Enabled          := True;
  btnConfirmar.Enabled      := False;
  btnMarcarTodos.Enabled    := False;
  btnDesmarcarTodos.Enabled := False;

  pSetFocus(edtCodFor);
  objLock.pDestravarTodos;

end;

procedure TfrmManGarantiaFornecAntEnvio.pPreencheDadosGrid(qryDados: TUniQuery);
begin
  With qryDados Do
  Begin
    First;

    cdsDados.EmptyDataSet;

    While Not Eof Do
    Begin
      cdsDados.Append;
      cdsDadosNUMENT.AsString   := FieldByName('NUMENT').AsString;
      cdsDadosCODITE.AsString   := FieldByName('CODITE').AsString;
      cdsDadosCODFAB.AsString   := FieldByName('CODFAB').AsString;
      cdsDadosDESITE.AsString   := FieldByName('DESITE').AsString;
      cdsDadosREFERE.AsString   := FieldByName('REFERE').AsString;
      cdsDadosSIGUNI.AsString   := FieldByName('SIGUNI').AsString;
      cdsDadosCODFOR.AsString   := FieldByName('CODFOR').AsString;
      cdsDadosNOMFOR.AsString   := FieldByName('CODFOR').AsString + ' - ' + FieldByName('NOMFOR').AsString;
      cdsDadosDTAENT.AsString   := FormatDateTime('dd/mm/yyyy', FieldByName('DTAENT').AsDateTime);
      cdsDadosQTDITE.AsFloat    := FieldByName('QTDREQ').AsFloat;
      cdsDadosNUMDOC.AsString   := FieldByName('NUMDOC').AsString;
      cdsDadosESPDOC.AsString   := FieldByName('ESPDOC').AsString;
      cdsDadosEMPDOC.AsString   := FieldByName('EMPDOC').AsString;
      cdsDadosREPOST.AsString   := FieldByName('REPOST').AsString;
      cdsDadosVALITE.AsCurrency := FieldByName('VALITE').AsCurrency;
      cdsDadosQTDDEV.AsFloat    := FieldByName('QTDDEV').AsFloat;
      cdsDadosOBSP_1.AsString   := FieldByName('OBSP_1').AsString;
      cdsDadosOBSP_2.AsString   := FieldByName('OBSP_2').AsString;
      cdsDadosAUTINC.AsString   := FieldByName('AUTINC').AsString;
      cdsDadosCODEMP.AsString   := FieldByName('CODEMP').AsString;
      cdsDadosGARFIL.AsString   := FieldByName('GARFIL').AsString;
      cdsDadosDOCVENDA.AsString := cdsDadosNUMDOC.AsString + '-' + cdsDadosESPDOC.AsString;
      cdsDadosUC_FORNEC.AsString    := FieldByName('UC_FORNEC').AsString;
      cdsDadosUC_DTAENT.AsDateTime  := FieldByName('UC_DTAENT').AsDateTime;
      cdsDadosUC_QTDITE.AsFloat     := FieldByname('UC_QTDITE').AsFloat;
      cdsDados.Post;

      Next;
    End;

    cdsDados.First;
  End;

  pnlDados.Enabled          := False;
  btnConfirmar.Enabled      := True;
  btnMarcarTodos.Enabled    := True;
  btnDesmarcarTodos.Enabled := True;
end;

function TfrmManGarantiaFornecAntEnvio.fVerificaLoteProduto(strNumLot: String): Boolean;
  Var
    blnLoteOK: Boolean;
    intResMen: Integer;
begin

  Result := False;
  With cdsDados Do
  Begin
    Repeat
      If (objCadLot.fExisteLote(FieldByName('CODITE').AsString, VS_strCodEmp, '', False, False)) And
         (Not objCadLot.fExisteLotePrincipalGarantia(FieldByName('CODITE').AsString, Vs_strCodEmp)) Then
      Begin
        intResMen := fMensagem('', 'O produto ' + FieldByName('CODITE').AsString + ' possui vinculo com ' + objCadLot.strTitImp + Chr(13) +
                                   'Favor informar um ' + objCadLot.strTitImp + ' principal para Recebimento de Garantia do Cliente! ' + Chr(13) +
                                   'Caminho: Principal -> Manutenção de Cadastros -> Produtos - ' + objCadLot.strTitImp + Chr(13) +
                                   'Pressione [ENTER] para continuar ou [ESC] para cancelar', ['&Continuar', 'C&ancelar'], 1, True);

        Case intResMen Of
          0,2 : blnLoteOK := True
        Else
          blnLoteOK := False;
        End;
      End
      Else If (objCadLot.fExisteLote(FieldByName('CODITE').AsString, VS_strCodEmp, '', False, False)) Then
      Begin
        Result    := True;
        blnLoteOK := True;
      End
      Else
      Begin
        Result := True;
        blnLoteOK := True;
      End;
    Until (blnLoteOK = True);
  End;
end;

procedure TfrmManGarantiaFornecAntEnvio.pSelecionaProduto(pTag: Integer;
  blnTodos: Boolean);
  Var
    BookMark: TBookMark;
begin
  BookMark := cdsDados.GetBookmark;
  cdsDados.DisableControls;

  With cdsDados Do
  Begin

    {*******************************************}
    {* MARCAR / DESMARCAR INDIVIDUAL           *}
    {****************************************FC*}

    If Not blnTodos Then
    Begin
      If fVerificaLoteProduto( FieldByName('CODITE').AsString ) Then
      Begin
        Edit;

        If FieldByName('MARCA').AsString = 'S' Then
        Begin
          FieldByName('MARCA').AsString := 'N';
          objLock.fLock_Unlock('GARANT_ENV_' + FieldByName('AUTINC').AsString,
                                               False, False );
        End
        Else
        Begin
          If Not objLock.fLock_Unlock('GARANT_ENV_' + FieldByName('AUTINC').AsString,
                                                  True, False) Then
          Begin

            fMensagem('', 'O Documento ' + FieldByName('NUMENT').AsString  +
                                           FieldByName('CODITE').AsString + ' está sendo utilizado em Outra Estação por ' +

                    fGetHostLock('GARANT_ENV_' + FieldByName('AUTINC').AsString)  + '!', ['&Ok'])
          End
          Else
            FieldByName('MARCA').AsString := 'S';

        End;

        Post;
      End;
    End

    {*******************************************}
    {* MARCAR / DESMARCAR TODOS                *}
    {****************************************FC*}
    Else
    Begin
      First;

      While Not Eof Do
      Begin
        If fVerificaLoteProduto( FieldByName('CODITE').AsString ) Then
        Begin
          Edit;

          If pTag = 1 Then
            FieldByName('MARCA').AsString := 'S'
          Else If pTag = 0 Then
            FieldByName('MARCA').AsString := 'N';

          Post;
        End;
        Next;
      End;

    End;

  End;

  cdsDados.GotoBookmark(BookMark);
  cdsDados.FreeBookmark(BookMark);
  cdsDados.EnableControls;
end;

end.
