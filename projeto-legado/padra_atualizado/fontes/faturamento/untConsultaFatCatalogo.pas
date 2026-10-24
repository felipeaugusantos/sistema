unit untConsultaFatCatalogo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGridCitel, DBGrids, Mask, MaskEditFocus, EditFocus, DB, UniClientDataSet,
  UniDataSetProvider, Uni, BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, Vcl.DBCtrls, DBMemoFocus,untCadProdutos, untPreAlt_Trigger;

type
  TLastField = Record
    intIndCol : integer;
    ftyTipCam : TFieldType;
    strNomCam,
    strNomCol : String;
  End;

  TfrmConsultaFatCatalogo = class(TfrmPai)
    Panel1: TPanel;
    Label2: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    pnlPesquisa: TPanel;
    lblPesquisa: TLabel;
    edtNumero: TEditFocus;
    edtString: TEditFocus;
    edtValor: TEditFocus;
    dbgItens: TDBGridCitel;
    btnPesquisar: TBitBtnLocked;
    btnMudaOrdem: TBitBtnLocked;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    lblNomeCampo: TLabel;
    btnAtiva: TBitBtnLocked;
    btnIncluiItem: TBitBtnLocked;
    lblAltera: TLabel;
    btnAltera: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnPromocao: TBitBtnLocked;
    Shape1: TShape;
    Shape2: TShape;
    Label1: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBMemoFocus1: TDBMemoFocus;
    btnHeranca: TBitBtnLocked;
    Panel4: TPanel;
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure dbgItensTitleClick(Column: TColumn);
    procedure edtCodForEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAtivaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure cdsConsultaAfterInsert(DataSet: TDataSet);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgItensKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluiItemClick(Sender: TObject);
    procedure btnAlteraClick(Sender: TObject);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPromocaoClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure btnHerancaClick(Sender: TObject);
  private
    { Private declarations }
    frmCadProdutos : TfrmCadProdutos;
    blnMarNeg,
    blnPreMat: Boolean;
    qryConsulta : TUniQuery;


    function fAbreConsulta(blnLike: Boolean): Boolean;
    function fblnTeveAlteracao: Boolean;
    procedure pProximaOrdenacao;
    procedure pPegaProximaColuna;
    procedure pAbrePesquisa;
    procedure pLimpaPesquisa;
    procedure pMascaraValor;
    procedure pCarregaItem;

    function fRetOperador(ftyTipCam : TFieldType): String;
    function fVerificaItemJaCadastrado(strCodFor, strCodFab: String): String;
    function fValidaCodFabRepetidos(strCodFor: String): Boolean;

    Function fValidaMargemNegativa(strCodIte: String; dtsCatIte: TDataSet): Boolean;

    Function fTemMargemNegativa(dtsCatIte: TDataSet): Boolean;

    procedure pRecalculaValores;
    procedure pAtualizaTabelas(strCodIte: String);
    procedure fAtiva_Inativa_Item(strCodIte, strCodCat, strCodFor, strOpcao: String);
    function fVerificaItemAtivo(strCodFor, strCodFab: String): Boolean;
    procedure pGeraCodigoBarra(strCodIte, strCodCat, strCodFor: String);
    procedure pCamposEditaveis(blnPreMat: Boolean);
    function fValidaGrid : Boolean;
    procedure pControlGridFocus(dbgGrid: TDBGridCitel; Key: Word; NextControl: TWinControl);
    function fGetIndexByName(strFieldName: String): Integer;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  public
    { Public declarations }
    intRecNo : Integer;
    lflLastField : TLastField;
    blnEditar: Boolean;
    blnFlxProcessoTec: Boolean;
  end;


implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untFatCatalogoAlteraItem,
  untParCalculaPrecoCusto, untIteBar, untTConfiguracao, untPreAlt, untProdMargemNegativa,
  untZClient;

{$R *.dfm}

Const
  SET_OF_TYPES : Set of TFieldType = [ftString,ftWideString,ftDate,ftDateTime,ftInteger,ftLargeInt,ftWord,ftFloat];

procedure TfrmConsultaFatCatalogo.pMascaraValor;
  Var
    intIndex: integer;
Begin
  If Not cdsConsulta.IsEmpty Then
  Begin
    With dbgItens.Columns Do
    Begin
      For intIndex := 1 To Count - 1 Do
      Begin
        If Items[intIndex].Field.DataType = ftFloat Then
          (Items[intIndex].Field As TFloatField).DisplayFormat := '#0.00';
      End;
    End;
  End;
End;

function TfrmConsultaFatCatalogo.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  Try

    If (inherited fValidaCampos(Sender)) Then
    Begin
      If (Sender = edtCodFor) Then
      Begin
        If (fEmptyStr(edtCodFor.Text)) Then
        Begin
          btnAtiva.Enabled      := False;
          btnIncluiItem.Enabled := False;
          btnAltera.Enabled     := False;
          btnHeranca.Enabled    := False;
          btnExcluir.Enabled    := False;
          btnPromocao.Enabled   := False;
          fMensagem('ATENÇÃO!', 'O Código do Fornecedor deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          btnAtiva.Enabled      := True;
          btnIncluiItem.Enabled := True;
          btnAltera.Enabled     := True;
          btnHeranca.Enabled    := True;
          btnExcluir.Enabled    := True;
          btnPromocao.Enabled   := True;                            
          fAbreConsulta(True);
        End;

        blnMudarFoco := FALSE;  
      End;
    End;

  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmConsultaFatCatalogo.fValidaCampos]');
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmConsultaFatCatalogo.fRetOperador(ftyTipCam : TFieldType): String;
begin
  Case ftyTipCam Of
    ftString,
    ftWideString : Result := 'LIKE';
    ftDate,
    ftDateTime   : Result := 'DATE';
    Else           Result := '=';
  End;
end;

procedure TfrmConsultaFatCatalogo.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;

begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmConsultaFatCatalogo.edtCodForExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodFor.Text) Then
    edtNomFor.Clear
  Else
  Begin
    edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

    If Not fEmptyStr(edtNomFor.Text) Then
      fAbreConsulta(True)
    Else
    Begin
      fMensagem('AVISO','Código do Fornecedor não encontrado.', ['&O K']);
      edtCodFor.Clear;
      pSetFocus(edtCodFor);
    End;
  End;
end;

procedure TfrmConsultaFatCatalogo.dbgItensTitleClick(Column: TColumn);
begin
  inherited;
  pnlPesquisa.Visible := false;

  If Not cdsConsulta.IsEmpty Then
  With lflLastField Do
  Begin
    intIndCol := Column.Index;
    ftyTipCam := Column.Field.DataType;
    strNomCam := Column.Field.FieldName;
    strNomCol := Column.Title.Caption;
  End;
  fAbreConsulta(False);

end;

