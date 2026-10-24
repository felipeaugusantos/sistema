unit untCadFaixaDescTabPreco;

interface

uses
  Windows, Classes, Controls, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  BitBtnLockedIncrem, untBaseListIntf, ExtCtrls, ComboBoxFocus, EditFocus, Grids,
  DBGridCitel, DBGrids, DB, UniClientDataSet, Uni,

  UniDataSetProvider, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadFaixaDescTabPreco = class(TfrmPai)
    pnlGrid: TPanel;
    Label12: TLabel;
    dbgCadTab: TDBGridCitel;
    pnlDesconto: TPanel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    edtDesIni: TEditFocus;
    edtDesFin: TEditFocus;
    edtComPra: TEditFocus;
    btnConfirma: TBitBtnLocked;
    edtComVis: TEditFocus;
    Label1: TLabel;
    cmbTabPre: TComboBoxFocus;
    btnGravar: TBitBtnLocked;
    dtsCadTab: TDataSource;
    rdgTipOpe: TRadioGroup;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pAfterPost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cmbTabPreChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }

    blnAlterou,
    blnEditando: Boolean;
    cdsCadTab: TUniClientDataSet;
    dspCadTab: TUniDataSetProvider;

    function fGetTabPre: Integer;
    function fGetTipOpe: string;
    function fGetAutInc: Integer;

    procedure pCarregaTabelaPrecos;
    procedure pCarregaFaixasComissoes;

    procedure pAddItem;
    procedure pEditItem;
    procedure pDeleteItem;
    procedure pLimpaCampos;
    procedure pSetaMascaras;

    procedure pPreencheListaObjeto(objFaixaDescTapPrecoList: IBaseList; cdsDataSet: TUniClientDataSet);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadFaixaDescTabPreco: TfrmCadFaixaDescTabPreco;

implementation

uses SysUtils, Forms, untFuncoesSimples,
   untFactoryClass, untCadComissaoFaixaDescTabPrecoIntf, untCadComissaoFaixaDescTabPrecoDAO;

{$R *.dfm}

{ TfrmCadFaixaDescTabPreco }

procedure TfrmCadFaixaDescTabPreco.btnConfirmaClick(Sender: TObject);
begin
  If fVerificaCampos Then
    pAddItem;
end;

procedure TfrmCadFaixaDescTabPreco.btnGravarClick(Sender: TObject);
  Var
    objFaixaDescTabPrecoList: IBaseList;
    cdsAux: TUniClientDataSet;
begin
  inherited;

  objFaixaDescTabPrecoList := Factory.CreateList;
  cdsAux := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsAux, cdsCadTab);
  cdsAux.Filter   := '';
  cdsAux.Filtered := False;

  If fMensagem('ATENÇÃO', 'Confirma gravação das faixas de comissão?', ['&Sim', '&Não']) = 2 Then
    Exit;

  pPreencheListaObjeto(objFaixaDescTabPrecoList, cdsAux);

  If FaixaDescTabPrecoDAO.fDeleteAll Then
  Begin
    If FaixaDescTabPrecoDAO.fInsert(objFaixaDescTabPrecoList) Then
    Begin
      fMensagem('ATENÇÃO', 'Faixas de comissões salvas com sucesso!!', ['&OK']);
      blnAlterou := False;
    End;
  End;

  objFaixaDescTabPrecoList := nil;
end;

procedure TfrmCadFaixaDescTabPreco.cmbTabPreChange(Sender: TObject);
begin
  cdsCadTab.Filter   := 'TABPRE = ' + QuotedStr(IntToStr(fGetTabPre)) + ' AND TIPOPE = ' + QuotedStr(fGetTipOpe);
  cdsCadTab.Filtered := True;
end;

procedure TfrmCadFaixaDescTabPreco.pAfterPost(DataSet: TDataSet);
begin
  blnAlterou := True;
  btnGravar.Enabled := True;
  blnEditando := False;
  dbgCadTab.Enabled := True;
end;

function TfrmCadFaixaDescTabPreco.fGetAutInc: Integer;
  Var
    cdsAux: TUniClientDataSet;
begin
  If blnEditando Then
  Begin
    Result := cdsCadTab.FieldByName('AUTINC').AsInteger;
    Exit;
  End;

  cdsAux := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsAux, cdsCadTab);

    cdsAux.IndexFieldNames := 'AUTINC';
    cdsAux.Last;
    
    Result := cdsAux.FieldByName('AUTINC').AsInteger + 1;
  Finally
    FreeAndNil(cdsAux);
  End;
end;

function TfrmCadFaixaDescTabPreco.fGetTabPre: Integer;
begin
  Result := StrToInt(fRetSomenteNumeros(cmbTabPre.Text));
end;

function TfrmCadFaixaDescTabPreco.fGetTipOpe: string;
begin
  case rdgTipOpe.ItemIndex of
    0: Result := 'T';
    1: Result := 'V';
    2: Result := 'V2';
    3: Result := 'D';
    4: Result := 'R';
  end;
