unit untAltPrecoGlobalCatalogo;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Dialogs,
  StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni, Mask, MaskEditFocus,
  Grids, DBGridCitel, DBGrids, EditFocus, Menus, StrUtils, untfuncoesSimples, DB, AppEvnts,
  UniClientDataSet, UniDataSetProvider, BitBtnLockedIncrem, MemDS, DBAccess,
  Datasnap.Provider, untTypesSistema, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient;

Type
  TRecTabelaPrecos = Record
    fltPreVenNov: Double;
    fltMarBruNov: Double;
    fltComTblNov: Double;
    blnAltPreven: Boolean;
    blnAltMarBru: Boolean;
    blnAltComTbl: Boolean;
  End;

type
  TfrmAltPrecoGlobalCatalogo = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label2: TLabel;
    Label8: TLabel;
    pnlDadosAlt: TPanel;
    lblCamAlt: TLabel;
    edtCamAlt: TEditFocus;
    pnlBotoesEnt: TPanel;
    edtDesIte: TEditFocus;
    edtCodFor: TEditFocus;
    pgbProgresso: TProgressBar;
    edtNomFor: TEditFocus;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    dspItens: TUniDataSetProvider;
    cdsItens: TUniClientDataSet;
    dtsItens: TDataSource;
    rdgTipAlt: TRadioGroup;
    dbgTiposAlt: TDBGridCitel;
    btnConfirmaAlt: TBitBtnLocked;
    btnCancelaAlt: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnSairAlt: TBitBtnLocked;
    rdgAltCat: TRadioGroup;
    lblClaIpi: TLabel;
    edtClaIpi: TEditFocus;
    lblInfoFator: TLabel;
    procedure btnSairAltClick(Sender: TObject);
    procedure dbgTiposAltKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaAltClick(Sender: TObject);
    procedure dbgTiposAltDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelaAltClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCamAltKeyPress(Sender: TObject; var Key: Char);
    procedure dbgTiposAltDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtDesIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rdgTipAltClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryConFor: TUniQuery;
    qryItens: TUniQuery;
    qryAbfIcm: TUniQuery;

    blnBloPre: Boolean;

    arrCamposGlobal: Array Of TCampoGlobal;
    arrCamposTabela: Array Of TCampoGlobal;
    arrCamposGrid: Array Of TCampoGlobal;
    arrRecTabelasPreco: Array [1..7] Of TRecTabelaPrecos;    

    procedure pGerarTemporaria;

    function fGeraVetorCampos: Boolean;
    procedure pCriaTabelaItens;
    function  fGeraTabelaItens: Boolean;
    procedure pDeletaTabelaItens;

    procedure pAlteraValorTabelaItens(strCodIte: String; Var arrCampos: Array Of TCampoGlobal);

    procedure pCarregaFornecedor;

    procedure pAtribuiTabelas;

    procedure pDesmarcaCampo;
    procedure pCarregaInfoAlteracao;
    procedure pGravaValor;

    procedure pAtualizaValorCampo(Var arrCampos: Array Of TCampoGlobal;
                                      strNomeCampo: String; varValor: Variant);

    procedure  pAlteraPrecoOuMargem;
    procedure pZeraPrecoOuMargem;
    procedure pLimpaCampo;

    function fRetornaNumeric(strMascara: String): String;
    function fRetornaCampoPorNome(Var arrCampos: Array Of TCampoGlobal;
                                      strNomeCampo: String): TCampoGlobal;
    function fTamanhoCampo(strCampo: String):Boolean;

  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnAltPorFator: Boolean;
    arrProduto,
    arrCodAbr : TConsultasArray;
  end;

var
  frmAltPrecoGlobalCatalogo: TfrmAltPrecoGlobalCatalogo;

implementation

uses untPesqAux, untConstantes,
     untAltPrecoGlobalItensCatalogo,
     untParCalculaPrecoCusto, untFuncoesConsulta, untConsultas, untTConfiguracao;

{$R *.dfm}

function TfrmAltPrecoGlobalCatalogo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNomCam: String;
    strMasCam: String;