function TfrmConsultaFatCatalogo.fAbreConsulta(blnLike: Boolean): Boolean;
Begin

  Result := False;

  If Not fValidaCodFabRepetidos(edtCodFor.Text) Then
    Exit;

  Try

    With qryConsulta, Sql Do
    Begin

      Close;
      cdsConsulta.Close;
      Clear;

      Add('SELECT                                                      ');
      Add('  IF(CAT_DTAATI IS NULL, " ", "X") AS CAT_ATIVO,            ');

      Add('  IFNULL(IF(CAT_DTAATI IS NULL,                             ');
      Add('     0,                                                     ');
      Add('     (SELECT I.ITE_SALDOS                                   ');
      Add('      FROM CADITE C JOIN ITEGER I                           ');
      Add('        ON (C.ITE_CODITE = I.ITE_CODITE AND                 ');
      Add('            C.ITE_CODEMP = I.ITE_CODEMP AND                 ');
      Add('            I.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ') ');
      Add('      WHERE IFNULL(C.ITE_CODFAB, "") <> "" AND C.ITE_CODFAB = CAT_CODFAB AND                   ');
      Add('            C.ITE_CODFOR = CAT_CODFOR ORDER BY C.ITE_ITEATI DESC LIMIT 1) ), 0) AS CAT_QTDEST, ');

      Add('     IFNULL((SELECT C.ITE_ITEATI                            ');
      Add('      FROM CADITE C                                         ');
      Add('      WHERE IFNULL(C.ITE_CODFAB, "") <> "" AND C.ITE_CODFAB = CAT_CODFAB AND                   ');
      Add('            C.ITE_CODFOR = CAT_CODFOR ORDER BY C.ITE_ITEATI DESC LIMIT 1), "X") AS CAT_ATVINA, ');

      Add('     (SELECT U.UNI_SIGUNI                                   ');
      Add('      FROM CADUNI U                                         ');
      Add('      WHERE U.UNI_CODUNI = CAT_CODUNI) AS UNI_SIGUNI,       ');

      Add('  CT.AUTOINCREM, ');

      Add('  CAT_CODFOR, ');
      Add('  CAT_CODFAB, ');
      Add('  CAT_CODMAR, ');

      Add('  CAT_APLICA, ');
      Add('  CAST(CAT_APLICA AS CHAR(255)) AS APLICA, ');

      Add('  CAT_REFERE, ');

      Add('  CAT_CODBAR, ');
      Add('  CAT_BAREMB, ');
      Add('  CAT_DESITE, ');
      Add('  CAT_PREDOL, ');
      Add('  CAT_PRECOM, ');
      Add('  CAT_DESF01, ');
      Add('  CAT_DESF02, ');
      Add('  CAT_DESF03, ');
      Add('  CAT_DESF04, ');
      Add('  CAT_DESF05, ');
      Add('  CAT_DESF06, ');
      Add('  CAT_PRECUS, ');
      Add('  CAT_ICMENT, ');
      Add('  CAT_SUBFED, ');
      Add('  CAT_ICMSAI, ');
      Add('  CAT_IMPFED, ');
      Add('  CAT_DESOPE, ');
      Add('  CAT_OUTVAL, ');
      Add('  CAT_DESADB, ');
      Add('  CAT_VALFRE, ');
      Add('  CAT_IPIENT, ');
      Add('  CAT_FREENT, ');
      Add('  CAT_SUBSTI, ');
      Add('  CAT_ACRFIN, ');
      Add('  CAT_MARBR1, ');
      Add('  CAT_MARBR2, ');
      Add('  CAT_MARBR3, ');
      Add('  CAT_MARBR4, ');
      Add('  CAT_MARBR5, ');
      Add('  CAT_MARBR6, ');
      Add('  CAT_MARBR7, ');
      Add('  CAT_PREVE1, ');
      Add('  CAT_PREVE2, ');
      Add('  CAT_PREVE3, ');
      Add('  CAT_PREVE4, ');
      Add('  CAT_PREVE5, ');
      Add('  CAT_PREVE6, ');
      Add('  CAT_PREVE7, ');
      Add('  CAT_COMVAR, ');
      Add('  CAT_PESOIT, ');
      Add('  CAT_PESLIQ, ');
      Add('  CAT_EMBALA, ');
      Add('  CAT_CODUNI, ');
      Add('  CAT_CLAIPI, ');
      Add('  CAT_CPRCEN, ');
      Add('  CAT_ITEALT, ');
      Add('  CAT_HORALT, ');
      Add('  CAT_DTAALT, ');
      Add('  CAT_OPEALT, ');
      Add('  CAT_ITEPRO, ');
      Add('  CAT_PREORI, ');
      Add('  CAT_HORATI, ');
      Add('  CAT_DTAATI, ');
      Add('  CAT_OPEATI, ');
      Add('  CAT_CODABF, ');
      Add('  CAT_TCIFCU, ');
      Add('  CAT_TSCUST, ');
      Add('  CAT_DEPICO, ');
      Add('  CAT_DEICMS, ');
      Add('  CAT_FATREG, ');
      Add('  C.ITE_CODITE AS CAT_CODITE, ');
      Add('  C.ITE_CODGRU AS CAT_CODGRU, ');
      Add('  C.ITE_CODBAR AS ITE_CODBAR  ');
      Add('FROM           ');
      Add('  CATITE CT    ');
      Add('  LEFT JOIN  CADITE C ON IFNULL(C.ITE_CODFAB, "") <> "" AND C.ITE_CODFAB = CAT_CODFAB AND C.ITE_CODFOR = CAT_CODFOR ');
      Add('WHERE         ');
      Add('  CAT_CODFOR = :CODFOR ');

      if not fEmptyStr(edtCodFor.Text) Then
        ParamByName('CODFOR').AsString := edtCodFor.Text;

      If lflLastField.intIndCol <> -1 Then
      Begin
        If blnLike Then
        Begin
          IF lflLastField.strNomCam = 'APLICA' Then
            Add(' AND CAT_APLICA  LIKE  "%' + edtString.Text + '%"')
          Else
          Begin
          Case lflLastField.ftyTipCam Of
            ftString,
            ftWideString: Begin
                             If not fEmptyStr(Trim(edtString.Text)) Then
                               If lflLastField.strNomCam = 'CAT_CODITE' Then
                                 Add(' AND ITE_CODITE ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ')
                               Else
                                 Add(' AND ' + lflLastField.strNomCam +  '  ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ');
                          End;

            ftInteger,
              ftLargeInt,
              ftWord      : If StrToIntDef(Trim(edtNumero.Text),0) <> 0 Then
                              Add(' AND ' + lflLastField.strNomCam +  '  ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ');

              ftFloat     : If fStrToFloat(Trim(edtValor.Text)) <> 0 Then
                              Add(' AND ' + lflLastField.strNomCam +  '  ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ');
            End;
          End;
        End;

        Add(' ORDER BY ');
        Add(    lflLastField.strNomCam + ',');
        Add('  CAT_CODFAB');

      End;

      If blnLike Then
      Begin
        If Not (lflLastField.strNomCam = 'APLICA') Then
        Case lflLastField.ftyTipCam Of
          ftString,
          ftWideString: If not fEmptyStr(Trim(edtString.Text)) Then
                          ParamByName('CODPES').AsString  := edtString.Text + '%';

          ftInteger,
          ftLargeInt,
          ftWord      : If StrToIntDef(Trim(edtNumero.Text),0) <> 0 Then
                          ParamByName('CODPES').AsInteger := StrToIntDef(Trim(edtNumero.Text),0);

          ftFloat     : If fStrToFloat(Trim(edtValor.Text)) <> 0 Then
                          ParamByName('CODPES').AsFloat := fStrToFloat(Trim(edtValor.Text));

        End;
      End;

      Open;
      pSetaClient(qryConsulta);
      cdsConsulta.Open;

      pMascaraValor;


      With cdsConsulta Do
      Begin
        (FieldByName('CAT_DESF01') As TFloatField).DisplayFormat := '##0.0000';
        (FieldByName('CAT_DESF02') As TFloatField).DisplayFormat := '##0.0000';
        (FieldByName('CAT_DESF03') As TFloatField).DisplayFormat := '##0.0000';
        (FieldByName('CAT_DESF04') As TFloatField).DisplayFormat := '##0.0000';
        (FieldByName('CAT_DESF05') As TFloatField).DisplayFormat := '##0.0000';
        (FieldByName('CAT_DESF06') As TFloatField).DisplayFormat := '##0.0000';
        (FieldByName('CAT_QTDEST') As TFloatField).DisplayFormat := '##0.00';
        (FieldByName('CAT_CPRCEN') As TStringField).EditMask     := '>A;1; ';
      End;

      If Not pnlPesquisa.Visible Then
        pSetFocus(dbgItens);

      pSetFocus(dbgItens);

      if cdsConsulta.IsEmpty Then
         Exit;

      Result := True;
      with cdsConsulta do
      Begin
        FieldByName('CAT_CODITE').ProviderFlags := [];
        FieldByName('CAT_CODGRU').ProviderFlags := [];
        FieldByName('ITE_CODBAR').ProviderFlags := [];
        FieldByName('UNI_SIGUNI').ProviderFlags := [];
        FieldByName('CAT_ATVINA').ProviderFlags := [];
        FieldByName('CAT_QTDEST').ProviderFlags := [];
        FieldByName('CAT_ATIVO' ).ProviderFlags := [];
      end;
      with qryConsulta do
      Begin
        FieldByName('CAT_CODITE').ProviderFlags := [];
        FieldByName('CAT_CODGRU').ProviderFlags := [];
        FieldByName('ITE_CODBAR').ProviderFlags := [];
        FieldByName('UNI_SIGUNI').ProviderFlags := [];
        FieldByName('CAT_ATVINA').ProviderFlags := [];
        FieldByName('CAT_QTDEST').ProviderFlags := [];
        FieldByName('CAT_ATIVO' ).ProviderFlags := [];
      End;
    End;
  Except
    On E: Exception Do
    Begin
   			pMensagensErro(E.Message,'[TfrmConsultaFatCatalogo.fAbreConsulta]');
      Result := False;
    End;
  End;

End;

procedure TfrmConsultaFatCatalogo.edtCodForEnter(Sender: TObject);
begin
  inherited;
  If cdsConsulta.State in [dsInsert, dsEdit] Then
    cdsConsulta.Post;
  cdsConsulta.Close;
end;

procedure TfrmConsultaFatCatalogo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If cdsConsulta.State in [dsInsert, dsEdit] Then
    cdsConsulta.Post;
  cdsConsulta.Close;
end;

procedure TfrmConsultaFatCatalogo.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta := fCriaQuery(Self);
  dspConsulta.DataSet := qryConsulta;

  blnMarNeg := fCfgSis('MARNEG', varBoolean);

  lflLastField.intIndCol := 3;
  lflLastField.ftyTipCam := ftString;
  lflLastField.strNomCam := 'CAT_CODFAB';
  lflLastField.strNomCol := 'Código';

  dbgItens.Columns[7].Visible := fCfgSis('COTDOR', varBoolean);

  blnEditar := FALSE;
  blnPreMat := fPreMat;
end;

procedure TfrmConsultaFatCatalogo.FormDestroy(Sender: TObject);
begin
  qryConsulta.Close;
  FreeAndNil(qryConsulta);
  inherited;
end;

procedure TfrmConsultaFatCatalogo.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of

    VK_F3    : pProximaOrdenacao;

    VK_F4    : If btnHeranca.Enabled Then
                 btnHeranca.Click;

    VK_F5    : pAbrePesquisa;

    VK_F6    : If btnAtiva.Enabled Then
                 btnAtiva.Click;

    VK_F7    : If btnIncluiItem.Enabled And blnEditar Then
                 btnIncluiItem.Click;

    VK_F8    : If btnAltera.Enabled Then
                 btnAltera.Click;

    VK_F9    : If btnPromocao.Enabled Then
                 btnPromocao.Click;

    VK_DELETE: If (btnExcluir.Enabled) And (cdsConsulta.State = dsBrowse) Then
                  btnExcluir.Click;

    VK_RETURN: Begin
                 If pnlPesquisa.Visible And
                     ((edtNumero.Focused) Or
                      (edtString.Focused) Or
                      (edtValor.Focused)) Then
                 Begin
                   fAbreConsulta(True);
                   pSetFocus(pnlPesquisa);
                 End
                 Else
                 Begin

                   If (dbgItens.Focused) And (cdsConsulta.Active) Then
                   Begin
                     If (cdsConsulta.State = dsEdit) Then
                     Begin
                       cdsConsulta.Post;
                       cdsConsulta.Next;
                       dbgItens.SelectedField.FocusControl;
                     End
                     Else
                     Begin
                       cdsConsulta.Edit;
                       dbgItens.SelectedField := dbgItens.SelectedField;
                 End;
                   End;

               End;

               End;

    VK_ESCAPE: Begin
                 If cdsConsulta.State in [dsInsert, dsEdit] Then
                 Begin
                   cdsConsulta.Cancel;
                   Exit;
                 End

                 Else If pnlPesquisa.Visible Then
                 Begin
                   pLimpaPesquisa;
                   pSetFocus(dbgItens);
                   Abort;
                 End Else

                 If cdsConsulta.Active Then
                 Begin
                   pSetFocus(edtCodFor);
                   Exit;
                 End

                 Else Close;
               End;
  Else         inherited;

  End;

end;

procedure TfrmConsultaFatCatalogo.FormResize(Sender: TObject);
begin
  inherited;
  btnSair.Left := pnlBotoes.ClientWidth - btnSair.Width - 3;
end;

procedure TfrmConsultaFatCatalogo.pProximaOrdenacao;
Begin
  If cdsConsulta.State in [dsInsert, dsEdit] Then
    cdsConsulta.Post;

  pnlPesquisa.Visible := false;

  If Not cdsConsulta.Active Then
    lflLastField.intIndCol := -1
  Else
    pPegaProximaColuna;

  fAbreConsulta(False);
End;

procedure TfrmConsultaFatCatalogo.pPegaProximaColuna;
  Var
    intIndex: integer;
    intCount: integer;
Begin
  intCount := 0;
  intIndex := lflLastField.intIndCol;

    If cdsConsulta.Active Then
    Repeat
      inc(intIndex);
      If intIndex > dbgItens.Columns.Count - 1 Then
        intIndex := 0;
      inc(intCount);

      If dbgItens.Columns.Items[intIndex].Visible And
        (dbgItens.Columns.Items[intIndex].Field.DataType In SET_OF_TYPES) Then
      With lflLastField Do
      Begin
        intIndCol := intIndex;
        ftyTipCam := dbgItens.Columns.Items[intIndex].Field.DataType;
        strNomCam := dbgItens.Columns.Items[intIndex].Field.FieldName;
        strNomCol := dbgItens.Columns.Items[intIndex].Title.Caption;

        exit;
      End;
    Until (intCount > dbgItens.Columns.Count);
End;