end;

procedure TfrmCadFaixaDescTabPreco.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  If blnAlterou And (fMensagem('', 'Deseja cancelar edição?', ['&Sim','&Não']) = 2) Then
    CanClose := False;
end;

procedure TfrmCadFaixaDescTabPreco.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) And blnEditando Then
  Begin
    Key := 0;
    blnEditando := False;
    pLimpaCampos;
    dbgCadTab.Enabled := True;
  End;

  If edtDesIni.Focused Then
  Begin
    If Key = VK_ESCAPE Then
      pSetFocus(cmbTabPre);
  End;

  If dbgCadTab.Focused Then
  Begin
    If (Key = VK_RETURN) And (Not cdsCadTab.IsEmpty) Then
    Begin
      pEditItem;
      pSetFocus(edtDesIni);
    End;

    If Key = VK_DELETE Then
      pDeleteItem;

    If Key = VK_ESCAPE Then
      pSetFocus(edtDesIni);
  End;
end;

procedure TfrmCadFaixaDescTabPreco.FormShow(Sender: TObject);
begin
  inherited;
  blnAlterou := False;
  pCarregaTabelaPrecos;
  pCarregaFaixasComissoes;
  if fCfgSis('TOFDTP', varBoolean) then
  begin
    rdgTipOpe.Visible  := True;
    pnlDesconto.Height := 75;
  end
  else
  begin
    rdgTipOpe.Visible  := False;
    pnlDesconto.Height := 40;
  end;
end;

procedure TfrmCadFaixaDescTabPreco.pPreencheListaObjeto(objFaixaDescTapPrecoList: IBaseList; cdsDataSet: TUniClientDataSet);
  Var
    objTemp: ICadComissaoFaixaDescTabPreco;
begin

  With cdsDataSet Do
  Begin
    If Not IsEmpty Then
    Begin
      First;

      While Not Eof Do
      Begin
        objTemp           := Factory.Create('ComissaoFaixaTabPreco') as ICadComissaoFaixaDescTabPreco;
        objTemp.strTabPre := FieldByName('TABPRE').AsString;
        objTemp.strTipOpe := FieldByName('TIPOPE').AsString;
        objTemp.fltDesIni := FieldByName('DESINI').AsFloat;
        objTemp.fltDesFin := FieldByName('DESFIN').AsFloat;
        objTemp.fltComVis := FieldByName('COMVIS').AsFloat;
        objTemp.fltComPra := FieldByName('COMPRA').AsFloat;
        objTemp.strCodEmp := VS_strCodEmp;
        objFaixaDescTapPrecoList.Add(objTemp);

        Next;
      End;
    End;
  End;
end;

function TfrmCadFaixaDescTabPreco.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strMsg: String;

  function fCheckRange(fltFat: Double): Boolean;
    Var
      cdsAux: TUniClientDataSet;
  begin
    Result := True;

    cdsAux := TUniClientDataSet.Create(Nil);

    Try
      pCloneDataSet(cdsAux, cdsCadTab);

      cdsAux.First;
      While Not cdsAux.Eof Do
      Begin
        If blnEditando And (cdsAux.FieldByName('AUTINC').AsInteger = fGetAutInc) Then
        Begin
          cdsAux.Next;
          Continue;
        End;

        If (cdsAux.FieldByName('TABPRE').AsInteger = fGetTabPre) and (cdsAux.FieldByName('TIPOPE').AsString = fGetTipOpe) Then
        Begin
          If (fltFat >= cdsAux.FieldByName('DESINI').AsFloat) And (fltFat <= cdsAux.FieldByName('DESFIN').AsFloat) Then
          Begin
            Result := False;
            Exit;
          End;
        End;

        cdsAux.Next;
      End;
    Finally
      FreeAndNil(cdsAux);
    End;              
  end;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = edtDesIni Then
    Begin
      If Not fCheckRange(fStrToFloat(edtDesIni.Text)) Then
        strMsg := 'Desconto Inicial inválido! Já existe um intervalo contendo o valor especificado.'
    End

    Else If Sender = edtDesFin Then
    Begin
      If fStrToFloat(edtDesFin.Text) < fStrToFloat(edtDesIni.Text) Then
        strMsg := 'Desconto Final deve ser maior ou igual ao Desconto Inicial'

      Else If Not fCheckRange(fStrToFloat(edtDesFin.Text)) Then
        strMsg := 'Desconto Final inválido! Já existe um intervalo contendo o valor especificado.'
    End;

    If Not fEmptyStr(strMsg) Then
    Begin
      fMensagem('ATENÇÃO', strMsg, ['&O k']);
      Result := False;
      pSetFocus(Sender);
    End;
  End;
end;

procedure TfrmCadFaixaDescTabPreco.pAddItem;
  Var
    intAutInc: Integer;
