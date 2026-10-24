unit untAlteraEstMinMax;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, untCadLote, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, QColorLabel,
  untFuncoesSimples, strUtils, Math, ComCtrls, untTypesSistema,
  BitBtnLockedIncrem,  MemDS, DBAccess, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, Vcl.DBCtrls, DBMemoFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, untPaiOrdenaCxGrid, cxGridCitel,
  cxCheckBox;

type
  TfrmAlteraEstMinMax = class(TfrmPaiOrdenaCxGrid)
    Label1: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    Label2: TLabel;
    edtDesIte: TEditFocus;
    Label3: TLabel;
    edtRefere: TEditFocus;
    Label4: TLabel;
    edtCodUni: TEditFocus;
    Label6: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    Label8: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    Label5: TLabel;
    mskMesAno: TMaskEditFocus;
    rdgAtivo: TRadioGroup;
    prgProgresso: TProgressBar;
    Shape3: TShape;
    Label7: TLabel;
    shpMultSel: TShape;
    btnConfirmar: TBitBtnLocked;
    rdgMeses: TRadioGroup;
    lblPrdGru: TLabel;
    edtPrdGru: TEditFocus;
    edtDesPrdGru: TEditFocus;
    lblCodDep: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    Label9: TLabel;
    edtCodIte: TEditFocus;
    edtProdutos: TEditFocus;
    dbgConsultaCODEMP: TcxGridDBColumn;
    dbgConsultaCODITE: TcxGridDBColumn;
    dbgConsultaDESITE: TcxGridDBColumn;
    dbgConsultaREFERE: TcxGridDBColumn;
    dbgConsultaSIGUNI: TcxGridDBColumn;
    dbgConsultaSAIME0: TcxGridDBColumn;
    dbgConsultaSAIME1: TcxGridDBColumn;
    dbgConsultaSAIME2: TcxGridDBColumn;
    dbgConsultaSAIME3: TcxGridDBColumn;
    dbgConsultaSAIME4: TcxGridDBColumn;
    dbgConsultaSAIME5: TcxGridDBColumn;
    dbgConsultaSAIME6: TcxGridDBColumn;
    dbgConsultaSAIME7: TcxGridDBColumn;
    dbgConsultaSAIME8: TcxGridDBColumn;
    dbgConsultaSAIME9: TcxGridDBColumn;
    dbgConsultaSAIME10: TcxGridDBColumn;
    dbgConsultaSAIME11: TcxGridDBColumn;
    dbgConsultaSAIME12: TcxGridDBColumn;
    dbgConsultaMEDIAM: TcxGridDBColumn;
    dbgConsultaSALDOS: TcxGridDBColumn;
    dbgConsultaMLTCOM: TcxGridDBColumn;
    dbgConsultaALTMIN: TcxGridDBColumn;
    dbgConsultaALTMAX: TcxGridDBColumn;
    dbgConsultaLOCALT: TcxGridDBColumn;
    dbgConsultaSUPALT: TcxGridDBColumn;
    dbgConsultaFABALT: TcxGridDBColumn;
    dbgConsultaMINDIG: TcxGridDBColumn;
    dbgConsultaMAXDIG: TcxGridDBColumn;
    dbgConsultaPONPED: TcxGridDBColumn;
    dbgConsultaNIVGIR: TcxGridDBColumn;
    dbgConsultaALTERA: TcxGridDBColumn;
    Shape1: TShape;
    Label10: TLabel;
    Shape2: TShape;
    Label11: TLabel;
    Shape4: TShape;
    Label12: TLabel;
    lblPesquisa: TLabel;
    lblNomeCampo: TLabel;
    edtData: TMaskEditFocus;
    edtNumero: TEditFocus;
    edtString: TEditFocus;
    edtValor: TEditFocus;
    pnlAplicacao: TPanel;
    pnlAplica: TPanel;
    mmoAplica: TDBMemoFocus;
    btnCarregar: TBitBtnLocked;
    dbgConsultaDadosPONEXP: TcxGridDBColumn;
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure rdgAtivoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruExit(Sender: TObject);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodUniExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdgMesesClick(Sender: TObject);
    procedure rdgAtivoExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure dbgConsultaDBTableView1EditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure dbgConsultaDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    arrLinGru: TConsultasArray;
    arrEmpres: TConsultasArray;
    arrFornec: TConsultasArray;
    arrUnidad: TConsultasArray;
    arrMarca : TConsultasArray;
    arrPrdGru: TConsultasArray;
    arrCodDep: TConsultasArray;
    arrProdut: TConsultasArray;

    arrMesAno: Array of Record
      strAno,
      strMes: String;
    End;

    strLinGru,
    strEmpres,
    strFornec,
    strUnidad,
    strMarca,
    strPrdGru,
    strCodDep,
    strCodIte: String;

    blnCadLoc: Boolean;
    blnExiApl: Boolean;
    strTraLoc: String;
    objCadLot: TCadLot;

    qryUpdate: TUniQuery;

    FIndexInicialMesAno: Integer;

    Function fGravaItem: Boolean;
    Function fGravaEstoque: Boolean;
    Procedure pCalculaMeses;
    Procedure pAlteraNomeColunas;