procedure TfrmConsultaFatCatalogo.pAbrePesquisa;
Begin
  If cdsConsulta.State in [dsInsert, dsEdit] Then
    cdsConsulta.Post;

  If lflLastField.intIndCol = -1 Then
    pPegaProximaColuna;

  If (lflLastField.intIndCol > -1) Then
  Begin
    If lflLastField.ftyTipCam in SET_OF_TYPES Then
    Begin

      lblNomeCampo.Caption := lflLastField.strNomCol + ':';

      pnlPesquisa.Visible  := True;

      Case lflLastField.ftyTipCam Of
        ftString,
        ftWideString: Begin
                       edtString.Left           := lblNomeCampo.Left + lblNomeCampo.Width + 2;
                       edtString.Visible        := True;
                       edtNumero.Visible        := False;
                       edtValor.Visible         := False;
                       pSetFocus(edtString);
                       lblPesquisa.FocusControl := edtString;
                     End;
        ftInteger,
        ftLargeInt,
        ftWord     : Begin
                       edtNumero.Left    := lblNomeCampo.Left + lblNomeCampo.Width + 2;
                       edtString.Visible := False;
                       edtNumero.Visible := True;
                       edtValor.Visible  := False;
                       pSetFocus(edtNumero);
                       lblPesquisa.FocusControl := edtNumero;
                     End;
        ftFloat     : Begin
                       edtValor.Left            := lblNomeCampo.Left + lblNomeCampo.Width + 2;
                       edtString.Visible        := False;
                       edtNumero.Visible        := False;
                       edtValor.Visible         := True;
                       pSetFocus(edtValor);
                       lblPesquisa.FocusControl := edtValor;
                     End;
      End;
    End
    Else
      fMensagem('', 'Somente campos do tipo texto, numérico ou valor podem ser pesquisados.', ['&O k']);
  End
  Else
    fMensagem('', 'Escolha um campo de ordenação clicando no título de uma coluna.', ['&O k']);
End;

procedure TfrmConsultaFatCatalogo.pLimpaPesquisa;
begin
  pnlPesquisa.Visible := False;
  edtNumero.Clear;
  edtString.Clear;
  edtValor.Clear;
  fAbreConsulta(True);
End;

procedure TfrmConsultaFatCatalogo.btnMudaOrdemClick(Sender: TObject);
begin
  inherited;
  pProximaOrdenacao;
end;

procedure TfrmConsultaFatCatalogo.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  pAbrePesquisa;
end;

procedure TfrmConsultaFatCatalogo.pCamposEditaveis(blnPreMat: Boolean);
  Var
    strAux: String;
    idx: Integer;
begin
  strAux := '';
  strAux := strAux + '_CAT_PRECOM';
  strAux := strAux + '_CAT_DESF01';
  strAux := strAux + '_CAT_DESF02';
  strAux := strAux + '_CAT_DESF03';
  strAux := strAux + '_CAT_DESF04';
  strAux := strAux + '_CAT_DESF05';
  strAux := strAux + '_CAT_DESF06';
  strAux := strAux + '_CAT_ICMENT';
  strAux := strAux + '_CAT_SUBFED';
  strAux := strAux + '_CAT_ICMSAI';
  strAux := strAux + '_CAT_IMPFED';
  strAux := strAux + '_CAT_DESOPE';
  strAux := strAux + '_CAT_OUTVAL';
  strAux := strAux + '_CAT_IPIENT';
  strAux := strAux + '_CAT_FREENT';
  strAux := strAux + '_CAT_ACRFIN';
  strAux := strAux + '_CAT_SUBSTI';
  strAux := strAux + '_CAT_PREORI';
  strAux := strAux + '_CAT_PESOIT';
  strAux := strAux + '_CAT_PESLIQ';
  strAux := strAux + '_CAT_COMVAR';
  strAux := strAux + '_CAT_DESADB';
  strAux := strAux + '_CAT_VALFRE';

  For idx := 1 To 7 Do
  Begin
    strAux := strAux + '_CAT_MARBR' + IntToStr(idx);
    strAux := strAux + '_CAT_PREVE' + IntToStr(idx);
  End;

  With dbgItens Do
  Begin
    For idx := 0 To dbgItens.Columns.Count - 1 Do
      If Pos(dbgItens.Columns[idx].FieldName, strAux) > 0 Then
      Begin
        dbgItens.Columns[idx].ReadOnly := blnPreMat;
      End;
  End;
end;

procedure TfrmConsultaFatCatalogo.pCarregaItem;
Begin
  frmCadProdutos.pCarregaItemCatalogo(VS_strCodEmp,
                                      cdsConsulta.FieldByName('CAT_DESITE').AsString,
                                      cdsConsulta.FieldByName('CAT_CODFAB').AsString,
                                      edtCodFor.Text,
                                      edtNomFor.Text,
                                      cdsConsulta.FieldByName('CAT_PRECOM').AsFloat,
                                      cdsConsulta.FieldByName('CAT_PRECUS').AsFloat,
                                      cdsConsulta.FieldByName('CAT_PREVE1').AsFloat,
                                      cdsConsulta.FieldByName('CAT_PREVE2').AsFloat,
                                      cdsConsulta.FieldByName('CAT_PREVE3').AsFloat,
                                      cdsConsulta.FieldByName('CAT_PREVE4').AsFloat,
                                      cdsConsulta.FieldByName('CAT_PREVE5').AsFloat,
                                      cdsConsulta.FieldByName('CAT_PREVE6').AsFloat,
                                      cdsConsulta.FieldByName('CAT_PREVE7').AsFloat,
                                      cdsConsulta.FieldByName('CAT_DESF01').AsFloat,
                                      cdsConsulta.FieldByName('CAT_DESF02').AsFloat,
                                      cdsConsulta.FieldByName('CAT_DESF03').AsFloat,
                                      cdsConsulta.FieldByName('CAT_DESF04').AsFloat,
                                      cdsConsulta.FieldByName('CAT_DESF05').AsFloat,
                                      cdsConsulta.FieldByName('CAT_DESF06').AsFloat,
                                      cdsConsulta.FieldByName('CAT_IPIENT').AsFloat,
                                      cdsConsulta.FieldByName('CAT_FREENT').AsFloat,
                                      cdsConsulta.FieldByName('CAT_ACRFIN').AsFloat,
                                      cdsConsulta.FieldByName('CAT_COMVAR').AsFloat,
                                      cdsConsulta.FieldByName('CAT_PESOIT').AsFloat,
                                      cdsConsulta.FieldByName('CAT_PESLIQ').AsFloat,
                                      cdsConsulta.FieldByName('CAT_EMBALA').AsFloat,
                                      cdsConsulta.FieldByName('CAT_CODUNI').AsString,
                                      cdsConsulta.FieldByName('CAT_CLAIPI').AsString,
                                      cdsConsulta.FieldByName('CAT_CPRCEN').AsString,
                                      cdsConsulta.FieldByName('CAT_MARBR1').AsFloat,
                                      cdsConsulta.FieldByName('CAT_MARBR2').AsFloat,
                                      cdsConsulta.FieldByName('CAT_MARBR3').AsFloat,
                                      cdsConsulta.FieldByName('CAT_MARBR4').AsFloat,
                                      cdsConsulta.FieldByName('CAT_MARBR5').AsFloat,
                                      cdsConsulta.FieldByName('CAT_MARBR6').AsFloat,
                                      cdsConsulta.FieldByName('CAT_MARBR7').AsFloat,
                                      cdsConsulta.FieldByName('CAT_ICMENT').AsFloat,
                                      cdsConsulta.FieldByName('CAT_SUBFED').AsFloat,
                                      cdsConsulta.FieldByName('CAT_ICMSAI').AsFloat,
                                      cdsConsulta.FieldByName('CAT_SUBSTI').AsFloat,
                                      cdsConsulta.FieldByName('CAT_DESADB').AsFloat,
                                      cdsConsulta.FieldByName('CAT_VALFRE').AsFloat,
                                      cdsConsulta.FieldByName('CAT_OUTVAL').AsFloat,
                                      cdsConsulta.FieldByName('CAT_IMPFED').AsFloat,
                                      cdsConsulta.FieldByName('CAT_DESOPE').AsFloat,
                                      cdsConsulta.FieldByName('CAT_CODABF').AsString,
                                      cdsConsulta.FieldByName('CAT_CODMAR').AsString,
                                      cdsConsulta.FieldByName('CAT_CODBAR').AsString,
                                      cdsConsulta.FieldByName('CAT_BAREMB').AsString,
                                      cdsConsulta.FieldByName('CAT_REFERE').AsString,
                                      cdsConsulta.FieldByName('CAT_APLICA').AsString,
                                      cdsConsulta.FieldByName('CAT_PREDOL').AsString = 'S',
                                      cdsConsulta.FieldByName('CAT_TCIFCU').AsFloat,
                                      cdsConsulta.FieldByName('CAT_TSCUST').AsFloat,
                                      cdsConsulta.FieldByName('CAT_DEPICO').AsFloat,
                                      cdsConsulta.FieldByName('CAT_DEICMS').AsFloat,
                                      cdsConsulta.FieldByName('CAT_FATREG').AsFloat);
end;

procedure TfrmConsultaFatCatalogo.btnAtivaClick(Sender: TObject);
  Var
    strCodIte : String;
    strCodFab : String;
