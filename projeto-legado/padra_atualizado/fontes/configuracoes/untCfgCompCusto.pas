{ Configuração da Formação de Custo.
  Autor : Guilherme Borges
  Data  : 18/10/2012

  Alteração: Matheus Mendes
  Data     : 04/07/2013

   ## Formação do valor do Parametro
    ** Preço de Custo                               ( DET_PRECUS ) => 1
    ** Preço Médio                                  ( DET_PREMED ) => 2
    ** Preço de Última Compra                       ( DET_PREULT ) => 4
    ** Preço de Última Compra + Impostos de Entrada ( DET_IMPULT ) => 8
    ** ICMS de Saída                                ( DET_ICMSAI ) => 16
    ** Despesas Operacionais                        ( DET_DESOPE ) => 32
    ** Outros Valores                               ( DET_OUTVAL ) => 64
    ** Impostos Federais                            ( DET_IMPFED ) => 128

   ## OS BYTES ESTÃO CONFIGURADOS NA PROPRIEDADE TAG DOS CHECKBOX
   ## AO ADICIONAR OUTRO, SEGUIR A MESMA REGRA

}

unit untCfgCompCusto;

interface

uses
  Windows, Classes, Controls, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls,  untPaiConfirma, cxStyles, cxCustomData, cxGraphics, Types, UITypes,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, EditFocus, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, Uni, CheckLst, QColorLabel, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, untZClient, frxClass,
  frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCfgCompCusto = class(TfrmPaiConfirma)
    pnlFundo: TPanel;
    cxgComCus: TcxGrid;
    cxgComCusDBTableView1: TcxGridDBTableView;
    cxgComCusLevel1: TcxGridLevel;
    Label12: TLabel;
    edtDescri: TEditFocus;
    Label1: TLabel;
    cxgComCusDESCRI: TcxGridDBColumn;
    cxgComCusFORMUL: TcxGridDBColumn;
    btnAdicionarCtt: TBitBtnLocked;
    chklstCompos: TCheckListBox;
    Label37: TLabel;
    ColorLabel1: TColorLabel;
    edtSugeri: TEditFocus;
    cxgComCusSUGERI: TcxGridDBColumn;
    btnRemCom: TBitBtnLocked;
    Label2: TLabel;
    shp3: TShape;
    Shape1: TShape;
    Label4: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure btnAdicionarCttClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgComCusDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtSugeriKeyPress(Sender: TObject; var Key: Char);
    procedure cxgComCusSUGERIGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxgComCusDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnRemComClick(Sender: TObject);
    procedure chklstComposClickCheck(Sender: TObject);
    procedure cxgComCusDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure chklstComposDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    cdsComCus: TZClient;

    procedure pAdicionaComposicao(strDescri, strSugeri : String; intCompos: Integer);
    procedure pLimpa;
    procedure pAlteraComposicao(DataSet: TDataSet);
    procedure pCarregaValoresIniciais;

    function  fExtrairCamposFormula(intValCfg : Integer): String;
    function  fExtrairCamposLayout(intValCfg : Integer): String;
    function  fTransformarLayoutEmFormula : Boolean;

    function  fFormataComposicao: Integer;
    function  fValidaCampos: Boolean; reintroduce; overload;
  public
    strAutIncAlt : String;

  Protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; overload; override;
  end;


implementation

uses SysUtils, Graphics, Forms, StrUtils, Mask, UniClientDataSet, untFuncoesSimples,
  untPai, untConstantes, untTypesSistema;

{$R *.dfm}

{ TfrmCfgCompCusto }

procedure TfrmCfgCompCusto.btnAdicionarCttClick(Sender: TObject);
begin
  inherited;
  If fValidaCampos Then
    pAdicionaComposicao(edtDescri.Text, edtSugeri.Text, fFormataComposicao)
  Else
    pSetFocus(edtDescri);
end;

procedure TfrmCfgCompCusto.btnConfirmaClick(Sender: TObject);
  Var
    qryGen     : TUniQuery;