Begin

  strNomCam := '';
  strMasCam := '';
  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDesIte) Then
    Begin
    End

    Else If (Sender = edtCodFor) Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
        edtNomFor.Text := 'TODOS'
      Else
      Begin
        pCarregaFornecedor;
        If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtClaIpi) Then
    Begin
      If Not fEmptyStr(edtClaIpi.Text) And (Length(edtClaIpi.Text) <> MAX_CLAIPI) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Classificação de IPI deve ter ' + IntToStr(MAX_CLAIPI) +  ' caracteres!', ['&Ok']);
        Result := False;
      End;
    End

    {******************************************}
    {* VALIDAÇÕES DO CAMPO ONDE SÃO DIGITADOS *}
    {* OS VALORES                             *}
    {***************************************MV*}
    Else If (Sender = edtCamAlt) Then
    Begin

      If ((rdgTipAlt.ItemIndex = 0) And (Pos(UpperCase('CAT_MARBR'),  cdsConsulta.FieldByName('ITE_NOMCAM').AsString) > 0)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para alterar a margem selecione a opção "Alterar Custos e/ou Margem refletindo no Preço de Venda"!', ['&O k']);
        Result := False;
      End;

       If ((rdgTipAlt.ItemIndex = 1) And (Pos(UpperCase('CAT_PREVE'),  cdsConsulta.FieldByName('ITE_NOMCAM').AsString)> 0)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para alterar o preço de venda selecione a opção "Alterar Custos e/ou Preço de Venda refletindo na Margem"!', ['&O k']);
        Result := False;
      End;

      strNomCam := cdsConsulta.FieldByName('ITE_NOMCAM').AsString;
      strMasCam := cdsConsulta.FieldByName('ITE_MASCAM').AsString;

      If (strNomCam = 'CAT_PRECOM') Or
         (strNomCam = 'CAT_PREVE1') Or
         (strNomCam = 'CAT_PREVE2') Or
         (strNomCam = 'CAT_PREVE3') Or
         (strNomCam = 'CAT_PREVE4') Or
         (strNomCam = 'CAT_PREVE5') Or
         (strNomCam = 'CAT_PREVE6') Or
         (strNomCam = 'CAT_PREVE7') Or
         (strNomCam = 'CAT_EMBALA') Then
      Begin

        If (Not fEmptyStr(edtCamAlt.Text)) Then
        Begin
          edtCamAlt.Text := FormatFloat(strMasCam, fStrToFloat(edtCamAlt.Text));

          If blnAltPorFator Then
          Begin
            If (Int(fStrToFloat(edtCamAlt.Text)) > 1) Then
              Result := False;
          End;

          If (fStrToFloat(edtCamAlt.Text) < 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Valor não permitido: maior ou igual a 0!', ['&Ok']);
            Result := False;
          End;

        End;

      End

      {***************************************}
      {* VALIDAÇÃO DA MARGEM                 *}
      {************************************CI*}

      Else If (Pos(UpperCase('CAT_MARBR'), strNomCam) > 0) Then
      Begin
        If Not fEmptyStr(edtCamAlt.Text) Then
        Begin
          If fStrToFloat(edtCamAlt.Text) > MAX_VALMON Then
            edtCamAlt.Text := FloatToStr(MAX_VALMON);

          If (Pos(fCfgSis('MARMKP'), '1_5_') > 0) Then
          Begin
            If (fStrToFloat(edtCamAlt.Text) >= 100) Then
            Begin
              fMensagem('ATENÇÃO!', 'Margem não permitida: maior ou igual a 100!', ['&Ok']);
              Result := False;
            End;

          End;
        End;
      End

      {***************************************}
      {* VALIDAÇÃO ABREV. FISCAL             *}
      {***************************************}
      Else If (strNomCam = 'CAT_CODABF') Then
      Begin
        If (fRetDesAbfIcm(edtCamAlt.Text) = '') Then
        Begin
          fMensagem('ATENÇÃO!', 'Abreviação Fiscal não cadastrada!', ['&O k']);
          Result := False;
        End
      End

      Else If (strNomCam = 'CAT_CODFOR') Then
      Begin

        If (fRetNomFornecedor(edtCamAlt.Text) = '') Then
        Begin
          fMensagem('ATENÇÃO!', 'Fornecedor não cadastrado!', ['&O k']);
          Result := False;
        End;

      End

      Else If (Not fEmptyStr(edtCamAlt.Text)) And
              (Not fEmptyStr(strMasCam))      Then
      Begin
        edtCamAlt.Text := FormatFloat(strMasCam, fStrToFloat(edtCamAlt.Text));
      End

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
End;

procedure TfrmAltPrecoGlobalCatalogo.pEscapePressed;
Begin
  If (ActiveControl.Parent = pnlBotoesEnt) Or (ActiveControl.Parent = pnlDadosAlt)  Then
    btnCancelaAlt.Click
  Else
    inherited;
End;

procedure TfrmAltPrecoGlobalCatalogo.pGerarTemporaria;
  Var
    intContador: Integer;
Begin
  With cdsConsulta Do
  Begin
    With FieldDefs Do
    Begin
      With AddFieldDef Do Begin Name := 'ITE_DESCAM'; DataType := ftString; Size := 040; End;
      With AddFieldDef Do Begin Name := 'ITE_VALCAM'; DataType := ftString; Size := 019; End;
      With AddFieldDef Do Begin Name := 'ITE_MASCAM'; DataType := ftString; Size := 015; End;
      With AddFieldDef Do Begin Name := 'ITE_NOMCAM'; DataType := ftString; Size := 010; End;
      With AddFieldDef Do Begin Name := 'ITE_DESABR'; DataType := ftString; Size := 015; End;
      With AddFieldDef Do Begin Name := 'ITE_LIMCAM'; DataType := ftInteger; End;
      With AddFieldDef Do Begin Name := 'ITE_TIPCAM'; DataType := ftString; Size := 015; End;
      With AddFieldDef Do Begin Name := 'ITE_ALTERA'; DataType := ftString; Size := 001; End;
    End;

    CreateDataSet;
    Open;

    For intContador := 0 To Length(arrCamposGlobal) -1 Do
    If Not fEmptyStr(arrCamposGlobal[intContador].strDesCam) Then
    Begin
      Insert;
      FieldByName('ITE_DESCAM').AsString  := arrCamposGlobal[intContador].strDesCam;
      FieldByName('ITE_VALCAM').Value     := arrCamposGlobal[intContador].varValCam;
      FieldByName('ITE_MASCAM').AsString  := arrCamposGlobal[intContador].strMasCam;
      FieldByName('ITE_NOMCAM').AsString  := arrCamposGlobal[intContador].strNomCam;
      FieldByName('ITE_DESABR').AsString  := arrCamposGlobal[intContador].strDesAbr;
      FieldByName('ITE_LIMCAM').AsInteger := arrCamposGlobal[intContador].intLimCam;
      FieldByName('ITE_TIPCAM').AsString  := arrCamposGlobal[intContador].strTipCam;
      Post;
     End;
  End;

End;

procedure TfrmAltPrecoGlobalCatalogo.pCarregaFornecedor;
Begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
End;

procedure TfrmAltPrecoGlobalCatalogo.pAtribuiTabelas;
Begin
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
End;

procedure TfrmAltPrecoGlobalCatalogo.btnSairAltClick(Sender: TObject);
Begin
  inherited;
  Close;
End;

procedure TfrmAltPrecoGlobalCatalogo.dbgTiposAltKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
Begin
  inherited;
  If (Key = VK_Escape) Then
    pSetFocus(edtCodFor)
  Else If (Key = VK_Return) Then
  Begin
    If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Then
      Exit;
    If cdsConsulta.FieldByName('ITE_ALTERA').AsString = 'S' Then
      pDesmarcaCampo
    Else
      pCarregaInfoAlteracao;

  End
  Else If (Key = VK_F10) Then
    btnConfirma.Click;

End;

procedure TfrmAltPrecoGlobalCatalogo.pGravaValor;
Begin
  With cdsConsulta Do
  Begin
    Edit;

    FieldByName('ITE_VALCAM').AsString := edtCamAlt.Text;

    If fEmptyStr(edtCamAlt.Text) Then
      FieldByName('ITE_ALTERA').AsString := 'N'
    Else
      FieldByName('ITE_ALTERA').AsString := 'S';

    Post;
  End;

End;

procedure TfrmAltPrecoGlobalCatalogo.rdgTipAltClick(Sender: TObject);
Begin
  inherited;
  btnCancelaAltClick(Sender);
  pLimpaCampo;
  dbgTiposAlt.Refresh;
  dbgTiposAlt.Update;
End;

procedure TfrmAltPrecoGlobalCatalogo.pLimpaCampo;
Begin
  With cdsConsulta Do
  Begin
    If Not Active Then
      Exit;

    First;
    While Not Eof Do
    Begin
      If ((Pos(UpperCase('CAT_MARBR'),  FieldByName('ITE_NOMCAM').AsString) > 0)  Or
          (Pos(UpperCase('CAT_PREVE'),  FieldByName('ITE_NOMCAM').AsString) > 0)) Then
      Begin
        Edit;
        FieldByName('ITE_ALTERA').AsString := 'N';
        FieldByName('ITE_VALCAM').Value    := 0;
        Post;
      End;
      Next;
    End;
  End;

End;

procedure TfrmAltPrecoGlobalCatalogo.btnConfirmaAltClick(Sender: TObject);
Begin
  inherited;

  If fValidaCampos(edtCamAlt, False) Then
  Begin

    {*******************************************}
    {* VERIFICA O TAMANHO DO CAMPO PARA PODER  *}
    {* GRAVAR CORRETAMENTE                     *}
    {****************************************AC*}
    If (Not fTamanhoCampo(edtCamAlt.Text)) Then
    Begin
      pSetFocus(edtCamAlt);
      Exit;
    End;


    pGravaValor;
    pSetFocus(dbgTiposAlt);
    lblCamAlt.Caption := '';
    edtCamAlt.Clear;


  End;

End;

procedure TfrmAltPrecoGlobalCatalogo.pCarregaInfoAlteracao;
Begin
  If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Then
    Exit;

  With cdsConsulta Do
  Begin

    lblCamAlt.Caption := FieldByName('ITE_DESCAM').AsString;
    edtCamAlt.Clear;

    If (Not fEmptyStr(FieldByName('ITE_MASCAM').AsString)) Or (FieldByName('ITE_TIPCAM').AsString = 'INTEGER') Then
      edtCamAlt.TipoTexto := ttNumerico
    Else
      edtCamAlt.TipoTexto := ttAlfanumerico;

    edtCamAlt.MaxLength := FieldByName('ITE_LIMCAM').AsInteger;

    If (((rdgTipAlt.ItemIndex = 0) And (Pos(UpperCase('CAT_MARBR'),  FieldByName('ITE_NOMCAM').AsString) > 0)) Or
        ((rdgTipAlt.ItemIndex = 1) And (Pos(UpperCase('CAT_PREVE'),  FieldByName('ITE_NOMCAM').AsString)> 0))) Then
    Begin
      lblCamAlt.Caption := '';
      pSetFocus(dbgTiposAlt);
    End
    Else
      pSetFocus(edtCamAlt);
  End;

End;

procedure TfrmAltPrecoGlobalCatalogo.dbgTiposAltDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
Begin
  inherited;

  If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Then
    Exit;

  With cdsConsulta Do
  Begin

    If (rdgTipAlt.ItemIndex = 0) Then
    Begin
      If (Pos(UpperCase('CAT_MARBR'), FieldByName('ITE_NOMCAM').AsString) > 0) Then
        dbgTiposAlt.Canvas.Brush.Color := $00FFDFB8
      Else
        dbgTiposAlt.Canvas.Brush.Color := clWhite;
    End
    Else
    Begin
      If (Pos(UpperCase('CAT_PREVE'), FieldByName('ITE_NOMCAM').AsString) > 0) Then
        dbgTiposAlt.Canvas.Brush.Color := $00FFDFB8
      Else
        dbgTiposAlt.Canvas.Brush.Color := clWhite;
    End;
    dbgTiposAlt.Canvas.FillRect(Rect);

    If FieldByName('ITE_ALTERA').AsString = 'S' Then
      dbgTiposAlt.Canvas.Font.Color := clBlue
    Else
      dbgTiposAlt.Canvas.Font.Color := clBlack;

  End;

  dbgTiposAlt.DefaultDrawColumnCell(Rect, DataCol, Column, State);

End;

procedure TfrmAltPrecoGlobalCatalogo.FormClose(Sender: TObject;
  var Action: TCloseAction);
Begin
  inherited;
  pDeletaTabelaItens;
End;

procedure TfrmAltPrecoGlobalCatalogo.FormCreate(Sender: TObject);
Begin
  inherited;
  qryItens := fCriaQuery(Self);
  dspItens.DataSet := qryItens;
End;

procedure TfrmAltPrecoGlobalCatalogo.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryItens);
  inherited;
end;

procedure TfrmAltPrecoGlobalCatalogo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Begin
  inherited;

    If (ActiveControl.Parent = rdgTipAlt) Then
      SelectNext(ActiveControl, True, True);

End;

procedure TfrmAltPrecoGlobalCatalogo.pDesmarcaCampo;
Begin

  pGravaValor; //Grava em branco.

End;

procedure TfrmAltPrecoGlobalCatalogo.btnCancelaAltClick(Sender: TObject);
Begin
  inherited;
  lblCamAlt.Caption := '';
  edtCamAlt.Clear;
  pSetFocus(dbgTiposAlt);
End;

procedure TfrmAltPrecoGlobalCatalogo.btnConfirmaClick(Sender: TObject);
  Var
    blnConfirma: Boolean;
Begin
  inherited;

  If (Not btnConfirma.Enabled) Then
    Exit;

  blnConfirma := False;

  Screen.Cursor := crHourGlass;

  btnConfirmaAlt.Enabled := False;
  btnConfirma.Enabled    := False;
  btnCancelaAlt.Enabled  := False;
  btnSairAlt.Enabled     := False;

  pDeletaTabelaItens;
  If (Not fGeraVetorCampos) Then
  Begin
    fMensagem('', 'É necessário marcar pelo menos um campo para alteração!', ['&O k']);
    btnConfirmaAlt.Enabled := True;
    btnConfirma.Enabled    := True;
    btnCancelaAlt.Enabled  := True;
    btnSairAlt.Enabled     := True;
    Screen.Cursor          := crDefault;
    Exit;
  End;

  pCriaTabelaItens;

  If fGeraTabelaItens Then
  Begin

    Try
      pCriarFormularios(TfrmAltPrecoGlobalItensCatalogo, frmAltPrecoGlobalItensCatalogo);
      frmAltPrecoGlobalItensCatalogo.dbgItens.DataSource := dtsItens;
      frmAltPrecoGlobalItensCatalogo.cdsItens := cdsItens;
      frmAltPrecoGlobalItensCatalogo.pCopiaCamposGrid(arrCamposGrid);
      frmAltPrecoGlobalItensCatalogo.showModal;

      blnConfirma := frmAltPrecoGlobalItensCatalogo.blnConfirma;

    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message, '[frmAltPrecoGlobalCatalogo.btnConfirmaClick]');
      End;
    End;

    pFreeAndNil(frmAltPrecoGlobalItensCatalogo);

  End;

  btnConfirmaAlt.Enabled := True;
  btnConfirma.Enabled    := True;
  btnCancelaAlt.Enabled  := True;
  btnSairAlt.Enabled     := True;
  Screen.Cursor          := crDefault;

  If blnConfirma Then
    Close;

End;

procedure TfrmAltPrecoGlobalCatalogo.pCriaTabelaItens;
  Var
    strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  C.CAT_CODFOR, ';

  If (rdgAltCat.ItemIndex = 0) Or (rdgAltCat.ItemIndex = 2) Then
  Begin
    strSQL := strSQL + '  I.ITE_CODITE, ';
    strSQL := strSQL + '  I.ITE_REFERE, ';
  End
  Else
  Begin
    strSQL := strSQL + '  CAST("" AS CHAR(5)) AS ITE_CODITE, ';
    strSQL := strSQL + '  CAST("" AS CHAR(16)) AS ITE_REFERE, ';
  End;


  strSQL := strSQL + '  C.CAT_CODFAB AS CAT_CODITE, ';
  strSQL := strSQL + '  C.CAT_DESITE, ';
  strSQL := strSQL + '  C.CAT_PESOIT, ';
  strSQL := strSQL + '  C.CAT_PESOIT AS "CAT_PESOIT_NOV", ';
  strSQL := strSQL + '  C.CAT_PESLIQ, ';
  strSQL := strSQL + '  C.CAT_PESLIQ AS "CAT_PESLIQ_NOV", ';
  strSQL := strSQL + '  C.CAT_CODABF, ';
  strSQL := strSQL + '  C.CAT_CODABF AS "CAT_CODABF_NOV", ';
(*
  strSQL := strSQL + '  C.CAT_EMBALA, ';
  strSQL := strSQL + '  C.CAT_EMBALA AS "CAT_EMBALA_NOV", ';
*)  
  strSQL := strSQL + '  C.CAT_PRECOM, ';
  strSQL := strSQL + '  C.CAT_PRECOM AS "CAT_PRECOM_NOV", ';
  strSQL := strSQL + '  C.CAT_PREVE1, ';
  strSQL := strSQL + '  C.CAT_PREVE1 AS "CAT_PREVE1_NOV", ';
  strSQL := strSQL + '  C.CAT_PREVE2, ';
  strSQL := strSQL + '  C.CAT_PREVE2 AS "CAT_PREVE2_NOV", ';
  strSQL := strSQL + '  C.CAT_PREVE3, ';
  strSQL := strSQL + '  C.CAT_PREVE3 AS "CAT_PREVE3_NOV", ';
  strSQL := strSQL + '  C.CAT_PREVE4, ';
  strSQL := strSQL + '  C.CAT_PREVE4 AS "CAT_PREVE4_NOV", ';
  strSQL := strSQL + '  C.CAT_PREVE5, ';
  strSQL := strSQL + '  C.CAT_PREVE5 AS "CAT_PREVE5_NOV", ';
  strSQL := strSQL + '  C.CAT_PREVE6, ';
  strSQL := strSQL + '  C.CAT_PREVE6 AS "CAT_PREVE6_NOV", ';
  strSQL := strSQL + '  C.CAT_PREVE7, ';
  strSQL := strSQL + '  C.CAT_PREVE7 AS "CAT_PREVE7_NOV", ';
  strSQL := strSQL + '  C.CAT_DESF01, ';
  strSQL := strSQL + '  C.CAT_DESF01 AS "CAT_DESF01_NOV", ';
  strSQL := strSQL + '  C.CAT_DESF02, ';
  strSQL := strSQL + '  C.CAT_DESF02 AS "CAT_DESF02_NOV", ';
  strSQL := strSQL + '  C.CAT_DESF03, ';
  strSQL := strSQL + '  C.CAT_DESF03 AS "CAT_DESF03_NOV", ';
  strSQL := strSQL + '  C.CAT_DESF04, ';
  strSQL := strSQL + '  C.CAT_DESF04 AS "CAT_DESF04_NOV", ';
  strSQL := strSQL + '  C.CAT_DESF05, ';
  strSQL := strSQL + '  C.CAT_DESF05 AS "CAT_DESF05_NOV", ';
  strSQL := strSQL + '  C.CAT_DESF06, ';
  strSQL := strSQL + '  C.CAT_DESF06 AS "CAT_DESF06_NOV", ';
  strSQL := strSQL + '  C.CAT_SUBFED, ';
  strSQL := strSQL + '  C.CAT_SUBFED AS "CAT_SUBFED_NOV", ';
  strSQL := strSQL + '  C.CAT_DESADB, ';
  strSQL := strSQL + '  C.CAT_DESADB AS "CAT_DESADB_NOV", ';
  strSQL := strSQL + '  C.CAT_VALFRE, ';
  strSQL := strSQL + '  C.CAT_VALFRE AS "CAT_VALFRE_NOV", ';
  strSQL := strSQL + '  C.CAT_OUTVAL, ';
  strSQL := strSQL + '  C.CAT_OUTVAL AS "CAT_OUTVAL_NOV", ';
  strSQL := strSQL + '  C.CAT_DESOPE, ';
  strSQL := strSQL + '  C.CAT_DESOPE AS "CAT_DESOPE_NOV", ';
  strSQL := strSQL + '  C.CAT_IMPFED, ';
  strSQL := strSQL + '  C.CAT_IMPFED AS "CAT_IMPFED_NOV", ';
  strSQL := strSQL + '  C.CAT_ICMSAI, ';
  strSQL := strSQL + '  C.CAT_ICMSAI AS "CAT_ICMSAI_NOV", ';
  strSQL := strSQL + '  C.CAT_ICMENT, ';
  strSQL := strSQL + '  C.CAT_ICMENT AS "CAT_ICMENT_NOV", ';
  strSQL := strSQL + '  C.CAT_IPIENT, ';
  strSQL := strSQL + '  C.CAT_IPIENT AS "CAT_IPIENT_NOV", ';
  strSQL := strSQL + '  C.CAT_FREENT, ';
  strSQL := strSQL + '  C.CAT_FREENT AS "CAT_FREENT_NOV", ';
  strSQL := strSQL + '  C.CAT_ACRFIN, ';
  strSQL := strSQL + '  C.CAT_ACRFIN AS "CAT_ACRFIN_NOV", ';
  strSQL := strSQL + '  C.CAT_SUBSTI, ';
  strSQL := strSQL + '  C.CAT_SUBSTI AS "CAT_SUBSTI_NOV", ';
  strSQL := strSQL + '  C.CAT_PRECUS, ';
  strSQL := strSQL + '  C.CAT_PRECUS AS "CAT_PRECUS_NOV", ';
  strSQL := strSQL + '  C.CAT_MARBR1, ';
  strSQL := strSQL + '  C.CAT_MARBR1 AS "CAT_MARBR1_NOV", ';
  strSQL := strSQL + '  C.CAT_MARBR2, ';
  strSQL := strSQL + '  C.CAT_MARBR2 AS "CAT_MARBR2_NOV", ';
  strSQL := strSQL + '  C.CAT_MARBR3, ';
  strSQL := strSQL + '  C.CAT_MARBR3 AS "CAT_MARBR3_NOV", ';
  strSQL := strSQL + '  C.CAT_MARBR4, ';
  strSQL := strSQL + '  C.CAT_MARBR4 AS "CAT_MARBR4_NOV", ';
  strSQL := strSQL + '  C.CAT_MARBR5, ';
  strSQL := strSQL + '  C.CAT_MARBR5 AS "CAT_MARBR5_NOV", ';
  strSQL := strSQL + '  C.CAT_MARBR6, ';
  strSQL := strSQL + '  C.CAT_MARBR6 AS "CAT_MARBR6_NOV", ';
  strSQL := strSQL + '  C.CAT_MARBR7, ';
  strSQL := strSQL + '  C.CAT_MARBR7 AS "CAT_MARBR7_NOV", ';
  strSQL := strSQL + '  C.CAT_COMVAR, ';
  strSQL := strSQL + '  C.CAT_COMVAR AS "CAT_COMVAR_NOV", ';
  strSQL := strSQL + '  C.CAT_TCIFCU, ';
  strSQL := strSQL + '  C.CAT_TCIFCU AS "CAT_TCIFCU_NOV", ';
  strSQL := strSQL + '  C.CAT_TSCUST, ';
  strSQL := strSQL + '  C.CAT_TSCUST AS "CAT_TSCUST_NOV", ';
  strSQL := strSQL + '  C.CAT_DEPICO, ';
  strSQL := strSQL + '  C.CAT_DEPICO AS "CAT_DEPICO_NOV", ';
  strSQL := strSQL + '  C.CAT_DEICMS, ';
  strSQL := strSQL + '  C.CAT_DEICMS AS "CAT_DEICMS_NOV", ';
  strSQL := strSQL + '  C.CAT_FATREG, ';
  strSQL := strSQL + '  C.CAT_FATREG AS "CAT_FATREG_NOV",  ';
  strSQL := strSQL + '  "M"          AS CAT_MARDES        ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CATITE C ';

  If (rdgAltCat.ItemIndex In [0..1]) Then
  Begin
    strSQL := strSQL + IIF(rdgAltCat.ItemIndex = 1, 'LEFT', '') + ' JOIN CADITE I ON I.ITE_CODFOR = C.CAT_CODFOR ';
    strSQL := strSQL + '                                                         AND I.ITE_CODFAB = C.CAT_CODFAB ';
  End
  Else
  Begin
    strSQL := strSQL + 'LEFT JOIN CADITE I ON I.ITE_CODFOR = C.CAT_CODFOR ';
    strSQL := strSQL + '                  AND I.ITE_CODFAB = C.CAT_CODFAB ';
  End;

  strSQL := strSQL + ' WHERE TRUE ';

  If (rdgAltCat.ItemIndex = 1) Then
    strSQL := strSQL + ' AND I.ITE_CODITE IS NULL ';

  strSQL := strSQL + ' AND C.CAT_CODFAB IS NULL ';

  With qryItens Do
  Begin
    Close;
    cdsItens.Close;

    SQL.Clear;
    SQL.Add(strSQL);

    Open;
    pSetaClient(qryItens);

    cdsItens.Open;
    pSetaClient(cdsItens);
  End;

End;

function TfrmAltPrecoGlobalCatalogo.fRetornaNumeric(strMascara: String): String;
  Var
    intPrecisao: Integer;
Begin

  strMascara := AnsiReplaceStr(strMascara, '#', '');
  strMascara := AnsiReplaceStr(strMascara, ',', '');

  intPrecisao := Length(Copy(strMascara, Pos('.', strMascara)+1, Length(strMascara)));

  Result := 'NUMERIC(12, ' + IntToStr(intPrecisao) + ')';

End;

function TfrmAltPrecoGlobalCatalogo.fRetornaCampoPorNome(Var arrCampos: Array Of TCampoGlobal;
  strNomeCampo: String): TCampoGlobal;
  Var
    intContador: Integer;
    intTamMat: Integer;
Begin

  intContador := 0;
  intTamMat := Length(arrCampos);

  While intContador < intTamMat Do
  Begin
    If arrCampos[intContador].strNomCam = strNomeCampo Then
    Begin
      Result := arrCampos[intContador];
      Break;
    End;
    Inc(intContador);
  End;

End;

procedure  TfrmAltPrecoGlobalCatalogo.pAlteraPrecoOuMargem;
Var
    intTblPrc: Integer;
Begin
  For intTblPrc := 1 To Length(arrRecTabelasPreco) Do
              Begin
                If (rdgTipAlt.ItemIndex = 0) Then
                Begin
                  arrRecTabelasPreco[intTblPrc].blnAltMarBru := True;
                  arrRecTabelasPreco[intTblPrc].blnAltPreven := False;
                End
                Else
                Begin
                  arrRecTabelasPreco[intTblPrc].blnAltMarBru := False;
                  arrRecTabelasPreco[intTblPrc].blnAltPreven := True;
                End;
              End;
End;

procedure  TfrmAltPrecoGlobalCatalogo.pZeraPrecoOuMargem;
Var
    intTblPrc: Integer;
Begin
  SetLength(arrCamposGrid, 0);
  For intTblPrc := 1 To Length(arrRecTabelasPreco) Do
  Begin
      arrRecTabelasPreco[intTblPrc].blnAltMarBru := False;
      arrRecTabelasPreco[intTblPrc].blnAltPreven := False;
  End;
End;

{******************************************}
{* GERA A TABELA TEMPORARIA COM OS CAMPOS *}
{* ALTERADOS E SEUS NOVOS VALORES         *}
{***************************************MV*}
function TfrmAltPrecoGlobalCatalogo.fGeraTabelaItens: Boolean;
  Var

    strSQL    : String;
    intTamMat : Integer;
    qryGenIte : TUniQuery;

    strProduto: String;

    intContador     : Integer;
    intTblPrc       : Integer;
    strCamAtu       : String;
    varValAtu       : Variant;
    varValorRegAtual: Variant;

    fltNovPreVen: Double;
    fltPreCusNov: Double;

    blnAltPrecus: Boolean;

    arrRegistroAtual: Array Of TCampoGlobal;

    cpcParams : TParCalculaPrecoCusto;

    procedure pAdicionaCampoGrid(strNomeCampo: String);
      Var
        intTamMatCampos: Integer;
        intContador: Integer;
        campo: TCampoGlobal;
    begin
      intTamMatCampos := Length(arrCamposGrid);

      For intContador := 0 To intTamMatCampos -1 Do
        If arrCamposGrid[intContador].strNomCam = strNomeCampo Then
          Exit;

      campo := fRetornaCampoPorNome(arrCamposGlobal, strNomeCampo);

      If Not Campo.strNomCam.IsEmpty Then
      Begin
        SetLength(arrCamposGrid, intTamMatCampos+1);
        arrCamposGrid[intTamMatCampos] := fRetornaCampoPorNome(arrCamposGlobal, strNomeCampo);
      End;
    end;

    function fPrecoVenda(intOpc, intTabPrc: Integer): Double;
    begin
      Result := fCalculaPrecoVenda(intOpc, fRetornaCampoPorNome(arrRegistroAtual, 'CAT_PRECUS_NOV').varValCam + fRetornaCampoPorNome(arrRegistroAtual, 'CAT_OUTVAL_NOV').varValCam,
                                           fRetornaCampoPorNome(arrRegistroAtual, 'CAT_PREVE' + IntToStr(intTabPrc) + '_NOV').varValCam,
                                           fRetornaCampoPorNome(arrRegistroAtual, 'CAT_MARBR' + IntToStr(intTabPrc) + '_NOV').varValCam,
                                           fRetornaCampoPorNome(arrRegistroAtual, 'CAT_ICMSAI_NOV').varValCam,
                                           fRetornaCampoPorNome(arrRegistroAtual, 'CAT_IMPFED_NOV').varValCam,
                                           fRetornaCampoPorNome(arrRegistroAtual, 'CAT_DESOPE_NOV').varValCam,
                                           fRetornaCampoPorNome(arrRegistroAtual, 'CAT_COMTB' + IntToStr(intTabPrc) + '_NOV').varValCam);
    end;

Begin

  Try

    pZeraPrecoOuMargem;  
    qryGenIte := fCriaQuery(Self);
    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
    Result := True;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  C.CAT_CODFOR, ';

    If (rdgAltCat.ItemIndex = 0) Or (rdgAltCat.ItemIndex = 2) Then
    Begin
      strSQL := strSQL + '  I.ITE_CODITE, ';
      strSQL := strSQL + '  I.ITE_REFERE, ';
    End
    Else
    Begin
      strSQL := strSQL + '  CAST("" AS CHAR(5)) AS ITE_CODITE, ';
      strSQL := strSQL + '  CAST("" AS CHAR(16)) AS ITE_REFERE, ';
    End;

    strSQL := strSQL + '  C.CAT_CODFAB AS CAT_CODITE, ';
    strSQL := strSQL + '  C.CAT_DESITE,  ';
    strSQL := strSQL + '  C.CAT_PESOIT,  ';
    strSQL := strSQL + '  C.CAT_PESOIT AS "CAT_PESOIT_NOV", ';
    strSQL := strSQL + '  C.CAT_PESLIQ, ';
    strSQL := strSQL + '  C.CAT_PESLIQ AS "CAT_PESLIQ_NOV", ';
    strSQL := strSQL + '  C.CAT_CODABF, ';
    strSQL := strSQL + '  C.CAT_CODABF AS "CAT_CODABF_NOV", ';
(*
    strSQL := strSQL + '  C.CAT_EMBALA, ';
    strSQL := strSQL + '  C.CAT_EMBALA AS "CAT_EMBALA_NOV", ';
*)    
    strSQL := strSQL + '  C.CAT_PRECOM, ';
    strSQL := strSQL + '  C.CAT_PRECOM AS "CAT_PRECOM_NOV", ';
    strSQL := strSQL + '  C.CAT_PREVE1, ';
    strSQL := strSQL + '  C.CAT_PREVE1 AS "CAT_PREVE1_NOV", ';
    strSQL := strSQL + '  C.CAT_PREVE2, ';
    strSQL := strSQL + '  C.CAT_PREVE2 AS "CAT_PREVE2_NOV", ';
    strSQL := strSQL + '  C.CAT_PREVE3, ';
    strSQL := strSQL + '  C.CAT_PREVE3 AS "CAT_PREVE3_NOV", ';
    strSQL := strSQL + '  C.CAT_PREVE4, ';
    strSQL := strSQL + '  C.CAT_PREVE4 AS "CAT_PREVE4_NOV", ';
    strSQL := strSQL + '  C.CAT_PREVE5, ';
    strSQL := strSQL + '  C.CAT_PREVE5 AS "CAT_PREVE5_NOV", ';
    strSQL := strSQL + '  C.CAT_PREVE6, ';
    strSQL := strSQL + '  C.CAT_PREVE6 AS "CAT_PREVE6_NOV", ';
    strSQL := strSQL + '  C.CAT_PREVE7, ';
    strSQL := strSQL + '  C.CAT_PREVE7 AS "CAT_PREVE7_NOV", ';
    strSQL := strSQL + '  C.CAT_DESF01, ';
    strSQL := strSQL + '  C.CAT_DESF01 AS "CAT_DESF01_NOV", ';
    strSQL := strSQL + '  C.CAT_DESF02, ';
    strSQL := strSQL + '  C.CAT_DESF02 AS "CAT_DESF02_NOV", ';
    strSQL := strSQL + '  C.CAT_DESF03, ';
    strSQL := strSQL + '  C.CAT_DESF03 AS "CAT_DESF03_NOV", ';
    strSQL := strSQL + '  C.CAT_DESF04, ';
    strSQL := strSQL + '  C.CAT_DESF04 AS "CAT_DESF04_NOV", ';
    strSQL := strSQL + '  C.CAT_DESF05, ';
    strSQL := strSQL + '  C.CAT_DESF05 AS "CAT_DESF05_NOV", ';
    strSQL := strSQL + '  C.CAT_DESF06, ';
    strSQL := strSQL + '  C.CAT_DESF06 AS "CAT_DESF06_NOV", ';
    strSQL := strSQL + '  C.CAT_SUBFED, ';
    strSQL := strSQL + '  C.CAT_SUBFED AS "CAT_SUBFED_NOV", ';
    strSQL := strSQL + '  C.CAT_DESADB, ';
    strSQL := strSQL + '  C.CAT_DESADB AS "CAT_DESADB_NOV", ';
    strSQL := strSQL + '  C.CAT_VALFRE, ';
    strSQL := strSQL + '  C.CAT_VALFRE AS "CAT_VALFRE_NOV", ';
    strSQL := strSQL + '  C.CAT_OUTVAL, ';
    strSQL := strSQL + '  C.CAT_OUTVAL AS "CAT_OUTVAL_NOV", ';
    strSQL := strSQL + '  C.CAT_DESOPE, ';
    strSQL := strSQL + '  C.CAT_DESOPE AS "CAT_DESOPE_NOV", ';
    strSQL := strSQL + '  C.CAT_IMPFED, ';
    strSQL := strSQL + '  C.CAT_IMPFED AS "CAT_IMPFED_NOV", ';
    strSQL := strSQL + '  C.CAT_ICMSAI, ';
    strSQL := strSQL + '  C.CAT_ICMSAI AS "CAT_ICMSAI_NOV", ';
    strSQL := strSQL + '  C.CAT_ICMENT, ';
    strSQL := strSQL + '  C.CAT_ICMENT AS "CAT_ICMENT_NOV", ';
    strSQL := strSQL + '  C.CAT_IPIENT, ';
    strSQL := strSQL + '  C.CAT_IPIENT AS "CAT_IPIENT_NOV", ';
    strSQL := strSQL + '  C.CAT_FREENT, ';
    strSQL := strSQL + '  C.CAT_FREENT AS "CAT_FREENT_NOV", ';
    strSQL := strSQL + '  C.CAT_ACRFIN, ';
    strSQL := strSQL + '  C.CAT_ACRFIN AS "CAT_ACRFIN_NOV", ';
    strSQL := strSQL + '  C.CAT_SUBSTI, ';
    strSQL := strSQL + '  C.CAT_SUBSTI AS "CAT_SUBSTI_NOV", ';
    strSQL := strSQL + '  C.CAT_PRECUS, ';
    strSQL := strSQL + '  C.CAT_PRECUS AS "CAT_PRECUS_NOV", ';
    strSQL := strSQL + '  C.CAT_MARBR1, ';
    strSQL := strSQL + '  C.CAT_MARBR1 AS "CAT_MARBR1_NOV", ';
    strSQL := strSQL + '  C.CAT_MARBR2, ';
    strSQL := strSQL + '  C.CAT_MARBR2 AS "CAT_MARBR2_NOV", ';
    strSQL := strSQL + '  C.CAT_MARBR3, ';
    strSQL := strSQL + '  C.CAT_MARBR3 AS "CAT_MARBR3_NOV", ';
    strSQL := strSQL + '  C.CAT_MARBR4, ';
    strSQL := strSQL + '  C.CAT_MARBR4 AS "CAT_MARBR4_NOV", ';
    strSQL := strSQL + '  C.CAT_MARBR5, ';
    strSQL := strSQL + '  C.CAT_MARBR5 AS "CAT_MARBR5_NOV", ';
    strSQL := strSQL + '  C.CAT_MARBR6, ';
    strSQL := strSQL + '  C.CAT_MARBR6 AS "CAT_MARBR6_NOV", ';
    strSQL := strSQL + '  C.CAT_MARBR7, ';
    strSQL := strSQL + '  C.CAT_MARBR7 AS "CAT_MARBR7_NOV", ';
    strSQL := strSQL + '  C.CAT_COMVAR, ';
    strSQL := strSQL + '  C.CAT_COMVAR AS "CAT_COMVAR_NOV", ';
    strSQL := strSQL + '  C.CAT_TCIFCU, ';
    strSQL := strSQL + '  C.CAT_TCIFCU AS "CAT_TCIFCU_NOV", ';
    strSQL := strSQL + '  C.CAT_TSCUST, ';
    strSQL := strSQL + '  C.CAT_TSCUST AS "CAT_TSCUST_NOV", ';
    strSQL := strSQL + '  C.CAT_DEPICO, ';
    strSQL := strSQL + '  C.CAT_DEPICO AS "CAT_DEPICO_NOV", ';
    strSQL := strSQL + '  C.CAT_DEICMS, ';
    strSQL := strSQL + '  C.CAT_DEICMS AS "CAT_DEICMS_NOV", ';
    strSQL := strSQL + '  C.CAT_FATREG, ';
    strSQL := strSQL + '  C.CAT_FATREG AS "CAT_FATREG_NOV"  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CATITE C ';

    If (rdgAltCat.ItemIndex In [0..1]) Then
    Begin
      strSQL := strSQL + IIF(rdgAltCat.ItemIndex = 1, 'LEFT', '') + ' JOIN CADITE I ON I.ITE_CODFOR = C.CAT_CODFOR ';
      strSQL := strSQL + '                                                         AND I.ITE_CODFAB = C.CAT_CODFAB ';
    End
    Else
    Begin
      strSQL := strSQL + 'LEFT JOIN CADITE I ON I.ITE_CODFOR = C.CAT_CODFOR ';
      strSQL := strSQL + '                  AND I.ITE_CODFAB = C.CAT_CODFAB ';
    End;

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '  TRUE ';

    If (rdgAltCat.ItemIndex = 1) Then
      strSQL := strSQL + ' AND I.ITE_CODITE IS NULL ';

    If Not fEmptyStr(edtDesIte.Text) Then
    Begin
      If (edtDesIte.Text <> '+1') Then
        strSQL := strSQL + '  AND C.CAT_DESITE LIKE :DESITE '
      Else
        strSQL := strSQL + '  AND LOCATE(C.CAT_CODFAB,:DESITE) > 0 ';
    End;

    If Not fEmptyStr(edtCodFor.Text) Then
      strSQL := strSQL + '  AND C.CAT_CODFOR = :CODFOR ';

    If Not fEmptyStr(edtClaIpi.Text) then
      strSQL := strSQL + '  AND C.CAT_CLAIPI = :CLAIPI ';

    With qryGenIte Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(edtDesIte.Text) Then
      Begin
        If (edtDesIte.Text <> '+1') Then
          ParamByName('DESITE').AsString := edtDesIte.Text + '%'
        Else
          pSetaParam(edtDesIte.Text,arrProduto,strProduto,'DESITE',qryGenIte);
      End;

      If Not fEmptyStr(edtCodFor.Text) Then
        ParamByName('CODFOR').AsString := edtCodFor.Text;

      If Not fEmptyStr(edtClaIpi.Text) Then
        ParamByName('CLAIPI').AsString := edtClaIpi.Text;

      Open;

      {*****************************************}
      {* CASO NÃO HAJA ITENS COM O FILTRO      *}
      {**************************************MV*}
      If IsEmpty Then
      Begin
        Result := False;
        fMensagem('', 'Não há dados itens para serem alterados!', ['&O k']);
        Exit;
      End;

      pgbProgresso.Visible := True;
      pgbProgresso.Max     := (RecordCount * Length(arrCamposTabela));

      While Not Eof Do
      Begin

        SetLength(arrRegistroAtual, 0);

        For intContador := 0 To FieldCount -1 Do
        Begin

          intTamMat := Length(arrRegistroAtual);
          SetLength(arrRegistroAtual, intTamMat+1);
          arrRegistroAtual[intTamMat].strNomCam := Fields[intContador].FieldName;
          arrRegistroAtual[intTamMat].varValCam := Fields[intContador].Value;

          If (Fields[intContador].DataType = ftString) Then
            arrRegistroAtual[intTamMat].strTipCam := 'VARCHAR'
          Else
            arrRegistroAtual[intTamMat].strTipCam := 'NUMERIC';

          If arrRegistroAtual[intTamMat].varValCam = Null Then
          Begin
            If (Fields[intContador].DataType = ftString) Then
              arrRegistroAtual[intTamMat].varValCam := ''
            Else
              arrRegistroAtual[intTamMat].varValCam := 0.0;
          End;

        End;

        intTamMat := Length(arrCamposTabela);

        intContador := 0;

        While intContador < intTamMat Do
        Begin

          blnAltPrecus := False;

          strCamAtu := arrCamposTabela[intContador].strNomCam;
          varValAtu := arrCamposTabela[intContador].varValCam;

          pAdicionaCampoGrid(strCamAtu);

          varValorRegAtual := fRetornaCampoPorNome(arrRegistroAtual, strCamAtu + '_NOV').varValCam;

          {*****************************************}
          {* RECLACULA PREÇO DE COMPRA             *}
          {**************************************MV*}
          If strCamAtu = 'CAT_PRECOM' Then
          Begin

            If blnAltPorFator Then
              pAtualizaValorCampo(arrRegistroAtual, 'CAT_PRECOM_NOV', varValorRegAtual * varValAtu)
            Else
              pAtualizaValorCampo(arrRegistroAtual, 'CAT_PRECOM_NOV', varValAtu);

            blnAltPrecus := True;
            pAlteraPrecoOuMargem;

          End

          {*****************************************}
          {* RECALCULA O PREÇO DE VENDA            *}
          {**************************************MV*}
          Else If (Pos('CAT_PREVE', strCamAtu) > 0) And (Length(strCamAtu) = 10) Then // ver (not blnAltPreve1)
          Begin
            intTblPrc := StrToInt(RightStr(strCamAtu, 1));

            If blnAltPorFator Then
              fltNovPreVen := varValorRegAtual * varValAtu
            Else
              fltNovPreVen := varValAtu;

            pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', fltNovPreVen);

            arrRecTabelasPreco[intTblPrc].fltMarBruNov := fPrecoVenda(2, intTblPrc);
            pAtualizaValorCampo(arrRegistroAtual, 'CAT_MARBR' + IntToStr(intTblPrc) + '_NOV', arrRecTabelasPreco[intTblPrc].fltMarBruNov);
            pAdicionaCampoGrid('CAT_MARBR' + IntToStr(intTblPrc));

          End

          {*****************************************}
          {* ALTERA CAMPOS QUE INFLUENCIAM DIRETA- *}
          {* MENTE NO PRECO DE CUSTO               *}
          {**************************************MV*}
          Else If (Pos('CAT_DESF', strCamAtu) > 0) Or
                  (strCamAtu = 'CAT_ICMENT')       Or
                  (strCamAtu = 'CAT_IPIENT')       Or
                  (strCamAtu = 'CAT_FREENT')       Or
                  (strCamAtu = 'CAT_SUBSTI')       Or
                  (strCamAtu = 'CAT_ACRFIN')       Or
                  (strCamAtu = 'CAT_SUBFED')       Or
                  (strCamAtu = 'CAT_DESADB')       Or
                  (strCamAtu = 'CAT_VALFRE')       Or
                  (strCamAtu = 'CAT_OUTVAL')       Or
                  (strCamAtu = 'CAT_DESOPE')       Or
                  (strCamAtu = 'CAT_IMPFED')       Or
                  (strCamAtu = 'CAT_TCIFCU')       Or
                  (strCamAtu = 'CAT_TSCUST')       Or
                  (strCamAtu = 'CAT_DEPICO')       Or
                  (strCamAtu = 'CAT_DEICMS')       Or
                  (strCamAtu = 'CAT_FATREG')       Then
          Begin
            pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', varValAtu);
            blnAltPrecus := True;
            pAlteraPrecoOuMargem;
          End

          {****************************************}
          {* ALTERA A MARGEM BRUTA                *}
          {*************************************MV*}
          Else If (Pos('CAT_MARBR', strCamAtu) > 0) And
                  (Length(strCamAtu) = 10) Then
          Begin

            intTblPrc := StrToInt(RightStr(strCamAtu, 1));

            If blnAltPorFator Then
              pAtualizaValorCampo(arrRegistroAtual, 'CAT_MARBR' + IntToStr(intTblPrc) + '_NOV', IIF(( (varValorRegAtual * varValAtu) > 99.99) And (Pos(fCfgSis('MARMKP'), '1_5_') > 0), 99.99, (varValorRegAtual * varValAtu)))
            Else
              pAtualizaValorCampo(arrRegistroAtual, 'CAT_MARBR' + IntToStr(intTblPrc) + '_NOV', IIF((varValAtu > 99.99) And (Pos(fCfgSis('MARMKP'), '1_5_') > 0), 99.99, varValAtu));

            arrRecTabelasPreco[intTblPrc].blnAltPreven := True;

          End

          {*****************************************}
          {* ALTERA O RESTANTE DOS CAMPOS          *}
          {**************************************MV*}
          Else
          Begin
            pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', varValAtu);
          End;

          {*****************************************}
          {* ALTERA O PREÇO DE CUSTO SE NECESSÁRIO *}
          {**************************************MV*}
          If blnAltPrecus Then
          Begin
            pAdicionaCampoGrid('CAT_PRECUS');

            {**********************************}
            {* CALCULA PREÇOS DE CUSTO        *}
            {*******************************JB*}
            With cpcParams Do
            Begin
              curPreCom := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_PRECOM_NOV').varValCam;
              curDesF01 := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_DESF01_NOV').varValCam;
              curDesF02 := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_DESF02_NOV').varValCam;
              curDesF03 := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_DESF03_NOV').varValCam;
              curDesF04 := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_DESF04_NOV').varValCam;
              curDesF05 := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_DESF05_NOV').varValCam;
              curDesF06 := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_DESF06_NOV').varValCam;

              curICMSEnt:= fRetornaCampoPorNome(arrRegistroAtual, 'CAT_ICMENT_NOV').varValCam;
              curIPIEnt := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_IPIENT_NOV').varValCam;
              curFrete  := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_FREENT_NOV').varValCam;
              curAcrFin := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_ACRFIN_NOV').varValCam;
              curSubsti := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_SUBSTI_NOV').varValCam;
              curDesAdb := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_DESADB_NOV').varValCam;
              curSubFed := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_SUBFED_NOV').varValCam;
              curValFre := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_VALFRE_NOV').varValCam;

              if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
              begin
                curTCIFCu := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_TCIFCU_NOV').varValCam;
                curTSCust := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_TSCUST_NOV').varValCam;
                curDePiCo := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_DEPICO_NOV').varValCam;
                curDeICMS := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_DEICMS_NOV').varValCam;
                curFatReg := fRetornaCampoPorNome(arrRegistroAtual, 'CAT_FATREG_NOV').varValCam;
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
            fltPreCusNov := cpcParams.fCalculaPrecoCusto();
            pAtualizaValorCampo(arrRegistroAtual, 'CAT_PRECUS_NOV', fltPreCusNov);
          End;

          {************************************************}
          {* ALTERA O PREÇO DE VENDA, MARGEM SE NECESSÁRIO*}
          {*********************************************MV*}
          For intTblPrc := 1 To Length(arrRecTabelasPreco) Do
          Begin
            If arrRecTabelasPreco[intTblPrc].blnAltPreven Then
            Begin
              pAdicionaCampoGrid('CAT_PREVE' + IntToStr(intTblPrc));
              arrRecTabelasPreco[intTblPrc].fltPreVenNov := fPrecoVenda(1, intTblPrc);
              pAtualizaValorCampo(arrRegistroAtual, 'CAT_PREVE' + IntToStr(intTblPrc) + '_NOV', arrRecTabelasPreco[intTblPrc].fltPreVenNov);
            End;

            If arrRecTabelasPreco[intTblPrc].blnAltMarBru Then
            Begin
              pAdicionaCampoGrid('CAT_MARBR' + IntToStr(intTblPrc));
              arrRecTabelasPreco[intTblPrc].fltMarBruNov := fPrecoVenda(2, intTblPrc);
              pAtualizaValorCampo(arrRegistroAtual, 'CAT_MARBR' + IntToStr(intTblPrc) + '_NOV', arrRecTabelasPreco[intTblPrc].fltMarBruNov);
            End;

          End;
          pgbProgresso.StepBy(1);
          Inc(intContador);
          Application.ProcessMessages;

        End;

        pAlteraValorTabelaItens(FieldByName('CAT_CODITE').AsString, arrRegistroAtual);
        Next;

      End;
      Close;

    End;

    pgbProgresso.Position := 0;
    pgbProgresso.Visible  := False;

  Finally
    FreeAndNil(cpcParams);
    FreeAndNil(qryGenIte);
  End;

End;

procedure TfrmAltPrecoGlobalCatalogo.pAtualizaValorCampo(Var arrCampos: Array Of TCampoGlobal;
  strNomeCampo: String; varValor: Variant);
  Var
    intContador: Integer;
    intTamMat: Integer;
Begin

  intContador := 0;

  intTamMat := Length(arrCampos);

  While intContador < intTamMat Do
  Begin
    If arrCampos[intContador].strNomCam = strNomeCampo Then
    Begin
      arrCampos[intContador].varValCam := varValor;
      Break;
    End;
    Inc(intContador);
  End;

End;

function TfrmAltPrecoGlobalCatalogo.fGeraVetorCampos: Boolean;
  Var
    intTamMat: Integer;
Begin

  SetLength(arrCamposTabela, 0);

  With cdsConsulta Do
  Begin

    First;

    While Not Eof Do
    Begin

      If (FieldByName('ITE_ALTERA').AsString <> 'S') Then
      Begin
        Next;
        Continue;
      End;

      pAtualizaValorCampo(arrCamposGlobal, FieldByName('ITE_NOMCAM').AsString, FieldByName('ITE_VALCAM').Value);

      intTamMat := Length(arrCamposTabela);
      SetLength(arrCamposTabela, intTamMat+1);

      arrCamposTabela[intTamMat].strDesCam := FieldByName('ITE_DESCAM').AsString;
      arrCamposTabela[intTamMat].varValCam := FieldByName('ITE_VALCAM').Value;
      arrCamposTabela[intTamMat].strMasCam := FieldByName('ITE_MASCAM').AsString;
      arrCamposTabela[intTamMat].strNomCam := FieldByName('ITE_NOMCAM').AsString;
      arrCamposTabela[intTamMat].strDesAbr := FieldByName('ITE_DESABR').AsString;
      arrCamposTabela[intTamMat].intLimCam := FieldByName('ITE_LIMCAM').AsInteger;
      arrCamposTabela[intTamMat].strTipCam := FieldByName('ITE_TIPCAM').AsString;

      Next;

    End;

  End;

  Result := (Length(arrCamposTabela) > 0);

End;

procedure TfrmAltPrecoGlobalCatalogo.pAlteraValorTabelaItens(strCodIte: String;
  Var arrCampos: Array Of TCampoGlobal);
  Var
    intTamMat  : Integer;
    intContador: Integer;

Begin

  intTamMat := Length(arrCampos);

  With cdsItens Do
  Begin
    Insert;
    FieldByName('CAT_MARDES').AsString := 'M';

    intContador := 0;

    While intContador < intTamMat Do
    Begin

      If Pos('CHAR', arrCampos[intContador].strTipCam) > 0 Then
        FieldByName(arrCampos[intContador].strNomCam).Value := arrCampos[intContador].varValCam
      Else
        FieldByName(arrCampos[intContador].strNomCam).AsFloat := fStrToFloat(arrCampos[intContador].varValCam);

      Inc(intContador);

    End;

    Post;
  End;

End;

procedure TfrmAltPrecoGlobalCatalogo.pDeletaTabelaItens;

Begin
  If cdsItens.Active Then
    cdsItens.EmptyDataSet;
End;

procedure TfrmAltPrecoGlobalCatalogo.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
Begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, qryConFor, Key, arrSel) Then  
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