//    Procedure pGravaLog;
    Procedure pUpdateItem;
    Procedure pLimpaPesquisa;

  public
    { Public declarations }
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fAbreConsulta(blnLike: Boolean = True): Boolean; override;
    Procedure pOrdenaClient; override;
  end;

var
  frmAlteraEstMinMax: TfrmAlteraEstMinMax;

implementation

uses untConsultas, untAltEst, untFuncoesConsulta, untGravando;

{$R *.dfm}

Const
  NRO_COL_ESTMIN = 21;
  NRO_COL_ESTMAX = 22;

Procedure TfrmAlteraEstMinMax.pUpdateItem;
Begin
  With qryUpdate, SQL Do
  Begin
    With cdsConsulta Do
      TAltEst.fGravaLog(Self,
                        FieldByName('CODITE').AsString,
                        FieldByName('CODEMP').AsString,
                        FieldByName('ALTMIN').AsFloat,
                        FieldByName('ALTMAX').AsFloat
                       );

    Clear;
    Add('UPDATE ITEGER');
    Add('SET ');
    Add('  ITE_ESTMIN = :SALMIN, ');
    Add('  ITE_ESTMAX = :SALMAX, ');
    Add('  ITE_LOCFIS = :LOCFIS, ');
    Add('  ITE_LOCSUP = :LOCSUP, ');
    Add('  ITE_MINDIG = :MINDIG, ');
    Add('  ITE_MAXDIG = :MAXDIG, ');
    Add('  ITE_PONPED = :PONPED, ');
    Add('  ITE_PONEXP = :PONEXP, ');
    Add('  ITE_NIVGIR = :NIVGIR  ');
    Add('WHERE ');
    Add('  ITE_CODITE = :CODITE AND ');
    Add('  ITE_CODEMP = :CODEMP     ');

    Close;
    ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('CODEMP').AsString;
    ParamByName('CODITE').AsString := cdsConsulta.FieldByName('CODITE').AsString;
    ParamByName('SALMIN').AsFloat  := cdsConsulta.FieldByName('ALTMIN').AsFloat;
    ParamByName('SALMAX').AsFloat  := cdsConsulta.FieldByName('ALTMAX').AsFloat;
    ParamByName('LOCFIS').AsString := cdsConsulta.FieldByName('LOCALT').AsString;
    ParamByName('LOCSUP').AsString := cdsConsulta.FieldByName('SUPALT').AsString;

    ParamByName('MINDIG').Value := cdsConsulta.FieldByName('MINDIG').Value;
    ParamByName('MAXDIG').Value := cdsConsulta.FieldByName('MAXDIG').Value;
    ParamByName('PONPED').Value := cdsConsulta.FieldByName('PONPED').Value;
    ParamByName('NIVGIR').Value := cdsConsulta.FieldByName('NIVGIR').Value;
    ParamByName('PONEXP').Value := cdsConsulta.FieldByName('PONEXP').Value;

    ExecSQL;

    Clear;
    Add(' UPDATE CADITE              ');
    Add(' SET ITE_CODFAB = :CODFAB   ');
    Add(' WHERE ITE_CODITE = :CODITE ');

    Close;
    ParamByName('CODITE').AsString := cdsConsulta.FieldByName('CODITE').AsString;
    ParamByName('CODFAB').AsString := cdsConsulta.FieldByName('FABALT').AsString;
    ExecSQL;

    fAtualizaBarFabIte(cdsConsulta.FieldByName('CODITE').AsString);
  End;
End;

{Procedure TfrmAlteraEstMinMax.pGravaLog;
Begin

  With qryUpdate, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM ALTEST WHERE FALSE');
    Close;
    Open;
    qryUpdate.Insert;

    FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ALTEST', VS_strCodEmp);

    FieldByName('LOG_CODEMP').AsString := cdsConsulta.FieldByName('CODEMP').AsString;
    FieldByName('LOG_CODITE').AsString := cdsConsulta.FieldByName('CODITE').AsString;

    FieldByName('LOG_MINANT').AsFloat  := cdsConsulta.FieldByName('ESTMIN').AsFloat;
    FieldByName('LOG_MINATU').AsFloat  := cdsConsulta.FieldByName('ALTMIN').AsFloat;

    FieldByName('LOG_MAXANT').AsFloat  := cdsConsulta.FieldByName('ESTMAX').AsFloat;
    FieldByName('LOG_MAXATU').AsFloat  := cdsConsulta.FieldByName('ALTMAX').AsFloat;

    FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
    FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
    FieldByName('LOG_HRAALT').AsDateTime := fTime();

    Post;
  End;
End;}