Begin
  if not fTransformarLayoutEmFormula then
    Exit;

  If fPergunta('Confirma a gravação das composições do preço de custo?') Then
  Begin

    Try
      qryGen := fCriaQuery;

      fStartTransaction;

      With qryGen, Sql Do
      Begin
        Close;
        Clear;

        Add('DELETE FROM COMCUS;');
        ExecSQL;
      End;

      cdsComCus.First;
      While Not cdsComCus.Eof Do
      Begin

        With qryGen, Sql Do
        Begin
          Close;

          Clear;
          Add('INSERT INTO ');
          Add('  COMCUS    ');
          Add('    (AUTOINCREM, COM_DESCRI, COM_COMPOS, COM_SUGERI, COM_LAYOUT, COM_FORMUL) ');
          Add('  VALUES    ');
          Add('    (:AUTOIN, :DESCRI, :COMPOS, :SUGERI, :LAYOUT, :FORMUL)          ');

          ParamByName('AUTOIN').AsString  := cdsComCus.FieldByName('AUTOINCREM').AsString;
          ParamByName('DESCRI').AsString  := cdsComCus.FieldByName('COM_DESCRI').AsString;
          ParamByName('COMPOS').AsInteger := cdsComCus.FieldByName('COM_COMPOS').AsInteger;
          ParamByName('SUGERI').AsString  := cdsComCus.FieldByName('COM_SUGERI').AsString;
          ParamByName('LAYOUT').AsString  := cdsComCus.FieldByName('COM_LAYOUT').AsString;
          ParamByName('FORMUL').AsString  := cdsComCus.FieldByName('COM_FORMUL').AsString;

          ExecSQL;
        End;

        cdsComCus.Next;
      End;

      fCommit;

    Except
      On E : Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmCfgCompCusto.btnConfirma]');
        fRollBack;
      End;
    End;

    FreeAndNil(qryGen);

    fMensagem('','Composições de custo cadastradas com sucesso!',['&Ok']);
  End;  
end;

procedure TfrmCfgCompCusto.btnRemComClick(Sender: TObject);
begin
  inherited;
  If (cdsComCus.IsEmpty) Then
    Exit;

  If (cdsComCus.FieldByName('COM_SUGERI').AsString = 'S') Then
  Begin
    pMensagemOk('A composição Principal para os Relatórios não pode ser removida!');
    Exit;
  End;

  If fPergunta('Confirma exclusão?') Then
  Begin
    cdsComCus.Delete;
    pLimpa;
  End;
end;

procedure TfrmCfgCompCusto.chklstComposClickCheck(Sender: TObject);
  Var
    intCont : Integer;
begin
  inherited;
  If (chklstCompos.ItemIndex in [0,1,2,3]) And
     (chklstCompos.Checked[chklstCompos.ItemIndex]) Then
  Begin
    For intCont := 0 To 3 Do
      If (intCont <> chklstCompos.ItemIndex) Then
        chklstCompos.Checked[intCont] := False;
  End;

end;

procedure TfrmCfgCompCusto.chklstComposDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
  Var
    Flags: Longint;
begin
  With TCheckListBox(Control) Do
  Begin
    case Index of
      0,1,2,3: Canvas.Brush.Color := clInfoBk;
      Else     Canvas.Brush.Color := cl3DLight;
    end;
    Canvas.FillRect(Rect);
    case Index of
      0,1,2,3: Canvas.Font.Color := clRed;
      Else     Canvas.Font.Color := clGreen;
    end;
    Flags := DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
    if not UseRightToLeftAlignment then
      Inc(Rect.Left, 2)
    else
      Dec(Rect.Right, 2);
    DrawText(Canvas.Handle, Items[Index], Length(Items[Index]), Rect, Flags);
  End;
end;

procedure TfrmCfgCompCusto.cxgComCusDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  pAlteraComposicao(cdsComCus);
  pSetFocus(edtDescri);
end;

procedure TfrmCfgCompCusto.cxgComCusDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Not AViewInfo.GridRecord.Focused) And
     (AViewInfo.GridRecord.Index Mod 2 = 0) Then
  Begin
    ACanvas.Brush.Color := StrToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
    ACanvas.Font.Color  := clBlack;
  End;
end;

procedure TfrmCfgCompCusto.cxgComCusDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    pAlteraComposicao(cdsComCus);
    pSetFocus(edtDescri);
  End;

  If (Key = VK_DELETE) Then
  Begin
    btnRemCom.Click;
  End;
end;

procedure TfrmCfgCompCusto.cxgComCusSUGERIGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If (AText = 'S') Then
    AText := 'SIM'
  Else
    AText := '';  
end;