begin
  If Not cdsCadTab.Active Then
  Begin
    cdsCadTab.Open;
    pSetaClient(cdsCadTab);
  End;

  intAutInc := fGetAutInc;

  If blnEditando Then
    cdsCadTab.Edit
  Else
    cdsCadTab.Insert;

  cdsCadTab.FieldByName('AUTINC').AsInteger := intAutInc;
  cdsCadTab.FieldByName('TABPRE').AsInteger := fGetTabPre;
  cdsCadTab.FieldByName('TIPOPE').AsString  := fGetTipOpe;
  cdsCadTab.FieldByName('DESINI').AsFloat   := fStrToFloat(edtDesIni.Text);
  cdsCadTab.FieldByName('DESFIN').AsFloat   := fStrToFloat(edtDesFin.Text);
  cdsCadTab.FieldByName('COMVIS').AsFloat   := fStrToFloat(edtComVis.Text);
  cdsCadTab.FieldByName('COMPRA').AsFloat   := fStrToFloat(edtComPra.Text);

  cdsCadTab.Post;

  cdsCadTab.IndexFieldNames := 'DESINI';
  
  pLimpaCampos;
  pSetFocus(cmbTabPre);
end;

procedure TfrmCadFaixaDescTabPreco.pCarregaFaixasComissoes;
  Var
    qryCadTab: TUniQuery;
Begin
  qryCadTab := FaixaDescTabPrecoDAO.fGetAll;

  Try
    With qryCadTab Do
    Begin
      dspCadTab := TUniDataSetProvider.Create(Nil);
      cdsCadTab := TUniClientDataSet.Create(Nil);
      
      dspCadTab.DataSet := qryCadTab;
      cdsCadTab.SetProvider(dspCadTab);
      cdsCadTab.Open;
      pSetaClient(cdsCadTab);
      pSetaMascaras;
      
      dtsCadTab.DataSet := cdsCadTab;

      First;
      While Not Eof Do
      Begin
        cdsCadTab.Edit;
        cdsCadTab.FieldByName('AUTINC').AsInteger := RecNo;
        cdsCadTab.Post;

        Next;
      End;

      cdsCadTab.AfterPost   := pAfterPost;
      cdsCadTab.AfterDelete := pAfterPost;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadFaixaDescTabPreco.pCarregaFaixasComissoes]');
    End;
  End;

  cmbTabPre.ItemIndex := 0;

  cdsCadTab.Filter   := 'TABPRE = ' + QuotedStr(IntToStr(fGetTabPre)) + ' AND TIPOPE = ' + QuotedStr(fGetTipOpe);
  cdsCadTab.Filtered := True;
  cdsCadTab.First;
  
  FreeAndNil(qryCadTab);
end;

procedure TfrmCadFaixaDescTabPreco.pCarregaTabelaPrecos;
  Var
    intCont: Integer;
begin
  cmbTabPre.Items.Clear;

  For intCont := 1 To Length(Trim(VS_strTabVen)) Do
  Begin
    If (VS_strTabVen[intCont] = 'S') Then
      cmbTabPre.Items.Add('Tabela de Preço ' + IntToStr(intCont));
  End;
end;

procedure TfrmCadFaixaDescTabPreco.pDeleteItem;
begin
  If Not cdsCadTab.IsEmpty Then
    If fMensagem('', 'Deseja apagar registro selecionado?', ['&Sim', '&Não']) = 1 Then
      cdsCadTab.Delete;
end;

procedure TfrmCadFaixaDescTabPreco.pEditItem;
begin
  With cdsCadTab Do
  Begin
    If Not IsEmpty Then
    Begin
      blnEditando := True;
      dbgCadTab.Enabled := False;

      edtDesIni.Text := FormatFloat('#,##0.00', FieldByName('DESINI').AsFloat);
      edtDesFin.Text := FormatFloat('#,##0.00', FieldByName('DESFIN').AsFloat);
      edtComPra.Text := FormatFloat('#,##0.00', FieldByName('COMPRA').AsFloat);
      edtComVis.Text := FormatFloat('#,##0.00', FieldByName('COMVIS').AsFloat);

      pSetFocus(edtDesIni);
    End;
  End;
end;

procedure TfrmCadFaixaDescTabPreco.pLimpaCampos;
begin
  edtDesIni.Text := '0,00';
  edtDesFin.Text := '0,00';
  edtComPra.Text := '0,00';
  edtComVis.Text := '0,00';
  pSetFocus(edtDesIni);
end;

procedure TfrmCadFaixaDescTabPreco.pSetaMascaras;
begin
  With cdsCadTab Do
  Begin
    If FindField('DESINI') <> Nil Then
      TFloatField(FieldByName('DESINI')).DisplayFormat := '#,##0.00';

    If FindField('DESFIN') <> Nil Then
      TFloatField(FieldByName('DESFIN')).DisplayFormat := '#,##0.00';

    If FindField('COMVIS') <> Nil Then
      TFloatField(FieldByName('COMVIS')).DisplayFormat := '#,##0.00';

    If FindField('COMPRA') <> Nil Then
      TFloatField(FieldByName('COMPRA')).DisplayFormat := '#,##0.00';
  End;
end;

end.