Function TfrmAlteraEstMinMax.fGravaItem: Boolean;
Begin
  Try
    fStartTransaction;

    pUpdateItem;
//    pGravaLog;

    fCommit;

    Result := True;
  Except
    on E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmAlteraEstMinMax.fGravaItem]');
      fRollBack;
    End;
  End;
End;

Function TfrmAlteraEstMinMax.fGravaEstoque: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  With cdsConsulta Do
  Begin
    If State = dsEdit Then
      Post;

    DisableControls;

    prgProgresso.Position := 0;
    prgProgresso.Max      := stlListSelecao.Count;
    prgProgresso.Visible  := True;

    For intContador := 0 To stlListSelecao.Count - 1 Do
      If Locate('AUTOINCREM', stlListSelecao[intContador], []) Then
      Begin
        Result := fGravaItem;

        prgProgresso.StepBy(1);
        Application.ProcessMessages;

        If Not Result Then
          Break;
      End;

    prgProgresso.Visible  := False;

    EnableControls;
  End;

End;

procedure TfrmAlteraEstMinMax.btnCarregarClick(Sender: TObject);
begin
  inherited;
  fAbreConsulta;
  pFreeAndNil(frmGravando);
end;

procedure TfrmAlteraEstMinMax.btnConfirmarClick(Sender: TObject);
begin
  inherited;


  If fGravaEstoque Then
  Begin
    pMensagemOk('Alterações realizadas com sucesso!');
    pDesmarcaTodos;
    pSetFocus(mskLinGru);
    pLimpaPesquisa;
    If cdsConsulta.Active = True then
       cdsConsulta.Close;
  End;
end;

procedure TfrmAlteraEstMinMax.cdsConsultaBeforePost(DataSet: TDataSet);
  Var
    strItem  : String;
    strLote  : String;
    fltSalIte: Double;
    Result   : Boolean;
begin
  inherited;

  With DataSet Do
  Begin

    If FieldByName('ALTMIN').AsFloat < 0 Then
    Begin
      pMensagemOk('O estoque mínimo deve ser maior ou igual a zero!');
      Abort;
    End;

    If FieldByName('ALTMAX').AsFloat < 0 Then
    Begin
      pMensagemOk('O estoque máximo deve ser maior ou igual a zero!');
      Abort;
    End;

    If FieldByName('ALTMAX').AsFloat < FieldByName('ALTMIN').AsFloat Then
    Begin
      pMensagemOk('O estoque máximo deve ser maior ou igual ao estoque mínimo!');
      Abort;
    End;

    If FieldByName('MAXDIG').AsFloat < FieldByName('MINDIG').AsFloat Then
    Begin
      pMensagemOk('O estoque máximo digitado não pode ser menor que o mínimo digitado!');
      Abort;
    End;

    FieldByName('LOCALT').AsString := UpperCase( FieldByName('LOCALT').AsString );
    FieldByName('SUPALT').AsString := UpperCase( FieldByName('SUPALT').AsString );
    FieldByName('FABALT').AsString := UpperCase( FieldByName('FABALT').AsString );

    Result := True;
    If blnCadLoc Then
    Begin

      If (Not fEmptyStr(FieldByName('LOCALT').AsString)) Then
      Begin

        If fEmptyStr(fRetNomLocFisica(FieldByName('LOCALT').AsString, FieldByName('CODEMP').AsString)) Then
        Begin
          pMensagemOk('Localização Física não encontrada!');
          Result := False;
        End;

        If (strTraLoc <> 'N') And (Result) Then
        Begin

          If objCadLot.fTemProdutoComLocFisica(FieldByName('LOCALT').AsString, strItem, fltSalIte, fltSalIte, FieldByName('CODITE').AsString) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' já está cadastrado com essa localização física!');
            If (strTraLoc = 'T') Then
              Result := False;
          End

          Else If objCadLot.fTemLoteComLocFisica(FieldByName('LOCALT').AsString, strItem, strLote, fltSalIte, fltSalIte) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' (' + objCadLot.strTitLab + strLote + ') já está cadastrado com essa localização física!');
            If (strTraLoc = 'T') Then
              Result := False;
          End;

        End;

      End;

      If (Not fEmptyStr(FieldByName('SUPALT').AsString)) Then
      Begin

        If fEmptyStr(fRetNomLocFisica(FieldByName('SUPALT').AsString, FieldByName('CODEMP').AsString)) Then
        Begin
          pMensagemOk('Localização Física não encontrada!');
          Result := False;
        End;

        If (strTraLoc <> 'N') And (Result) Then
        Begin

          If objCadLot.fTemProdutoComLocFisica(FieldByName('SUPALT').AsString, strItem, fltSalIte, fltSalIte, FieldByName('CODITE').AsString) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' já está cadastrado com essa localização física!');
            If (strTraLoc = 'T') Then
              Result := False;
          End

          Else If objCadLot.fTemLoteComLocFisica(FieldByName('SUPALT').AsString, strItem, strLote, fltSalIte, fltSalIte) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' (' + objCadLot.strTitLab + strLote + ') já está cadastrado com essa localização física!');
            If (strTraLoc = 'T') Then
              Result := False;
          End;

        End;

      End;

    End;

    If Not Result Then Abort;

    If ((RoundTo(FieldByName('ESTMIN').AsFloat, -3) <> RoundTo(FieldByName('ALTMIN').AsFloat, -3)) Or
        (RoundTo(FieldByName('ESTMAX').AsFloat, -3) <> RoundTo(FieldByName('ALTMAX').AsFloat, -3)) Or
        (FieldByName('LOCFIS').AsString <> FieldByName('LOCALT').AsString) Or
        (FieldByName('LOCSUP').AsString <> FieldByName('SUPALT').AsString) Or
        (FieldByName('CODFAB').AsString <> FieldByName('FABALT').AsString)) Or
        (FieldByName('NIVGIR').OldValue <> FieldByName('NIVGIR').NewValue) Or
        (FieldByName('MINDIG').OldValue <> FieldByName('MINDIG').NewValue) Or
        (FieldByName('MAXDIG').OldValue <> FieldByName('MAXDIG').NewValue) Or
        (FieldByName('PONPED').OldValue <> FieldByName('PONPED').NewValue) Or
        (FieldByName('PONEXP').OldValue <> FieldByName('PONEXP').NewValue) Then
    Begin
      If (Not fInLista) Then
      Begin
        pAddListaQuery;  // adiciona
        FieldByName('ALTERA').AsString := 'S';
      End;
    End

    Else If fInLista Then
    Begin
      pAddListaQuery;  // retira
      FieldByName('ALTERA').AsString := 'N';
    End;
  End;