End;

procedure TfrmAltPrecoGlobalCatalogo.edtCamAltKeyPress(Sender: TObject;
  var Key: Char);
Begin
  inherited;

  If Not fEntraCons(Key) Then
  Begin
    Exit;
  End;

  If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Then
    Exit;

  If cdsConsulta.FieldByName('ITE_NOMCAM').AsString = 'CAT_CODABF' Then
  Begin
    If fPesqAbrevFiscal(Self, edtCamAlt, Nil, qryAbfIcm, Key, arrCodAbr, True) Then
    Begin
      If fValidaCampos(edtCamAlt, True) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
    End;
  End;

  Key := #0;

  If cdsConsulta.FieldByName('ITE_NOMCAM').AsString = 'CAT_CODFOR' Then
    edtCodForKeyPress(nil, Key);
End;

procedure TfrmAltPrecoGlobalCatalogo.dbgTiposAltDblClick(Sender: TObject);
  Var
    Key: Word;
    State: TShiftState;
Begin
  inherited;
  Key := VK_Return;
  dbgTiposAltKeyDown(Sender, Key, State);
End;

procedure TfrmAltPrecoGlobalCatalogo.FormShow(Sender: TObject);
  function fSoma(Var intVal : Integer; intSoma : Integer = 1) : Integer;
  Begin
    intVal := intVal + intSoma;
    Result := intVal + 1;
  End;

  Var
    strMasVal: String;
    strMasFat: String;
    strMasPer: String;
    intPosMat: Integer;
    intTabPre: Integer;
    intCnt : Integer;