begin
  inherited;

  If (Not cdsConsulta.Active) Or (cdsConsulta.RecordCount <= 0) Then
  Begin
    fMensagem('ATENÇÃO', 'Nenhum item selecionado!' , ['&O k']);
    Exit;
  End;

  If blnPreMat Then
  Begin
    fMensagem('', 'Ativação de Produto permitido somente na Loja Matriz!', ['&Ok']);
    Exit;
  End;

  If fEmptyStr(cdsConsulta.FieldByName('CAT_ATIVO').AsString) Then
    If Not fValidaGrid Then
      Exit;

  If Not fVerificaAcessoSistema('ATVPRO',strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO', 'Usuário sem permissão para Ativar Produto!' , ['&O k']);
    Exit;
  End
  Else
  Begin
    {****************************************}
    {* VERIFICA SE O ITEM JÁ FOI CADASTRADO *}
    {*************************************LU*}
    strCodIte := fVerificaItemJaCadastrado(edtCodFor.Text, cdsConsulta.fieldbyname('CAT_CODFAB').AsString);

    {*************************************}
    {* CASO ELE JÁ TENHA SIDO CADASTRADO *}
    {**********************************LU*}
    If Not fEmptyStr(strCodIte) Then
    Begin
      {*****************************************************}
      {* SE ELE ESTIVER ATIVO, PERGUNTA SE QUER INATIVÁ-LO *}
      {**************************************************LU*}
      If cdsConsulta.FieldByName('CAT_ATIVO').AsString = 'X' Then
      Begin
        If fMensagem('AVISO', 'Item Ativo e já cadastrado. Código: ' + strCodIte + #13#10 +
                              'Deseja inativá-lo?', ['&Sim', '&Não']) = 1 Then
        Begin
          If cdsConsulta.FieldByName('CAT_QTDEST').AsFloat <= 0 Then
            fAtiva_Inativa_Item(strCodite, cdsConsulta.FieldByName('AUTOINCREM').AsString, edtCodFor.Text, 'I')
          Else
          Begin
            fMensagem('', 'O Estoque do item deve estar zerado para efetuar a inativação.', ['&O k']);
            Exit;
          End;
        End;
      End
      Else
      {*****************************************************}
      {* SE ELE NÃO ESTIVER ATIVO, PORÉM JÁ FOI CADASTRADO *}
      {**************************************************LU*}
      Begin
        If fMensagem('AVISO', 'Item Inativo, porém já cadastrado. Código: ' + strCodIte + #13#10 +
                              'Deseja reativá-lo?', ['&Sim', '&Não']) = 1 Then
        Begin
          fAtiva_Inativa_Item(strCodite, cdsConsulta.FieldByName('AUTOINCREM').AsString, edtCodFor.Text, 'A');

          {*******************************************************}
          {* GERAÇÃO DO CÓDIGO DE BARRAS NO CADASTRO DE PRODUTOS *}
          {****************************************************CI*}
          If (fEmptyStr(cdsConsulta.FieldByName('CAT_CODBAR').AsString)) Then
            pGeraCodigoBarra(strCodite, cdsConsulta.FieldByName('AUTOINCREM').AsString,edtCodFor.Text);

          {*****************************************************}
          {* NÃO ESTAVA ATUALIZANDO INFORMACOES DO ITEN QUANDO *}
          {* TROCAVA DE INATIVO PARA ATIVO                     *}
          {***************************************************LE}
          cdsConsulta.Edit;
          cdsConsulta.FieldByName('CAT_ATIVO').AsString := 'X';
          cdsConsulta.Post;
        End;
      End;

      strCodFab := cdsConsulta.FieldByName('CAT_CODFAB').AsString;
      fAbreConsulta(True);
      cdsConsulta.Locate('CAT_CODFAB',strCodFab,[]);

    End
    Else
    {********************************************************************}
    {* CASO ELE NÃO TENHA SIDO CADASTRADO - FAZ A ATIVAÇÃO E O CADASTRO *}
    {*****************************************************************LU*}
    Begin
      pCriarFormularios(TfrmCadProdutos, frmCadProdutos);
      frmCadProdutos.blnCatalogo := True;
      frmCadProdutos.pInsereItemCatalogo := pCarregaItem;
      frmCadProdutos.ShowModal;

      If frmCadProdutos.blnAtualizarCatAti Then
      Begin
        strCodFab := cdsConsulta.FieldByName('CAT_CODFAB').AsString;
        fAbreConsulta(True);
        cdsConsulta.Locate('CAT_CODFAB',strCodFab,[]);
      End;

      FreeAndNil(frmCadProdutos);
    End;
  End;

end;

procedure TfrmConsultaFatCatalogo.FormShow(Sender: TObject);
  Var
    intIndex: Integer;
    intIdxFld : Integer;
begin
  inherited;
  pSetFocus(edtCodFor);

  if not blnFlxProcessoTec then
  begin
    For intIndex := 1 To Length(VS_strTabVen) Do
    Begin
      If VS_strTabVen[intIndex] = 'S' Then
      Begin
        intIdxFld := fGetIndexByName('CAT_PREVE' + IntToStr(intIndex));
        If (intIdxFld >= 0) Then
        Begin
          dbgItens.Columns[intIdxFld].Visible := True;
          dbgItens.Columns[intIdxFld].Width := 82;
        End;

        intIdxFld := fGetIndexByName('CAT_MARBR' + IntToStr(intIndex));
        If (intIdxFld >= 0) Then
        Begin
          dbgItens.Columns[intIdxFld].Visible := True;
          dbgItens.Columns[intIdxFld].Width := 82;
        End;
      End;
    End;
  end
  else
  begin
    dbgItens.Columns[fGetIndexByName('CAT_PREVE1')].Visible := False;
    dbgItens.Columns[fGetIndexByName('CAT_PREORI')].Visible := False;
  end;

  If Not blnEditar Then
  Begin
    btnIncluiItem.Visible := False;
    btnAltera.Visible     := False;
    btnHeranca.Visible    := False;
    btnExcluir.Visible    := False;
    btnPromocao.Visible   := False;                
    lblAltera.Visible     := False;

    dbgItens.Options := dbgItens.Options - [dgEditing];
    dbgItens.Options := dbgItens.Options + [dgRowSelect];

    For intIndex := 0 To dbgItens.Columns.Count - 1 Do
      if (dbgItens.Columns[intIndex].FieldName <> 'CAT_ATIVO') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_CODFAB') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_CODITE') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_DESITE') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_PREVE1') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_PREVE2') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_PREVE3') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_PREVE4') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_PREVE5') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_PREVE6') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_PREVE7') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_PREORI') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_EMBALA') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_OPEATI') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_DTAATI') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_HORATI') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_PESOIT') And
         (dbgItens.Columns[intIndex].FieldName <> 'CAT_PESLIQ') And
         (dbgItens.Columns[intIndex].FieldName <> 'APLICA') Then
        dbgItens.Columns[intIndex].Visible := FALSE;

  End
  Else
    dbgItens.Options := dbgItens.Options - [dgRowSelect];

  If fCfgSis('PESLIQ') <> 'SOMA' Then
    fFindColumnByName(dbgItens, 'CAT_PESLIQ').Visible := False;

  fFindColumnByName(dbgItens, 'CAT_VALFRE').Title.Caption := fCfgSis('DESVFR');
  fFindColumnByName(dbgItens, 'CAT_DESADB').Title.Caption := fCfgSis('DESADI');
  fFindColumnByName(dbgItens, 'CAT_OUTVAL').Title.Caption := fCfgSis('DOVCPP');

  pCamposEditaveis(blnPreMat);
end;

procedure TfrmConsultaFatCatalogo.pGeraCodigoBarra(strCodIte, strCodCat, strCodFor: String);
Var
  strSQL, strCodBar: String;
  qryUpd: TUniQuery;
  objIteBar: TIteBar;
Begin

  Try
    fStartTransaction;

    qryUpd := fCriaQuery;

    If (fEmptyStr(cdsConsulta.FieldByName('ITE_CODBAR').AsString)) Then
    Begin
      If fCfgSis('TIPBAR') = '2' Then
        strCodBar := fGeraCodBarraEAN39(cdsConsulta.FieldByName('CAT_CODITE').AsString)
      Else
        strCodBar := fGeraCodBarraEAN13('1' + fStrZero(cdsConsulta.FieldByName('CAT_CODITE').AsString, 11));

      {*******************************}
      {* ATUALIZANDO - CADITE        *}
      {****************************LU*}
      strSQL := '';
      strSQL := strSQL + ' UPDATE ';
      strSQL := strSQL + '   CADITE ';
      strSQL := strSQL + ' SET ';
      strSQL := strSQL + '   ITE_CODBAR = :CODBAR ';
      strSQL := strSQL + ' WHERE                  ';
      strSQL := strSQL + '   ITE_CODITE = :CODITE AND ';
      strSQL := strSQL + '   ITE_CODFOR = :CODFOR ';

      With qryUpd Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('CODBAR').AsString := strCodBar;
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODFOR').AsString := strCodFor;

        ExecSQL;
      End;

      objIteBar := TIteBar.Create(opcOperacoes);

      objIteBar.pIncluiCodigoBarrasCatalogo(cdsConsulta.FieldByName('CAT_CODITE').AsString,
         strCodBar,
         cdsConsulta.FieldByName('CAT_BAREMB').AsString,
         cdsConsulta.FieldByName('CAT_EMBALA').AsFloat);

      objIteBar.cdsIteBar.ApplyUpdates(0);

      FreeAndNil(objIteBar);

      fAtualizaBarFabIte(strCodIte);
    End
    Else
      strCodBar := cdsConsulta.FieldByName('ITE_CODBAR').AsString;


    {*******************************}
    {* ATUALIZANDO - CATITE        *}
    {****************************LU*}
    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + '   CATITE ';
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '   CAT_OPEATI = :OPEATI, ';
    strSQL := strSQL + '   CAT_HORATI = :HORATI, ';
    strSQL := strSQL + '   CAT_DTAATI = :DTAATI,  ';
    strSQL := strSQL + '   CAT_CODBAR = :CODBAR  ';
    strSQL := strSQL + ' WHERE                   ';
    strSQL := strSQL + '   AUTOINCREM = :AUTINC  ';

    With qryUpd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('OPEATI').AsString := strLoginUsuarioLogado;
      ParamByName('HORATI').AsTime   := fTime();
      ParamByName('DTAATI').AsDate   := VS_Date;
      ParamByName('CODBAR').AsString := strCodBar;
      ParamByName('AUTINC').AsString := strCodCat;

      ExecSQL;
    End;

    fCommit;

  Except

    On E: Exception Do
    Begin
      fRollBack;
			pMensagensErro(E.Message,'[TfrmConsultaFatCatalogo.pGeraCodigoBarra]');
    End;

  End;

  FreeAndNil(qryUpd);

End;

function TfrmConsultaFatCatalogo.fVerificaItemJaCadastrado(strCodFor, strCodFab: String): String;
Var
  strSQL : String;
  qryGen : TUniQuery;
Begin

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   ITE_CODITE ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADITE ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   ITE_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '   ITE_CODFAB = :CODFAB ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('CODFAB').AsString := strCodFab;
      Open;
    End;

    If qryGen.RecordCount > 0 Then
      Result := qryGen.fieldbyname('ITE_CODITE').AsString
    Else
      Result := '';

  Finally
    FreeAndNil(qryGen);
  End;

End;

procedure TfrmConsultaFatCatalogo.cdsConsultaAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  intRecNo := cdsConsulta.RecNo;
end;

Function TfrmConsultaFatCatalogo.fTemMargemNegativa(dtsCatIte: TDataSet): Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  With dtsCatIte Do
  For intContador := 1 To Length(VS_strTabVen) Do
    If (VS_strTabVen[intContador] = 'S') And (FieldByName('CAT_MARBR' + IntToStr(intContador)).AsFloat < 0) Then
    Begin
      Result := True;
      Exit;
    End;

End;

Function TfrmConsultaFatCatalogo.fValidaMargemNegativa(strCodIte: String; dtsCatIte: TDataSet): Boolean;
  Var
    cdsItem: TZClient;
    intNumPreVen: Integer;
Begin
  Result := True;

  If Not blnMarNeg Then
    Exit;

  If Not fTemMargemNegativa(dtsCatIte) Then
    Exit;

  cdsItem := TProdMargemNegativa.fCriaDadosItem(strCodIte);

  With cdsItem Do
  If Not IsEmpty Then
  Begin
    Edit;

    FieldByName('ITE_PRECUS').AsFloat := dtsCatIte.FieldByName('CAT_PRECUS').AsFloat;

    For intNumPreVen := 1 To 7 Do
    Begin
      FieldByName('ITE_PREVE' + IntToStr(intNumPreVen)).AsFloat := dtsCatIte.FieldByName('CAT_PREVE' + IntToStr(intNumPreVen)).AsFloat;
      FieldByName('ITE_MARBR' + IntToStr(intNumPreVen)).AsFloat := dtsCatIte.FieldByName('CAT_MARBR' + IntToStr(intNumPreVen)).AsFloat;
    End;

    Post;

    Result := TProdMargemNegativa.fLiberaMargemNegativa(cdsItem, cdsItem, rotCadProdutos);
  End;

  FreeAndNil(cdsItem);
End;

procedure TfrmConsultaFatCatalogo.cdsConsultaBeforePost(DataSet: TDataSet);
Var
  strCodIte : String;