end;

procedure TfrmAlteraEstMinMax.dbgConsultaDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var fltQtdMedia, fltEstMin, fltEstMax: Double;
    strAltera, strQtdMedia, strEstMin, strEstMax: String;
begin
  inherited;

  strQtdMedia := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgConsultaMEDIAM.Index]);
  strEstMin   := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgConsultaALTMIN.Index]);
  strEstMax   := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgConsultaALTMAX.Index]);
  strAltera   := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgConsultaALTERA.Index]);

  fltQtdMedia := StrToFloatDef(strQtdMedia, 0);
  fltEstMin   := StrToFloatDef(strEstMin, 0);
  fltEstMax   := StrToFloatDef(strEstMax, 0);

  if strAltera = 'S' Then
  Begin
    ACanvas.Brush.Color := clAqua;
    If AViewInfo.Selected Then
    Begin
      ACanvas.Font.Color := clBlack;
      ACanvas.Font.Style := [fsBold];
    End;
  End Else
  Begin
    { VERMELHO }
    if fltQtdMedia > fltEstMax Then

    Begin
      ACanvas.Brush.Color := clRed;
      ACanvas.Font.Style := [fsBold];
    End;

    { AMARELO }
    if (fltQtdMedia >= fltEstMin) and (fltQtdMedia <= fltEstMax) Then
    Begin
      ACanvas.Brush.Color := clYellow;
      ACanvas.Font.Style := [fsBold];
    End;

    { AZUL }
    if (fltQtdMedia < fltEstMin) Then
    Begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.Font.Style := [fsBold];
    End;
  End;

end;

procedure TfrmAlteraEstMinMax.dbgConsultaDBTableView1EditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: If (cdsConsulta.State = dsEdit) Then
               Begin
                 If  dbgConsultaALTMIN.Focused Then
                   dbgConsultaALTMAX.Focused := True
                 Else If dbgConsultaALTMAX.Focused Then
                 Begin
                   //cxConsultaDBTableView1.Navigator.Buttons.Next.Click;
                   cdsConsulta.Next;
                   dbgConsultaALTMIN.Focused := True;
                 End;
               End;
  End;
end;

procedure TfrmAlteraEstMinMax.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrCodDep, fRetNomDep, nil, 'do Departamento');
end;

procedure TfrmAlteraEstMinMax.edtCodDepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrCodDep, False) Then
  Begin
    If fValidaCampos(edtCodDep, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteraEstMinMax.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmp,edtNomEmp,arrEmpres,fRetNomeEmpresa,nil,'da Empresa');
  
end;

procedure TfrmAlteraEstMinMax.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples,
                  Self,
                  edtCodEmp,
                  edtNomEmp,
                  Nil,
                  Key,
                  arrEmpres,
                  False,
                  True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAlteraEstMinMax.edtCodForExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodFor,edtNomFor,arrFornec,fRetNomFornecedor,nil,'do Fornecedor');