procedure TfrmCfgCompCusto.edtSugeriKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Not CharInSet(key, ['S','s','N','n',#8,#13]) then
    key := #0;
end;

function TfrmCfgCompCusto.fExtrairCamposFormula(intValCfg : Integer): String;
  Var
    arrTemp   : TIntArray;
    intCorre  : Integer;
Begin
  Result  := '';

  arrTemp := fRetornaComposicaoCustoIndices(intValCfg);

  For intCorre := Length(arrTemp)-1 DownTo 0 Do
  Begin
    Result := Result + ARR_CFG_COMP_CUSTO_CAMPOS[arrTemp[intCorre]];

    If (intCorre - 1) >= 0 Then
      Result := Result + ' + ';
  End;
end;

function TfrmCfgCompCusto.fExtrairCamposLayout(intValCfg: Integer): String;
  Var
    arrTemp   : TIntArray;
    intCorre  : Integer;
Begin
  Result  := '';

  arrTemp := fRetornaComposicaoCustoIndices(intValCfg);

  For intCorre := Length(arrTemp)-1 DownTo 0 Do
  Begin
    Result := Result + ARR_CFG_COMP_CUSTO_DISPLAY[arrTemp[intCorre]];

    If (intCorre - 1) >= 0 Then
      Result := Result + ' + ';
  End;
end;

function TfrmCfgCompCusto.fFormataComposicao: Integer;
  Var
    intCont : Integer;
begin
  Result := 0;

  For intCont := 0 To chklstCompos.Count-1 Do
  Begin
    If (chklstCompos.Checked[intCont]) Then
      Result := Result + ARR_CFG_COMP_CUSTO_VALCAM[intCont];
  End;
end;

procedure TfrmCfgCompCusto.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDescri);
end;

procedure TfrmCfgCompCusto.FormCreate(Sender: TObject);
  Var
    strSQL    : String;
begin
  inherited;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  AUTOINCREM, ';  
  strSQL := strSQL + '  COM_DESCRI, ';
  strSQL := strSQL + '  COM_COMPOS, ';
  strSQL := strSQL + '  COM_SUGERI, ';
  strSQL := strSQL + '  COM_LAYOUT, ';
  strSQL := strSQL + '  COM_FORMUL ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  COMCUS ';

  cdsComCus                 := TZClient.Create(Self, strSQL);
  cdsComCus.IndexFieldNames := 'AUTOINCREM; COM_DESCRI; COM_COMPOS';

  cxgComCusDBTableView1.DataController.DataSource := cdsComCus.dtsSource;

  With cdsComCus Do
  Begin
    Close;
    qryQuery.Close;
    pSetProvider;
    qryQuery.Open;
    pSetaClient(qryQuery);
    Open;
  End;

  pCarregaValoresIniciais;
end;

procedure TfrmCfgCompCusto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Screen.ActiveControl.Name = '' then
  Begin
    If Not CharInSet(key, ['+','-','/','*','(',')', #20, #8]) then
      key := #0;
  End;
end;

function TfrmCfgCompCusto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
end;

function TfrmCfgCompCusto.fValidaCampos: Boolean;
  Var
    intCont,
    intCheck : Integer;
    blnCustoSelecionado : Boolean;
begin
  Result := True;

  {***************************}
  {* DESCRIÇÃO DA COMPOSIÇÃO *}
  {************************MM*}
  If fEmptyStr(edtDescri.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Descrição da composição deve ser preenchida!', ['&Ok']);
    Result := False;
    pSetFocus(edtDescri);
    Exit;
  End
  Else
  Begin
    If cdsComCus.Locate('COM_DESCRI', edtDescri.Text, []) Then
    Begin
      If (cdsComCus.FieldByName('AUTOINCREM').AsString <> strAutIncAlt) Then
      Begin
        fMensagem('ATENÇÃO!', 'Já existe uma composição cadastrada com essa Descrição!', ['&Ok']);
        Result := False;
        pSetFocus(edtDescri);
        Exit;
      End;
    End;
  End;

  {*******************}
  {* SUGESTÃO PADRÃO *}
  {****************MM*}
  If fEmptyStr(edtSugeri.Text) Or (Pos(edtSugeri.Text,'S_N_') <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Preencha o campo Sugestão com S ou N!', ['&Ok']);
    Result := False;
    pSetFocus(edtSugeri);
    Exit;
  End
  Else
  Begin
    If cdsComCus.Locate('COM_DESCRI', edtDescri.Text, []) Then
    Begin
      If (cdsComCus.FieldByName('COM_SUGERI').AsString = 'S') And (edtSugeri.Text <> 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'A composição padrão só mudará ao definir outra composição como padrão!', ['&Ok']);
        Result := False;
        pSetFocus(edtSugeri);
        Exit;
      End;
    End;
  end;

  {********************************}
  {* PREÇOS DE CUSTO SELECIONADOS *}
  {*****************************MM*}
  blnCustoSelecionado := False;
  intCheck := 0;
  For intCont := 0 To chklstCompos.Count-1 Do
  Begin
    If (intCont <= 3) And (chklstCompos.Checked[intCont]) Then
      blnCustoSelecionado := True;

    intCheck := intCheck + IIF(chklstCompos.Checked[intCont], 1, 0);
  End;

  If Not (blnCustoSelecionado) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Preço de Custo principal não foi selecionado!', ['&Ok']);
    Result := False;
    pSetFocus(chklstCompos);
    Exit;
  End;

  If (intCheck = 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Selecione pelo menos um item para formar a composição de preço!', ['&Ok']);
    Result := False;
    pSetFocus(chklstCompos);
    Exit;
  End;
end;

procedure TfrmCfgCompCusto.pAdicionaComposicao(strDescri, strSugeri : String; intCompos: Integer);
begin
  with cdsComCus Do
  Begin
    If (strSugeri = 'S') Then
    Begin
      If Locate('COM_SUGERI', strSugeri, []) Then
      Begin
        Edit;
        FieldByName('COM_SUGERI').AsString  := 'N';        
        Post;
      End;
    End;

    If Locate('AUTOINCREM', strAutIncAlt, []) Then
    Begin
      Edit;
      FieldByName('AUTOINCREM').AsString  := strAutIncAlt;
    End
    Else
    Begin
      Insert;
      FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('COMCUS', VS_strCodEmp);      
    End;

    FieldByName('COM_DESCRI').AsString  := strDescri;
    FieldByName('COM_COMPOS').AsInteger := intCompos;
    FieldByName('COM_SUGERI').AsString  := strSugeri;
    FieldByName('COM_LAYOUT').AsString  := fExtrairCamposLayout(intCompos);
    FieldByName('COM_FORMUL').AsString  := fExtrairCamposFormula(intCompos);

    Post;

    pLimpa;

    pSetFocus(edtDescri);
  End;
end;

procedure TfrmCfgCompCusto.pAlteraComposicao(DataSet: TDataSet);
  Var
    intCont : Integer;
    arrIndi : TIntArray;
begin
  pLimpa;
  With DataSet Do
  Begin
    strAutIncAlt   := FieldByName('AUTOINCREM').AsString;
    edtDescri.Text := FieldByName('COM_DESCRI').AsString;
    edtSugeri.Text := FieldByName('COM_SUGERI').AsString;

    arrIndi := fRetornaComposicaoCustoIndices(FieldByName('COM_COMPOS').AsInteger);

    For intCont := 0 To Length(arrIndi)-1 Do
      chklstCompos.Checked[arrIndi[intCont]] := True;
  End;
end;

procedure TfrmCfgCompCusto.pCarregaValoresIniciais;
  Var
    intCont: Integer;
begin
  With cdsComCus Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      if fEmptyStr(FieldByName('COM_LAYOUT').AsString) then
      Begin
        FieldByName('COM_LAYOUT').AsString := fExtrairCamposLayout(FieldByName('COM_COMPOS').AsInteger);
        FieldByName('COM_FORMUL').AsString := fExtrairCamposFormula(FieldByName('COM_COMPOS').AsInteger);
      End;
      Post;

      Next;
    End;
  end;

  chklstCompos.Clear;
  For intCont := 0 To Length(ARR_CFG_COMP_CUSTO_CAMPOS) -1 Do
  Begin
    If (RightStr(ARR_CFG_COMP_CUSTO_CAMPOS[intCont], 6) = 'OUTVAL') Then
      chklstCompos.Items.Add('OUTVAL - ' + fCfgSis('DOVCPP',varString))
    Else If (ARR_CFG_COMP_CUSTO_CAMPOS[intCont] = STR_COMP_FRETE_CAMPO) Then
      chklstCompos.Items.Add(STR_COMP_FRETE_DESCR + ' - ' + ARR_CFG_COMP_CUSTO_DISPLAY[intCont])
    Else If (ARR_CFG_COMP_CUSTO_CAMPOS[intCont] = STR_COMP_JURCUS_CAMPO) Then
      chklstCompos.Items.Add(STR_COMP_JURCUS_DESCR + ' - ' + ARR_CFG_COMP_CUSTO_DISPLAY[intCont])
    Else If (ARR_CFG_COMP_CUSTO_CAMPOS[intCont] = STR_COMP_DIFAL_CAMPO) Then
      chklstCompos.Items.Add(STR_COMP_DIFAL_DESCR + ' - ' + ARR_CFG_COMP_CUSTO_DISPLAY[intCont])
    Else If (ARR_CFG_COMP_CUSTO_CAMPOS[intCont] = STR_COMP_FCP_CAMPO) Then
      chklstCompos.Items.Add(STR_COMP_FCP_DESCR + ' - ' + ARR_CFG_COMP_CUSTO_DISPLAY[intCont])
    Else
      chklstCompos.Items.Add(RightStr(ARR_CFG_COMP_CUSTO_CAMPOS[intCont], 6) + ' - ' +
                                      ARR_CFG_COMP_CUSTO_DISPLAY[intCont]);
  End;
end;

procedure TfrmCfgCompCusto.pLimpa;
  Var
    intCont: Integer;
begin
  strAutIncAlt := EmptyStr;

  edtDescri.Clear;
  edtSugeri.Clear;

  For intCont := 0 To chklstCompos.Count-1 Do
    chklstCompos.Checked[intCont] := False;
end;

function TfrmCfgCompCusto.fTransformarLayoutEmFormula : Boolean;
  Var
    LarrTemp   : TIntArray;
    LintCorre  : Integer;
    LQuery     : TUniQuery;
Begin
  Result := True;

  LQuery := fcriaQuery(nil);

  Try
    cdsComCus.First;
    While Not cdsComCus.Eof Do
    Begin

      cdsComCus.Edit;
      cdsComCus.FieldByName('COM_FORMUL').AsString := cdsComCus.FieldByName('COM_LAYOUT').AsString;

      LarrTemp := fRetornaComposicaoCustoIndices(cdsComCus.FieldByname('COM_COMPOS').AsInteger);
      For LintCorre := Length(LarrTemp)-1 DownTo 0 Do
      Begin
        if POS(ARR_CFG_COMP_CUSTO_DISPLAY[LarrTemp[LintCorre]], cdsComCus.FieldByName('COM_FORMUL').AsString) <= 0 then
        Begin
          fMensagem('ATENÇÂO','Fórmula "'+cdsComCus.FieldByname('COM_DESCRI').AsString+'" inválida. O campo "'+ARR_CFG_COMP_CUSTO_DISPLAY[LarrTemp[LintCorre]]+'" '+
          'foi selecionado para a mesma, porém retirado na edição manual pela grid. A mesma será restaurada para o valor default '+
        '(somatória entre todos os campos selecionados), para que seja possível revisar sua estrutura.',['&Ok']);

          cdsComCus.FieldByName('COM_LAYOUT').AsString := fExtrairCamposLayout(cdsComCus.FieldByName('COM_COMPOS').AsInteger);
          cdsComCus.FieldByName('COM_FORMUL').AsString := fExtrairCamposFormula(cdsComCus.FieldByName('COM_COMPOS').AsInteger);
          cdsComCus.Post;

          Exit(False);
        End
        Else
          cdsComCus.FieldByName('COM_FORMUL').AsString := ReplaceStr(cdsComCus.FieldByName('COM_FORMUL').AsString,
                                                                     ARR_CFG_COMP_CUSTO_DISPLAY[LarrTemp[LintCorre]],
                                                                     'IFNULL('+ARR_CFG_COMP_CUSTO_CAMPOS[LarrTemp[LintCorre]]+', 0)');
      End;

      cdsComCus.FieldByName('COM_FORMUL').AsString := 'ROUND(( ' + cdsComCus.FieldByName('COM_FORMUL').AsString + ' ), 2) ';
      cdsComCus.Post;

      Try
        LQuery.Close;

        LQuery.Sql.Text := 'SELECT @FORMULA '+
                           '  FROM MOVGER G '+
                           '  JOIN MOVDET D ON G.AUTOINCREM = D.DET_SEQGER '+
                           '  JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM '+
                           '  JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM '+
                           '  LEFT JOIN MOVICD I ON I.ICD_SEQGER = D.AUTOINCREM '+
                           '  LIMIT 1 ';
        LQuery.Sql.Text := ReplaceStr(LQuery.Sql.Text, '@FORMULA', cdsComCus.FieldByName('COM_FORMUL').AsString);

        LQuery.Open;
      Except
        LQuery.Close;

        fMensagem('ATENÇÂO','Fórmula "'+cdsComCus.FieldByname('COM_DESCRI').AsString+'" inválida. A mesma será restaurada para o valor default '+
        '(somatória entre todos os campos selecionados), para que seja possível refazer revisando se os sinais matemáticos e os parentêses estão '+
        'posicionados corretamente ou se alguma variável foi modificada indevidamente.',['&Ok']);

        cdsComCus.Edit;
        cdsComCus.FieldByName('COM_LAYOUT').AsString := fExtrairCamposLayout(cdsComCus.FieldByName('COM_COMPOS').AsInteger);
        cdsComCus.FieldByName('COM_FORMUL').AsString := fExtrairCamposFormula(cdsComCus.FieldByName('COM_COMPOS').AsInteger);
        cdsComCus.Post;

        Exit(False);
      End;

      cdsComCus.Next;
    End;

  Finally
    FreeAndNil(LQuery);
  End;

end;

end.