Begin
  inherited;

  blnBloPre := fCfgSis('BLOPRE', varBoolean);

  If blnBloPre Then
  Begin
    rdgTipAlt.Controls[0].Enabled := False;
    rdgTipAlt.ItemIndex := 1;
  End;

  lblCamAlt.Caption := '';

  pAtribuiTabelas;

  strMasVal := fMskDigitos(fCfgSis('DECUNI', varInteger));
  strMasFat := '####0.0000';
  strMasPer := '##0.00';

  lblInfoFator.Visible := blnAltPorFator;

  {******************************************}
  {* CARREGA MATRIZ COM OS CAMPOS QUE PODEM *}
  {* SER ALTERADOS                          *}
  {***************************************JB*}
  intPosMat := 0;
  SetLength(arrCamposGlobal, 1);

  {*********************}
  {* PREÇO DE COMPRA   *}
  {******************LU*}
  arrCamposGlobal[intPosMat].strDesCam := 'Preço de Compra';
  arrCamposGlobal[intPosMat].varValCam := 0.0;

  If blnAltPorFator Then
  Begin
    arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
  End
  Else
  Begin
    arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
  End;

  arrCamposGlobal[intPosMat].strNomCam := 'CAT_PRECOM';
  arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Compra';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';

  SetLength(arrCamposGlobal, fSoma(intPosMat));

  {*****************************************}
  {* PREÇO - CASO ESTEJA NA CONFIGURAÇÃO   *}
  {**************************************CI*}

  For intTabPre := Length(VS_strTabPrc) DownTo 1 Do
  Begin

    If (VS_strTabPrc[intTabPre] = 'S') And (Not blnBloPre) Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := 'Preço de Venda ' + IntToStr(intTabPre);
      arrCamposGlobal[intPosMat].varValCam := 0.0;


      If blnAltPorFator Then
      Begin
        arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
      End
      Else
      Begin
        arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
      End;

      arrCamposGlobal[intPosMat].strNomCam := 'CAT_PREVE' + IntToStr(intTabPre);
      arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Venda ' + IntToStr(intTabPre);
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
      SetLength(arrCamposGlobal, fSoma(intPosMat));

    End;
  End;

  {*****************************************}
  {* MARGEM - CASO ESTEJA NA CONFIGURAÇÃO  *}
  {**************************************CI*}

  For intTabPre := Length(VS_strTabPrc) DownTo 1 Do
  Begin

    If (VS_strTabPrc[intTabPre] = 'S') And (Not blnBloPre) Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Margem Bruta ' + IntToStr(intTabPre);
      arrCamposGlobal[intPosMat].varValCam := 0.0;

      If blnAltPorFator Then
      Begin
        arrCamposGlobal[intPosMat].strMasCam := strMasPer;
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      End
      Else
      Begin
        arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fRetPrecisaoMargemItem); //fMskDigitos(fCfgSis('DECUNI', varInteger));
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(fMskDigitos(fRetPrecisaoMargemItem));
      End;

      arrCamposGlobal[intPosMat].strNomCam := 'CAT_MARBR' + IntToStr(intTabPre);
      arrCamposGlobal[intPosMat].strDesAbr := '% Margem Bruta ' + IntToStr(intTabPre);
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
      SetLength(arrCamposGlobal, fSoma(intPosMat));

    End;
  End;

  {*********************}
  {* DESCONTO 1..6     *}
  {******************LU*}
  For intCnt := 6 DownTo 1 Do
  Begin
    arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 0' + IntToStr(intCnt);
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'CAT_DESF0' + IntToStr(intCnt);
    arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 0' + IntToStr(intCnt);
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  {*************************}
  {* IMPOSTOS FEDERAIS (-) *}
  {**********************RN*}
  arrCamposGlobal[intPosMat].strDesCam := '% Impostos Federais (-)';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_SUBFED';
  arrCamposGlobal[intPosMat].strDesAbr := '% Imp. Fed. (-)';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
  SetLength(arrCamposGlobal, fSoma(intPosMat));

  {**********************************}
  {* DECONTOS ADICIONAIS BOLETO (-) *}
  {*******************************RN*}
  arrCamposGlobal[intPosMat].strDesCam := '% ' + fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_DESADB';
  arrCamposGlobal[intPosMat].strDesAbr := '% ' + fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
  SetLength(arrCamposGlobal, fSoma(intPosMat));

  {*******************}
  {* VALOR FRETE (+) *}
  {****************RN*}
  arrCamposGlobal[intPosMat].strDesCam := fCfgSis('DESVFR') + ' (+)';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  If blnAltPorFator Then
  Begin
    arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
  End
  Else
  Begin
    arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
  End;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_VALFRE';
  arrCamposGlobal[intPosMat].strDesAbr := fCfgSis('DESVFR') + ' (+)';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
  SetLength(arrCamposGlobal, fSoma(intPosMat));


  {**********************}
  {* Outros Valores (+) *}
  {*******************RN*}
  arrCamposGlobal[intPosMat].strDesCam := fCfgSis('DOVCPP') + ' (+):';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  If blnAltPorFator Then
  Begin
    arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
  End
  Else
  Begin
    arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
  End;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_OUTVAL';
  arrCamposGlobal[intPosMat].strDesAbr := fCfgSis('DOVCPP') + ' (+):';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
  SetLength(arrCamposGlobal, fSoma(intPosMat));

  {*****************************}
  {* DESPESAS OPERACIONAIS (+) *}
  {**************************RN*}
  arrCamposGlobal[intPosMat].strDesCam := '% Despesas Operacionais (+)';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_DESOPE';
  arrCamposGlobal[intPosMat].strDesAbr := '% Des.Ope. (+)';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
  SetLength(arrCamposGlobal, fSoma(intPosMat));

  {*************************}
  {* IMPOSTOS FEDERAIS (+) *}
  {**********************RN*}
  arrCamposGlobal[intPosMat].strDesCam := '% Impostos Federais (+)';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_IMPFED';
  arrCamposGlobal[intPosMat].strDesAbr := '% Imp.Fed. (+)';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
  SetLength(arrCamposGlobal, fSoma(intPosMat));

  {*********************}
  {* ICMS ENTRADA      *}
  {******************LU*}
  arrCamposGlobal[intPosMat].strDesCam := '% ICMS Entrada';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_ICMENT';
  arrCamposGlobal[intPosMat].strDesAbr := '% ICMS Entrada';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
  SetLength(arrCamposGlobal, fSoma(intPosMat));

  {*********************}
  {* IPI ENTRADA       *}
  {******************LU*}
  arrCamposGlobal[intPosMat].strDesCam := '% IPI de Entrada';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_IPIENT';
  arrCamposGlobal[intPosMat].strDesAbr := '% IPI Entrada';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
  SetLength(arrCamposGlobal, fSoma(intPosMat));

  {*********************}
  {* FRETE ENTRADA     *}
  {******************LU*}
  arrCamposGlobal[intPosMat].strDesCam := '% Frete de Entrada';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_FREENT';
  arrCamposGlobal[intPosMat].strDesAbr := '% Frete Entrada';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
  SetLength(arrCamposGlobal, fSoma(intPosMat));

  {************************}
  {* ACRESCIMO FINANCEIRO *}
  {*********************LU*}
  arrCamposGlobal[intPosMat].strDesCam := '% Acréscimo Financeiro';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_ACRFIN';
  arrCamposGlobal[intPosMat].strDesAbr := '% Acresc.Financ.';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
  SetLength(arrCamposGlobal, fSoma(intPosMat));

  {*********************}
  {* SUBSTITUICAO TRIB *}
  {******************LU*}
  arrCamposGlobal[intPosMat].strDesCam := '% Substituição Tributária';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_SUBSTI';
  arrCamposGlobal[intPosMat].strDesAbr := '% Subst. Tributária';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
  SetLength(arrCamposGlobal, fSoma(intPosMat));

  {*********************}
  {* COMISSAO          *}
  {******************LU*}
  arrCamposGlobal[intPosMat].strDesCam := '% Comissão Varejo';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_COMVAR';
  arrCamposGlobal[intPosMat].strDesAbr := '% Comis.Varejo';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
  SetLength(arrCamposGlobal, fSoma(intPosMat));

  {*********************}
  {* PESO              *}
  {******************LU*}
  arrCamposGlobal[intPosMat].strDesCam := 'Peso Bruto';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  If blnAltPorFator Then
  Begin
    arrCamposGlobal[intPosMat].strMasCam := strMasFat;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
  End
  Else
  Begin
    arrCamposGlobal[intPosMat].strMasCam := '####0.0000';
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
  End;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_PESOIT';
  arrCamposGlobal[intPosMat].strDesAbr := 'Peso Bruto';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
  SetLength(arrCamposGlobal, fSoma(intPosMat));

  If fCfgSis('PESLIQ') = 'SOMA' Then
  Begin
    {*********************}
    {* PESO              *}
    {******************LU*}
    arrCamposGlobal[intPosMat].strDesCam := 'Peso Liq.';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasFat;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := '####0.0000';
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'CAT_PESLIQ';
    arrCamposGlobal[intPosMat].strDesAbr := 'Peso Liq.';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  {*******************}
  {* ABREV. FISCAL   *}
  {*******************}
  arrCamposGlobal[intPosMat].strDesCam := 'Abreviação Fiscal';
  arrCamposGlobal[intPosMat].varValCam := '';
  arrCamposGlobal[intPosMat].strMasCam := '';
  arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(03)';
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_CODABF';
  arrCamposGlobal[intPosMat].strDesAbr := 'Abrev. Fiscal';
  arrCamposGlobal[intPosMat].intLimCam := 3;
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
  SetLength(arrCamposGlobal, fSoma(intPosMat));

  {*********************}
  {* ICMS Saida        *}
  {*********************}
  arrCamposGlobal[intPosMat].strDesCam := '% ICMS Saída (+)';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_ICMSAI';
  arrCamposGlobal[intPosMat].strDesAbr := '% ICMS Saída (+)';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
  SetLength(arrCamposGlobal, fSoma(intPosMat));