end;

procedure TfrmAlteraEstMinMax.edtCodForKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples,
                     Self,
                     edtCodFor,
                     edtNomFor,
                     Nil,
                     Key,
                     arrFornec,
                     False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAlteraEstMinMax.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte, edtProdutos, arrProdut, Nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmAlteraEstMinMax.edtCodIteKeyPress(Sender: TObject; var Key: Char);
begin
 inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtProdutos, Nil, Key, arrProdut, False) then
    Begin
      fValidaCampos(edtProdutos, True);
      Self.SelectNext(ActiveControl, True, True);
    End;

  End;

end;

procedure TfrmAlteraEstMinMax.edtCodMarExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodMar,edtDesMar,arrMarca,fRetNomMarca,nil,'da Marca');

end;

procedure TfrmAlteraEstMinMax.edtCodMarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self,
                 edtCodMar,
                 edtDesMar,
                 Nil,
                 Key,
                 arrMarca,
                 False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAlteraEstMinMax.edtCodUniExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodUni,Nil,arrUnidad,fRetNomUnidade,nil,'da Unidade');

end;

procedure TfrmAlteraEstMinMax.edtCodUniKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self,
                  edtCodUni,
                  Nil,
                  Nil,
                  Nil,
                  Key,
                  arrUnidad,
                  False) Then
  Begin
    if fvalidaCampos(edtCodUni,False) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAlteraEstMinMax.edtPrdGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPrdGru, edtDesPrdGru, arrPrdGru, fRetNomeGrupoProduto, nil, 'do Grupo de Produtos', edtPrdGru.MaxLength);
end;

procedure TfrmAlteraEstMinMax.edtPrdGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdGru, Nil, Key, arrPrdGru, False) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteraEstMinMax.FormCreate(Sender: TObject);
var
  intContador: Integer;
  strColuna: String;
  blnVisivel: Boolean;
begin
  inherited;

  pVerificaProCod;
  qryUpdate := fCriaQuery(Self);
  edtCodIte.TamCampo := fTamCodIte;
  edtCodMar.TamCampo := fTamCodMar;

  intDigDec           := 3;
  blnTemSelecao       := False;
  blnTemMarcacao      := True;
  blnQuoteLista       := False;
  blnSempreRelerBanco := False;
  blnTemPesquisa      := False;
  blnPassarRadioButtonComEnter := False;
  lflLastField.intIndCol := 2;
  lflLastField.strNomCam := dbgConsultaDados.Columns[2].DataBinding.FieldName;
  lflLastField.strNomCol := dbgConsultaDados.Columns[2].Caption;

  lflLastField.ftyTipCam := ftString;

  mskMesAno.Text := RightStr(DateToStr(VS_Date), 7);

  blnCadLoc := fCfgSis('CADLOC', varBoolean);
  strTraLoc := fCfgSIs('TRALOC');
  objCadLot := TCadLot.Create(Self);
  blnExiApl := fCfgSis('EXIAPL', varBoolean);

  If blnExiApl Then
  Begin
    pnlAplicacao.Visible := True;
    mmoAplica.DataSource := dtsConsulta;
  End;


  blnVisivel := fCfgSis('MINDIG', varBoolean);
  for intContador := 0 to dbgConsultaDados.ColumnCount -1 do
  Begin
    strColuna := dbgConsultaDados.Columns[intContador].DataBinding.FieldName;
    if Pos(strColuna, 'MINDIG-MAXDIG-PONPED-PONPED') > 0 then
      dbgConsultaDados.Columns[intContador].Visible := blnVisivel;
  End;
  FIndexInicialMesAno := 7;
end;

procedure TfrmAlteraEstMinMax.FormDestroy(Sender: TObject);
begin
  inherited;
  blnPassarRadioButtonComEnter := True;
end;

procedure TfrmAlteraEstMinMax.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_F10   : btnConfirmar.Click;
  End;

  inherited;
end;

procedure TfrmAlteraEstMinMax.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskLinGru);
end;

procedure TfrmAlteraEstMinMax.mskLinGruExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo',6);
end;