begin
  inherited;

  Try
    If dbgItens.SelectedField.DataType = ftFloat Then
    Begin
      if fStrToFloat(dbgItens.SelectedField.Text) = 0 Then
        dbgItens.SelectedField.Value := 0;
    End;

    If cdsConsulta.FieldByName('CAT_ATIVO').AsString = 'X' Then
    Begin
      strCodIte := fVerificaItemJaCadastrado(cdsConsulta.FieldByName('CAT_CODFOR').AsString,
                                             cdsConsulta.FieldByName('CAT_CODFAB').AsString);

      If fEmptyStr(strCodIte) Then
      Begin
        fMensagem('', 'O item está ativo, porém, não foi encontrado no cadastro de produtos.' + #13#10 +
                      'Verifique a chave Cód. Fab. e Cód. Fornec. desse item.', ['&O k']);
        Abort;
      End
    End;

    If (fblnTeveAlteracao) Then
    Begin
      If fEmptyStr(cdsConsulta.fieldbyname('CAT_CODUNI').AsString) Then
      Begin
        fMensagem('', 'O item está sem unidade preenchida!', ['&OK']);
        Abort;
      End;

      pRecalculaValores;

      If Not fValidaMargemNegativa(strCodite, DataSet) Then
        Abort;

      cdsConsulta.FieldByName('CAT_ITEALT').AsString := 'X';
      cdsConsulta.FieldByName('CAT_OPEALT').AsString := strLoginUsuarioLogado;
      cdsConsulta.FieldByName('CAT_DTAALT').Value := VS_Date;
      cdsConsulta.FieldByName('CAT_HORALT').Value := fTime();

      pAtualizaTabelas(strCodite);
    End;

  Except
    On E:EAbort Do
    Begin
      cdsConsulta.CancelUpdates;
      Abort;
    End;

    On E:Exception Do
      pMensagensErro(E.Message, '[cdsConsultaBeforePost]');

  End;

end;

procedure TfrmConsultaFatCatalogo.ApplicationEventsException(
  Sender: TObject; E: Exception);
begin
  inherited;

  If Pos(Uppercase('is not a valid date'),Uppercase(E.Message)) > 0 Then
    fMensagem('', 'Data inválida.', ['&O k'])

  Else If Pos(Uppercase('is not a valid floating'),Uppercase(E.Message)) > 0 Then
    fMensagem('', 'Valor inválido.', ['&O k'])
  Else
    fMensagem('', E.Message, ['&O k']);

end;

procedure TfrmConsultaFatCatalogo.cdsConsultaAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  DataSet.Cancel;
end;

procedure TfrmConsultaFatCatalogo.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If (blnEditar Or (intRecNo <> cdsConsulta.RecNo)) And (Column.Index = lflLastField.intIndCol) then
  Begin
    dbgItens.Canvas.Brush.Color:= clInfoBk;
    dbgItens.Canvas.Font.Color:= clWindowText;
    dbgItens.Canvas.FillRect(Rect);
  End;

  If (cdsConsulta.FieldByName('CAT_ITEPRO').AsString = 'X') Then
  Begin
    dbgItens.Canvas.Font.Color:= clGreen;
    dbgItens.Canvas.FillRect(Rect);
  End;

  If (cdsConsulta.FieldByName('CAT_ATVINA').AsString = 'N') Then
  Begin
    dbgItens.Canvas.Font.Color:= clRed;
    dbgItens.Canvas.FillRect(Rect);
  End;
  
  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmConsultaFatCatalogo.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pControlGridFocus(dbgItens, Key, btnSair);
end;

procedure TfrmConsultaFatCatalogo.dbgItensKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryCons: TUniQuery;
    arrSel : TConsultasArray;

begin
  inherited;
  If Not cdsConsulta.Active Then
    Exit;

  If (key = '-') And (dbgItens.SelectedField.DataType in [ftFloat, ftInteger]) Then
    Key := #0;


  If (fEntraCons(Key)) And (dbgItens.SelectedField <> Nil)  Then
  Begin
    qryCons := fCriaQuery;

    If (dbgItens.SelectedField.FieldName = 'CAT_CODUNI') Then
    Begin
      If fPesqUnidade(Self, nil, nil, nil, qryCons, Key, arrSel) Then
      Begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('CAT_CODUNI').AsString := qryCons.FieldByName('UNI_CODUNI').AsString;
        cdsConsulta.FieldByName('UNI_SIGUNI').AsString := fRetSiglaUnidade(qryCons.FieldByName('UNI_CODUNI').AsString);
      End;
    End;

    If (dbgItens.SelectedField.FieldName = 'CAT_CODMAR') Then
    Begin
      cdsConsulta.Edit;
      If fPesqMarcas(Self, Nil, Nil,qryCons, Key, arrSel) Then
        cdsConsulta.FieldByName('CAT_CODMAR').AsString := qryCons.FieldByName('MAR_CODMAR').AsString;
    End;

    FreeAndNil(qryCons);
     
  End;
end;

procedure TfrmConsultaFatCatalogo.btnIncluiItemClick(Sender: TObject);
  Var
    frmFatCatalogoAlteraItem: TfrmFatCatalogoAlteraItem;
begin
  inherited;

  If blnPreMat Then
  Begin
    fMensagem('', 'Cadastro de Produto permitido somente na Loja Matriz!', ['&Ok']);
    Exit;
  End;

  If fEmptyStr(edtNomFor.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Fornecedor deve ser informado.', ['&Ok']);
    pSetFocus(edtCodFor);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmFatCatalogoAlteraItem, frmFatCatalogoAlteraItem);
    frmFatCatalogoAlteraItem.strOpcao := 'INC';
    frmFatCatalogoAlteraItem.blnPreMat := blnPreMat;
    frmFatCatalogoAlteraItem.strCodForAlt := edtCodFor.Text;
    frmFatCatalogoAlteraItem.ShowModal;
  Finally
    FreeAndNil(frmFatCatalogoAlteraItem);
  End;

  fAbreConsulta(False);
end;

procedure TfrmConsultaFatCatalogo.btnAlteraClick(Sender: TObject);
Var
  intRec : Integer;
  frmFatCatalogoAlteraItem: TfrmFatCatalogoAlteraItem;
begin
  inherited;

  If cdsConsulta.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  
  If pnlPesquisa.Visible And
    ((edtNumero.Focused) Or
    (edtString.Focused) Or
    (edtValor.Focused)) Then
  Begin
    fAbreConsulta(True);
    pSetFocus(pnlPesquisa);
  End
  Else
  Begin

    If blnEditar And (cdsConsulta.Active) Then
    Begin

      intRec := cdsConsulta.RecNo;

      Try
        pCriarFormularios(TfrmFatCatalogoAlteraItem, frmFatCatalogoAlteraItem);

        If cdsConsulta.FieldByName('CAT_ATIVO').AsString = 'X' Then
        Begin
          frmFatCatalogoAlteraItem.strAltCadProdItem := fVerificaItemJaCadastrado(cdsConsulta.FieldByName('CAT_CODFOR').AsString,
                                                                                  cdsConsulta.FieldByName('CAT_CODFAB').AsString);
          If fEmptyStr(frmFatCatalogoAlteraItem.strAltCadProdItem) Then
          Begin
            fMensagem('', 'O item está ativo, porém, não foi encontrado no cadastro de produtos.' + #13#10 +
                          'Verifique a chave Cód. Fab. e Cód. Fornec. desse item.', ['&O k']);
            Exit;
          End
          Else If Not fVerificaItemAtivo(cdsConsulta.FieldByName('CAT_CODFOR').AsString,
                                         cdsConsulta.FieldByName('CAT_CODFAB').AsString) Then
          Begin
            fMensagem('', 'O item está inativo no cadastro de produtos!', ['&O k']);
            Exit;
          End;

        End
        Else
          frmFatCatalogoAlteraItem.strAltCadProdItem := EmptyStr;

        frmFatCatalogoAlteraItem.cdsConsulta := cdsConsulta;
        frmFatCatalogoAlteraItem.strOpcao := 'ALT';
        frmFatCatalogoAlteraItem.blnPreMat := blnPreMat;
        frmFatCatalogoAlteraItem.pCarregaItemCatalogo(cdsConsulta.FieldByName('CAT_DESITE').AsString,
                                                      cdsConsulta.FieldByName('CAT_CODFAB').AsString,
                                                      cdsConsulta.FieldByName('CAT_CODUNI').AsString,
                                                      cdsConsulta.FieldByName('CAT_CLAIPI').AsString,
                                                      cdsConsulta.FieldByName('CAT_CPRCEN').AsString,
                                                      cdsConsulta.FieldByName('CAT_CODFOR').AsString,
                                                      cdsConsulta.FieldByName('CAT_PRECOM').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_PRECUS').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_PREVE1').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_PREVE2').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_PREVE3').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_PREVE4').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_PREVE5').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_PREVE6').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_PREVE7').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_DESF01').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_DESF02').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_DESF03').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_DESF04').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_DESF05').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_DESF06').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_IPIENT').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_FREENT').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_ACRFIN').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_COMVAR').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_PESOIT').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_PESLIQ').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_EMBALA').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_MARBR1').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_MARBR2').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_MARBR3').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_MARBR4').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_MARBR5').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_MARBR6').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_MARBR7').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_ICMENT').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_SUBFED').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_ICMSAI').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_SUBSTI').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_DESADB').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_VALFRE').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_OUTVAL').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_IMPFED').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_DESOPE').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_CODABF').AsString,
                                                      cdsConsulta.FieldByName('CAT_CODMAR').AsString,
                                                      cdsConsulta.FieldByName('CAT_CODBAR').AsString,
                                                      cdsConsulta.FieldByName('CAT_BAREMB').AsString,
                                                      cdsConsulta.FieldByName('CAT_REFERE').AsString,
                                                      cdsConsulta.FieldByName('CAT_APLICA').AsString,
                                                      (cdsConsulta.FieldByName('CAT_PREDOL').AsString = 'S'),
                                                      cdsConsulta.FieldByName('CAT_TCIFCU').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_TSCUST').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_DEPICO').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_DEICMS').AsFloat,
                                                      cdsConsulta.FieldByName('CAT_FATREG').AsFloat);
        frmFatCatalogoAlteraItem.ShowModal;
      Finally
        FreeAndNil(frmFatCatalogoAlteraItem);
      End;

      fAbreConsulta(False);
      If cdsConsulta.RecordCount >= intRec Then
        cdsConsulta.RecNo := intRec;
    End
    Else
      inherited;
  End;
end;

procedure TfrmConsultaFatCatalogo.cdsConsultaAfterPost(DataSet: TDataSet);
begin
  inherited;
  cdsConsulta.ApplyUpdates(0);
end;

{******************************************}
{* ATUALIZA OS CAMPOS DOS VALORES NO GRID *}
{***************************************LU*}
procedure TfrmConsultaFatCatalogo.pRecalculaValores;
  var
    blnUtilizarConversorDeMoedas : Boolean;

  function fMarPreVen(intPreMar: Integer; fltPreCus: Double; fltPreven: Double; fltMarBru: Double): Double;
  begin
    Result := fCalculaPrecoVenda(intPreMar,
                                 fltPreCus + cdsConsulta.FieldByName('CAT_OUTVAL').AsFloat,
                                 fltPreven,
                                 fltMarBru,
                                 cdsConsulta.FieldByName('CAT_ICMSAI').AsFloat,
                                 cdsConsulta.FieldByName('CAT_IMPFED').AsFloat,
                                 cdsConsulta.FieldByName('CAT_DESOPE').AsFloat,
                                 0);
  end;

  Var
    fltPreVe1: Double;
    fltPreVe2: Double;
    fltPreVe3: Double;
    fltPreVe4: Double;
    fltPreVe5: Double;
    fltPreVe6: Double;
    fltPreVe7: Double;
    fltMarBr1: Double;
    fltMarBr2: Double;
    fltMarBr3: Double;
    fltMarBr4: Double;
    fltMarBr5: Double;
    fltMarBr6: Double;
    fltMarBr7: Double;
    fltPreCus: Double;
    cpcParams : TParCalculaPrecoCusto;