(*
  {*********************}
  {* EMBALAGEM         *}
  {******************LU*}
  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := 'Embalagem';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  If blnAltPorFator Then
  Begin
    arrCamposGlobal[intPosMat].strMasCam := strMasFat;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
  End
  Else
  Begin
    arrCamposGlobal[intPosMat].strMasCam := '####0.0000';
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
  End;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_EMBALA';
  arrCamposGlobal[intPosMat].strDesAbr := 'Embalagem';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';
*)  

  pGerarTemporaria;

  {***********************************************************************************}
  {* PREÇO DE CUSTO                                                                  *}
  {* ESTE CAMPO DEVE SER CRIADO APÓS AS ATUALIZAÇÕES ACIMA PARA NÃO APARECER NO GRID *}
  {********************************************************************************LU*}
  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := 'Preço de Custo';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  If blnAltPorFator Then
  Begin
    arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger)); //strMasFat;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
  End
  Else
  Begin
    arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
  End;
  arrCamposGlobal[intPosMat].strNomCam := 'CAT_PRECUS';
  arrCamposGlobal[intPosMat].strDesAbr := 'Preço Custo';
  arrCamposGlobal[intPosMat].intLimCam := -1;
  arrCamposGlobal[intPosMat].strNomArq := 'CATITE';

End;

procedure TfrmAltPrecoGlobalCatalogo.edtDesIteKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
Begin
  inherited;

  If fPesqItem(conIteSimples, Self, nil, edtDesIte, qryItens, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
  Begin
    fvalidaCampos(edtDesIte,False);
    self.SelectNext(ActiveControl, True, True);
  End;

End;

function TfrmAltPrecoGlobalCatalogo.fTamanhoCampo(strCampo: String): Boolean;
  Var
    intTamanho: Integer;
Begin
  Result := False;

  If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Then
    Exit;

  intTamanho := cdsConsulta.FieldByName('ITE_LIMCAM').AsInteger;

  If Length(strCampo) > intTamanho Then
  Begin
    fMensagem('ATENÇÃO!', 'Número Máximo de Caracteres tem que ser igual á : '+ IntToStr(intTamanho), ['&O k']);
    Result := False;
  End
  Else
    Result := True;
End;

End.