procedure TfrmAlteraEstMinMax.mskLinGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self,
                mskLinGru,
                edtDesGru,
                Nil,
                Key,
                arrLinGru,
                False) Then
  Begin
    if fValidaCampos(mskLinGru, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmAlteraEstMinMax.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskLinGru) Then
    Begin
      pDesmarcaLista(mskLinGru, arrLinGru, '', 6)
    End

    Else If (Sender = edtDesIte) Then
    Begin

    End

    Else If (Sender = edtRefere) Then
    Begin

    End

    Else If (Sender = edtCodUni) Then
    Begin
      pDesmarcaLista(edtCodUni, arrUnidad);
    End

    Else If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar, arrMarca);
    End

    Else If (Sender = edtCodFor) Then
    Begin
      pDesmarcaLista(edtCodFor, arrFornec);
    End

    Else If (Sender = edtPrdGru) Then
    Begin
      pDesmarcaLista(edtPrdGru, arrPrdGru);
    End

    Else If (Sender = edtCodDep) Then
    Begin
      pDesmarcaLista(edtCodDep, arrCodDep);
    End

    Else If (Sender = edtCodIte) Then
    Begin
      pDesmarcaLista(edtCodIte, arrProdut);
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If (Not fEmptyStr(edtCodEmp.Text)) And (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0) And (edtNomEmp.Text <> '+1') Then
      Begin
        fMensagem('', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = mskMesAno) Then
    Begin
      Result := fValidaMesAno(mskMesAno, 'Informe o mês para processar o giro dos últimos três meses!');
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Procedure TfrmAlteraEstMinMax.pCalculaMeses;
  Var
    intContador,
    intAno,
    intMes: Integer;
Begin
  case rdgMeses.ItemIndex of
    0: SetLength(arrMesAno, 3);
    1: SetLength(arrMesAno, 6);
    2: SetLength(arrMesAno, 12);
  end;

  With arrMesAno[High(arrMesAno)] Do
  Begin
    strAno := RightStr(mskMesAno.Text, 4);
    strMes := LeftStr(mskMesAno.Text, 2);

    intAno := StrToInt(strAno);
    intMes := StrToInt(strMes);
  End;

  For intContador := High(arrMesAno) DownTo Low(arrMesAno) Do
  With arrMesAno[intContador] Do
  Begin
    If intMes = 1 Then
    Begin
      intMes := 12;
      Dec(intAno);
    End Else
    Begin
      Dec(intMes);
    End;

    strAno := IntToStr(intAno);
    strMes := fStrZero(IntToStr(intMes), 2);
  End;

End;

procedure TfrmAlteraEstMinMax.pLimpaPesquisa;
Var intContador: Integer;
begin
  For intContador := 0 to ComponentCount -1 Do
  Begin
    if (Components[intContador] is TEdit) or (Components[intContador] is TMaskEdit) Then
      TEdit(Components[intContador]).Clear;
  End;
  rdgMeses.ItemIndex := 0;
  rdgAtivo.ItemIndex := 0;

end;