begin
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

  With cpcParams Do
  Begin
    curPreCom := cdsConsulta.FieldByName('CAT_PRECOM').AsFloat;
    curDesF01 := cdsConsulta.FieldByName('CAT_DESF01').AsFloat;
    curDesF02 := cdsConsulta.FieldByName('CAT_DESF02').AsFloat;
    curDesF03 := cdsConsulta.FieldByName('CAT_DESF03').AsFloat;
    curDesF04 := cdsConsulta.FieldByName('CAT_DESF04').AsFloat;
    curDesF05 := cdsConsulta.FieldByName('CAT_DESF05').AsFloat;
    curDesF06 := cdsConsulta.FieldByName('CAT_DESF06').AsFloat;
    curICMSEnt:= cdsConsulta.FieldByName('CAT_ICMENT').AsFloat;
    curSubFed := cdsConsulta.FieldByName('CAT_SUBFED').AsFloat;
    curIPIEnt := cdsConsulta.FieldByName('CAT_IPIENT').AsFloat;
    curFrete  := cdsConsulta.FieldByName('CAT_FREENT').AsFloat;
    curAcrFin := cdsConsulta.FieldByName('CAT_ACRFIN').AsFloat;
    curSubsti := cdsConsulta.FieldByName('CAT_SUBSTI').AsFloat;
    curDesAdb := cdsConsulta.FieldByName('CAT_DESADB').AsFloat;
    curValFre := cdsConsulta.FieldByName('CAT_VALFRE').AsFloat;

    if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
    begin
      curTCIFCu := cdsConsulta.FieldByName('CAT_TCIFCU').AsFloat;
      curTSCust := cdsConsulta.FieldByName('CAT_TSCUST').AsFloat;
      curDePiCo := cdsConsulta.FieldByName('CAT_DEPICO').AsFloat;
      curDeICMS := cdsConsulta.FieldByName('CAT_DEICMS').AsFloat;
      curFatReg := cdsConsulta.FieldByName('CAT_FATREG').AsFloat;
    end
    else
    begin
      curTCIFCu := 0;
      curTSCust := 0;
      curDePiCo := 0;
      curDeICMS := 0;
      curFatReg := 0;
    end;
  End;

  blnUtilizarConversorDeMoedas := cdsConsulta.FieldByName('CAT_PREDOL').AsString = 'S';

  fltPreCus := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoedas);

  fltMarBr1 := cdsConsulta.FieldByName('CAT_MARBR1').AsFloat;
  fltMarBr2 := cdsConsulta.FieldByName('CAT_MARBR2').AsFloat;
  fltMarBr3 := cdsConsulta.FieldByName('CAT_MARBR3').AsFloat;
  fltMarBr4 := cdsConsulta.FieldByName('CAT_MARBR4').AsFloat;
  fltMarBr5 := cdsConsulta.FieldByName('CAT_MARBR5').AsFloat;
  fltMarBr6 := cdsConsulta.FieldByName('CAT_MARBR6').AsFloat;
  fltMarBr7 := cdsConsulta.FieldByName('CAT_MARBR7').AsFloat;

  If dbgItens.SelectedField.FieldName = 'CAT_MARBR1' Then
    fltMarBr1 := fMarPreVen(2, fltPreCus, cdsConsulta.FieldByName('CAT_PREVE1').AsFloat, 0);

  If dbgItens.SelectedField.FieldName = 'CAT_MARBR2' Then
    fltMarBr2 := fMarPreVen(2, fltPreCus, cdsConsulta.FieldByName('CAT_PREVE2').AsFloat, 0);

  If dbgItens.SelectedField.FieldName = 'CAT_MARBR3' Then
    fltMarBr3 := fMarPreVen(2, fltPreCus, cdsConsulta.FieldByName('CAT_PREVE3').AsFloat, 0);

  If dbgItens.SelectedField.FieldName = 'CAT_MARBR4' Then
    fltMarBr4 := fMarPreVen(2, fltPreCus, cdsConsulta.FieldByName('CAT_PREVE4').AsFloat, 0);

  If dbgItens.SelectedField.FieldName = 'CAT_MARBR5' Then
    fltMarBr5 := fMarPreVen(2, fltPreCus, cdsConsulta.FieldByName('CAT_PREVE5').AsFloat, 0);

  If dbgItens.SelectedField.FieldName = 'CAT_MARBR6' Then
    fltMarBr6 := fMarPreVen(2, fltPreCus, cdsConsulta.FieldByName('CAT_PREVE6').AsFloat, 0);

  If dbgItens.SelectedField.FieldName = 'CAT_MARBR7' Then
    fltMarBr7 := fMarPreVen(2, fltPreCus, cdsConsulta.FieldByName('CAT_PREVE7').AsFloat, 0);

  fltPreVe1 := fMarPreVen(1, fltPreCus, 0, fltMarBr1);
  fltPreVe2 := fMarPreVen(1, fltPreCus, 0, fltMarBr2);
  fltPreVe3 := fMarPreVen(1, fltPreCus, 0, fltMarBr3);
  fltPreVe4 := fMarPreVen(1, fltPreCus, 0, fltMarBr4);
  fltPreVe5 := fMarPreVen(1, fltPreCus, 0, fltMarBr5);
  fltPreVe6 := fMarPreVen(1, fltPreCus, 0, fltMarBr6);
  fltPreVe7 := fMarPreVen(1, fltPreCus, 0, fltMarBr7);

  cdsConsulta.FieldByName('CAT_PREVE1').AsFloat := fltPreVe1;
  cdsConsulta.FieldByName('CAT_PREVE2').AsFloat := fltPreVe2;
  cdsConsulta.FieldByName('CAT_PREVE3').AsFloat := fltPreVe3;
  cdsConsulta.FieldByName('CAT_PREVE4').AsFloat := fltPreVe4;
  cdsConsulta.FieldByName('CAT_PREVE5').AsFloat := fltPreVe5;
  cdsConsulta.FieldByName('CAT_PREVE6').AsFloat := fltPreVe6;
  cdsConsulta.FieldByName('CAT_PREVE7').AsFloat := fltPreVe7;

  cdsConsulta.FieldByName('CAT_MARBR1').AsFloat := fltMarBr1;
  cdsConsulta.FieldByName('CAT_MARBR2').AsFloat := fltMarBr2;
  cdsConsulta.FieldByName('CAT_MARBR3').AsFloat := fltMarBr3;
  cdsConsulta.FieldByName('CAT_MARBR4').AsFloat := fltMarBr4;
  cdsConsulta.FieldByName('CAT_MARBR5').AsFloat := fltMarBr5;
  cdsConsulta.FieldByName('CAT_MARBR6').AsFloat := fltMarBr6;
  cdsConsulta.FieldByName('CAT_MARBR7').AsFloat := fltMarBr7;

  cdsConsulta.FieldByName('CAT_PRECUS').AsFloat := fltPreCus;
end;

{******************************************}
{* ATUALIZA AS TABELAS CADITE E ITEGER    *}
{***************************************LU*}
procedure TfrmConsultaFatCatalogo.pAtualizaTabelas(strCodIte: String);
Var
  strSQL   : String;
  qryGen   : TUniQuery;
  qryEmp   : TUniQuery;
  objIteBar: TIteBar;
  blnGrvLog: Boolean;
  strAgrupadorPreAlt : String;