function TfrmAlteraEstMinMax.fGetSql(blnLike: Boolean): String;
  Var
    strSQL     : String;
    intContador: Integer;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE          ';

  strSQL := strSQL + '   "N" AS ALTERA,   ';
  strSQL := strSQL + '   G.AUTOINCREM,         ';
  strSQL := strSQL + '   GIR_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   GIR_CODITE AS CODITE, ';
  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  If blnExiApl then
    strSQL := strSQL + ' ITE_APLICA AS APLICA , ';

  strSQL := strSQL + '   ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI, ';

  For intContador := Low(arrMesAno) To High(arrMesAno) Do
    With arrMesAno[intContador] Do
    strSQL := strSQL + '  SUM(IF(GIR_A_N_O_ = ' + QuotedStr(strAno) + ', IFNULL(GIR_QSAI' + strMes + ', 0), 0)) AS SAIME' + IntToStr(intContador) + ',';

  strSQL := strSQL + '  SUM((';
  For intContador := Low(arrMesAno) To High(arrMesAno) Do
  With arrMesAno[intContador] Do
  Begin
    strSQL := strSQL + '  IF(GIR_A_N_O_ = ' + QuotedStr(strAno) + ', IFNULL(GIR_QSAI' + strMes + ', 0), 0) ';
    If intContador <> High(arrMesAno) Then
      strSQL := strSQL + ' + ';
  End;

  case rdgMeses.ItemIndex Of
  0:begin
      strSQL := strSQL + '  ) / 3) AS MEDIAM, ';
      strSQL := strSQL + ' 0,00 AS SAIME4,    ';
      strSQL := strSQL + ' 0,00 AS SAIME5,    ';
      strSQL := strSQL + ' 0,00 AS SAIME6,    ';
      strSQL := strSQL + ' 0,00 AS SAIME7,    ';
      strSQL := strSQL + ' 0,00 AS SAIME8,    ';
      strSQL := strSQL + ' 0,00 AS SAIME9,    ';
      strSQL := strSQL + ' 0,00 AS SAIME10,   ';
      strSQL := strSQL + ' 0,00 AS SAIME11,   ';
      strSQL := strSQL + ' 0,00 AS SAIME12,   ';
    end;
  1:begin
      strSQL := strSQL + '  ) / 6) AS MEDIAM, ';
      strSQL := strSQL + ' 0,00 AS SAIME7,    ';
      strSQL := strSQL + ' 0,00 AS SAIME8,    ';
      strSQL := strSQL + ' 0,00 AS SAIME9,    ';
      strSQL := strSQL + ' 0,00 AS SAIME10,   ';
      strSQL := strSQL + ' 0,00 AS SAIME11,   ';
      strSQL := strSQL + ' 0,00 AS SAIME12,   ';
    end;
  2: strSQL := strSQL + '  ) / 12) AS MEDIAM, ';
    end;

  strSQL := strSQL + '   ITE_SALDOS AS SALDOS, ';
  strSQL := strSQL + '   ITE_MLTCOM AS MLTCOM, ';
  strSQL := strSQL + '   ITE_ESTMIN AS ESTMIN, ';
  strSQL := strSQL + '   ITE_ESTMAX AS ESTMAX, ';

  strSQL := strSQL + '   ITE_ESTMIN AS ALTMIN, ';
  strSQL := strSQL + '   ITE_ESTMAX AS ALTMAX, ';

  strSQL := strSQL + '   ITE_LOCFIS AS LOCFIS, ';
  strSQL := strSQL + '   ITE_LOCSUP AS LOCSUP, ';
  strSQL := strSQL + '   ITE_CODFAB AS CODFAB, ';

  strSQL := strSQL + '   ITE_LOCFIS AS LOCALT, ';
  strSQL := strSQL + '   ITE_LOCSUP AS SUPALT, ';
  strSQL := strSQL + '   ITE_CODFAB AS FABALT, ';

  strSQL := strSQL + '   ITE_MINDIG AS MINDIG, ';
  strSQL := strSQL + '   ITE_MAXDIG AS MAXDIG, ';
  strSQL := strSQL + '   ITE_PONPED AS PONPED, ';
  strSQL := strSQL + '   ITE_NIVGIR AS NIVGIR, ';
  strSQL := strSQL + '   G.ITE_PONEXP AS PONEXP ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   GIRITE R ';

  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = R.GIR_CODITE AND ';
  strSQL := strSQL + '                        G.ITE_CODEMP = R.GIR_CODEMP     ';

  strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE     ';

  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI  ';

  strSQL := strSQL + ' WHERE ';

  strSQL := strSQL + '   GIR_CODITE = G.ITE_CODITE AND ';
  strSQL := strSQL + '   GIR_CODEMP = G.ITE_CODEMP AND ';
  strSQL := strSQL + '   GIR_A_N_O_ BETWEEN :ANOINI AND :ANOFIN ';

  If Not fEmptyStr(edtDesIte.Text) Then
    strSQL := strSQL + ' AND I.ITE_DESITE LIKE :DESITE ';

  If Not fEmptyStr(edtRefere.Text) Then
    strSQL := strSQL + ' AND I.ITE_REFERE LIKE :REFERE ';

  Case rdgAtivo.ItemIndex Of
    0: strSQL := strSQL + ' AND I.ITE_ITEATI = "S" ';
    1: strSQL := strSQL + ' AND I.ITE_ITEATI = "N" ';
  End;

  strSQL := strSQL + fStrLocateLinGru(mskLinGru, arrLinGru, 'I.ITE_CODGRU', 'CODGRU');
  strSQL := strSQL + fStrLocateEmpresa(edtCodEmp, arrEmpres, 'R.GIR_CODEMP', 'CODEMP');
  strSQL := strSQL + fStrLocate(edtCodMar, arrMarca , 'I.ITE_CODMAR', 'CODMAR');
  strSQL := strSQL + fStrLocate(edtCodFor, arrFornec, 'I.ITE_CODFOR', 'CODFOR');
  strSQL := strSQL + fStrLocate(edtCodUni, arrUnidad, 'I.ITE_CODUNI', 'CODUNI');
  strSQL := strSQL + fStrLocate(edtPrdGru, arrPrdGru, 'I.ITE_PRDGRU', 'PRDGRU');
  strSQL := strSQL + fStrLocate(edtCodDep, arrCodDep, 'I.ITE_CODDEP', 'CODDEP');
  strSQL := strSQL + fStrLocate(edtCodIte, arrProdut, 'I.ITE_CODITE', 'CODITE');


  strSQL := strSQL +  ' GROUP BY ';
  strSQL := strSQL +  '   GIR_CODITE, ';
  strSQL := strSQL +  '   GIR_CODEMP  ';

  Result := strSQL;
End;