begin
  inherited;
  pPreAltDefineVariaveisAltPre(fNow, 'CATALOGO DE PREÇOS', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);
  qryGen := fCriaQuery(Self);
  qryEmp := fCriaQuery(Self);
  Try
    Try
      blnGrvLog := False;
      fStartTransaction;

      strSQL := '';
      strSQL := strSQL + ' UPDATE ';
      strSQL := strSQL + '   CADITE ';
      strSQL := strSQL + ' SET ';
      strSQL := strSQL + '   ITE_DESITE = :DESITE, ';
      strSQL := strSQL + '   ITE_PESOIT = :PESOIT, ';
      strSQL := strSQL + '   ITE_PESLIQ = :PESLIQ, ';
      strSQL := strSQL + '   ITE_CODUNI = :CODUNI, ';
      strSQL := strSQL + '   ITE_CODMAR = :CODMAR, ';
      strSQL := strSQL + '   ITE_CODBAR = :CODBAR, ';
      strSQL := strSQL + '   ITE_BAREMB = :BAREMB, ';
      strSQL := strSQL + '   ITE_CLAIPI = :CLAIPI, ';
      strSQL := strSQL + '   ITE_EMBALA = :EMBALA  ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   ITE_CODFOR = :CODFOR AND ';
      strSQL := strSQL + '   ITE_CODFAB = :CODFAB AND ';
      strSQL := strSQL + '   ITE_CODITE = :CODITE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DESITE').AsString := cdsConsulta.fieldbyname('CAT_DESITE').AsString;
        ParamByName('PESOIT').AsFloat  := cdsConsulta.fieldbyname('CAT_PESOIT').AsFloat;
        ParamByName('PESLIQ').AsFloat  := cdsConsulta.fieldbyname('CAT_PESLIQ').AsFloat;
        ParamByName('EMBALA').AsFloat  := cdsConsulta.fieldbyname('CAT_EMBALA').AsFloat;
        ParamByName('CODBAR').AsString := cdsConsulta.fieldbyname('CAT_CODBAR').AsString;
        ParamByName('BAREMB').AsString := cdsConsulta.fieldbyname('CAT_BAREMB').AsString;
        ParamByName('CLAIPI').AsString := cdsConsulta.fieldbyname('CAT_CLAIPI').AsString;
        ParamByName('CODFOR').AsString := cdsConsulta.fieldbyname('CAT_CODFOR').AsString;
        ParamByName('CODUNI').AsString := cdsConsulta.fieldbyname('CAT_CODUNI').AsString;
        ParamByName('CODFAB').AsString := cdsConsulta.fieldbyname('CAT_CODFAB').AsString;
        ParamByName('CODITE').AsString := strCodIte;

        If Not fEmptyStr(cdsConsulta.Fieldbyname('CAT_CODMAR').AsString) Then
          ParamByName('CODMAR').AsString := cdsConsulta.Fieldbyname('CAT_CODMAR').AsString
        Else
          ParamByName('CODMAR').Value := Null;

        ExecSQL;

        objIteBar := TIteBar.Create(opcOperacoes);
        Try
          objIteBar.pIncluiCodigoBarrasCatalogo(strCodIte,
             cdsConsulta.fieldbyname('CAT_CODBAR').AsString,
             cdsConsulta.FieldByName('CAT_BAREMB').AsString,
             cdsConsulta.FieldByName('CAT_EMBALA').AsFloat);

          objIteBar.pSalvaDados(strCodIte);
        Finally
          FreeAndNil(objIteBar);
        End;

        fAtualizaBarFabIte(strCodIte);
      End;

      strSQL := '';
      strSQL := strSQL + ' UPDATE ';
      strSQL := strSQL + '   ITEGER ';
      strSQL := strSQL + ' SET ';
      strSQL := strSQL + '   ITE_DESF01 = :DESF01, ';
      strSQL := strSQL + '   ITE_DESF02 = :DESF02, ';
      strSQL := strSQL + '   ITE_DESF03 = :DESF03, ';
      strSQL := strSQL + '   ITE_DESF04 = :DESF04, ';
      strSQL := strSQL + '   ITE_DESF05 = :DESF05, ';
      strSQL := strSQL + '   ITE_DESF06 = :DESF06, ';
      strSQL := strSQL + '   ITE_PRECOM = :PRECOM, ';
      strSQL := strSQL + '   ITE_PRECUS = :PRECUS, ';
      strSQL := strSQL + '   ITE_PREVE1 = :PREVE1, ';
      strSQL := strSQL + '   ITE_PREVE2 = :PREVE2, ';
      strSQL := strSQL + '   ITE_PREVE3 = :PREVE3, ';
      strSQL := strSQL + '   ITE_PREVE4 = :PREVE4, ';
      strSQL := strSQL + '   ITE_PREVE5 = :PREVE5, ';
      strSQL := strSQL + '   ITE_PREVE6 = :PREVE6, ';
      strSQL := strSQL + '   ITE_PREVE7 = :PREVE7, ';
      strSQL := strSQL + '   ITE_IPIENT = :IPIENT, ';
      strSQL := strSQL + '   ITE_FREENT = :FREENT, ';
      strSQL := strSQL + '   ITE_ACRFIN = :ACRFIN, ';
      strSQL := strSQL + '   ITE_COMVAR = :COMVAR, ';
      strSQL := strSQL + '   ITE_ICMENT = :ICMENT, ';
      strSQL := strSQL + '   ITE_SUBFED = :SUBFED, ';
      strSQL := strSQL + '   ITE_CPRCEN = :CPRCEN, ';
      strSQL := strSQL + '   ITE_SUBSTI = :SUBSTI, ';
      strSQL := strSQL + '   ITE_MARBR1 = :MARBR1, ';
      strSQL := strSQL + '   ITE_MARBR2 = :MARBR2, ';
      strSQL := strSQL + '   ITE_MARBR3 = :MARBR3, ';
      strSQL := strSQL + '   ITE_MARBR4 = :MARBR4, ';
      strSQL := strSQL + '   ITE_MARBR5 = :MARBR5, ';
      strSQL := strSQL + '   ITE_MARBR6 = :MARBR6, ';
      strSQL := strSQL + '   ITE_MARBR7 = :MARBR7, ';
      strSQL := strSQL + '   ITE_DESADB = :DESADB, ';
      strSQL := strSQL + '   ITE_VALFRE = :VALFRE, ';
      strSQL := strSQL + '   ITE_OUTVAL = :OUTVAL, ';
      strSQL := strSQL + '   ITE_PREALT = :PREALT, ';

      strSQL := strSQL + '   ITE_DESOPE = :DESOPE, ';
      strSQL := strSQL + '   ITE_IMPFED = :IMPFED, ';
      strSQL := strSQL + '   ITE_ICMSAI = :ICMSAI, ';
      strSQL := strSQL + '   ITE_TCIFCU = :TCIFCU, ';
      strSQL := strSQL + '   ITE_TSCUST = :TSCUST, ';
      strSQL := strSQL + '   ITE_DEPICO = :DEPICO, ';
      strSQL := strSQL + '   ITE_DEICMS = :DEICMS, ';
      strSQL := strSQL + '   ITE_FATREG = :FATREG ';

      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   ITE_CODITE = :CODITE AND ';
      strSQL := strSQL + '   ITE_CODEMP = :CODEMP ';

      If Not blnPreMat Then
      Begin
        With qryGen Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('DESF01').AsFloat  := cdsConsulta.FieldByName('CAT_DESF01').AsFloat;
          ParamByName('DESF02').AsFloat  := cdsConsulta.FieldByName('CAT_DESF02').AsFloat;
          ParamByName('DESF03').AsFloat  := cdsConsulta.FieldByName('CAT_DESF03').AsFloat;
          ParamByName('DESF04').AsFloat  := cdsConsulta.FieldByName('CAT_DESF04').AsFloat;
          ParamByName('DESF05').AsFloat  := cdsConsulta.FieldByName('CAT_DESF05').AsFloat;
          ParamByName('DESF06').AsFloat  := cdsConsulta.FieldByName('CAT_DESF06').AsFloat;
          ParamByName('PRECOM').AsFloat  := cdsConsulta.FieldByName('CAT_PRECOM').AsFloat;
          ParamByName('PRECUS').AsFloat  := cdsConsulta.FieldByName('CAT_PRECUS').AsFloat;
          ParamByName('PREVE1').AsFloat  := cdsConsulta.FieldByName('CAT_PREVE1').AsFloat;
          ParamByName('PREVE2').AsFloat  := cdsConsulta.FieldByName('CAT_PREVE2').AsFloat;
          ParamByName('PREVE3').AsFloat  := cdsConsulta.FieldByName('CAT_PREVE3').AsFloat;
          ParamByName('PREVE4').AsFloat  := cdsConsulta.FieldByName('CAT_PREVE4').AsFloat;
          ParamByName('PREVE5').AsFloat  := cdsConsulta.FieldByName('CAT_PREVE5').AsFloat;
          ParamByName('PREVE6').AsFloat  := cdsConsulta.FieldByName('CAT_PREVE6').AsFloat;
          ParamByName('PREVE7').AsFloat  := cdsConsulta.FieldByName('CAT_PREVE7').AsFloat;
          ParamByName('IPIENT').AsFloat  := cdsConsulta.FieldByName('CAT_IPIENT').AsFloat;
          ParamByName('ICMENT').AsFloat  := cdsConsulta.FieldByName('CAT_ICMENT').AsFloat;
          ParamByName('SUBFED').AsFloat  := cdsConsulta.FieldByName('CAT_SUBFED').AsFloat;
          ParamByName('FREENT').AsFloat  := cdsConsulta.FieldByName('CAT_FREENT').AsFloat;
          ParamByName('ACRFIN').AsFloat  := cdsConsulta.FieldByName('CAT_ACRFIN').AsFloat;
          ParamByName('SUBSTI').AsFloat  := cdsConsulta.FieldByName('CAT_SUBSTI').AsFloat;
          ParamByName('COMVAR').AsFloat  := cdsConsulta.FieldByName('CAT_COMVAR').AsFloat;
          ParamByName('CPRCEN').AsString := cdsConsulta.FieldByName('CAT_CPRCEN').AsString;
          ParamByName('MARBR1').AsFloat  := cdsConsulta.FieldByName('CAT_MARBR1').AsFloat;
          ParamByName('MARBR2').AsFloat  := cdsConsulta.FieldByName('CAT_MARBR2').AsFloat;
          ParamByName('MARBR3').AsFloat  := cdsConsulta.FieldByName('CAT_MARBR3').AsFloat;
          ParamByName('MARBR4').AsFloat  := cdsConsulta.FieldByName('CAT_MARBR4').AsFloat;
          ParamByName('MARBR5').AsFloat  := cdsConsulta.FieldByName('CAT_MARBR5').AsFloat;
          ParamByName('MARBR6').AsFloat  := cdsConsulta.FieldByName('CAT_MARBR6').AsFloat;
          ParamByName('MARBR7').AsFloat  := cdsConsulta.FieldByName('CAT_MARBR7').AsFloat;
          ParamByName('DESADB').AsFloat  := cdsConsulta.FieldByName('CAT_DESADB').AsFloat;
          ParamByName('VALFRE').AsFloat  := cdsConsulta.FieldByName('CAT_VALFRE').AsFloat;
          ParamByName('OUTVAL').AsFloat  := cdsConsulta.FieldByName('CAT_OUTVAL').AsFloat;
          ParamByName('DESOPE').AsFloat  := cdsConsulta.FieldByName('CAT_DESOPE').AsFloat;
          ParamByName('IMPFED').AsFloat  := cdsConsulta.FieldByName('CAT_IMPFED').AsFloat;
          ParamByName('ICMSAI').AsFloat  := cdsConsulta.FieldByName('CAT_ICMSAI').AsFloat;
          ParamByName('PREALT').AsString  := strAgrupadorPreAlt;
          ParamByName('TCIFCU').AsFloat  := cdsConsulta.FieldByName('CAT_TCIFCU').AsFloat;
          ParamByName('TSCUST').AsFloat  := cdsConsulta.FieldByName('CAT_TSCUST').AsFloat;
          ParamByName('DEPICO').AsFloat  := cdsConsulta.FieldByName('CAT_DEPICO').AsFloat;
          ParamByName('DEICMS').AsFloat  := cdsConsulta.FieldByName('CAT_DEICMS').AsFloat;
          ParamByName('FATREG').AsFloat  := cdsConsulta.FieldByName('CAT_FATREG').AsFloat;
          ParamByName('CODITE').AsString := strCodIte;

          qryEmp.SQL.Text := 'SELECT ITE_CODEMP FROM ITEGER WHERE ITE_CODITE = :CODITE AND LOCATE(ITE_CODEMP, :CODEMP)';
          qryEmp.ParamByName('CODITE').AsString := strCodIte;
          qryEmp.ParamByName('CODEMP').AsString := fRetEmpresasUsamPrecoMatriz;
          qryEmp.Open;
          While Not qryEmp.Eof Do
          Begin
            ParamByName('CODEMP').AsString := qryEmp.FieldByName('ITE_CODEMP').AsString;

            If (Not blnGrvLog) And (Not VS_blnPreAltViaTrigger) Then
              blnGrvLog := fGravaPreAltCat(qryGen);
            ExecSQL;

            qryEmp.Next;
          End;
        End;
      End;

      fCommit
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmConsultaFatCatalogo.pAtualizaTabelas]');
      End;
    End;

  Finally
    FreeAndNil(qryGen);
    FreeAndNil(qryEmp);
    strAgrupadorPreAlt := '';
  End
end;

procedure TfrmConsultaFatCatalogo.btnExcluirClick(Sender: TObject);
  Var
    qryGen: TUniQuery;
begin
  inherited;
  If (Not btnExcluir.Visible) Or (Not cdsConsulta.Active) Or (cdsConsulta.RecordCount <= 0) Then
    Exit;

  Try
    qryGen := fCriaQuery;

    If fEmptyStr(cdsConsulta.FieldByName('CAT_ATIVO').AsString) Then
    Begin
      If fMensagem('AVISO', 'Deseja realmente excluir esse produto?', ['&Sim', '&Não']) = 1 Then
      Begin
        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add('DELETE FROM CATITE WHERE AUTOINCREM = :AUTINC');
        qryGen.ParamByName('AUTINC').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
        qryGen.ExecSQL;

        cdsConsulta.Delete;
      End;
    End
    Else
    Begin
      fMensagem('ATENÇÃO', 'Produto Ativo, não pode ser excluído!' , ['&O k']);
      Exit;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

procedure TfrmConsultaFatCatalogo.btnHerancaClick(Sender: TObject);
  Var
    frmFatCatalogoAlteraItem: TfrmFatCatalogoAlteraItem;