function TfrmAlteraEstMinMax.fSetParametros: Boolean;
Begin

  With qryConsulta Do
  Begin
    If Not fEmptyStr(edtDesIte.Text) Then
      ParamByName('DESITE').AsString := edtDesIte.Text + '%';

    If Not fEmptyStr(edtRefere.Text) Then
      ParamByName('REFERE').AsString := edtRefere.Text + '%';

    ParamByName('ANOINI').AsString := arrMesAno[Low(arrMesAno)].strAno;
    ParamByName('ANOFIN').AsString := arrMesAno[High(arrMesAno)].strAno;

    pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryConsulta);
    pSetaParam(edtCodEmp.Text, arrEmpres, strEmpres, 'CODEMP', qryConsulta);
    pSetaParam(edtCodMar.Text, arrMarca,  strMarca,  'CODMAR', qryConsulta);
    pSetaParam(edtCodFor.Text, arrFornec, strFornec, 'CODFOR', qryConsulta);
    pSetaParam(edtCodUni.Text, arrUnidad, strUnidad, 'CODUNI', qryConsulta);
    pSetaParam(edtPrdGru.Text, arrPrdGru, strPrdGru, 'PRDGRU', qryConsulta);
    pSetaParam(edtCodDep.Text, arrCodDep, strCodDep, 'CODDEP', qryConsulta);
    pSetaParam(edtCodIte.Text, arrProdut, strCodIte, 'CODITE', qryConsulta);

  End;

  Result := True;
End;

Procedure TfrmAlteraEstMinMax.pAlteraNomeColunas;
Var
  intContador: Integer;
Begin
  For intContador := Low(arrMesAno) To High(arrMesAno) Do
  With arrMesAno[intContador] Do
  Begin
    If Assigned(dbgConsultaDados.GetColumnByFieldName('SAIME' + IntToStr(intContador))) Then
      dbgConsultaDados.GetColumnByFieldName('SAIME' + IntToStr(intContador)).Caption := strMes + '/' + strAno;
  End;
End;

Function TfrmAlteraEstMinMax.fAbreConsulta(blnLike: Boolean = True): Boolean;
Begin
  Result := False;
  If fVerificaCampos Then
  Begin
    pCalculaMeses;
    inherited fAbreConsulta(blnLike);
    pAlteraNomeColunas;
    dbgConsultaALTMIN.Focused := True;
    Result := True;
  End;

End;

Procedure TfrmAlteraEstMinMax.pOrdenaClient;
Begin
  If SameText(lflLastField.strNomCam, 'DESITE') Then
    cdsConsulta.IndexFieldNames := 'DESITE;SIGUNI;CODEMP'
  Else
    cdsConsulta.IndexFieldNames := fGetAliasField(lflLastField.strNomCam);
End;

procedure TfrmAlteraEstMinMax.rdgAtivoClick(Sender: TObject);
begin
  inherited;
  pSetFocus(btnCarregar);
end;

procedure TfrmAlteraEstMinMax.rdgAtivoExit(Sender: TObject);
begin
  inherited;
  pSetFocus(btnCarregar);
end;

procedure TfrmAlteraEstMinMax.rdgMesesClick(Sender: TObject);
begin
  inherited;
  fAbreConsulta;

  dbgConsultaDados.BeginUpdate;
  case rdgMeses.ItemIndex Of
  0:begin
      With dbgConsultaDados do
      Begin
        GetColumnByFieldName('SAIME3').Visible := False;
        GetColumnByFieldName('SAIME4').Visible := False;
        GetColumnByFieldName('SAIME5').Visible := False;
        GetColumnByFieldName('SAIME6').Visible := False;
        GetColumnByFieldName('SAIME7').Visible := False;
        GetColumnByFieldName('SAIME8').Visible := False;
        GetColumnByFieldName('SAIME9').Visible := False;
        GetColumnByFieldName('SAIME10').Visible := False;
        GetColumnByFieldName('SAIME11').Visible := False;
        GetColumnByFieldName('SAIME12').Visible := False;

      End;
    end;

  1:begin
     With dbgConsultaDados do
      Begin
        GetColumnByFieldName('SAIME3').Visible := True;
        GetColumnByFieldName('SAIME4').Visible := True;
        GetColumnByFieldName('SAIME5').Visible := True;
        GetColumnByFieldName('SAIME6').Visible := False;
        GetColumnByFieldName('SAIME7').Visible := False;
        GetColumnByFieldName('SAIME8').Visible := False;
        GetColumnByFieldName('SAIME9').Visible := False;
        GetColumnByFieldName('SAIME10').Visible := False;
        GetColumnByFieldName('SAIME11').Visible := False;
        GetColumnByFieldName('SAIME12').Visible := False;
      End;
    end;

  2:begin
      With dbgConsultaDados do
      Begin
        GetColumnByFieldName('SAIME3').Visible := True;
        GetColumnByFieldName('SAIME4').Visible := True;
        GetColumnByFieldName('SAIME5').Visible := True;
        GetColumnByFieldName('SAIME6').Visible := True;
        GetColumnByFieldName('SAIME7').Visible := True;
        GetColumnByFieldName('SAIME8').Visible := True;
        GetColumnByFieldName('SAIME9').Visible := True;
        GetColumnByFieldName('SAIME10').Visible := True;
        GetColumnByFieldName('SAIME11').Visible := True;
        GetColumnByFieldName('SAIME12').Visible := False;
      End;
    end;
  end;
  dbgConsultaDados.EndUpdate;
end;

end.