begin
  inherited;
  If cdsConsulta.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If blnPreMat Then
  Begin
    fMensagem('', 'Cadastro de Produto permitido somente na Loja Matriz!', ['&Ok']);
    Exit;
  End;

  If fEmptyStr(edtNomFor.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Fornecedor deve ser informado.', ['&Ok']);
    pSetFocus(edtCodFor);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmFatCatalogoAlteraItem, frmFatCatalogoAlteraItem);
    frmFatCatalogoAlteraItem.strOpcao := 'HER';
    frmFatCatalogoAlteraItem.blnPreMat := blnPreMat;
    frmFatCatalogoAlteraItem.strCodForAlt := edtCodFor.Text;
    frmFatCatalogoAlteraItem.pCarregaItemCatalogo(cdsConsulta.FieldByName('CAT_DESITE').AsString,
                                                  cdsConsulta.FieldByName('CAT_CODFAB').AsString,
                                                  cdsConsulta.FieldByName('CAT_CODUNI').AsString,
                                                  cdsConsulta.FieldByName('CAT_CLAIPI').AsString,
                                                  cdsConsulta.FieldByName('CAT_CPRCEN').AsString,
                                                  cdsConsulta.FieldByName('CAT_CODFOR').AsString,
                                                  cdsConsulta.FieldByName('CAT_PRECOM').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_PRECUS').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_PREVE1').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_PREVE2').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_PREVE3').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_PREVE4').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_PREVE5').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_PREVE6').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_PREVE7').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_DESF01').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_DESF02').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_DESF03').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_DESF04').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_DESF05').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_DESF06').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_IPIENT').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_FREENT').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_ACRFIN').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_COMVAR').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_PESOIT').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_PESLIQ').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_EMBALA').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_MARBR1').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_MARBR2').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_MARBR3').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_MARBR4').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_MARBR5').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_MARBR6').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_MARBR7').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_ICMENT').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_SUBFED').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_ICMSAI').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_SUBSTI').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_DESADB').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_VALFRE').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_OUTVAL').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_IMPFED').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_DESOPE').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_CODABF').AsString,
                                                  cdsConsulta.FieldByName('CAT_CODMAR').AsString,
                                                  cdsConsulta.FieldByName('CAT_CODBAR').AsString,
                                                  cdsConsulta.FieldByName('CAT_BAREMB').AsString,
                                                  cdsConsulta.FieldByName('CAT_REFERE').AsString,
                                                  cdsConsulta.FieldByName('CAT_APLICA').AsString,
                                                  cdsConsulta.FieldByName('CAT_PREDOL').AsString = 'S',
                                                  cdsConsulta.FieldByName('CAT_TCIFCU').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_TSCUST').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_DEPICO').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_DEICMS').AsFloat,
                                                  cdsConsulta.FieldByName('CAT_FATREG').AsFloat);
    frmFatCatalogoAlteraItem.ShowModal;
  Finally
    FreeAndNil(frmFatCatalogoAlteraItem);
  End;

  fAbreConsulta(False);

end;

procedure TfrmConsultaFatCatalogo.btnPromocaoClick(Sender: TObject);
begin
  inherited;
  If Not btnPromocao.Visible then
    Exit;

  If (Not Assigned(cdsConsulta)) Or
     (Not cdsConsulta.Active) Or
     (cdsConsulta.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não há itens para incluir/retirar da promoção!', ['&Ok']);
    Exit;
  End;

  if fEmptyStr(cdsConsulta.FieldByName('CAT_ITEPRO').AsString) Then
  Begin
    If fMensagem('AVISO', 'Confirma inclusão do Produto em Promoção?', ['&Sim', '&Não']) = 1 Then
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('CAT_ITEPRO').AsString := 'X';
      cdsConsulta.FieldByName('CAT_PREORI').AsFloat  := cdsConsulta.fieldbyname('CAT_PREVE1').AsFloat;
      cdsConsulta.ApplyUpdates(0);
    End;
  End
  Else
  Begin
    If fMensagem('AVISO', 'Confirma retirada do Produto em Promoção?', ['&Sim', '&Não']) = 1 Then
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('CAT_ITEPRO').AsString := '';
      cdsConsulta.FieldByName('CAT_PREORI').AsFloat  := 0.0;
      cdsConsulta.ApplyUpdates(0);
    End;
  End;

end;

procedure TfrmConsultaFatCatalogo.fAtiva_Inativa_Item(strCodIte, strCodCat, strCodFor, strOpcao: String);
Var
  strSQL: String;
  qryUpd: TUniQuery;
Begin

  Try
    qryUpd := fCriaQuery;

    {*******************************}
    {* ATUALIZANDO - CATITE        *}
    {****************************LU*}
    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + '   CATITE ';
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '   CAT_OPEATI = :OPEATI, ';
    strSQL := strSQL + '   CAT_HORATI = :HORATI, ';
    strSQL := strSQL + '   CAT_DTAATI = :DTAATI  ';
    strSQL := strSQL + ' WHERE                   ';
    strSQL := strSQL + '   AUTOINCREM = :AUTINC  ';

    With qryUpd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If strOpcao = 'A' Then
      Begin
        ParamByName('OPEATI').AsString := strLoginUsuarioLogado;
        ParamByName('HORATI').AsTime   := fTime();
        ParamByName('DTAATI').AsDate   := VS_Date;
      End
      Else
      Begin
        ParamByName('OPEATI').Value := Null;
        ParamByName('HORATI').Value := Null;
        ParamByName('DTAATI').Value := Null;
      End;

      ParamByName('AUTINC').AsString := strCodCat;

      ExecSQL;
    End;

    {*******************************}
    {* ATUALIZANDO - CADITE        *}
    {****************************LU*}
    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + '   CADITE ';
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '   ITE_ITEATI = :ITEATI, ';
    strSQL := strSQL + '   ITE_ATICOM = :ITEATI ';
    strSQL := strSQL + ' WHERE                  ';
    strSQL := strSQL + '   ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '   ITE_CODFOR = :CODFOR ';

    With qryUpd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If strOpcao = 'A' Then
        ParamByName('ITEATI').AsString := 'S'
      Else
        ParamByName('ITEATI').AsString := 'N';

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODFOR').AsString := strCodFor;

      ExecSQL;
    End;

  Finally
    FreeAndNil(qryUpd);
  End;

End;

function TfrmConsultaFatCatalogo.fVerificaItemAtivo(strCodFor, strCodFab: String): Boolean;
Var
  strSQL : String;
  qryGen : TUniQuery;
Begin

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   ITE_ITEATI ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADITE ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   ITE_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '   ITE_CODFAB = :CODFAB ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('CODFAB').AsString := strCodFab;
      Open;
    End;

    Result := (qryGen.FieldByName('ITE_ITEATI').AsString = 'S');

  Finally
    FreeAndNil(qryGen);
  End;

End;

function TfrmConsultaFatCatalogo.fValidaCodFabRepetidos(strCodFor: String): Boolean;
  Var
    qryGen: TUniQuery;
    strMsg: String;
begin

  qryGen := fCriaQuery(Nil);

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT                   ');
    SQL.Add('   ITE_CODFAB,            ');
    SQL.Add('   ITE_CODFOR,            ');
    SQL.Add('   COUNT(*) AS QTD        ');
    SQL.Add(' FROM                     ');
    SQL.Add('   CADITE                 ');
    SQL.Add(' WHERE                    ');
    SQL.Add('   ITE_CODFOR =:CODFOR AND ');
    SQL.Add('   IFNULL(ITE_CODFAB, "") <> "" ');
    SQL.Add(' GROUP BY                 ');
    SQL.Add('   ITE_CODFOR,            ');
    SQL.Add('   ITE_CODFAB             ');
    SQL.Add(' HAVING                   ');
    SQL.Add('   QTD > 1                ');

    ParamByName('CODFOR').AsString := strCodFor;

    Open;

    strMsg := 'O Fornecedor possui produtos com mesmo código de fábrica: ' + #13#10;

    If Not IsEmpty Then
    Begin
      While Not Eof Do
      Begin
        strMsg := strMsg + '(Cód.Fab: ' + FieldByName('ITE_CODFAB').AsString + ' Qtd.Itens: ' + FieldByName('QTD').AsString +')' + IIF(RecNo < RecordCount, ', ','');
        Next;
      End;
      Result := False;
      fMensagem('',strMsg,['&Ok']);
    End
    Else
      Result := True;

  End;

  FreeAndNil(qryGen);

end;

function TfrmConsultaFatCatalogo.fblnTeveAlteracao: Boolean;
var i: Integer;
begin
  Result := False;
  for i := 0 to cdsConsulta.Fields.Count - 1 do
  Begin
    if cdsConsulta.Fields[i].OldValue <> cdsConsulta.Fields[i].Value then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TfrmConsultaFatCatalogo.fGetIndexByName(strFieldName: String): Integer;
  Var
    intIndex : Integer;
begin
  Result := -1;
  With dbgItens.Columns Do
  Begin
    For intIndex := 0 To Count - 1 Do
    Begin
      If (Items[intIndex].FieldName = strFieldName) Then
      Begin
        Result := intIndex;
        Break;
      End;
    End;
  End;
end;

function TfrmConsultaFatCatalogo.fValidaGrid: Boolean;
begin
  Result := True;
  If fEmptyStr(cdsConsulta.FieldByName('CAT_CODMAR').AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'A Marca deve ser preenchida!', ['&Ok']);
    Result := False;
    pSetFocus(dbgItens);
    dbgItens.SelectedField :=  cdsConsulta.FieldByName('CAT_CODMAR');
  End;

  If (Result) And (fEmptyStr(cdsConsulta.FieldByName('CAT_CODUNI').AsString)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A Unidade deve ser preenchida!', ['&Ok']);
    Result := False;
    pSetFocus(dbgItens);
    dbgItens.SelectedField :=  cdsConsulta.FieldByName('CAT_CODUNI');
  End;
end;

procedure TfrmConsultaFatCatalogo.pControlGridFocus(dbgGrid: TDBGridCitel; Key: Word; NextControl: TWinControl);

  function fGetNextColumnField: TField;
    Var
      intIndex: Integer;
  begin
    Result := Nil;
    For intIndex := 0 To dbgGrid.Columns.Count -1 Do
      If intIndex > dbgGrid.SelectedIndex Then
        If Not dbgGrid.Columns[intIndex].ReadOnly Then
        Begin

          Result := dbgGrid.Columns[intIndex].Field;
          Break;
        End;
  end;

  function fGoToNextColumn: Boolean;
  begin
    Result := False;
    If fGetNextColumnField <> nil Then
    Begin
      dbgGrid.SelectedField := fGetNextColumnField;
      dbgGrid.DataSource.DataSet.Edit;
      Result := True;
    End;
  end;

  procedure pNextRecord;
  begin
    dbgGrid.DataSource.DataSet.Next;
    dbgGrid.SelectedIndex := 0;
    dbgGrid.SelectedField := fGetNextColumnField;
    dbgGrid.DataSource.DataSet.Edit;
  end;

begin
  With dbgGrid, DataSource.DataSet Do
  Begin
    Case Key Of
      VK_RETURN: Begin

                   If (Not Assigned(cdsConsulta)) Or
                      (Not cdsConsulta.Active) Or
                      (cdsConsulta.IsEmpty) Then
                     Exit;

                   If State = dsEdit Then
                     Post;

                   If Not fGoToNextColumn Then
                   Begin
                     If RecNo < RecordCount Then
                       pNextRecord
                     Else
                       pSetFocus(NextControl);
                   End;

                 End;
    End;
  End;
end;

end.

